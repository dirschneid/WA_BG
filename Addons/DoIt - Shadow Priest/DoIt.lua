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
local MnCD = 0.4
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

	-- Shpriest
			DEFAULT_CHAT_FRAME:AddMessage("DoIt: Shadow priest")
			DoItCombat = ShpriestCombat
			DoItFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
			DoItFrame:SetScript("OnUpdate", 
				function()
					if DoItUpdate then
						DoItPrev=DoItNext
						DoItRecountShpriest()
						if DoItNext ~= DoItPrev then
							DoItSetShpriest(DoItNext)
						end
					end
				end
			)
end



T["Vampiric Touch"] = GetSpellInfo(34914)
T["Shadow Word: Pain"] = GetSpellInfo(589)
T["Devouring Plague"] = GetSpellInfo(2944)
T["Shadowfiend"] = GetSpellInfo(34433)
T["Mind Blast"] = GetSpellInfo(8092)
T["Shadow Word: Death"] = GetSpellInfo(32379)
T["Mind Flay"] = GetSpellInfo(15407)
T["Vampiric Embrace"] = GetSpellInfo(15286)
T["Inner Fire"] = GetSpellInfo(588)
T["Power Word: Fortitude"] = GetSpellInfo(21562)
T["Shadow Protection"] = GetSpellInfo(27683)
T["Archangel"] = GetSpellInfo(87151)

T["Shadow Orb"] = GetSpellInfo(77487)
T["Dark Evangelism"] = GetSpellInfo(87118)
T["Pero"] = GetSpellInfo(98764) --XXXX


local NextDP = 0
local DbfTry = 0

function ShpriestCombat( ... )
	local timestamp, type, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags = select(1, ...)
    if (type=="SPELL_MISSED") and (destGUID == UnitGUID("target")) then
		local spellId, spellName, spellSchool, missType = select(9, ...)
		if spellName == T["Devouring Plague"] and missType == "IMMUNE" then
			DbfTry = 10
		end
	end
end

function DoItRecountShpriest()
	DoItNext = "none"

	if not InCombatLockdown() or UnitCanAttack("player","target") == nil then
		spell = "none"
		return
	end

	local start, duration, usable, inrange, index
--	local _, _, lag = GetNetStats()
	
--	local precast = min(lag / 1000 , 0.4)

	local spellch, _, _, _, startTime, endTime = UnitChannelInfo("PLAYER")
