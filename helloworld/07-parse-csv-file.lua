inspect = require('inspect')
M = {}


function M.parse_csv_line(line, sep)
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
    v = string.gsub(string.gsub(v, '^%s+', ''), '%s+$', '')
    if v and string.len(v) > 0 then
        print('found value: ' .. v)
        table.insert(values, v)
    end
    local more = string.sub(line, pos + 1)
    if #more > 0 then
        local next_values = M.parse_csv_line(more)
        if next_values and #next_values > 0 then
            for i = 1, #next_values do
                table.insert(values, next_values[i])
            end
        end
    end
    return values
end


function M.parse_file(path, sep)
    print('LODING CONTENT...')
    if not sep then sep = ',' end
    -- PARSE LINES
    local rows = {}
    for line in io.lines(path) do
        local vlist = M.parse_csv_line(line, sep)
        if vlist and #vlist > 0 then table.insert(rows, vlist) end
    end

    -- CONVERT TO DICT ROWS
    local tb, headers = {}, {}
    if rows and #rows > 1 then headers = table.remove(rows, 1) end
    for i = 1, #rows do
        local d = {}
        for j, v in pairs(headers) do
            d[v] = rows[i][j]
        end
        if d and #d then table.insert(tb, d) end
    end
    print('DONE: LOADED CSV CONTENT...')
    return tb
end

tb = M.parse_file('dataset/student.csv')
print( inspect(tb) )
print('[ OK. ]')