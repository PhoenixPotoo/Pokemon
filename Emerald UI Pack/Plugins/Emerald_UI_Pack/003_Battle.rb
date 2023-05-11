# Battle scene (the visuals of the battle)
class Battle::Scene
  MESSAGE_BASE_COLOR   = Color.new(248, 248, 240)
  MESSAGE_SHADOW_COLOR = Color.new(107, 90, 115)
end

class Battle::Scene
  def pbCreateBackdropSprites
    case @battle.time
    when 1 then time = "eve"
    when 2 then time = "night"
    end
    # Put everything together into backdrop, bases and message bar filenames
    backdropFilename = @battle.backdrop
    baseFilename = @battle.backdrop
    baseFilename = sprintf("%s_%s", baseFilename, @battle.backdropBase) if @battle.backdropBase
    messageFilename = @battle.backdrop
    if time
      trialName = sprintf("%s_%s", backdropFilename, time)
      if pbResolveBitmap(sprintf("Graphics/Battlebacks/" + trialName + "_bg"))
        backdropFilename = trialName
      end
      trialName = sprintf("%s_%s", baseFilename, time)
      if pbResolveBitmap(sprintf("Graphics/Battlebacks/" + trialName + "_base0"))
        baseFilename = trialName
      end
      trialName = sprintf("%s_%s", messageFilename, time)
      if pbResolveBitmap(sprintf("Graphics/Battlebacks/battle_message"))
        messageFilename = trialName
      end
    end
    if !pbResolveBitmap(sprintf("Graphics/Battlebacks/" + baseFilename + "_base0")) &&
       @battle.backdropBase
      baseFilename = @battle.backdropBase
      if time
        trialName = sprintf("%s_%s", baseFilename, time)
        if pbResolveBitmap(sprintf("Graphics/Battlebacks/" + trialName + "_base0"))
          baseFilename = trialName
        end
      end
    end
    # Finalise filenames
    battleBG   = "Graphics/Battlebacks/" + backdropFilename + "_bg"
    playerBase = "Graphics/Battlebacks/" + baseFilename + "_base0"
    enemyBase  = "Graphics/Battlebacks/" + baseFilename + "_base1"
    messageBG  = "Graphics/Battlebacks/battle_message"
    # Apply graphics
    bg = pbAddSprite("battle_bg", 0, 0, battleBG, @viewport)
    bg.z = 0
    bg = pbAddSprite("battle_bg2", -Graphics.width, 0, battleBG, @viewport)
    bg.z      = 0
    bg.mirror = true
    2.times do |side|
      baseX, baseY = Battle::Scene.pbBattlerPosition(side)
      base = pbAddSprite("base_#{side}", baseX, baseY,
                         (side == 0) ? playerBase : enemyBase, @viewport)
      base.z = 1
      if base.bitmap
        base.ox = base.bitmap.width / 2
        base.oy = (side == 0) ? base.bitmap.height : base.bitmap.height / 2
      end
    end
    cmdBarBG = pbAddSprite("cmdBar_bg", 0, Graphics.height - 96, messageBG, @viewport)
    cmdBarBG.z = 180
  end
end

#===============================================================================
# Base class for all three menu classes below
#===============================================================================
class Battle::Scene::MenuBase
  COMMAND_BASE_COLOR = Color.new(74, 74, 74)
  COMMAND_SHADOW_COLOR = Color.new(214, 214, 206)
end

