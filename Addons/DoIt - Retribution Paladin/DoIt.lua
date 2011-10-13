-- DoIt by Basil Uzhanov
-- Paint the square according to the next priority abbility

local DoItUpdate=true
local DoItNext="none"
local DoItPrev
local spell = "none"

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

			DEFAULT_CHAT_FRAME:AddMessage("DoIt: Retripala")
			DoItFrame:SetScript("OnUpdate", 
				function()
					if DoItUpdate then
						DoItPrev=DoItNext
						DoItRecountRetri()
						if DoItNext ~= DoItPrev then
							DoItSetRetri(DoItNext)
						end
					end
				end
			)
end


T["Crusader Strike"] = GetSpellInfo(35395)

T["Judgement"] = GetSpellInfo(20271)
T["Exorcism"] = GetSpellInfo(879)
T["Hammer of Wrath"] = GetSpellInfo(24275)
T["Holy Wrath"] = GetSpellInfo(2812)
T["Consecration"] = GetSpellInfo(26573)

T["Templar's Verdict"] = GetSpellInfo(85256)
T["Divine Storm"] = GetSpellInfo(53385)
T["Inquisition"] = GetSpellInfo(84963)

T["Zealotry"] = GetSpellInfo(85696)


T["Seal of Insight"] = GetSpellInfo(20165)
T["Seal of Justice"] = GetSpellInfo(20164)
T["Seal of Righteousness"] = GetSpellInfo(20154)
T["Seal of Truth"] = GetSpellInfo(31801)
T["Rebuke"] = GetSpellInfo(96231)

T["Censure"] = GetSpellInfo(31803)
T["The Art of War"] = GetSpellInfo(59578)
T["Divine Purpose"] = GetSpellInfo(90174)
T["Avenging Wrath"] = GetSpellInfo(31884)

T["Blessing of Might"] = GetSpellInfo(19740)
T["Unleashed Rage"] = GetSpellInfo(30808)
T["Abomination's Might"] = GetSpellInfo(53138)
T["Trueshot Aura"] = GetSpellInfo(19506)

T["qqqqqqqqqqqqqqqqqqqqqqqqqqqqq"] = GetSpellInfo(47467)

