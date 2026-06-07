local _0x0002 = {}
_0x0002._0x000c = _0x0002
function _0x0002._0x000e(_0x0013, _0x0014)
local _0x0015 = setmetatable({}, _0x0002)
_0x0015._0x0016 = {}
_0x0015._0x0013 = _0x0013 or 20
_0x0015._0x0014 = _0x0014 or string.char(80, 108, 97, 121, 101, 114)
_0x0015._0x0017 = 0
_0x0015._0x0018 = false
return _0x0015
end
function _0x0002:_0x001d(_0x001e, _0x001b, _0x001f)
if _0x0015._0x0018 then
return false, string.char(73, 110, 118, 101, 110, 116, 111, 114, 121, 32, 105, 115, 32, 108, 111, 99, 107, 101, 100)
end
local _0x0020 = #_0x0015._0x0016 + 1
if _0x0020 > _0x0015._0x0013 then
return false, string.char(73, 110, 118, 101, 110, 116, 111, 114, 121, 32, 102, 117, 108, 108)
end
local _0x001a = {
_0x0022 = _0x001e,
_0x0023 = _0x001b or 1,
_0x001f = _0x001f or string.char(99, 111, 109, 109, 111, 110),
_0x0024 = os._0x0025(),
_0x0026 = math.random(1000, 9999)
}
local _0x0028 = 1.0
if _0x001f == string.char(114, 97, 114, 101) then
_0x0028 = 1.5
elseif _0x001f == string.char(101, 112, 105, 99) then
_0x0028 = 2.0
elseif _0x001f == string.char(108, 101, 103, 101, 110, 100, 97, 114, 121) then
_0x0028 = 3.0
end
_0x001a._0x0029 = math.floor(_0x001b * 10 * _0x0028)
table.insert(_0x0015._0x0016, _0x001a)
return true, string.char(65, 100, 100, 101, 100, 32) .. _0x001e
end
function _0x0002:_0x002c()
local _0x002b = _0x0015._0x0017
local _0x002d = 0
for _0x002e = 1, #_0x0015._0x0016 do
local _0x001a = _0x0015._0x0016[_0x002e]
_0x002b = _0x002b + (_0x001a._0x0029 or 0)
_0x002d = _0x002d + 1
end
return _0x002b, _0x002d
end
function _0x0002:_0x0032(_0x0033)
local _0x0034 = {}
local _0x0035 = string.lower(_0x0033)
for _0x0036, _0x001a in pairs(_0x0015._0x0016) do
if string.lower(_0x001a._0x001f) == _0x0035 then
table.insert(_0x0034, _0x001a._0x0022)
end
end
return _0x0034
end
function _0x0002:_0x003a(_0x003b)
if _0x003b < 1 or _0x003b > #_0x0015._0x0016 then
return false
end
local _0x001a = table.remove(_0x0015._0x0016, _0x003b)
local _0x003c = math.floor(_0x001a._0x0029 * 0.75)
_0x0015._0x0017 = _0x0015._0x0017 + _0x003c
return true, _0x003c
end
function _0x0002:_0x0040(_0x0041)
_0x0015._0x0018 = true
local _0x0042, _0x0043 = pcall(function()
return _0x0041(_0x0015)
end)
_0x0015._0x0018 = false
return _0x0042, _0x0043
end
local _0x0046 = _0x0002._0x000e((50 / 2), string.char(72, 101, 114, 111))
_0x0046:_0x001d(string.char(72, 101, 97, 108, 116, 104, 32, 80, 111, 116, 105, 111, 110), 5, string.char(99, 111, 109, 109, 111, 110))
_0x0046:_0x001d(string.char(77, 97, 110, 97, 32, 67, 114, 121, 115, 116, 97, 108), 3, string.char(114, 97, 114, 101))
_0x0046:_0x001d(string.char(68, 114, 97, 103, 111, 110, 32, 83, 99, 97, 108, 101), 1, string.char(108, 101, 103, 101, 110, 100, 97, 114, 121))
_0x0046:_0x001d(string.char(73, 114, 111, 110, 32, 83, 119, 111, 114, 100), 1, string.char(101, 112, 105, 99))
_0x0046:_0x001d(string.char(71, 111, 108, 100, 32, 67, 111, 105, 110, 115), (400 / 4), string.char(99, 111, 109, 109, 111, 110))
local _0x0049, _0x004a = _0x0046:_0x002c()
print(string.char(73, 110, 118, 101, 110, 116, 111, 114, 121, 32, 86, 97, 108, 117, 101, 58, 32) .. _0x0049 .. string.char(32, 103, 111, 108, 100))
print(string.char(84, 111, 116, 97, 108, 32, 73, 116, 101, 109, 115, 58, 32) .. _0x004a)
local _0x004c = _0x0046:_0x0032(string.char(108, 101, 103, 101, 110, 100, 97, 114, 121))
print(string.char(76, 101, 103, 101, 110, 100, 97, 114, 121, 32, 73, 116, 101, 109, 115, 58, 32) .. table.concat(_0x004c, string.char(44, 32)))
local _0x0042, _0x0038 = _0x0046:_0x0040(function(_0x004f)
return _0x004f:_0x003a(2)
end)
if _0x0042 then
print(string.char(83, 111, 108, 100, 32, 105, 116, 101, 109, 32, 102, 111, 114, 32) .. _0x0038 .. string.char(32, 103, 111, 108, 100))
print(string.char(78, 101, 119, 32, 66, 97, 108, 97, 110, 99, 101, 58, 32) .. _0x0046._0x0017 .. string.char(32, 103, 111, 108, 100))
end
