dbg = require('debugger')
json = require('json')
inspect = require('inspect')
stringx = require('pl.stringx')

header = 'pid,name,country,languages,description'
line1 = '123,Tom,CN,zh-hans,hello hi'
line2 = '456,Jason,US,["en", "zh", "ja", "fr"],this is a person description'
-- content = [[
-- pid,name,country,languages,description
-- 123,Jason,US,["en", "zh", "ja", "fr"],this is a person description
-- ]]
content = header .. '\n' .. line1 .. '\n' .. line2

-- print(content)
for line in stringx.lines(content) do
    print(line)
end

function parse_line(line, sep)
    if not line then return nil end
    if not sep then sep = ',' end
    local values = {}
    local pos = string.find(line, sep)
    if string.sub(line, 1, 1) == '[' then
        local arr_end_pos = string.find(line, ']')
        if arr_end_pos then pos = arr_end_pos + 1 end
    end
    if not pos then pos = string.len(line) + 1 end
    local v = string.sub(line, 1, pos - 1)
    if v then
        print('found value: ' .. v)
        table.insert(values, v)
    end
    local rest = string.sub(line, pos + 1)
    if #rest > 0 then
        local next_values = parse_line(rest)
        if next_values and #next_values > 0 then
            for i = 1, #next_values do
                table.insert(values, next_values[i])
            end
        end
    end
    return values
end

tb = {}
for line in stringx.lines(content) do
    local values = parse_line(line)
    if #values > 0 then
        table.insert(tb, values)
    end
end
print('LOADED CSV CONTENT...')
print(inspect(tb))
print('[ OK. ]')
