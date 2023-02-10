--[[
  Project: PongLove - Pong clone in Lua using LÖVE
  Date: 10-02-2023
  Author: Quentin "QuenK"
  For: UnisCité - Code Club
]]--

--[[
  Mise en place de la fonction d'initialisation 
(initialisation: En informatique et en particulier en programmation, 
l'initialisation est l'opération qui consiste à mettre en place les éléments nécessaires au bon fonctionnement d'un programme ou d'un système.
Pour notre cas: L'initialisation est l'opération qui consiste à mettre en place les éléments du jeu.)
]]--

function love.load() -- Début de la fonction d'initialisation
  -- Création de la balle et des raquettes
  ball = {x = 400, y = 300, radius = 10, speed = 200, dx = 1, dy = 1} -- x = abscisse, y = ordonnée, radius = rayon, speed = vitesse, dx = déplacement en x, dy = déplacement en y
  player1 = {x = 50, y = 250, width = 10, height = 100, score = 0} -- x = abscisse, y = ordonnée, width = largeur, height = hauteur, score = score
  player2 = {x = 750, y = 250, width = 10, height = 100, score = 0}

  -- Nom de la fenêtre
  love.window.setTitle("Pong UnisCité")
end -- Fin de la fonction d'initialisation

--[[
  Mise en place de la fonction de mise à jour
(mise à jour: En informatique, la mise à jour est l'opération qui consiste à mettre à jour un programme ou un système.
Pour notre cas: La mise à jour est l'opération qui consiste à mettre à jour les éléments du jeu.)
]]--

function love.update(dt) -- Début de la fonction de mise à jour (dt = delta time = temps écoulé entre chaque frame (image) en secondes 1FPS = 1 frame par seconde 60FPS = 60 frames par seconde)
  -- Déplacement de la balle
  ball.x = ball.x + ball.dx * ball.speed * dt
  ball.y = ball.y + ball.dy * ball.speed * dt
  
  -- Déplacement de la raquette du joueur 1
  if love.keyboard.isDown("z") then
    player1.y = player1.y - 400 * dt
  elseif love.keyboard.isDown("s") then
    player1.y = player1.y + 400 * dt
  end
  
  -- Déplacement de la raquette du joueur 2
  if love.keyboard.isDown("up") then
    player2.y = player2.y - 400 * dt
  elseif love.keyboard.isDown("down") then
    player2.y = player2.y + 400 * dt
  end

  -- Enteindre le programme si echap appuyé
  if love.keyboard.isDown("escape") then
    love.event.quit()
  end
  
  -- Collision avec le haut et le bas de l'écran
  if ball.y < ball.radius then
    ball.y = ball.radius
    ball.dy = -ball.dy
  elseif ball.y > 600 - ball.radius then
    ball.y = 600 - ball.radius
    ball.dy = -ball.dy
  end
  
  -- Collision avec les raquettes (width = largeur, height = hauteur et radius = rayon)
  if ball.x < player1.x + player1.width and ball.y > player1.y and ball.y < player1.y + player1.height then -- Si la balle touche la raquette du joueur 1
    ball.x = player1.x + player1.width
    ball.dx = -ball.dx
  elseif ball.x > player2.x - player2.width and ball.y > player2.y and ball.y < player2.y + player2.height then -- Si la balle touche la raquette du joueur 2
    ball.x = player2.x - player2.width
    ball.dx = -ball.dx
  end
  
  -- Collision avec les bords de l'écran (x = abscisse, y = ordonnée et dx = déplacement en x)
  if ball.x < 0 then -- Si la balle touche le bord gauche de l'écran
    player2.score = player2.score + 1
    ball.x = 400
    ball.y = 300
    ball.dx = -ball.dx
  elseif ball.x > 800 then -- Si la balle touche le bord droit de l'écran
    player1.score = player1.score + 1
    ball.x = 400
    ball.y = 300
    ball.dx = -ball.dx
  end
end -- Fin de la fonction de mise à jour

--[[
  Mise en place de la fonction d'affichage
(affichage: En informatique, l'affichage est l'opération qui consiste à afficher un programme ou un système.
Pour notre cas: L'affichage est l'opération qui consiste à afficher les éléments du jeu.)
]]--

function love.draw() -- Début de la fonction d'affichage
  -- Affichage de la balle
  love.graphics.circle("fill", ball.x, ball.y, ball.radius)
  
  -- Affichage des raquettes
  love.graphics.rectangle("fill", player1.x, player1.y, player1.width, player1.height)
  love.graphics.rectangle("fill", player2.x, player2.y, player2.width, player2.height)
  
  -- Affichage du score
  love.graphics.print("Score: "..player1.score.." | "..player2.score, 350, 20)
end -- Fin de la fonction d'affichage

-- Fin du code