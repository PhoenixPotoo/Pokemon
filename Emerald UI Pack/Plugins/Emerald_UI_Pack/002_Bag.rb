#===============================================================================
#
#===============================================================================
class Window_PokemonBag < Window_DrawableCommand
  def drawCursor(index, rect)
    if self.index == index
      bmp = (@sorting) ? @swaparrow.bitmap : @selarrow.bitmap
      pbCopyBitmap(self.contents, bmp, rect.x, rect.y + 28)
    end
  end

  def drawItem(index, _count, rect)
    textpos = []
    rect = Rect.new(rect.x + 16, rect.y + 16, rect.width - 16, rect.height)
    thispocket = @bag.pockets[@pocket]
    if index == self.itemCount - 1
      textpos.push([_INTL("CLOSE BAG"), rect.x, rect.y + 2, false, self.baseColor, self.shadowColor])
    else
      item = (@filterlist) ? thispocket[@filterlist[@pocket][index]][0] : thispocket[index][0]
      baseColor   = self.baseColor
      shadowColor = self.shadowColor
      if @sorting && index == self.index
        baseColor   = Color.new(224, 0, 0)
        shadowColor = Color.new(248, 144, 144)
      end
      textpos.push(
        [@adapter.getDisplayName(item), rect.x, rect.y + 2, false, baseColor, shadowColor]
      )
      if GameData::Item.get(item).is_important?
        if @bag.registered?(item)
          pbDrawImagePositions(
            self.contents,
            [["Graphics/Pictures/Bag/icon_register", rect.x + rect.width - 72, rect.y + 8, 0, 0, -1, 24]]
          )
        elsif pbCanRegisterItem?(item)
          pbDrawImagePositions(
            self.contents,
            [["Graphics/Pictures/Bag/icon_register", rect.x + rect.width - 72, rect.y + 8, 0, 24, -1, 24]]
          )
        elsif GameData::Item.get(item).is_HM?
          pbDrawImagePositions(
            self.contents,
            [["Graphics/Pictures/Bag/icon_hm", rect.x + rect.width - 72, rect.y + 8, 0, 0, -1, 32]]
          )
        end
      else
        qty = (@filterlist) ? thispocket[@filterlist[@pocket][index]][1] : thispocket[index][1]
        qtytext = _ISPRINTF("x{1: 3d}", qty)
        xQty    = rect.x + rect.width - self.contents.text_size(qtytext).width - 16
        textpos.push([qtytext, xQty-16, rect.y + 2, false, baseColor, shadowColor])
      end
    end
    pbDrawTextPositions(self.contents, textpos)
  end
end

