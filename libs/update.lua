Import = require "import"
Environment = Import("android.os.Environment")

local Update = {}

local constants = require "libs.constants"
local json = require "cjson"

 function Update.getLocalVersion()
    return {
        version = constants.APP_VERSION,
        versionCode = constants.APP_VERSION_CODE
    }
end

 function Update.checkRemoteVersion(url, onSuccess, onError)

    Http.get(url, nil, nil, function(status_code, response)

        if status_code == 200 then

            local ok, data = pcall(json.decode, response)

            if ok and data then
    if onSuccess then
                onSuccess(data)
end
            else
                if onError then
                    onError("Invalid version.json")
                end
            end

        else

            if onError then
                onError("HTTP status code: " .. tostring(status_code))
            end

        end

    end)

end

 function Update.isUpdateAvailable(remoteData)
if not Update.validateRemoteData(remoteData) then
return false
end

    local localVersion = Update.getLocalVersion()

    return remoteData.versionCode > localVersion.versionCode
end

 function Update.validateRemoteData(data)
if type(data) ~= "table" then
return false
end

if type(data.version) ~= "string" then
return false
end

if type(data.versionCode) ~= "number" then
return false
end

if type(data.downloadUrl) ~= "string" then
return false
end

if type(data.notes) ~= "string" then
return false
end

return true
end

function Update.checkForUpdate(url, onSuccess, onError)
    Update.checkRemoteVersion(
url,
function(remoteData)
if not Update.validateRemoteData(remoteData) then
if onError then
onError("Invalid remote update data")
end
return
end

if onSuccess then
    if Update.isUpdateAvailable(remoteData) then
onSuccess(remoteData)
else
onSuccess(nil)
end
end
end,
function(Error)
if onError then
onError(Error)
end
end)
end

function Update.downloadPackage(url, path, onSuccess, onError)
    Http.download(url, path, function(status_code, response)
        if status_code == 200 then
            local file = io.open(path, "r")

            if file then
                file:close()

                if onSuccess then
                    onSuccess(path)
                end
            else
                if onError then
                    onError("Download completed, but the file was not found.")
                end
            end
        else
            if onError then
                onError(
                    "Download failed. HTTP status code: "
                    .. tostring(status_code)
                    .. " Response: "
                    .. tostring(response)
                )
            end
        end
    end)
end

function Update.getDownloadPath()
    local downloadDir = Environment.getExternalStoragePublicDirectory(
        Environment.DIRECTORY_DOWNLOADS
    )

    return tostring(downloadDir) .. "/ExtensionMaker.ppk"
end

return Update