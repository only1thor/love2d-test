platform = {}
player = {}

function love.load()
    platform.width = love.graphics.getWidth()
    platform.height = love.graphics.getHeight() / 2
    platform.x = 0
    platform.y = love.graphics.getHeight() / 2

    player.x = love.graphics.getWidth() / 2
    player.y = love.graphics.getHeight() / 2
    player.speed = 500
    player.img = love.graphics.newImage('purple.png')
    player.ground = player.y
    player.y_velocity = 0
    player.jump_power = -900
    player.gravity = 3900
    player.max_fall_speed = 1800
    player.grounded = true
end

-- Define the red box properties
local red_box = {
    x = 300,
    y = 300,
    width = 50,
    height = 50
}

-- Function to reset the game
local function reset_game()
    player.x = 100
    player.y = player.ground
    player.y_velocity = 0
    player.grounded = true
end

function love.update(dt)
    if love.keyboard.isDown('escape') then
        love.event.quit()
    end

    if love.keyboard.isDown('right') and player.x < (love.graphics.getWidth() - player.img:getWidth()) then
        player.x = player.x + (player.speed * dt)
    elseif love.keyboard.isDown('left') and player.x > 0 then
        player.x = player.x - (player.speed * dt)
    end

    if love.keyboard.isDown('space') and player.grounded then
        player.y_velocity = player.jump_power
        player.grounded = false
    end

    if not player.grounded then
        player.y_velocity = player.y_velocity + player.gravity * dt
        player.y_velocity = math.min(player.y_velocity, player.max_fall_speed)
        player.y = player.y + player.y_velocity * dt
    else
        player.y_velocity = 0
    end

    player.grounded = player.y >= player.ground
    if player.grounded then
        player.y = player.ground
    end

    -- Check for collision with the red box
    if player.x < red_box.x + red_box.width and
       player.x + player.img:getWidth() > red_box.x and
       player.y < red_box.y + red_box.height and
       player.y + player.img:getHeight() > red_box.y then
        reset_game()
    end
end

function love.draw()
    love.graphics.setColor(0, 0, 0.545)  -- Set color to deep blue
    love.graphics.rectangle('fill', platform.x, platform.y, platform.width, platform.height)
    love.graphics.setColor(1, 1, 1)  -- Reset color to white for the player
    love.graphics.draw(player.img, player.x, player.y, 0, 1, 1, 0, 32)
    love.graphics.setColor(1, 0, 0)  -- Set color to red for the red box
    love.graphics.draw(player.img, red_box.x, red_box.y, 0, 1, 1, 0, 32)
end
