-- Constants --
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

-- Frame init --
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
	
	WorldFrame:ClearAllPoints()
	WorldFrame:SetPoint("TOPLEFT", 0, -height)
	WorldFrame:SetPoint("BOTTOMRIGHT", 0, 0)

			DEFAULT_CHAT_FRAME:AddMessage("DoIt: Moonkin")
			DoItFrame:SetScript("OnUpdate", 
				function()
					if DoItUpdate then
						DoItPrev=DoItNext
						DoItRecountBoom()
						if DoItNext ~= DoItPrev then
							DoItSetBoom(DoItNext)
						end
					end
				end
			)
end

T["Insect Swarm"] = GetSpellInfo(5570) -- 100
T["Moonfire"] = GetSpellInfo(8921) -- 100
T["Starsurge"] = GetSpellInfo(78674) -- 100
T["Wrath"] = GetSpellInfo(5176) -- 100
T["Starfire"] = GetSpellInfo(2912) -- 100
T["Innervate"] = GetSpellInfo(29166) -- 100

T["Shooting Stars"] = GetSpellInfo(93400) -- 100
T["Sunfire"] = GetSpellInfo(93402) -- 100
T["Eclipse (Lunar)"] = GetSpellInfo(48518) -- 100
T["Eclipse (Solar)"] = GetSpellInfo(48517) -- 100
T["Nature's Grace"] = GetSpellInfo(61346) -- 100
T["Astral Alignment"] = GetSpellInfo(90164) -- 100

local NextNG = 0
local PrevEcl = 0
local t11 = false

function DoItRecountBoom()
	local start, duration, usable, index
--	local _, _, lag = GetNetStats()
	
	DoItNext = "none"

	if not InCombatLockdown() or UnitCanAttack("player","target") == nil then
		spell = "none"
		t11 = false
		return
	end

--	local precast = min(lag / 1000 , 0.4)

	spell1, _, _, _, _, endTime = UnitCastingInfo("PLAYER")
	if spell1 ~= nil then
		spell = spell1
	end
	if spell1 and ((endTime/1000 - GetTime()) > precast) then
		return
	end
	
	local spellch, _, _, _, startTime, endTime = UnitChannelInfo("PLAYER")
	if spellch and (endTime / 1000 - GetTime() > advance) then
		spell = spellch
		return
	end
	
	if IsSpellInRange(T["Wrath"],"TARGET")~=1 then
		return
	end
	
	if not DoItMnRdy() then
		return
	end
	
	start, duration = GetSpellCooldown(T["Wrath"])
	if start and (start + duration - GetTime() > advance) then
		return
	end

	local IsStill = (GetUnitSpeed("player") == 0)
	
	local Power = UnitPower("player", 8)

	index = 1
	local Moonfire = 0
	local InsectSwarm = 0
	while UnitDebuff("target", index) do
		local name, _, _, count, _, _, DoTExpires, isMine = UnitDebuff("target", index)
		if isMine and isMine == "player" then
			if name == T["Moonfire"] or name == T["Sunfire"] then
				Moonfire = DoTExpires - GetTime()
			elseif name == T["Insect Swarm"] then
				InsectSwarm = DoTExpires - GetTime()
				if NextNG <= DoTExpires - 18 then
					NextNG = DoTExpires + 42
				end
			end
		end
		index = index + 1
	end
	
	index = 1
	local ShOK = false
	local Solar = false
	local Lunar = false
	local NG = false
	local NGExp = 0
	local AstAl = false
	while UnitBuff("PLAYER", index) do
		local name, _, _, count, _, _, Expires = UnitBuff("PLAYER", index)
		if name == T["Shooting Stars"] then
			ShOK = true
		elseif name == T["Eclipse (Solar)"] then
			Solar = true
			if PrevEcl ~= 1 then
				PrevEcl = 1
				if Power == 100 then
					NextNG = GetTime()
				end
			end
		elseif name == T["Eclipse (Lunar)"] then
			Lunar = true
			if PrevEcl ~= -1 then
				PrevEcl = -1
				if Power == -100 then
					NextNG = GetTime()
				end
			end
		elseif name == T["Nature's Grace"] then
			NG = true
