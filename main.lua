Import = require "import"
LinearLayout = Import("android.widget.LinearLayout")
TextView = Import("android.widget.TextView")
Button = Import("android.widget.Button")
ScrollView = Import("android.widget.ScrollView")
EditText = Import("android.widget.EditText")
App = require "libs.app"
Account = require "libs.account"
Storage = require "libs.storage"
Api = require "libs.api"
Constants = require "libs.constants"
Update = require "libs.update"

-- Show ExtensionMaker setup screen
 local app_role = Storage.has_app_role()

if not app_role then
App.show_role_selection(function(selected)

if selected == "User" then
Account.setupUserProfile()
elseif selected == "Developer" then
Account.add_developer_profile()
end
end)
return
end

local layout = {
LinearLayout,
orientation="vertical",
layout_width="fill",
layout_height="fill",

{
ScrollView,
id="topScroll",
layout_width="fill",

{
LinearLayout,
orientation="vertical",

{
EditText,
id="creationET",
hint="What do you want to get created? ",
},

{
Button,
id="createBTN",
text="Create",
layout_width="fill",
},

{
Button,
id="generateNew",
text="Generate New",
layout_width="fill",
layout_height="wrap",
},

{
Button,
id="feedbackBTN",
text="Send Feedback or Suggestions",
layout_width="fill",
layout_height="wrap",
},

{
Button,
id="settingsBTN",
text="Settings",
layout_width="fill",
layout_height="wrap",
},
},
},

{
ScrollView,
id="scroll",
layout_width="fill",
layout_height=0,
layout_weight=1,

{
LinearLayout,
id="extensionsList",
orientation="vertical",
},
},
}

local feedbackLayout = {
EditText,
id="user_feedback",
hint="What is your suggestion? ",
layout_width="fill",
layout_height="wrap",
}

local dialog = LuaDialog()
dialog.setTitle("ExtensionMaker")
dialog.setView(loadlayout(layout))
dialog.setNegativeButton("Close", nil)
dialog.show()

function feedbackBTN.onClick()
local dialog = LuaDialog()
dialog.setTitle("Send Feedback or Suggestion")
dialog.setView(loadlayout(feedbackLayout))
dialog.setPositiveButton("Send", function()
local feedbackText = tostring(user_feedback.text)

App.	sendFeedback(feedbackText, function(status, result)
App.dialog(status, result)
end)
end)
dialog.setNegativeButton("Cancel", nil)
dialog.show()
end

function addNew(new)
local code= TextView()
code.setText(tostring(new))

local copy = Button()
copy.setText("Copy")
copy.onClick = function()
local text = tostring(code.text)
App.copyToClipboard(text)
end
extensionsList.addView(code)
extensionsList.addView(copy)
end


function generateNew.onClick()
local prompt = Constants.DEFAULT_PROMPT

Api.getGeminiResponse(tostring(prompt), function(message)
addNew(message)
end,
function(message)
addNew(message)
end)
end

function createBTN.onClick()
local user_request = tostring(creationET.text)
local system_prompt = Constants.DEFAULT_CREATION_PROMPT
local prompt = system_prompt .. user_request

Api.getGeminiResponse(tostring(prompt), function(message)
addNew(message)
end,
function(message)
addNew(message)
end)

end

function settingsBTN.onClick()
App.showSettingsScreen()
end
