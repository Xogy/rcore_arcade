Config = {}

-- Which translation you wish to use ?
Config.Locale = "en"

-- Key settings
Config.keyToOpenTicketMenu = "E"
Config.keyToOpenComputer = "E"

-- Marker for buying ticket
Config.Arcade = {
    {
        NPC = {
            position = vector3(-1083.19, -245.78, 36.75),
            heading = 205.11,
            model = "ig_claypain",
        },
        blip = {
            position = vector3(-1082.12, -247.57, 36.8),
            blipId = 521,
            scale = 1.0,
            color = 0,
            name = "Arcade house",
            shortRange = true,
            enable = true,
        },
        marker = {
            markerPosition = vector3(-1082.12, -247.57, 37.2),
            markerType = 23,
            options = {
                scale = { x = 1.0, y = 1.0, z = 1.0 },
                color = { r = 255, g = 255, b = 255, a = 125 },
            }
        },
    },
        -- GABZ ARCADE!!!!!
    --[[
    {
        NPC = {
            position = vector3(-1659.14, -1062.72, 12.17),
            heading = 226.17,
            model = "ig_claypain",
        },
        blip = {
            position = vector3(-1082.12, -247.57, 36.8),
            blipId = 521,
            scale = 1.0,
            color = 0,
            name = "Gabz Arcade",
            shortRange = true,
            enable = false,
        },
        marker = {
            markerPosition = vector3(-1649.2, -1062.78, 12.17),
            markerType = 23,
            options = {
                scale = { x = 1.0, y = 1.0, z = 1.0 },
                color = { r = 255, g = 255, b = 255, a = 125 },
            }
        },
    },--]]
}

-- ticket price, and time in arcade.
Config.ticketPrice = {
    [_U("bronz")] = {
        price = 300,
        time = 10, -- in minutes
    },
    [_U("silver")] = {
        price = 600,
        time = 20, -- in minutes
    },
    [_U("gold")] = {
        price = 900,
        time = 30, -- in minutes
    },
}

-- is arcade payed ?
Config.enableGameHouse = true
-- do not change unless you know what you're doing
Config.GPUList = {
    [1] = "ETX2080",
    [2] = "ETX1050",
    [3] = "ETX660",
}

-- do not change unless you know what you're doing
Config.CPUList = {
    [1] = "U9_9900",
    [2] = "U7_8700",
    [3] = "U3_6300",
    [4] = "BENTIUM",
}

Config.MyList = {
    {
        name = "name",
        link = "bleh",
    },
}

-- game list for retro machine
Config.RetroMachine = {
    {
        name = "Pacman",
        link = "http://xogos.robinko.eu/PACMAN/",
    },
    {
        name = "Tetris",
        link = "http://xogos.robinko.eu/TETRIS/",
    },
    {
        name = "Ping Pong",
        link = "http://xogos.robinko.eu/PONG/",
    },
    {
        name = "DOOM",
        link = string.format("nui://rcore_arcade/html/msdos.html?url=%s&params=%s", "https://www.retrogames.cz/dos/zip/Doom.zip", "./DOOM.EXE"),
    },
    {
        name = "Duke Nukem 3D",
        link = string.format("nui://rcore_arcade/html/msdos.html?url=%s&params=%s", "https://www.retrogames.cz/dos/zip/duke3d.zip", "./DUKE3D.EXE"),
    },
    {
        name = "Wolfenstein 3D",
        link = string.format("nui://rcore_arcade/html/msdos.html?url=%s&params=%s", "https://www.retrogames.cz/dos/zip/Wolfenstein3D.zip", "./WOLF3D.EXE"),
    },
    -- emulatorjs powers this second page, it takes in a rom url, a "core" type (eg nes, snes, etc) a game name, and an id for network play (yep! some cores support network play!)
    -- for more info see : 
    -- https://github.com/ethanaobrien/emulatorjs/tree/main/docs
    {
        name = "Circus Charlie",
        link = string.format("nui://rcore_arcade/html/ejs.html?url=%s&params=%s&name=%s&id=%s", "https://www.retrogames.cz/NES/Circus_Charlie.nes", "nes", "Circus_Charlie-nes", "4201"),
    },
    {
        name = "Sonic The Hedgehog",
        link = string.format("nui://rcore_arcade/html/ejs.html?url=%s&params=%s&name=%s&id=%s", "https://www.retrogames.cz/Genesis/SonictheHedgehog.zip", "segaMD", "SonictheHedgehog-segaMD", "4202"),
    },
    -- some cores require a bios, you may pass it in like this
    {
        name = "Pokemon Ruby",
        link = string.format("nui://rcore_arcade/html/ejs.html?url=%s&params=%s&name=%s&id=%s&bios=%s", "https://static.emulatorgames.net/roms/gameboy-advance/Pokemon%20-%20Ruby%20Version%20(U)%20(V1.1).zip", "gba", "PokemonRuby-gba", "4203", "https://phoenixnap.dl.sourceforge.net/project/gameboid/gba_bios907607290.bin"),
    },
    -- you may need to encode characters such as "&" in urls, or the query parser might get confused.
    {
        name = "Kirby & The Amazing Mirror",
        link = string.format("nui://rcore_arcade/html/ejs.html?url=%s&params=%s&name=%s&id=%s&bios=%s", "https://static.emulatorgames.net/roms/gameboy-advance/Kirby%20%26%20The%20Amazing%20Mirror%20(U).zip", "gba", "KirbyTheAmazingMirror-gba", "4204", "https://phoenixnap.dl.sourceforge.net/project/gameboid/gba_bios907607290.bin"),
    },
    {
        name = "Contra III",
        link = string.format("nui://rcore_arcade/html/ejs.html?url=%s&params=%s&name=%s&id=%s", "https://static.emulatorgames.net/roms/super-nintendo/Contra%20III%20-%20The%20Alien%20Wars%20(U)%20[!].zip", "snes", "Contraiii-snes", "4205"),
    },
    {
        name = "Metal Slug X (BIG!)", -- BIG GAME! will take a while to download/boot up
        link = string.format("nui://rcore_arcade/html/ejs.html?url=%s&params=%s&name=%s&id=%s&bios=%s", "https://static.emulatorgames.net/roms/playstation/Metal%20Slug%20X%20(U)%20[SLUS-01212].7z", "psx", "MSLUGX-psx", "4206", "https://dl.hexrom.com/rom/psx-bios-SCPH1001-hexrom_com.zip"),
    },
}

