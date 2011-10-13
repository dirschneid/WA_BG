-- DoIt by Basil Uzhanov
-- Paint the square according to the next priority abbility

local DoItUpdate=true
local DoItNext="none"
local DoItPrev
local spell = "none"
local spell1 = "none"
local DoItCombat 

local advance = 0.3
local reDoT = 1.25
local UtlCD = 4
local UtlTick = 0.2
local LastUtl =0
local MnCD = 0.4
local LastMn = 0
local precast = 0.4


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

			DEFAULT_CHAT_FRAME:AddMessage("DoIt: Fury warrior")
			DoItFrame:SetScript("OnUpdate", 
				function()
					if DoItUpdate then
						DoItPrev=DoItNext
						DoItRecountFury()
						if DoItNext ~= DoItPrev then
							DoItSetFury(DoItNext)
						end
					end
				end
			)


end



T["Bloodthirst"] = GetSpellInfo(23881)
T["Raging Blow"] = GetSpellInfo(85288)
T["Slam"] = GetSpellInfo(1464)
T["Battle Shout"] = GetSpellInfo(6673)
T["Sunder Armor"] = GetSpellInfo(7386)
T["Execute"] = GetSpellInfo(5308)
T["Heroic Strike"] = GetSpellInfo(78)
T["Berserker Rage"] = GetSpellInfo(18499)
T["Pummel"] = GetSpellInfo(6552)
T["Intercept"] = GetSpellInfo(20252)
T["Death Wish"] = GetSpellInfo(12292)
T["Colossus Smash"] = GetSpellInfo(86346)
T["Victory Rush"] = GetSpellInfo(34428)

T["Battle Trance"] = GetSpellInfo(12964) -- при наличии этого бафа следующий удар требующи5 5+ раги бесплатен. Надо бы его отслеживать для юза героика
T["Incite"] = GetSpellInfo(50685) -- при наличии этого бафа следующий удар героика будет 100% критическим
T["Bloodsurge"] = GetSpellInfo(46916)
T["Executioner"] = GetSpellInfo(90806)
T["Faerie Fire"] = GetSpellInfo(91565)
T["Expose Armor"] = GetSpellInfo(8647)



