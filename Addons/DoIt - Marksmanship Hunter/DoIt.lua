-- DoIt by Basil Uzhanov
-- Paint the square according to the next priority abbility

local DoItUpdate=true
local DoItNext="none"
local DoItPrev
local spell = "none"
local spell1 = "none"
local DoItCombat 

local advance = 0.25
local reDoT = 1.5
local UtlCD = 4
local UtlTick = 0.2
local LastUtl =0
local MnCD = 0.5
local LastMn = 0
local precast = 0.35

local PrUnit = "none"


local DoItFrame=CreateFrame("Frame",nil,WorldFrame)
-- Create the square itself
DoItFrame.t = DoItFrame:CreateTexture()
local width = 2
local height = 2
DoItFrame:ClearAllPoints()
DoItFrame:SetScale(1)
DoItFrame:SetFrameStrata("TOOLTIP")
DoItFrame:SetWidth(width)
DoItFrame:SetHeight(height)
DoItFrame:SetPoint("TOPLEFT",UIParent)
DoItFrame.t:SetAllPoints(DoItFrame)
DoItFrame.t:SetTexture(0,0,0)
DoItFrame:Show()

local T = {}

local function DiItInit()
	-- Check Who am I?
	
	WorldFrame:ClearAllPoints()
	WorldFrame:SetPoint("TOPLEFT", 0, -height)
	WorldFrame:SetPoint("BOTTOMRIGHT", 0, 0)

	-- Hunter MM
			DEFAULT_CHAT_FRAME:AddMessage("DoIt: MM Hunter")
			DoItCombat = HuntCombatMM
			DoItFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
			DoItFrame:SetScript("OnUpdate", 
				function()
					if DoItUpdate then
						DoItPrev=DoItNext
						DoItRecountHuntMM()
						if DoItNext ~= DoItPrev then
							DoItSetHuntMM(DoItNext)
						end
					end
				end
			)
end



T["Kill Shot"] = GetSpellInfo(53351) -- 71
T["Chimera Shot"] = GetSpellInfo(53209) -- 60
T["Serpent Sting"] = GetSpellInfo(1978) -- 4
T["Arcane Shot"] = GetSpellInfo(3044) -- 6
T["Aimed Shot"] = 19434 -- 20
T["Steady Shot"] = GetSpellInfo(56641) -- 50
T["Hunter's Mark"] = GetSpellInfo(1130) -- 6
T["Mend Pet"] = GetSpellInfo(136) -- 12
T["Aspect of the Hawk"] = GetSpellInfo(13165) -- 100
T["Aspect of the Fox"] = GetSpellInfo(82661) -- 100


T["Fire!"] = GetSpellInfo(82926) -- 100
T["Improved Steady Shot"] = GetSpellInfo(53224) -- 100
T["Marked for Death"] = GetSpellInfo(88691) -- 100
T["Pero"] = GetSpellInfo(98764) --XXXX

local DbfTry = 0
local LastSting = 0
local LastStSh = 0
local StShFlag = false
local StShCount = 0
local Stopped = 0

function HuntCombatMM( ... )
	local timestamp, type, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags = select(1, ...)
    if (type=="SPELL_MISSED") and (destGUID == UnitGUID("target")) then
		local spellId, spellName, spellSchool, missType = select(9, ...)
--		print(spellName)
		if missType == "IMMUNE" and spellName == T["Serpent Sting"] then
			DbfTry = 10
--			print("Unplagueable")
		end
	end
end

