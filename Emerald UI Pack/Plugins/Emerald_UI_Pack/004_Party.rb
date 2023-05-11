#===============================================================================
# Pokémon party buttons and menu
#===============================================================================
class PokemonPartyConfirmCancelSprite < Sprite
  def initialize(text, x, y, narrowbox = false, viewport = nil)
    super(viewport)
    @refreshBitmap = true
    @bgsprite = ChangelingSprite.new(0, 0, viewport)
    @bgsprite.addBitmap("desel", "Graphics/Pictures/Party/icon_cancel")
    @bgsprite.addBitmap("sel", "Graphics/Pictures/Party/icon_cancel_sel")
    @bgsprite.changeBitmap("desel")
    @overlaysprite = BitmapSprite.new(@bgsprite.bitmap.width, @bgsprite.bitmap.height, viewport)
    @overlaysprite.z = self.z + 1
    pbSetSmallFont(@overlaysprite.bitmap)
    textpos = [[text, 56, (narrowbox) ? 8 : 14, 2, Color.new(248, 248, 248), Color.new(40, 40, 40)]]
    pbDrawTextPositions(@overlaysprite.bitmap, textpos)
    self.x = x
    self.y = y
  end
end

#===============================================================================
# Pokémon party panel
#===============================================================================
class PokemonPartyPanel < Sprite
  TEXT_SHADOW_COLOR  = Color.new(112, 112, 112)

  def initialize(pokemon, index, viewport = nil)
    super(viewport)
    @pokemon = pokemon
    @active = (index == 0)
    @refreshing = true
    if @active
      self.x = 18
      self.y = 62 + 60 * index
    else
      self.x = 222
      self.y = -30 + 60 * index
    end
    @panelbgsprite = ChangelingSprite.new(0, 0, viewport)
    @panelbgsprite.z = self.z
    if @active   # Rounded panel
      @panelbgsprite.addBitmap("able", "Graphics/Pictures/Party/panel_round")
      @panelbgsprite.addBitmap("ablesel", "Graphics/Pictures/Party/panel_round_sel")
      @panelbgsprite.addBitmap("fainted", "Graphics/Pictures/Party/panel_round_faint")
      @panelbgsprite.addBitmap("faintedsel", "Graphics/Pictures/Party/panel_round_faint_sel")
      @panelbgsprite.addBitmap("swap", "Graphics/Pictures/Party/panel_round_swap")
      @panelbgsprite.addBitmap("swapsel", "Graphics/Pictures/Party/panel_round_swap_sel")
      @panelbgsprite.addBitmap("swapsel2", "Graphics/Pictures/Party/panel_round_swap_sel2")
    else   # Rectangular panel
      @panelbgsprite.addBitmap("able", "Graphics/Pictures/Party/panel_rect")
      @panelbgsprite.addBitmap("ablesel", "Graphics/Pictures/Party/panel_rect_sel")
      @panelbgsprite.addBitmap("fainted", "Graphics/Pictures/Party/panel_rect_faint")
      @panelbgsprite.addBitmap("faintedsel", "Graphics/Pictures/Party/panel_rect_faint_sel")
      @panelbgsprite.addBitmap("swap", "Graphics/Pictures/Party/panel_rect_swap")
      @panelbgsprite.addBitmap("swapsel", "Graphics/Pictures/Party/panel_rect_swap_sel")
      @panelbgsprite.addBitmap("swapsel2", "Graphics/Pictures/Party/panel_rect_swap_sel2")
    end
    @hpbgsprite = ChangelingSprite.new(0, 0, viewport)
    @hpbgsprite.z = self.z + 1
    @hpbgsprite.addBitmap("able", "Graphics/Pictures/Party/overlay_hp_back")
    @hpbgsprite.addBitmap("fainted", "Graphics/Pictures/Party/overlay_hp_back_faint")
    @hpbgsprite.addBitmap("swap", "Graphics/Pictures/Party/overlay_hp_back_swap")
    @ballsprite = ChangelingSprite.new(0, 0, viewport)
    @ballsprite.z = self.z + 1
    @ballsprite.addBitmap("desel", "Graphics/Pictures/Party/icon_ball")
    @ballsprite.addBitmap("sel", "Graphics/Pictures/Party/icon_ball_sel")
    @pkmnsprite = PokemonIconSprite.new(pokemon, viewport)
    @pkmnsprite.setOffset(PictureOrigin::CENTER)
    @pkmnsprite.active = @active
    @pkmnsprite.z      = self.z + 2
    @helditemsprite = HeldItemIconSprite.new(0, 0, @pokemon, viewport)
    @helditemsprite.z = self.z + 3
    @overlaysprite = BitmapSprite.new(Graphics.width, Graphics.height, viewport)
    @overlaysprite.z = self.z + 4
    pbSetSmallFont(@overlaysprite.bitmap)
    @hpbar    = AnimatedBitmap.new("Graphics/Pictures/Party/overlay_hp")
    @maleicon = AnimatedBitmap.new("Graphics/Pictures/Party/overlay_male")
    @femaleicon = AnimatedBitmap.new("Graphics/Pictures/Party/overlay_female")
    @statuses = AnimatedBitmap.new(_INTL("Graphics/Pictures/statuses"))
    @selected      = false
    @preselected   = false
    @switching     = false
    @text          = nil
    @refreshBitmap = true
    @refreshing    = false
    refresh
  end

  def dispose
    @panelbgsprite.dispose
    @hpbgsprite.dispose
    @ballsprite.dispose
    @pkmnsprite.dispose
    @helditemsprite.dispose
    @overlaysprite.bitmap.dispose
    @overlaysprite.dispose
    @hpbar.dispose
    @maleicon.dispose
    @femaleicon.dispose
    @statuses.dispose
    super
  end

  def refresh_hp_bar_graphic
    return if !@hpbgsprite || @hpbgsprite.disposed?
    @hpbgsprite.visible = (!@pokemon.egg? && !(@text && @text.length > 0))
    return if !@hpbgsprite.visible
    if self.preselected || (self.selected && @switching)
      @hpbgsprite.changeBitmap("swap")
    elsif @pokemon.fainted?
      @hpbgsprite.changeBitmap("fainted")
    else
      @hpbgsprite.changeBitmap("able")
    end
    xoff = (@active) ? -78 : 50
    yoff = (@active) ? 12 : -36
    @hpbgsprite.x     = self.x + 96 + xoff
    @hpbgsprite.y     = self.y + 50 + yoff
    @hpbgsprite.color = self.color
  end

  def refresh_ball_graphic
    return if !@ballsprite || @ballsprite.disposed?
    xoffset = (@active) ? 4 : 0
    yoffset = (@active) ? -8 : 0
    @ballsprite.changeBitmap((self.selected) ? "sel" : "desel")
    @ballsprite.x     = self.x - 20 + xoffset
    @ballsprite.y     = self.y - 4 + yoffset
    @ballsprite.color = self.color
  end

  def refresh_pokemon_icon
    return if !@pkmnsprite || @pkmnsprite.disposed?
    xoffset = (@active) ? 12 : 0
    yoffset = (@active) ? 12 : 0
    @pkmnsprite.x        = self.x + 8 + xoffset
    @pkmnsprite.y        = self.y + 26 + yoffset
    @pkmnsprite.color    = self.color
    @pkmnsprite.selected = self.selected
  end

  def refresh_held_item_icon
    return if !@helditemsprite || @helditemsprite.disposed? || !@helditemsprite.visible
    yoffset = (@active) ? -4 : -18
    @helditemsprite.x     = self.x + 20
    @helditemsprite.y     = self.y + 48 + yoffset
    @helditemsprite.color = self.color
  end

  def draw_name
    yoffset = (@active) ? 14 : 0
    pbDrawTextPositions(@overlaysprite.bitmap,
                        [[@pokemon.name, 46, 12+yoffset, 0, TEXT_BASE_COLOR, TEXT_SHADOW_COLOR]])
  end

  def draw_level
    return if @pokemon.egg?
    yoffset = (@active) ? 14 : 0
    # "Lv" graphic
    pbDrawImagePositions(@overlaysprite.bitmap,
                         [["Graphics/Pictures/Party/overlay_lv", 60, 30+yoffset, 0, 0, 22, 16]])
    # Level number
    pbSetSmallFont(@overlaysprite.bitmap)
    pbDrawTextPositions(@overlaysprite.bitmap,
                        [[@pokemon.level.to_s, 82, 30+yoffset, 0, TEXT_BASE_COLOR, TEXT_SHADOW_COLOR]])
    pbSetSmallFont(@overlaysprite.bitmap)
  end

  def draw_gender
    return if @pokemon.egg? || @pokemon.genderless?
    gender_bitmap = (@pokemon.male?) ? @maleicon.bitmap : @femaleicon.bitmap
    xpos = (@active) ? 124 : 122
    ypos = (@active) ? 44 : 30
    @overlaysprite.bitmap.blt(xpos, ypos, gender_bitmap, Rect.new(0, 0, 16, 16))
  end

  def draw_hp
    return if @pokemon.egg? || (@text && @text.length > 0)
    xpos_offset = @active ? -128 : 0
    ypos_offset = @active ? 48 : 0
    # HP numbers
    hp_text = sprintf("% 3d /% 3d", @pokemon.hp, @pokemon.totalhp)
    pbDrawTextPositions(@overlaysprite.bitmap,
                        [[hp_text, 274 + xpos_offset, 30 + ypos_offset, 1, TEXT_BASE_COLOR, TEXT_SHADOW_COLOR]])
    # HP bar
    if @pokemon.able?
      w = @pokemon.hp * HP_BAR_WIDTH / @pokemon.totalhp.to_f
      w = 1 if w < 1
      w = ((w / 2).round) * 2   # Round to the nearest 2 pixels
      hpzone = 0
      hpzone = 1 if @pokemon.hp <= (@pokemon.totalhp / 2).floor
      hpzone = 2 if @pokemon.hp <= (@pokemon.totalhp / 4).floor
      hprect = Rect.new(0, hpzone * 8, w, 8)
      @overlaysprite.bitmap.blt(178 + xpos_offset, 16 + ypos_offset, @hpbar.bitmap, hprect)
    end
  end

  def draw_status
    return if @pokemon.egg? || (@text && @text.length > 0)
    status = -1
    if @pokemon.fainted?
      status = GameData::Status.count - 1
    elsif @pokemon.status != :NONE
      status = GameData::Status.get(@pokemon.status).icon_position
    elsif @pokemon.pokerusStage == 1
      status = GameData::Status.count
    end
    return if status < 0
    statusrect = Rect.new(0, STATUS_ICON_HEIGHT * status, STATUS_ICON_WIDTH, STATUS_ICON_HEIGHT)
    xpos_offset = @active ? -36 : 2
    ypos_offset = @active ? -10 : 2
    @overlaysprite.bitmap.blt(144+xpos_offset, 26+ypos_offset, @statuses.bitmap, statusrect)
  end

  def draw_shiny_icon
    return if @pokemon.egg? || !@pokemon.shiny?
    yoffset = (@active) ? -4 : -18
    pbDrawImagePositions(@overlaysprite.bitmap,
                         [["Graphics/Pictures/shiny", 38, 48+yoffset, 0, 0, 16, 16]])
  end

  def draw_annotation
    return if !@text || @text.length == 0
    xpos = @active ? 56 : 144
    ypos = @active ? 68 : 24
    pbDrawTextPositions(@overlaysprite.bitmap, [[@text, xpos, ypos, 0, TEXT_BASE_COLOR, TEXT_SHADOW_COLOR]])
  end
