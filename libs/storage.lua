storage = {}

local PREF_NAME = "Extension_Maker"
local USER_NAME = "User_Name"
local API_KEY = "Api_Key"
local BOT_TOKEN = "Bot_Token"
local CHAT_ID = "Chat_Id"
local DEVELOPER_NAME = "Developer_Name"
local PASSWORD = "Developer_Password"
local APP_ROLE = "App_Role"
local preferences = this.getSharedPreferences(PREF_NAME, 0)

function storage.save_app_role(role)
preferences.edit().putString(APP_ROLE, role).apply()
end

function storage.get_app_role()
return preferences.getString(APP_ROLE, nil)
end

function storage.has_app_role()
local role = storage.get_app_role()
return role ~= nil and role ~= ""
end

function storage.has_developer_config()
    local developer_name = storage.get_developer_name()
    local password = storage.get_password()
    local bot_token = storage.get_bot_token()
    local chat_id = storage.get_chat_id()

    return developer_name ~= nil
        and developer_name ~= ""
        and password ~= nil
        and password ~= ""
        and bot_token ~= nil
        and bot_token ~= ""
        and chat_id ~= nil
        and chat_id ~= ""
end

function storage.save_password(password)
    preferences.edit().putString(PASSWORD, password).apply()
end

function storage.get_password()
    return preferences.getString(PASSWORD, nil)
end

function storage.has_password()
local password = storage.get_password()
return password ~= nil and password ~= ""
end

function storage.save_developer_name(name)
    preferences.edit().putString(DEVELOPER_NAME, name).apply()
end

function storage.get_developer_name()
    return preferences.getString(DEVELOPER_NAME, nil)
end

function storage.has_developer_name()
local name = storage.get_developer_name()
return name ~= nil and name ~= ""
end

function storage.save_bot_token(bot_token)
    preferences.edit().putString(BOT_TOKEN, bot_token).apply()
end

function storage.get_bot_token()
    return preferences.getString(BOT_TOKEN, nil)
end

function storage.has_bot_token()
local token = storage.get_bot_token()
return token ~= nil and token ~= ""
end

function storage.save_chat_id(chat_id)
    preferences.edit().putString(CHAT_ID, chat_id).apply()
end

function storage.get_chat_id()
    return preferences.getString(CHAT_ID, nil)
end

function storage.has_chat_id()
local id = storage.get_chat_id()
return id ~= nil and id ~= ""
end

function storage.save_user_name(user_name)
preferences.edit().putString(USER_NAME, user_name).apply()
end

function storage.get_user_name()
return preferences.getString(USER_NAME, nil)
end

function storage.has_user_name()
local user_name = storage.get_user_name()
return user_name ~= nil and user_name ~= ""
end

function storage.save_api_key(api_key)
preferences.edit().putString(API_KEY, api_key).apply()
end

function storage.get_api_key()
return preferences.getString(API_KEY, nil)
end

function storage.has_api_key()
local api_key = storage.get_api_key()
return api_key ~= nil and api_key ~= ""
end

function storage.has_user_config()
local name = storage.get_user_name()
local apikey = storage.get_api_key()
return name ~= nil and name ~= "" and apikey ~= nil and apikey ~= ""
end

function storage.removeKey(key)
preferences.edit().remove(key).apply()
end

function storage.clearAll()
preferences.edit().clear().apply()
end

return storage