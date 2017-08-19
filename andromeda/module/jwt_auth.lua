local jwt = require "resty.jwt"

local header_name = "Token"
local prefix = "andromeda"
local secret = "lua-resty-jwt"

local _M = {}

function _M.filter()
    -- JWT verify
    local jwt_token = ngx.req.get_headers()[header_name]
    local jwt_obj = jwt:verify(secret, jwt_token)

    if jwt_obj.verified == true then
        for i, v in pairs(jwt_obj.payload) do
            if not ngx.re.match(i, [[^__\w+]], "jo") then
               ngx.header[prefix .. i] = v
            end
         end
    else
        ngx.exit(ngx.HTTP_FORBIDDEN)
    end
end

return _M