end

#===============================================================================
# Pokémon party visuals
#===============================================================================
class PokemonParty_Scene
  def pbStartScene(party, starthelptext, annotations = nil, multiselect = false, can_access_storage = false)
    @sprites = {}
    @party = party
    @viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @viewport.z = 99999
    @multiselect = multiselect
    @can_access_storage = can_access_storage
    addBackgroundPlane(@sprites, "partybg", "Party/bg", @viewport)
    @sprites["messagebox"] = Window_AdvancedTextPokemon.new("")
    @sprites["messagebox"].z              = 50
    @sprites["messagebox"].viewport       = @viewport
    @sprites["messagebox"].visible        = false
    @sprites["messagebox"].letterbyletter = true
    pbBottomLeftLines(@sprites["messagebox"], 2)
    @sprites["storagetext"] = Window_UnformattedTextPokemon.new(
      @can_access_storage ? _INTL("[Special]: To Boxes") : ""
    )
    @sprites["storagetext"].x           = 12
    @sprites["storagetext"].y           = Graphics.height - @sprites["messagebox"].height - 16
    @sprites["storagetext"].z           = 10
    @sprites["storagetext"].viewport    = @viewport
    @sprites["storagetext"].baseColor   = Color.new(248, 248, 248)
    @sprites["storagetext"].shadowColor = Color.new(0, 0, 0)
    @sprites["storagetext"].windowskin  = nil
    @sprites["helpwindow"] = Window_UnformattedTextPokemon.new(starthelptext)
    @sprites["helpwindow"].viewport = @viewport
    @sprites["helpwindow"].visible  = true
    pbBottomLeftLines(@sprites["helpwindow"], 1)
    pbSetHelpText(starthelptext)
    # Add party Pokémon sprites
    Settings::MAX_PARTY_SIZE.times do |i|
      if @party[i]
        @sprites["pokemon#{i}"] = PokemonPartyPanel.new(@party[i], i, @viewport)
      else
        @sprites["pokemon#{i}"] = PokemonPartyBlankPanel.new(@party[i], i, @viewport)
      end
      @sprites["pokemon#{i}"].text = annotations[i] if annotations
    end
    if @multiselect
      @sprites["pokemon#{Settings::MAX_PARTY_SIZE}"] = PokemonPartyConfirmSprite.new(@viewport)
      @sprites["pokemon#{Settings::MAX_PARTY_SIZE + 1}"] = PokemonPartyCancelSprite2.new(@viewport)
    else
      @sprites["pokemon#{Settings::MAX_PARTY_SIZE}"] = PokemonPartyCancelSprite.new(@viewport)
    end
    # Select first Pokémon
    @activecmd = 0
    @sprites["pokemon0"].selected = true
    pbFadeInAndShow(@sprites) { update }
  end

  def pbSwitchBegin(oldid, newid)
    pbSEPlay("GUI party switch")
    oldsprite = @sprites["pokemon#{oldid}"]
    newsprite = @sprites["pokemon#{newid}"]
    timeTaken = Graphics.frame_rate * 4 / 10
    distancePerFrame = (Graphics.width / (2.0 * timeTaken)).ceil
    timeTaken.times do
      oldsprite.x += oldid == 0 ? -distancePerFrame : distancePerFrame
      newsprite.x += newid == 0 ? -distancePerFrame : distancePerFrame
      Graphics.update
      Input.update
      self.update
    end
  end

  def pbSwitchEnd(oldid, newid)
    pbSEPlay("GUI party switch")
    oldsprite = @sprites["pokemon#{oldid}"]
    newsprite = @sprites["pokemon#{newid}"]
    oldsprite.pokemon = @party[oldid]
    newsprite.pokemon = @party[newid]
    timeTaken = Graphics.frame_rate * 4 / 10
    distancePerFrame = (Graphics.width / (2.0 * timeTaken)).ceil
    timeTaken.times do
      oldsprite.x -= oldid == 0 ? -distancePerFrame : distancePerFrame
      newsprite.x -= newid == 0 ? -distancePerFrame : distancePerFrame
      Graphics.update
      Input.update
      self.update
    end
    Settings::MAX_PARTY_SIZE.times do |i|
      @sprites["pokemon#{i}"].preselected = false
      @sprites["pokemon#{i}"].switching   = false
    end
    pbRefresh
  end

  def pbChangeSelection(key, currentsel)
    numsprites = Settings::MAX_PARTY_SIZE + ((@multiselect) ? 2 : 1)
    case key
    when Input::LEFT
      currentsel = 0 if currentsel > 0
    when Input::RIGHT
      currentsel = 1 if currentsel < 1 && @party.length > 1
    when Input::UP
      if currentsel >= Settings::MAX_PARTY_SIZE
        currentsel -= 1
        while currentsel > 0 && currentsel < Settings::MAX_PARTY_SIZE && !@party[currentsel]
          currentsel -= 1
        end
      else
        loop do
          currentsel -= 1
          break unless currentsel > 0 && !@party[currentsel]
        end
      end
      if currentsel >= @party.length && currentsel < Settings::MAX_PARTY_SIZE
        currentsel = @party.length - 1
      end
      currentsel = 0 if currentsel < 0
    when Input::DOWN
      if currentsel >= Settings::MAX_PARTY_SIZE - 1
        currentsel += 1
      else
        currentsel += 1
        currentsel = Settings::MAX_PARTY_SIZE if currentsel < Settings::MAX_PARTY_SIZE && !@party[currentsel]
      end
      if currentsel >= @party.length && currentsel < Settings::MAX_PARTY_SIZE
        currentsel = Settings::MAX_PARTY_SIZE
      elsif currentsel >= numsprites
        currentsel = 0
      end
    end
    return currentsel
  end
end