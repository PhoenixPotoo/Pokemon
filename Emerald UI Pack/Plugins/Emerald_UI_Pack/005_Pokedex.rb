#===============================================================================
#
#===============================================================================
class Window_Pokedex < Window_DrawableCommand
  def initialize(x, y, width, height, viewport)
    @commands = []
    super(x, y, width, height, viewport)
    @selarrow     = AnimatedBitmap.new("Graphics/Pictures/Pokedex/cursor_list")
    @pokeballOwn  = AnimatedBitmap.new("Graphics/Pictures/Pokedex/icon_own")
    @pokeballSeen = AnimatedBitmap.new("Graphics/Pictures/Pokedex/icon_seen")
    self.baseColor   = Color.new(0, 0, 0)
    self.shadowColor = Color.new(189, 189, 189)
    pbSetNarrowFont(self.contents)
    self.windowskin  = nil
  end

  def drawItem(index, _count, rect)
    return if index >= self.top_row + self.page_item_max
    rect = Rect.new(rect.x + 16, rect.y, rect.width - 16, rect.height)
    species     = @commands[index][0]
    indexNumber = @commands[index][4]
    indexNumber -= 1 if @commands[index][5]
    if $player.seen?(species)
      if $player.owned?(species)
        pbCopyBitmap(self.contents, @pokeballOwn.bitmap, rect.x + 18, rect.y + 10)
      else
        pbCopyBitmap(self.contents, @pokeballSeen.bitmap, rect.x + 18, rect.y + 10)
      end
      text = sprintf("%03d%s %s", indexNumber, " ", @commands[index][1])
    else
      text = sprintf("%03d  ----------", indexNumber)
    end
    pbDrawShadowText(self.contents, rect.x + 36, rect.y + 6, rect.width, rect.height,
                     text, self.baseColor, self.shadowColor)
  end
end

#===============================================================================
# Pokédex main screen
#===============================================================================
class PokemonPokedex_Scene
  def pbStartScene
    @sliderbitmap       = AnimatedBitmap.new("Graphics/Pictures/Pokedex/icon_slider")
    @typebitmap         = AnimatedBitmap.new(_INTL("Graphics/Pictures/Pokedex/icon_types"))
    @shapebitmap        = AnimatedBitmap.new("Graphics/Pictures/Pokedex/icon_shapes")
    @hwbitmap           = AnimatedBitmap.new("Graphics/Pictures/Pokedex/icon_hw")
    @selbitmap          = AnimatedBitmap.new("Graphics/Pictures/Pokedex/icon_searchsel")
    @searchsliderbitmap = AnimatedBitmap.new(_INTL("Graphics/Pictures/Pokedex/icon_searchslider"))
    @sprites = {}
    @viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @viewport_pokeball = Viewport.new(0, 0, 92, Graphics.height)
    @viewport.z = 99999
    @viewport_pokeball.z = 99999
    addBackgroundPlane(@sprites, "background", "Pokedex/bg_list", @viewport)
=begin
    # Suggestion for changing the background depending on region. You can change
    # the line above with the following:
    if pbGetPokedexRegion==-1   # Using national Pokédex
      addBackgroundPlane(@sprites,"background","Pokedex/bg_national",@viewport)
    elsif pbGetPokedexRegion==0   # Using first regional Pokédex
      addBackgroundPlane(@sprites,"background","Pokedex/bg_regional",@viewport)
    end
