#! /usr/bin/env lua

data = {
    a = 1,
    b = 2,
    hello = "hi",
    ["my-name"] = "def",
    ["$@!"] = "123",
    ['sub-table'] = {
        a = 2,
        b = 3,
    },
}

print(data)
print(data.hello)
print(data['$@!'])
print(data['sub-table']['a'])


function tprint (tb, indent)
    if not indent then indent = 0 end
    for k, v in pairs(tb) do
        local formatting = string.rep("  ", indent) .. k .. ": "
        if type(v) == "table" then
            print(formatting)
            tprint(v, indent+1)
        elseif type(v) == 'boolean' then
            print(formatting .. tostring(v))
        else
            print(formatting .. v)
        end
    end
end

print('DISPLAY TABLE ========>')
tprint(data, 4)
