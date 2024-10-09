local function mandelbrot(cx, cy)
	local x = cx
	local y = cy

	for n = 1, N do
		local x_new = x ^ 2 - y ^ 2 + cx
		local y_new = 2 * x * y + cy
		x = x_new
		y = y_new
		if n % 10 == 0 then
			if x^2 + y^2 > 4 then
				break
			end
		end
	end
	return x^2 + y^2 < 4
end

function love.load()
	tx = 0
	ty = 0
	tscale = 1

	N = 100

	NX = 300 * 5
	NY = 200 * 5

	LX, RX = -2, 1
	LY, RY = -1, 1

	HX = (RX - LX) / NX
	HY = (RY - LY) / NY

	SCALEX = 100
	SCALEY = 100

	print(HX, HY)

	mesh = {}
	for y = 0, NY do
		local row = {}
		for x = 0, NX do
			local cx = LX + HX * x
			local cy = LY + HY * y

			row[x] = mandelbrot(cx, cy)
			-- if row[x] then
			-- 	print(cx, cy)
			-- end
		end
		mesh[y] = row
	end

	print(mesh)
end

function love.update(dt)
end

function love.draw()

	love.graphics.scale(tscale, tscale)
	love.graphics.translate(tx, ty)

	for y = 0, NY do
		for x = 0, NX do
			local xx = (LX + HX * x) * SCALEX
			local yy = (LY + HY * y) * SCALEY

			if mesh[y][x] then
				love.graphics.rectangle("fill", xx, yy, HX * SCALEX, HY * SCALEY)
			end
		end
	end
end

function love.keypressed(key, scancode)
	if scancode == "left" then
		tx = tx + 100
	elseif scancode == "right" then
		tx = tx - 100
	elseif scancode == "up" then
		ty = ty + 100
	elseif scancode == "down" then
		ty = ty - 100
	end

	if scancode == "[" then
		tscale = tscale / 2
	elseif scancode == "]" then
		tscale = tscale * 2
	end
end