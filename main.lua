Import = require "import"
LinearLayout = Import("android.widget.LinearLayout")
TextView = Import("android.widget.TextView")
Button = Import("android.widget.Button")
ScrollView = Import("android.widget.ScrollView")
Toast = Import("android.widget.Toast")
EditText = Import("android.widget.EditText")
App = require "libs.app"
Account = require "libs.account"
Storage = require "libs.storage"
Api = require "libs.api"
Constants = require "libs.constants"
Update = require "libs.update"

-- Check for update
Update.checkForUpdate(
"https://raw.githubusercontent.com/nitinscriptsdev/ExtensionMaker/main/version.json",
function(updateData)
if updateData then

App.createDialog({
title = "Update Available",
message = "Version " .. updateData.version .. " is available.\n\n" .. updateData.notes,

positiveButtonText = "Update",
positiveButtonFunction = function()

local downloadPath = Update.getDownloadPath()

Update.downloadPackage(
updateData.downloadUrl,
downloadPath,

function(path)

-- Open downloaded package for import
service.installApk(downloadPath)
end,

function(errorMessage)
App.dialog(
"Download Failed",
"The update could not be downloaded.\n\nPlease check your internet connection and try again later.\n\nError: "..tostring(errorMessage)
)
end
)

end,

negativeButtonText = "Later",
negativeButtonFunction = function()

-- Speak later message
service.speak("Later")
end
})

end
end,
function(errorMessage)
-- Ignore update-check errors for now
end
)

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

{
TextView,
id="generationStatus",
text="",
layout_width="fill",
layout_height="wrap",
},

},
},
}


local dialog = LuaDialog()
dialog.setTitle("ExtensionMaker")
dialog.setView(loadlayout(layout))
dialog.setNegativeButton("Close", nil)
dialog.show()

function feedbackBTN.onClick()
App.sendFeedback(function(err)
if err then
App.dialog("Error", err)
end
end)
dialog.dismiss()
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

function cleanResponse(response)
if type(response) ~= "string" then
return ""
end

response = response:gsub("^%s*```%w*%s*", "")
response = response:gsub("%s*```%s*$", "")

return response
end

function generateNew.onClick()
local prompt = Constants.DEFAULT_PROMPT

-- Toast message
Toast.setText(this, "Processing start", Toast.LENGTH_LONG).show()

-- Show generation message
generationStatus.setText("Generating...")

-- Disable create and generate new buttons
createBTN.setEnabled(false)
generateNew.setEnabled(false)

-- Send request to AI
Api.getGeminiResponse(tostring(prompt), function(message)

-- Toast message
Toast.setText(this,"Processing complete", Toast.LENGTH_LONG).show()

-- Add AI response
addNew(cleanResponse(message))

-- Hide generation status
generationStatus.setText("")

-- Enable create and generate new buttons
createBTN.setEnabled(true)
generateNew.setEnabled(true)
end,
function(message)

-- Add tokens details
addNew(message)
end)
end

function createBTN.onClick()
local user_request = tostring(creationET.text)
local system_prompt = Constants.DEFAULT_CREATION_PROMPT
local prompt = system_prompt .. user_request

-- Toast message
Toast.setText(this, "Processing start", Toast.LENGTH_LONG).show()

-- Show generation message
generationStatus.setText("Generating...")

-- Disable create and generate new buttons
createBTN.setEnabled(false)
generateNew.setEnabled(false)

-- Send response to AI
Api.getGeminiResponse(tostring(prompt), function(message)

-- Toast message
Toast.setText(this, "Processing complete", Toast.LENGTH_LONG).show()

-- Show AI response
addNew(cleanResponse(message))

-- Hide generation status
generationStatus.setText("")

-- Enable create and generate new buttons
createBTN.setEnabled(true)
generateNew.setEnabled(true)
end,
function(message)

-- Add tokens details
addNew(message)
end)

end

function settingsBTN.onClick()
App.showSettingsScreen()
end

