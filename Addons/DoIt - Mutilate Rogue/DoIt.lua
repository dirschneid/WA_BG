-- DoIt by Basil Uzhanov
-- Paint the square according to the next priority abbility

local DoItUpdate=true
local DoItNext="none"
local DoItPrev
local spell = "none"
local spell1 = "none"
local DoItCombat 

local advance = 0.02
local reDoT = 1.25
local UtlCD = 4
local UtlTick = 0.2
local LastUtl =0
local MnCD = 0.6
local LastMn = 0
local precast = 0.5

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

			DEFAULT_CHAT_FRAME:AddMessage("DoIt: Muti Rogue")
			DoItFrame:SetScript("OnUpdate", 
				function()
					if DoItUpdate then
						DoItPrev=DoItNext
						DoItRecountMuti()
						if DoItNext ~= DoItPrev then
							DoItSetMuti(DoItNext)
						end
					end
				end
			)
end



T["Mutilate"] = GetSpellInfo(1329) -- 50
T["Backstab"] = GetSpellInfo(53) -- 100
T["Slice and Dice"] = GetSpellInfo(5171) -- 10
T["Rupture"] = GetSpellInfo(1943) -- 100
T["Envenom"] = GetSpellInfo(32645) -- 1
T["Kick"] = GetSpellInfo(1766) -- 12


T["Eviscerate"] = GetSpellInfo(2098) -- 1



function DoItRecountMuti()
	local start, duration, usable, nomana, index, spell
	
	DoItNext = "none"

	if not InCombatLockdown() or UnitCanAttack("player","target") == nil then
		return
	end


	InMelee = IsSpellInRange(T["Mutilate"],"TARGET") == 1
	usable, _ = IsUsableSpell(T["Kick"])

	if InMelee and usable then
		local spell, _, _, _, _, endTime, _, _, notinterrupt = UnitCastingInfo("TARGET")
		if spell and not notinterrupt and ((endTime/1000 - GetTime()) > 0.2) then
			start, duration = GetSpellCooldown(T["Kick"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Kick"
				return
			end
		end

		local spell, _, _, _, _, endTime, _, notinterrupt = UnitChannelInfo("TARGET")
		if spell and not notinterrupt and ((endTime/1000 - GetTime()) > 0.2) then
			start, duration = GetSpellCooldown(T["Kick"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Kick"
				return
			end
		end
	end
	
	index = 1
	local SnD = false
	while UnitBuff("PLAYER", index) do
		local name, _, _, _, _, _, Expire, IsMine = UnitBuff("PLAYER", index)
		if name == T["Slice and Dice"] and (Expire-GetTime() > 2) then
			SnD = true
		end
		index = index + 1
	end
	
	index = 1
	local Rupt = false
	while UnitDebuff("TARGET", index) do
		local name, _, _, _, _, _, Expire, IsMine = UnitDebuff("TARGET", index)
		if name == T["Rupture"] and IsMine == "player" then
			Rupt = true
		end
		index = index + 1
	end
	
	start, duration = GetSpellCooldown(T["Mutilate"])
	if start and (start + duration - GetTime() > advance) then
		return
	end
	
	if not InMelee or not DoItMnRdy() then
		return
	end

	local _, _, _, _, currRank = GetTalentInfo(1,13)
	local OnBS = (currRank == 2 and (UnitHealth("target") / UnitHealthMax("target") < 0.35))
	
	if not Rupt and GetComboPoints("player","target") > 0 then
		usable, _ = IsUsableSpell(T["Rupture"])
		if usable then
			start, duration = GetSpellCooldown(T["Rupture"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Rupture"
				return
			end
		end
	end

	if not SnD then
		usable, _ = IsUsableSpell(T["Slice and Dice"])
		if usable then
			start, duration = GetSpellCooldown(T["Slice and Dice"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Slice and Dice"
				return
			end
		end
	end

	spell = "Eviscerate"
	usable, _ = IsUsableSpell(T[spell])
	if usable and (GetComboPoints("player","target") > 3 or (OnBS and GetComboPoints("player","target") > 4)) then
		start, duration = GetSpellCooldown(T[spell])
		if start and (start + duration - GetTime() < advance) then
			DoItNext = spell
			return
		end
	end

	spell = "Backstab"
	usable, _ = IsUsableSpell(T[spell])
	local _, _, _, _, currRank = GetTalentInfo(1,13)
	if usable and OnBS then
		start, duration = GetSpellCooldown(T[spell])
		if start and (start + duration - GetTime() < advance) then
			DoItNext = spell
			return
		end
	end

	spell = "Mutilate"
	usable, _ = IsUsableSpell(T[spell])
	if usable and not OnBS then
		start, duration = GetSpellCooldown(T[spell])
		if start and (start + duration - GetTime() < advance) then
			DoItNext = spell
			return
		end
	end

	return
end

function DoItSetMuti(donext)
--	DEFAULT_CHAT_FRAME:AddMessage(donext)
	if donext == "none" then
		DoItColorCode(0)
	elseif donext == "Mutilate" then
		DoItColorCode(1)
	elseif donext == "Backstab" then
		DoItColorCode(2)
	elseif donext == "Slice and Dice" then
		DoItColorCode(3)
	elseif donext == "Rupture" then
		DoItColorCode(4)
	elseif donext == "Eviscerate" then
		DoItColorCode(5)
	elseif donext == "Kick" then
		DoItColorCode(6)
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
DoItFrame:SetScript("OnEvent", DiItInit);
