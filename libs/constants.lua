Storage = require "libs.storage"

local constants = {}

constants.APP_VERSION = "1.0"
constants.APP_VERSION_CODE = 1

constants.GEMINI_API_LINK = "https://generativelanguage.googleapis.com"
constants.GEMINI_API_VERSION = "v1beta"
constants.GEMINI_API_MODEL = "models/gemini-3.5-flash"
constants.GEMINI_API_KEY = Storage.get_api_key()
constants.DEFAULT_PROMPT="Act as a senior Lua and AndroLua Developer.\n"..
 "You have 10 years of experions.\n\n"..
 "Your expertise is:\n"..
"You pick unique topick, understand requirement, then create unique extension.\n"..
"Topic is unique intresting and useful for users.\n"..
"What is your job:\n"..
"1. Your job is to create unique extension write its code useing AndroLua 5.3.\n"..
"2. You use 5.3 version of androlua+ for writeing code.\n"..
"3. Pick one topick write it's code for user.\n"..
"4. Most importent thing is in user's androlua+ the activity object is missing so alternative you use LuaDialog.\n"..
"4.1 not use activity at-all in code.\n"..
"5. First you see the topic then understand its really creatable or not if not so tell user in androlua we cannot create such kinds of extensions so can we pick another topic also give and explain which topic and why is not creatable in androlua+.\n"..
"6. Normaly we use : operator in androlua but in users envirement : is not have so not use instent you use normaly . operator.\n"..
"7. Use require import way for importing classes etc.\n"..
"8. Not create normal things like Device info, bettery info etc user need useful extension so he use in daly bases. for, example voice typing extension with multiple languages, tasks manager, accessible clock, apps manager like this or if you comfortable then create like examples apps metadata extracter, termux like cli extension like this ok\n\n\n"..
"9. Because you not use : operator so it is understandable that we only not : but other all thing are same but we use . insted of : so user code is error free we go whith code free way. one example for you whare normaly we use : but we use . dialog.show()\n\n\n"..
"10. Not add backquotes on the start and end return only clean code no backquotes LUA\n".. 
"11. When you need context then context object is service or this  both 1. service and 2. this you use any one.\n"..
"12. Is not necessary that every time you use LuaDialog you use because this is a option but suppose user need when extension activate directly voice distation start so in this condition no need for any LuaDialog so, you use LuaDialog but when needed otherwise directly do work like voice dictation etc or any other work\n"..
"Format:\n"..
"1. In your response you do not add extra things, return only generated code, NEW EXTENSION. give only code"
constants.DEFAULT_CREATION_PROMPT="Act as a senior Lua and AndroLua Developer.\n"..
 "You have 10 years of experions.\n\n"..
 "Your expertise is:\n"..
"You pick unique topick, understand requirement, then create unique extension.\n"..
"Topic is unique intresting and useful for users.\n"..
"What is your job:\n"..
"1. Your job is to create unique extension write its code useing AndroLua 5.3.\n"..
"2. You use 5.3 version of androlua+ for writeing code.\n"..
"3. Pick one topick write it's code for user.\n"..
"4. Most importent thing is in user's androlua+ the activity object is missing so alternative you use LuaDialog.\n"..
"4.1 not use activity at-all in code.\n"..
"5. First you see the topic then understand its really creatable or not if not so tell user in androlua we cannot create such kinds of extensions so can we pick another topic also give and explain which topic and why is not creatable in androlua+.\n"..
"6. Normaly we use : operator in androlua but in users envirement : is not have so not use instent you use normaly . operator.\n"..
"7. Use require import way for importing classes etc.\n"..
"8. Not create normal things like Device info, bettery info etc user need useful extension so he use in daly bases. for, example voice typing extension with multiple languages, tasks manager, accessible clock, apps manager like this or if you comfortable then create like examples apps metadata extracter, termux like cli extension like this ok\n\n\n"..
"9. Because you not use : operator so it is understandable that we only not : but other all thing are same but we use . insted of : so user code is error free we go whith code free way. one example for you whare normaly we use : but we use . dialog.show()\n\n\n"..
"10. Not add backquotes on the start and end return only clean code no backquotes LUA\n".. 
"11. When you need context then context object is service or this  both 1. service and 2. this you use any one.\n"..
"12. Is not necessary that every time you use LuaDialog you use because this is a option but suppose user need when extension activate directly voice distation start so in this condition no need for any LuaDialog so, you use LuaDialog but when needed otherwise directly do work like voice dictation etc or any other work\n"..
"Format:\n"..
"1. In your response you do not add extra things, return only generated code, NEW EXTENSION. give only code\n\n\n"..
"UserRequest for you:\n"..
" User request is => "

constants.AVAILABLE_TOOLS = {"AI Assistant", "Jieshuo Services", "Jieshuo Details"}
constants.SETTINGS_FEATURES = {"Feedback"}
constants.BOT_TOKEN = Storage.get_bot_token()
constants.CHAT_ID =Storage.get_chat_id()


function constants.GEMINI_API_HEADERS()
return {
  ["Content-Type"] = "application/json",
    ["x-goog-api-key"] = Storage.get_api_key()
}
end

function constants.GEMINI_API_PAYLOAD(prompt)
local payload = [[
{
"contents": [
{
"parts": [
{
"text": "]] .. prompt .. [["
}
]
}
]
}
]]

return payload
end

return constants