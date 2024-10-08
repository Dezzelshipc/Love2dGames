function love.load()
	tile = {
		width = 32,
		height = 32,
	}

	nx = 10
	ny = 10

	t_step = 0.1
	step_progress = 0

	tilemap = {}
	for yi = 1, nx do
		local row = {}
		for xi = 1, ny do
			table.insert(row, false)
		end
		table.insert(tilemap, row)
	end

	is_playing = false
end

local function next_step()
	local function count_nearest(xi, yi)
		local sum = 0

		for j = -1, 1 do
			for i = -1, 1 do
				if 1 <= xi + i and xi + i <= nx and 1 <= yi + j and yi + j <= ny and not (i == 0 and j == 0) then
					sum = sum + (tilemap[yi + j][xi + i] and 1 or 0)
				end
			end
		end
		return sum
	end

	local new_tilemap = {}

	for yi = 1, nx do
		local row = {}
		for xi = 1, ny do
			local c_n = count_nearest(xi, yi)
			
			local state = (c_n == 3 or (tilemap[yi][xi] and c_n == 2))
			
			-- if c_n > 1 then
			-- 	print(c_n)
			-- end
			table.insert(row, state)
		end
		table.insert(new_tilemap, row)
	end

	return new_tilemap
end


function love.update(dt)
	if is_playing then
		step_progress = step_progress + dt

		if step_progress > t_step then
			step_progress = 0
			tilemap = next_step()
			-- print("---")
		end
	end
end

function love.draw()
	for yi = 1, nx do
		for xi = 1, ny do
			local fill_mode = tilemap[yi][xi] and "fill" or "line"

			love.graphics.rectangle(fill_mode, tile.width * xi, tile.height * yi, tile.width, tile.height)
		end
	end


	love.graphics.print(tostring(love.timer.getFPS()))
	
	love.graphics.print(string.format("%.2f", step_progress), 0 ,10)
end

function love.mousepressed(x, y, button, istouch, presses)
	if is_playing then
		return
	end

	local xi = math.floor(x / tile.width)
	local yi = math.floor(y / tile.height)

	if xi < 1 or xi > nx or yi < 1 or yi > ny then
		return
	end

	tilemap[yi][xi] = not tilemap[yi][xi]
end

local function clean()
	for yi = 1, nx do
		for xi = 1, ny do
			tilemap[yi][xi] = false
		end
	end
end

function love.keypressed(key, scancode, isrepeat)
	if scancode == "escape" then
		love.event.quit()
	end

	if scancode == "space" then
		is_playing = not is_playing
	end

	if scancode == "f1" then
		clean()
	end
end
