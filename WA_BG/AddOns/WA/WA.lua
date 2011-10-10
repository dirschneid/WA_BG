local jbqxekIXgR = 0;
local zoneCodename = nil;
local XPthvfnIFcXcb = nil;
local TikKsaVP = 0;
local dqNjjulBKOr = 0;
local KWRdJTfvJehHPcl = 0;
local buLcnXnhwDEfRM = 0;
local KBjFswjP = 0;
local ndTerKXMSx = 0;
local DwWvrLQQMMLLNmN = 0;
local XXMxUoOLgdsJV = 0;
local hOuyAKHyDiBpp = 0;
local eLbMsxnvm = 0;
local vzOGpOEysfFrF = 0;
local sfRkybniBU = 1;
local gizxlVfnynAPUfxK;
local KbsfPRmHKiuPi = 0;
local IsInBg = 0;
local CWpwajXJnFs = -1;
local mCASochVq = 0;
local ajwHmsnVIDwnCf = 0;
local rGPqjvTSBkM = 0;
WA.BgBegun = 0;
local zoneNr = 0;
local UtkknUXUM = 0;

local gpRsywncE = nil;
local colorCodeName = nil;

if (_autojoin == nil) then
	_autojoin = 0;
	_forcejoin = 0;
	_autosignup = 0;
	_autorelease = 0;
	_autoleave = 0;
	_tell = 0;
	chatChannel = 0;
	_sound = 0;
	_screenshot = 0;
	CKylqTuCxB = 0;
	eTRAhmqsVzyokKN = 0;
	_soundonhighlight = 0;
	QXcHLxfvnJC = 0;
	cvar_autoLootDefault = GetCVar("autoLootDefault");
	cvar_autoSelfCast = GetCVar("autoSelfCast");
end
if (_soundonemote == nil) then
	_soundonemote = 0;
end
function WA_OnLoad(self)

	self:RegisterEvent("VARIABLES_LOADED");
	self:RegisterEvent("CHAT_MSG_YELL");
	self:RegisterEvent("CHAT_MSG_RAID");
	self:RegisterEvent("CHAT_MSG_PARTY");
	self:RegisterEvent("GMSURVEY_DISPLAY");
	self:RegisterEvent("PARTY_INVITE_REQUEST");
	self:RegisterEvent("MERCHANT_SHOW");
	self:RegisterEvent("DUEL_REQUESTED");
	self:RegisterEvent("CHAT_MSG_GUILD");
	self:RegisterEvent("CHAT_MSG_BATTLEGROUND");
	self:RegisterEvent("CHAT_MSG_CHANNEL");
	self:RegisterEvent("CHAT_MSG_SAY");
	self:RegisterEvent("CHAT_MSG_WHISPER");
	self:RegisterEvent("CHAT_MSG_EMOTE");
	self:RegisterEvent("CHAT_MSG_TEXT_EMOTE");
	self:RegisterEvent("UNIT_AURA");
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	self:RegisterEvent("BATTLEFIELDS_SHOW");
	self:RegisterEvent("PLAYER_DEAD");
	self:RegisterEvent("PLAYER_UNGHOST");
	self:RegisterEvent("PLAYER_ALIVE");
	self:RegisterEvent("UPDATE_BATTLEFIELD_STATUS");
	self:RegisterEvent("LOOT_BIND_CONFIRM");
	self:RegisterEvent("LOOT_CLOSED");
	self:RegisterEvent("PLAYER_ENTERING_BATTLEGROUND");
	self:RegisterEvent("PLAYER_LEAVING_WORLD");
	self:RegisterEvent("CHAT_MSG_BN_WHISPER");
	self:RegisterEvent("CHAT_MSG_BATTLEGROUND_LEADER");
	NPJebBwFCiiRwfKd();
end


