Storage = require "libs.storage"
json = require "cjson"

local constants = {}

constants.APP_VERSION = "1.1-beta.3"
constants.APP_VERSION_CODE = 4

constants.GEMINI_API_LINK = "https://generativelanguage.googleapis.com"
constants.GEMINI_API_VERSION = "v1beta"
constants.GEMINI_API_MODEL = "models/gemini-3.5-flash"
constants.GEMINI_API_KEY = Storage.get_api_key()
constants.COMMON_GENERATION_PROMPT =
"Act as a senior Lua and AndroLua developer.\n" ..
"You have extensive experience developing production-ready Jieshuo extensions.\n\n" ..

"Target environment:\n" ..
"1. Write code specifically for AndroLua 5.3.\n" ..
"2. The activity object is not available in the user's environment. Never use activity.\n" ..
"3. When a context object is needed, use service or this.\n" ..
"4. Always include every Java, Android, and AndroLua class/library import that the generated code actually uses.\n" ..
"5. Put all required imports at the beginning of the generated code.\n" ..
"6. Use the project's require \"import\" style for importing Java, Android, and AndroLua classes.\n" ..
"7. Do not assume that Java or Android classes are automatically available.\n\n" ..

"Java and Android API rules:\n" ..
"8. When calling a Java or Android object method, use dot syntax.\n" ..
"9. Do not pass the object itself as an additional first argument.\n" ..
"10. For example, use dialog.setTitle(\"Title\"), not dialog.setTitle(dialog, \"Title\").\n" ..
"11. Use dialog.show(), not dialog.show(dialog).\n" ..
"12. Do not blindly convert a Java or Android method call by adding the object as the first argument.\n" ..
"13. Use the method signature required by the actual Java or Android API.\n\n" ..

"Dialog rules:\n" ..
"14. Always use com.androlua.LuaDialog for dialogs and dialog-based user interfaces.\n" ..
"15. Never use android.app.AlertDialog.\n" ..
"16. Never use AlertDialog.Builder.\n" ..
"17. If a dialog is required, import com.androlua.LuaDialog correctly and create the dialog using the AndroLua LuaDialog API.\n\n" ..

"Lua rules:\n" ..
"18. Write valid Lua 5.3 code.\n" ..
"19. Do not use Lua syntax that is incompatible with Lua 5.3.\n" ..
"20. Do not blindly change Lua syntax merely to imitate Java syntax.\n" ..
"21. Keep Lua functions, tables, variables, loops, conditions, and error handling valid for the target environment.\n\n" ..

"Extension rules:\n" ..
"22. Generate a complete, usable Jieshuo extension, not a partial code fragment.\n" ..
"23. The extension should provide a useful real-world function.\n" ..
"24. Do not generate trivial examples such as basic battery information, device information, or simple hello-world extensions unless the user specifically requests them.\n" ..
"25. Before generating code, determine whether the requested functionality is technically possible in AndroLua 5.3.\n" ..
"26. Do not use APIs, libraries, classes, or features that are unavailable in the target environment.\n\n" ..

"Output rules:\n" ..
"27. Return clean Lua source code only.\n" ..
"28. Do not use Markdown code fences.\n" ..
"29. Do not add explanations before the code.\n" ..
"30. Do not add explanations after the code.\n" ..
"31. Do not include phrases such as \"Here is your code\" or \"Here is the extension\".\n" ..
"32. Make sure the final output is directly usable as an ExtensionMaker-generated extension.\n"


constants.DEFAULT_PROMPT =
constants.COMMON_GENERATION_PROMPT ..
"\nGeneration task:\n" ..
"Choose a unique, useful and interesting extension topic yourself and generate the complete extension code."

constants.DEFAULT_CREATION_PROMPT =
constants.COMMON_GENERATION_PROMPT ..
"\nGeneration task:\n" ..
"Create the extension based on the user's request below.\n\n" ..
"User request:\n"

constants.FEEDBACK_API_URL = ""
constants.BOT_TOKEN = Storage.get_bot_token()
constants.CHAT_ID =Storage.get_chat_id()


function constants.GEMINI_API_HEADERS()
return {
  ["Content-Type"] = "application/json",
    ["x-goog-api-key"] = Storage.get_api_key()
}
end

function constants.GEMINI_API_PAYLOAD(prompt)
local payload = {
contents = {
parts = {
text = prompt
}
}
}

return json.encode(payload)
end

return constants