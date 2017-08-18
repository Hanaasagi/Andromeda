expose("expose fake variable", function()
    local old_ngx = _G.ngx
    local fake_ngx

    -- fake ngx variable
    fake_ngx = {
        log = function(...) end,
    }
    stub(fake_ngx, "log")
    _G.ngx = setmetatable(fake_ngx, {__index=old_ngx})
end)


describe("Busted logger Test", function()

    it("should be banned", function()
        local logger = require("utils").logger
        logger.log_err("a error occurred")
        assert.stub(ngx.log).was.called_with(ngx.ERR, "a error occurred")
    end)
end)

