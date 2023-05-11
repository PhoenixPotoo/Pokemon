#===============================================================================
# Scene class for handling appearance of the screen
#===============================================================================
class MoveRelearner_Scene
  def pbStartScene(pokemon, moves)
    @pokemon = pokemon
    @moves = moves
    moveCommands = []
    moves.each { |m| moveCommands.push(GameData::Move.get(m).name) }
    # Create sprite hash
    @viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @viewport.z = 99999
    @sprites = {}
    addBackgroundPlane(@sprites, "bg", "reminderbg", @viewport)
    @sprites["pokeicon"] = PokemonIconSprite.new(@pokemon, @viewport)
    @sprites["pokeicon"].setOffset(PictureOrigin::CENTER)
    @sprites["pokeicon"].x = 320
    @sprites["pokeicon"].y = 84
    @sprites["background"] = IconSprite.new(0, 0, @viewport)
    @sprites["background"].setBitmap("Graphics/Pictures/reminderSel")
    @sprites["background"].y = 78
    @sprites["background"].src_rect = Rect.new(0, 72, 258, 72)
    @sprites["overlay"] = BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
    pbSetNarrowFont(@sprites["overlay"].bitmap)
    @sprites["commands"] = Window_CommandPokemon.new(moveCommands, 32)
    @sprites["commands"].height = 32 * (VISIBLEMOVES + 1)
    @sprites["commands"].visible = false
    @sprites["msgwindow"] = Window_AdvancedTextPokemon.new("")
    @sprites["msgwindow"].visible = false
    @sprites["msgwindow"].viewport = @viewport
    @typebitmap = AnimatedBitmap.new(_INTL("Graphics/Pictures/types"))
    pbDrawMoveList
    pbDeactivateWindows(@sprites)
    # Fade in all sprites
    pbFadeInAndShow(@sprites) { pbUpdate }
  end

  def pbDrawMoveList
    overlay = @sprites["overlay"].bitmap
    overlay.clear
    @pokemon.types.each_with_index do |type, i|
      type_number = GameData::Type.get(type).icon_position
      type_rect = Rect.new(0, type_number * 28, 64, 28)
      type_x = (@pokemon.types.length == 1) ? 400 : 366 + (70 * i)
      overlay.blt(type_x, 70, @typebitmap.bitmap, type_rect)
    end
    textpos = [
      [_INTL("Teach which move?"), 4, 4, 0, Color.new(248, 248, 248), Color.new(96, 96, 96)]
    ]
    imagepos = []
    yPos = 88
    VISIBLEMOVES.times do |i|
      moveobject = @moves[@sprites["commands"].top_item + i]
      if moveobject
        moveData = GameData::Move.get(moveobject)
        type_number = GameData::Type.get(moveData.display_type(@pokemon)).icon_position
        imagepos.push(["Graphics/Pictures/types", 12, yPos - 2, 0, type_number * 28, 64, 28])
        textpos.push([moveData.name, 80, yPos, 0, Color.new(72, 72, 72), Color.new(184, 184, 184)])
        textpos.push([_INTL("PP"), 112, yPos + 32, 0, Color.new(72, 72, 72), Color.new(184, 184, 184)])
        if moveData.total_pp > 0
          textpos.push([_INTL("{1}/{1}", moveData.total_pp), 230, yPos + 32, 1,
                        Color.new(72, 72, 72), Color.new(184, 184, 184)])
        else
          textpos.push(["--", 230, yPos + 32, 1, Color.new(72, 72, 72), Color.new(184, 184, 184)])
        end
      end
      yPos += 64
    end
    imagepos.push(["Graphics/Pictures/reminderSel",
                   0, 78 + ((@sprites["commands"].index - @sprites["commands"].top_item) * 64),
                   0, 0, 258, 72])
    selMoveData = GameData::Move.get(@moves[@sprites["commands"].index])
    basedamage = selMoveData.display_damage(@pokemon)
    category = selMoveData.display_category(@pokemon)
    accuracy = selMoveData.display_accuracy(@pokemon)
    textpos.push([_INTL("CATEGORY"), 272, 120, 0, Color.new(248, 248, 248), Color.new(96, 96, 96)])
    textpos.push([_INTL("POWER"), 272, 152, 0, Color.new(248, 248, 248), Color.new(96, 96, 96)])
    textpos.push([basedamage <= 1 ? basedamage == 1 ? "???" : "---" : sprintf("%d", basedamage),
                  468, 152, 2, Color.new(72, 72, 72), Color.new(184, 184, 184)])
    textpos.push([_INTL("ACCURACY"), 272, 184, 0, Color.new(248, 248, 248), Color.new(96, 96, 96)])
    textpos.push([accuracy == 0 ? "---" : "#{accuracy}%",
                  468, 184, 2, Color.new(72, 72, 72), Color.new(184, 184, 184)])
    pbDrawTextPositions(overlay, textpos)
    imagepos.push(["Graphics/Pictures/category", 436, 116, 0, category * 22, 66, 22])
    if @sprites["commands"].index < @moves.length - 1
      imagepos.push(["Graphics/Pictures/reminderButtons", 48, 350, 0, 0, 76, 32])
    end
    if @sprites["commands"].index > 0
      imagepos.push(["Graphics/Pictures/reminderButtons", 134, 350, 76, 0, 76, 32])
    end
    pbDrawImagePositions(overlay, imagepos)
    drawTextEx(overlay, 272, 218, 230, 5, selMoveData.description,
               Color.new(72, 72, 72), Color.new(184, 184, 184))
  end
end