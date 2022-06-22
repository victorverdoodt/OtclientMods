# otclient-mods
Modulos para otcliente programados na linguagem LUA

#lockpick
https://www.youtube.com/watch?v=jGZWTIUwV3k

Exemplo para uso no server-side
function onUse(cid, item, frompos, item2, topos)

	if item2.uid > 0 then
		if item2.itemid == 1741 then
			local minrange = getItemAttribute(item2.uid, 'minrange')
			local maxrange = getItemAttribute(item2.uid, 'maxrange')
			if minrange ~= nil and maxrange ~= nil then
				doSendPlayerExtendedOpcode(cid,  27, "Open|"..minrage.."|"..maxrange)
			else
				doItemSetAttribute(getThingfromPos(topos).uid, "minrange", 35)			
				doItemSetAttribute(getThingfromPos(topos).uid, "maxrange", 45)
				doSendPlayerExtendedOpcode(cid,  27, "Open|35|45")
			end
		end
	end
	return true
end


#fishing
https://www.youtube.com/watch?v=In2gEBgvMZU
