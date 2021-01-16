{
    ["sparkWidth"] = 10,
    ["iconSource"] = -1,
    ["xOffset"] = 160,
    ["preferToUpdate"] = false,
    ["yOffset"] = 20,
    ["displayText_format_p_time_dynamic"] = false,
    ["sparkRotation"] = 0,
    ["url"] = "https://wago.io/hNQkeoP-B/2",
    ["backgroundColor"] = {
        [1] = 0,
        [2] = 0,
        [3] = 0,
        [4] = 0.5,
    },
    ["icon_color"] = {
        [1] = 1,
        [2] = 1,
        [3] = 1,
        [4] = 1,
    },
    ["wordWrap"] = "WordWrap",
    ["barColor"] = {
        [1] = 1,
        [2] = 0,
        [3] = 0,
        [4] = 1,
    },
    ["desc"] = "Estimates the chances to win Adventures from the Command/Mission Table based on board power difference.\\nHelps with comparing your troops' effectiveness quickly and being confident they come back victorious!\\n\\nSupports most of the abilities in English language, but fixes are released often when bugs or new spells are found so please update often!\\n\\nPlease note this is solely an estimator, it doesn't factor in precise combat mechanics (attack order, etc.).\\nThis WeakAura's purpose is only to provide an estimation to help you decide if your troops are enough (or by how much they aren't), not to simulate the whole fight.\\nSome examples :\\n   - With 15% win estimated, if you already used all of your best troops and can't do better strategically, you might want to wait for your troops to be at a much higher level before attempting this fight at all.\\n   - With 50% win estimated, it's likely the fight will be a close win or loss for either side if you don't have an advanced strategy in place (e.g. burst the problematic enemy).\\n   - With 95% win estimated, your troops are very likely to crush their opponents unmatched.",
    ["font"] = "1Bignoodle",
    ["sparkOffsetY"] = 0,
    ["load"] = {
        ["use_zone"] = false,
        ["use_zoneId"] = true,
        ["use_never"] = false,
        ["talent"] = {
            ["multi"] = {
            },
        },
        ["zoneId"] = "1698,1707,1699,1701,1565",
        ["spec"] = {
            ["multi"] = {
            },
        },
        ["class"] = {
            ["multi"] = {
            },
        },
        ["size"] = {
            ["multi"] = {
            },
        },
    },
    ["shadowXOffset"] = 1,
    ["smoothProgress"] = true,
    ["useAdjustededMin"] = true,
    ["regionType"] = "aurabar",
    ["texture"] = "Blizzard",
    ["sparkTexture"] = "Interface\\\\CastingBar\\\\UI-CastingBar-Spark",
    ["spark"] = false,
    ["tocversion"] = 90002,
    ["alpha"] = 1,
    ["sparkColor"] = {
        [1] = 1,
        [2] = 1,
        [3] = 1,
        [4] = 1,
    },
    ["fixedWidth"] = 200,
    ["outline"] = "OUTLINE",
    ["sparkOffsetX"] = 0,
    ["color"] = {
        [1] = 1,
        [2] = 1,
        [3] = 1,
        [4] = 1,
    },
    ["adjustedMin"] = "0",
    ["shadowYOffset"] = -1,
    ["sparkRotationMode"] = "AUTO",
    ["automaticWidth"] = "Auto",
    ["triggers"] = {
        [1] = {
            ["trigger"] = {
                ["type"] = "custom",
                ["custom_type"] = "stateupdate",
                ["customVariables"] = "{\\n    percent = \\\"number\\\",\\n    select = \\\"bool\\\",\\n}",
                ["unit"] = "player",
                ["event"] = "Health",
                ["subeventPrefix"] = "SPELL",
                ["custom"] = "function(s, ev, ...)\\n    if ev == \\\"GARRISON_MISSION_NPC_OPENED\\\"\\n    or ev == \\\"GARRISON_SHIPYARD_NPC_CLOSED\\\"\\n    or ev == \\\"GARRISON_FOLLOWER_LIST_UPDATE\\\"\\n    then\\n        C_Timer.After(0.1, function() WeakAuras.ScanEvents(\\\"GO_FARM_ANIME\\\", true) end)\\n    elseif ev == \\\"GO_FARM_ANIME\\\" and ... then\\n        if CovenantMissionFrame\\n        and CovenantMissionFrame:IsVisible()\\n        and CovenantMissionFrame.MissionTab\\n        and CovenantMissionFrame.MissionTab.MissionPage\\n        and CovenantMissionFrame.MissionTab.MissionPage.Stage\\n        and CovenantMissionFrame.MissionTab.MissionPage.Stage:IsVisible()\\n        and CovenantMissionFrame.MissionTab.MissionPage.Board\\n        and CovenantMissionFrame.MissionTab.MissionPage.Board:IsVisible()\\n        then\\n            local stage = CovenantMissionFrame.MissionTab.MissionPage.Stage\\n            local board = CovenantMissionFrame.MissionTab.MissionPage.Board\\n            local percent = 0\\n            \\n            local a, e = {}, {}\\n            a.hp = board.AllyHealthValue and board.AllyHealthValue:GetText():gsub(',',''):gsub('%.',''):gsub(' ','') or 0\\n            a.dmg = board.AllyPowerValue and board.AllyPowerValue:GetText():gsub(',',''):gsub('%.',''):gsub(' ','') or 0\\n            \\n            if tonumber(a.dmg) > 0 or aura_env.config.details then\\n                e.hp = stage.EnemyHealthValue and stage.EnemyHealthValue:GetText():gsub(',',''):gsub('%.',''):gsub(' ','') or 0\\n                e.dmg = stage.EnemyPowerValue and stage.EnemyPowerValue:GetText():gsub(',',''):gsub('%.',''):gsub(' ','') or 0\\n                \\n                a.container = CovenantMissionFrame.MissionTab.MissionPage.Board.FollowerContainer\\n                e.container = CovenantMissionFrame.MissionTab.MissionPage.Board.EnemyContainer\\n                \\n                a.melee, a.ranged, e.melee, e.ranged = aura_env.nbMeleeRanged(a.container, e.container)\\n                a.tot = a.melee + a.ranged\\n                e.tot = e.melee + e.ranged\\n                \\n                a.dmgBonus, a.heal, a.dmgMod, a.dmgTakenMod = aura_env.totPartyBonus(a, e)\\n                e.dmgBonus, e.heal, e.dmgMod, e.dmgTakenMod = aura_env.totPartyBonus(e, a)\\n                \\n                a.dmgTot = (a.dmg + a.dmgBonus) * a.dmgMod * e.dmgTakenMod\\n                e.dmgTot = (e.dmg + e.dmgBonus) * e.dmgMod * a.dmgTakenMod\\n                \\n                a.dmgEff = a.dmgTot-e.heal\\n                e.dmgEff = e.dmgTot-a.heal\\n                \\n                if a.dmgEff < 1 then\\n                    e.dmgEff = e.dmgEff + (a.dmgEff < 0 and (-a.dmgEff+1) or (1-a.dmgEff))\\n                    a.dmgEff = 1\\n                end\\n                if e.dmgEff < 1 then\\n                    a.dmgEff = a.dmgEff + (e.dmgEff < 0 and (-e.dmgEff+1) or (1-e.dmgEff))\\n                    e.dmgEff = 1\\n                end\\n                \\n                a.estWin = e.hp/a.dmgEff\\n                e.estWin = a.hp/e.dmgEff\\n                \\n                aura_env.ally = a\\n                aura_env.enemy = e\\n                \\n                percent = e.estWin^2/(e.estWin^2+a.estWin^2)\\n                percent = math.floor(percent*100+0.5)\\n            end\\n            \\n            s[\\\"\\\"] = {\\n                percent = percent,\\n                a = a,\\n                e = e,\\n                select = tonumber(a.dmg) == 0,\\n                progressType = \\\"static\\\",\\n                value = percent,\\n                changed = true,\\n                show = true,\\n            }\\n            return true\\n        elseif s[\\\"\\\"] then\\n            s[\\\"\\\"] = {\\n                changed = true,\\n                show = false,\\n            }\\n            return true\\n        end\\n    end\\nend",
                ["customName"] = "\\n\\n",
                ["spellIds"] = {
                },
                ["names"] = {
                },
                ["check"] = "event",
                ["events"] = "GARRISON_MISSION_NPC_OPENED GARRISON_SHIPYARD_NPC_CLOSED GARRISON_FOLLOWER_LIST_UPDATE GO_FARM_ANIME",
                ["subeventSuffix"] = "_CAST_START",
                ["debuffType"] = "HELPFUL",
            },
            ["untrigger"] = {
                ["custom"] = "",
            },
        },
        ["disjunctive"] = "any",
        ["activeTriggerMode"] = -10,
    },
    ["displayText_format_p_format"] = "timed",
    ["internalVersion"] = 40,
    ["animation"] = {
        ["start"] = {
            ["colorR"] = 1,
            ["scalex"] = 1,
            ["colorA"] = 1,
            ["colorG"] = 1,
            ["type"] = "none",
            ["easeType"] = "none",
            ["colorB"] = 1,
            ["scaley"] = 1,
            ["alpha"] = 0,
            ["colorType"] = "custom",
            ["y"] = 0,
            ["x"] = 0,
            ["easeStrength"] = 3,
            ["duration_type"] = "relative",
            ["colorFunc"] = "function(progress, r1, g1, b1, a1, r2, g2, b2, a2)\\n    return 0, 1, 0\\nend\\n",
            ["rotate"] = 0,
            ["duration"] = "",
            ["use_color"] = true,
        },
        ["main"] = {
            ["colorR"] = 1,
            ["scalex"] = 1,
            ["colorA"] = 1,
            ["colorG"] = 1,
            ["type"] = "custom",
            ["easeType"] = "none",
            ["colorB"] = 1,
            ["scaley"] = 1,
            ["alpha"] = 0,
            ["colorType"] = "custom",
            ["y"] = 0,
            ["x"] = 0,
            ["easeStrength"] = 3,
            ["duration_type"] = "seconds",
            ["colorFunc"] = "function(progress, r1, g1, b1, a1, r2, g2, b2, a2)\\n    if aura_env.state.select or not aura_env.state.percent then\\n        return 0.7, 0.7, 0.7\\n    end\\n    local pct = aura_env.state.percent/100\\n    if pct < 0.5 then\\n        return 1, pct/0.5, 0\\n    else\\n        return (1-pct)/0.5, 1, 0\\n    end\\nend",
            ["rotate"] = 0,
            ["duration"] = "",
            ["use_color"] = true,
        },
        ["finish"] = {
            ["type"] = "none",
            ["easeStrength"] = 3,
            ["duration_type"] = "seconds",
            ["easeType"] = "none",
        },
    },
    ["version"] = 2,
    ["subRegions"] = {
        [1] = {
            ["type"] = "aurabar_bar",
        },
        [2] = {
            ["text_shadowXOffset"] = 0,
            ["text_text"] = "%c1",
            ["text_shadowColor"] = {
                [1] = 0,
                [2] = 0,
                [3] = 0,
                [4] = 1,
            },
            ["text_selfPoint"] = "AUTO",
            ["text_automaticWidth"] = "Auto",
            ["text_fixedWidth"] = 64,
            ["anchorYOffset"] = 0,
            ["text_justify"] = "CENTER",
            ["rotateText"] = "NONE",
            ["type"] = "subtext",
            ["text_color"] = {
                [1] = 1,
                [2] = 1,
                [3] = 1,
                [4] = 1,
            },
            ["text_font"] = "Friz Quadrata TT",
            ["text_shadowYOffset"] = 0,
            ["text_wordWrap"] = "WordWrap",
            ["text_fontType"] = "OUTLINE",
            ["text_anchorPoint"] = "INNER_CENTER",
            ["text_text_format_c1_format"] = "none",
            ["text_text_format_n_format"] = "none",
            ["text_fontSize"] = 15,
            ["anchorXOffset"] = 0,
            ["text_visible"] = true,
        },
        [3] = {
            ["border_offset"] = 1,
            ["border_anchor"] = "bar",
            ["type"] = "subborder",
            ["border_color"] = {
                [1] = 0,
                [2] = 0,
                [3] = 0,
                [4] = 1,
            },
            ["border_visible"] = true,
            ["border_edge"] = "Square Full White",
            ["border_size"] = 1,
        },
        [4] = {
            ["text_text_format_n_format"] = "none",
            ["text_text"] = "%c2",
            ["text_shadowColor"] = {
                [1] = 0,
                [2] = 0,
                [3] = 0,
                [4] = 1,
            },
            ["text_selfPoint"] = "TOPLEFT",
            ["text_automaticWidth"] = "Auto",
            ["text_fixedWidth"] = 64,
            ["anchorYOffset"] = 0,
            ["text_justify"] = "LEFT",
            ["rotateText"] = "NONE",
            ["text_shadowXOffset"] = 1,
            ["text_text_format_p_format"] = "timed",
            ["text_text_format_p_time_precision"] = 1,
            ["type"] = "subtext",
            ["text_anchorXOffset"] = -220,
            ["text_color"] = {
                [1] = 1,
                [2] = 1,
                [3] = 1,
                [4] = 1,
            },
            ["text_font"] = "Friz Quadrata TT",
            ["text_wordWrap"] = "WordWrap",
            ["text_shadowYOffset"] = -1,
            ["text_fontType"] = "OUTLINE",
            ["text_text_format_c2_format"] = "none",
            ["text_text_format_c3_format"] = "none",
            ["text_anchorPoint"] = "INNER_RIGHT",
            ["text_visible"] = true,
            ["text_anchorYOffset"] = -40,
            ["text_fontSize"] = 14,
            ["anchorXOffset"] = 0,
            ["text_text_format_p_time_dynamic"] = false,
        },
        [5] = {
            ["text_text_format_p_time_precision"] = 1,
            ["text_text"] = "%c3",
            ["text_text_format_p_format"] = "timed",
            ["text_selfPoint"] = "TOPLEFT",
            ["text_automaticWidth"] = "Auto",
            ["text_fixedWidth"] = 64,
            ["anchorYOffset"] = 0,
            ["text_justify"] = "LEFT",
            ["rotateText"] = "NONE",
            ["text_text_format_n_format"] = "none",
            ["text_shadowColor"] = {
                [1] = 0,
                [2] = 0,
                [3] = 0,
                [4] = 1,
            },
            ["text_shadowXOffset"] = 1,
            ["type"] = "subtext",
            ["text_anchorXOffset"] = -160,
            ["text_color"] = {
                [1] = 1,
                [2] = 1,
                [3] = 1,
                [4] = 1,
            },
            ["text_font"] = "Friz Quadrata TT",
            ["text_shadowYOffset"] = -1,
            ["text_anchorYOffset"] = -40,
            ["text_text_format_c3_format"] = "none",
            ["text_text_format_c2_format"] = "none",
            ["text_visible"] = true,
            ["text_anchorPoint"] = "INNER_RIGHT",
            ["text_fontType"] = "OUTLINE",
            ["text_wordWrap"] = "WordWrap",
            ["text_fontSize"] = 14,
            ["anchorXOffset"] = 0,
            ["text_text_format_p_time_dynamic"] = false,
        },
        [6] = {
            ["text_shadowXOffset"] = 1,
            ["text_text"] = "%c4",
            ["text_shadowColor"] = {
                [1] = 0,
                [2] = 0,
                [3] = 0,
                [4] = 1,
            },
            ["text_selfPoint"] = "TOPLEFT",
            ["text_automaticWidth"] = "Auto",
            ["text_fixedWidth"] = 64,
            ["text_text_format_c4_format"] = "none",
            ["anchorYOffset"] = 0,
            ["text_justify"] = "LEFT",
            ["rotateText"] = "NONE",
            ["text_text_format_p_format"] = "timed",
            ["text_text_format_p_time_precision"] = 1,
            ["text_text_format_n_format"] = "none",
            ["type"] = "subtext",
            ["text_anchorXOffset"] = -100,
            ["text_color"] = {
                [1] = 1,
                [2] = 1,
                [3] = 1,
                [4] = 1,
            },
            ["text_font"] = "Friz Quadrata TT",
            ["text_text_format_c2_format"] = "none",
            ["text_anchorYOffset"] = -40,
            ["text_fontType"] = "OUTLINE",
            ["text_wordWrap"] = "WordWrap",
            ["text_visible"] = true,
            ["text_anchorPoint"] = "INNER_RIGHT",
            ["text_text_format_c3_format"] = "none",
            ["text_shadowYOffset"] = -1,
            ["text_fontSize"] = 14,
            ["anchorXOffset"] = 0,
            ["text_text_format_p_time_dynamic"] = false,
        },
        [7] = {
            ["text_text_format_p_time_precision"] = 1,
            ["text_text"] = "%c5",
            ["text_text_format_p_format"] = "timed",
            ["text_selfPoint"] = "TOPLEFT",
            ["text_automaticWidth"] = "Auto",
            ["text_fixedWidth"] = 64,
            ["text_shadowColor"] = {
                [1] = 0,
                [2] = 0,
                [3] = 0,
                [4] = 1,
            },
            ["anchorYOffset"] = 0,
            ["text_justify"] = "LEFT",
            ["rotateText"] = "NONE",
            ["text_shadowXOffset"] = 1,
            ["text_text_format_n_format"] = "none",
            ["text_shadowYOffset"] = -1,
            ["type"] = "subtext",
            ["text_anchorXOffset"] = -40,
            ["text_color"] = {
                [1] = 1,
                [2] = 1,
                [3] = 1,
                [4] = 1,
            },
            ["text_font"] = "Friz Quadrata TT",
            ["text_text_format_c2_format"] = "none",
            ["text_anchorYOffset"] = -40,
            ["text_text_format_c3_format"] = "none",
            ["text_wordWrap"] = "WordWrap",
            ["text_fontType"] = "OUTLINE",
            ["text_anchorPoint"] = "INNER_RIGHT",
            ["text_visible"] = true,
            ["text_text_format_c5_format"] = "none",
            ["text_fontSize"] = 14,
            ["anchorXOffset"] = 0,
            ["text_text_format_p_time_dynamic"] = false,
        },
        [8] = {
            ["text_text_format_p_time_precision"] = 1,
            ["text_text"] = "%c6",
            ["text_text_format_p_format"] = "timed",
            ["text_selfPoint"] = "TOPLEFT",
            ["text_automaticWidth"] = "Auto",
            ["text_fixedWidth"] = 64,
            ["text_shadowColor"] = {
                [1] = 0,
                [2] = 0,
                [3] = 0,
                [4] = 1,
            },
            ["anchorYOffset"] = 0,
            ["text_justify"] = "LEFT",
            ["rotateText"] = "NONE",
            ["text_shadowXOffset"] = 1,
            ["text_text_format_n_format"] = "none",
            ["text_anchorYOffset"] = -40,
            ["type"] = "subtext",
            ["text_anchorXOffset"] = 20,
            ["text_color"] = {
                [1] = 1,
                [2] = 1,
                [3] = 1,
                [4] = 1,
            },
            ["text_font"] = "Friz Quadrata TT",
            ["text_text_format_c6_format"] = "none",
            ["text_shadowYOffset"] = -1,
            ["text_fontType"] = "OUTLINE",
            ["text_wordWrap"] = "WordWrap",
            ["text_text_format_c3_format"] = "none",
            ["text_anchorPoint"] = "INNER_RIGHT",
            ["text_visible"] = true,
            ["text_text_format_c2_format"] = "none",
            ["text_fontSize"] = 14,
            ["anchorXOffset"] = 0,
            ["text_text_format_p_time_dynamic"] = false,
        },
        [9] = {
            ["text_shadowXOffset"] = 1,
            ["text_text"] = "%c7",
            ["text_shadowColor"] = {
                [1] = 0,
                [2] = 0,
                [3] = 0,
                [4] = 1,
            },
            ["text_text_format_c7_format"] = "none",
            ["text_selfPoint"] = "TOPLEFT",
            ["text_automaticWidth"] = "Fixed",
            ["text_fixedWidth"] = 80,
            ["text_text_format_p_time_precision"] = 1,
            ["anchorYOffset"] = 0,
            ["text_justify"] = "LEFT",
            ["rotateText"] = "NONE",
            ["text_text_format_p_format"] = "timed",
            ["text_text_format_n_format"] = "none",
            ["text_wordWrap"] = "WordWrap",
            ["type"] = "subtext",
            ["text_anchorXOffset"] = -310,
            ["text_color"] = {
                [1] = 1,
                [2] = 1,
                [3] = 1,
                [4] = 1,
            },
            ["text_font"] = "Friz Quadrata TT",
            ["text_text_format_c6_format"] = "none",
            ["text_shadowYOffset"] = -1,
            ["text_text_format_c3_format"] = "none",
            ["text_text_format_c2_format"] = "none",
            ["text_visible"] = true,
            ["text_anchorPoint"] = "INNER_RIGHT",
            ["text_fontType"] = "OUTLINE",
            ["text_anchorYOffset"] = -40,
            ["text_fontSize"] = 14,
            ["anchorXOffset"] = 0,
            ["text_text_format_p_time_dynamic"] = false,
        },
    },
    ["height"] = 15,
    ["sparkBlendMode"] = "ADD",
    ["useAdjustededMax"] = true,
    ["fontSize"] = 40,
    ["displayIcon"] = "237381",
    ["adjustedMax"] = "100",
    ["customText"] = "function()\\n    if aura_env.state and aura_env.state.percent then\\n        local winpct,win,dmgbon,heal,dmgmod,defmod,header = \\\"ADD TROOPS\\\",\\\"\\\",\\\"\\\",\\\"\\\",\\\"\\\",\\\"\\\",\\\"\\\"\\n        \\n        if not aura_env.state.select or aura_env.config.details then\\n            local a = aura_env.state.a\\n            local e = aura_env.state. e\\n            \\n            local rou = function(nb,dec)\\n                if not dec then dec = 2 end\\n                return math.floor(nb*10^dec+0.5)/10^dec\\n            end\\n            \\n            winpct = (\\\"WIN: %s%%\\\"):format(aura_env.state.percent)\\n            \\n            if aura_env.config.details then\\n                win = \\\"TtoW\\\\n\\\"..rou(e.estWin)..\\\"\\\\n\\\"..rou(a.estWin)\\n                dmgbon = \\\"Dmg+\\\\n\\\"..rou(e.dmgBonus,0)..\\\"\\\\n\\\"..rou(a.dmgBonus,0)\\n                heal = \\\"Heal\\\\n\\\"..rou(e.heal,0)..\\\"\\\\n\\\"..rou(a.heal,0)\\n                dmgmod = \\\"Dmg*\\\\n\\\"..rou(e.dmgMod)..\\\"\\\\n\\\"..rou(a.dmgMod)\\n                defmod = \\\"Def*\\\\n\\\"..rou(e.dmgTakenMod)..\\\"\\\\n\\\"..rou(a.dmgTakenMod)\\n                header = \\\"\\\\n\\\"..e.tot..\\\" Enemies\\\\n\\\"..a.tot..\\\" Allies\\\"\\n            end \\n        end\\n        \\n        return winpct,win,dmgbon,heal,dmgmod,defmod,header\\n    end\\nend",
    ["shadowColor"] = {
        [1] = 0,
        [2] = 0,
        [3] = 0,
        [4] = 1,
    },
    ["uid"] = "9s4pRC((pib",
    ["anchorFrameFrame"] = "CovenantMissionFrame",
    ["config"] = {
        ["details"] = false,
    },
    ["actions"] = {
        ["start"] = {
        },
        ["init"] = {
            ["custom"] = "aura_env.matches = {}\\n\\n-- IF MATCHES ARE IN THE SAME FAMILY, ONLY THE FIRST MATCH WILL BE USED\\n\\naura_env.matches[\\\"enUS\\\"] = {\\n    -- DEALING (FAMILY)\\n    {text=\\\"dealing %d+ .*damage in a cone\\\", type=\\\"dmg-cone\\\", family=\\\"dealing\\\"},\\n    {text=\\\"in a cone.*, dealing %d+ .*damage\\\", type=\\\"dmg-cone\\\", family=\\\"dealing\\\"},\\n    {text=\\\"dealing %d+ .*damage to all\\\", type=\\\"dmg-aoe\\\", family=\\\"dealing\\\"},\\n    {text=\\\"all enemies.*, dealing %d+\\\", type=\\\"dmg-aoe\\\", family=\\\"dealing\\\"},\\n    {text=\\\"all enemies.* for %d+ .*damage\\\", type=\\\"dmg-aoe\\\", family=\\\"dealing\\\"},\\n    {text=\\\"adjacent enemies.*, dealing %d+ .*damage\\\", type=\\\"dmg-adj\\\", family=\\\"dealing\\\"},\\n    {text=\\\", dealing %d+ damage,\\\", type=\\\"dmg\\\", family=\\\"dealing\\\"},\\n    {text=\\\"dealing %d+ .*damage for .*\\\", type=\\\"dot\\\", family=\\\"dealing\\\"},\\n    {text=\\\"dealing %d+ .*damage to .*adjacent enemies\\\", type=\\\"dmg-adj\\\", family=\\\"dealing\\\"},\\n    {text=\\\"closest.*farthest.*dealing %d+ .*damage to both\\\", type=\\\"dmg-twice\\\", family=\\\"dealing\\\"},\\n    {text=\\\"dealing %d+ .*damage to both\\\", type=\\\"dmg-pierce\\\", family=\\\"dealing\\\"},\\n    {text=\\\"dealing %d+ .*damage to them and an enemy behind\\\", type=\\\"dmg-pierce\\\", family=\\\"dealing\\\"},\\n    {text=\\\"dealing a %d+\\\", type=\\\"dmg\\\", family=\\\"dealing\\\"},\\n    {text=\\\"dealing %d+\\\", type=\\\"dmg\\\", family=\\\"dealing\\\"},\\n    -- DEALS (FAMILY)\\n    {text=\\\"deal[s]? %d+ .*damage .*each .* for .*\\\", type=\\\"dot\\\", family=\\\"deals\\\"},\\n    {text=\\\"each turn.*deal[s]? %d+%% maximum health .*damage to all\\\", type=\\\"dot-pct-aoe\\\", family=\\\"deals\\\"},\\n    {text=\\\"deal[s]? %d+\\\", type=\\\"dmg\\\", family=\\\"deals\\\"},\\n    -- OTHER DIRECT DAMAGES\\n    {text=\\\"and then %d+ .*damage\\\", type=\\\"dmg\\\"},\\n    {text=\\\"and %d+ with the second\\\", type=\\\"dmg\\\"},\\n    {text=\\\"and.* %d+ .*damage over\\\", type=\\\"dmg\\\"},\\n    {text=\\\", then %d+, then %d+, then %d+%.\\\", type=\\\"dmg\\\"},\\n    {text=\\\", then %d+, then %d+, then %d+%.\\\", type=\\\"dmg\\\"},\\n    {text=\\\", then %d+%.\\\", type=\\\"dmg\\\"},\\n    {text=\\\"hitting them for %d+ .*damage\\\", type=\\\"dmg\\\"},\\n    {text=\\\"closest enemy for %d+%% of their maximum hit points\\\", type=\\\"dmg-pct\\\"},\\n    {text=\\\"times,.*dealing %d+ .*damage\\\", type=\\\"dmg-mult\\\"},\\n    -- DOTS\\n    {text=\\\"damage over time effect for %d+\\\", type=\\\"dot\\\"},\\n    {text=\\\"additional %d+ .*damage .* round\\\", type=\\\"dot\\\"},\\n    {text=\\\"additional %d+ .*damage .* turn\\\", type=\\\"dot\\\"},\\n    {text=\\\"and %d+ .*damage for .* .*\\\", type=\\\"dot\\\"},\\n    {text=\\\"bleed for %d+ for .*\\\", type=\\\"dot\\\"},\\n    {text=\\\"inflicting %d+ .*damage .* round\\\", type=\\\"dot-aoe\\\"},\\n    -- FLAT BOOSTS\\n    {text=\\\"increases his damage.* by %d+\\\", type=\\\"boost-flat\\\"},\\n    {text=\\\"increasing their damage.* by %d+ \\\", type=\\\"boost-flat-all\\\"},\\n    -- MULTIPLICATIVE BOOSTS\\n    {text=\\\"increasing damage done by %d+%%\\\", type=\\\"boost\\\"},\\n    {text=\\\"increasing his damage by %d+%%\\\", type=\\\"boost\\\"},\\n    {text=\\\"ally.*boosting their damage by %d+%%\\\", type=\\\"boost\\\"},\\n    {text=\\\"allies.*boosting their damage by %d+%%\\\", type=\\\"boost-all\\\"},\\n    {text=\\\"ally.*buffing their damage by %d+%%\\\", type=\\\"boost\\\"},\\n    {text=\\\"allies.*buffing their damage by %d+%%\\\", type=\\\"boost-all\\\"},\\n    {text=\\\"ally.*increasing their damage by %d+%%\\\", type=\\\"boost\\\"},\\n    {text=\\\"allies.*increasing their damage by %d+%%\\\", type=\\\"boost-all\\\"},\\n    {text=\\\"adjacent allies, increasing all damage they deal by %d+%%\\\", type=\\\"boost-adj\\\"},\\n    {text=\\\"doubles the damage of all allies for %d+ rounds\\\", type=\\\"boost-all-double\\\"},\\n    -- MULTIPLICATIVE NERF\\n    {text=\\\"but reduce their damage by %d+%% for the next round\\\", type=\\\"nerf\\\"},\\n    -- MULTIPLICATIVE VULNERABILITY\\n    {text=\\\"increasing damage taken by %d+%%\\\", type=\\\"vulne\\\"},\\n    {text=\\\"causing them to take %d+%% more damage\\\", type=\\\"vulne\\\"},\\n    {text=\\\"exposing them to %d+%% more damage\\\", type=\\\"vulne\\\"},\\n    {text=\\\"increasing the damage they take by %d+%%\\\", type=\\\"vulne-all\\\"},\\n    -- HEALS (FAMILY)\\n    {text=\\\"each turn.*heal[s]? for %d+%% of maximum health\\\", type=\\\"hot-pct\\\", family=\\\"heals\\\"},\\n    {text=\\\"heal[s]? all .*for %d+%% of their max\\\", type=\\\"heal-pct-aoe\\\", family=\\\"heals\\\"},\\n    {text=\\\"heal[s]? all .*for %d+\\\", type=\\\"heal-aoe\\\", family=\\\"heals\\\"},\\n    {text=\\\"heal[s]? .*for %d+\\\", type=\\\"heal\\\", family=\\\"heals\\\"},\\n    -- HEALING (FAMILY)\\n    {text=\\\"healing their.*for %d+\\\", type=\\\"heal-aoe\\\", family=\\\"healing\\\"},\\n    {text=\\\"healing .*for %d+\\\", type=\\\"heal\\\", family=\\\"healing\\\"},\\n    -- HOTS\\n    {text=\\\"and damage taken by %d+ for .*\\\", type=\\\"hot\\\"},\\n    {text=\\\"increases their maximum health by %d+%%\\\", type=\\\"heal-pct\\\"},\\n    -- MULTIPLICATIVE PROTECTION\\n    {text=\\\"reducing the damage they take by %d+%%\\\", type=\\\"prot\\\"},\\n    {text=\\\"reducing all damage taken by %d+%%\\\", type=\\\"prot-all\\\"},\\n    {text=\\\"decreasing .*damage .*by %d+%%\\\", type=\\\"prot-all\\\"},\\n    {text=\\\"reducing the damage .*allies take by %d+%%\\\", type=\\\"prot-all\\\"},\\n    {text=\\\"all allies take %d+%% less damage\\\", type=\\\"prot-all\\\"},\\n    {text=\\\"reducing their damage.* by %d+%%\\\", type=\\\"prot-all\\\"},\\n    {text=\\\"reduces their damage.* by %d+%%\\\", type=\\\"prot-all\\\"},\\n    -- SPECIALS\\n    {text=\\\"takes %d+%% reduced damage and protects all ranged allies\\\", type=\\\"prot-self-ranged\\\"},\\n}\\n\\naura_env.matches[\\\"enGB\\\"] = aura_env.matches[\\\"enUS\\\"]\\n\\naura_env.effects = function(text, matching, effect, cd, a, e)\\n    local damage, heal, modDmg, modDmgTaken = 0, 0, 1, 1\\n    \\n    local val = matching:match(\\\"%d+\\\")\\n    local rounds = aura_env.roundsFromString(text, cd)\\n    local times = aura_env.timesFromString(text, cd)\\n    local hitA = aura_env.nbHitAoe(text, a)\\n    local hitE = aura_env.nbHitAoe(text, e)\\n    local hitCone = aura_env.nbHitCone(e)\\n    local hitPierce = aura_env.nbHitPierce(e)\\n    local hitAdjA = aura_env.nbHitAdjacent(a)\\n    local hitAdjE = aura_env.nbHitAdjacent(e)\\n    \\n    if effect.type == \\\"dmg\\\" then damage = val/cd\\n    elseif effect.type == \\\"dmg-twice\\\" then damage = val*2/cd\\n    elseif effect.type == \\\"dmg-aoe\\\" then damage = val*hitE/cd\\n    elseif effect.type == \\\"dmg-cone\\\" then damage = val*hitCone/cd\\n    elseif effect.type == \\\"dmg-adj\\\" then damage = val*hitAdjE/cd\\n    elseif effect.type == \\\"dmg-pierce\\\" then damage = val*hitPierce/cd\\n    elseif effect.type == \\\"dmg-pct\\\" then damage = e.tot == 0 and 0 or val/100*e.hp/e.tot*rounds/cd\\n    elseif effect.type == \\\"dmg-mult\\\" then damage = val*rounds/cd\\n    elseif effect.type == \\\"dot\\\" then damage = val*rounds/cd\\n    elseif effect.type == \\\"dot-aoe\\\" then damage = val*rounds*hitE/cd\\n    elseif effect.type == \\\"dot-pct-aoe\\\" then damage = e.tot == 0 and 0 or val/100*hitE*e.hp/e.tot*rounds/cd\\n    elseif effect.type == \\\"boost-flat\\\" then damage = val*rounds/cd\\n    elseif effect.type == \\\"boost-flat-all\\\" then damage = val*a.tot*rounds/cd\\n        \\n    elseif effect.type == \\\"boost\\\" then modDmg = 1+val/100/a.tot*rounds/cd\\n    elseif effect.type == \\\"boost-all\\\" then modDmg = 1+val/100*rounds/cd\\n    elseif effect.type == \\\"boost-all-double\\\" then modDmg = 1+rounds/cd\\n    elseif effect.type == \\\"boost-adj\\\" then modDmg = 1+val/100*hitAdjA/a.tot*rounds/cd\\n    elseif effect.type == \\\"vulne\\\" then modDmg = e.tot == 0 and 0 or 1+val/100/e.tot*rounds/cd\\n    elseif effect.type == \\\"vulne-all\\\" then modDmg = 1+val/100*rounds/cd\\n    elseif effect.type == \\\"nerf\\\" then modDmg = 1-val/100/a.tot*rounds/cd\\n        \\n    elseif effect.type == \\\"heal\\\" then heal = val/cd\\n    elseif effect.type == \\\"hot\\\" then heal = val*rounds/cd\\n    elseif effect.type == \\\"heal-aoe\\\" then heal = val*hitA/cd\\n    elseif effect.type == \\\"heal-pct\\\" then heal = val/100*a.hp/a.tot/cd\\n    elseif effect.type == \\\"heal-pct-aoe\\\" then heal = val/100*a.hp*hitA/a.tot/cd\\n    elseif effect.type == \\\"hot-pct\\\" then heal = val/100*a.hp/a.tot*rounds/cd\\n        \\n    elseif effect.type == \\\"prot\\\" then modDmgTaken = 1-val/100/a.tot*rounds/cd\\n    elseif effect.type == \\\"prot-all\\\" then modDmgTaken = 1-val/100*rounds/cd\\n    elseif effect.type == \\\"prot-self-ranged\\\" then modDmgTaken = 1-val/100*(math.min(a.melee,1)+a.ranged)/a.tot*rounds/cd\\n        \\n    end\\n    \\n    return damage, heal, modDmg, modDmgTaken\\nend\\n\\naura_env.spellEffects = function(text, cd, a, e)\\n    local damage, heal, modDmg, modDmgTaken = 0, 0, 1, 1\\n    \\n    cd = math.max(1, cd)\\n    text = text:lower():gsub(\\\"-\\\", \\\"\\\")\\n    \\n    local families = {}\\n    for _, effect in ipairs(aura_env.matches[GetLocale()]) do\\n        if (not effect.family or not families[effect.family]) then\\n            local matching = text:match(effect.text)\\n            if matching then\\n                local d,h,md,mdt = aura_env.effects(text, matching, effect, cd, a, e)\\n                damage = damage + d\\n                heal = heal + h\\n                modDmg = modDmg * md\\n                modDmgTaken = modDmgTaken * mdt\\n                \\n                if effect.family then\\n                    families[effect.family] = true\\n                end\\n            end\\n        end\\n    end\\n    \\n    return damage, heal, modDmg, modDmgTaken\\nend\\n\\naura_env.totPartyBonus = function(a, e)\\n    local damage, heal, modDmg, modDmgTaken = 0, 0, 1, 1\\n    if aura_env.matches[GetLocale()] then\\n        for _, frame in ipairs({a.container:GetChildren()}) do\\n            if frame.name and frame:IsShown() then\\n                for _, spell in ipairs(frame:GetAutoCombatSpells()) do\\n                    local d,h,md,mdt = aura_env.spellEffects(spell.description, spell.cooldown, a, e)\\n                    damage = damage + d\\n                    heal = heal + h\\n                    modDmg = modDmg * md\\n                    modDmgTaken = modDmgTaken * mdt\\n                end\\n            end\\n        end\\n    end\\n    return damage, heal, modDmg, modDmgTaken\\nend\\n\\naura_env.nbMeleeRanged = function(allies, enemies)\\n    local aMelee, aRanged, eMelee, eRanged = 0,0,0,0\\n    \\n    for _, frame in ipairs({allies:GetChildren()}) do\\n        if frame.name and frame:IsShown() then\\n            if frame.boardIndex > 1 then aMelee = aMelee + 1\\n            else aRanged = aRanged + 1\\n            end\\n        end\\n    end\\n    \\n    for _, frame in ipairs({enemies:GetChildren()}) do\\n        if frame.name and frame:IsShown() then\\n            if frame.boardIndex < 9 then eMelee = eMelee + 1\\n            else eRanged = eRanged + 1\\n            end\\n        end\\n    end\\n    \\n    return aMelee, aRanged, eMelee, eRanged\\nend\\n\\naura_env.roundsFromString = function(text, cd)\\n    local check = text:match(\\\"%d+ rounds\\\")\\n    or text:match(\\\"%d+ turns\\\")\\n    return \\n    (check and string.match(check, \\\"%d+\\\"))\\n    or (((text:match(\\\"one turn\\\") or text:match(\\\"one round\\\")) and 1)\\n        or ((text:match(\\\"two turns\\\") or text:match(\\\"two rounds\\\")) and 2)\\n        or ((text:match(\\\"three turns\\\") or text:match(\\\"three rounds\\\")) and 3)\\n        or ((text:match(\\\"four turns\\\") or text:match(\\\"four rounds\\\")) and 4)\\n        or ((text:match(\\\"every other turn\\\") or text:match(\\\"every other round\\\")) and cd-1))\\n    or cd\\nend\\n\\naura_env.timesFromString = function(text, cd)\\n    local check = text:match(\\\"%d+ times\\\")\\n    return \\n    (check and string.match(check, \\\"%d+\\\"))\\n    or ((text:match(\\\"one time\\\") and 1)\\n        or (text:match(\\\"two times\\\") and 2)\\n        or (text:match(\\\"three times\\\") and 3)\\n        or (text:match(\\\"four times\\\") and 4))\\n    or 1\\nend\\n\\naura_env.nbHitAoe = function(text, hit)\\n    if text:match(\\\"melee\\\") or text:match(\\\"front\\\") then return hit.melee\\n    elseif text:match(\\\"ranged\\\") or text:match(\\\"back\\\") then return hit.ranged\\n    elseif text:match(\\\"at range\\\") or text:match(\\\"in range\\\") then return math.max(hit.ranged > 0 and hit.ranged or hit.melee, hit.tot/2)\\n    elseif text:match(\\\"a line\\\") then return aura_env.nbHitPierce(hit)\\n    else return hit.tot\\n    end\\nend\\n\\naura_env.nbHitCone = function(hit)\\n    return 1 + (hit.melee > 0 and math.min(hit.ranged, 2) or 0)\\nend\\n\\naura_env.nbHitAdjacent = function(hit)\\n    return math.min(hit.melee, hit.ranged, 2)\\nend\\n\\naura_env.nbHitPierce = function(hit)\\n    return math.min(hit.melee, 1) + math.min(hit.ranged, 1)\\nend\\n\\nif not aura_env.region.hook then\\n    aura_env.region.hook = true\\n    local func = function() \\n        C_Timer.After(0.1, function() WeakAuras.ScanEvents(\\\"GO_FARM_ANIME\\\", true) end)\\n    end\\n    \\n    LoadAddOn(\\\"Blizzard_GarrisonUI\\\")\\n    \\n    CovenantMissionFrame.MissionTab.MissionPage.Board:HookScript('OnShow', func)\\n    CovenantMissionFrame.MissionTab.MissionPage.Board:HookScript('OnHide', func)\\nend",
            ["do_custom"] = true,
        },
        ["finish"] = {
        },
    },
    ["desaturate"] = false,
    ["icon_side"] = "RIGHT",
    ["width"] = 200,
    ["icon"] = false,
    ["displayText_format_p_time_precision"] = 1,
    ["customTextUpdate"] = "event",
    ["id"] = "Z Mission Table Win Estimator",
    ["anchorPoint"] = "BOTTOM",
    ["justify"] = "LEFT",
    ["semver"] = "1.0.1",
    ["sparkHidden"] = "NEVER",
    ["sparkHeight"] = 30,
    ["frameStrata"] = 5,
    ["anchorFrameType"] = "SELECTFRAME",
    ["displayText"] = "%c",
    ["selfPoint"] = "BOTTOM",
    ["inverse"] = false,
    ["zoom"] = 0,
    ["orientation"] = "HORIZONTAL",
    ["conditions"] = {
    },
    ["information"] = {
        ["ignoreOptionsEventErrors"] = true,
    },
    ["authorOptions"] = {
        [1] = {
            ["type"] = "toggle",
            ["key"] = "details",
            ["desc"] = "Displays an additional text below the window showing more stats about the combat",
            ["useDesc"] = true,
            ["name"] = "Show details",
            ["default"] = false,
            ["width"] = 1,
        },
    },
}