=end
    addBackgroundPlane(@sprites, "searchbg", "Pokedex/bg_search", @viewport)
    @sprites["searchbg"].visible = false
    5.times do |i|
      @sprites["icon#{i}"] = PokemonSprite.new(@viewport)
      @sprites["icon#{i}"].setOffset(PictureOrigin::CENTER)
      @sprites["icon#{i}"].x = 192
      @sprites["icon#{i}"].y = 184 + 96*(i-2)
      @sprites["icon#{i}"].zoom_y = (i > 2 ? i*0.5%1 : i*0.5)
    end
    @direction = 0
    @sprites["bg_overlay"] = IconSprite.new(0, 0, @viewport)
    @sprites["bg_overlay"].setBitmap("Graphics/Pictures/Pokedex/bg_list_over")
    @sprites["pokeball"] = IconSprite.new(0, 176, @viewport_pokeball)
    @sprites["pokeball"].setBitmap("Graphics/Pictures/Pokedex/pokeball")
    @sprites["pokeball"].ox = 109
    @sprites["pokeball"].oy = 109
    @sprites["pokeball"].angle = 0.0
    @sprites["pokeball"].src_rect = Rect.new(0,0,218,218)
    @sprites["seenown"] = IconSprite.new(4, 76, @viewport_pokeball)
    @sprites["seenown"].setBitmap("Graphics/Pictures/Pokedex/seenown")
    @sprites["pokedex"] = Window_Pokedex.new(264, 16, 276, 364, @viewport)
    @sprites["overlay"] = BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
    pbSetNarrowFont(@sprites["overlay"].bitmap)
    @sprites["overlay_pokeball"] = BitmapSprite.new(Graphics.width, Graphics.height, @viewport_pokeball)
    pbSetNarrowFont(@sprites["overlay_pokeball"].bitmap)
    @sprites["searchcursor"] = PokedexSearchSelectionSprite.new(@viewport)
    @sprites["searchcursor"].visible = false
    @searchResults = false
    @searchParams  = [$PokemonGlobal.pokedexMode, -1, -1, -1, -1, -1, -1, -1, -1, -1]
    pbRefreshDexList($PokemonGlobal.pokedexIndex[pbGetSavePositionIndex])
    pbDeactivateWindows(@sprites)
    pbFadeInAndShow(@sprites)
  end

  def pbEndScene
    pbFadeOutAndHide(@sprites)
    pbDisposeSpriteHash(@sprites)
    @sliderbitmap.dispose
    @typebitmap.dispose
    @shapebitmap.dispose
    @hwbitmap.dispose
    @selbitmap.dispose
    @searchsliderbitmap.dispose
    @viewport.dispose
    @viewport_pokeball.dispose
  end

  def lerp(a, b, t)
    return (1 - t) * a + t * b
  end
  
  def pbMoveIcons(index=nil)
    return if index.nil?
    frames = 5
    frames.times do |anim|
      5.times do |i|
        new_i = (i == 5 ? i-@direction : i+@direction)
        new_zoom = (new_i > 2 ? new_i*0.5%1 : new_i*0.5)
        new_y = 184 + 96*(i-2+@direction)*1.3
        @sprites["icon#{i}"].zoom_y = lerp(@sprites["icon#{i}"].zoom_y, new_zoom, (anim+1)/frames.to_f)
        @sprites["icon#{i}"].y = lerp(@sprites["icon#{i}"].y, new_y, (anim+1)/frames.to_f)
      end
      @sprites["pokeball"].angle = lerp(@sprites["pokeball"].angle, 22.5*@direction, (anim+1)/frames.to_f)
      Graphics.update unless @direction == 0
    end
    @sprites["pokeball"].angle = 0
    @sprites["pokeball"].src_rect = Rect.new(218*(index%8),0,218,218)
    5.times do |i|
      @sprites["icon#{i}"].y = 184 + 96*(i-2)*1.3
      @sprites["icon#{i}"].zoom_y = (i > 2 ? i*0.5%1 : i*0.5)
      if @dexlist[i-2 + index] == nil || i-2+index < 0
        ispeciescon = nil
        @sprites["icon#{i}"].opacity = 0
      else
        iconspecies = @dexlist[i-2 + index][0]
        @sprites["icon#{i}"].opacity = 255
      end
      iconspecies = nil if !$player.seen?(iconspecies)
      setIconBitmap(iconspecies,i)
    end
  end

  def pbRefresh
    overlay = @sprites["overlay"].bitmap
    overlay_pokeball = @sprites["overlay_pokeball"].bitmap
    overlay.clear
    overlay_pokeball.clear
    base   = Color.new(255, 255, 255)
    shadow = Color.new(0, 0, 0)
    @sprites["seenown"].visible = !@searchResults
    # Write various bits of text
    textpos = []
    if @searchResults
      textpos.push([_INTL("Search results: #{@dexlist.length.to_s}"), 122, 324, 2, base, shadow])
      # Draw all text
      pbDrawTextPositions(overlay, textpos)
    else
      textpos.push([$player.pokedex.seen_count(pbGetPokedexRegion).to_s, 40, 110, 2, base, shadow])
      textpos.push([$player.pokedex.owned_count(pbGetPokedexRegion).to_s, 40, 234, 2, base, shadow])
      # Draw all text
      pbDrawTextPositions(overlay_pokeball, textpos)
    end
    # Draw slider box
    itemlist = @sprites["pokedex"]
    sliderheight = 322
    y = 16
    y += ((itemlist.index+1) / itemlist.itemCount.to_f * sliderheight).round
    overlay.blt(488, y, @sliderbitmap.bitmap, Rect.new(0, 0, 12, 16))
    # Move icons
    pbMoveIcons(itemlist.index)
  end

  def setIconBitmap(species,idx)
    gender, form, shiny = $player.pokedex.last_form_seen(species)
    shiny = false
    @sprites["icon#{idx}"].setSpeciesBitmap(species, gender, form, shiny)
  end

  def pbDexSearch
    oldsprites = pbFadeOutAndHide(@sprites)
    params = @searchParams.clone
    @orderCommands = []
    @orderCommands[MODENUMERICAL] = _INTL("Numerical")
    @orderCommands[MODEATOZ]      = _INTL("A to Z")
    @orderCommands[MODEHEAVIEST]  = _INTL("Heaviest")
    @orderCommands[MODELIGHTEST]  = _INTL("Lightest")
    @orderCommands[MODETALLEST]   = _INTL("Tallest")
    @orderCommands[MODESMALLEST]  = _INTL("Smallest")
    @nameCommands = [_INTL("A"), _INTL("B"), _INTL("C"), _INTL("D"), _INTL("E"),
                     _INTL("F"), _INTL("G"), _INTL("H"), _INTL("I"), _INTL("J"),
                     _INTL("K"), _INTL("L"), _INTL("M"), _INTL("N"), _INTL("O"),
                     _INTL("P"), _INTL("Q"), _INTL("R"), _INTL("S"), _INTL("T"),
                     _INTL("U"), _INTL("V"), _INTL("W"), _INTL("X"), _INTL("Y"),
                     _INTL("Z")]
    @typeCommands = []
    GameData::Type.each { |t| @typeCommands.push(t) if !t.pseudo_type }
    @heightCommands = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
                       11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
                       21, 22, 23, 24, 25, 30, 35, 40, 45, 50,
                       55, 60, 65, 70, 80, 90, 100]
    @weightCommands = [5, 10, 15, 20, 25, 30, 35, 40, 45, 50,
                       55, 60, 70, 80, 90, 100, 110, 120, 140, 160,
                       180, 200, 250, 300, 350, 400, 500, 600, 700, 800,
                       900, 1000, 1250, 1500, 2000, 3000, 5000]
    @colorCommands = []
    GameData::BodyColor.each { |c| @colorCommands.push(c) if c.id != :None }
    @shapeCommands = []
    GameData::BodyShape.each { |s| @shapeCommands.push(s) if s.id != :None }
    @sprites["searchbg"].visible     = true
    @sprites["overlay"].visible      = true
    @sprites["searchcursor"].visible = true
    index = 0
    oldindex = index
    @sprites["searchcursor"].mode    = -1
    @sprites["searchcursor"].index   = index
    pbRefreshDexSearch(params, index)
    pbFadeInAndShow(@sprites)
    loop do
      Graphics.update
      Input.update
      pbUpdate
      if index != oldindex
        @sprites["searchcursor"].index = index
        oldindex = index
      end
      if Input.trigger?(Input::UP)
        if index >= 7
          index = 4
        elsif index == 5
          index = 0
        elsif index > 0
          index -= 1
        end
        pbPlayCursorSE if index != oldindex
      elsif Input.trigger?(Input::DOWN)
        if [4, 6].include?(index)
          index = 8
        elsif index < 7
          index += 1
        end
        pbPlayCursorSE if index != oldindex
      elsif Input.trigger?(Input::LEFT)
        if index == 5
          index = 1
        elsif index == 6
          index = 3
        elsif index > 7
          index -= 1
        end
        pbPlayCursorSE if index != oldindex
      elsif Input.trigger?(Input::RIGHT)
        if index == 1
          index = 5
        elsif index >= 2 && index <= 4
          index = 6
        elsif [7, 8].include?(index)
          index += 1
        end
        pbPlayCursorSE if index != oldindex
      elsif Input.trigger?(Input::ACTION)
        index = 8
        pbPlayCursorSE if index != oldindex
      elsif Input.trigger?(Input::BACK)
        pbPlayCloseMenuSE
        break
      elsif Input.trigger?(Input::USE)
        pbPlayDecisionSE if index != 9
        case index
        when 0   # Choose sort order
          newparam = pbDexSearchCommands(0, [params[0]], index)
          params[0] = newparam[0] if newparam
          pbRefreshDexSearch(params, index)
        when 1   # Filter by name
          newparam = pbDexSearchCommands(1, [params[1]], index)
          params[1] = newparam[0] if newparam
          pbRefreshDexSearch(params, index)
        when 2   # Filter by type
          newparam = pbDexSearchCommands(2, [params[2], params[3]], index)
          if newparam
            params[2] = newparam[0]
            params[3] = newparam[1]
          end
          pbRefreshDexSearch(params, index)
        when 3   # Filter by height range
          newparam = pbDexSearchCommands(3, [params[4], params[5]], index)
          if newparam
            params[4] = newparam[0]
            params[5] = newparam[1]
          end
          pbRefreshDexSearch(params, index)
        when 4   # Filter by weight range
          newparam = pbDexSearchCommands(4, [params[6], params[7]], index)
          if newparam
            params[6] = newparam[0]
            params[7] = newparam[1]
          end
          pbRefreshDexSearch(params, index)
        when 5   # Filter by color filter
          newparam = pbDexSearchCommands(5, [params[8]], index)
          params[8] = newparam[0] if newparam
          pbRefreshDexSearch(params, index)
        when 6   # Filter by shape
          newparam = pbDexSearchCommands(6, [params[9]], index)
          params[9] = newparam[0] if newparam
          pbRefreshDexSearch(params, index)
        when 7   # Clear filters
          10.times do |i|
            params[i] = (i == 0) ? MODENUMERICAL : -1
          end
          pbRefreshDexSearch(params, index)
        when 8   # Start search (filter)
          dexlist = pbSearchDexList(params)
          if dexlist.length == 0
            pbMessage(_INTL("No matching Pokémon were found."))
          else
            @dexlist = dexlist
            @sprites["pokedex"].commands = @dexlist
            @sprites["pokedex"].index    = 0
            @sprites["pokedex"].refresh
            @searchResults = true
            @searchParams = params
            break
          end
        when 9   # Cancel
          pbPlayCloseMenuSE
          break
        end
      end
    end
    pbFadeOutAndHide(@sprites)
    if @searchResults
      @sprites["background"].setBitmap("Graphics/Pictures/Pokedex/bg_list_search")
      @sprites["bg_overlay"].setBitmap("Graphics/Pictures/Pokedex/bg_list_over_search")
    else
      @sprites["background"].setBitmap("Graphics/Pictures/Pokedex/bg_list")
      @sprites["bg_overlay"].setBitmap("Graphics/Pictures/Pokedex/bg_list_over")
    end
    pbRefresh
    pbFadeInAndShow(@sprites, oldsprites)
    Input.update
    return 0
  end

  def pbPokedex
    pbActivateWindow(@sprites, "pokedex") {
      loop do
        Graphics.update
        Input.update
        oldindex = @sprites["pokedex"].index
        pbUpdate
        if oldindex != @sprites["pokedex"].index
          @direction = (@sprites["pokedex"].index > oldindex ? -1 : 1)
          @direction = 0 if (@sprites["pokedex"].index - oldindex).abs > 1
          $PokemonGlobal.pokedexIndex[pbGetSavePositionIndex] = @sprites["pokedex"].index if !@searchResults
          pbRefresh
        end
        if Input.trigger?(Input::ACTION)
          pbPlayDecisionSE
          @sprites["pokedex"].active = false
          pbDexSearch
          @sprites["pokedex"].active = true
        elsif Input.trigger?(Input::BACK)
          if @searchResults
            pbPlayCancelSE
            pbCloseSearch
          else
            pbPlayCloseMenuSE
            break
          end
        elsif Input.trigger?(Input::USE)
          if $player.seen?(@sprites["pokedex"].species)
            pbPlayDecisionSE
            pbDexEntry(@sprites["pokedex"].index)
          end
        end
      end
    }
  end
end