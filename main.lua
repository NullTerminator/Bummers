local playerGUID = UnitGUID("player")

local f = CreateFrame("Frame")
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
f:SetScript("OnEvent", function(self, event)
	self:OnEvent(event, CombatLogGetCurrentEventInfo())
end)

function f:OnEvent(event, ...)
	local timestamp, subevent, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = ...

	if subevent == "SPELL_MISSED" and playerGUID == sourceGUID then
    local spellId, spellName, spellSchool, missType = select(12, ...)
    if missType == "RESIST" then
      playSound("spell_resist")
    end
  elseif subevent == "UNIT_DIED" and playerGUID == destGUID then
    playSound("death")
  end
end

function playSound(file)
	PlaySoundFile("Interface\\AddOns\\Bummers\\sounds\\"..file..".mp3", "Master")
end
