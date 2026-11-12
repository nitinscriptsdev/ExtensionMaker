Import = require "import"
TextView = Import("android.widget.TextView")
LuaDialog = Import("com.androlua.LuaDialog")
EditText = Import("android.widget.EditText")
View = Import("android.view.View")
LinearLayout = Import("android.widget.LinearLayout")
Button = Import("android.widget.Button")
ScrollView = Import("android.widget.ScrollView")
Toast = Import("android.widget.Toast")
Storage = require "libs.storage"
account = {}

function account.add_developer_profile()
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
orientation="vertical",
layout_width="fill",

{
TextView,
text="Enter Developer Name",
layout_width="fill",
layout_height="wrap",
},

{
EditText,
id="developerName",
hint="Name",
layout_width="fill",
},

{
TextView,
text="Enter Strong Password",
layout_width="fill",
layout_height="wrap",
},

{
EditText,
id="developerPassword",
hint="Password",
layout_width="fill",
},

{
TextView,
text="Enter Telegram Bot Token",
layout_width="fill",
layout_height="fill",
},

{
EditText,
id="developerToken",
hint="Token",
layout_width="fill",
},

{
TextView,
text="Enter Telegram Chat ID",
layout_width="fill",
layout_height="wrap",
},

{
EditText,
id="developerId",
hint="ID",
},
},
},
}

local dialog = LuaDialog()
dialog.setTitle("Setup Developer Profile")
dialog.setView(loadlayout(layout))
dialog.setPositiveButton("Save", function()
local name = developerName.text
local password = developerPassword.text
local token = developerToken.text
local id = developerId.text

if name ~= nil and name ~= "" and password ~= nil and password ~= "" and token ~= nil and token ~= "" and id ~= nil and id ~= "" then
Storage.save_developer_name(name)
Storage.save_password(password)
Storage.save_bot_token(token)
Storage.save_chat_id(id)
Storage.save_app_role("Developer")
dialog.hide()
else
Toast.makeText(this, "Enter complete details", Toast.LENGTH_SHORT).show()
end
end)
dialog.setNegativeButton("Cancel", nil)
dialog.show()
end

function account.add_user_name()
 layout = {
EditText,
id="user_name",
hint = "Enter user name",
gravity = "center",
}

local dlg = LuaDialog()
dlg.setTitle("Add user name")
dlg.setView(loadlayout	(layout))
dlg.setPositiveButton("Save", function()
local username = tostring(user_name.text)

if username ~= nil and username ~= "" then
Storage.save_user_name(username)
dlg.hide()
else
Toast.makeText(activity, "Please, Enter User Name.", Toast.LENGTH_SHORT).show()
end
end)
dlg.show()
end

function account.setupUserProfile()
local layout = {
LinearLayout,
orientation="vertical",
layout_width="fill",
layout_height="fill",

{
TextView,
id="userNameTV",
text="Enter unique user name",
layout_width="fill",
},

{
EditText,
id="userNameET",
hint="UserName",
layout_width="fill",
},

{
TextView,
id="apiKeyTV",
text="Enter Gemini APIKey",
layout_width="fill",
},

{
EditText,
id="api_key",
hint = "APIKey",
gravity = "center",
layout_width="fill",
},
}

local dlg = LuaDialog()
dlg.setTitle("Setup User Profile")
dlg.setView(loadlayout	(layout))
dlg.setPositiveButton("Save", function()
local name = userNameET.text
local apikey = tostring(api_key.text)

if name ~= nil and name ~= "" and apikey ~= nil and apikey ~= "" then
Storage.save_user_name(name)
Storage.save_api_key(apikey)
Storage.save_app_role("User")
dlg.hide()
else
Toast.makeText(this, "Enter Complete Details", Toast.LENGTH_SHORT).show()
end
end)
dlg.setNegativeButton("Cancel", nil)
dlg.show()
end


return account