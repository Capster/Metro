local rect, mod, setcolor = surface.DrawRect, math.mod, surface.SetDrawColor

function surface.DrawGrid(x, y, w, h, color)
 
	local val=0

	setcolor(color)

	for i=0,w do
		val=val+1
		if math.mod(val,2)!=0 then
			rect( x+i, y, 1, 1 ) 
		end
	end

	for i=1,h do
		val=val+1
		if math.mod(val,2)!=0 then
			rect( x+w, y+i, 1, 1 ) 
		end
	end

	for i=1,w do
		val=val+1
		if math.mod(val,2)!=0 then
			rect( x+w-i, y+h, 1, 1 ) 
		end
	end

	for i=1,h do
		val=val+1
		if math.mod(val,2)!=0 then
			rect( x, y+h-i, 1, 1 ) 
		end
	end

end

local cos, sin, DrawPoly = math.cos, math.sin, surface.DrawPoly

function surface.DrawFilledCircle(x,y,radius,quality)
    local circle = {};
    local tmp = 0;
    for i=1,quality do
        tmp = rad(i*360)/quality
        circle[i] = {x = x + cos(tmp)*radius,y = y + sin(tmp)*radius};
    end
    DrawPoly(circle)
end