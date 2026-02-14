-- Define science packs for each level of Cleaner Rocket Exhaust technology
local science_packs = {
    [1] = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}, {"chemical-science-pack", 1},
           {"space-science-pack", 1}},
    [2] = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}, {"chemical-science-pack", 1},
           {"space-science-pack", 1}, {"agricultural-science-pack", 1}},
    [3] = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}, {"chemical-science-pack", 1},
           {"space-science-pack", 1}, {"agricultural-science-pack", 1}, {"cryogenic-science-pack", 1}},
    [4] = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}, {"chemical-science-pack", 1},
           {"space-science-pack", 1}, {"agricultural-science-pack", 1}, {"cryogenic-science-pack", 1},
           {"promethium-science-pack", 1}}
}

-- Cleaner Rocket Exhaust technology (4 upgrade levels)
for i = 1, 4 do
    local before_percent = 100 - ((i - 1) * 20)
    local after_percent = 100 - (i * 20)

    -- Base prerequisite chain
    local prerequisites = i == 1 and {"rocket-silo"} or {"cleaner-rocket-exhaust-" .. (i - 1)}

    -- Add science-pack tech prerequisites when introduced
    if i == 2 then
        table.insert(prerequisites, "agricultural-science-pack")
    end

    if i == 3 then
        table.insert(prerequisites, "cryogenic-science-pack")
    end

    if i == 4 then
        table.insert(prerequisites, "promethium-science-pack")
    end

    data:extend({{
        type = "technology",
        name = "cleaner-rocket-exhaust-" .. i,
        icons = {{
            icon = "__space-age__/graphics/technology/space-platform-thruster.png",
            icon_size = 256,
            tint = {
                r = 0.8,
                g = 1.0,
                b = 0.8,
                a = 1
            }
        }},
        prerequisites = prerequisites,
        effects = {{
            type = "nothing",
            effect_description = "Pollution burst on launch: " .. before_percent .. "% → " .. after_percent .. "%",
            icon = "__base__/graphics/icons/rocket-part.png",
            icon_size = 64
        }},
        unit = {
            count = 500 * i,
            ingredients = science_packs[i],
            time = 30
        },
        upgrade = true,
        order = "k-a[" .. i .. "]"
    }})
end
