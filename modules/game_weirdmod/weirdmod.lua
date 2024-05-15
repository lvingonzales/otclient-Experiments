weirdmodWindow = nil
weirdmodButton = nil
eventId = nil

function init()
    g_ui.importStyle('weirdmod')                                                                            -- weirdmod.otui is imported to allow for creation of
                                                                                                            -- the widgets.
    weirdmodWindow = g_ui.createWidget('MainPanel',rootWidget)
    weirdmodWindow:hide()                                                                                   -- The window is created as a widget with rootWidget as
                                                                                                            -- its parent and hidden on initialization.
    jumper = g_ui.createWidget('JumpButton', weirdmodWindow)                                                -- Similarly the button within the window is created as
    jumper:setX(weirdmodWindow:getX() + weirdmodWindow:getWidth())                                          -- a widget and its position is set to the right hand side 
    --print("Weird Button Loaded")                                                                          -- of its parent, the window.

    weirdmodButton = modules.client_topmenu.addRightGameToggleButton('weirdmodButton', tr('Weird Button'),  -- A button to access the winddow is placed on the top right 
                                                                     '/images/topbuttons/skills', toggle)   -- menu alongside buttons such as skills and inventory, and is
    weirdmodButton:setOn(false)                                                                             -- set to off on initialization.
end

function terminate()                                                                                        
    weirdmodWindow:destroy()
    weirdmodButton:destroy()
    jumper:destroy()
end

function toggle()                                                                                           -- The toggle shows all the components and calls the move() function
    if weirdmodWindow:isVisible() then                                                                      -- for the button, or it hide all the components and removes the 
        weirdmodWindow:hide()                                                                               -- scheduled event stored in eventId to stop the loop.
        weirdmodButton:setOn(false)
        jumper:hide()
        removeEvent(eventId)
    else
        weirdmodWindow:show()
        weirdmodButton:setOn(true)
        weirdmodWindow:focus()
        jumper:show()
        move()
    end
end

function move()
    if jumper:getX() >= (weirdmodWindow:getX() + jumper:getPaddingLeft()) then                              -- The X position (top left corner) of the button is checked against
        jumper:setX(jumper:getX() - 10)                                                                     -- the left edge of the window + the padding of the button, and if the
    end                                                                                                     -- two are not colliding the X position of the button is changed by -10.
    if jumper:getX() <= (weirdmodWindow:getX() + jumper:getPaddingLeft()) then                              -- Upon collision the movementReset() function is called.
        movementReset()
    end

    eventId = scheduleEvent(move, 100)                                                                      -- In order to loop without crashing the client, a scheduleEvnt() is used
end                                                                                                         -- with a delay of 100ms.

function movementReset()                                                                                    -- Using a seed set to the time on the operating system clock, the button's
    math.randomseed(os.time())                                                                              -- X position is reset and the Y position is set to a floored random integer
    jumper:setX(weirdmodWindow:getX() + (weirdmodWindow:getWidth() - (jumper:getWidth()                     -- between the current Y position of the window, accouting for the height of
                                                                      + jumper:getPaddingRight())))         -- the button, and the height of the window also accounting for the height of 
                                                                                                            -- the button.
    jumper:setY(math.floor(math.random(weirdmodWindow:getY() + jumper:getHeight(), 
                                       weirdmodWindow:getY() + (weirdmodWindow:getHeight()
                                        - jumper:getHeight()))))
end