#===============================================================================
# Bag visuals
#===============================================================================
class PokemonBag_Scene
  ITEMLISTBASECOLOR     = Color.new(0, 0, 0)
  ITEMLISTSHADOWCOLOR   = Color.new(208, 208, 200)
  ITEMTEXTBASECOLOR     = Color.new(0, 0, 0)
  ITEMTEXTSHADOWCOLOR   = Color.new(208, 208, 200)
  POCKETNAMEBASECOLOR   = Color.new(0, 0, 0)
  POCKETNAMESHADOWCOLOR = Color.new(184, 152, 88)

  def pbStartScene(bag, choosing = false, filterproc = nil, resetpocket = true)
    @viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @viewport.z = 99999
    @bag        = bag
    @choosing   = choosing
    @filterproc = filterproc
    pbRefreshFilter
    lastpocket = @bag.last_viewed_pocket
    numfilledpockets = @bag.pockets.length - 1
    if @choosing
      numfilledpockets = 0
      if @filterlist.nil?
        (1...@bag.pockets.length).each do |i|
          numfilledpockets += 1 if @bag.pockets[i].length > 0
        end
      else
        (1...@bag.pockets.length).each do |i|
          numfilledpockets += 1 if @filterlist[i].length > 0
        end
      end
      lastpocket = (resetpocket) ? 1 : @bag.last_viewed_pocket
      if (@filterlist && @filterlist[lastpocket].length == 0) ||
         (!@filterlist && @bag.pockets[lastpocket].length == 0)
        (1...@bag.pockets.length).each do |i|
          if @filterlist && @filterlist[i].length > 0
            lastpocket = i
            break
          elsif !@filterlist && @bag.pockets[i].length > 0
            lastpocket = i
            break
          end
        end
      end
    end
    @bag.last_viewed_pocket = lastpocket
    @pocketbitmap = AnimatedBitmap.new("Graphics/Pictures/Bag/icon_pocket")
    @ballbitmap = AnimatedBitmap.new("Graphics/Pictures/Bag/icon_pokeball")
    @sprites = {}
    @sprites["background"] = IconSprite.new(0, 0, @viewport)
    @sprites["overlay"] = BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
    pbSetSystemFont(@sprites["overlay"].bitmap)
    @sprites["bagsprite"] = IconSprite.new(121, 203, @viewport)
    @sprites["bagsprite"].ox = 66
    @sprites["bagsprite"].oy = 132
    @sprites["ballsprite"] = BitmapSprite.new(32, 224, @viewport)
    @sprites["ballsprite"].x = 12
    @sprites["ballsprite"].y = 16
    @sprites["pocketicon"] = BitmapSprite.new(186, 32, @viewport)
    @sprites["pocketicon"].x = 72
    @sprites["pocketicon"].y = 52
    @sprites["leftarrow"] = AnimatedSprite.new("Graphics/Pictures/leftarrow", 8, 40, 28, 2, @viewport)
    @sprites["leftarrow"].x       = 28
    @sprites["leftarrow"].y       = 18
    @sprites["leftarrow"].visible = (!@choosing || numfilledpockets > 1)
    @sprites["leftarrow"].play
    @sprites["rightarrow"] = AnimatedSprite.new("Graphics/Pictures/rightarrow", 8, 40, 28, 2, @viewport)
    @sprites["rightarrow"].x       = 182
    @sprites["rightarrow"].y       = 18
    @sprites["rightarrow"].visible = (!@choosing || numfilledpockets > 1)
    @sprites["rightarrow"].play
    @sprites["itemlist"] = Window_PokemonBag.new(@bag, @filterlist, lastpocket, 214, -4, 314, 20+ 32 + (ITEMSVISIBLE * 32))
    @sprites["itemlist"].viewport    = @viewport
    @sprites["itemlist"].pocket      = lastpocket
    @sprites["itemlist"].index       = @bag.last_viewed_index(lastpocket)
    @sprites["itemlist"].baseColor   = ITEMLISTBASECOLOR
    @sprites["itemlist"].shadowColor = ITEMLISTSHADOWCOLOR
    @sprites["itemicon"] = ItemIconSprite.new(44, 240, nil, @viewport)
    @sprites["itemtext"] = Window_UnformattedTextPokemon.newWithSize(
      "", 12, 262, Graphics.width - 24, 144, @viewport
    )
    @sprites["itemtext"].baseColor   = ITEMTEXTBASECOLOR
    @sprites["itemtext"].shadowColor = ITEMTEXTSHADOWCOLOR
    @sprites["itemtext"].visible     = true
    @sprites["itemtext"].windowskin  = nil
    @sprites["helpwindow"] = Window_UnformattedTextPokemon.new("")
    @sprites["helpwindow"].visible  = false
    @sprites["helpwindow"].viewport = @viewport
    @sprites["msgwindow"] = Window_AdvancedTextPokemon.new("")
    @sprites["msgwindow"].visible  = false
    @sprites["msgwindow"].viewport = @viewport
    pbBottomLeftLines(@sprites["helpwindow"], 1)
    pbDeactivateWindows(@sprites)
    pbRefresh
    pbFadeInAndShow(@sprites)
  end

  def dispose
    pbDisposeSpriteHash(@sprites)
    @pocketbitmap.dispose
    @ballbitmap.dispose
    @viewport.dispose
  end

  def pbRefresh
    # Set the background image
    @sprites["background"].setBitmap(sprintf("Graphics/Pictures/Bag/bg_#{$player.female? ? "f" : "m"}"))
    # Set the bag sprite
    fbagexists = pbResolveBitmap(sprintf("Graphics/Pictures/Bag/bag_#{@bag.last_viewed_pocket}_f"))
    if $player.female? && fbagexists
      @sprites["bagsprite"].setBitmap("Graphics/Pictures/Bag/bag_#{@bag.last_viewed_pocket}_f")
    else
      @sprites["bagsprite"].setBitmap("Graphics/Pictures/Bag/bag_#{@bag.last_viewed_pocket}")
    end
    # Draw the pocket icons
    @sprites["pocketicon"].bitmap.clear
    if @choosing && @filterlist
      (1...@bag.pockets.length).each do |i|
        next if @filterlist[i].length > 0
        @sprites["pocketicon"].bitmap.blt(
          6 + ((i - 1) * 16), 6, @pocketbitmap.bitmap, Rect.new((i - 1) * 16, 16, 16, 16)
        )
      end
    end
    @sprites["pocketicon"].bitmap.blt(
      2 + ((@sprites["itemlist"].pocket - 1) * 16), 2, @pocketbitmap.bitmap,
      Rect.new((@sprites["itemlist"].pocket - 1) * 16, 0, 16, 16)
    )
    # Refresh the item window
    @sprites["itemlist"].refresh
    # Refresh more things
    pbRefreshIndexChanged
  end

  def pbBagJump(is_right)
    # Jump the little bag
    @sprites["ballsprite"].bitmap.clear
    @sprites["bagsprite"].y -= 10
    @sprites["bagsprite"].angle = is_right ?  355 : 5
    @sprites["ballsprite"].bitmap.blt(0,0,@ballbitmap.bitmap,Rect.new(0,32,32,32))
    i = 2
    5.times do
      @sprites["bagsprite"].y += 2
      if is_right
        @sprites["bagsprite"].angle += 1
      else
        @sprites["bagsprite"].angle -= 1
      end
      pbWait(1)
      @sprites["ballsprite"].bitmap.clear
      @sprites["ballsprite"].bitmap.blt(0,0,@ballbitmap.bitmap,Rect.new(0,i*32,32,32))
      i+=1
    end
    @sprites["ballsprite"].bitmap.clear
  end

  def pbRefreshIndexChanged
    itemlist = @sprites["itemlist"]
    overlay = @sprites["overlay"].bitmap
    overlay.clear
    # Draw the pocket name
    pbDrawTextPositions(
      overlay,
      [[PokemonBag.pocket_names[@bag.last_viewed_pocket - 1], 124, 22, 2, POCKETNAMEBASECOLOR, POCKETNAMESHADOWCOLOR]]
    )
    # Set the selected item's icon
    @sprites["itemicon"].item = itemlist.item
    # Set the selected item's description
    @sprites["itemtext"].text =
      (itemlist.item) ? GameData::Item.get(itemlist.item).description : _INTL("Return to the field.")
  end

  # Called when the item screen wants an item to be chosen from the screen
  def pbChooseItem
    @sprites["helpwindow"].visible = false
    itemwindow = @sprites["itemlist"]
    thispocket = @bag.pockets[itemwindow.pocket]
    swapinitialpos = -1
    pbActivateWindow(@sprites, "itemlist") {
      loop do
        oldindex = itemwindow.index
        Graphics.update
        Input.update
        pbUpdate
        if itemwindow.sorting && itemwindow.index >= thispocket.length
          itemwindow.index = (oldindex == thispocket.length - 1) ? 0 : thispocket.length - 1
        end
        if itemwindow.index != oldindex
          # Move the item being switched
          if itemwindow.sorting
            thispocket.insert(itemwindow.index, thispocket.delete_at(oldindex))
          end
          # Update selected item for current pocket
          @bag.set_last_viewed_index(itemwindow.pocket, itemwindow.index)
          pbRefresh
        end
        if itemwindow.sorting
          if Input.trigger?(Input::ACTION) ||
             Input.trigger?(Input::USE)
            itemwindow.sorting = false
            pbPlayDecisionSE
            pbRefresh
          elsif Input.trigger?(Input::BACK)
            thispocket.insert(swapinitialpos, thispocket.delete_at(itemwindow.index))
            itemwindow.index = swapinitialpos
            itemwindow.sorting = false
            pbPlayCancelSE
            pbRefresh
          end
        else   # Change pockets
          if Input.trigger?(Input::LEFT)
            newpocket = itemwindow.pocket
            loop do
              newpocket = (newpocket == 1) ? PokemonBag.pocket_count : newpocket - 1
              break if !@choosing || newpocket == itemwindow.pocket
              if @filterlist
                break if @filterlist[newpocket].length > 0
              elsif @bag.pockets[newpocket].length > 0
                break
              end
            end
            if itemwindow.pocket != newpocket
              itemwindow.pocket = newpocket
              @bag.last_viewed_pocket = itemwindow.pocket
              thispocket = @bag.pockets[itemwindow.pocket]
              pbPlayCursorSE
              pbRefresh
              pbBagJump(false)
            end
          elsif Input.trigger?(Input::RIGHT)
            newpocket = itemwindow.pocket
            loop do
              newpocket = (newpocket == PokemonBag.pocket_count) ? 1 : newpocket + 1
              break if !@choosing || newpocket == itemwindow.pocket
              if @filterlist
                break if @filterlist[newpocket].length > 0
              elsif @bag.pockets[newpocket].length > 0
                break
              end
            end
            if itemwindow.pocket != newpocket
              itemwindow.pocket = newpocket
              @bag.last_viewed_pocket = itemwindow.pocket
              thispocket = @bag.pockets[itemwindow.pocket]
              pbPlayCursorSE
              pbRefresh
              pbBagJump(true)
            end
#          elsif Input.trigger?(Input::SPECIAL)   # Register/unregister selected item
#            if !@choosing && itemwindow.index<thispocket.length
#              if @bag.registered?(itemwindow.item)
#                @bag.unregister(itemwindow.item)
#              elsif pbCanRegisterItem?(itemwindow.item)
#                @bag.register(itemwindow.item)
#              end
#              pbPlayDecisionSE
#              pbRefresh
#            end
          elsif Input.trigger?(Input::ACTION)   # Start switching the selected item
            if !@choosing && thispocket.length > 1 && itemwindow.index < thispocket.length &&
               !Settings::BAG_POCKET_AUTO_SORT[itemwindow.pocket - 1]
              itemwindow.sorting = true
              swapinitialpos = itemwindow.index
              pbPlayDecisionSE
              pbRefresh
            end
          elsif Input.trigger?(Input::BACK)   # Cancel the item screen
            pbPlayCloseMenuSE
            return nil
          elsif Input.trigger?(Input::USE)   # Choose selected item
            (itemwindow.item) ? pbPlayDecisionSE : pbPlayCloseMenuSE
            return itemwindow.item
          end
        end
      end
    }
  end
end