#===============================================================================
# Command menu (Fight/Pokémon/Bag/Run)
#===============================================================================
class Battle::Scene::CommandMenu < Battle::Scene::MenuBase
  def initialize(viewport, z)
    super(viewport)
    self.x = 0
    self.y = Graphics.height - 96
    # Create message box (shows "What will X do?")
    @msgBox = Window_UnformattedTextPokemon.newWithSize(
      "", self.x + 16, self.y + 2, 220, Graphics.height - self.y, viewport
    )
    @msgBox.baseColor   = Color.new(248, 248, 240)
    @msgBox.shadowColor = Color.new(107, 90, 115)
    @msgBox.windowskin  = nil
    addSprite("msgBox", @msgBox)
    if USE_GRAPHICS
      # Create background graphic
      background = IconSprite.new(self.x, self.y, viewport)
      background.setBitmap("Graphics/Pictures/Battle/overlay_command")
      addSprite("background", background)
      # Create bitmaps
      @buttonBitmap = AnimatedBitmap.new(_INTL("Graphics/Pictures/Battle/cursor_command"))
      # Create action buttons
      @buttons = Array.new(4) do |i|   # 4 command options, therefore 4 buttons
        button = Sprite.new(viewport)
        button.bitmap = @buttonBitmap.bitmap
        button.x = self.x + Graphics.width - 260
        button.x += (i.even? ? 0 : (@buttonBitmap.width / 2) - 4)
        button.y = self.y + 6
        button.y += (((i / 2) == 0) ? 0 : BUTTON_HEIGHT - 4)
        button.y -= 10 if i > 1
        button.src_rect.width  = @buttonBitmap.width / 2
        button.src_rect.height = BUTTON_HEIGHT
        addSprite("button_#{i}", button)
        next button
      end
    else
      # Create command window (shows Fight/Bag/Pokémon/Run)
      @cmdWindow = Window_CommandPokemon.newWithSize(
        [], self.x + Graphics.width - 240, self.y, 240, Graphics.height - self.y, viewport
      )
      @cmdWindow.columns       = 2
      @cmdWindow.columnSpacing = 4
      @cmdWindow.ignore_input  = true
      addSprite("cmdWindow", @cmdWindow)
    end
    self.z = z
    refresh
  end
end

#===============================================================================
# Fight menu (choose a move)
#===============================================================================
class Battle::Scene::FightMenu < Battle::Scene::MenuBase
  GET_MOVE_TEXT_COLOR_FROM_MOVE_BUTTON = false
  PP_COLORS = [
    Color.new(248, 72, 72), Color.new(136, 48, 48),    # Red, zero PP
    Color.new(248, 136, 32), Color.new(144, 72, 24),   # Orange, 1/4 of total PP or less
    Color.new(248, 192, 0), Color.new(144, 104, 0),    # Yellow, 1/2 of total PP or less
    COMMAND_BASE_COLOR, COMMAND_SHADOW_COLOR                 # Black, more than 1/2 of total PP
  ]

  def refreshButtonNames
    moves = (@battler) ? @battler.moves : []
    if !USE_GRAPHICS
      # Fill in command window
      commands = []
      [4, moves.length].max.times do |i|
        commands.push((moves[i]) ? moves[i].name : "-")
      end
      @cmdWindow.commands = commands
      return
    end
    # Draw move names onto overlay
    @overlay.bitmap.clear
    textPos = []
    @buttons.each_with_index do |button, i|
      next if !@visibility["button_#{i}"]
      x = button.x - self.x + 82
      y = button.y - self.y + 14
      y -= 4 if i > 1
      moveNameBase = COMMAND_BASE_COLOR
      if GET_MOVE_TEXT_COLOR_FROM_MOVE_BUTTON && moves[i].display_type(@battler)
        # NOTE: This takes a color from a particular pixel in the button
        #       graphic and makes the move name's base color that same color.
        #       The pixel is at coordinates 10,34 in the button box. If you
        #       change the graphic, you may want to change the below line of
        #       code to ensure the font is an appropriate color.
        moveNameBase = button.bitmap.get_pixel(10, button.src_rect.y + 34)
      end
      textPos.push([moves[i].name, x, y, 2, moveNameBase, COMMAND_SHADOW_COLOR])
    end
    pbDrawTextPositions(@overlay.bitmap, textPos)
  end
end

#===============================================================================
# Target menu (choose a move's target)
# NOTE: Unlike the command and fight menus, this one doesn't have a textbox-only
#       version.
#===============================================================================
class Battle::Scene::TargetMenu < Battle::Scene::MenuBase
  TEXT_BASE_COLOR   = Color.new(74, 74, 74)
  TEXT_SHADOW_COLOR = Color.new(214, 214, 206)
end

#===============================================================================
# Data box for regular battles
#===============================================================================
class Battle::Scene::PokemonDataBox < Sprite
  NAME_BASE_COLOR         = Color.new(66, 66, 66)
  NAME_SHADOW_COLOR       = Color.new(222, 214, 181)
  MALE_BASE_COLOR         = Color.new(66, 206, 255)
  FEMALE_BASE_COLOR       = Color.new(255, 156, 148)

  def x=(value)
    super
    @hpBar.x     = value + @spriteBaseX + 102
    @expBar.x    = value + @spriteBaseX + 28
    @hpNumbers.x = value + @spriteBaseX + 80
  end

  def y=(value)
    super
    @hpBar.y     = value + 40
    @expBar.y    = value + 78
    @hpNumbers.y = value + 52
  end
end