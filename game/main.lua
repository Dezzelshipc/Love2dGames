function love.load()
	tile = {
		width = 100,
		height = 100,
		x = 100,
		y = 100,
		n = 3,
	}

	tilemap = {
		{ 0, 0, 0 },
		{ 0, 0, 0 },
		{ 0, 0, 0 },
	}

	icon_player = {"X", "O"}

	current_player = 1
	turn = 0

	is_game = true
end

function love.update(dt)
end

function love.draw()
	for i = 0, tile.n - 1 do
		for j = 0, tile.n - 1 do
			love.graphics.rectangle('line', tile.x + tile.width * i, tile.y + tile.height * j, tile.width, tile.height)

			local icon = tilemap[i + 1][j + 1]

			if icon == 1 then
				local i1 = i + 0.1
				local i2 = i + 0.9
				local j1 = j + 0.1
				local j2 = j + 0.9

				love.graphics.line(tile.x + tile.width * i1, tile.y + tile.height * j1, tile.x + tile.width * i2,
					tile.y + tile.height * j2)
				love.graphics.line(tile.x + tile.width * i1, tile.y + tile.height * j2, tile.x + tile.width * i2,
					tile.y + tile.height * j1)
			elseif icon == 2 then
				love.graphics.circle('line', tile.x + tile.width * (i + 0.5), tile.y + tile.height * (j + 0.5),
					(tile.width + tile.height) / 5)
			end
		end
	end

	if is_game then
		love.graphics.print("Turn of player " .. current_player .. " (".. icon_player[current_player] ..")", tile.x, tile.y - tile.height)
	else
		if current_player == -1 then
			love.graphics.print("It's a tie!", tile.x, tile.y - tile.height)
		else
			love.graphics.print("Player " .. current_player .. " won!", tile.x, tile.y - tile.height)
		end
	end

	
	love.graphics.print("F1 to restart", tile.x, tile.y + tile.height * (3+0.8))
end

local function checkWin(i, j)
	local function checkEntry(entry)
		local is_all = true
		for _, v in ipairs(entry) do
			if v ~= entry[1] then
				is_all = false
				break
			end
		end
		return is_all and entry[1] ~= 0 and entry[1]
	end

	local player_won = false

	local to_check = { tilemap[i] }

	local col = {}
	for ii = 1, tile.n do
		table.insert(col, tilemap[ii][j])
	end
	table.insert(to_check, col)

	if i - j == 0 then
		local diag = {}
		for ii = 1, tile.n do
			table.insert(diag, tilemap[ii][ii])
		end
		table.insert(to_check, diag)
	end

	if i + j == tile.n + 1 then
		local diag = {}
		for ii = 1, tile.n do
			table.insert(diag, tilemap[tile.n + 1 - ii][ii])
		end
		table.insert(to_check, diag)
	end

	for _, v in ipairs(to_check) do
		local won = checkEntry(v)
		if won then
			player_won = won
			break
		end
	end

	return player_won
end


function love.mousepressed(x, y, button, istouch, presses)
	if button ~= 1 or not is_game then
		return
	end

	local tx = math.floor((x - tile.x) / tile.width)
	local ty = math.floor((y - tile.y) / tile.height)

	if tilemap[tx + 1][ty + 1] == 0 then
		tilemap[tx + 1][ty + 1] = current_player

		if current_player == 1 then
			current_player = 2
		else
			current_player = 1
		end
	end
	turn = turn + 1
	if turn >= 9 then
		current_player = -1
		is_game = false
	end

	local is_player_won = checkWin(tx + 1, ty + 1)

	if is_player_won then
		is_game = false
		current_player = is_player_won
	end
end

function love.keypressed(key, scancode, isrepeat)
	if scancode == "f1" then
		love.load()
	end
end
