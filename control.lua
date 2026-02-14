-- Determine Cleaner Rocket Exhaust tech level
local function get_cleaning_level(force)
  for i = 4, 1, -1 do
    if force.technologies["cleaner-rocket-exhaust-" .. i] and force.technologies["cleaner-rocket-exhaust-" .. i].researched then
      return i
    end
  end
  return 0
end

-- Trigger pollution on rocket launch
script.on_event(defines.events.on_rocket_launched, function(event)
  local silo = event.rocket_silo
  if silo and silo.valid then
    local base_pollution = settings.global["dirty-launches-pollution-amount"].value
    local level = get_cleaning_level(silo.force)
    local multiplier = 1 - (level * 0.2)
    local final_pollution = base_pollution * multiplier
    silo.surface.pollute(silo.position, final_pollution)
  end
end)
