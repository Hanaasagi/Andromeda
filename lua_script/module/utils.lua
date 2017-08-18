local _M = {}

local logger = {}
local ngx_log = ngx.log
local CRIT = ngx.CRIT
local ERR = ngx.ERR
local WARN = ngx.WARN
local NOTICE = ngx.NOTICE
local DEBUG = ngx.DEBUG

function logger.log_crit(mgs)
    ngx_log(CRIT, msg)
end

function logger.log_err(msg)
    ngx_log(ERR, msg)
end

function logger.log_warn(msg)
    ngx_log(WARN, msg)
end

function logger.log_notice(msg)
    ngx_log(NOTICE, msg)
end

function logger.log_debug(msg)
    ngx_log(WARN, msg)
end

_M.logger = logger

return _M