--			if NextNG <= Expires - 15 then
--				NextNG = Expires + 45
--			end
			NGExp = Expires
		elseif name == T["Astral Alignment"] then
			AstAl = true
			t11 = true
		end
		index = index + 1
	end

	if NextNG <= NGExp - 15 then
		NextNG = NGExp + 45
	end

	local SoonEclipse = (Power > 80 and not Solar) or (Power < -75 and not Lunar)

	usable, _ = IsUsableSpell(T["Insect Swarm"])
	if usable and (((InsectSwarm < reDoT) and (not SoonEclipse or not IsStill)) or ((NextNG < GetTime()) and not NG and not AstAl) or (SoonEclipse and t11 and (InsectSwarm < 10))) then
		start, duration = GetSpellCooldown(T["Insect Swarm"])
		if start and (start + duration - GetTime() < advance) then
			DoItNext = "Insect Swarm"
			spell = DoItNext
			DoItMnRst()
			return
		end
	end

	usable, _ = IsUsableSpell(T["Moonfire"])
	if usable and (((Moonfire < reDoT) and not SoonEclipse) or (NG and (Moonfire < InsectSwarm)) or (SoonEclipse and t11 and (Moonfire < 10))) and not AstAl then
		start, duration = GetSpellCooldown(T["Moonfire"])
		if start and (start + duration - GetTime() < advance) then
			DoItNext = "Moonfire"
			spell = DoItNext
			DoItMnRst()
			return
		end
	end

	usable, _ = IsUsableSpell(T["Starsurge"])
	if usable and ShOK then
		start, duration = GetSpellCooldown(T["Starsurge"])
		if start and (start + duration - GetTime() < advance) then
			DoItNext = "Starsurge"
			spell = T["Starsurge"]
			DoItMnRst()
			return
		end
	end

	usable, _ = IsUsableSpell(T["Innervate"])
	if usable and UnitPower("player") / UnitPowerMax("player") < 0.15 then
		start, duration = GetSpellCooldown(T["Innervate"])
		if start and (start + duration - GetTime() < advance) then
			if (GetTime() - start < 2) or (start + duration - GetTime() < 0.01) then 
				DoItNext = "Innervate"
				spell = DoItNext
				DoItMnRst()
			end
			return
		end
	end

	usable, _ = IsUsableSpell(T["Moonfire"])
	if usable and not IsStill then
		start, duration = GetSpellCooldown(T["Moonfire"])
		if start and (start + duration - GetTime() < advance) then
			DoItNext = "Moonfire"
			spell = DoItNext
			DoItMnRst()
			return
		end
	end

	usable, _ = IsUsableSpell(T["Starsurge"])
	if usable and spell ~= T["Starsurge"] then
		start, duration = GetSpellCooldown(T["Starsurge"])
		if start and (start + duration - GetTime() < advance) then
			if (GetTime() - start < 2) or (start + duration - GetTime() < 0.01) then 
				DoItNext = "Starsurge"
				DoItMnRst()
			end
			return
		end
	end
	
	if (Power < -87 and spell == T["Wrath"]) or (Power < -85 and spell == T["Starsurge"]) or Lunar or (not Solar and Power >= 0 and (Power <= 80 or spell ~= T["Starfire"]) and (Power <= 85 or spell ~= T["Starsurge"])) then
		usable, _ = IsUsableSpell(T["Starfire"])
		if usable then
			start, duration = GetSpellCooldown(T["Starfire"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Starfire"
				DoItMnRst()
				return
			end
		end
	else
		usable, _ = IsUsableSpell(T["Wrath"])
		if usable then
			start, duration = GetSpellCooldown(T["Wrath"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Wrath"
				DoItMnRst()
				return
			end
		end
	end
		
	return
end

function DoItSetBoom(donext)
--	DEFAULT_CHAT_FRAME:AddMessage("---")
--	DEFAULT_CHAT_FRAME:AddMessage(spell)
--	DEFAULT_CHAT_FRAME:AddMessage(donext)
	if donext == "none" then
		DoItColorCode(0)
	elseif donext == "Insect Swarm" then
		DoItColorCode(1)
	elseif donext == "Moonfire" then
		DoItColorCode(2)
	elseif donext == "Starsurge" then
		DoItColorCode(3)
	elseif donext == "Wrath" then
		DoItColorCode(4)
	elseif donext == "Starfire" then
		DoItColorCode(5)
	elseif donext == "Innervate" then
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