function DGPTEgvKTxrOCod(arg1)
	local _, _, cmd, args = string.find(arg1, "(%w+)%s?(.*)");
	if(cmd) then
		gizxlVfnynAPUfxK = arg1;
		cmd = strlower(cmd);
	else
		cmd = "";
	end


	if(cmd == "autosignup" or cmd == "signup") then
		if (_autosignup == 0) then 
			_autosignup =1;
			DEFAULT_CHAT_FRAME:AddMessage("<Auto signup now ON>", 0, 0.7, 1);
		elseif (_autosignup == 1) then 
			_autosignup =0;
			DEFAULT_CHAT_FRAME:AddMessage("<Auto signup now OFF>", 0, 0.7, 1);
		end

	elseif(cmd == "autojoin" or cmd == "join") then
		if (_autojoin == 0) then 
			_autojoin = 1;
			DEFAULT_CHAT_FRAME:AddMessage("<Auto join bg now ON>", 0, 0.7, 1);
		elseif (_autojoin == 1) then 
			_autojoin = 0;
			DEFAULT_CHAT_FRAME:AddMessage("<Auto join bg now OFF>", 0, 0.7, 1);
		end

	elseif(cmd == "forcejoin") then
		if (_forcejoin == 0) then 
			_forcejoin = 1;
			DEFAULT_CHAT_FRAME:AddMessage("<Force bg join now ON>", 0, 0.7, 1);
		elseif (_forcejoin == 1) then 
			_forcejoin = 0;
			DEFAULT_CHAT_FRAME:AddMessage("<Force bg join now OFF>", 0, 0.7, 1);
		end

	elseif(cmd == "autorelease" or cmd == "release") then
		if (_autorelease == 0) then 
			_autorelease =1;
			DEFAULT_CHAT_FRAME:AddMessage("<Auto release spirit now ON>", 0, 0.7, 1);
		elseif (_autorelease == 1) then 
			_autorelease =0;
			DEFAULT_CHAT_FRAME:AddMessage("<Auto release spirit now OFF>", 0, 0.7, 1);
		end

	elseif(cmd == "autoleave" or cmd == "leave") then
		if (_autoleave == 0) then 
			_autoleave =1;
			DEFAULT_CHAT_FRAME:AddMessage("<Auto leave bg now ON>", 0, 0.7, 1);
		elseif (_autoleave == 1) then 
			_autoleave =0;
			DEFAULT_CHAT_FRAME:AddMessage("<Auto leave bg now OFF>", 0, 0.7, 1);
		end

	elseif(cmd == "sound" or cmd == "sounds") then
		if (_sound == 0) then 
			_sound =1;
			DEFAULT_CHAT_FRAME:AddMessage("<Sounds ON>", 0, 0.7, 1);
		elseif (_sound == 1) then 
			_sound =0;
			DEFAULT_CHAT_FRAME:AddMessage("<Sounds OFF>", 0, 0.7, 1);
		end

	elseif(cmd == "soundonemote") then
		if (_soundonemote == 0) then 
			_soundonemote = 1;
			DEFAULT_CHAT_FRAME:AddMessage("<Sound on emotes to you ON>", 0, 0.7, 1);
		elseif (_soundonemote == 1) then 
			_soundonemote = 0;
			DEFAULT_CHAT_FRAME:AddMessage("<Sound on emotes to you OFF>", 0, 0.7, 1);
		end

	elseif(cmd == "soundonhighlight") then
		if (_soundonhighlight == 0) then 
			_soundonhighlight = 1;
			DEFAULT_CHAT_FRAME:AddMessage("<Sound on player highlight ON>", 0, 0.7, 1);
		elseif (_soundonhighlight == 1) then 
			_soundonhighlight = 0;
			DEFAULT_CHAT_FRAME:AddMessage("<Sound on player highlight OFF>", 0, 0.7, 1);
		end

	elseif(cmd == "screenshot" or cmd == "screenshots") then
		if (_screenshot == 0) then 
			_screenshot =1;
			DEFAULT_CHAT_FRAME:AddMessage("<Take screenshot on whisper/afk debuff/highlight ON>", 0, 0.7, 1);
		elseif (_screenshot == 1) then 
			_screenshot =0;
			DEFAULT_CHAT_FRAME:AddMessage("<Take screenshot on whisper/afk debuff/highlight OFF>", 0, 0.7, 1);
		end

	elseif(cmd == "tell") then
		if (_tell == 0) then 
			_tell =1;
			DEFAULT_CHAT_FRAME:AddMessage("<Tell an other char info now ON>", 0, 0.7, 1);
			DEFAULT_CHAT_FRAME:AddMessage("Set the Playername who u want to whisper. Use /wa nickname e.g /wa Pirox", 0, 0.7, 1);
		    if (chatChannel ~= 0) then 
			    DEFAULT_CHAT_FRAME:AddMessage("WhisperName is at the moment: " .. chatChannel, 0, 0.7, 1);
		    end
		elseif (_tell == 1) then 
			_tell =0;
			DEFAULT_CHAT_FRAME:AddMessage("<Tell an other char info now OFF>", 0, 0.7, 1);
		end

	elseif(cmd == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("<WA v7.4>", 0, 0.7, 1);
		DEFAULT_CHAT_FRAME:AddMessage("    /wa  (status)", 0, 0.7, 1);
		DEFAULT_CHAT_FRAME:AddMessage("    /wa on/off  (show/hide squares)", 0, 0.7, 1);
		DEFAULT_CHAT_FRAME:AddMessage("    /wa ontop  (show squares on top of wow)", 0, 0.7, 1);
		DEFAULT_CHAT_FRAME:AddMessage("  - - - - - - - ", 0, 0.7, 1);
		DEFAULT_CHAT_FRAME:AddMessage("    /wa release  (auto release corpse)", 0, 0.7, 1);
		DEFAULT_CHAT_FRAME:AddMessage("    /wa leave  (auto leave the bg if finished)", 0, 0.7, 1);
		DEFAULT_CHAT_FRAME:AddMessage("    /wa quests  (list all quests and get the quest id", 0, 0.7, 1);
		DEFAULT_CHAT_FRAME:AddMessage("    /wa sound  (play sound on whisper/bgover/afkdebuff)", 0, 0.7, 1);
		DEFAULT_CHAT_FRAME:AddMessage("    /wa soundonhighlight  (play sound on player highlight)", 0, 0.7, 1);
		DEFAULT_CHAT_FRAME:AddMessage("    /wa soundonemote  (play sound on emotes to you)", 0, 0.7, 1);
		DEFAULT_CHAT_FRAME:AddMessage("    /wa screenshot  (take screen on whisper/afkdebuff/highlight)", 0, 0.7, 1);
		DEFAULT_CHAT_FRAME:AddMessage("    /wa tell  (whisper another player your incoming whisper)", 0, 0.7, 1);
		DEFAULT_CHAT_FRAME:AddMessage("    /wa signup  (auto signup for rated arena only)", 0, 0.7, 1);
		DEFAULT_CHAT_FRAME:AddMessage("    /wa honor (show total honor and honor made this login)", 0, 0.7, 1);

	elseif(cmd == "ontop") then
		if (WAMainFrame:IsVisible() and RightSquare2:IsVisible()) then
			DEFAULT_CHAT_FRAME:AddMessage("<Squares onTop are already on>", 0, 0.7, 1);
		else
			WAMainFrame:Show();
			LeftSquare2:Show();
			RightSquare2:Show();
			RightSquare:Hide();
			LeftSquare:Hide();

			if CKylqTuCxB == 0 then
				DEFAULT_CHAT_FRAME:AddMessage("<Squares onTop shown - Vars set>", 0, 0.7, 1);
			elseif CKylqTuCxB == 1 then
				DEFAULT_CHAT_FRAME:AddMessage("<Squares moved to Top>", 0, 0.7, 1);
			end

			SetCVar("autoLootDefault", 1);
			SetCVar("autoSelfCast", 1);
			CKylqTuCxB = 2;
			eTRAhmqsVzyokKN = 0;
		end
		NPJebBwFCiiRwfKd();
	elseif(cmd == "on") then
		if (WAMainFrame:IsVisible() and RightSquare:IsVisible()) then
			DEFAULT_CHAT_FRAME:AddMessage("<Squares onBottom are already on>", 0, 0.7, 1);
		else
			WAMainFrame:Show();
			LeftSquare:Show();
			RightSquare:Show();
			RightSquare2:Hide();
			LeftSquare2:Hide();

			if CKylqTuCxB == 0 then
				DEFAULT_CHAT_FRAME:AddMessage("<Squares onBottom shown - Vars set>", 0, 0.7, 1);
			elseif CKylqTuCxB == 2 then
				DEFAULT_CHAT_FRAME:AddMessage("<Squares moved to Bottom>", 0, 0.7, 1);
			end

			SetCVar("autoLootDefault", 1);
			SetCVar("autoSelfCast", 1);
			CKylqTuCxB = 1;
			eTRAhmqsVzyokKN = 0;
		end
		NPJebBwFCiiRwfKd();
	elseif(cmd == "off") then
		if (WAMainFrame:IsVisible()) then
			WAMainFrame:Hide();
			DEFAULT_CHAT_FRAME:AddMessage("<Squares hidden>", 0, 0.7, 1);
	
			CKylqTuCxB = 0;
		else
			DEFAULT_CHAT_FRAME:AddMessage("<Squares are already off>", 0, 0.7, 1);
		end

	elseif(cmd == "honor") then
		if CWpwajXJnFs == -1 then
			CWpwajXJnFs = select(2,GetCurrencyInfo(392))
		end
		DEFAULT_CHAT_FRAME:AddMessage("Honor made - Session: " .. (select(2,GetCurrencyInfo(392))-CWpwajXJnFs) .. "  Total: " .. QXcHLxfvnJC, 0, 0.7, 1);

	elseif(cmd == "quests" or cmd == "quest") then

		local i=1
		while (GetQuestLogTitle(i) ~= nil) do
		   local questTitle, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily = GetQuestLogTitle(i)
		   if isHeader ~= 1 then
		      local questLink = GetQuestLink(i)
		      local quest, questId, questRest = strsplit(":", questLink, 3)
		      DEFAULT_CHAT_FRAME:AddMessage("[".. questId .."] ".. questTitle,0,0.7,1)
		   end
		   i = i + 1
		end

	elseif(cmd == "") then

		DEFAULT_CHAT_FRAME:AddMessage("<WA v7.4>", 0, 0.7, 1);

		if (_autosignup == 1) then 
			DEFAULT_CHAT_FRAME:AddMessage(" - Auto arena signup : ON", 0, 0.7, 1);
		elseif (_autosignup == 0) then 
			DEFAULT_CHAT_FRAME:AddMessage(" - Auto Arena signup : OFF", 0, 0.7, 1);
		end

		if (_autorelease == 1) then 
			DEFAULT_CHAT_FRAME:AddMessage(" - Auto release spirit : ON", 0, 0.7, 1);
		elseif (_autorelease == 0) then 
			DEFAULT_CHAT_FRAME:AddMessage(" - Auto release spirit : OFF", 0, 0.7, 1);
		end

		if (_autoleave == 1) then 
			DEFAULT_CHAT_FRAME:AddMessage(" - Auto leave bg : ON", 0, 0.7, 1);
		elseif (_autoleave == 0) then 
			DEFAULT_CHAT_FRAME:AddMessage(" - Auto leave bg : OFF ", 0, 0.7, 1);
		end

		if (_sound == 1) then 
			DEFAULT_CHAT_FRAME:AddMessage(" - Sound on whisper/bgover/afkdebuff : ON", 0, 0.7, 1);
		elseif (_sound == 0) then 
			DEFAULT_CHAT_FRAME:AddMessage(" - Sound on whisper/bgover/afkdebuff : OFF", 0, 0.7, 1);
		end

		if (_soundonhighlight == 1) then 
			DEFAULT_CHAT_FRAME:AddMessage(" - Sound on player highlight : ON", 0, 0.7, 1);
		elseif (_soundonhighlight == 0) then 
			DEFAULT_CHAT_FRAME:AddMessage(" - Sound on player highlight : OFF", 0, 0.7, 1);
		end

		if (_soundonemote == 1) then 
			DEFAULT_CHAT_FRAME:AddMessage(" - Sound on emotes to you : ON", 0, 0.7, 1);
		elseif (_soundonemote == 0) then 
			DEFAULT_CHAT_FRAME:AddMessage(" - Sound on emotes to you : OFF", 0, 0.7, 1);
		end

		if (_screenshot == 1) then 
			DEFAULT_CHAT_FRAME:AddMessage(" - Take screenshot on whisper/afkdebuff : ON", 0, 0.7, 1);
		elseif (_screenshot == 0) then 
			DEFAULT_CHAT_FRAME:AddMessage(" - Take screenshot on whisper/afkdebuff : OFF", 0, 0.7, 1);
		end

		if (_tell == 1) then 
			DEFAULT_CHAT_FRAME:AddMessage(" - Tell other char infos : ON", 0, 0.7, 1);
		elseif (_tell == 0) then 
			DEFAULT_CHAT_FRAME:AddMessage(" - Tell other char infos : OFF", 0, 0.7, 1);
		end

	else
	    if (_tell == 1) then
	        chatChannel = strlower(gizxlVfnynAPUfxK);
	        DEFAULT_CHAT_FRAME:AddMessage("<WA> ".. chatChannel .." set as response name", 0, 0.7, 1);
	    end
		DEFAULT_CHAT_FRAME:AddMessage("<WA> Type '/wa help' for a commandlist and '/wa' for status.", 0, 0.7, 1);
	end


end


function WA_OnEvent(self,event,arg1,arg2,arg3,arg4,arg5,arg6)

      if (event == "VARIABLES_LOADED") then
			SlashCmdList["WA"]=DGPTEgvKTxrOCod;
			SLASH_WA1="/wa";
			if CKylqTuCxB == 1 then
				WAMainFrame:Show();
				LeftSquare:Show();
				RightSquare:Show();
				RightSquare2:Hide();
				LeftSquare2:Hide();
				eTRAhmqsVzyokKN = 0;
			elseif CKylqTuCxB == 2 then
				WAMainFrame:Show();
				LeftSquare2:Show();
				RightSquare2:Show();
				RightSquare:Hide();
				LeftSquare:Hide();
				eTRAhmqsVzyokKN = 0;
			else
				if eTRAhmqsVzyokKN == 1 then
					WAMainFrame:Show();
					RightSquare2:Hide();
					LeftSquare2:Hide();
					RightSquare:Hide();
					LeftSquare:Show();
				else
					if(WAMainFrame:IsVisible()) then
						WAMainFrame:Hide();
					end
				end
			end
			LeftSquare:SetTexture(1,1,1); --white
			LeftSquare2:SetTexture(1,1,1); --white

      elseif (event == "MERCHANT_SHOW") then
        if WAMainFrame:IsVisible() then
      	   if CanMerchantRepair() == 1 then
      	      repairAllCost, canRepair = GetRepairAllCost();
      	      if repairAllCost > 0 then
      	         if canRepair == 1 then
      	            RepairAllItems();
      	            valC = repairAllCost%100;
      	            valS = math.floor((repairAllCost%10000)/100);
      	            valG = math.floor(repairAllCost/10000);
      	            DEFAULT_CHAT_FRAME:AddMessage("Your items have been repaired for "..valG.."g "..valS.."s "..valC.."c", 0, 0.7, 1);
      	         else
      	            DEFAULT_CHAT_FRAME:AddMessage("You don't have enough money for repair!", 0, 0.7, 1);
      	         end
      	      end
      	   end
           for i=0,4 do 
              if GetContainerNumSlots(i) ~= 0 then
                 for j=1,GetContainerNumSlots(i) do 
                    local itemLink = GetContainerItemLink(i,j);
                    if itemLink then
                       local _, _, itemRarity = GetItemInfo(itemLink);
                       if itemRarity == 0 then
                          UseContainerItem(i,j); 
                       end
                    end 
                 end
              end
           end
        end


      elseif (event == "PLAYER_LEAVING_WORLD") then
	      IsInBg = 0;

      elseif (event == "PLAYER_ENTERING_BATTLEGROUND") then
	      IsInBg = 1;


      elseif (event == "GMSURVEY_DISPLAY") then
	      DEFAULT_CHAT_FRAME:AddMessage("GM Chat Request", 0, 0.7, 1);
	      GMSurveySubmit();
			if(_sound== 1 or WAMainFrame:IsVisible()) then
			   PlaySoundFile("Interface\\AddOns\\WA\\whispergm.mp3");
			end
			if(WAMainFrame:IsVisible()) then
			   LeftSquare:SetTexture(1,0,1); --pink
			   LeftSquare2:SetTexture(1,0,1); --pink
			   ndTerKXMSx = GetTime()+5;
			   DwWvrLQQMMLLNmN = 1;
			end
			if(_screenshot == 1) then
				TakeScreenshot();
			end

      elseif (event == "CHAT_MSG_SAY" or event == "CHAT_MSG_CHANNEL" or event == "CHAT_MSG_BATTLEGROUND" or event == "CHAT_MSG_GUILD" or event == "CHAT_MSG_YELL" or event == "CHAT_MSG_RAID" or event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_BATTLEGROUND_LEADER") then
		if arg1 and string.find(strlower(arg1), strlower(UnitName("player"))) then
		 if (not arg4) or (arg4 and not string.find(strlower(arg4), "crbz")) then
			if _soundonhighlight == 1 then
				PlaySoundFile("Interface\\AddOns\\WA\\highlight.mp3");
			end
			if(WAMainFrame:IsVisible()) then
				LeftSquare:SetTexture(0,0,0.5); --darkblue
				LeftSquare2:SetTexture(0,0,0.5); --darkblue
				eLbMsxnvm = GetTime()+5;
				vzOGpOEysfFrF = 1;
			end
			if(_screenshot == 1) then
				TakeScreenshot();
			end
		 end
		end

	    elseif (event == "LOOT_CLOSED") then
	      if not self:IsEventRegistered("LOOT_BIND_CONFIRM") then
	         self:RegisterEvent("LOOT_BIND_CONFIRM");
			end

      elseif (event == "CHAT_MSG_EMOTE" or event == "CHAT_MSG_TEXT_EMOTE") then
        if arg1 and arg2 and arg2 ~= UnitName("player") and string.find(strlower(arg1), " ".. WA.Localization[2]) then
			   if _soundonemote == 1 then
				   PlaySoundFile("Interface\\AddOns\\WA\\highlight.mp3");
			   end
			   if(WAMainFrame:IsVisible()) then
				   LeftSquare:SetTexture(0,0,0.5); --darkblue
				   LeftSquare2:SetTexture(0,0,0.5); --darkblue
				   eLbMsxnvm = GetTime()+5;
				   vzOGpOEysfFrF = 1;
			   end
		   end

	    elseif (event == "LOOT_BIND_CONFIRM") then
			if ( (GetNumPartyMembers() == 0 and GetNumRaidMembers() == 0) or IsFishingLoot() ) then
			  if UtkknUXUM == 0 and arg1 then
				LootSlot(arg1);
				ConfirmLootSlot(arg1);
				DEFAULT_CHAT_FRAME:AddMessage("Looting BoP Item", 0, 0.7, 1);
				UtkknUXUM = GetTime()+10;
			  end
			end

		elseif (event == "UNIT_AURA") then
			foundDebuff = 0;
 			for i=1,40 do
				local n = UnitDebuff("player",i);
				if n == WA.Localization[0] or n == WA.Localization[1] then
					foundDebuff = 1;
				end
			end
			if foundDebuff == 1 then
				if XXMxUoOLgdsJV == 0 then
				    if(_screenshot == 1) then
			    	    TakeScreenshot();
			        end
					if(_sound == 1) then 
						PlaySoundFile("Interface\\Addons\\WA\\debuff.mp3");
					end
					LeftSquare:SetTexture(0,0.5,0); --darkgreen 0x008000
					LeftSquare2:SetTexture(0,0.5,0); --darkgreen 0x008000
					XXMxUoOLgdsJV = 1;
					hOuyAKHyDiBpp = GetTime()+5;
					ajwHmsnVIDwnCf = ajwHmsnVIDwnCf+1;
				end
			else
				XXMxUoOLgdsJV=0;
			end

		elseif (event == "PLAYER_UNGHOST") then
	      if (IsInBg == 0) then
			   RightSquare:SetTexture(1,1,1); --white
			   RightSquare2:SetTexture(1,1,1); --white
			   colorCodeName = "white";
	      else
			   RightSquare:SetTexture(0,0,1); --blau
			   RightSquare2:SetTexture(0,0,1); --blau
			   colorCodeName = "blau";
	      end
			rGPqjvTSBkM = 0;

	    elseif (event == "PLAYER_DEAD") then
	      zoneNr = GetCurrentMapZone();
			RightSquare:SetTexture(1,1,0); --gelb
			RightSquare2:SetTexture(1,1,0); --gelb
			colorCodeName = "gelb";
			if (rGPqjvTSBkM == 0) then
			   if IsInBg == 1 or zoneNr == 11 or (IsInBg == 0 and (GetNumPartyMembers() < 4 and GetNumRaidMembers() == 0)) then
			      if (_autorelease == 1) then
				      DEFAULT_CHAT_FRAME:AddMessage("Release Corpse in 5 sec", 0, 0.7, 1);
			         KWRdJTfvJehHPcl = 1;
			         dqNjjulBKOr = GetTime()+5;
			      elseif (WAMainFrame:IsVisible()) then
				      DEFAULT_CHAT_FRAME:AddMessage("Release Corpse in 5 sec", 0, 0.7, 1);
			         KWRdJTfvJehHPcl = 1;
			         dqNjjulBKOr = GetTime()+5;
			      end
			   elseif GetNumRaidMembers() ~= 0 then
				   DEFAULT_CHAT_FRAME:AddMessage("No Corpse Release - Not in BG and in Raid", 0, 0.7, 1);
			   else
				   DEFAULT_CHAT_FRAME:AddMessage("No Corpse Release - Not in BG and in Group with more than 4 people", 0, 0.7, 1);
			   end
		   end
			rGPqjvTSBkM = 1;

	    elseif (event == "PLAYER_ALIVE") then
			rGPqjvTSBkM = 0;
			if KWRdJTfvJehHPcl == 1 then
				KWRdJTfvJehHPcl = 2;
			else
				NPJebBwFCiiRwfKd();
			end

	    elseif (event == "PARTY_INVITE_REQUEST") then

	    elseif (event == "PARTY_MEMBERS_CHANGED") then
        StaticPopup_Hide("PARTY_INVITE");
        self:UnregisterEvent("PARTY_MEMBERS_CHANGED");

	    elseif (event == "DUEL_REQUESTED") then
        if(WAMainFrame:IsVisible()) then
           CancelDuel();
				DEFAULT_CHAT_FRAME:AddMessage("Canceled Duel (to accept, enter /wa off)", 0, 0.7, 1);
			end

		-- Chat reaction disabled
	    -- elseif (event == "CHAT_MSG_WHISPER" or event == "CHAT_MSG_BN_WHISPER" ) then
			-- if ((arg2) and (strlower(arg2) ~= chatChannel)) then
		  	  	-- if (arg1 and not string.find(strlower(arg1), "lvbm") and not string.find(strlower(arg1), "lvpn")) then
			   	-- if (_tell == 1) then
				    	-- if (arg6) then
					    	-- SendChatMessage("<" .. arg6 .. ">[" .. arg2 .. "]: " .. arg1,"WHISPER", GetDefaultLanguage("player"), chatChannel);
				    	-- else
					   		-- SendChatMessage("[" .. arg2 .. "]: " .. arg1,"WHISPER", GetDefaultLanguage("player"), chatChannel);
				    	-- end
			    	-- end
			    	-- if (_sound== 1 or WAMainFrame:IsVisible())  then
						-- if (arg6 and string.find(arg6, "GM") or string.find(arg6, "Master")) then
							-- PlaySoundFile("Interface\\AddOns\\WA\\whispergm.mp3");
						-- else
							-- PlaySoundFile("Interface\\AddOns\\WA\\whisper.mp3");
						-- end
			    	-- end
			    	-- if(_screenshot== 1) then
			    		-- TakeScreenshot();
			    	-- end
			    	-- if(WAMainFrame:IsVisible()) then
			    		-- if (arg6 and string.find(arg6, "GM")) then
			    			-- LeftSquare:SetTexture(1,0,1); --pink
			    			-- LeftSquare2:SetTexture(1,0,1); --pink
				    	-- else
				    		-- LeftSquare:SetTexture(0,1,0); --green
				    		-- LeftSquare2:SetTexture(0,1,0); --green
			        	-- end
				    	-- ndTerKXMSx = GetTime()+5;
				    	-- DwWvrLQQMMLLNmN = 1;
			    	-- end
		    	-- end
			-- elseif arg2 and (strlower(arg2) == chatChannel) then
		    	-- local startPos, endPos = string.find( arg1, "==");
		    	-- local startPos2, endPos2 = string.find( arg1, "!honor");
		    	-- local startPos3, endPos3 = string.find( arg1, "!afkdebuff");

				-- if (startPos2 ~= nil) then
					-- if CWpwajXJnFs == -1 then
						-- CWpwajXJnFs = select(2,GetCurrencyInfo(392));
					-- end	
					-- SendChatMessage("Current Honor: ".. select(2,GetCurrencyInfo(392))-CWpwajXJnFs,"WHISPER", GetDefaultLanguage("player"), chatChannel);
		   	 	-- end
		    	-- if (startPos3 ~= nil) then
		       		-- SendChatMessage("Afk Debuffs: ".. ajwHmsnVIDwnCf,"WHISPER", GetDefaultLanguage("player"), chatChannel);
		    	-- end
		    	-- if (startPos ~= nil) then
		        	-- SendChatMessage(strsub(arg1,endPos+1,strlen(arg1)),"WHISPER", GetDefaultLanguage("player"), strsub(arg1,0,startPos-1));
		    	-- end
			-- end

		elseif (event == "ZONE_CHANGED_NEW_AREA") then
		NPJebBwFCiiRwfKd();

			if RightSquare:IsVisible() or RightSquare2:IsVisible() then
				local pTCurrentHonor = select(2,GetCurrencyInfo(392));
				if CWpwajXJnFs == -1 then
					CWpwajXJnFs = pTCurrentHonor
				end

				QXcHLxfvnJC = QXcHLxfvnJC + (pTCurrentHonor - CWpwajXJnFs)-mCASochVq;
				mCASochVq = pTCurrentHonor - CWpwajXJnFs;
			end
		elseif (event == "BATTLEFIELDS_SHOW") then
			if RightSquare:IsVisible() or RightSquare2:IsVisible() then
				if( CanJoinBattlefieldAsGroup() and GetNumPartyMembers() > 0) then
					if IsBattlefieldArena() then
						if GetNumPartyMembers() == 1 then
							JoinBattlefield(1, 1, 1);
						elseif GetNumPartyMembers() == 2 then
							JoinBattlefield(2, 1, 1);
						elseif GetNumPartyMembers() == 4 then
							JoinBattlefield(3, 1, 1);
						end
						HideUIPanel(ArenaFrame);
					end
				end
			end
			if(WAMainFrame:IsVisible() or _autosignup == 1) then
				if( CanJoinBattlefieldAsGroup() and GetNumPartyMembers() > 0) then
					JoinBattlefield(0, 1);
				else
					JoinBattlefield(0);
				end
				HideUIPanel(BattlefieldFrame);
			end

		elseif (event == "UPDATE_BATTLEFIELD_STATUS") then
			local index = nil;
			local inQueue = nil;
			for i=1, MAX_BATTLEFIELD_QUEUES, 1 do
				local status,mapname,instanceID = GetBattlefieldStatus(i);

				if (status == "confirm") then
					index = i;
					inQueue = 2;
				elseif (status == "queued" and IsInBg == 0) then
				RightSquare:SetTexture(1,0,0); --red queued
				RightSquare2:SetTexture(1,0,0); --red queued
				colorCodeName = "rot";
					inQueue = 1;
				elseif (status == "active") then
					inQueue = 1;
				end

			end
			if (inQueue == nil) then
		      RightSquare:SetTexture(1,1,1); --white
		      RightSquare2:SetTexture(1,1,1); --white
		      colorCodeName = "white";
			end
			if ( index ~= nil and ((TikKsaVP == 0 and IsInBg == 0) or (_forcejoin == 1 and IsInBg == 1))) then
				if (WAMainFrame:IsVisible() or _autojoin == 1) then
					RightSquare:SetTexture(1,0,1); --pink joining in 15sec
					RightSquare2:SetTexture(1,0,1); --pink joining in 15sec
					colorCodeName = "pink";
					jbqxekIXgR = GetTime()+15;
					TikKsaVP = 1;
					gpRsywncE = index;
				end
			end
		end
end


function WA_OnUpdate()
	local battlefieldRunTime = GetBattlefieldInstanceRunTime();
	local seconds = GetTime();
	local isArena, isRegistered = IsActiveBattlefieldArena();
	local zone = GetRealZoneText();

	if (WAMainFrame:IsVisible()) then
		if sfRkybniBU == 0 and not UnitIsGhost("player") and KWRdJTfvJehHPcl ~= 1 then
			if ((_tell == 1) and (XPthvfnIFcXcb ~= nil)) then
				if (XPthvfnIFcXcb < battlefieldRunTime) then
					SendChatMessage("Joining " .. zone,"WHISPER", GetDefaultLanguage("player"), chatChannel);
					XPthvfnIFcXcb = nil;
				end
			end
			if isArena == 1 then
				zoneCodename = "arena";
			end

			if zoneCodename == "arena" then
				if battlefieldRunTime > 0 and battlefieldRunTime < 75000 then
					RightSquare:SetTexture(0,0.5,0); --darkgreen 0x008000
					RightSquare2:SetTexture(0,0.5,0); --darkgreen 0x008000
					colorCodeName = "darkgreen";
					WA.BgBegun = 0;
				else
					if WA.BgBegun == 0 then
						RightSquare:SetTexture(0,0,1); --blau
						RightSquare2:SetTexture(0,0,1); --blau
						colorCodeName = "blau";
						WA.BgBegun = 1;
					end
				end
			else
				if battlefieldRunTime > 0 and battlefieldRunTime < 121500 then
					RightSquare:SetTexture(0,0.5,0); --darkgreen 0x008000
					RightSquare2:SetTexture(0,0.5,0); --darkgreen 0x008000
					colorCodeName = "darkgreen";
					WA.BgBegun = 0;
				else
					if WA.BgBegun == 0 then
						RightSquare:SetTexture(0,0,0.5); --darkblue
						RightSquare2:SetTexture(0,0,0.5); --darkblue
						colorCodeName = "darkblue";
						WA.BgBegun = 1;
					end
				end
			end
		end
	end

	if (eLbMsxnvm <= seconds and vzOGpOEysfFrF == 1) then
		eLbMsxnvm = 0;
		vzOGpOEysfFrF = 0;
		LeftSquare:SetTexture(1,1,1); --white
		LeftSquare2:SetTexture(1,1,1); --white
	end


	if (hOuyAKHyDiBpp <= seconds and XXMxUoOLgdsJV == 1) then
		XXMxUoOLgdsJV = 2;
		hOuyAKHyDiBpp = 0;
		LeftSquare:SetTexture(1,1,1); --white
		LeftSquare2:SetTexture(1,1,1); --white
	end

	if (ndTerKXMSx <= seconds and DwWvrLQQMMLLNmN == 1) then
		ndTerKXMSx = 0;
		DwWvrLQQMMLLNmN = 0;
		LeftSquare:SetTexture(1,1,1); --white
		LeftSquare2:SetTexture(1,1,1); --white
	end

	if (UnitIsGhost("player")) then
		if DwWvrLQQMMLLNmN ~= 1 then
			LeftSquare:SetTexture(1,1,0); --gelb
			LeftSquare2:SetTexture(1,1,0); --gelb
			KWRdJTfvJehHPcl = 2;
		end
	elseif (KWRdJTfvJehHPcl == 2) then
		if DwWvrLQQMMLLNmN ~= 1 then
			LeftSquare:SetTexture(1,1,1); --white
			LeftSquare2:SetTexture(1,1,1); --white
			KWRdJTfvJehHPcl = 0;
		end
	end


	if (UtkknUXUM < seconds and UtkknUXUM ~= 0) then
		UtkknUXUM = 0;
	end

	if (not StaticPopup_Visible("CONFIRM_BATTLEFIELD_ENTRY") and TikKsaVP == 1) then
		jbqxekIXgR = 0;
		TikKsaVP = 0;	
		if (IsInBg == 1) then
	   RightSquare:SetTexture(0,0,1); --blau
		RightSquare2:SetTexture(0,0,1); --blau
		colorCodeName = "blau";
		else
		RightSquare:SetTexture(1,1,1); --white
		RightSquare2:SetTexture(1,1,1); --white
		colorCodeName = "white";
		end
	end	

	if (IsInBg == 0) then
		KBjFswjP = 0;
		if (_autojoin == 1 or WAMainFrame:IsVisible()) then
			if (jbqxekIXgR <= seconds and TikKsaVP == 1 and gpRsywncE ~= nil and UnitAffectingCombat("player") == nil) then
				DEFAULT_CHAT_FRAME:AddMessage("Can Join Battleground now.", 0, 0.7, 1);
				jbqxekIXgR = 0;
				TikKsaVP = 0;
				gpRsywncE = nil;
			end	
		end
	else
		if (_forcejoin == 1 and (_autojoin == 1 or WAMainFrame:IsVisible())) then
			if (jbqxekIXgR <= seconds and TikKsaVP == 1 and gpRsywncE ~= nil and UnitAffectingCombat("player") == nil ) then
				RightSquare:SetTexture(0,0.5,0); --darkgreen 0x008000
				RightSquare2:SetTexture(0,0.5,0); --darkgreen 0x008000
				colorCodeName = "darkgreen";
				jbqxekIXgR = 0;
				TikKsaVP = 0;
				gpRsywncE = nil;
			end	
		end
		if (_autoleave == 1 or WAMainFrame:IsVisible()) then
			local evNXQOMfbFjyHb = GetBattlefieldWinner();
			if (evNXQOMfbFjyHb ~= nil) then
      		RightSquare:SetTexture(1,0,1); --pink leaving in 15sec
				RightSquare2:SetTexture(1,0,1); --pink leaving in 15sec
				colorCodeName = "pink";
				if (KBjFswjP == 0) then
					DEFAULT_CHAT_FRAME:AddMessage("AutoLeave BG in 15 sec", 0, 0.7, 1);
					buLcnXnhwDEfRM = GetTime()+15;
					KBjFswjP = 1;
				end
			end

			if (buLcnXnhwDEfRM <= seconds and KBjFswjP == 1) then
				LeaveBattlefield();
				buLcnXnhwDEfRM = 0;
			end
		end
	end

	if (_autorelease == 1 or WAMainFrame:IsVisible()) then
			if (dqNjjulBKOr <= seconds and KWRdJTfvJehHPcl == 1) then
				StaticPopup_Hide("DEATH");
				RepopMe();
				KWRdJTfvJehHPcl = 0;
				dqNjjulBKOr = 0;
			end
		end
end


function NPJebBwFCiiRwfKd()
	local zone = GetRealZoneText();
	local zoneNr2 = GetCurrentMapZone();

	if IsInBg == 1 then
		zoneCodename = zone;
		XPthvfnIFcXcb = GetTime()+1;
		sfRkybniBU = 0;
		if (colorCodeName == "white" or colorCodeName == nil) then
			RightSquare:SetTexture(0,0,1); --blau
			RightSquare2:SetTexture(0,0,1); --blau
			colorCodeName = "blau";
		end
	else
		zoneCodename = nil;
		if ((_sound == 1) and (sfRkybniBU == 0)) then
			PlaySoundFile("Interface\\AddOns\\WA\\bgover.mp3");
		end
		if ((_tell == 1) and (sfRkybniBU == 0)) then
			SendChatMessage("BG over","WHISPER", GetDefaultLanguage("player"), chatChannel);
		end
		WA.BgBegun = 0;
		KBjFswjP = 0;
		RightSquare:SetTexture(1,1,1); --white
		RightSquare2:SetTexture(1,1,1); --white
		colorCodeName = "white";
		sfRkybniBU = 1;
		buLcnXnhwDEfRM = 0;
		KWRdJTfvJehHPcl = 0;
		XXMxUoOLgdsJV = 0;
	end
	if zoneNr == 11 and zoneNr2 ~= 11 then
	   DeclineGroup();
	   zoneNr = 0;
	end
end
