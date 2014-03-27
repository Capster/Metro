Metro.Keyboard = {}
Metro.Keyboard.Listen = {}

Metro.Keyboard.Enums = {
	Down = 1,
	Up 	 = 0
}

Metro.Keyboard.CloseAll = {KEY_LALT, KEY_F4}

function Metro.Keyboard:ListenKey(key)
	if self.Listen [key] then return end
	self.Listen [key] = Metro.Keyboard.Enums.Up
end

function Metro.Keyboard:UnListenKey(key)
	if not self.Listen [key] then return end
	self.Listen [key] = nil
end

function Metro.Keyboard:IsKeyDown(key)
	return self.Listen [key] == self.Enums.Down or false
end

hook.Add( "Think", "Metro.KeyboardHook", function()
	for k, v in pairs (Metro.Keyboard.Listen) do
		Metro.Keyboard.Listen[k] = Metro.Keyboard.Enums.Up
		if input.IsKeyDown( k ) then
			Metro.Keyboard.Listen[k] = Metro.Keyboard.Enums.Down
		end
	end
end )

Metro.Keyboard:ListenKey(KEY_LALT)
Metro.Keyboard:ListenKey(KEY_LCONTROL)
Metro.Keyboard:ListenKey(KEY_ESCAPE)
Metro.Keyboard:ListenKey(KEY_F1)
Metro.Keyboard:ListenKey(KEY_F4)