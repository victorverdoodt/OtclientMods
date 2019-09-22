lockWindow = nil
image = nil
chave = nil
local Open = nil
local lockpick = nil
local min_r = nil
local max_r = nil
function init()
	lockWindow = g_ui.displayUI('lockpick.otui')	
	image = lockWindow:getChildById('fechadura')
	lockWindow:hide()
	chave = lockWindow:getChildById('chave')
	chave:hide()
	g_mouse.bindPressMove(chave, chaveRotationRight)
	g_mouse.bindPressMove(image, lockerRotationRight)
	
	ProtocolGame.registerExtendedOpcode(27, Update)
	g_keyboard.bindKeyPress('Right', lockerRotationRight, lockWindow)
	g_keyboard.bindKeyUp('Right', lockerReset, lockWindow, true)
end

function lockerReset()
	image:rotate(0)
end
function Update(protocol, opcode, buffer)
	local player = g_game.getLocalPlayer()
	local creatureData = g_map.getCreatureById(player:getId())
	g_map.colorizeThing(creatureData, 12)
	local data = string.split(buffer, "|")
	if data[1] == "Open" then
		lockWindow:show()
		min_r = tonumber(data[2])
		max_r = tonumber(data[3])
		Open = false
		chave:rotate(0)
		image:rotate(0)
		lockpick = true
		chave:show()
	end
end


local count = 0
function lockerRotationRight() 
	if not Open and min_r ~= nil and max_r ~= nil then
		image:rotate(image:getRotation()+1)
		if chave:getRotation() >= min_r and chave:getRotation() <= max_r then
			print("open")
			Open = true
			if g_game.isOnline() then
				local Protocol = g_game.getProtocolGame()
				Protocol:sendExtendedOpcode(28, "open")
			end
			lockWindow:hide()
			lockpick = false
			chave:hide()
			Open = false
		else
			if image:getRotation() > 0 then
				if math.random(100) < 20 then
					image:rotate(image:getRotation()-math.random(-1, 10))
					count = count +1
				end
				if lockpick and count > 10 then
					print("break lockpick")
					if g_game.isOnline() then
						local Protocol = g_game.getProtocolGame()
						Protocol:sendExtendedOpcode(28, "break")
					end
					count = 0
					lockWindow:hide()
					lockpick = false
					chave:hide()
				end
			end
		end
	end
end

function chaveRotationRight() 
	if not Open  then
		chave:rotate(getAngle(g_window.getMousePosition(), image:getPosition()))
	end
end

function getAngle(Pos1, Pos2)
    local PI = math.pi
    local deltaY = Pos1.y - Pos2.y
    local deltaX = Pos1.x - Pos2.x

    local angleInDegrees = (math.atan2(deltaY, deltaX) * 180 / PI)

    return math.floor(angleInDegrees)
end



