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

			DEFAULT_CHAT_FRAME:AddMessage("DoIt: Arms warrior")
			DoItFrame:SetScript("OnUpdate", 
				function()
					if DoItUpdate then
						DoItPrev=DoItNext
						DoItRecountArms()
						if DoItNext ~= DoItPrev then
							DoItSetArms(DoItNext)
						end
					end
				end
			)

end


T["Rend"] = GetSpellInfo(772)
T["Colossus Smash"] = GetSpellInfo(86346)
T["Mortal Strike"] = GetSpellInfo(12294)
T["Overpower"] = GetSpellInfo(7384)
T["Slam"] = GetSpellInfo(1464)
T["Execute"] = GetSpellInfo(5308)
T["Heroic Strike"] = GetSpellInfo(78)
T["Battle Shout"] = GetSpellInfo(6673)
T["Sunder Armor"] = GetSpellInfo(7386)
T["Pummel"] = GetSpellInfo(6552)
T["Victory Rush"] = GetSpellInfo(34428)
T["Charge"] = GetSpellInfo(100)

T["Battle Trance"] = GetSpellInfo(12964) -- при наличии этого бафа следующий удар требующи5 5+ раги бесплатен. Надо бы его отслеживать для юза героика
T["Incite"] = GetSpellInfo(50685) -- при наличии этого бафа следующий удар героика будет 100% критическим
T["Deadly Calm"] = GetSpellInfo(85730) -- при наличии этого бафа следующие 10 секунд не расходуется ярость и заклинания ярость не требуют
T["Executioner"] = GetSpellInfo(90806)
T["Faerie Fire"] = GetSpellInfo(91565)
T["Expose Armor"] = GetSpellInfo(8647)

function DoItRecountArms()
	local start, duration, usable, norage, OnExec, InMelee, index, enabled
	local SlamOK = false
	local BTOK = false
	local Inc = false
	local DC = false
	
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
		if name == T["Executioner"] and count == 5 and (expire - GetTime()) > 2 then
			ExecOK = true
		elseif name == T["Battle Trance"] then
			BTOK = true
		elseif name == T["Incite"] then
			Inc = true
		elseif name == T["Deadly Calm"] then
			DC = true
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
		if UnitPower("PLAYER") > 70 or BTOK or Inc or DC then
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
	
	if InMelee then
		
		index = 1
		local SunderOK = (UnitLevel("target") ~= -1)
		local RendOK = false
		while UnitDebuff("target", index) do
			local name, _, _, count, _, _, Expires, IsMine = UnitDebuff("target", index)
			if ((not ((name == T["Sunder Armor"]) and ((Expires - GetTime())<5))) and (((name == T["Sunder Armor"]) and count == 3 and ((Expires - GetTime())>5)))) or ((name == T["Faerie Fire"]) and count == 3) or name == T["Expose Armor"] then
				SunderOK = true
			elseif IsMine and IsMine == "player" and name == T["Rend"] and (Expires - GetTime()) > reDoT then
				RendOK = true
			end
			index = index + 1
		end
		
		usable, _ = IsUsableSpell(T["Victory Rush"])
		if usable then
			start, duration = GetSpellCooldown(T["Victory Rush"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Victory Rush"
				return
			end
		end

		usable, _ = IsUsableSpell(T["Sunder Armor"])
		if not SunderOK and usable then
			start, duration = GetSpellCooldown(T["Sunder Armor"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Sunder Armor"
				return
			end
		end

		usable, _ = IsUsableSpell(T["Rend"])
		if not RendOK and usable then
			start, duration = GetSpellCooldown(T["Rend"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Rend"
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
		
		usable, _ = IsUsableSpell(T["Colossus Smash"])
		if usable then
			start, duration = GetSpellCooldown(T["Colossus Smash"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Colossus Smash"
				return
			end
		end
		
		local MSleft = 100
		usable, _ = IsUsableSpell(T["Mortal Strike"])
		if usable then
			start, duration = GetSpellCooldown(T["Mortal Strike"])
			MSleft = start + duration - GetTime()
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Mortal Strike"
				return
			end
		end
		
		usable, _ = IsUsableSpell(T["Overpower"])
		if usable then
			start, duration = GetSpellCooldown(T["Overpower"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Overpower"
				return
			end
		end

		usable, _ = IsUsableSpell(T["Slam"])
		if usable and (MSleft > 3 or (MSleft > 1 and UnitPower("player") >= 35)) then
			start, duration = GetSpellCooldown(T["Slam"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Slam"
				return
			end
		end
    
	end
	
	if not InMelee then
		usable, _ = IsUsableSpell(T["Charge"])
		if usable then
			start, duration = GetSpellCooldown(T["Charge"])
			if start and (start + duration - GetTime() < advance) and (IsSpellInRange(T["Charge"],"TARGET") == 1) then
				DoItNext = "Charge"
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


function DoItSetArms(donext)
	--DEFAULT_CHAT_FRAME:AddMessage(donext)
	if donext == "none" then
		DoItColorCode(0)
	elseif donext == "Rend" then
		DoItColorCode(1)
	elseif donext == "Colossus Smash" then
		DoItColorCode(2)
	elseif donext == "Mortal Strike" then
		DoItColorCode(3)
	elseif donext == "Overpower" then
		DoItColorCode(4)
	elseif donext == "Slam" then
		DoItColorCode(5)
	elseif donext == "Execute" then
		DoItColorCode(6)
	elseif donext == "Heroic Strike" then
		DoItColorCode(7)
	elseif donext == "Battle Shout" then
		DoItColorCode(8)
	elseif donext == "Sunder Armor" then
		DoItColorCode(9)
	elseif donext == "Pummel" then
		DoItColorCode(10)
	elseif donext == "Victory Rush" then
		DoItColorCode(11)
	elseif donext == "Charge" then
		DoItColorCode(12)
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
