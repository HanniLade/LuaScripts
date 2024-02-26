-- Modified version of AIO Divination by JCurtis
-- Original Author: JCurtis
-- Modified by Goblins to remove long sleeps, remove gui, add inventory check, add timeout, add random events
-- Further modified by HanniLade to make it work on all wisp types, xp tracker, catch chronicle fragments, and work on current rs version

local API = require("api")
local UTILS = require("utils")

local player = API.GetLocalPlayerName()
local timeout = os.time() + 300
local idle_time = os.time()
local startTime os.time()
local afk = os.time()

local aioSelect = API.CreateIG_answer()
local aioOptions = {
    {
        label = "Pale Wisps",
        ids = {
            npc = 18150
        }
    },
    {
        label = "Flickering Wisps",
        ids = {
            npc = 18151
        }
    },
    {
        label = "Bright Wisps",
        ids = {
            npc = 18153
        }
    },
    {
        label = "Glowing Wisps",
        ids = {
            npc = 18155
        }
    },
    {
        label = "Sparkling Wisps",
        ids = {
            npc = 18157
        }
    },
    {
        label = "Gleaming Wisps",
        ids = {
            npc = 18159
        }
    },
    {
        label = "Vibrant Wisps",
        ids = {
            npc = 18161
        }
    },
    {
        label = "Lustrous Wisps",
        ids = {
            npc = 18163
        }
    },
    {
        label = "Elder Wisps",
        ids = {
            npc = 13614
        }
    },
    {
        label = "Brilliant Wisps",
        ids = {
            npc = 18165
        }
    },
    {
        label = "Radiant Wisps",
        ids = {
            npc = 18167
        }
    },
    {
        label = "Luminous Wisps",
        ids = {
            npc = 18169
        }
    },
    {
        label = "Incandescent Wisps",
        ids = {
            npc = 18171
        }
    },
}

local selectedNPC = nil

local function setupGUI()
    IGP = API.CreateIG_answer()
    IGP.box_start = FFPOINT.new(5, 20, 0)
    IGP.box_name = "PROGRESSBAR"
    IGP.colour = ImColor.new(51, 10, 128);
    IGP.string_value = "AIO DIVINATION by JCurtis"
end

local function setupBackground()
    

    IG_Back = API.CreateIG_answer();
    IG_Back.box_name = "back";
    IG_Back.box_start = FFPOINT.new(0, 0, 0)
    IG_Back.box_size = FFPOINT.new(440, 50, 0)
    IG_Back.colour = ImColor.new(0,0,0, 160)
    IG_Back.string_value = ""

    IG_Text = API.CreateIG_answer();
    IG_Text.box_start = FFPOINT.new(60, 3, 0)
    IG_Text.box_name = "TXT"
    IG_Text.colour = ImColor.new(51, 10, 128);
    IG_Text.string_value = "AIO Divination by JCurtis - Modified by HanniLade"

    API.DrawSquareFilled(IG_Back)
    API.DrawTextAt(IG_Text)
end

local function setupOptions()
    aioSelect.box_name = "AIO"
    aioSelect.box_start = FFPOINT.new(1,8,0)
    aioSelect.stringsArr = {}
    aioSelect.box_size = FFPOINT.new(440, 0, 0)

    table.insert(aioSelect.stringsArr, "Select an option")

    for i, v in ipairs(aioOptions) do
        table.insert(aioSelect.stringsArr, v.label)
    end

    API.DrawComboBox(aioSelect, false)
end

setupBackground()
setupOptions()
setupGUI()

local function idle()
    if os.time() > idle_time then
        print("idle")
        API.PIdle2()
        idle_time = os.time() + math.random(60, 250)
    end
end

API.SetDrawTrackedSkills(true)
API.ScriptRuntimeString()
API.GetTrackedSkills()

while API.Read_LoopyLoop() do
    if (aioSelect.return_click) then
        aioSelect.return_click = false
        
        for i, v in ipairs(aioOptions) do
            if (aioSelect.string_value == v.label) then
                selectedNPC = v.ids.npc
            end
        end
    end

    if API.InvFull_() then
        API.DoAction_Object1(0xc8,0,{ 87306 },50)
        API.DoAction_Object1(0xc8,0,{ 93489 },50);
        timeout = os.time() + 300
        API.RandomSleep2(600, 0, 600)
    end

    if not API.IsPlayerAnimating_(player, 100) and (not API.InvFull_()) then
        print("Harvest")
        API.DoAction_NPC(0xc8,1488,{ selectedNPC },50)
    end

    if os.time() > timeout then
        print("Timeout")
        API.Write_LoopyLoop(false)
        return
    end

    idle()
        API.DoRandomEvent(18204)
end

API.SetDrawTrackedSkills(false)