function DoItRecountFury()
	local start, duration, usable, norage, OnExec, InMelee, index, enabled
	local SlamOK = false
	local BTOK = false
	local Inc = false
	
	DoItNext = "none"
	if not InCombatLockdown() or UnitCanAttack("player","target") == nil then
		return
	end

	InMelee = (IsSpellInRange(T["Sunder Armor"],"TARGET") == 1)
	
		
	local _, _, _, _, currRank = GetTalentInfo(2,4)
	local ExecOK = (currRank == 0)
	index = 1
	while UnitBuff("PLAYER", index) do
		local name, _, _, count, _, _, expire, IsMine = UnitBuff("PLAYER", index)
		if name == T["Bloodsurge"] then
			SlamOK = true
		elseif name == T["Executioner"] and count == 5  then
			ExecOK = true
		elseif name == T["Battle Trance"] then
			BTOK = true
		elseif name == T["Incite"] then
			Inc = true
		end
		index = index + 1
	end
	
	
	usable, _ = IsUsableSpell(T["Pummel"])
	if InMelee and usable then
		local spell, _, _, _, _, endTime, _, _, notinterrupt = UnitCastingInfo("TARGET")
		if spell and not notinterrupt and ((endTime/1000 - GetTime()) > 0.2) then
			start, duration = GetSpellCooldown(T["Pummel"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Pummel"
				return
			end
		end

		local spell, _, _, _, _, endTime, _, notinterrupt = UnitChannelInfo("TARGET")
		if spell and not notinterrupt and ((endTime/1000 - GetTime()) > 0.2) then
			start, duration = GetSpellCooldown(T["Pummel"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Pummel"
				return
			end
		end
	end

	OnExec, _ = IsUsableSpell(T["Execute"])

	if InMelee then
		if UnitPower("PLAYER") > 90 or BTOK == true or Inc == true then
			if DoItMnRdy() then
				usable, _ = IsUsableSpell(T["Heroic Strike"])
				if usable then
					start, duration = GetSpellCooldown(T["Heroic Strike"])
					if start and (start + duration - GetTime() < advance) then
						DoItNext = "Heroic Strike"
						DoItMnRst()
						return
					end
				end

			end
		end
	end

	start, duration = GetSpellCooldown(T["Sunder Armor"])
	if start and (start + duration - GetTime() > advance) then
		return
	end
	
	if not InMelee then
		usable, _ = IsUsableSpell(T["Intercept"])
		if usable then
			start, duration = GetSpellCooldown(T["Intercept"])
			if start and (start + duration - GetTime() < advance) and (IsSpellInRange(T["Intercept"],"TARGET") == 1) then
				DoItNext = "Intercept"
				return
			end
		end
	end
	
	
	if InMelee then
		
		index = 1
		local SunderOK = (UnitLevel("target") ~= -1)
		while UnitDebuff("target", index) do
			local name, _, _, count, _, _, Expires = UnitDebuff("target", index)
			if ((not ((name == T["Sunder Armor"]) and ((Expires - GetTime())<5))) and (((name == T["Sunder Armor"]) and count == 3 and ((Expires - GetTime())>5)))) or ((name == T["Faerie Fire"]) and count == 3) or name == T["Expose Armor"] then
				SunderOK = true
			end
			index = index + 1
		end

		usable, _ = IsUsableSpell(T["Sunder Armor"])
		if not SunderOK and usable then
			start, duration = GetSpellCooldown(T["Sunder Armor"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Sunder Armor"
				return
			end
		end
 				
		if OnExec and not ExecOK then
			start, duration = GetSpellCooldown(T["Execute"])
			if start and OnExec and (start + duration - GetTime() < advance) and UnitMana("PLAYER")>30 then
				DoItNext = "Execute"
				return
			end
		end
		
--		usable, _ = IsUsableSpell(T["Death Wish"])
--		if usable then
--			start, duration = GetSpellCooldown(T["Death Wish"])
--			if start and (start + duration - GetTime() < advance) then
--				DoItNext = "Death Wish"
--				return
--			end
--		end

		usable, _ = IsUsableSpell(T["Bloodthirst"])
		if usable and not OnExec then
			start, duration = GetSpellCooldown(T["Bloodthirst"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Bloodthirst"
				return
			end
		end
   
		usable, norage = IsUsableSpell(T["Raging Blow"])
		if usable then
			start, duration = GetSpellCooldown(T["Raging Blow"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Raging Blow"
				return
			end
		else
			usable, _ = IsUsableSpell(T["Berserker Rage"])
			if usable and not OnExec and not norage then
				start, duration = GetSpellCooldown(T["Berserker Rage"])
				if start and (start + duration - GetTime() < advance) then
					DoItNext = "Berserker Rage"
					return
				end
			end
		end
		
		usable, _ = IsUsableSpell(T["Victory Rush"])
		if usable then
			start, duration = GetSpellCooldown(T["Victory Rush"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Victory Rush"
				return
			end
		end
		
		usable, _ = IsUsableSpell(T["Colossus Smash"])
		if usable then
			start, duration = GetSpellCooldown(T["Colossus Smash"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Colossus Smash"
				return
			end
		end
				
		if OnExec then
			start, duration = GetSpellCooldown(T["Execute"])
			if start and OnExec and (start + duration - GetTime() < advance) and UnitMana("PLAYER")>30 then
				DoItNext = "Execute"
				return
			end
		end

		usable, _ = IsUsableSpell(T["Slam"])
		if SlamOK and usable then
			start, duration = GetSpellCooldown(T["Slam"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Slam"
				return
			end
		end
    
	end
	
	usable, _ = IsUsableSpell(T["Battle Shout"])
	if usable then
		start, duration = GetSpellCooldown(T["Battle Shout"])
		if start and (start + duration - GetTime() < advance) then
			DoItNext = "Battle Shout"
			return
		end
	end

	return
end

function DoItSetFury(donext)
	--DEFAULT_CHAT_FRAME:AddMessage(donext)
	if donext == "none" then
		DoItColorCode(0)
	elseif donext == "Bloodthirst" then
		DoItColorCode(1)
	elseif donext == "Raging Blow" then
		DoItColorCode(2)
	elseif donext == "Slam" then
		DoItColorCode(3)
	elseif donext == "Battle Shout" then
		DoItColorCode(4)
	elseif donext == "Sunder Armor" then
		DoItColorCode(5)
	elseif donext == "Execute" then
		DoItColorCode(6)
	elseif donext == "Heroic Strike" then
		DoItColorCode(7)
	elseif donext == "Berserker Rage" then
		DoItColorCode(8)
	elseif donext == "Pummel" then
		DoItColorCode(9)
	elseif donext == "Intercept" then
		DoItColorCode(10)
	elseif donext == "Death Wish" then
		DoItColorCode(11)
	elseif donext == "Victory Rush" then
		DoItColorCode(12)
	elseif donext == "Colossus Smash" then
		DoItColorCode(13)
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