function DoItRecountRetri()
	local start, duration, usable, nomana, index, enabled
	local InMelee = true
	local MightOK = false
	local SealOK = false
	local DivPurp = false
	local ArtOK = false
	local AvWOK = false
	local InqOK = false
	local CensureOK = false
	
	DoItNext = "none"
	if not InCombatLockdown() or UnitCanAttack("player","target") == nil then
		return
	end

	usable, nomana = IsUsableSpell(T["Crusader Strike"])
	if usable or nomana then
		InMelee = (IsSpellInRange(T["Crusader Strike"],"TARGET") == 1)
	end
	
	usable, _ = IsUsableSpell(T["Rebuke"])
	if InMelee and usable then
		local spell, _, _, _, _, endTime, _, _, notinterrupt = UnitCastingInfo("TARGET")
		if spell and not notinterrupt and ((endTime/1000 - GetTime()) > 0.2) then
			start, duration = GetSpellCooldown(T["Rebuke"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Rebuke"
				return
			end
		end

		local spell, _, _, _, _, endTime, _, notinterrupt = UnitChannelInfo("TARGET")
		if spell and not notinterrupt and ((endTime/1000 - GetTime()) > 0.2) then
			start, duration = GetSpellCooldown(T["Rebuke"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Rebuke"
				return
			end
		end
	end
	
	start, duration = GetSpellCooldown(T["Seal of Righteousness"])
	if start and (start + duration - GetTime() > advance) then
		return
	end

	index = 1
	while UnitBuff("PLAYER", index) do
		local name, _, _, _, _, _, expire, IsMine = UnitBuff("PLAYER", index)
		if name == T["The Art of War"] then
			ArtOK = true
		elseif name == T["Blessing of Might"] or name == T["Unleashed Rage"] or name == T["Abomination's Might"] or name == T["Trueshot Aura"] then
			MightOK = true
		elseif name == T["Divine Purpose"] then
			DivPurp = true
		elseif name == T["Seal of Insight"] or name == T["Seal of Justice"] or name == T["Seal of Righteousness"] or name == T["Seal of Truth"] then
			SealOK = true
		elseif name == T["Avenging Wrath"] then
			AvWOK = true
		elseif name == T["Inquisition"] and expire - GetTime() > 5 then
			InqOK = true
		end
		index = index + 1
	end

	index = 1
	while UnitDebuff("TARGET", index) do
		local name, _, _, count, _, _, Expire, IsMine = UnitDebuff("TARGET", index)
		if name == T["Censure"] and count > 0 and IsMine == "player" then
			CensureOK = true
		end
		index = index + 1
	end
	
	usable, _ = IsUsableSpell(T["Seal of Righteousness"])
	if usable and not SealOK then
		start, duration = GetSpellCooldown(T["Seal of Righteousness"])
		if start and (start + duration - GetTime() < advance) then
			DoItNext = "Seal of Righteousness"
			return
		end
	end
	
	if not MightOK then
		start, duration = GetSpellCooldown(T["Blessing of Might"])
		usable, _ = IsUsableSpell(T["Blessing of Might"])
		if start and usable and (start + duration - GetTime() < advance) then
			DoItNext = "Blessing of Might"
			return
		end
	end

	if InMelee and not AvWOK then
		usable, _ = IsUsableSpell(T["Zealotry"])
		if usable then
			start, duration = GetSpellCooldown(T["Zealotry"])
			if start and (start + duration - GetTime() < advance) then
				if (GetTime() - start < 2) or (start + duration - GetTime() < 0.01) then
					DoItNext = "Zealotry"
				end
				return
			end
		end
	end

	usable, _ = IsUsableSpell(T["Inquisition"])
	if InMelee and usable and (UnitPower("player", 9) == 3) and not InqOK then
		start, duration = GetSpellCooldown(T["Inquisition"])
		if start and (start + duration - GetTime() < advance) then
			DoItNext = "Inquisition"
			return
		end
	end

	if InMelee then
		usable, _ = IsUsableSpell(T["Divine Storm"])
		if usable and not CensureOK then
			start, duration = GetSpellCooldown(T["Divine Storm"])
			if start and (start + duration - GetTime() < advance) then
				if (GetTime() - start < 2) or (start + duration - GetTime() < 0.01) then
					DoItNext = "Divine Storm"
				end
				return
			end
		end
	end

	if InMelee then
		usable, _ = IsUsableSpell(T["Crusader Strike"])
		if usable and (UnitPower("player", 9) < 3) then
			start, duration = GetSpellCooldown(T["Crusader Strike"])
			if start and (start + duration - GetTime() < advance) then
				if (GetTime() - start < 2) or (start + duration - GetTime() < 0.01) then
					DoItNext = "Crusader Strike"
				end
				return
			end
		end
	end

	usable, _ = IsUsableSpell(T["Templar's Verdict"])
	if InMelee and usable and (DivPurp or (UnitPower("player", 9) == 3)) then
		start, duration = GetSpellCooldown(T["Templar's Verdict"])
		if start and (start + duration - GetTime() < advance) then
			DoItNext = "Templar's Verdict"
			return
		end
	end
	
	usable, _ = IsUsableSpell(T["Hammer of Wrath"])
	if usable and IsSpellInRange(T["Hammer of Wrath"],"TARGET")==1 then
		start, duration = GetSpellCooldown(T["Hammer of Wrath"])
		if start and (start + duration - GetTime() < advance) then
			if (GetTime() - start < 2) or (start + duration - GetTime() < 0.01) then 
				DoItNext = "Hammer of Wrath"
			end
			return
		end
	end

	usable, _ = IsUsableSpell(T["Exorcism"])
	if ArtOK and usable and IsSpellInRange(T["Exorcism"],"TARGET")==1 then
		start, duration = GetSpellCooldown(T["Exorcism"])
		if start and (start + duration - GetTime() < advance) then
			DoItNext = "Exorcism"
			return
		end
	end
	
	usable, _ = IsUsableSpell(T["Judgement"])
	if usable and IsSpellInRange(T["Judgement"],"TARGET")==1 then
		start, duration = GetSpellCooldown(T["Judgement"])
		if start and (start + duration - GetTime() < advance) then
			if (GetTime() - start < 2) or (start + duration - GetTime() < 0.01) then
				DoItNext = "Judgement"
			end
			return
		end
	end

	if InMelee then
		usable, _ = IsUsableSpell(T["Holy Wrath"])
		if usable then
			start, duration = GetSpellCooldown(T["Holy Wrath"])
			if start and (start + duration - GetTime() < advance) then
				if (GetTime() - start < 2) or (start + duration - GetTime() < 0.01) then
					DoItNext = "Holy Wrath"
				end
				return
			end
		end
	end

	if InMelee then
		usable, _ = IsUsableSpell(T["Consecration"])
		if usable then
			start, duration = GetSpellCooldown(T["Consecration"])
			if start and (start + duration - GetTime() < advance) then
				if (GetTime() - start < 2) or (start + duration - GetTime() < 0.01) then
					DoItNext = "Consecration"
				end
				return
			end
		end
	end
	
	return
end

function DoItSetRetri(donext)
--	DEFAULT_CHAT_FRAME:AddMessage(donext)
	if donext == "none" then
		DoItColorCode(0)
	elseif donext == "Crusader Strike" then
		DoItColorCode(1)
	elseif donext == "Judgement" then
		DoItColorCode(2)
	elseif donext == "Exorcism" then
		DoItColorCode(3)
	elseif donext == "Hammer of Wrath" then
		DoItColorCode(4)
	elseif donext == "Holy Wrath" then
		DoItColorCode(5)
	elseif donext == "Consecration" then
		DoItColorCode(6)
	elseif donext == "Templar's Verdict" then
		DoItColorCode(7)
	elseif donext == "Divine Storm" then
		DoItColorCode(8)
	elseif donext == "Inquisition" then
		DoItColorCode(9)
	elseif donext == "Zealotry" then
		DoItColorCode(10)
	elseif donext == "Blessing of Might" then
		DoItColorCode(11)
	elseif donext == "Seal of Righteousness" then
		DoItColorCode(12)
	elseif donext == "Rebuke" then
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
DoItFrame:SetScript("OnEvent", DiItInit);
