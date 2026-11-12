Import = require "import"
Toast = Import("android.widget.Toast")
Context = Import("android.content.Context")
ClipData = Import("android.content.ClipData")
Uri = Import("android.net.Uri")
Http = Import("com.androlua.Http")
LuaDialog = Import("com.androlua.LuaDialog")
LinearLayout = Import("android.widget.LinearLayout")
TextView = Import("android.widget.TextView")
Button = Import("android.widget.Button")
ScrollView = Import("android.widget.ScrollView")
EditText = Import("android.widget.EditText")
Constants = require "libs.constants"
Build = Import("android.os.Build")
Storage = require "libs.storage"

local app = {}

function app.copyToClipboard(text)
local clipboard = this.getSystemService(Context.CLIPBOARD_SERVICE)
local clip = ClipData.newPlainText("Text_Copyed", text)
clipboard.setPrimaryClip(clip)
Toast.makeText(this, "Code copy to clipboard", Toast.LENGTH_SHORT).show()
end

function app.showSettingsScreen()
local userName = Storage.get_user_name() or Storage.get_developer_name() or "Unknown"
local role = Storage.get_app_role() or "Unknown"

local layout = {
LinearLayout,
orientation="vertical",
layout_width="fill",
layout_height="fill",

{
ScrollView,
id="scroll",
layout_width="fill",

{
LinearLayout,
id="settingsOptionsList",
orientation="vertical",
layout_width="fill",

{
TextView,
id="userNameTV",
text= string.format("%s: %s", role, userName),
layout_width="fill",
},

{
Button,
id="manageProfileBTN",
text="Manage Profile",
layout_width="fill",
},

{
Button,
id="clearAllBTN",
text="Delete All Data",
layout_width="fill",
},

},
},
}

local dialog = LuaDialog()
dialog.setTitle("ExtensionMaker Settings")
dialog.setView(loadlayout(layout))
dialog.setButton("Close", nil)
dialog.show()

clearAllBTN.onClick = function()
app.createDialog({
title="Delete",
message="Are you sure, you want to delete all data?",
positiveButtonText="Yes",
positiveButtonFunction=function()
Storage.clearAll()
Toast.makeText(this, "Data deleted successfully", Toast.LENGTH_SHORT).show()
end,
negativeButtonText="No",
negativeButtonFunction=function()

end
})
end

end

function app.createDialog(...)
local layout = ...

local dialog = LuaDialog()
dialog.setTitle(layout.title or "")
dialog.setMessage(layout.message or "")
dialog.setPositiveButton(layout.positiveButtonText or "", layout.positiveButtonFunction or nil)
dialog.setNegativeButton(layout.negativeButtonText or "", layout.negativeButtonFunction or nil)
dialog.show()
end

function app.getCorrectString(str)
if type(str) ~= "string" then return "" end

return str:gsub("[%[%]']", " ")
end

function app.show_role_selection(onSelected)
local dialog = LuaDialog()
dialog.setTitle("ExtensionMaker Setup")
dialog.setMessage("Who are you?")

dialog.setButton("User", function()
onSelected("User")
dialog.hide()
end)

dialog.setButton2("Developer", function()
onSelected("Developer")
dialog.hide()
end)

dialog.show()
end

function app.dialog(title, message)
local luaDialog = LuaDialog()
luaDialog.setTitle(title)
luaDialog.setMessage(tostring(message))
luaDialog.setButton("OK", nil)
luaDialog.show()
end

function app.sendFeedback(user_text, onResult)
local BOT_TOKEN = Constants.BOT_TOKEN
local CHAT_ID = Constants.CHAT_ID
local fullMessage = "New feedback from 'ExtensionMaker' jieshuo extension\n\n\n"..user_text.."\n\n\nDevice: "..Build.MODEL
local encoded = Uri.encode(fullMessage)
local url = "https://api.telegram.org/bot"..BOT_TOKEN.."/sendMessage?chat_id="..CHAT_ID.."&text="..encoded

Http.get(url, function(code, body)
if code == 200 then
onResult("SUCCESS", "Feedback Sent Successfully!")
else
onResult("FAILED", "Failed: "..tostring(body))
end
end)
end


return app