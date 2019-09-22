FishWindow = nil
Fish = nil
Target = nil
PBar = nil
local pos = nil
function init()
	FishWindow = g_ui.displayUI('fishing.otui')	
	Fish = FishWindow:getChildById('Fish')
	Target = FishWindow:getChildById('Target')
	PBar = FishWindow:getChildById('FishBar')
	pos = math.random(FishWindow:getWidth())
	cycleEvent(Update, 10)
	cycleEvent(ChangeTarget, 25)
	cycleEvent(ChangeBar, 10)
	Target:setWidth(40)
	PBar:setPercent(0)
	FishWindow:hide()
end

function ChangeBar()
	if Fish:getMarginLeft() >= Target:getMarginLeft() and Fish:getMarginLeft() <= Target:getMarginLeft()+Target:getWidth() then
		PBar:setPercent(PBar:getPercent()+1)
	else
		PBar:setPercent(PBar:getPercent()-1)
	end
end
function ChangeTarget()
	if g_window.isMouseButtonPressed(MouseLeftButton) then
		if Target:getMarginLeft() < FishWindow:getWidth()-Target:getWidth()-21 then
			Target:setMarginLeft(Target:getMarginLeft()+5)
		end
	else
		if Target:getMarginLeft() > 0 then
			Target:setMarginLeft(Target:getMarginLeft()-5)
		end
	end
end
function Update()
	if pos >= FishWindow:getWidth()-50 then
		pos = FishWindow:getWidth()-50
	end
	if Fish:getMarginLeft() ~= pos then
		if Fish:getMarginLeft() < FishWindow:getWidth()-40 then
			if (Fish:getMarginLeft() - pos) < 0 then
				Fish:setMarginLeft(Fish:getMarginLeft()+1)
			else
				Fish:setMarginLeft(Fish:getMarginLeft()-1)
			end
		else
			pos = math.random(FishWindow:getWidth())
		end
	else
		pos = math.random(FishWindow:getWidth())
	end

end