function DoItRecountHuntMM()
	local start, duration, usable, index, spell
	
	DoItNext = "none"

	if not InCombatLockdown() or UnitCanAttack("player","target") == nil then
		DbfTry = 0
		StShCount = 0
		return
	end

	local IsStill = (GetUnitSpeed("player") == 0)
	
	if IsStill then
		if Stopped == 0 then
			Stopped = GetTime()
		end
	else
		Stopped = 0
	end

	spell1, _, _, _, _, endTime = UnitCastingInfo("PLAYER")
	if spell1 and endTime and ((endTime/1000 - GetTime()) > precast) then
		if StShFlag and spell1 == T["Steady Shot"] then
			StShFlag = false
			StShCount = StShCount + 1
		end
		if GetTime() - LastStSh > 1 and spell1 ~= T["Steady Shot"] then
			StShCount = 0
		end
		return
	end
	
	index = 1
	local FireOK = false
	local ISS = 0
	local AotF = false
	local _, _, _, _, currRank = GetTalentInfo(2,5)
	if currRank == 0 then
		ISS = 100
	end
	while UnitBuff("PLAYER", index) do
		local name, _, _, _, _, _, expire, IsMine = UnitBuff("PLAYER", index)
		if name == T["Fire!"] then
			FireOK = true
		elseif name == T["Improved Steady Shot"] then
			ISS = expire - GetTime()
		elseif name == T["Aspect of the Fox"] then
			AotF = true
		elseif name == T["Pero"] then
			IsStill = true
		end
		index = index + 1
	end
	
	spell = "Aspect of the Hawk"
	usable, _ = IsUsableSpell(T[spell])
	if usable and IsStill and AotF and GetTime() - Stopped > 1.5 then
		start, duration = GetSpellCooldown(T[spell])
		if start and (start + duration - GetTime() < advance) then
			DoItNext = spell
			DoItMnRst()
			return
		end
	end
	
	spell = "Aspect of the Fox"
	usable, _ = IsUsableSpell(T[spell])
	if usable and not IsStill and not AotF and (ISS < 3 or UnitPower("player") < 30) then
		start, duration = GetSpellCooldown(T[spell])
		if start and (start + duration - GetTime() < advance) then
			DoItNext = spell
			DoItMnRst()
			return
		end
	end
	
	start, duration = GetSpellCooldown(T["Serpent Sting"])
	if (start and (start + duration - GetTime() > advance)) then
		if GetTime() - LastStSh > 1 then
			StShCount = 0
		end
		return
	end
	
	if IsSpellInRange(T["Serpent Sting"],"TARGET")~=1 or not DoItMnRdy() then
		return
	end
	
	if ISS > 6 then
		StShCount = 0
	end

	local CUnit = UnitGUID("target")
	if CUnit ~= nil and CUnit ~= PrUnit then
		PrUnit = CUnit
		DbfTry = 0
	end

	index = 1
	local ST = 0
	local HM = false
	while UnitDebuff("target", index) do
		local name, _, _, count, _, _, shockExpires, isMine = UnitDebuff("target", index)
		if name == T["Hunter's Mark"] or name == T["Marked for Death"] then
			HM = true
		elseif isMine and isMine == "player" then
			if name == T["Serpent Sting"] then
				ST = shockExpires - GetTime()
				DbfTry = 0
			end
		end
		index = index + 1
	end

	index = 1
	local MP = not (UnitExists("pet") and UnitHealth("pet") > 0)
	if not MP then
		while UnitBuff("pet", index) do
			local name, _, _, _, _, _, expire, IsMine = UnitBuff("pet", index)
			if name == T["Mend Pet"] then
				MP = true
			end
			index = index + 1
		end
	end

	local _, _, _, _, _, _, STcastTime, _, _ = GetSpellInfo(T["Steady Shot"])
	
	spell = "Steady Shot"
	usable, _ = IsUsableSpell(T[spell])
	if usable and (IsStill or AotF) and ISS < 2 * STcastTime / 1000 and StShCount == 1 then
		start, duration = GetSpellCooldown(T[spell])
		if start and (start + duration - GetTime() < advance) then
			if GetTime() - LastStSh > 1 then
				LastStSh = GetTime()
				StShFlag = true
			end
			DoItNext = spell
			DoItMnRst()
			return
		end
	end
	
	if DbfTry < 2 and ST == 0 and (GetTime() - LastSting < UtlTick or GetTime() - LastSting > 2) then
		usable, _ = IsUsableSpell(T["Serpent Sting"])
		if usable then
			start, duration = GetSpellCooldown(T["Serpent Sting"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Serpent Sting"
				if GetTime() - LastSting > UtlTick then
					LastSting = GetTime()
				end
				DoItMnRst()
				return
			end
		end
	end

	local CA = (select(5,GetTalentInfo(2, 6)) > 0) and (UnitHealth("target") / UnitHealthMax("target") > 0.9)

	local ChShLeft = 100
	local _, _, _, _, MfD = GetTalentInfo(2, 18)
	spell = "Chimera Shot"
	usable, nomana = IsUsableSpell(T[spell])
	if usable or nomana then
		start, duration = GetSpellCooldown(T[spell])
		ChShLeft = start + duration - GetTime()
--		if usable and start and (ChShLeft < advance) then
		if usable and start and (ChShLeft < advance) and (((ST > 0.5 and ST < 4) or (not HM and MfD == 2) or not IsStill) or not CA) then
			DoItNext = spell
			DoItMnRst()
			return
		end
	end

	local _, _, _, _, ChS = GetTalentInfo(2, 19)
	if not HM and (MfD < 2 or ChS == 0) then
		usable, _ = IsUsableSpell(T["Hunter's Mark"])
		if usable then
			start, duration = GetSpellCooldown(T["Hunter's Mark"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Hunter's Mark"
				DoItMnRst()
				return
			end
		end
	end
	
	spell = "Aimed Shot"
	usable, _ = IsUsableSpell(T[spell])
	if usable and FireOK then
		start, duration = GetSpellCooldown(T[spell])
		if start and (start + duration - GetTime() < advance) then
			DoItNext = spell
			DoItMnRst()
			return
		end
	end
	
	spell = "Steady Shot"
	usable, _ = IsUsableSpell(T[spell])
	if usable and (IsStill or AotF) and ISS == 0 and StShCount == 0 then
		start, duration = GetSpellCooldown(T[spell])
		if start and (start + duration - GetTime() < advance) then
			if GetTime() - LastStSh > 1 then
				LastStSh = GetTime()
				StShFlag = true
			end
			DoItNext = spell
			DoItMnRst()
			return
		end
	end
	
	spell = "Aimed Shot"
	usable, _ = IsUsableSpell(T[spell])
	if usable and CA and IsStill and (ChShLeft > 3 or UnitPower("player") > 80) then
		start, duration = GetSpellCooldown(T[spell])
		if start and (start + duration - GetTime() < advance) then
			DoItNext = spell
			DoItMnRst()
			return
		end
	end

	-- слив фокуса аббилкой "Focus dump", аркан только на перебежках
	spell = "Aimed Shot"
	usable, _ = IsUsableSpell(T[spell])
	if usable and IsStill and (ChShLeft > 3 or UnitPower("player") > 80) then
		start, duration = GetSpellCooldown(T[spell])
		if start and (start + duration - GetTime() < advance) then
--			DoItNext = spell
			DoItNext = "Focus dump"
			DoItMnRst()
			return
		end
	end
	
	spell = "Arcane Shot"
	usable, _ = IsUsableSpell(T[spell])
	if usable and not IsStill and (ChShLeft > 3 or UnitPower("player") > 70) then
--	if usable and not IsStill then
		start, duration = GetSpellCooldown(T[spell])
		if start and (start + duration - GetTime() < advance) then
			DoItNext = spell
			DoItMnRst()
			return
		end
	end
	
	spell = "Kill Shot"
	usable, _ = IsUsableSpell(T[spell])
	if usable then
		start, duration = GetSpellCooldown(T[spell])
		if start and (start + duration - GetTime() < advance) then
			DoItNext = spell
			DoItMnRst()
			return
		end
	end

	spell = "Steady Shot"
	usable, _ = IsUsableSpell(T[spell])
	if usable and (IsStill or AotF) and ISS < 2 * STcastTime / 1000 and StShCount == 0 then
		start, duration = GetSpellCooldown(T[spell])
		if start and (start + duration - GetTime() < advance) then
			if GetTime() - LastStSh > 1 then
				LastStSh = GetTime()
				StShFlag = true
			end
			DoItNext = spell
			DoItMnRst()
			return
		end
	end

	if not MP and (UnitHealth("pet") / UnitHealthMax("pet") < 0.7) then
		usable, _ = IsUsableSpell(T["Mend Pet"])
		if usable then
			start, duration = GetSpellCooldown(T["Mend Pet"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Mend Pet"
				DoItMnRst()
				return
			end
		end
	end

	spell = "Steady Shot"
	usable, _ = IsUsableSpell(T[spell])
	if usable and (IsStill or AotF) then
		start, duration = GetSpellCooldown(T[spell])
		if start and (start + duration - GetTime() < advance) then
			if GetTime() - LastStSh > 1 then
				LastStSh = GetTime()
				StShFlag = true
			end
			DoItNext = spell
			DoItMnRst()
			return
		end
	end

	return

end

function DoItSetHuntMM(donext)
--	DEFAULT_CHAT_FRAME:AddMessage(donext)
	if donext == "none" then
		DoItColorCode(0)
	elseif donext == "Kill Shot" then
		DoItColorCode(1)
	elseif donext == "Chimera Shot" then
		DoItColorCode(2)
	elseif donext == "Serpent Sting" then
		DoItColorCode(3)
	elseif donext == "Arcane Shot" then
		DoItColorCode(4)
	elseif donext == "Aimed Shot" then
		DoItColorCode(5)
	elseif donext == "Steady Shot" then
		DoItColorCode(6)
	elseif donext == "Hunter's Mark" then
		DoItColorCode(7)
	elseif donext == "Mend Pet" then
		DoItColorCode(8)
	elseif donext == "Aspect of the Hawk" then
		DoItColorCode(9)
	elseif donext == "Aspect of the Fox" then
		DoItColorCode(10)
	elseif donext == "Focus dump" then
		DoItColorCode(11)
	end

	return
end



function DoItColorCode(code)
	-- LowHealthFrame:Hide()
	-- LowHealthFrame:SetAlpha(0)
	if code == 0 then
		DoItFrame.t:SetTexture(0,0,0)
	elseif code == 1 then
		DoItFrame.t:SetTexture(0.047,0,0)
	elseif code == 2 then
		DoItFrame.t:SetTexture(0.094,0,0)
	elseif code == 3 then
		DoItFrame.t:SetTexture(0,0.047,0)
	elseif code == 4 then
		DoItFrame.t:SetTexture(0.047,0.047,0)
	elseif code == 5 then
		DoItFrame.t:SetTexture(0.094,0.047,0)
	elseif code == 6 then
		DoItFrame.t:SetTexture(0,0.094,0)
	elseif code == 7 then
		DoItFrame.t:SetTexture(0.047,0.094,0)
	elseif code == 8 then
		DoItFrame.t:SetTexture(0.094,0.094,0)
	elseif code == 9 then
		DoItFrame.t:SetTexture(0,0,0.047)
	elseif code == 10 then
		DoItFrame.t:SetTexture(0.047,0,0.047)
	elseif code == 11 then
		DoItFrame.t:SetTexture(0.094,0,0.047)
	elseif code == 12 then
		DoItFrame.t:SetTexture(0,0.047,0.047)
	elseif code == 13 then
		DoItFrame.t:SetTexture(0.047,0.047,0.047)
	elseif code == 14 then
		DoItFrame.t:SetTexture(0.094,0.047,0.047)
	elseif code == 15 then
		DoItFrame.t:SetTexture(0,0.094,0.047)
	elseif code == 16 then
		DoItFrame.t:SetTexture(0.047,0.094,0.047)

	end

	return
end

function DoItUtlRdy()
	return ((GetTime() - LastUtl) > UtlCD) or ((GetTime() - LastUtl) < UtlTick)
end

function DoItUtlRst()
	if (GetTime() - LastUtl) > 2*UtlTick then
		LastUtl = GetTime()
		LastMn = GetTime()
	end
	return
end

function DoItMnRdy()
	return ((GetTime() - LastMn) > MnCD) or ((GetTime() - LastMn) < UtlTick)
end

function DoItMnRst()
	if (GetTime() - LastMn) > 2*UtlTick then
		LastMn = GetTime()
	end
	return
end



DoItFrame:RegisterEvent("PLAYER_ALIVE");
DoItFrame:RegisterEvent("PLAYER_LOGIN");
DoItFrame:RegisterEvent("PLAYER_TALENT_UPDATE");

local function eventHandler(self, event, ...)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		DoItCombat( ... )
	else
		DiItInit()
	end
	return
end

DoItFrame:SetScript("OnEvent", eventHandler);


