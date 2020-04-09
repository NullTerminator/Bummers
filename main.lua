local playerGUID = UnitGUID("player")

local f = CreateFrame("Frame")
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
f:SetScript("OnEvent", function(self, event)
	self:OnEvent(event, CombatLogGetCurrentEventInfo())
end)

function f:OnEvent(event, ...)
	local timestamp, event, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = ...

  if playerGUID == sourceGUID then
    if event == "SPELL_MISSED" then
      local spellId, spellName, spellSchool, missType = select(12, ...)
      playSound("spell_"..missType:lower())
    elseif event == "SWING_MISSED" then
      local missType = select(12, ...)
      playSound("melee_"..missType:lower())
    elseif event == "RANGED_MISSED" then
      local spellId, spellName, spellSchool, missType = select(12, ...)
      playSound("ranged_"..missType:lower())
    end
  elseif event == "UNIT_DIED" and playerGUID == destGUID then
    C_Timer.After(0.5, function()
      playSound("death")
    end)
  end
end

function playSound(file)
	PlaySoundFile("Interface\\AddOns\\Bummers\\sounds\\"..file..".mp3", "Master")
end
