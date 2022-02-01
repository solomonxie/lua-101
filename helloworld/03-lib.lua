-- $ luarocks install inspect
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

inspect = require('inspect')
print(inspect(data))
