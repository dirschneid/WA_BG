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

			DEFAULT_CHAT_FRAME:AddMessage("DoIt: Feral druid (Cat)")
			DoItFrame:SetScript("OnUpdate", 
				function()
					if DoItUpdate then
						DoItPrev=DoItNext
						DoItRecountFeral()
						if DoItNext ~= DoItPrev then
							DoItSetFeral(DoItNext)
						end
					end
				end
			)
end



T["Savage Roar"] = GetSpellInfo(52610) -- 75
T["Mangle (Cat)"] = 33876 -- 50
T["Rake"] = GetSpellInfo(1822) -- 24
T["Shred"] = GetSpellInfo(5221) -- 22
T["Rip"] = GetSpellInfo(1079) -- 20
T["Tiger's Fury"] = GetSpellInfo(5217) -- 24
T["Ferocious Bite"] = GetSpellInfo(22568) -- 32
T["Berserk"] = GetSpellInfo(50334) -- 60
T["Skull Bash (Cat)"] = 80965 -- 100
T["Ravage"] = 81170 -- 100
T["Faerie Fire (Feral)"] = GetSpellInfo(16857) -- 18


T["Mangle"] = GetSpellInfo(33876) -- 50
T["Trauma"] = GetSpellInfo(46857) -- 35
T["Hemorrhage"] = GetSpellInfo(16511) -- 35
T["Clearcasting"] = GetSpellInfo(16870) -- 10
T["Stampede"] = GetSpellInfo(78893) -- 10
T["Strength of the Panther"] = GetSpellInfo(90166) -- 100
T["Sunder Armor"] = GetSpellInfo(58567) -- 100
T["Expose Armor"] = GetSpellInfo(8647) -- 100
T["Faerie Fire"] = GetSpellInfo(91565) -- 100


