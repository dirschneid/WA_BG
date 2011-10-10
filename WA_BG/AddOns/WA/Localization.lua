WA = {}
WA.Localization = {}
if (GetLocale() == "deDE") then
	WA.Localization[0] = "Unt\195\164tig";
	WA.Localization[1] = "Inaktiv";
	WA.Localization[2] = "euch";

elseif (GetLocale() == "frFR") then 
	WA.Localization[0] = "Oisif";
	WA.Localization[1] = "Inacti";
	WA.Localization[2] = "vous";

elseif (GetLocale() == "esES" or GetLocale() == "esMX") then 
	WA.Localization[0] = "Parado";
	WA.Localization[1] = "Inactivo";
	WA.Localization[2] = "os";

elseif (GetLocale() == "ruRU") then 
	WA.Localization[0] = "Ð”ÐµÐ·ÐµÑ€Ñ‚Ð¸Ñ€";
	WA.Localization[1] = "ÐÐµÐ°ÐºÑ‚Ð¸Ð²Ð½Ð¾";
	WA.Localization[2] = "you";

elseif (GetLocale() == "zhCN") then 
	WA.Localization[0] = "\230\135\146\230\131\176";
	WA.Localization[1] = "\230\182\136\230\158\129";
	WA.Localization[2] = "you";
else
	WA.Localization[0] = "Idle";
	WA.Localization[1] = "Inactive";
	WA.Localization[2] = "you";
end