-- game list for gaming machine
Config.GamingMachine = {
    {
        name = "Slide a Lama",
        link = "http://lama.robinko.eu/fullscreen.html",
    },
    {
        name = "Uno",
        link = "https://duowfriends.eu/",
    },
    {
        name = "Ants",
        link = "http://ants.robinko.eu/fullscreen.html",
    },
    {
        name = "FlappyParrot",
        link = "http://xogos.robinko.eu/FlappyParrot/",
    },
    {
        name = "Zoopaloola",
        link = "http://zoopaloola.robinko.eu/Embed/fullscreen.html"
    }
}

-- game list for super computer
Config.SuperMachine = {}

for i = 1, #Config.RetroMachine do
    table.insert(Config.SuperMachine, Config.RetroMachine[i])
end

for i = 1, #Config.GamingMachine do
    table.insert(Config.SuperMachine, Config.GamingMachine[i])
end

-- computer list in world
Config.computerList = {
    -- Retro machines
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.RetroMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 31,
        position = vector3(-1080.11, -245.35, 44.5),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 255, g = 255, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.RetroMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 31,
        position = vector3(-1079.25, -244.9, 44.5),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 255, g = 255, b = 255, a = 125 },
            rotate = true,
        },
    },
    -- Gaming computers
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(-1063.7, -246.7, 44.5),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(-1060.2, -244.85, 44.5),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(-1055.7, -246.12, 44.5),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(-1053.96, -241.8, 44.5),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(-1056.14, -243.42, 44.5),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(-1050.76, -240.9, 44.5),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(-1050.03, -243.51, 44.5),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(-1062.44, -248.98, 44.5),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    -- Super machines

    ------ GABZ ARCADE!!!!!! -------
    --[[
    -- Retro machines
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.RetroMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 31,
        position = vector3(-1648.34, -1076.46, 12.17),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 255, g = 255, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.RetroMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 31,
        position = vector3(-1649.31, -1077.57, 12.17),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 255, g = 255, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.RetroMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 31,
        position = vector3(-1649.41, -1074.78, 12.17),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 255, g = 255, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
            -- if false player dont need a ticket to play on this computer.
            isInGamingHouse = true,
            computerType = Config.RetroMachine,
            computerGPU = Config.GPUList[2],
            computerCPU = Config.CPUList[2],
            markerType = 31,
            position = vector3(-1650.14, -1074.18, 12.17),
            markerOptions = {
                scale = { x = 0.5, y = 0.5, z = 0.5 },
                color = { r = 255, g = 255, b = 255, a = 125 },
                rotate = true,
            },
        },
        {
            -- if false player dont need a ticket to play on this computer.
            isInGamingHouse = true,
            computerType = Config.RetroMachine,
            computerGPU = Config.GPUList[2],
            computerCPU = Config.CPUList[2],
            markerType = 31,
            position = vector3(-1650.83, -1073.58, 12.17),
            markerOptions = {
                scale = { x = 0.5, y = 0.5, z = 0.5 },
                color = { r = 255, g = 255, b = 255, a = 125 },
                rotate = true,
            },
        },
        {
            -- if false player dont need a ticket to play on this computer.
            isInGamingHouse = true,
            computerType = Config.RetroMachine,
            computerGPU = Config.GPUList[2],
            computerCPU = Config.CPUList[2],
            markerType = 31,
            position = vector3(-1650.23, -1078.69, 12.17),
            markerOptions = {
                scale = { x = 0.5, y = 0.5, z = 0.5 },
                color = { r = 255, g = 255, b = 255, a = 125 },
                rotate = true,
            },
        },
        {
            -- if false player dont need a ticket to play on this computer.
            isInGamingHouse = true,
            computerType = Config.RetroMachine,
            computerGPU = Config.GPUList[2],
            computerCPU = Config.CPUList[2],
            markerType = 31,
            position = vector3(-1648.34, -1076.46, 12.17),
            markerOptions = {
                scale = { x = 0.5, y = 0.5, z = 0.5 },
                color = { r = 255, g = 255, b = 255, a = 125 },
                rotate = true,
            },
        },
        {
            -- if false player dont need a ticket to play on this computer.
            isInGamingHouse = true,
            computerType = Config.RetroMachine,
            computerGPU = Config.GPUList[2],
            computerCPU = Config.CPUList[2],
            markerType = 31,
            position = vector3(-1652.28, -1075.75, 12.17),
            markerOptions = {
                scale = { x = 0.5, y = 0.5, z = 0.5 },
                color = { r = 255, g = 255, b = 255, a = 125 },
                rotate = true,
            },
        },
        {
                -- if false player dont need a ticket to play on this computer.
                isInGamingHouse = true,
                computerType = Config.RetroMachine,
                computerGPU = Config.GPUList[2],
                computerCPU = Config.CPUList[2],
                markerType = 31,
                position = vector3(-1652.94, -1075.19, 12.17),
                markerOptions = {
                    scale = { x = 0.5, y = 0.5, z = 0.5 },
                    color = { r = 255, g = 255, b = 255, a = 125 },
                    rotate = true,
                },
            },
            {
                -- if false player dont need a ticket to play on this computer.
                isInGamingHouse = true,
                computerType = Config.RetroMachine,
                computerGPU = Config.GPUList[2],
                computerCPU = Config.CPUList[2],
                markerType = 31,
                position = vector3(-1653.65, -1074.64, 12.17),
                markerOptions = {
                    scale = { x = 0.5, y = 0.5, z = 0.5 },
                    color = { r = 255, g = 255, b = 255, a = 125 },
                    rotate = true,
                },
            },
            {
                -- if false player dont need a ticket to play on this computer.
                isInGamingHouse = true,
                computerType = Config.RetroMachine,
                computerGPU = Config.GPUList[2],
                computerCPU = Config.CPUList[2],
                markerType = 31,
                position = vector3(-1654.22, -1074.14, 12.17),
                markerOptions = {
                    scale = { x = 0.5, y = 0.5, z = 0.5 },
                    color = { r = 255, g = 255, b = 255, a = 125 },
                    rotate = true,
                },
            },
    -- Gaming computers
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(-1649.89, -1065.79, 12.17),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(-1650.31, -1066.32, 12.17),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(-1650.84, -1066.97, 12.17),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(-1651.38, -1067.58, 12.17),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(-1651.9, -1068.22, 12.17),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(-1652.47, -1068.92, 12.17),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(-1655.21, -1068.46, 12.17),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(-1654.7, -1067.76, 12.17),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(-1657.34, -1068.65, 12.17),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(-1657.59, -1066.58, 12.17),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    -- Gaming computers
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(-1660.27, -1067.52, 12.17),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(-1660.25, -1068.43, 12.17),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(-1660.18, -1069.31, 12.17),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(-1659.81, -1070.1, 12.17),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(-1655.21, -1068.46, 12.17),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(-1654.7, -1067.76, 12.17),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(-1657.34, -1068.65, 12.17),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(-1657.59, -1066.58, 12.17),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    -- Super machines
    --]]
}
