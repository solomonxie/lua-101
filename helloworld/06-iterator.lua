inspect = require('inspect')
raw = [[
    pid,name,country,languages,description
    123,Tom,CN,zh-hans,hello hi
    456,Jason,US,["en", "zh", "ja", "fr"],this is a person description
]]


function enumerate (tb)
    local i = 0
    return function ()
        i = i + 1
        if i <= #tb then return i, tb[i] end
    end
end

function enumerate_line(content)
    local i = 0
    return function ()
        i = i + 1
        local pos = string.find(content, '\n')
        if not pos then pos = 1 end
        local line = string.sub(content, 1, pos - 1)
        line = string.gsub(string.gsub(line, '^%s+', ''), '%s+$', '')
        if string.len(line) > 0 and pos <= #content then
            content = string.sub(content, pos + 1)
            return i, line
        end
    end
end


tb = {}
for i, line in enumerate_line(raw) do
    print(i, line)
end
print('[ OK. ]')
