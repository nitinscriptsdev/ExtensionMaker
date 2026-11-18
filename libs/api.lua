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

function api.sendFeedback(message, onSuccess, onError)
    local url = constants.FEEDBACK_API_URL

    if url == nil or url == "" then
        return onError("Feedback API URL is not configured.")
    end

    local payload = json.encode({
        message = message,
        appVersion = constants.APP_VERSION,
        device = tostring(Build.MODEL)
    })

    local headers = {
        ["Content-Type"] = "application/json"
    }

    Http.post(url, payload, headers, function(status_code, response)
        if status_code == 200 then
            return onSuccess(response)
        else
            return onError(
                "HTTP status code: " ..
                tostring(status_code) ..
                " Response: " ..
                tostring(response)
            )
        end
    end)
end

return api