function DoItRecountFeral()
	local start, duration, usable, nomana, index, spell
	
	DoItNext = "none"

	if not InCombatLockdown() or UnitCanAttack("player","target") == nil then
		return
	end
	
	if GetShapeshiftForm() == 3 then
	
		usable, _ = IsUsableSpell(T["Skull Bash (Cat)"])
		if usable and IsSpellInRange(GetSpellInfo(T["Skull Bash (Cat)"]),"TARGET") == 1 then
			local spell, _, _, _, _, endTime, _, _, notinterrupt = UnitCastingInfo("TARGET")
			if spell and not notinterrupt and ((endTime/1000 - GetTime()) > 0.1) then
				start, duration = GetSpellCooldown(T["Skull Bash (Cat)"])
				if start and (start + duration - GetTime() < advance) then
					DoItNext = "Skull Bash (Cat)"
					return
				end
			end

			local spell, _, _, _, _, endTime, _, notinterrupt = UnitChannelInfo("TARGET")
			if spell and not notinterrupt and ((endTime/1000 - GetTime()) > 0.1) then
				start, duration = GetSpellCooldown(T["Skull Bash (Cat)"])
				if start and (start + duration - GetTime() < advance) then
					DoItNext = "Skull Bash (Cat)"
					return
				end
			end
		end

		InMelee = IsSpellInRange(T["Rip"],"TARGET") == 1
		
		start, duration = GetSpellCooldown(T["Rip"])
		if not InMelee or (start and (start + duration - GetTime() > advance)) or not DoItMnRdy() then
			return
		end
	
		index = 1
		local SR = 0
		usable, nomana = IsUsableSpell(T["Savage Roar"])
		if not usable and not nomana then
			SR = 50
		end
		local TF = false
		local CC = false
		local Berserk = false
		local Stampede = 0
		local B4T11 = 0
		while UnitBuff("PLAYER", index) do
			local name, _, _, count, _, _, Expire, IsMine = UnitBuff("PLAYER", index)
			if name == T["Savage Roar"] then
				SR = Expire-GetTime()
			elseif name == T["Tiger's Fury"] then
				TF = true
			elseif name == T["Clearcasting"] then
				CC = true
			elseif name == T["Berserk"] then
				Berserk = true
			elseif name == T["Stampede"] then
				Stampede = Expire-GetTime()
			elseif name == T["Strength of the Panther"] then
				if count == 3 then
					B4T11 = Expire-GetTime()
				end
				On4T11 = true
			end
			index = index + 1
		end
		
		index = 1
		local Rip = 0
		local Mangle = 0
		local Rake = 0
		local FF = false
		while UnitDebuff("TARGET", index) do
			local name, _, _, count, _, _, Expire, IsMine = UnitDebuff("TARGET", index)
			if name == T["Mangle"] and IsMine == "player" then
				Test4T11 = true
			end
			if name == T["Mangle"] or name == T["Trauma"] or name == T["Hemorrhage"] then
				Mangle = Expire - GetTime()
			elseif name == T["Rake"] and IsMine == "player" then
				Rake = Expire - GetTime()
			elseif name == T["Rip"] and IsMine == "player" then
				Rip = Expire - GetTime()
			elseif name == T["Expose Armor"] or (count == 3 and (name == T["Sunder Armor"] or name == T["Faerie Fire"])) then
				FF = true
			end
			index = index + 1
		end

		local ToTF = 0
		usable, _ = IsUsableSpell(T["Tiger's Fury"])
		if usable then
			start, duration = GetSpellCooldown(T["Tiger's Fury"])
			if start then
				ToTF = start + duration - GetTime()
				if ToTF < advance and UnitPower("player") <= 26 and not Berserk then
					DoItNext = "Tiger's Fury"
					DoItMnRst()
					return
				end
			end
		end
		
		if (B4T11 < 4 and On4T11) or not Test4T11 then
			usable, _ = IsUsableSpell(T["Mangle (Cat)"])
			if usable then
				start, duration = GetSpellCooldown(T["Mangle (Cat)"])
				if start and (start + duration - GetTime() < advance) then
					DoItNext = "Mangle (Cat)"
					DoItMnRst()
					return
				end
			end
		end

		usable, _ = IsUsableSpell(T["Faerie Fire (Feral)"])
		if usable and not FF then
			start, duration = GetSpellCooldown(T["Faerie Fire (Feral)"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Faerie Fire (Cat)"
				DoItMnRst()
				return
			end
		end
		
		if Mangle < reDoT then
			usable, _ = IsUsableSpell(T["Mangle (Cat)"])
			if usable then
				start, duration = GetSpellCooldown(T["Mangle (Cat)"])
				if start and (start + duration - GetTime() < advance) then
					DoItNext = "Mangle (Cat)"
					DoItMnRst()
					return
				end
			end
		end

		usable, _ = IsUsableSpell(T["Ravage"])
		if usable and Stampede < 2 then
			start, duration = GetSpellCooldown(T["Ravage"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Ravage"
				DoItMnRst()
				return
			end
		end

--		if ToTF > 15 and UnitPower("player") > 80 then
--			usable, _ = IsUsableSpell(T["Berserk"])
--			if usable then
--				start, duration = GetSpellCooldown(T["Berserk"])
--				if start and (start + duration - GetTime() < advance) then
--					DoItNext = "Berserk"
--					DoItMnRst()
--					return
--				end
--			end
--		end

		if Rip > 0.2 and (Rip < reDoT or GetComboPoints("player","target") == 5) and UnitHealth("target") / UnitHealthMax("target") < 0.25 then
			local _, _, _, _, currRank = GetTalentInfo(2, 19)
			usable, _ = IsUsableSpell(T["Ferocious Bite"])
			if usable and currRank == 2 then
				start, duration = GetSpellCooldown(T["Ferocious Bite"])
				if start and (start + duration - GetTime() < advance) then
					DoItNext = "Ferocious Bite"
					DoItMnRst()
					return
				end
			end
		end

		if Rip < 2 then
			usable, _ = IsUsableSpell(T["Rip"])
			if usable and GetComboPoints("player","target") == 5 then
				start, duration = GetSpellCooldown(T["Rip"])
				if start and (start + duration - GetTime() < advance) then
					DoItNext = "Rip"
					DoItMnRst()
					return
				end
			end
		end

		if Rake < 3 or (Rake < 9 and TF) then
			usable, _ = IsUsableSpell(T["Rake"])
			if usable then
				start, duration = GetSpellCooldown(T["Rake"])
				if start and (start + duration - GetTime() < advance) then
					DoItNext = "Rake"
					DoItMnRst()
					return
				end
			end
		end

		if CC then
			usable, _ = IsUsableSpell(T["Shred"])
			if usable then
				start, duration = GetSpellCooldown(T["Shred"])
				if start and (start + duration - GetTime() < advance) then
					DoItNext = "Shred"
					DoItMnRst()
					return
				end
			end
		end

		if SR < 0.5 then
			usable, _ = IsUsableSpell(T["Savage Roar"])
			if usable then
				start, duration = GetSpellCooldown(T["Savage Roar"])
				if start and (start + duration - GetTime() < advance) then
					DoItNext = "Savage Roar"
					DoItMnRst()
					return
				end
			end
		end

		if (abs(SR - Rip) < 3) and Rip < 12 and GetComboPoints("player","target") == 5 then
			usable, _ = IsUsableSpell(T["Savage Roar"])
			if usable then
				start, duration = GetSpellCooldown(T["Savage Roar"])
				if start and (start + duration - GetTime() < advance) then
					DoItNext = "Savage Roar"
					DoItMnRst()
					return
				end
			end
		end

		usable, _ = IsUsableSpell(T["Shred"])
		if usable and (
		(GetComboPoints("player","target") < 5 and Rip > 8 and SR > 8 and (UnitPower("player") > 70 or (UnitPower("player") > 35 and Berserk) or ToTF < 3)) or
		(GetComboPoints("player","target") < 5 and (Rip < 2 or SR < 2)) or
		(Rip == 0) or
		UnitPower("player") > 95
		) then
			start, duration = GetSpellCooldown(T["Shred"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Shred"
				DoItMnRst()
				return
			end
		end

	end
	
	return
end

function DoItSetFeral(donext)
--	DEFAULT_CHAT_FRAME:AddMessage(donext)
	if donext == "none" then
		DoItColorCode(0)
	elseif donext == "Savage Roar" then
		DoItColorCode(1)
	elseif donext == "Mangle (Cat)" then
		DoItColorCode(2)
	elseif donext == "Rake" then
		DoItColorCode(3)
	elseif donext == "Shred" then
		DoItColorCode(4)
	elseif donext == "Rip" then
		DoItColorCode(5)
	elseif donext == "Tiger's Fury" then
		DoItColorCode(6)
	elseif donext == "Ferocious Bite" then
		DoItColorCode(7)
	elseif donext == "Berserk" then
		DoItColorCode(8)
	elseif donext == "Skull Bash (Cat)" then
		DoItColorCode(9)
	elseif donext == "Ravage" then
		DoItColorCode(10)
	elseif donext == "Faerie Fire (Cat)" then
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
DoItFrame:SetScript("OnEvent", DiItInit);
