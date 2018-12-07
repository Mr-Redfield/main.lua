local anim = require 'anim8'
local imagem, animation
local posX = 100
local direcao = true
local bump =  require 'bump'
fisica = {}--tabela fisica
player = {
	x = 100,
	y = 100,
	speed = 100
} --cria o corpo "player"

pedra = {
	x = 400,
	y = 400,
	w = 50,
	h = 50
}--Cria o corpo pedra

background = {
	x = 0,
	y = 0
}--Define o background da imagem.



function love.load()
	fisica.world = bump.newWorld(32)
	background.imagem = love.graphics.newImage("imagem/background.jpeg")--coloca o elmento "imagem" na tabela "background"
	player.imagem = love.graphics.newImage("imagem/sprite.png")--coloca o elemento "imagem" na tabela "player"
	-- getWidth() retorna a largura da imagem
	player.width = player.imagem:getWidth()--encontra a largura da imagem
	-- getHeight() retorna a altura da mm
	player.height = player.imagem:getHeight()--encontra a altura da imagem

	fisica.world:add(player, player.x, player.y, player.width, player.height)--adiciona os parametros para a função retornada pelo Bump
	--A mesma coisa da linha anterior, mas para outro objeto
	
	player.imagem = love.graphics.newImage("imagem/sprite.png")
	player.imagem = anim.newGrid(player.width, player.height, imagem:getWidth(),imagem:getHeight() )
	animation = pers( player.imagem('1-10', 1, '1-10', 2, '1-9', 3), 0.01)
end
function love.update( dt )
	--[[if love.keyboard.isDown('left') then
		posX = posX - 150 * dt
		direcao = false
		animation:update( dt )
	end
	if love.keyboard.isDown('right') then
		posX = posX + 150 * dt
		direcao = true
		animation:update( dt )
	end ]]
	if (love.keyboard.isDown("up")) then
		player.x, player.y = fisica.world:move(player, player.x, player.y - player.speed * dt)--chama a função move
	elseif (love.keyboard.isDown("down")) then
		player.x, player.y = fisica.world:move(player, player.x, player.y + player.speed * dt)
	elseif (love.keyboard.isDown("left")) then
		player.x, player.y = fisica.world:move(player, player.x - player.speed * dt, player.y)
	elseif (love.keyboard.isDown("right")) then
		background.x = background.x - 100 * dt
		if (background.x < -background.imagem:getWidth()) then
			background.x = 0
		end
		player.x, player.y = fisica.world:move(player, player.x + player.speed * dt, player.y)
	end
end

function love.draw()
	love.graphics.setBackgroundColor(255,255,255)
	if direcao then
		animation:draw(imagem,posX,50,0,1,1,207,0)
	elseif not direcao then
		animation:draw(imagem, posX, 50,0,-1,1,207,0)
	end
	love.graphics.draw(background.imagem, background.x, background.y)
	love.graphics.draw(background.imagem, background.x + background.imagem:getWidth(), background.y)
	love.graphics.draw(player.imagem, player.x, player.y)
end
