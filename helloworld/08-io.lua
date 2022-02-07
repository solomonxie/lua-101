path = '/tmp/data.csv'
f = io.open(path, 'w')
f:write('1hihi', '\n')
f:write('2hello', '\n')
f:close()


f = io.open(path, 'r')
rows = {}
while true do
    local v = f:read()
    if not v then
        f:close()
        break
    end
    print(v)
    table.insert(rows, v)
end
print('[ OK ]')
