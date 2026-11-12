json = require "cjson"
constants = require "libs.constants"

local api = {}

function api.getGeminiResponse(prompt, onSuccess, onTokensDetails)
local url = constants.GEMINI_API_LINK .. "/" .. constants.GEMINI_API_VERSION .. "/" .. constants.GEMINI_API_MODEL .. ":generateContent"
local headers = constants.GEMINI_API_HEADERS()
local JSON_PAYLOAD = constants.GEMINI_API_PAYLOAD(prompt)

Http.post(url, JSON_PAYLOAD, headers, function(status_code, response)
if status_code == 200 then
local result = json.decode(response)

if result.candidates and result.candidates[1] and result.candidates[1].content and result.candidates[1].content.parts and result.candidates[1].content.parts[1] then
 onSuccess(result.candidates[1].content.parts[1].text)
if result.usageMetadata then
onTokensDetails(result.usageMetadata.totalTokenCount)
end
end
else
return onSuccess("Error: HTTP status code: " .. tostring(status_code) .. " Response: " .. tostring(response))
end
end)

end

return api