--	if spellch and ( select(2, math.modf((GetTime()-startTime/1000)*3000/(endTime-startTime))) > 1000*(advance+MnCD)/(endTime-startTime)) then
	if spellch and (endTime / 1000 - GetTime() > advance) then
		spell = spellch
		return
	end
	if spellch == nil then
		spellch = "none"
	end

	if IsSpellInRange(T["Shadow Word: Pain"],"TARGET")~=1 or not DoItMnRdy() then
		if spell1 ~= nil then
			spell = spell1
		end	
		return
	end

	spell1, _, _, _, _, endTime = UnitCastingInfo("PLAYER")
	if spell1 ~= nil then
		spell = spell1
	end
	if spell1 and ((endTime/1000 - GetTime()) > precast) then
		return
	end

	start, duration = GetSpellCooldown(T["Shadow Word: Pain"])
	if start and (start + duration - GetTime() > advance) then
		return
	end

	local IsStill = (GetUnitSpeed("player") == 0)

	local CUnit = UnitGUID("target")
	if CUnit ~= nil and CUnit ~= PrUnit then
		PrUnit = CUnit
		DbfTry = 0
	end
	
	index = 1
	local VT = 0
	local SWP = 0
	local DP = 0
	while UnitDebuff("target", index) do
		local name, _, _, count, _, _, DoTExpires, isMine = UnitDebuff("target", index)
		if isMine and isMine == "player" then
			if name == T["Vampiric Touch"] then
				VT = DoTExpires - GetTime()
			elseif name == T["Shadow Word: Pain"] then
				SWP = DoTExpires - GetTime()
			elseif name == T["Devouring Plague"] then
				DP = DoTExpires - GetTime()
				NextDP = DoTExpires
				DbfTry = 0
			end
		end
		index = index + 1
	end
	
	index = 1
	local InF = false
	local VE = false
	local PWF = false
	local ShPr = false
	local ShOrb = false
	local Ev = false
	while UnitBuff("PLAYER", index) do
		local name, _, _, count = UnitBuff("PLAYER", index)
		if name == T["Inner Fire"] then
			InF = true
		elseif name == T["Vampiric Embrace"] then
			VE = true
		elseif name == T["Power Word: Fortitude"] then
			PWF = true
		elseif name == T["Shadow Protection"] then
			ShPr = true
		elseif name == T["Shadow Orb"] then
			ShOrb = true
		elseif name == T["Dark Evangelism"] and count == 5 then
			Ev = true
		elseif name == T["Pero"] then
			IsStill = true
		end
		index = index + 1
	end

	if SWP < reDoT then
		usable, _ = IsUsableSpell(T["Shadow Word: Pain"])
		if usable then
			start, duration = GetSpellCooldown(T["Shadow Word: Pain"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Shadow Word: Pain"
				spell1 = DoItNext
				DoItMnRst()
				return
			end
		end
	end
	
	usable, _ = IsUsableSpell(T["Mind Blast"])
	if usable and ShOrb then
		if IsStill and spell ~= T["Mind Blast"] then
			start, duration = GetSpellCooldown(T["Mind Blast"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Mind Blast"
				DoItMnRst()
				return
			end
		end
	end

	if DbfTry < 2 and NextDP - GetTime() < reDoT then
		usable, _ = IsUsableSpell(T["Devouring Plague"])
		if usable then
			start, duration = GetSpellCooldown(T["Devouring Plague"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Devouring Plague"
				spell1 = DoItNext
				DoItMnRst()
				return
			end
		end
	end
	
	usable, _ = IsUsableSpell(T["Vampiric Touch"])
	local castTime = 0
	if usable then
		_, _, _, _, _, _, castTime, _, _ = GetSpellInfo(T["Vampiric Touch"])
		if IsStill and VT < (castTime / 1000 + reDoT) and spell ~= T["Vampiric Touch"] then
			start, duration = GetSpellCooldown(T["Vampiric Touch"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Vampiric Touch"
				DoItMnRst()
				return
			end
		end
	end
	
	usable, _ = IsUsableSpell(T["Mind Blast"])
	if usable then
		if IsStill and spell ~= T["Mind Blast"] then
			start, duration = GetSpellCooldown(T["Mind Blast"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Mind Blast"
				DoItMnRst()
				return
			end
		end
	end

	if (UnitHealth("player") / UnitHealthMax("player") > 0.5) and ((UnitHealth("target") / UnitHealthMax("target") < 0.25) or not IsStill) then
		usable, _ = IsUsableSpell(T["Shadow Word: Death"])
		if usable then
			start, duration = GetSpellCooldown(T["Shadow Word: Death"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Shadow Word: Death"
				spell1 = DoItNext
				DoItMnRst()
				return
			end
		end
	end
	
	usable, _ = IsUsableSpell(T["Archangel"])
	if usable and Ev and SWP > 15 and DP > 18 then
		if IsStill and spell ~= T["Archangel"] then
			start, duration = GetSpellCooldown(T["Archangel"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Archangel"
				DoItMnRst()
				return
			end
		end
	end
	
	usable, _ = IsUsableSpell(T["Shadowfiend"])
	if usable then
		start, duration = GetSpellCooldown(T["Shadowfiend"])
		if start and (start + duration - GetTime() < advance) then
			DoItNext = "Shadowfiend"
			spell1 = DoItNext
			DoItMnRst()
			return
		end
	end

	if DoItUtlRdy() then
		if not InF then
			usable, _ = IsUsableSpell(T["Inner Fire"])
			if usable then
				start, duration = GetSpellCooldown(T["Inner Fire"])
				if start and (start + duration - GetTime() < advance) then
					DoItNext = "Inner Fire"
					spell1 = DoItNext
					DoItUtlRst()
					return
				end
			end
		end

		if not VE then
			usable, _ = IsUsableSpell(T["Vampiric Embrace"])
			if usable then
				start, duration = GetSpellCooldown(T["Vampiric Embrace"])
				if start and (start + duration - GetTime() < advance) then
					DoItNext = "Vampiric Embrace"
					spell1 = DoItNext
					DoItUtlRst()
					return
				end
			end
		end
		
		if not PWF then
			usable, _ = IsUsableSpell(T["Power Word: Fortitude"])
			if usable then
				start, duration = GetSpellCooldown(T["Power Word: Fortitude"])
				if start and (start + duration - GetTime() < advance) then
					DoItNext = "Power Word: Fortitude"
					spell1 = DoItNext
					DoItUtlRst()
					return
				end
			end
		end

		if not ShPr then
			usable, _ = IsUsableSpell(T["Shadow Protection"])
			if usable then
				start, duration = GetSpellCooldown(T["Shadow Protection"])
				if start and (start + duration - GetTime() < advance) then
					DoItNext = "Shadow Protection"
					spell1 = DoItNext
					DoItUtlRst()
					return
				end
			end
		end

		-- if not PWS and (UnitHealth("player") / UnitHealthMax("player") < 0.9) then
			-- start, duration = GetSpellCooldown(T["Power Word: Shield"])
			-- usable, _ = IsUsableSpell(T["Power Word: Shield"])
			-- if start and usable and (start + duration - GetTime() < advance) then
				-- DoItNext = "Power Word: Shield"
				-- spell1 = DoItNext
				-- DoItUtlRst()
				-- return
			-- end
		-- end

	end
		
	start, duration = GetSpellCooldown(T["Mind Flay"])
	usable, _ = IsUsableSpell(T["Mind Flay"])
	if IsStill and IsSpellInRange(T["Mind Flay"], "target") == 1 and start and usable and (start + duration - GetTime() < advance) then
		DoItNext = "Mind Flay"
		spell1 = DoItNext
		DoItMnRst()
		return
	end
	
	return
end

function DoItSetShpriest(donext)
--	DEFAULT_CHAT_FRAME:AddMessage(donext)
	if donext == "none" then
		DoItColorCode(0)
	elseif donext == "Vampiric Touch" then
		DoItColorCode(1)
	elseif donext == "Shadow Word: Pain" then
		DoItColorCode(2)
	elseif donext == "Devouring Plague" then
		DoItColorCode(3)
	elseif donext == "Shadowfiend" then
		DoItColorCode(4)
	elseif donext == "Mind Blast" then
		DoItColorCode(5)
	elseif donext == "Shadow Word: Death" then
		DoItColorCode(6)
	elseif donext == "Mind Flay" then
		DoItColorCode(7)
	elseif donext == "Vampiric Embrace" then
		DoItColorCode(8)
	elseif donext == "Inner Fire" then
		DoItColorCode(9)
	elseif donext == "Power Word: Fortitude" then
		DoItColorCode(10)
	elseif donext == "Shadow Protection" then
		DoItColorCode(11)
	elseif donext == "Archangel" then
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


