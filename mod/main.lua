
local ____modules = {}
local ____moduleCache = {}
local ____originalRequire = require
local function require(file)
    if ____moduleCache[file] then
        return ____moduleCache[file]
    end
    if ____modules[file] then
        ____moduleCache[file] = ____modules[file]()
        return ____moduleCache[file]
    else
        if ____originalRequire then
            return ____originalRequire(file)
        else
            error("module '" .. file .. "' not found")
        end
    end
end
____modules = {
["lualib_bundle"] = function() function __TS__ArrayIsArray(value)
    return (type(value) == "table") and ((value[1] ~= nil) or (next(value, nil) == nil))
end

function __TS__ArrayConcat(arr1, ...)
    local args = {...}
    local out = {}
    for ____, val in ipairs(arr1) do
        out[#out + 1] = val
    end
    for ____, arg in ipairs(args) do
        if __TS__ArrayIsArray(arg) then
            local argAsArray = arg
            for ____, val in ipairs(argAsArray) do
                out[#out + 1] = val
            end
        else
            out[#out + 1] = arg
        end
    end
    return out
end

function __TS__ArrayEvery(arr, callbackfn)
    do
        local i = 0
        while i < #arr do
            if not callbackfn(_G, arr[i + 1], i, arr) then
                return false
            end
            i = i + 1
        end
    end
    return true
end

function __TS__ArrayFilter(arr, callbackfn)
    local result = {}
    do
        local i = 0
        while i < #arr do
            if callbackfn(_G, arr[i + 1], i, arr) then
                result[#result + 1] = arr[i + 1]
            end
            i = i + 1
        end
    end
    return result
end

function __TS__ArrayForEach(arr, callbackFn)
    do
        local i = 0
        while i < #arr do
            callbackFn(_G, arr[i + 1], i, arr)
            i = i + 1
        end
    end
end

function __TS__ArrayFind(arr, predicate)
    local len = #arr
    local k = 0
    while k < len do
        local elem = arr[k + 1]
        if predicate(_G, elem, k, arr) then
            return elem
        end
        k = k + 1
    end
    return nil
end

function __TS__ArrayFindIndex(arr, callbackFn)
    do
        local i = 0
        local len = #arr
        while i < len do
            if callbackFn(_G, arr[i + 1], i, arr) then
                return i
            end
            i = i + 1
        end
    end
    return -1
end

function __TS__ArrayIncludes(self, searchElement, fromIndex)
    if fromIndex == nil then
        fromIndex = 0
    end
    local len = #self
    local k = fromIndex
    if fromIndex < 0 then
        k = len + fromIndex
    end
    if k < 0 then
        k = 0
    end
    for i = k, len do
        if self[i + 1] == searchElement then
            return true
        end
    end
    return false
end

function __TS__ArrayIndexOf(arr, searchElement, fromIndex)
    local len = #arr
    if len == 0 then
        return -1
    end
    local n = 0
    if fromIndex then
        n = fromIndex
    end
    if n >= len then
        return -1
    end
    local k
    if n >= 0 then
        k = n
    else
        k = len + n
        if k < 0 then
            k = 0
        end
    end
    do
        local i = k
        while i < len do
            if arr[i + 1] == searchElement then
                return i
            end
            i = i + 1
        end
    end
    return -1
end

function __TS__ArrayJoin(self, separator)
    if separator == nil then
        separator = ","
    end
    local result = ""
    for index, value in ipairs(self) do
        if index > 1 then
            result = tostring(result) .. tostring(separator)
        end
        result = tostring(result) .. tostring(
            tostring(value)
        )
    end
    return result
end

function __TS__ArrayMap(arr, callbackfn)
    local newArray = {}
    do
        local i = 0
        while i < #arr do
            newArray[i + 1] = callbackfn(_G, arr[i + 1], i, arr)
            i = i + 1
        end
    end
    return newArray
end

function __TS__ArrayPush(arr, ...)
    local items = {...}
    for ____, item in ipairs(items) do
        arr[#arr + 1] = item
    end
    return #arr
end

function __TS__ArrayReduce(arr, callbackFn, ...)
    local len = #arr
    local k = 0
    local accumulator = nil
    if select("#", ...) ~= 0 then
        accumulator = select(1, ...)
    elseif len > 0 then
        accumulator = arr[1]
        k = 1
    else
        error("Reduce of empty array with no initial value", 0)
    end
    for i = k, len - 1 do
        accumulator = callbackFn(_G, accumulator, arr[i + 1], i, arr)
    end
    return accumulator
end

function __TS__ArrayReduceRight(arr, callbackFn, ...)
    local len = #arr
    local k = len - 1
    local accumulator = nil
    if select("#", ...) ~= 0 then
        accumulator = select(1, ...)
    elseif len > 0 then
        accumulator = arr[k + 1]
        k = k - 1
    else
        error("Reduce of empty array with no initial value", 0)
    end
    for i = k, 0, -1 do
        accumulator = callbackFn(_G, accumulator, arr[i + 1], i, arr)
    end
    return accumulator
end

function __TS__ArrayReverse(arr)
    local i = 0
    local j = #arr - 1
    while i < j do
        local temp = arr[j + 1]
        arr[j + 1] = arr[i + 1]
        arr[i + 1] = temp
        i = i + 1
        j = j - 1
    end
    return arr
end

function __TS__ArrayShift(arr)
    return table.remove(arr, 1)
end

function __TS__ArrayUnshift(arr, ...)
    local items = {...}
    do
        local i = #items - 1
        while i >= 0 do
            table.insert(arr, 1, items[i + 1])
            i = i - 1
        end
    end
    return #arr
end

function __TS__ArraySort(arr, compareFn)
    if compareFn ~= nil then
        table.sort(
            arr,
            function(a, b) return compareFn(_G, a, b) < 0 end
        )
    else
        table.sort(arr)
    end
    return arr
end

function __TS__ArraySlice(list, first, last)
    local len = #list
    local relativeStart = first or 0
    local k
    if relativeStart < 0 then
        k = math.max(len + relativeStart, 0)
    else
        k = math.min(relativeStart, len)
    end
    local relativeEnd = last
    if last == nil then
        relativeEnd = len
    end
    local final
    if relativeEnd < 0 then
        final = math.max(len + relativeEnd, 0)
    else
        final = math.min(relativeEnd, len)
    end
    local out = {}
    local n = 0
    while k < final do
        out[n + 1] = list[k + 1]
        k = k + 1
        n = n + 1
    end
    return out
end

function __TS__ArraySome(arr, callbackfn)
    do
        local i = 0
        while i < #arr do
            if callbackfn(_G, arr[i + 1], i, arr) then
                return true
            end
            i = i + 1
        end
    end
    return false
end

function __TS__ArraySplice(list, ...)
    local len = #list
    local actualArgumentCount = select("#", ...)
    local start = select(1, ...)
    local deleteCount = select(2, ...)
    local actualStart
    if start < 0 then
        actualStart = math.max(len + start, 0)
    else
        actualStart = math.min(start, len)
    end
    local itemCount = math.max(actualArgumentCount - 2, 0)
    local actualDeleteCount
    if actualArgumentCount == 0 then
        actualDeleteCount = 0
    elseif actualArgumentCount == 1 then
        actualDeleteCount = len - actualStart
    else
        actualDeleteCount = math.min(
            math.max(deleteCount or 0, 0),
            len - actualStart
        )
    end
    local out = {}
    do
        local k = 0
        while k < actualDeleteCount do
            local from = actualStart + k
            if list[from + 1] then
                out[k + 1] = list[from + 1]
            end
            k = k + 1
        end
    end
    if itemCount < actualDeleteCount then
        do
            local k = actualStart
            while k < (len - actualDeleteCount) do
                local from = k + actualDeleteCount
                local to = k + itemCount
                if list[from + 1] then
                    list[to + 1] = list[from + 1]
                else
                    list[to + 1] = nil
                end
                k = k + 1
            end
        end
        do
            local k = len
            while k > ((len - actualDeleteCount) + itemCount) do
                list[k] = nil
                k = k - 1
            end
        end
    elseif itemCount > actualDeleteCount then
        do
            local k = len - actualDeleteCount
            while k > actualStart do
                local from = (k + actualDeleteCount) - 1
                local to = (k + itemCount) - 1
                if list[from + 1] then
                    list[to + 1] = list[from + 1]
                else
                    list[to + 1] = nil
                end
                k = k - 1
            end
        end
    end
    local j = actualStart
    for i = 3, actualArgumentCount do
        list[j + 1] = select(i, ...)
        j = j + 1
    end
    do
        local k = #list - 1
        while k >= ((len - actualDeleteCount) + itemCount) do
            list[k + 1] = nil
            k = k - 1
        end
    end
    return out
end

function __TS__ArrayToObject(array)
    local object = {}
    do
        local i = 0
        while i < #array do
            object[i] = array[i + 1]
            i = i + 1
        end
    end
    return object
end

function __TS__ArrayFlat(array, depth)
    if depth == nil then
        depth = 1
    end
    local result = {}
    for ____, value in ipairs(array) do
        if (depth > 0) and __TS__ArrayIsArray(value) then
            result = __TS__ArrayConcat(
                result,
                __TS__ArrayFlat(value, depth - 1)
            )
        else
            result[#result + 1] = value
        end
    end
    return result
end

function __TS__ArrayFlatMap(array, callback)
    local result = {}
    do
        local i = 0
        while i < #array do
            local value = callback(_G, array[i + 1], i, array)
            if (type(value) == "table") and __TS__ArrayIsArray(value) then
                result = __TS__ArrayConcat(result, value)
            else
                result[#result + 1] = value
            end
            i = i + 1
        end
    end
    return result
end

function __TS__ArraySetLength(arr, length)
    if (((length < 0) or (length ~= length)) or (length == math.huge)) or (math.floor(length) ~= length) then
        error(
            "invalid array length: " .. tostring(length),
            0
        )
    end
    do
        local i = #arr - 1
        while i >= length do
            arr[i + 1] = nil
            i = i - 1
        end
    end
    return length
end

function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
end

function __TS__ClassExtends(target, base)
    target.____super = base
    local staticMetatable = setmetatable({__index = base}, base)
    setmetatable(target, staticMetatable)
    local baseMetatable = getmetatable(base)
    if baseMetatable then
        if type(baseMetatable.__index) == "function" then
            staticMetatable.__index = baseMetatable.__index
        end
        if type(baseMetatable.__newindex) == "function" then
            staticMetatable.__newindex = baseMetatable.__newindex
        end
    end
    setmetatable(target.prototype, base.prototype)
    if type(base.prototype.__index) == "function" then
        target.prototype.__index = base.prototype.__index
    end
    if type(base.prototype.__newindex) == "function" then
        target.prototype.__newindex = base.prototype.__newindex
    end
    if type(base.prototype.__tostring) == "function" then
        target.prototype.__tostring = base.prototype.__tostring
    end
end

function __TS__CloneDescriptor(____bindingPattern0)
    local enumerable
    enumerable = ____bindingPattern0.enumerable
    local configurable
    configurable = ____bindingPattern0.configurable
    local get
    get = ____bindingPattern0.get
    local set
    set = ____bindingPattern0.set
    local writable
    writable = ____bindingPattern0.writable
    local value
    value = ____bindingPattern0.value
    local descriptor = {enumerable = enumerable == true, configurable = configurable == true}
    local hasGetterOrSetter = (get ~= nil) or (set ~= nil)
    local hasValueOrWritableAttribute = (writable ~= nil) or (value ~= nil)
    if hasGetterOrSetter and hasValueOrWritableAttribute then
        error("Invalid property descriptor. Cannot both specify accessors and a value or writable attribute.", 0)
    end
    if get or set then
        descriptor.get = get
        descriptor.set = set
    else
        descriptor.value = value
        descriptor.writable = writable == true
    end
    return descriptor
end

function __TS__Decorate(decorators, target, key, desc)
    local result = target
    do
        local i = #decorators
        while i >= 0 do
            local decorator = decorators[i + 1]
            if decorator then
                local oldResult = result
                if key == nil then
                    result = decorator(_G, result)
                elseif desc == true then
                    local value = rawget(target, key)
                    local descriptor = __TS__ObjectGetOwnPropertyDescriptor(target, key) or ({configurable = true, writable = true, value = value})
                    local desc = decorator(_G, target, key, descriptor) or descriptor
                    local isSimpleValue = (((desc.configurable == true) and (desc.writable == true)) and (not desc.get)) and (not desc.set)
                    if isSimpleValue then
                        rawset(target, key, desc.value)
                    else
                        __TS__SetDescriptor(
                            target,
                            key,
                            __TS__ObjectAssign({}, descriptor, desc)
                        )
                    end
                elseif desc == false then
                    result = decorator(_G, target, key, desc)
                else
                    result = decorator(_G, target, key)
                end
                result = result or oldResult
            end
            i = i - 1
        end
    end
    return result
end

function __TS__DecorateParam(paramIndex, decorator)
    return function(____, target, key) return decorator(_G, target, key, paramIndex) end
end

function __TS__ObjectGetOwnPropertyDescriptors(object)
    local metatable = getmetatable(object)
    if not metatable then
        return {}
    end
    return rawget(metatable, "_descriptors") or ({})
end

function __TS__Delete(target, key)
    local descriptors = __TS__ObjectGetOwnPropertyDescriptors(target)
    local descriptor = descriptors[key]
    if descriptor then
        if not descriptor.configurable then
            error(
                ((("Cannot delete property " .. tostring(key)) .. " of ") .. tostring(target)) .. ".",
                0
            )
        end
        descriptors[key] = nil
        return true
    end
    if target[key] ~= nil then
        target[key] = nil
        return true
    end
    return false
end

function __TS__DelegatedYield(iterable)
    if type(iterable) == "string" then
        for index = 0, #iterable - 1 do
            coroutine.yield(
                __TS__StringAccess(iterable, index)
            )
        end
    elseif iterable.____coroutine ~= nil then
        local co = iterable.____coroutine
        while true do
            local status, value = coroutine.resume(co)
            if not status then
                error(value, 0)
            end
            if coroutine.status(co) == "dead" then
                return value
            else
                coroutine.yield(value)
            end
        end
    elseif iterable[Symbol.iterator] then
        local iterator = iterable[Symbol.iterator](iterable)
        while true do
            local result = iterator:next()
            if result.done then
                return result.value
            else
                coroutine.yield(result.value)
            end
        end
    else
        for ____, value in ipairs(iterable) do
            coroutine.yield(value)
        end
    end
end

function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
end

function __TS__GetErrorStack(self, constructor)
    local level = 1
    while true do
        local info = debug.getinfo(level, "f")
        level = level + 1
        if not info then
            level = 1
            break
        elseif info.func == constructor then
            break
        end
    end
    return debug.traceback(nil, level)
end
function __TS__WrapErrorToString(self, getDescription)
    return function(self)
        local description = getDescription(self)
        local caller = debug.getinfo(3, "f")
        if (_VERSION == "Lua 5.1") or (caller and (caller.func ~= error)) then
            return description
        else
            return (tostring(description) .. "\n") .. self.stack
        end
    end
end
function __TS__InitErrorClass(self, Type, name)
    Type.name = name
    return setmetatable(
        Type,
        {
            __call = function(____, _self, message) return __TS__New(Type, message) end
        }
    )
end
Error = __TS__InitErrorClass(
    _G,
    (function()
        local ____ = __TS__Class()
        ____.name = ""
        function ____.prototype.____constructor(self, message)
            if message == nil then
                message = ""
            end
            self.message = message
            self.name = "Error"
            self.stack = __TS__GetErrorStack(_G, self.constructor.new)
            local metatable = getmetatable(self)
            if not metatable.__errorToStringPatched then
                metatable.__errorToStringPatched = true
                metatable.__tostring = __TS__WrapErrorToString(_G, metatable.__tostring)
            end
        end
        function ____.prototype.__tostring(self)
            return (((self.message ~= "") and (function() return (self.name .. ": ") .. self.message end)) or (function() return self.name end))()
        end
        return ____
    end)(),
    "Error"
)
for ____, errorName in ipairs({"RangeError", "ReferenceError", "SyntaxError", "TypeError", "URIError"}) do
    _G[errorName] = __TS__InitErrorClass(
        _G,
        (function()
            local ____ = __TS__Class()
            ____.name = ____.name
            __TS__ClassExtends(____, Error)
            function ____.prototype.____constructor(self, ...)
                Error.prototype.____constructor(self, ...)
                self.name = errorName
            end
            return ____
        end)(),
        errorName
    )
end

__TS__Unpack = table.unpack or unpack

function __TS__FunctionBind(fn, thisArg, ...)
    local boundArgs = {...}
    return function(____, ...)
        local args = {...}
        do
            local i = 0
            while i < #boundArgs do
                table.insert(args, i + 1, boundArgs[i + 1])
                i = i + 1
            end
        end
        return fn(
            thisArg,
            __TS__Unpack(args)
        )
    end
end

____symbolMetatable = {
    __tostring = function(self)
        return ("Symbol(" .. (self.description or "")) .. ")"
    end
}
function __TS__Symbol(description)
    return setmetatable({description = description}, ____symbolMetatable)
end
Symbol = {
    iterator = __TS__Symbol("Symbol.iterator"),
    hasInstance = __TS__Symbol("Symbol.hasInstance"),
    species = __TS__Symbol("Symbol.species"),
    toStringTag = __TS__Symbol("Symbol.toStringTag")
}

function __TS__GeneratorIterator(self)
    return self
end
function __TS__GeneratorNext(self, ...)
    local co = self.____coroutine
    if coroutine.status(co) == "dead" then
        return {done = true}
    end
    local status, value = coroutine.resume(co, ...)
    if not status then
        error(value, 0)
    end
    return {
        value = value,
        done = coroutine.status(co) == "dead"
    }
end
function __TS__Generator(fn)
    return function(...)
        local args = {...}
        local argsLength = select("#", ...)
        return {
            ____coroutine = coroutine.create(
                function() return fn(
                    (unpack or table.unpack)(args, 1, argsLength)
                ) end
            ),
            [Symbol.iterator] = __TS__GeneratorIterator,
            next = __TS__GeneratorNext
        }
    end
end

function __TS__InstanceOf(obj, classTbl)
    if type(classTbl) ~= "table" then
        error("Right-hand side of 'instanceof' is not an object", 0)
    end
    if classTbl[Symbol.hasInstance] ~= nil then
        return not (not classTbl[Symbol.hasInstance](classTbl, obj))
    end
    if type(obj) == "table" then
        local luaClass = obj.constructor
        while luaClass ~= nil do
            if luaClass == classTbl then
                return true
            end
            luaClass = luaClass.____super
        end
    end
    return false
end

function __TS__InstanceOfObject(value)
    local valueType = type(value)
    return (valueType == "table") or (valueType == "function")
end

function __TS__IteratorGeneratorStep(self)
    local co = self.____coroutine
    local status, value = coroutine.resume(co)
    if not status then
        error(value, 0)
    end
    if coroutine.status(co) == "dead" then
        return
    end
    return true, value
end
function __TS__IteratorIteratorStep(self)
    local result = self:next()
    if result.done then
        return
    end
    return true, result.value
end
function __TS__IteratorStringStep(self, index)
    index = index + 1
    if index > #self then
        return
    end
    return index, string.sub(self, index, index)
end
function __TS__Iterator(iterable)
    if type(iterable) == "string" then
        return __TS__IteratorStringStep, iterable, 0
    elseif iterable.____coroutine ~= nil then
        return __TS__IteratorGeneratorStep, iterable
    elseif iterable[Symbol.iterator] then
        local iterator = iterable[Symbol.iterator](iterable)
        return __TS__IteratorIteratorStep, iterator
    else
        return __TS__Unpack(
            {
                ipairs(iterable)
            }
        )
    end
end

Map = (function()
    local Map = __TS__Class()
    Map.name = "Map"
    function Map.prototype.____constructor(self, entries)
        self[Symbol.toStringTag] = "Map"
        self.items = {}
        self.size = 0
        self.nextKey = {}
        self.previousKey = {}
        if entries == nil then
            return
        end
        local iterable = entries
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                local value = result.value
                self:set(value[1], value[2])
            end
        else
            local array = entries
            for ____, kvp in ipairs(array) do
                self:set(kvp[1], kvp[2])
            end
        end
    end
    function Map.prototype.clear(self)
        self.items = {}
        self.nextKey = {}
        self.previousKey = {}
        self.firstKey = nil
        self.lastKey = nil
        self.size = 0
    end
    function Map.prototype.delete(self, key)
        local contains = self:has(key)
        if contains then
            self.size = self.size - 1
            local next = self.nextKey[key]
            local previous = self.previousKey[key]
            if next and previous then
                self.nextKey[previous] = next
                self.previousKey[next] = previous
            elseif next then
                self.firstKey = next
                self.previousKey[next] = nil
            elseif previous then
                self.lastKey = previous
                self.nextKey[previous] = nil
            else
                self.firstKey = nil
                self.lastKey = nil
            end
            self.nextKey[key] = nil
            self.previousKey[key] = nil
        end
        self.items[key] = nil
        return contains
    end
    function Map.prototype.forEach(self, callback)
        for ____, key in __TS__Iterator(
            self:keys()
        ) do
            callback(_G, self.items[key], key, self)
        end
    end
    function Map.prototype.get(self, key)
        return self.items[key]
    end
    function Map.prototype.has(self, key)
        return (self.nextKey[key] ~= nil) or (self.lastKey == key)
    end
    function Map.prototype.set(self, key, value)
        local isNewValue = not self:has(key)
        if isNewValue then
            self.size = self.size + 1
        end
        self.items[key] = value
        if self.firstKey == nil then
            self.firstKey = key
            self.lastKey = key
        elseif isNewValue then
            self.nextKey[self.lastKey] = key
            self.previousKey[key] = self.lastKey
            self.lastKey = key
        end
        return self
    end
    Map.prototype[Symbol.iterator] = function(self)
        return self:entries()
    end
    function Map.prototype.entries(self)
        local ____ = self
        local items = ____.items
        local nextKey = ____.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = {key, items[key]}}
                key = nextKey[key]
                return result
            end
        }
    end
    function Map.prototype.keys(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = key}
                key = nextKey[key]
                return result
            end
        }
    end
    function Map.prototype.values(self)
        local ____ = self
        local items = ____.items
        local nextKey = ____.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = items[key]}
                key = nextKey[key]
                return result
            end
        }
    end
    Map[Symbol.species] = Map
    return Map
end)()

__TS__MathAtan2 = math.atan2 or math.atan

function __TS__Number(value)
    local valueType = type(value)
    if valueType == "number" then
        return value
    elseif valueType == "string" then
        local numberValue = tonumber(value)
        if numberValue then
            return numberValue
        end
        if value == "Infinity" then
            return math.huge
        end
        if value == "-Infinity" then
            return -math.huge
        end
        local stringWithoutSpaces = string.gsub(value, "%s", "")
        if stringWithoutSpaces == "" then
            return 0
        end
        return 0 / 0
    elseif valueType == "boolean" then
        return (value and 1) or 0
    else
        return 0 / 0
    end
end

function __TS__NumberIsFinite(value)
    return (((type(value) == "number") and (value == value)) and (value ~= math.huge)) and (value ~= -math.huge)
end

function __TS__NumberIsNaN(value)
    return value ~= value
end

____radixChars = "0123456789abcdefghijklmnopqrstuvwxyz"
function __TS__NumberToString(self, radix)
    if ((((radix == nil) or (radix == 10)) or (self == math.huge)) or (self == -math.huge)) or (self ~= self) then
        return tostring(self)
    end
    radix = math.floor(radix)
    if (radix < 2) or (radix > 36) then
        error("toString() radix argument must be between 2 and 36", 0)
    end
    local integer, fraction = math.modf(
        math.abs(self)
    )
    local result = ""
    if radix == 8 then
        result = string.format("%o", integer)
    elseif radix == 16 then
        result = string.format("%x", integer)
    else
        repeat
            do
                result = tostring(
                    __TS__StringAccess(____radixChars, integer % radix)
                ) .. tostring(result)
                integer = math.floor(integer / radix)
            end
        until not (integer ~= 0)
    end
    if fraction ~= 0 then
        result = tostring(result) .. "."
        local delta = 1e-16
        repeat
            do
                fraction = fraction * radix
                delta = delta * radix
                local digit = math.floor(fraction)
                result = tostring(result) .. tostring(
                    __TS__StringAccess(____radixChars, digit)
                )
                fraction = fraction - digit
            end
        until not (fraction >= delta)
    end
    if self < 0 then
        result = "-" .. tostring(result)
    end
    return result
end

function __TS__ObjectAssign(to, ...)
    local sources = {...}
    if to == nil then
        return to
    end
    for ____, source in ipairs(sources) do
        for key in pairs(source) do
            to[key] = source[key]
        end
    end
    return to
end

function ____descriptorIndex(self, key)
    local value = rawget(self, key)
    if value ~= nil then
        return value
    end
    local metatable = getmetatable(self)
    while metatable do
        local rawResult = rawget(metatable, key)
        if rawResult ~= nil then
            return rawResult
        end
        local descriptors = rawget(metatable, "_descriptors")
        if descriptors then
            local descriptor = descriptors[key]
            if descriptor then
                if descriptor.get then
                    return descriptor.get(self)
                end
                return descriptor.value
            end
        end
        metatable = getmetatable(metatable)
    end
end
function ____descriptorNewindex(self, key, value)
    local metatable = getmetatable(self)
    while metatable do
        local descriptors = rawget(metatable, "_descriptors")
        if descriptors then
            local descriptor = descriptors[key]
            if descriptor then
                if descriptor.set then
                    descriptor.set(self, value)
                else
                    if descriptor.writable == false then
                        error(
                            ((("Cannot assign to read only property '" .. key) .. "' of object '") .. tostring(self)) .. "'",
                            0
                        )
                    end
                    descriptor.value = value
                end
                return
            end
        end
        metatable = getmetatable(metatable)
    end
    rawset(self, key, value)
end
function __TS__SetDescriptor(target, key, desc, isPrototype)
    if isPrototype == nil then
        isPrototype = false
    end
    local metatable = ((isPrototype and (function() return target end)) or (function() return getmetatable(target) end))()
    if not metatable then
        metatable = {}
        setmetatable(target, metatable)
    end
    local value = rawget(target, key)
    if value ~= nil then
        rawset(target, key, nil)
    end
    if not rawget(metatable, "_descriptors") then
        metatable._descriptors = {}
    end
    local descriptor = __TS__CloneDescriptor(desc)
    metatable._descriptors[key] = descriptor
    metatable.__index = ____descriptorIndex
    metatable.__newindex = ____descriptorNewindex
end

function __TS__ObjectDefineProperty(target, key, desc)
    local luaKey = (((type(key) == "number") and (function() return key + 1 end)) or (function() return key end))()
    local value = rawget(target, luaKey)
    local hasGetterOrSetter = (desc.get ~= nil) or (desc.set ~= nil)
    local descriptor
    if hasGetterOrSetter then
        if value ~= nil then
            error(
                "Cannot redefine property: " .. tostring(key),
                0
            )
        end
        descriptor = desc
    else
        local valueExists = value ~= nil
        descriptor = {
            set = desc.set,
            get = desc.get,
            configurable = (((desc.configurable ~= nil) and (function() return desc.configurable end)) or (function() return valueExists end))(),
            enumerable = (((desc.enumerable ~= nil) and (function() return desc.enumerable end)) or (function() return valueExists end))(),
            writable = (((desc.writable ~= nil) and (function() return desc.writable end)) or (function() return valueExists end))(),
            value = (((desc.value ~= nil) and (function() return desc.value end)) or (function() return value end))()
        }
    end
    __TS__SetDescriptor(target, luaKey, descriptor)
    return target
end

function __TS__ObjectEntries(obj)
    local result = {}
    for key in pairs(obj) do
        result[#result + 1] = {key, obj[key]}
    end
    return result
end

function __TS__ObjectFromEntries(entries)
    local obj = {}
    local iterable = entries
    if iterable[Symbol.iterator] then
        local iterator = iterable[Symbol.iterator](iterable)
        while true do
            local result = iterator:next()
            if result.done then
                break
            end
            local value = result.value
            obj[value[1]] = value[2]
        end
    else
        for ____, entry in ipairs(entries) do
            obj[entry[1]] = entry[2]
        end
    end
    return obj
end

function __TS__ObjectGetOwnPropertyDescriptor(object, key)
    local metatable = getmetatable(object)
    if not metatable then
        return
    end
    if not rawget(metatable, "_descriptors") then
        return
    end
    return rawget(metatable, "_descriptors")[key]
end

function __TS__ObjectKeys(obj)
    local result = {}
    for key in pairs(obj) do
        result[#result + 1] = key
    end
    return result
end

function __TS__ObjectRest(target, usedProperties)
    local result = {}
    for property in pairs(target) do
        if not usedProperties[property] then
            result[property] = target[property]
        end
    end
    return result
end

function __TS__ObjectValues(obj)
    local result = {}
    for key in pairs(obj) do
        result[#result + 1] = obj[key]
    end
    return result
end

function __TS__ParseFloat(numberString)
    local infinityMatch = string.match(numberString, "^%s*(-?Infinity)")
    if infinityMatch then
        return (((__TS__StringAccess(infinityMatch, 0) == "-") and (function() return -math.huge end)) or (function() return math.huge end))()
    end
    local number = tonumber(
        string.match(numberString, "^%s*(-?%d+%.?%d*)")
    )
    return number or (0 / 0)
end

__TS__parseInt_base_pattern = "0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTvVwWxXyYzZ"
function __TS__ParseInt(numberString, base)
    if base == nil then
        base = 10
        local hexMatch = string.match(numberString, "^%s*-?0[xX]")
        if hexMatch then
            base = 16
            numberString = ((string.match(hexMatch, "-") and (function() return "-" .. tostring(
                __TS__StringSubstr(numberString, #hexMatch)
            ) end)) or (function() return __TS__StringSubstr(numberString, #hexMatch) end))()
        end
    end
    if (base < 2) or (base > 36) then
        return 0 / 0
    end
    local allowedDigits = (((base <= 10) and (function() return __TS__StringSubstring(__TS__parseInt_base_pattern, 0, base) end)) or (function() return __TS__StringSubstr(__TS__parseInt_base_pattern, 0, 10 + (2 * (base - 10))) end))()
    local pattern = ("^%s*(-?[" .. allowedDigits) .. "]*)"
    local number = tonumber(
        string.match(numberString, pattern),
        base
    )
    if number == nil then
        return 0 / 0
    end
    if number >= 0 then
        return math.floor(number)
    else
        return math.ceil(number)
    end
end

Set = (function()
    local Set = __TS__Class()
    Set.name = "Set"
    function Set.prototype.____constructor(self, values)
        self[Symbol.toStringTag] = "Set"
        self.size = 0
        self.nextKey = {}
        self.previousKey = {}
        if values == nil then
            return
        end
        local iterable = values
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                self:add(result.value)
            end
        else
            local array = values
            for ____, value in ipairs(array) do
                self:add(value)
            end
        end
    end
    function Set.prototype.add(self, value)
        local isNewValue = not self:has(value)
        if isNewValue then
            self.size = self.size + 1
        end
        if self.firstKey == nil then
            self.firstKey = value
            self.lastKey = value
        elseif isNewValue then
            self.nextKey[self.lastKey] = value
            self.previousKey[value] = self.lastKey
            self.lastKey = value
        end
        return self
    end
    function Set.prototype.clear(self)
        self.nextKey = {}
        self.previousKey = {}
        self.firstKey = nil
        self.lastKey = nil
        self.size = 0
    end
    function Set.prototype.delete(self, value)
        local contains = self:has(value)
        if contains then
            self.size = self.size - 1
            local next = self.nextKey[value]
            local previous = self.previousKey[value]
            if next and previous then
                self.nextKey[previous] = next
                self.previousKey[next] = previous
            elseif next then
                self.firstKey = next
                self.previousKey[next] = nil
            elseif previous then
                self.lastKey = previous
                self.nextKey[previous] = nil
            else
                self.firstKey = nil
                self.lastKey = nil
            end
            self.nextKey[value] = nil
            self.previousKey[value] = nil
        end
        return contains
    end
    function Set.prototype.forEach(self, callback)
        for ____, key in __TS__Iterator(
            self:keys()
        ) do
            callback(_G, key, key, self)
        end
    end
    function Set.prototype.has(self, value)
        return (self.nextKey[value] ~= nil) or (self.lastKey == value)
    end
    Set.prototype[Symbol.iterator] = function(self)
        return self:values()
    end
    function Set.prototype.entries(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = {key, key}}
                key = nextKey[key]
                return result
            end
        }
    end
    function Set.prototype.keys(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = key}
                key = nextKey[key]
                return result
            end
        }
    end
    function Set.prototype.values(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = key}
                key = nextKey[key]
                return result
            end
        }
    end
    Set[Symbol.species] = Set
    return Set
end)()

WeakMap = (function()
    local WeakMap = __TS__Class()
    WeakMap.name = "WeakMap"
    function WeakMap.prototype.____constructor(self, entries)
        self[Symbol.toStringTag] = "WeakMap"
        self.items = {}
        setmetatable(self.items, {__mode = "k"})
        if entries == nil then
            return
        end
        local iterable = entries
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                local value = result.value
                self.items[value[1]] = value[2]
            end
        else
            for ____, kvp in ipairs(entries) do
                self.items[kvp[1]] = kvp[2]
            end
        end
    end
    function WeakMap.prototype.delete(self, key)
        local contains = self:has(key)
        self.items[key] = nil
        return contains
    end
    function WeakMap.prototype.get(self, key)
        return self.items[key]
    end
    function WeakMap.prototype.has(self, key)
        return self.items[key] ~= nil
    end
    function WeakMap.prototype.set(self, key, value)
        self.items[key] = value
        return self
    end
    WeakMap[Symbol.species] = WeakMap
    return WeakMap
end)()

WeakSet = (function()
    local WeakSet = __TS__Class()
    WeakSet.name = "WeakSet"
    function WeakSet.prototype.____constructor(self, values)
        self[Symbol.toStringTag] = "WeakSet"
        self.items = {}
        setmetatable(self.items, {__mode = "k"})
        if values == nil then
            return
        end
        local iterable = values
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                self.items[result.value] = true
            end
        else
            for ____, value in ipairs(values) do
                self.items[value] = true
            end
        end
    end
    function WeakSet.prototype.add(self, value)
        self.items[value] = true
        return self
    end
    function WeakSet.prototype.delete(self, value)
        local contains = self:has(value)
        self.items[value] = nil
        return contains
    end
    function WeakSet.prototype.has(self, value)
        return self.items[value] == true
    end
    WeakSet[Symbol.species] = WeakSet
    return WeakSet
end)()

function __TS__SourceMapTraceBack(fileName, sourceMap)
    _G.__TS__sourcemap = _G.__TS__sourcemap or ({})
    _G.__TS__sourcemap[fileName] = sourceMap
    if _G.__TS__originalTraceback == nil then
        _G.__TS__originalTraceback = debug.traceback
        debug.traceback = function(thread, message, level)
            local trace
            if ((thread == nil) and (message == nil)) and (level == nil) then
                trace = _G.__TS__originalTraceback()
            else
                trace = _G.__TS__originalTraceback(thread, message, level)
            end
            if type(trace) ~= "string" then
                return trace
            end
            local result = string.gsub(
                trace,
                "(%S+).lua:(%d+)",
                function(file, line)
                    local fileSourceMap = _G.__TS__sourcemap[tostring(file) .. ".lua"]
                    if fileSourceMap and fileSourceMap[line] then
                        return (file .. ".ts:") .. tostring(fileSourceMap[line])
                    end
                    return (file .. ".lua:") .. line
                end
            )
            return result
        end
    end
end

function __TS__Spread(iterable)
    local arr = {}
    if type(iterable) == "string" then
        do
            local i = 0
            while i < #iterable do
                arr[#arr + 1] = __TS__StringAccess(iterable, i)
                i = i + 1
            end
        end
    else
        for ____, item in __TS__Iterator(iterable) do
            arr[#arr + 1] = item
        end
    end
    return __TS__Unpack(arr)
end

function __TS__StringAccess(self, index)
    if (index >= 0) and (index < #self) then
        return string.sub(self, index + 1, index + 1)
    end
end

function __TS__StringCharAt(self, pos)
    if pos ~= pos then
        pos = 0
    end
    if pos < 0 then
        return ""
    end
    return string.sub(self, pos + 1, pos + 1)
end

function __TS__StringCharCodeAt(self, index)
    if index ~= index then
        index = 0
    end
    if index < 0 then
        return 0 / 0
    end
    return string.byte(self, index + 1) or (0 / 0)
end

function __TS__StringConcat(str1, ...)
    local args = {...}
    local out = str1
    for ____, arg in ipairs(args) do
        out = tostring(out) .. tostring(arg)
    end
    return out
end

function __TS__StringEndsWith(self, searchString, endPosition)
    if (endPosition == nil) or (endPosition > #self) then
        endPosition = #self
    end
    return string.sub(self, (endPosition - #searchString) + 1, endPosition) == searchString
end

function __TS__StringIncludes(self, searchString, position)
    if not position then
        position = 1
    else
        position = position + 1
    end
    local index = string.find(self, searchString, position, true)
    return index ~= nil
end

function __TS__StringPadEnd(self, maxLength, fillString)
    if fillString == nil then
        fillString = " "
    end
    if maxLength ~= maxLength then
        maxLength = 0
    end
    if (maxLength == -math.huge) or (maxLength == math.huge) then
        error("Invalid string length", 0)
    end
    if (#self >= maxLength) or (#fillString == 0) then
        return self
    end
    maxLength = maxLength - #self
    if maxLength > #fillString then
        fillString = tostring(fillString) .. tostring(
            string.rep(
                fillString,
                math.floor(maxLength / #fillString)
            )
        )
    end
    return tostring(self) .. tostring(
        string.sub(
            fillString,
            1,
            math.floor(maxLength)
        )
    )
end

function __TS__StringPadStart(self, maxLength, fillString)
    if fillString == nil then
        fillString = " "
    end
    if maxLength ~= maxLength then
        maxLength = 0
    end
    if (maxLength == -math.huge) or (maxLength == math.huge) then
        error("Invalid string length", 0)
    end
    if (#self >= maxLength) or (#fillString == 0) then
        return self
    end
    maxLength = maxLength - #self
    if maxLength > #fillString then
        fillString = tostring(fillString) .. tostring(
            string.rep(
                fillString,
                math.floor(maxLength / #fillString)
            )
        )
    end
    return tostring(
        string.sub(
            fillString,
            1,
            math.floor(maxLength)
        )
    ) .. tostring(self)
end

function __TS__StringReplace(source, searchValue, replaceValue)
    searchValue = string.gsub(searchValue, "[%%%(%)%.%+%-%*%?%[%^%$]", "%%%1")
    if type(replaceValue) == "string" then
        replaceValue = string.gsub(replaceValue, "%%", "%%%%")
        local result = string.gsub(source, searchValue, replaceValue, 1)
        return result
    else
        local result = string.gsub(
            source,
            searchValue,
            function(match) return replaceValue(_G, match) end,
            1
        )
        return result
    end
end

function __TS__StringSlice(self, start, ____end)
    if (start == nil) or (start ~= start) then
        start = 0
    end
    if ____end ~= ____end then
        ____end = 0
    end
    if start >= 0 then
        start = start + 1
    end
    if (____end ~= nil) and (____end < 0) then
        ____end = ____end - 1
    end
    return string.sub(self, start, ____end)
end

function __TS__StringSubstring(self, start, ____end)
    if ____end ~= ____end then
        ____end = 0
    end
    if (____end ~= nil) and (start > ____end) then
        start, ____end = __TS__Unpack({____end, start})
    end
    if start >= 0 then
        start = start + 1
    else
        start = 1
    end
    if (____end ~= nil) and (____end < 0) then
        ____end = 0
    end
    return string.sub(self, start, ____end)
end

function __TS__StringSplit(source, separator, limit)
    if limit == nil then
        limit = 4294967295
    end
    if limit == 0 then
        return {}
    end
    local out = {}
    local index = 0
    local count = 0
    if (separator == nil) or (separator == "") then
        while (index < (#source - 1)) and (count < limit) do
            out[count + 1] = __TS__StringAccess(source, index)
            count = count + 1
            index = index + 1
        end
    else
        local separatorLength = #separator
        local nextIndex = (string.find(source, separator, nil, true) or 0) - 1
        while (nextIndex >= 0) and (count < limit) do
            out[count + 1] = __TS__StringSubstring(source, index, nextIndex)
            count = count + 1
            index = nextIndex + separatorLength
            nextIndex = (string.find(
                source,
                separator,
                math.max(index + 1, 1),
                true
            ) or 0) - 1
        end
    end
    if count < limit then
        out[count + 1] = __TS__StringSubstring(source, index)
    end
    return out
end

function __TS__StringStartsWith(self, searchString, position)
    if (position == nil) or (position < 0) then
        position = 0
    end
    return string.sub(self, position + 1, #searchString + position) == searchString
end

function __TS__StringSubstr(self, from, length)
    if from ~= from then
        from = 0
    end
    if length ~= nil then
        if (length ~= length) or (length <= 0) then
            return ""
        end
        length = length + from
    end
    if from >= 0 then
        from = from + 1
    end
    return string.sub(self, from, length)
end

function __TS__StringTrim(self)
    local result = string.gsub(self, "^[%s ﻿]*(.-)[%s ﻿]*$", "%1")
    return result
end

function __TS__StringTrimEnd(self)
    local result = string.gsub(self, "[%s ﻿]*$", "")
    return result
end

function __TS__StringTrimStart(self)
    local result = string.gsub(self, "^[%s ﻿]*", "")
    return result
end

____symbolRegistry = {}
function __TS__SymbolRegistryFor(key)
    if not ____symbolRegistry[key] then
        ____symbolRegistry[key] = __TS__Symbol(key)
    end
    return ____symbolRegistry[key]
end
function __TS__SymbolRegistryKeyFor(sym)
    for key in pairs(____symbolRegistry) do
        if ____symbolRegistry[key] == sym then
            return key
        end
    end
end

function __TS__TypeOf(value)
    local luaType = type(value)
    if luaType == "table" then
        return "object"
    elseif luaType == "nil" then
        return "undefined"
    else
        return luaType
    end
end

end,
["types.Config"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
____exports.default = (function()
    ____exports.default = __TS__Class()
    local Config = ____exports.default
    Config.name = "Config"
    function Config.prototype.____constructor(self)
        self.startWithD6 = true
        self.disableCurses = true
        self.freeDevilItem = true
        self.fastClear = true
        self.fastDropAllKeyboard = -1
        self.fastDropAllController = -1
        self.fastDropTrinketsKeyboard = -1
        self.fastDropTrinketsController = -1
        self.fastDropPocketKeyboard = -1
        self.fastDropPocketController = -1
        self.judasAddBomb = true
        self.samsonDropHeart = true
        self.fastReset = true
        self.fixTeleportInvalidEntrance = true
    end
    return Config
end)()
return ____exports
end,
["types.enums"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
____exports.PickupVariantCustom = PickupVariantCustom or ({})
____exports.PickupVariantCustom.INVISIBLE_PICKUP = Isaac.GetEntityVariantByName("Invisible Pickup")
____exports.PickupVariantCustom[____exports.PickupVariantCustom.INVISIBLE_PICKUP] = "INVISIBLE_PICKUP"
____exports.EffectVariantCustom = EffectVariantCustom or ({})
____exports.EffectVariantCustom.TRAPDOOR_FAST_TRAVEL = Isaac.GetEntityVariantByName("Trapdoor (Fast-Travel)")
____exports.EffectVariantCustom[____exports.EffectVariantCustom.TRAPDOOR_FAST_TRAVEL] = "TRAPDOOR_FAST_TRAVEL"
____exports.EffectVariantCustom.CRAWLSPACE_FAST_TRAVEL = Isaac.GetEntityVariantByName("Crawlspace (Fast-Travel)")
____exports.EffectVariantCustom[____exports.EffectVariantCustom.CRAWLSPACE_FAST_TRAVEL] = "CRAWLSPACE_FAST_TRAVEL"
____exports.EffectVariantCustom.WOMB_TRAPDOOR_FAST_TRAVEL = Isaac.GetEntityVariantByName("Womb Trapdoor (Fast-Travel)")
____exports.EffectVariantCustom[____exports.EffectVariantCustom.WOMB_TRAPDOOR_FAST_TRAVEL] = "WOMB_TRAPDOOR_FAST_TRAVEL"
____exports.EffectVariantCustom.BLUE_WOMB_TRAPDOOR_FAST_TRAVEL = Isaac.GetEntityVariantByName("Blue Womb Trapdoor (Fast-Travel)")
____exports.EffectVariantCustom[____exports.EffectVariantCustom.BLUE_WOMB_TRAPDOOR_FAST_TRAVEL] = "BLUE_WOMB_TRAPDOOR_FAST_TRAVEL"
____exports.EffectVariantCustom.HEAVEN_DOOR_FAST_TRAVEL = Isaac.GetEntityVariantByName("Heaven Door (Fast-Travel)")
____exports.EffectVariantCustom[____exports.EffectVariantCustom.HEAVEN_DOOR_FAST_TRAVEL] = "HEAVEN_DOOR_FAST_TRAVEL"
____exports.EffectVariantCustom.VOID_PORTAL_FAST_TRAVEL = Isaac.GetEntityVariantByName("Void Portal (Fast-Travel)")
____exports.EffectVariantCustom[____exports.EffectVariantCustom.VOID_PORTAL_FAST_TRAVEL] = "VOID_PORTAL_FAST_TRAVEL"
____exports.SaveFileState = SaveFileState or ({})
____exports.SaveFileState.NOT_CHECKED = 0
____exports.SaveFileState[____exports.SaveFileState.NOT_CHECKED] = "NOT_CHECKED"
____exports.SaveFileState.DEFERRED_UNTIL_NEW_RUN_BEGINS = 1
____exports.SaveFileState[____exports.SaveFileState.DEFERRED_UNTIL_NEW_RUN_BEGINS] = "DEFERRED_UNTIL_NEW_RUN_BEGINS"
____exports.SaveFileState.GOING_TO_EDEN = 2
____exports.SaveFileState[____exports.SaveFileState.GOING_TO_EDEN] = "GOING_TO_EDEN"
____exports.SaveFileState.GOING_BACK = 3
____exports.SaveFileState[____exports.SaveFileState.GOING_BACK] = "GOING_BACK"
____exports.SaveFileState.FINISHED = 4
____exports.SaveFileState[____exports.SaveFileState.FINISHED] = "FINISHED"
return ____exports
end,
["types.GlobalsRunLevel"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
____exports.default = (function()
    ____exports.default = __TS__Class()
    local GlobalsRunLevel = ____exports.default
    GlobalsRunLevel.name = "GlobalsRunLevel"
    function GlobalsRunLevel.prototype.____constructor(self, stage, stageType)
        self.stage = stage
        self.stageType = stageType
    end
    return GlobalsRunLevel
end)()
return ____exports
end,
["types.GlobalsRunRoom"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
____exports.default = (function()
    ____exports.default = __TS__Class()
    local GlobalsRunRoom = ____exports.default
    GlobalsRunRoom.name = "GlobalsRunRoom"
    function GlobalsRunRoom.prototype.____constructor(self)
    end
    return GlobalsRunRoom
end)()
return ____exports
end,
["types.GlobalsRun"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____GlobalsRunLevel = require("types.GlobalsRunLevel")
local GlobalsRunLevel = ____GlobalsRunLevel.default
local ____GlobalsRunRoom = require("types.GlobalsRunRoom")
local GlobalsRunRoom = ____GlobalsRunRoom.default
____exports.default = (function()
    ____exports.default = __TS__Class()
    local GlobalsRun = ____exports.default
    GlobalsRun.name = "GlobalsRun"
    function GlobalsRun.prototype.____constructor(self)
        self.restart = false
        self.roomsEntered = 0
        self.level = __TS__New(GlobalsRunLevel, 0, 0)
        self.room = __TS__New(GlobalsRunRoom)
        self.race = {finished = false, finishedTime = 0, victoryLaps = 0}
        self.freeDevilItem = {takenDamage = {}, granted = false}
        self.fastClear = {aliveEnemies = {}, aliveEnemiesCount = 0, aliveBossesCount = 0, buttonsAllPushed = false, roomInitializing = false, delayFrame = 0, vanillaPhotosSpawning = false, paschalCandleCounters = 0, roomClearAwardSeed = 0, roomClearAwardSeedDevilAngel = 0}
        self.fastReset = {frame = 0, consoleOpened = false}
        self.debugChaosCard = false
    end
    return GlobalsRun
end)()
return ____exports
end,
["types.RaceData"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
____exports.default = (function()
    ____exports.default = __TS__Class()
    local RaceData = ____exports.default
    RaceData.name = "RaceData"
    function RaceData.prototype.____constructor(self)
        self.userID = 0
        self.raceID = 0
        self.status = "none"
        self.myStatus = "not ready"
        self.ranked = false
        self.solo = false
        self.rFormat = "unseeded"
        self.difficulty = "normal"
        self.character = PlayerType.PLAYER_JUDAS
        self.goal = "Blue Baby"
        self.seed = "-"
        self.startingItems = {}
        self.countdown = -1
        self.placeMid = 0
        self.place = 1
        self.numEntrants = 1
    end
    return RaceData
end)()
return ____exports
end,
["types.SpeedrunData"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
____exports.default = (function()
    ____exports.default = __TS__Class()
    local SpeedrunData = ____exports.default
    SpeedrunData.name = "SpeedrunData"
    function SpeedrunData.prototype.____constructor(self)
        self.fastReset = false
        self.characterNum = 1
    end
    return SpeedrunData
end)()
return ____exports
end,
["types.Globals"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____Config = require("types.Config")
local Config = ____Config.default
local ____enums = require("types.enums")
local SaveFileState = ____enums.SaveFileState
local ____GlobalsRun = require("types.GlobalsRun")
local GlobalsRun = ____GlobalsRun.default
local ____RaceData = require("types.RaceData")
local RaceData = ____RaceData.default
local ____SpeedrunData = require("types.SpeedrunData")
local SpeedrunData = ____SpeedrunData.default
____exports.default = (function()
    ____exports.default = __TS__Class()
    local Globals = ____exports.default
    Globals.name = "Globals"
    function Globals.prototype.____constructor(self)
        self.debug = false
        self.corrupted = false
        self.g = Game()
        self.l = Game():GetLevel()
        self.r = Game():GetRoom()
        self.p = Isaac.GetPlayer()
        self.seeds = Game():GetSeeds()
        self.itemPool = Game():GetItemPool()
        self.itemConfig = Isaac.GetItemConfig()
        self.sfx = SFXManager()
        self.music = MusicManager()
        self.config = __TS__New(Config)
        self.run = __TS__New(GlobalsRun)
        self.race = __TS__New(RaceData)
        self.speedrun = __TS__New(SpeedrunData)
        self.saveFile = {state = SaveFileState.NOT_CHECKED, fullyUnlocked = false, oldRun = {challenge = 0, character = 0, seededRun = false, seed = ""}}
    end
    return Globals
end)()
return ____exports
end,
["globals"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____Globals = require("types.Globals")
local Globals = ____Globals.default
local globals = __TS__New(Globals)
____exports.default = globals
RacingPlusGlobals = globals
return ____exports
end,
["cache"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____globals = require("globals")
local g = ____globals.default
function ____exports.updateAPIFunctions(self)
    g.l = g.g:GetLevel()
    g.r = g.g:GetRoom()
    local player = Isaac.GetPlayer()
    if player ~= nil then
        g.p = player
    end
    g.seeds = g.g:GetSeeds()
    g.itemPool = g.g:GetItemPool()
end
return ____exports
end,
["cardMap"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local CARD_MAP = __TS__New(Map, {{"fool", 1}, {"magician", 2}, {"magi", 2}, {"mag", 2}, {"high priestess", 3}, {"highpriestess", 3}, {"high", 3}, {"priestess", 3}, {"priest", 3}, {"hp", 3}, {"empress", 4}, {"emperor", 5}, {"emp", 5}, {"hierophant", 6}, {"hiero", 6}, {"lovers", 7}, {"chariot", 8}, {"justice", 9}, {"hermit", 10}, {"wheel of fortune", 11}, {"wheeloffortune", 11}, {"wheel", 11}, {"fortune", 11}, {"strength", 12}, {"str", 12}, {"hanged man", 13}, {"hangedman", 13}, {"hanged", 13}, {"death", 14}, {"temperance", 15}, {"devil", 16}, {"tower", 17}, {"stars", 18}, {"moon", 19}, {"sun", 20}, {"judgement", 21}, {"judge", 21}, {"world", 22}, {"2 of clubs", 23}, {"2ofclubs", 23}, {"2clubs", 23}, {"2 of diamonds", 24}, {"2ofdiamonds", 24}, {"2diamonds", 24}, {"2 of spades", 25}, {"2ofspades", 25}, {"2spades", 25}, {"2 of hearts", 26}, {"2ofhearts", 26}, {"2hearts", 26}, {"ace of clubs", 27}, {"aceofclubs", 27}, {"aceclubs", 27}, {"ace of diamonds", 28}, {"aceofdiamonds", 28}, {"acediamonds", 28}, {"ace of spades", 29}, {"aceofspades", 29}, {"acespades", 29}, {"ace of hearts", 30}, {"aceofhearts", 30}, {"acehearts", 30}, {"joker", 31}, {"hagalaz", 32}, {"destruction", 32}, {"jera", 33}, {"abundance", 33}, {"ehwaz", 34}, {"passage", 34}, {"dagaz", 35}, {"purity", 35}, {"ansuz", 36}, {"vision", 36}, {"perthro", 37}, {"change", 37}, {"berkano", 38}, {"companionship", 38}, {"algiz", 39}, {"resistance", 39}, {"shield", 39}, {"blank", 40}, {"black", 41}, {"chaos", 42}, {"credit", 43}, {"rules", 44}, {"against humanity", 45}, {"againsthumanity", 45}, {"humanity", 45}, {"suicide king", 46}, {"suicideking", 46}, {"suicide", 46}, {"get out of jail free", 47}, {"getoutofjailfree", 47}, {"get out of jail", 47}, {"getoutofjail", 47}, {"get out", 47}, {"getout", 47}, {"jail", 47}, {"?", 48}, {"dice shard", 49}, {"diceshard", 49}, {"dice", 49}, {"shard", 49}, {"emergency contact", 50}, {"emergencycontact", 50}, {"emergency", 50}, {"contact", 50}, {"holy", 51}, {"huge growth", 52}, {"hugegrowth", 52}, {"growth", 52}, {"ancient recall", 53}, {"ancientrecall", 53}, {"ancient", 53}, {"recall", 53}, {"era walk", 54}, {"erawalk", 54}, {"era", 54}, {"walk", 54}, {"rune shard", 55}, {"runeshard", 55}, {"shard", 55}, {"fool?", 56}, {"fool2", 56}, {"magician?", 57}, {"magician2", 57}, {"magi?", 57}, {"magi2", 57}, {"mag?", 57}, {"mag2", 57}, {"high priestess?", 58}, {"high priestess2", 58}, {"highpriestess?", 58}, {"highpriestess2", 58}, {"high?", 58}, {"high2", 58}, {"priestess?", 58}, {"priestess2", 58}, {"priest?", 58}, {"priest2", 58}, {"hp?", 58}, {"hp2", 58}, {"empress?", 59}, {"empress2", 59}, {"emperor?", 60}, {"emperor2", 60}, {"emp?", 60}, {"emp2", 60}, {"hierophant?", 61}, {"hierophant2", 61}, {"hiero?", 61}, {"hiero2", 61}, {"lovers?", 62}, {"lovers2", 62}, {"chariot?", 63}, {"chariot2", 63}, {"justice?", 64}, {"justice2", 64}, {"hermit?", 65}, {"hermit2", 65}, {"wheel of fortune?", 66}, {"wheel of fortune2", 66}, {"wheeloffortune?", 66}, {"wheeloffortune2", 66}, {"wheel?", 66}, {"wheel2", 66}, {"fortune?", 66}, {"fortune2", 66}, {"strength?", 67}, {"strength2", 67}, {"str?", 67}, {"str2", 67}, {"hanged man?", 68}, {"hanged man2", 68}, {"hangedman?", 68}, {"hangedman2", 68}, {"hanged?", 68}, {"hanged2", 68}, {"death?", 69}, {"death2", 69}, {"temperance?", 70}, {"temperance2", 70}, {"devil?", 71}, {"devil2", 71}, {"tower?", 72}, {"tower2", 72}, {"stars?", 73}, {"stars2", 73}, {"moon?", 74}, {"moon2", 74}, {"sun?", 75}, {"sun2", 75}, {"judgement?", 76}, {"judgement2", 76}, {"judge?", 76}, {"judge2", 76}, {"world?", 77}, {"world2", 77}, {"cracked key", 78}, {"crackedkey", 78}, {"cracked", 78}, {"key", 78}, {"queen of hearts", 79}, {"queenofhearts", 79}, {"queen hearts", 79}, {"queenhearts", 79}, {"queen", 79}, {"wild card", 80}, {"wildcard", 80}, {"wild", 80}, {"soul of isaac", 81}, {"soulofisaac", 81}, {"soulisaac", 81}, {"isaac", 81}, {"soul of magdalene", 82}, {"soulofmagdalene", 82}, {"soulmagdalene", 82}, {"magdalene", 82}, {"soul of cain", 83}, {"soulofcain", 83}, {"soulcain", 83}, {"cain", 83}, {"soul of judas", 84}, {"soulofjudas", 84}, {"souljudas", 84}, {"judas", 84}, {"soul of ???", 85}, {"soulof???", 85}, {"soul???", 85}, {"???", 85}, {"soul of blue baby", 85}, {"soulofbluebaby", 85}, {"soulbluebaby", 85}, {"blue baby", 85}, {"bluebaby", 85}, {"soul of eve", 86}, {"soulofeve", 86}, {"souleve", 86}, {"eve", 86}, {"soul of samson", 87}, {"soulofsamson", 87}, {"soulsamson", 87}, {"samson", 87}, {"soul of azazel", 88}, {"soulofazazel", 88}, {"soulazazel", 88}, {"azazel", 88}, {"soul of lazarus", 89}, {"souloflazarus", 89}, {"soullazarus", 89}, {"lazarus", 89}, {"soul of eden", 90}, {"soulofeden", 90}, {"souleden", 90}, {"eden", 90}, {"soul of the lost", 91}, {"soulofthelost", 91}, {"souloflost", 91}, {"soullost", 91}, {"the lost", 91}, {"thelost", 91}, {"lost", 91}, {"soul of lilith", 92}, {"souloflilith", 92}, {"soullilith", 92}, {"lilith", 92}, {"soul of the keeper", 93}, {"soulofthekeeper", 93}, {"soulofkeeper", 93}, {"soulkeeper", 93}, {"keeper", 93}, {"soul of apollyon", 94}, {"soulofapollyon", 94}, {"soulapollyon", 94}, {"apollyon", 94}, {"soul of the forgotten", 95}, {"souloftheforgotten", 95}, {"soulofforgotten", 95}, {"soulforgotten", 95}, {"forgotten", 95}, {"soul of bethany", 96}, {"soulofbethany", 96}, {"soulbethany", 96}, {"bethany", 96}, {"soul of jacob and esau", 97}, {"soul of jacob & esau", 97}, {"soul of jacob", 97}, {"soulofjacobandesau", 97}, {"soulofjacob&esau", 97}, {"soulofjacob", 97}, {"souljacobandesau", 97}, {"souljacob&esau", 97}, {"souljacob", 97}, {"jacobandesau", 97}, {"jacob&esau", 97}, {"jacob", 97}})
____exports.default = CARD_MAP
return ____exports
end,
["saveDat"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local json = require("json")
local ____globals = require("globals")
local g = ____globals.default
require("lib.RevelCopyTable")
local ____Globals = require("types.Globals")
local Globals = ____Globals.default
local loadSuccess
function loadSuccess(self, newGlobals)
    local validatedNewGlobals = RevelCopyTable(newGlobals, g)
    g.config = validatedNewGlobals.config
    g.run = validatedNewGlobals.run
end
local mod = nil
function ____exports.setMod(self, newMod)
    mod = newMod
end
function ____exports.save(self)
    if mod == nil then
        error("\"saveDat.save()\" was called without the mod being initialized.")
    end
    local encodedData = json.encode(g)
    mod:SaveData(encodedData)
end
function ____exports.load(self)
    if mod == nil then
        error("\"saveDat.load()\" was called without the mod being initialized.")
    end
    if not Isaac.HasModData(mod) then
        return
    end
    local newGlobals = nil
    local function loadJSON()
        if mod == nil then
            return
        end
        local modDataString = Isaac.LoadModData(mod)
        if __TS__StringTrim(modDataString) == "" then
            newGlobals = __TS__New(Globals)
        else
            newGlobals = json.decode(modDataString)
        end
    end
    local ok = pcall(loadJSON)
    if ok and (newGlobals ~= nil) then
        loadSuccess(nil, newGlobals)
    else
        error("Failed to load the \"save#.dat\" file.")
    end
end
return ____exports
end,
["config"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____globals = require("globals")
local g = ____globals.default
local saveDat = require("saveDat")
function ____exports.set(self, key, value)
    g.config[key] = value
    saveDat:save()
end
return ____exports
end,
["configDescription"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
____exports.MAJOR_CHANGES = {{"startWithD6", {4, "001", "Start with the D6", "Makes each character start with a D6 or a pocket D6."}}, {"disableCurses", {4, "002", "Disable curses", "Disables all curses, like Curse of the Maze."}}, {"freeDevilItem", {4, "003", "Free devil item", "Awards a Your Soul trinket upon entering the Basement 2 Devil Room if you have not taken damage."}}, {"fastClear", {4, "004", "Fast room clear", "Makes doors open at the beginning of the death animation instead of at the end."}}}
____exports.CUSTOM_HOTKEYS = {{"fastDropAllKeyboard", {6, "011", "Fast drop", "Drop all of your items instantaneously."}}, {"fastDropAllController", {7, "011", "Fast drop", "Drop all of your items instantaneously."}}, {"fastDropTrinketsKeyboard", {6, "011", "Fast drop (pocket)", "Drop your pocket items instantaneously."}}, {"fastDropTrinketsController", {7, "011", "Fast drop (trinkets)", "Drop your trinkets instantaneously."}}, {"fastDropPocketKeyboard", {6, "011", "Fast drop (pocket)", "Drop your pocket items instantaneously."}}, {"fastDropPocketController", {7, "011", "Fast drop (pocket)", "Drop your pocket items instantaneously."}}}
____exports.GAMEPLAY_AND_QUALITY_OF_LIFE_CHANGES = {{"judasAddBomb", {4, "021", "Add a bomb to Judas", "Makes Judas start with 1 bomb instead of 0 bombs."}}, {"samsonDropHeart", {4, "022", "Make Samson drop his trinket", "Makes Samson automatically drop his Child's Heart trinket at the beginning of a run."}}, {"fastReset", {4, "023", "Fast reset", "Instantaneously restart the game as soon as you press the R key."}}, {"fixTeleportInvalidEntrance", {4, "024", "Fix bad teleports", "Never teleport to a non-existent entrance."}}}
____exports.ALL_DESCRIPTIONS = {
    table.unpack(
        __TS__ArrayConcat(
            {
                table.unpack(____exports.MAJOR_CHANGES)
            },
            {
                table.unpack(____exports.CUSTOM_HOTKEYS)
            },
            {
                table.unpack(____exports.GAMEPLAY_AND_QUALITY_OF_LIFE_CHANGES)
            }
        )
    )
}
return ____exports
end,
["constants"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
____exports.VERSION = "0.56.1"
return ____exports
end,
["debugFunction"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____globals = require("globals")
local g = ____globals.default
local printFastClearVariables
function printFastClearVariables(self)
    Isaac.DebugString("Fast clear variables:")
    Isaac.DebugString("- aliveEnemies:")
    for key, value in pairs(g.run.fastClear.aliveEnemies) do
        Isaac.DebugString(
            (("  - " .. tostring(key)) .. " - ") .. tostring(value)
        )
    end
    Isaac.DebugString(
        "- aliveEnemiesCount: " .. tostring(g.run.fastClear.aliveEnemiesCount)
    )
    Isaac.DebugString(
        "- aliveBossesCount: " .. tostring(g.run.fastClear.aliveBossesCount)
    )
    Isaac.DebugString(
        "- buttonsAllPushed: " .. tostring(g.run.fastClear.buttonsAllPushed)
    )
    Isaac.DebugString(
        "- roomInitializing: " .. tostring(g.run.fastClear.roomInitializing)
    )
    Isaac.DebugString(
        "- delayFrame: " .. tostring(g.run.fastClear.delayFrame)
    )
    Isaac.DebugString(
        "- vanillaPhotosSpawning: " .. tostring(g.run.fastClear.vanillaPhotosSpawning)
    )
    Isaac.DebugString(
        "- paschalCandleCounters: " .. tostring(g.run.fastClear.paschalCandleCounters)
    )
    Isaac.DebugString(
        "- roomClearAwardSeed: " .. tostring(g.run.fastClear.roomClearAwardSeed)
    )
    Isaac.DebugString(
        "- roomClearAwardSeedDevilAngel: " .. tostring(g.run.fastClear.roomClearAwardSeedDevilAngel)
    )
end
function ____exports.default(self)
    g.debug = true
    Isaac.DebugString("+--------------------------+")
    Isaac.DebugString("| Entering debug function. |")
    Isaac.DebugString("+--------------------------+")
    printFastClearVariables(nil)
    Isaac.DebugString("+-------------------------+")
    Isaac.DebugString("| Exiting debug function. |")
    Isaac.DebugString("+-------------------------+")
end
return ____exports
end,
["misc"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____globals = require("globals")
local g = ____globals.default
function ____exports.getRoomIndex(self)
    local roomIndex = g.l:GetCurrentRoomDesc().SafeGridIndex
    if roomIndex < 0 then
        return g.l:GetCurrentRoomIndex()
    end
    return roomIndex
end
function ____exports.initRNG(self, seed)
    local RECOMMENDED_SHIFT_IDX = 35
    local rng = RNG()
    rng:SetSeed(seed, RECOMMENDED_SHIFT_IDX)
    return rng
end
function ____exports.consoleCommand(self, command)
    Isaac.DebugString("Executing console command: " .. command)
    Isaac.ExecuteCommand(command)
    Isaac.DebugString("Finished executing console command: " .. command)
end
____exports.ensureAllCases = function(____, obj) return obj end
function ____exports.enteredRoomViaTeleport(self)
    local roomIndex = ____exports.getRoomIndex(nil)
    local startingRoomIndex = g.l:GetStartingRoomIndex()
    local isFirstVisit = g.r:IsFirstVisit()
    local justReachedThisFloor = (roomIndex == startingRoomIndex) and isFirstVisit
    return (g.l.LeaveDoor == -1) and (not justReachedThisFloor)
end
function ____exports.getItemMaxCharges(self, itemID)
    local itemConfigItem = g.itemConfig:GetCollectible(itemID)
    if itemConfigItem == nil then
        return 0
    end
    return itemConfigItem.MaxCharges
end
function ____exports.getOpenTrinketSlot(self, player)
    local maxTrinkets = player:GetMaxTrinkets()
    local trinket0 = player:GetTrinket(0)
    local trinket1 = player:GetTrinket(1)
    if maxTrinkets == 1 then
        return ((trinket0 == TrinketType.TRINKET_NULL) and 0) or nil
    end
    if maxTrinkets == 2 then
        if trinket0 == TrinketType.TRINKET_NULL then
            return 0
        end
        return ((trinket1 == TrinketType.TRINKET_NULL) and 1) or nil
    end
    error(
        ("The player has " .. tostring(maxTrinkets)) .. " trinket slots, which is not supported."
    )
    return nil
end
function ____exports.getPlayers(self)
    local players = {}
    do
        local i = 0
        while i < g.g:GetNumPlayers() do
            local player = Isaac.GetPlayer(i)
            if player ~= nil then
                __TS__ArrayPush(players, player)
            end
            i = i + 1
        end
    end
    return players
end
function ____exports.getRandom(self, x, y, seed)
    local rng = ____exports.initRNG(nil, seed)
    return rng:RandomInt((y - x) + 1) + x
end
function ____exports.gridToPos(self, x, y)
    x = x + 1
    y = y + 1
    local gridIndex = (y * g.r:GetGridWidth()) + x
    return g.r:GetGridPosition(gridIndex)
end
function ____exports.incrementRNG(self, seed)
    local rng = ____exports.initRNG(nil, seed)
    rng:Next()
    return rng:GetSeed()
end
function ____exports.isActionTriggeredOnAnyInput(self, buttonAction)
    do
        local i = 0
        while i <= 3 do
            if Input.IsActionTriggered(buttonAction, i) then
                return true
            end
            i = i + 1
        end
    end
    return false
end
function ____exports.openAllDoors(self)
    do
        local i = 0
        while i <= 7 do
            local door = g.r:GetDoor(i)
            if door ~= nil then
                door:Open()
            end
            i = i + 1
        end
    end
end
function ____exports.teleport(self, roomIndex)
    g.l.LeaveDoor = -1
    g.g:StartRoomTransition(roomIndex, Direction.NO_DIRECTION, RoomTransitionAnim.TELEPORT)
end
return ____exports
end,
["features.freeDevilItem"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____globals = require("globals")
local g = ____globals.default
local ____misc = require("misc")
local enteredRoomViaTeleport = ____misc.enteredRoomViaTeleport
local getOpenTrinketSlot = ____misc.getOpenTrinketSlot
local getPlayers = ____misc.getPlayers
local giveTrinket
function giveTrinket(self, player)
    g.p:AnimateHappy()
    if getOpenTrinketSlot(nil, player) ~= nil then
        g.p:AddTrinket(TrinketType.TRINKET_YOUR_SOUL)
    else
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, TrinketType.TRINKET_YOUR_SOUL, g.p.Position, Vector.Zero, nil)
    end
end
function ____exports.entityTakeDmg(self, tookDamage, _damageAmount, _damageFlags, _damageSource, _damageCountdownFrames)
    if not g.config.freeDevilItem then
        return
    end
    local player = tookDamage:ToPlayer()
    if player ~= nil then
        g.run.freeDevilItem.takenDamage[player.ControllerIndex] = true
    end
end
function ____exports.postNewRoom(self)
    if not g.config.freeDevilItem then
        return
    end
    local stage = g.l:GetStage()
    local roomType = g.r:GetType()
    if (((not g.run.freeDevilItem.granted) and (stage == 2)) and (roomType == RoomType.ROOM_DEVIL)) and (not enteredRoomViaTeleport(nil)) then
        g.run.freeDevilItem.granted = true
        for ____, player in ipairs(
            getPlayers(nil)
        ) do
            local takenDamage = g.run.freeDevilItem.takenDamage[player.ControllerIndex]
            if takenDamage == nil then
                giveTrinket(nil, player)
            end
        end
    end
end
return ____exports
end,
["callbacks.entityTakeDmg"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local freeDevilItem = require("features.freeDevilItem")
function ____exports.main(self, tookDamage, damageAmount, damageFlags, damageSource, damageCountdownFrames)
    freeDevilItem:entityTakeDmg(tookDamage, damageAmount, damageFlags, damageSource, damageCountdownFrames)
    return nil
end
return ____exports
end,
["callbacks.executeCmdSubroutines"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____globals = require("globals")
local g = ____globals.default
local ____misc = require("misc")
local teleport = ____misc.teleport
function ____exports.blackMarket(self)
    teleport(nil, GridRooms.ROOM_BLACK_MARKET_IDX)
end
function ____exports.chaosCardTears(self)
    g.run.debugChaosCard = not g.run.debugChaosCard
    local enabled = (g.run.debugChaosCard and "Enabled") or "Disabled"
    print(enabled .. " Chaos Card tears.")
end
function ____exports.commands(self, functionMap)
    local commandNames = {}
    for ____, ____value in __TS__Iterator(functionMap) do
        local commandName
        commandName = ____value[1]
        __TS__ArrayPush(commandNames, commandName)
    end
    table.sort(commandNames)
    print("List of Racing+ commands:")
    local text = table.concat(commandNames, " " or ",")
    print(text)
end
function ____exports.devil(self)
    g.p:UseCard(Card.CARD_JOKER)
end
function ____exports.IAMERROR(self)
    teleport(nil, GridRooms.ROOM_ERROR_IDX)
end
function ____exports.validateNumber(self, params)
    local num = tonumber(params)
    if num == nil then
        print("You must specify a number.")
    end
    return num
end
return ____exports
end,
["callbacks.executeCmdFunctions"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____cardMap = require("cardMap")
local CARD_MAP = ____cardMap.default
local ____debugFunction = require("debugFunction")
local debugFunction = ____debugFunction.default
local ____globals = require("globals")
local g = ____globals.default
local ____misc = require("misc")
local gridToPos = ____misc.gridToPos
local ____executeCmdSubroutines = require("callbacks.executeCmdSubroutines")
local blackMarket = ____executeCmdSubroutines.blackMarket
local chaosCardTears = ____executeCmdSubroutines.chaosCardTears
local commands = ____executeCmdSubroutines.commands
local devil = ____executeCmdSubroutines.devil
local IAMERROR = ____executeCmdSubroutines.IAMERROR
local validateNumber = ____executeCmdSubroutines.validateNumber
local functionMap = __TS__New(Map)
____exports.default = functionMap
functionMap:set(
    "angel",
    function(____, _params)
        local hasEucharist = g.p:HasCollectible(CollectibleType.COLLECTIBLE_EUCHARIST)
        if not hasEucharist then
            g.p:AddCollectible(CollectibleType.COLLECTIBLE_EUCHARIST, 0, false)
        end
        g.p:UseCard(Card.CARD_JOKER)
        if not hasEucharist then
            g.p:RemoveCollectible(CollectibleType.COLLECTIBLE_EUCHARIST)
        end
    end
)
functionMap:set(
    "blackmarket",
    function(____, _params)
        blackMarket(nil)
    end
)
functionMap:set(
    "boss",
    function(____, _params)
        g.p:UseCard(Card.CARD_EMPEROR)
    end
)
functionMap:set(
    "bm",
    function(____, _params)
        blackMarket(nil)
    end
)
functionMap:set(
    "card",
    function(____, params)
        if params == "" then
            print("You must specify a card name.")
            return
        end
        local num = tonumber(params)
        if num ~= nil then
            if (num < 1) or (num >= Card.NUM_CARDS) then
                print("That is an invalid card ID.")
                return
            end
            Isaac.ExecuteCommand(
                "g k" .. tostring(num)
            )
            print(
                "Gave card: #" .. tostring(num)
            )
            return
        end
        local giveCardID = 0
        for ____, ____value in __TS__Iterator(CARD_MAP) do
            local word
            word = ____value[1]
            local cardID
            cardID = ____value[2]
            if params == word then
                giveCardID = cardID
                break
            end
        end
        if giveCardID == 0 then
            print("Unknown card.")
            return
        end
        Isaac.ExecuteCommand(
            "g k" .. tostring(giveCardID)
        )
        print(
            "Gave card: #" .. tostring(giveCardID)
        )
    end
)
functionMap:set(
    "cards",
    function(____, _params)
        local cardNum = 1
        do
            local y = 0
            while y <= 6 do
                do
                    local x = 0
                    while x <= 12 do
                        if cardNum < Card.NUM_CARDS then
                            local pos = gridToPos(nil, x, y)
                            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, cardNum, pos, Vector.Zero, nil)
                            cardNum = cardNum + 1
                        end
                        x = x + 1
                    end
                end
                y = y + 1
            end
        end
    end
)
functionMap:set(
    "cc",
    function(____, _params)
        chaosCardTears(nil)
    end
)
functionMap:set(
    "chaos",
    function(____, _params)
        chaosCardTears(nil)
    end
)
functionMap:set(
    "dd",
    function(____, _params)
        devil(nil)
    end
)
functionMap:set(
    "debug",
    function(____, _params)
        debugFunction(nil)
    end
)
functionMap:set(
    "devil",
    function(____, _params)
        devil(nil)
    end
)
functionMap:set(
    "char",
    function(____, params)
        if params == "" then
            print("You must specify a character number.")
        end
        local num = validateNumber(nil, params)
        if num == nil then
            return
        end
        g.speedrun.characterNum = num
    end
)
functionMap:set(
    "commands",
    function(____, _params)
        commands(nil, functionMap)
    end
)
functionMap:set(
    "fool",
    function(____, _params)
        g.p:UseCard(Card.CARD_FOOL)
    end
)
functionMap:set(
    "error",
    function(____, _params)
        IAMERROR(nil)
    end
)
functionMap:set(
    "help",
    function(____, _params)
        commands(nil, functionMap)
    end
)
functionMap:set(
    "iamerror",
    function(____, _params)
        IAMERROR(nil)
    end
)
functionMap:set(
    "list",
    function(____, _params)
        Isaac.DebugString("Entities in the room:")
        local roomEntities = Isaac.GetRoomEntities()
        do
            local i = 0
            while i < #roomEntities do
                local entity = roomEntities[i + 1]
                local debugString = (((((tostring(i + 1) .. "  - ") .. tostring(entity.Type)) .. ".") .. tostring(entity.Variant)) .. ".") .. tostring(entity.SubType)
                local npc = entity:ToNPC()
                if npc ~= nil then
                    debugString = tostring(debugString) .. ("." .. tostring(npc.State))
                end
                debugString = tostring(debugString) .. ((" (InitSeed: " .. tostring(entity.InitSeed)) .. ")")
                Isaac.DebugString(debugString)
                i = i + 1
            end
        end
        print("Logged the entities in the room to the \"log.txt\" file.")
    end
)
functionMap:set(
    "pills",
    function(____, _params)
        local pillNum = 1
        do
            local y = 0
            while y <= 6 do
                do
                    local x = 0
                    while x <= 12 do
                        if pillNum < PillColor.NUM_PILLS then
                            local pos = gridToPos(nil, x, y)
                            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_PILL, pillNum, pos, Vector.Zero, nil)
                            pillNum = 1
                        end
                        x = x + 1
                    end
                end
                y = y + 1
            end
        end
    end
)
functionMap:set(
    "shop",
    function(____, _params)
        g.p:UseCard(Card.CARD_HERMIT)
    end
)
functionMap:set(
    "sounds",
    function(____, _params)
        print("Printing out the currently playing sounds:")
        do
            local i = 0
            while i < SoundEffect.NUM_SOUND_EFFECTS do
                if g.sfx:IsPlaying(i) then
                    Isaac.DebugString(
                        "Currently playing sound effect: " .. tostring(i)
                    )
                end
                i = i + 1
            end
        end
    end
)
functionMap:set(
    "treasure",
    function(____, _params)
        g.p:UseCard(Card.CARD_STARS)
    end
)
return ____exports
end,
["callbacks.executeCmd"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____executeCmdFunctions = require("callbacks.executeCmdFunctions")
local executeCmdFunctions = ____executeCmdFunctions.default
function ____exports.main(self, command, parameters)
    local debugString = "MC_EXECUTE_CMD - " .. command
    if parameters ~= "" then
        debugString = tostring(debugString) .. (" " .. parameters)
    end
    Isaac.DebugString(debugString)
    local executeCmdFunction = executeCmdFunctions:get(command)
    if executeCmdFunction ~= nil then
        executeCmdFunction(nil, parameters)
    else
        print("Unknown Racing+ command.")
    end
end
return ____exports
end,
["features.fastClear.tracking"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____globals = require("globals")
local g = ____globals.default
local isAttachedNPC, checkFlushOldRoom, add, remove
function isAttachedNPC(self, npc)
    return (((((((((((npc.Type == EntityType.ENTITY_CHARGER) and (npc.Variant == 0)) and (npc.SubType == 1)) or ((npc.Type == EntityType.ENTITY_VIS) and (npc.Variant == 22))) or ((npc.Type == EntityType.ENTITY_DEATH) and (npc.Variant == 10))) or ((npc.Type == EntityType.ENTITY_PEEP) and (npc.Variant == 10))) or ((npc.Type == EntityType.ENTITY_PEEP) and (npc.Variant == 11))) or ((npc.Type == EntityType.ENTITY_BEGOTTEN) and (npc.Variant == 10))) or ((npc.Type == EntityType.ENTITY_MAMA_GURDY) and (npc.Variant == 1))) or ((npc.Type == EntityType.ENTITY_MAMA_GURDY) and (npc.Variant == 2))) or ((npc.Type == EntityType.ENTITY_BIG_HORN) and (npc.Variant == 1))) or ((npc.Type == EntityType.ENTITY_BIG_HORN) and (npc.Variant == 2))
end
function checkFlushOldRoom(self)
    local roomFrameCount = g.r:GetFrameCount()
    if (roomFrameCount == -1) and (not g.run.fastClear.roomInitializing) then
        g.run.fastClear.aliveEnemies = {}
        g.run.fastClear.aliveEnemiesCount = 0
        g.run.fastClear.aliveBossesCount = 0
        g.run.fastClear.roomInitializing = true
        g.run.fastClear.delayFrame = 0
        Isaac.DebugString("Fast-Clear - Reset all variables.")
    end
end
function add(self, ptrHash, isBoss)
    g.run.fastClear.aliveEnemies[ptrHash] = isBoss
    local ____obj, ____index = g.run.fastClear, "aliveEnemiesCount"
    ____obj[____index] = ____obj[____index] + 1
    if isBoss then
        local ____obj, ____index = g.run.fastClear, "aliveBossesCount"
        ____obj[____index] = ____obj[____index] + 1
    end
    Isaac.DebugString(
        "FastClear - Added: " .. tostring(ptrHash)
    )
end
function remove(self, ptrHash, isBoss)
    local gameFrameCount = g.g:GetFrameCount()
    g.run.fastClear.aliveEnemies[ptrHash] = nil
    local ____obj, ____index = g.run.fastClear, "aliveEnemiesCount"
    ____obj[____index] = ____obj[____index] - 1
    if isBoss then
        local ____obj, ____index = g.run.fastClear, "aliveBossesCount"
        ____obj[____index] = ____obj[____index] - 1
    end
    g.run.fastClear.delayFrame = gameFrameCount + 1
end
function ____exports.checkAdd(self, npc)
    local isBoss = npc:IsBoss()
    local ptrHash = GetPtrHash(npc)
    if g.run.fastClear.aliveEnemies[ptrHash] ~= nil then
        return
    end
    if not npc.CanShutDoors then
        return
    end
    if npc:IsDead() then
        return
    end
    if ((npc.Type == EntityType.ENTITY_RAGLING) and (npc.Variant == 1)) and (npc.State == NpcState.STATE_UNIQUE_DEATH) then
        return
    end
    if isAttachedNPC(nil, npc) then
        return
    end
    checkFlushOldRoom(nil)
    add(nil, ptrHash, isBoss)
end
function ____exports.checkRemove(self, npc, parentFunction)
    local ptrHash = GetPtrHash(npc)
    local isBoss = g.run.fastClear.aliveEnemies[ptrHash]
    if isBoss == nil then
        return
    end
    if (npc:GetChampionColorIdx() == ChampionColor.DARK_RED) and (parentFunction == "PostEntityKill") then
        return
    end
    remove(nil, ptrHash, isBoss)
end
return ____exports
end,
["features.fastClear.callbacks.NPCUpdate"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____globals = require("globals")
local g = ____globals.default
local tracking = require("features.fastClear.tracking")
function ____exports.main(self, npc)
    if not g.config.fastClear then
        return
    end
    if npc:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) then
        tracking:checkRemove(npc, "NPCUpdate")
        return
    end
    tracking:checkAdd(npc)
end
function ____exports.ragling(self, npc)
    if not g.config.fastClear then
        return
    end
    if (npc.Variant == 1) and (npc.State == NpcState.STATE_UNIQUE_DEATH) then
        tracking:checkRemove(npc, "NPCUpdateRagling")
    end
end
function ____exports.stoney(self, npc)
    if not g.config.fastClear then
        return
    end
    local ptrHash = GetPtrHash(npc)
    if g.run.fastClear.aliveEnemies[ptrHash] ~= nil then
        g.run.fastClear.aliveEnemies[ptrHash] = nil
        local ____obj, ____index = g.run.fastClear, "aliveEnemiesCount"
        ____obj[____index] = ____obj[____index] - 1
    end
end
return ____exports
end,
["callbacks.NPCUpdate"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local fastClearNPCUpdate = require("features.fastClear.callbacks.NPCUpdate")
function ____exports.main(self, npc)
    fastClearNPCUpdate:main(npc)
end
function ____exports.ragling(self, npc)
    fastClearNPCUpdate:ragling(npc)
end
function ____exports.stoney(self, npc)
    fastClearNPCUpdate:stoney(npc)
end
return ____exports
end,
["features.disableCurses"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____globals = require("globals")
local g = ____globals.default
function ____exports.default(self)
    if not g.config.disableCurses then
        return nil
    end
    return LevelCurse.CURSE_NONE
end
return ____exports
end,
["callbacks.postCurseEval"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____disableCurses = require("features.disableCurses")
local disableCurses = ____disableCurses.default
function ____exports.main(self, curses)
    local newCurses = disableCurses(nil)
    if newCurses ~= nil then
        return newCurses
    end
    return curses
end
return ____exports
end,
["features.fastClear.callbacks.postEntityKill"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____globals = require("globals")
local g = ____globals.default
local tracking = require("features.fastClear.tracking")
function ____exports.main(self, entity)
    if not g.config.fastClear then
        return
    end
    local npc = entity:ToNPC()
    if npc == nil then
        return
    end
    tracking:checkRemove(npc, "postEntityKill")
end
return ____exports
end,
["callbacks.postEntityKill"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local fastClearPostEntityKill = require("features.fastClear.callbacks.postEntityKill")
function ____exports.main(self, entity)
    fastClearPostEntityKill:main(entity)
end
return ____exports
end,
["features.fastClear.callbacks.postEntityRemove"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____globals = require("globals")
local g = ____globals.default
local tracking = require("features.fastClear.tracking")
function ____exports.main(self, entity)
    if not g.config.fastClear then
        return
    end
    local npc = entity:ToNPC()
    if npc == nil then
        return
    end
    tracking:checkRemove(npc, "postEntityRemove")
end
return ____exports
end,
["callbacks.postEntityRemove"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local fastClearPostEntityRemove = require("features.fastClear.callbacks.postEntityRemove")
function ____exports.main(self, entity)
    fastClearPostEntityRemove:main(entity)
end
return ____exports
end,
["features.centerStart"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____globals = require("globals")
local g = ____globals.default
local ____misc = require("misc")
local getPlayers = ____misc.getPlayers
local centerPlayer, distributeAround
function centerPlayer(self)
    local centerPos = g.r:GetCenterPos()
    local players = getPlayers(nil)
    if #players == 1 then
        g.p.Position = centerPos
    else
        local distanceBetweenPlayers = 50
        local positions = distributeAround(nil, centerPos, distanceBetweenPlayers, #players)
        do
            local i = 0
            while i < #players do
                players[i + 1].Position = positions[i + 1]
                i = i + 1
            end
        end
    end
    local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)
    for ____, familiar in ipairs(familiars) do
        familiar.Position = centerPos
    end
end
function distributeAround(self, centerPos, distance, numPoints)
    local positions = {}
    local leftOfCenter = Vector(-distance, 0)
    do
        local i = 0
        while i < numPoints do
            local rotatedPosition = leftOfCenter:Rotated((i * 360) / numPoints)
            local positionFromCenter = centerPos:__add(rotatedPosition)
            __TS__ArrayPush(positions, positionFromCenter)
            i = i + 1
        end
    end
    return positions
end
function ____exports.postGameStarted(self)
    if (g.g.Difficulty == Difficulty.DIFFICULTY_NORMAL) or (g.g.Difficulty == Difficulty.DIFFICULTY_HARD) then
        centerPlayer(nil)
    end
end
return ____exports
end,
["features.judasAddBomb"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____globals = require("globals")
local g = ____globals.default
function ____exports.postGameStarted(self)
    if not g.config.judasAddBomb then
        return
    end
    local character = g.p:GetPlayerType()
    if character == PlayerType.PLAYER_JUDAS then
        g.p:AddBombs(1)
    end
end
return ____exports
end,
["features.samsonDropHeart"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____globals = require("globals")
local g = ____globals.default
local ____misc = require("misc")
local gridToPos = ____misc.gridToPos
function ____exports.postGameStarted(self)
    if not g.config.samsonDropHeart then
        return
    end
    local character = g.p:GetPlayerType()
    if character == PlayerType.PLAYER_SAMSON then
        g.p:TryRemoveTrinket(TrinketType.TRINKET_CHILDS_HEART)
        local childsHeart = Isaac.Spawn(
            EntityType.ENTITY_PICKUP,
            PickupVariant.PICKUP_TRINKET,
            TrinketType.TRINKET_CHILDS_HEART,
            gridToPos(nil, 0, 6),
            Vector.Zero,
            g.p
        )
        childsHeart:GetSprite():Play("Idle", true)
    end
end
return ____exports
end,
["features.saveFileCheck"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____globals = require("globals")
local g = ____globals.default
local ____misc = require("misc")
local consoleCommand = ____misc.consoleCommand
local ____enums = require("types.enums")
local SaveFileState = ____enums.SaveFileState
local SAVE_FILE_SEED = "31XY AQGT"
local EDEN_ACTIVE_ITEM = CollectibleType.COLLECTIBLE_DEATH_CERTIFICATE
local EDEN_PASSIVE_ITEM = CollectibleType.COLLECTIBLE_MR_DOLLY
function ____exports.isNotFullyUnlocked(self)
    local character = g.p:GetPlayerType()
    local activeItem = g.p:GetActiveItem()
    local startSeedString = g.seeds:GetStartSeedString()
    local customRun = g.seeds:IsCustomRun()
    local challenge = Isaac.GetChallenge()
    if g.saveFile.state == SaveFileState.FINISHED then
        return false
    end
    if g.saveFile.state == SaveFileState.NOT_CHECKED then
        g.saveFile.oldRun.challenge = challenge
        g.saveFile.oldRun.character = character
        if (challenge == 0) and customRun then
            g.saveFile.oldRun.seededRun = true
            g.saveFile.oldRun.seed = startSeedString
        end
        g.saveFile.state = SaveFileState.GOING_TO_EDEN
    end
    if g.saveFile.state == SaveFileState.GOING_TO_EDEN then
        local valid = true
        if challenge ~= Challenge.CHALLENGE_NULL then
            valid = false
        end
        if character ~= PlayerType.PLAYER_EDEN then
            valid = false
        end
        if startSeedString ~= SAVE_FILE_SEED then
            valid = false
        end
        if not valid then
            g.run.restart = true
            return true
        end
        local neededActiveItem = EDEN_ACTIVE_ITEM
        local neededPassiveItem = EDEN_PASSIVE_ITEM
        local text = ("Error: On seed \"" .. SAVE_FILE_SEED) .. "\", Eden needs "
        if activeItem ~= neededActiveItem then
            text = tostring(text) .. (((("an active item of " .. tostring(neededActiveItem)) .. " (they have an active item of ") .. tostring(activeItem)) .. ").")
            Isaac.DebugString(text)
        elseif not g.p:HasCollectible(neededPassiveItem) then
            text = tostring(text) .. (("a passive item of " .. tostring(neededPassiveItem)) .. ".")
            Isaac.DebugString(text)
        else
            g.saveFile.fullyUnlocked = true
            Isaac.DebugString("Valid save file detected.")
        end
        g.saveFile.state = SaveFileState.GOING_BACK
    end
    if g.saveFile.state == SaveFileState.GOING_BACK then
        local valid = true
        if challenge ~= g.saveFile.oldRun.challenge then
            valid = false
        end
        if character ~= g.saveFile.oldRun.character then
            valid = false
        end
        if customRun ~= g.saveFile.oldRun.seededRun then
            valid = false
        end
        if g.saveFile.oldRun.seededRun and (startSeedString ~= g.saveFile.oldRun.seed) then
            valid = false
        end
        if not valid then
            g.run.restart = true
            return true
        end
        g.saveFile.state = SaveFileState.FINISHED
    end
    return false
end
function ____exports.checkRestart(self)
    local character = g.p:GetPlayerType()
    local customRun = g.seeds:IsCustomRun()
    local startSeedString = g.seeds:GetStartSeedString()
    local challenge = Isaac.GetChallenge()
    local ____switch21 = g.saveFile.state
    if ____switch21 == SaveFileState.GOING_TO_EDEN then
        goto ____switch21_case_0
    elseif ____switch21 == SaveFileState.GOING_BACK then
        goto ____switch21_case_1
    end
    goto ____switch21_case_default
    ::____switch21_case_0::
    do
        do
            if challenge ~= Challenge.CHALLENGE_NULL then
                consoleCommand(
                    nil,
                    "challenge " .. tostring(Challenge.CHALLENGE_NULL)
                )
            end
            if character ~= PlayerType.PLAYER_EDEN then
                consoleCommand(
                    nil,
                    "restart " .. tostring(PlayerType.PLAYER_EDEN)
                )
            end
            if startSeedString ~= SAVE_FILE_SEED then
                consoleCommand(nil, "seed " .. SAVE_FILE_SEED)
            end
            return true
        end
    end
    ::____switch21_case_1::
    do
        do
            if challenge ~= g.saveFile.oldRun.challenge then
                consoleCommand(
                    nil,
                    "challenge " .. tostring(g.saveFile.oldRun.challenge)
                )
            end
            if character ~= g.saveFile.oldRun.character then
                consoleCommand(
                    nil,
                    "restart " .. tostring(g.saveFile.oldRun.character)
                )
            end
            if customRun ~= g.saveFile.oldRun.seededRun then
                g.seeds:Reset()
                consoleCommand(nil, "restart")
            end
            if g.saveFile.oldRun.seededRun and (startSeedString ~= g.saveFile.oldRun.seed) then
                consoleCommand(nil, "seed " .. g.saveFile.oldRun.seed)
            end
            return true
        end
    end
    ::____switch21_case_default::
    do
        do
            return false
        end
    end
    ::____switch21_end::
end
return ____exports
end,
["features.startWithD6"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____globals = require("globals")
local g = ____globals.default
local givePocketActiveD6, giveActiveD6
function givePocketActiveD6(self)
    g.p:SetPocketActiveItem(CollectibleType.COLLECTIBLE_D6, ActiveSlot.SLOT_POCKET)
end
function giveActiveD6(self)
    g.p:AddCollectible(CollectibleType.COLLECTIBLE_D6, 6)
end
local TAINTED_CHARACTERS_WITHOUT_POCKET_ACTIVES = {PlayerType.PLAYER_ISAAC_B, PlayerType.PLAYER_SAMSON_B, PlayerType.PLAYER_AZAZEL_B, PlayerType.PLAYER_EDEN_B, PlayerType.PLAYER_THELOST_B, PlayerType.PLAYER_LILITH_B, PlayerType.PLAYER_KEEPER_B, PlayerType.PLAYER_THEFORGOTTEN_B, PlayerType.PLAYER_THESOUL_B}
local TAINTED_CHARACTERS_WITH_POCKET_ACTIVES = {PlayerType.PLAYER_MAGDALENA_B, PlayerType.PLAYER_CAIN_B, PlayerType.PLAYER_JUDAS_B, PlayerType.PLAYER_XXX_B, PlayerType.PLAYER_EVE_B, PlayerType.PLAYER_LAZARUS_B, PlayerType.PLAYER_APOLLYON_B, PlayerType.PLAYER_BETHANY_B, PlayerType.PLAYER_JACOB_B, PlayerType.PLAYER_LAZARUS2_B, PlayerType.PLAYER_JACOB2_B}
function ____exports.postGameStarted(self)
    if not g.config.startWithD6 then
        return
    end
    local character = g.p:GetPlayerType()
    if (character >= PlayerType.PLAYER_ISAAC) and (character <= PlayerType.PLAYER_ESAU) then
        givePocketActiveD6(nil)
    elseif __TS__ArrayIncludes(TAINTED_CHARACTERS_WITHOUT_POCKET_ACTIVES, character) then
        givePocketActiveD6(nil)
    elseif __TS__ArrayIncludes(TAINTED_CHARACTERS_WITH_POCKET_ACTIVES, character) then
        giveActiveD6(nil)
    end
end
return ____exports
end,
["callbacks.postGameStartedContinued"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____globals = require("globals")
local g = ____globals.default
local saveDat = require("saveDat")
local ____enums = require("types.enums")
local SaveFileState = ____enums.SaveFileState
function ____exports.main(self)
    saveDat:load()
    if g.saveFile.state == SaveFileState.NOT_CHECKED then
        g.saveFile.state = SaveFileState.DEFERRED_UNTIL_NEW_RUN_BEGINS
    end
end
return ____exports
end,
["features.fastClear.callbacks.postNewRoom"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____globals = require("globals")
local g = ____globals.default
local resetVariables
function resetVariables(self)
    g.run.fastClear.buttonsAllPushed = false
    g.run.fastClear.roomInitializing = false
end
function ____exports.main(self)
    if not g.config.fastClear then
        return
    end
    resetVariables(nil)
end
return ____exports
end,
["features.fixTeleportInvalidEntrance"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____globals = require("globals")
local g = ____globals.default
local ____misc = require("misc")
local enteredRoomViaTeleport = ____misc.enteredRoomViaTeleport
local getPlayers = ____misc.getPlayers
local getDoorEnterPosition
function getDoorEnterPosition(self, doorSlot, doorPosition)
    local x = doorPosition.X
    local y = doorPosition.Y
    if (doorSlot == DoorSlot.LEFT0) or (doorSlot == DoorSlot.LEFT1) then
        x = x + 40
    elseif (doorSlot == DoorSlot.UP0) or (doorSlot == DoorSlot.UP1) then
        y = y + 40
    elseif (doorSlot == DoorSlot.RIGHT0) or (doorSlot == DoorSlot.RIGHT1) then
        x = x - 40
    elseif (doorSlot == DoorSlot.DOWN0) or (doorSlot == DoorSlot.DOWN1) then
        y = y - 40
    end
    return Vector(x, y)
end
function ____exports.postNewRoom(self)
    if not g.config.fixTeleportInvalidEntrance then
        return
    end
    local roomShape = g.r:GetRoomShape()
    if not enteredRoomViaTeleport(nil) then
        return
    end
    if roomShape >= RoomShape.ROOMSHAPE_1x2 then
        return
    end
    local nextToADoor = false
    local firstDoorSlot = nil
    local firstDoorPosition = nil
    do
        local i = 0
        while i <= 7 do
            local door = g.r:GetDoor(i)
            if ((door ~= nil) and (door.TargetRoomType ~= RoomType.ROOM_SECRET)) and (door.TargetRoomType ~= RoomType.ROOM_SUPERSECRET) then
                if firstDoorSlot == nil then
                    firstDoorSlot = i
                    firstDoorPosition = Vector(door.Position.X, door.Position.Y)
                end
                if door.Position:Distance(g.p.Position) < 60 then
                    nextToADoor = true
                    break
                end
            end
            i = i + 1
        end
    end
    if ((not nextToADoor) and (firstDoorSlot ~= nil)) and (firstDoorPosition ~= nil) then
        local doorOffset = getDoorEnterPosition(nil, firstDoorSlot, firstDoorPosition)
        for ____, player in ipairs(
            getPlayers(nil)
        ) do
            player.Position = doorOffset
        end
        local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)
        for ____, familiar in ipairs(familiars) do
            familiar.Position = doorOffset
        end
    end
end
return ____exports
end,
["callbacks.postNewRoom"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local cache = require("cache")
local fastClearPostNewRoom = require("features.fastClear.callbacks.postNewRoom")
local fixTeleportInvalidEntrance = require("features.fixTeleportInvalidEntrance")
local freeDevilItem = require("features.freeDevilItem")
local ____globals = require("globals")
local g = ____globals.default
local ____GlobalsRunRoom = require("types.GlobalsRunRoom")
local GlobalsRunRoom = ____GlobalsRunRoom.default
function ____exports.newRoom(self)
    local stage = g.l:GetStage()
    local stageType = g.l:GetStageType()
    local roomDesc = g.l:GetCurrentRoomDesc()
    local roomStageID = roomDesc.Data.StageID
    local roomVariant = roomDesc.Data.Variant
    Isaac.DebugString(
        ((((((("MC_POST_NEW_ROOM_2 - " .. tostring(roomStageID)) .. ".") .. tostring(roomVariant)) .. " (on stage ") .. tostring(stage)) .. ".") .. tostring(stageType)) .. ")"
    )
    g.run.room = __TS__New(GlobalsRunRoom)
    local ____obj, ____index = g.run, "roomsEntered"
    ____obj[____index] = ____obj[____index] + 1
    freeDevilItem:postNewRoom()
    fastClearPostNewRoom:main()
    fixTeleportInvalidEntrance:postNewRoom()
end
function ____exports.main(self)
    cache:updateAPIFunctions()
    local gameFrameCount = g.g:GetFrameCount()
    local stage = g.l:GetStage()
    local stageType = g.l:GetStageType()
    local roomDesc = g.l:GetCurrentRoomDesc()
    local roomStageID = roomDesc.Data.StageID
    local roomVariant = roomDesc.Data.Variant
    Isaac.DebugString(
        ((((((("MC_POST_NEW_ROOM - " .. tostring(roomStageID)) .. ".") .. tostring(roomVariant)) .. " (on stage ") .. tostring(stage)) .. ".") .. tostring(stageType)) .. ")"
    )
    if ((gameFrameCount == 0) or (g.run.level.stage ~= stage)) or (g.run.level.stageType ~= stageType) then
        return
    end
    ____exports.newRoom(nil)
end
return ____exports
end,
["callbacks.postNewLevel"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____globals = require("globals")
local g = ____globals.default
local saveDat = require("saveDat")
local ____GlobalsRunLevel = require("types.GlobalsRunLevel")
local GlobalsRunLevel = ____GlobalsRunLevel.default
local postNewRoom = require("callbacks.postNewRoom")
function ____exports.newLevel(self)
    local stage = g.l:GetStage()
    local stageType = g.l:GetStageType()
    Isaac.DebugString(
        (("MC_POST_NEW_LEVEL_2 - " .. tostring(stage)) .. ".") .. tostring(stageType)
    )
    g.run.level = __TS__New(GlobalsRunLevel, stage, stageType)
    saveDat:save()
    postNewRoom:newRoom()
end
function ____exports.main(self)
    local gameFrameCount = g.g:GetFrameCount()
    local stage = g.l:GetStage()
    local stageType = g.l:GetStageType()
    Isaac.DebugString(
        (("MC_POST_NEW_LEVEL - " .. tostring(stage)) .. ".") .. tostring(stageType)
    )
    if gameFrameCount == 0 then
        return
    end
    ____exports.newLevel(nil)
end
return ____exports
end,
["callbacks.postGameStarted"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local centerStart = require("features.centerStart")
local judasAddBomb = require("features.judasAddBomb")
local samsonDropHeart = require("features.samsonDropHeart")
local saveFileCheck = require("features.saveFileCheck")
local startWithD6 = require("features.startWithD6")
local ____globals = require("globals")
local g = ____globals.default
local ____GlobalsRun = require("types.GlobalsRun")
local GlobalsRun = ____GlobalsRun.default
local postGameStartedContinued = require("callbacks.postGameStartedContinued")
local postNewLevel = require("callbacks.postNewLevel")
local checkCorruptMod
function checkCorruptMod(self)
    local sprite = Sprite()
    sprite:Load("gfx/ui/boss/versusscreen.anm2", true)
    sprite:SetFrame("Scene", 0)
    sprite:SetLastFrame()
    local lastFrame = sprite:GetFrame()
    if lastFrame ~= 0 then
        Isaac.DebugString(
            ("Error: Corrupted Racing+ instantiation detected. (The last frame of the \"Scene\" animation is frame " .. tostring(lastFrame)) .. ".)"
        )
        g.corrupted = true
    end
    return g.corrupted
end
function ____exports.main(self, isContinued)
    local startSeedString = g.seeds:GetStartSeedString()
    local isaacFrameCount = Isaac.GetFrameCount()
    Isaac.DebugString(
        (("MC_POST_GAME_STARTED - Seed: " .. startSeedString) .. " - IsaacFrame: ") .. tostring(isaacFrameCount)
    )
    g.seeds:RemoveSeedEffect(SeedEffect.SEED_PERMANENT_CURSE_UNKNOWN)
    g.seeds:AddSeedEffect(SeedEffect.SEED_PREVENT_CURSE_DARKNESS)
    if MinimapAPI ~= nil then
        MinimapAPI.Config.Disable = false
    end
    if isContinued then
        postGameStartedContinued:main()
        return
    end
    g.run = __TS__New(GlobalsRun)
    if checkCorruptMod(nil) or saveFileCheck:isNotFullyUnlocked() then
        return
    end
    g.itemPool:RemoveTrinket(TrinketType.TRINKET_KARMA)
    centerStart:postGameStarted()
    startWithD6:postGameStarted()
    judasAddBomb:postGameStarted()
    samsonDropHeart:postGameStarted()
    postNewLevel:newLevel()
end
return ____exports
end,
["features.fastClear.callbacks.postNPCInit"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____globals = require("globals")
local g = ____globals.default
local tracking = require("features.fastClear.tracking")
function ____exports.main(self, npc)
    if not g.config.fastClear then
        return
    end
    tracking:checkAdd(npc)
end
return ____exports
end,
["callbacks.postNPCInit"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local fastClearPostNPCInit = require("features.fastClear.callbacks.postNPCInit")
function ____exports.main(self, npc)
    fastClearPostNPCInit:main(npc)
end
return ____exports
end,
["features.customConsole"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____globals = require("globals")
local g = ____globals.default
local ____misc = require("misc")
local consoleCommand = ____misc.consoleCommand
local isConsoleOpen, consoleText, consoleTextIndex, keysPressed, checkKeyboardInput, handleInput, open, close
function checkKeyboardInput(self)
    if g.g:IsPaused() then
        return
    end
    for ____, keyboardValue in ipairs(
        __TS__ObjectValues(Keyboard)
    ) do
        if Input.IsButtonPressed(keyboardValue, g.p.ControllerIndex) then
            keysPressed:set(keyboardValue, true)
        else
            keysPressed:delete(keyboardValue)
        end
    end
    if isConsoleOpen then
        handleInput(nil)
    elseif keysPressed:has(Keyboard.KEY_ENTER) then
        open(nil)
    end
end
function handleInput(self)
    if keysPressed:has(Keyboard.KEY_ENTER) then
        close(nil)
    end
end
function open(self)
    isConsoleOpen = true
    consoleText = ""
    consoleTextIndex = 0
end
function close(self)
    isConsoleOpen = false
    if consoleText ~= "" then
        consoleCommand(nil, consoleText)
    end
end
isConsoleOpen = false
consoleText = ""
consoleTextIndex = 0
Isaac.DebugString(
    tostring(consoleTextIndex)
)
keysPressed = __TS__New(Map)
function ____exports.postRender(self)
    checkKeyboardInput(nil)
end
return ____exports
end,
["features.fastReset"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____globals = require("globals")
local g = ____globals.default
local ____misc = require("misc")
local consoleCommand = ____misc.consoleCommand
local isActionTriggeredOnAnyInput = ____misc.isActionTriggeredOnAnyInput
local checkConsoleInput, checkResetInput, reset
function checkConsoleInput(self)
    if g.run.fastReset.consoleOpened then
        return
    end
    if Input.IsButtonTriggered(Keyboard.KEY_GRAVE_ACCENT, 0) then
        g.run.fastReset.consoleOpened = true
        Isaac.DebugString("The console was opened for the first time on this run.")
    end
end
function checkResetInput(self)
    if g.run.fastReset.consoleOpened then
        return
    end
    if ((((Input.IsButtonPressed(Keyboard.KEY_LEFT_CONTROL, 0) or Input.IsButtonPressed(Keyboard.KEY_LEFT_ALT, 0)) or Input.IsButtonPressed(Keyboard.KEY_LEFT_SUPER, 0)) or Input.IsButtonPressed(Keyboard.KEY_RIGHT_CONTROL, 0)) or Input.IsButtonPressed(Keyboard.KEY_RIGHT_ALT, 0)) or Input.IsButtonPressed(Keyboard.KEY_RIGHT_SUPER, 0) then
        return
    end
    if isActionTriggeredOnAnyInput(nil, ButtonAction.ACTION_RESTART) then
        reset(nil)
    end
end
function reset(self)
    local isaacFrameCount = Isaac.GetFrameCount()
    if (g.run.roomsEntered <= 3) or (isaacFrameCount <= (g.run.fastReset.frame + 60)) then
        g.speedrun.fastReset = true
        consoleCommand(nil, "restart")
    else
        g.run.fastReset.frame = isaacFrameCount
    end
end
function ____exports.postRender(self)
    if not g.config.fastReset then
        return
    end
    checkConsoleInput(nil)
    checkResetInput(nil)
end
return ____exports
end,
["features.race.main"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____globals = require("globals")
local g = ____globals.default
local ____misc = require("misc")
local consoleCommand = ____misc.consoleCommand
function ____exports.checkRestartWrongCharacter(self)
    if (g.race.status == "none") or (g.race.rFormat == "custom") then
        return false
    end
    local character = g.p:GetPlayerType()
    if character ~= g.race.character then
        consoleCommand(
            nil,
            "restart " .. tostring(g.race.character)
        )
        return true
    end
    return false
end
function ____exports.checkRestartWrongSeed(self)
    if (g.race.rFormat ~= "seeded") or (g.race.status ~= "in progress") then
        return false
    end
    local startSeedString = g.seeds:GetStartSeedString()
    if startSeedString ~= g.race.seed then
        consoleCommand(nil, "seed " .. g.race.seed)
        return true
    end
    return false
end
return ____exports
end,
["features.speedrun.main"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
function ____exports.checkRestartWrongCharacter(self)
    return false
end
return ____exports
end,
["callbacks.postRender"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local cache = require("cache")
local customConsole = require("features.customConsole")
local fastReset = require("features.fastReset")
local race = require("features.race.main")
local saveFileCheck = require("features.saveFileCheck")
local speedrun = require("features.speedrun.main")
local ____globals = require("globals")
local g = ____globals.default
local ____misc = require("misc")
local consoleCommand = ____misc.consoleCommand
local checkRestart
function checkRestart(self)
    if not g.run.restart then
        return false
    end
    g.run.restart = false
    if saveFileCheck:checkRestart() then
        return true
    end
    if race:checkRestartWrongCharacter() then
        return true
    end
    if race:checkRestartWrongSeed() then
        return true
    end
    if speedrun:checkRestartWrongCharacter() then
        return true
    end
    consoleCommand(nil, "restart")
    return true
end
function ____exports.main(self)
    cache:updateAPIFunctions()
    if checkRestart(nil) then
        return
    end
    customConsole:postRender()
    fastReset:postRender()
end
return ____exports
end,
["features.fastClear.bagFamiliarSubroutines"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____globals = require("globals")
local g = ____globals.default
local ____misc = require("misc")
local initRNG = ____misc.initRNG
function ____exports.getCurrentFamiliarSeed(self, familiar)
    local rng = initRNG(nil, familiar.InitSeed)
    do
        local i = 0
        while i < familiar.RoomClearCount do
            rng:Next()
            i = i + 1
        end
    end
    return rng:GetSeed()
end
local MULTIPLIER_MAP = {[FamiliarVariant.BOMB_BAG] = {0.35, 0.42}, [FamiliarVariant.BOMB_BAG] = {0.35, 0.42}, [FamiliarVariant.SACK_OF_PENNIES] = {0.5, 0.57}, [FamiliarVariant.SACK_OF_PENNIES] = {0.5, 0.57}, [FamiliarVariant.LITTLE_CHAD] = {0.35, 0.42}, [FamiliarVariant.RELIC] = {0.166, 0.125}, [FamiliarVariant.MYSTERY_SACK] = {0.18, 0.22}, [FamiliarVariant.RUNE_BAG] = {0.125, 0.166}, [FamiliarVariant.ACID_BABY] = {0.125, 0.166}, [FamiliarVariant.SACK_OF_SACKS] = {0.125, 0.166}}
function ____exports.shouldDropSomething(self, familiar)
    local character = g.p:GetPlayerType()
    local multipliers = MULTIPLIER_MAP[familiar.Variant]
    if multipliers == nil then
        error(
            "Failed to find the multipliers for familiar variant: " .. tostring(familiar.Variant)
        )
    end
    local multiplierNormal, multiplierBFFS = table.unpack(multipliers)
    local multiplier = (g.p:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) and multiplierBFFS) or multiplierNormal
    if character == PlayerType.PLAYER_BETHANY then
        multiplier = multiplier * 0.75
    end
    return math.floor((familiar.RoomClearCount + 1) * multiplier) > math.floor(familiar.RoomClearCount * multiplier)
end
function ____exports.shouldDropHeart(self, familiar)
    return (not g.p:HasTrinket(TrinketType.TRINKET_DAEMONS_TAIL)) or ((____exports.getCurrentFamiliarSeed(nil, familiar) & 5) == 0)
end
return ____exports
end,
["features.fastClear.bagFamiliarFunctions"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____globals = require("globals")
local g = ____globals.default
local ____misc = require("misc")
local getRandom = ____misc.getRandom
local incrementRNG = ____misc.incrementRNG
local ____bagFamiliarSubroutines = require("features.fastClear.bagFamiliarSubroutines")
local getCurrentFamiliarSeed = ____bagFamiliarSubroutines.getCurrentFamiliarSeed
local shouldDropHeart = ____bagFamiliarSubroutines.shouldDropHeart
local shouldDropSomething = ____bagFamiliarSubroutines.shouldDropSomething
local functionMap = __TS__New(Map)
____exports.default = functionMap
functionMap:set(
    FamiliarVariant.BOMB_BAG,
    function(____, familiar)
        if shouldDropSomething(nil, familiar) then
            g.g:Spawn(
                EntityType.ENTITY_PICKUP,
                PickupVariant.PICKUP_BOMB,
                familiar.Position,
                Vector.Zero,
                familiar,
                0,
                getCurrentFamiliarSeed(nil, familiar)
            )
        end
    end
)
functionMap:set(
    FamiliarVariant.SACK_OF_PENNIES,
    function(____, familiar)
        if shouldDropSomething(nil, familiar) then
            g.g:Spawn(
                EntityType.ENTITY_PICKUP,
                PickupVariant.PICKUP_COIN,
                familiar.Position,
                Vector.Zero,
                g.p,
                0,
                getCurrentFamiliarSeed(nil, familiar)
            )
        end
    end
)
functionMap:set(
    FamiliarVariant.LITTLE_CHAD,
    function(____, familiar)
        if shouldDropSomething(nil, familiar) and shouldDropHeart(nil, familiar) then
            g.g:Spawn(
                EntityType.ENTITY_PICKUP,
                PickupVariant.PICKUP_HEART,
                familiar.Position,
                Vector.Zero,
                familiar,
                HeartSubType.HEART_HALF,
                getCurrentFamiliarSeed(nil, familiar)
            )
        end
    end
)
functionMap:set(
    FamiliarVariant.RELIC,
    function(____, familiar)
        if shouldDropSomething(nil, familiar) and shouldDropHeart(nil, familiar) then
            g.g:Spawn(
                EntityType.ENTITY_PICKUP,
                PickupVariant.PICKUP_HEART,
                familiar.Position,
                Vector.Zero,
                familiar,
                HeartSubType.HEART_SOUL,
                getCurrentFamiliarSeed(nil, familiar)
            )
        end
    end
)
functionMap:set(
    FamiliarVariant.JUICY_SACK,
    function(____, familiar)
        local familiarSeed = getCurrentFamiliarSeed(nil, familiar)
        local spiders = getRandom(nil, 1, 2, familiarSeed)
        g.p:AddBlueSpider(familiar.Position)
        if spiders == 2 then
            g.p:AddBlueSpider(familiar.Position)
        end
        if g.p:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) then
            g.p:AddBlueSpider(familiar.Position)
        end
    end
)
functionMap:set(
    FamiliarVariant.MYSTERY_SACK,
    function(____, familiar)
        if not shouldDropSomething(nil, familiar) then
            return
        end
        local familiarSeed = getCurrentFamiliarSeed(nil, familiar)
        local mysterySackPickupType = getRandom(nil, 1, 4, familiarSeed)
        local ____switch15 = mysterySackPickupType
        if ____switch15 == 1 then
            goto ____switch15_case_0
        elseif ____switch15 == 2 then
            goto ____switch15_case_1
        elseif ____switch15 == 3 then
            goto ____switch15_case_2
        elseif ____switch15 == 4 then
            goto ____switch15_case_3
        end
        goto ____switch15_case_default
        ::____switch15_case_0::
        do
            do
                if shouldDropHeart(nil, familiar) then
                    local heartType = getRandom(nil, 1, 11, familiarSeed)
                    g.g:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, familiar.Position, Vector.Zero, familiar, heartType, familiarSeed)
                end
                goto ____switch15_end
            end
        end
        ::____switch15_case_1::
        do
            do
                local coinType = getRandom(nil, 1, 6, familiarSeed)
                g.g:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, familiar.Position, Vector.Zero, familiar, coinType, familiarSeed)
                goto ____switch15_end
            end
        end
        ::____switch15_case_2::
        do
            do
                local keyType = getRandom(nil, 1, 4, familiarSeed)
                g.g:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_KEY, familiar.Position, Vector.Zero, familiar, keyType, familiarSeed)
                goto ____switch15_end
            end
        end
        ::____switch15_case_3::
        do
            do
                local bombType = getRandom(nil, 1, 4, familiarSeed)
                g.g:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, familiar.Position, Vector.Zero, familiar, bombType, familiarSeed)
                goto ____switch15_end
            end
        end
        ::____switch15_case_default::
        do
            do
                error("Invalid Mystery Sack pickup type.")
            end
        end
        ::____switch15_end::
    end
)
functionMap:set(
    FamiliarVariant.LIL_CHEST,
    function(____, familiar)
        local familiarSeed = getCurrentFamiliarSeed(nil, familiar)
        local lilChestTrinket = getRandom(nil, 1, 1000, familiarSeed)
        if (lilChestTrinket <= 100) or (g.p:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) and (lilChestTrinket <= 125)) then
            g.g:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, familiar.Position, Vector.Zero, familiar, 0, familiarSeed)
            return
        end
        familiarSeed = incrementRNG(nil, familiarSeed)
        local lilChestConsumable = getRandom(nil, 1, 10000, familiarSeed)
        if (lilChestConsumable <= 2500) or (g.p:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) and (lilChestConsumable <= 3125)) then
            familiarSeed = incrementRNG(nil, familiarSeed)
            local lilChestPickupType = getRandom(nil, 1, 4, familiarSeed)
            local ____switch25 = lilChestPickupType
            if ____switch25 == 1 then
                goto ____switch25_case_0
            elseif ____switch25 == 2 then
                goto ____switch25_case_1
            elseif ____switch25 == 3 then
                goto ____switch25_case_2
            elseif ____switch25 == 4 then
                goto ____switch25_case_3
            end
            goto ____switch25_case_default
            ::____switch25_case_0::
            do
                do
                    if shouldDropHeart(nil, familiar) then
                        g.g:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, familiar.Position, Vector.Zero, familiar, 0, familiarSeed)
                    end
                    goto ____switch25_end
                end
            end
            ::____switch25_case_1::
            do
                do
                    g.g:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, familiar.Position, Vector.Zero, familiar, 0, familiarSeed)
                    goto ____switch25_end
                end
            end
            ::____switch25_case_2::
            do
                do
                    g.g:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_KEY, familiar.Position, Vector.Zero, familiar, 0, familiarSeed)
                    goto ____switch25_end
                end
            end
            ::____switch25_case_3::
            do
                do
                    g.g:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, familiar.Position, Vector.Zero, familiar, 0, familiarSeed)
                    goto ____switch25_end
                end
            end
            ::____switch25_case_default::
            do
                do
                    error("Invalid Lil' Chest pickup type.")
                end
            end
            ::____switch25_end::
        end
    end
)
functionMap:set(
    FamiliarVariant.BUMBO,
    function(____, familiar)
        local bumboLevel = familiar.State + 1
        if bumboLevel ~= 2 then
            return
        end
        local familiarSeed = getCurrentFamiliarSeed(nil, familiar)
        local bumboPickup = getRandom(nil, 1, 100, familiarSeed)
        if (bumboPickup <= 32) or (g.p:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) and (bumboPickup <= 40)) then
            g.g:Spawn(EntityType.ENTITY_PICKUP, 0, familiar.Position, Vector.Zero, familiar, 0, familiarSeed)
        end
    end
)
functionMap:set(
    FamiliarVariant.RUNE_BAG,
    function(____, familiar)
        if shouldDropSomething(nil, familiar) then
            local familiarSeed = getCurrentFamiliarSeed(nil, familiar)
            local subType = g.itemPool:GetCard(familiarSeed, false, true, true)
            g.g:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, familiar.Position, Vector.Zero, familiar, subType, familiarSeed)
        end
    end
)
functionMap:set(
    FamiliarVariant.SPIDER_MOD,
    function(____, familiar)
        local familiarSeed = getCurrentFamiliarSeed(nil, familiar)
        local spiderModChance = getRandom(nil, 1, 1000, familiarSeed)
        if (spiderModChance <= 100) or (g.p:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) and (spiderModChance <= 125)) then
            familiarSeed = incrementRNG(nil, familiarSeed)
            local spiderModDrop = getRandom(nil, 1, 3, familiarSeed)
            if spiderModDrop == 1 then
                g.g:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_LIL_BATTERY, familiar.Position, Vector.Zero, familiar, 0, familiarSeed)
            else
                g.p:AddBlueSpider(familiar.Position)
            end
        end
    end
)
functionMap:set(
    FamiliarVariant.ACID_BABY,
    function(____, familiar)
        if shouldDropSomething(nil, familiar) then
            g.g:Spawn(
                EntityType.ENTITY_PICKUP,
                PickupVariant.PICKUP_PILL,
                familiar.Position,
                Vector.Zero,
                familiar,
                0,
                getCurrentFamiliarSeed(nil, familiar)
            )
        end
    end
)
functionMap:set(
    FamiliarVariant.SACK_OF_SACKS,
    function(____, familiar)
        if shouldDropSomething(nil, familiar) then
            g.g:Spawn(
                EntityType.ENTITY_PICKUP,
                PickupVariant.PICKUP_GRAB_BAG,
                familiar.Position,
                Vector.Zero,
                familiar,
                0,
                getCurrentFamiliarSeed(nil, familiar)
            )
        end
    end
)
return ____exports
end,
["features.fastClear.bagFamiliars"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____globals = require("globals")
local g = ____globals.default
local ____bagFamiliarFunctions = require("features.fastClear.bagFamiliarFunctions")
local bagFamiliarFunctions = ____bagFamiliarFunctions.default
local checkForDrops, paschalCandle
function checkForDrops(self, familiar)
    local bagFamiliarFunction = bagFamiliarFunctions:get(familiar.Variant)
    if bagFamiliarFunction ~= nil then
        bagFamiliarFunction(nil, familiar)
    end
end
function paschalCandle(self, familiar)
    if familiar.Variant ~= FamiliarVariant.PASCHAL_CANDLE then
        return
    end
    local oldCounters = g.run.fastClear.paschalCandleCounters
    local ____obj, ____index = g.run.fastClear, "paschalCandleCounters"
    ____obj[____index] = ____obj[____index] + 1
    local maxCounters = 5
    if g.run.fastClear.paschalCandleCounters > maxCounters then
        g.run.fastClear.paschalCandleCounters = maxCounters
    end
    if oldCounters ~= g.run.fastClear.paschalCandleCounters then
        g.p:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
        g.p:EvaluateItems()
    end
end
function ____exports.clearedRoom(self)
    local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)
    for ____, entity in ipairs(familiars) do
        local familiar = entity:ToFamiliar()
        if familiar ~= nil then
            familiar.RoomClearCount = familiar.RoomClearCount + 1
            checkForDrops(nil, familiar)
            paschalCandle(nil, familiar)
        end
    end
end
return ____exports
end,
["features.fastClear.photos"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____globals = require("globals")
local g = ____globals.default
local ____misc = require("misc")
local ensureAllCases = ____misc.ensureAllCases
local incrementRNG = ____misc.incrementRNG
local PhotoSituation, getPhotoSituation, getPhotoSituationRace, doPhotoSituation
function getPhotoSituation(self)
    local hasPolaroid = g.p:HasCollectible(CollectibleType.COLLECTIBLE_POLAROID)
    local hasNegative = g.p:HasCollectible(CollectibleType.COLLECTIBLE_NEGATIVE)
    if g.p:HasTrinket(TrinketType.TRINKET_MYSTERIOUS_PAPER) then
        hasPolaroid = false
        hasNegative = false
    end
    if hasPolaroid and hasNegative then
        return PhotoSituation.RANDOM_BOSS_ITEM
    end
    if hasPolaroid then
        return PhotoSituation.NEGATIVE
    end
    if hasNegative then
        return PhotoSituation.POLAROID
    end
    if g.race.status == "in progress" then
        return getPhotoSituationRace(nil, g.race.goal)
    end
    return PhotoSituation.BOTH
end
function getPhotoSituationRace(self, goal)
    local ____switch11 = goal
    if ____switch11 == "Blue Baby" then
        goto ____switch11_case_0
    elseif ____switch11 == "The Lamb" then
        goto ____switch11_case_1
    elseif ____switch11 == "Mega Satan" then
        goto ____switch11_case_2
    elseif ____switch11 == "Hush" then
        goto ____switch11_case_3
    elseif ____switch11 == "Delirium" then
        goto ____switch11_case_4
    elseif ____switch11 == "Boss Rush" then
        goto ____switch11_case_5
    elseif ____switch11 == "Everything" then
        goto ____switch11_case_6
    elseif ____switch11 == "Custom" then
        goto ____switch11_case_7
    end
    goto ____switch11_case_default
    ::____switch11_case_0::
    do
        do
            return PhotoSituation.POLAROID
        end
    end
    ::____switch11_case_1::
    do
        do
            return PhotoSituation.NEGATIVE
        end
    end
    ::____switch11_case_2::
    do
    end
    ::____switch11_case_3::
    do
    end
    ::____switch11_case_4::
    do
    end
    ::____switch11_case_5::
    do
    end
    ::____switch11_case_6::
    do
    end
    ::____switch11_case_7::
    do
        do
            return PhotoSituation.BOTH
        end
    end
    ::____switch11_case_default::
    do
        do
            ensureAllCases(nil, goal)
            return PhotoSituation.RANDOM_BOSS_ITEM
        end
    end
    ::____switch11_end::
end
function doPhotoSituation(self, situation)
    local roomSeed = g.r:GetSpawnSeed()
    local posCenter = Vector(320, 360)
    local posCenterLeft = Vector(280, 360)
    local posCenterRight = Vector(360, 360)
    local ____switch17 = situation
    if ____switch17 == PhotoSituation.POLAROID then
        goto ____switch17_case_0
    elseif ____switch17 == PhotoSituation.NEGATIVE then
        goto ____switch17_case_1
    elseif ____switch17 == PhotoSituation.BOTH then
        goto ____switch17_case_2
    elseif ____switch17 == PhotoSituation.RANDOM_BOSS_ITEM then
        goto ____switch17_case_3
    end
    goto ____switch17_case_default
    ::____switch17_case_0::
    do
        do
            g.g:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, posCenter, Vector.Zero, nil, CollectibleType.COLLECTIBLE_POLAROID, roomSeed)
            goto ____switch17_end
        end
    end
    ::____switch17_case_1::
    do
        do
            g.g:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, posCenter, Vector.Zero, nil, CollectibleType.COLLECTIBLE_NEGATIVE, roomSeed)
            goto ____switch17_end
        end
    end
    ::____switch17_case_2::
    do
        do
            local polaroid = g.g:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, posCenterLeft, Vector.Zero, nil, CollectibleType.COLLECTIBLE_POLAROID, roomSeed):ToPickup()
            if polaroid ~= nil then
                polaroid.OptionsPickupIndex = 1
            end
            local newSeed = incrementRNG(nil, roomSeed)
            local negative = g.g:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, posCenterRight, Vector.Zero, nil, CollectibleType.COLLECTIBLE_NEGATIVE, newSeed):ToPickup()
            if negative ~= nil then
                negative.OptionsPickupIndex = 1
            end
            goto ____switch17_end
        end
    end
    ::____switch17_case_3::
    do
        do
            if g.p:HasCollectible(CollectibleType.COLLECTIBLE_THERES_OPTIONS) then
                local item1 = g.g:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, posCenterLeft, Vector.Zero, nil, 0, roomSeed):ToPickup()
                if item1 ~= nil then
                    item1.OptionsPickupIndex = 1
                end
                local newSeed = incrementRNG(nil, roomSeed)
                local item2 = g.g:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, posCenterRight, Vector.Zero, nil, 0, newSeed):ToPickup()
                if item2 ~= nil then
                    item2.OptionsPickupIndex = 1
                end
            else
                g.g:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, posCenter, Vector.Zero, nil, 0, roomSeed)
            end
            goto ____switch17_end
        end
    end
    ::____switch17_case_default::
    do
        do
            ensureAllCases(nil, situation)
        end
    end
    ::____switch17_end::
end
PhotoSituation = PhotoSituation or ({})
PhotoSituation.POLAROID = 0
PhotoSituation[PhotoSituation.POLAROID] = "POLAROID"
PhotoSituation.NEGATIVE = 1
PhotoSituation[PhotoSituation.NEGATIVE] = "NEGATIVE"
PhotoSituation.BOTH = 2
PhotoSituation[PhotoSituation.BOTH] = "BOTH"
PhotoSituation.RANDOM_BOSS_ITEM = 3
PhotoSituation[PhotoSituation.RANDOM_BOSS_ITEM] = "RANDOM_BOSS_ITEM"
function ____exports.spawn(self)
    local stage = g.l:GetStage()
    local roomType = g.r:GetType()
    if (stage == 6) and (roomType == RoomType.ROOM_BOSS) then
        local situation = getPhotoSituation(nil)
        doPhotoSituation(nil, situation)
    end
end
return ____exports
end,
["features.fastClear.clearRoom"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____globals = require("globals")
local g = ____globals.default
local ____misc = require("misc")
local getItemMaxCharges = ____misc.getItemMaxCharges
local openAllDoors = ____misc.openAllDoors
local bagFamiliars = require("features.fastClear.bagFamiliars")
local photos = require("features.fastClear.photos")
local playDoorOpenSoundEffect, killExtraEntities, postBossActions, spawnClearAward
function playDoorOpenSoundEffect(self)
    local roomType = g.r:GetType()
    if roomType ~= RoomType.ROOM_DUNGEON then
        g.sfx:Play(SoundEffect.SOUND_DOOR_HEAVY_OPEN, 1, 0, false, 1)
    end
end
function killExtraEntities(self)
    for ____, entity in ipairs(
        Isaac.GetRoomEntities()
    ) do
        local ____switch7 = entity.Type
        if ____switch7 == EntityType.ENTITY_DEATHS_HEAD then
            goto ____switch7_case_0
        elseif ____switch7 == EntityType.ENTITY_FLESH_DEATHS_HEAD then
            goto ____switch7_case_1
        elseif ____switch7 == EntityType.ENTITY_EFFECT then
            goto ____switch7_case_2
        end
        goto ____switch7_case_default
        ::____switch7_case_0::
        do
            do
                if entity.Variant == 0 then
                    local npc = entity:ToNPC()
                    if npc ~= nil then
                        npc.State = 18
                    end
                end
                goto ____switch7_end
            end
        end
        ::____switch7_case_1::
        do
            do
                entity.Visible = false
                entity:Kill()
                local newHead = g.g:Spawn(entity.Type, entity.Variant, entity.Position, entity.Velocity, entity.Parent, entity.SubType, entity.InitSeed):ToNPC()
                if newHead ~= nil then
                    newHead.State = 18
                end
                goto ____switch7_end
            end
        end
        ::____switch7_case_2::
        do
            do
                if ((((((entity.Variant == EffectVariant.CREEP_RED) or (entity.Variant == EffectVariant.CREEP_GREEN)) or (entity.Variant == EffectVariant.CREEP_YELLOW)) or (entity.Variant == EffectVariant.CREEP_WHITE)) or (entity.Variant == EffectVariant.CREEP_BLACK)) or (entity.Variant == EffectVariant.CREEP_BROWN)) or (entity.Variant == EffectVariant.CREEP_SLIPPERY_BROWN) then
                    entity:Kill()
                end
                goto ____switch7_end
            end
        end
        ::____switch7_case_default::
        do
            do
                goto ____switch7_end
            end
        end
        ::____switch7_end::
    end
end
function postBossActions(self)
    local roomType = g.r:GetType()
    local stage = g.l:GetStage()
    if roomType ~= RoomType.ROOM_BOSS then
        return
    end
    g.r:TrySpawnDevilRoomDoor(true)
    if stage == 6 then
        local ignoreTime = (g.race.status == "in progress") and (g.race.goal == "Boss Rush")
        g.r:TrySpawnBossRushDoor(ignoreTime)
    elseif stage == 8 then
        if ((g.race.status == "in progress") and (g.race.goal == "Hush")) or ((g.race.status == "in progress") and (g.race.goal == "Delirium")) then
            g.r:TrySpawnBlueWombDoor(true, true)
        end
    end
end
function spawnClearAward(self)
    g.run.fastClear.vanillaPhotosSpawning = true
    g.r:SpawnClearAward()
    g.run.fastClear.vanillaPhotosSpawning = false
end
function ____exports.addCharge(self)
    local roomShape = g.r:GetRoomShape()
    do
        local i = 0
        while i < g.g:GetNumPlayers() do
            do
                local player = Isaac.GetPlayer(i)
                if player == nil then
                    goto __continue23
                end
                local activeItem = player:GetActiveItem()
                local activeCharge = player:GetActiveCharge()
                local batteryCharge = player:GetBatteryCharge()
                local maxCharges = getItemMaxCharges(nil, activeItem)
                if player:NeedsCharge() then
                    local chargesToAdd = 1
                    if roomShape >= RoomShape.ROOMSHAPE_2x2 then
                        chargesToAdd = 2
                    elseif player:HasTrinket(TrinketType.TRINKET_AAA_BATTERY) and (activeCharge == (maxCharges - 2)) then
                        chargesToAdd = 2
                    elseif ((player:HasTrinket(TrinketType.TRINKET_AAA_BATTERY) and (activeCharge == maxCharges)) and player:HasCollectible(CollectibleType.COLLECTIBLE_BATTERY)) and (batteryCharge == (maxCharges - 2)) then
                        chargesToAdd = 2
                    end
                    local currentCharge = player:GetActiveCharge()
                    player:SetActiveCharge(currentCharge + chargesToAdd)
                end
            end
            ::__continue23::
            i = i + 1
        end
    end
end
function ____exports.default(self)
    Isaac.DebugString("Fast-clear initiated.")
    g.r:SetClear(true)
    openAllDoors(nil)
    playDoorOpenSoundEffect(nil)
    killExtraEntities(nil)
    postBossActions(nil)
    spawnClearAward(nil)
    photos:spawn()
    ____exports.addCharge(nil)
    bagFamiliars:clearedRoom()
end
return ____exports
end,
["features.fastClear.callbacks.postUpdate"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____globals = require("globals")
local g = ____globals.default
local ____clearRoom = require("features.fastClear.clearRoom")
local clearRoom = ____clearRoom.default
local checkClearRoom, checkAllPressurePlatesPushed
function checkClearRoom(self)
    local gameFrameCount = g.g:GetFrameCount()
    local roomClear = g.r:IsClear()
    local roomFrameCount = g.r:GetFrameCount()
    if g.g.Difficulty >= Difficulty.DIFFICULTY_GREED then
        return
    end
    if g.seeds:HasSeedEffect(SeedEffect.SEED_PACIFIST) then
        return
    end
    if (g.run.fastClear.delayFrame ~= 0) and (gameFrameCount >= g.run.fastClear.delayFrame) then
        g.run.fastClear.delayFrame = 0
    end
    if ((((g.run.fastClear.aliveEnemiesCount == 0) and (g.run.fastClear.delayFrame == 0)) and (not roomClear)) and checkAllPressurePlatesPushed(nil)) and (roomFrameCount > 1) then
        clearRoom(nil)
    end
end
function checkAllPressurePlatesPushed(self)
    if g.run.fastClear.buttonsAllPushed or (not g.r:HasTriggerPressurePlates()) then
        return true
    end
    local gridSize = g.r:GetGridSize()
    do
        local i = 1
        while i <= gridSize do
            local gridEntity = g.r:GetGridEntity(i)
            if gridEntity ~= nil then
                local saveState = gridEntity:GetSaveState()
                if (saveState.Type == GridEntityType.GRID_PRESSURE_PLATE) and (saveState.State ~= 3) then
                    return false
                end
            end
            i = i + 1
        end
    end
    g.run.fastClear.buttonsAllPushed = true
    return true
end
function ____exports.main(self)
    if not g.config.fastClear then
        return
    end
    checkClearRoom(nil)
end
return ____exports
end,
["features.fastDrop"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____globals = require("globals")
local g = ____globals.default
local ____misc = require("misc")
local getPlayers = ____misc.getPlayers
local checkInput, checkInputAll, checkInputTrinkets, checkInputPocket, fastDrop
function checkInput(self)
    for ____, player in ipairs(
        getPlayers(nil)
    ) do
        checkInputAll(nil, player)
        checkInputTrinkets(nil, player)
        checkInputPocket(nil, player)
    end
end
function checkInputAll(self, player)
    if (g.config.fastDropAllKeyboard ~= -1) and InputHelper.KeyboardPressed(g.config.fastDropAllKeyboard, player.ControllerIndex) then
        fastDrop(nil, player, ____exports.FastDropTarget.ALL)
    end
    if (g.config.fastDropAllController ~= -1) and Input.IsButtonPressed(g.config.fastDropAllController, player.ControllerIndex) then
        fastDrop(nil, player, ____exports.FastDropTarget.ALL)
    end
end
function checkInputTrinkets(self, player)
    if (g.config.fastDropTrinketsKeyboard ~= -1) and InputHelper.KeyboardPressed(g.config.fastDropTrinketsKeyboard, player.ControllerIndex) then
        fastDrop(nil, player, ____exports.FastDropTarget.TRINKETS)
    end
    if (g.config.fastDropTrinketsController ~= -1) and Input.IsButtonPressed(g.config.fastDropTrinketsController, player.ControllerIndex) then
        fastDrop(nil, player, ____exports.FastDropTarget.TRINKETS)
    end
end
function checkInputPocket(self, player)
    if (g.config.fastDropPocketKeyboard ~= -1) and InputHelper.KeyboardPressed(g.config.fastDropPocketKeyboard, player.ControllerIndex) then
        fastDrop(nil, player, ____exports.FastDropTarget.POCKET)
    end
    if (g.config.fastDropPocketController ~= -1) and Input.IsButtonPressed(g.config.fastDropPocketController, player.ControllerIndex) then
        fastDrop(nil, player, ____exports.FastDropTarget.POCKET)
    end
end
function fastDrop(self, player, target)
    if not player:IsItemQueueEmpty() then
        return
    end
    if (target == ____exports.FastDropTarget.ALL) or (target == ____exports.FastDropTarget.TRINKETS) then
        local pos3 = g.r:FindFreePickupSpawnPosition(player.Position, 0, true)
        player:DropTrinket(pos3, false)
        local pos4 = g.r:FindFreePickupSpawnPosition(player.Position, 0, true)
        player:DropTrinket(pos4, false)
    end
    if (target == ____exports.FastDropTarget.ALL) or (target == ____exports.FastDropTarget.POCKET) then
        local pos1 = g.r:FindFreePickupSpawnPosition(player.Position, 0, true)
        player:DropPocketItem(0, pos1)
        local pos2 = g.r:FindFreePickupSpawnPosition(player.Position, 0, true)
        player:DropPocketItem(1, pos2)
    end
end
____exports.FastDropTarget = FastDropTarget or ({})
____exports.FastDropTarget.ALL = 0
____exports.FastDropTarget[____exports.FastDropTarget.ALL] = "ALL"
____exports.FastDropTarget.TRINKETS = 1
____exports.FastDropTarget[____exports.FastDropTarget.TRINKETS] = "TRINKETS"
____exports.FastDropTarget.POCKET = 2
____exports.FastDropTarget[____exports.FastDropTarget.POCKET] = "POCKET"
function ____exports.postUpdate(self)
    checkInput(nil)
end
return ____exports
end,
["callbacks.postUpdate"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local fastClearPostUpdates = require("features.fastClear.callbacks.postUpdate")
local fastDrop = require("features.fastDrop")
function ____exports.main(self)
    fastClearPostUpdates:main()
    fastDrop:postUpdate()
end
return ____exports
end,
["features.fastClear.callbacks.preEntitySpawnCollectible"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____globals = require("globals")
local g = ____globals.default
local ____enums = require("types.enums")
local PickupVariantCustom = ____enums.PickupVariantCustom
function ____exports.main(self, subType)
    if not g.config.fastClear then
        return nil
    end
    if g.run.fastClear.vanillaPhotosSpawning and ((subType == CollectibleType.COLLECTIBLE_POLAROID) or (subType == CollectibleType.COLLECTIBLE_NEGATIVE)) then
        local photoText = (CollectibleType.COLLECTIBLE_POLAROID and "Polaroid") or "Negative"
        local text = ("Preventing a vanilla " .. photoText) .. " from spawning."
        Isaac.DebugString(text)
        return {EntityType.ENTITY_PICKUP, PickupVariantCustom.INVISIBLE_PICKUP, 0, 0}
    end
    return nil
end
return ____exports
end,
["callbacks.preEntitySpawnPickupFunctions"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local fastClearPreEntitySpawnCollectible = require("features.fastClear.callbacks.preEntitySpawnCollectible")
local functionMap = __TS__New(Map)
____exports.default = functionMap
functionMap:set(
    PickupVariant.PICKUP_COLLECTIBLE,
    function(____, subType, _position, _spawner, _initSeed)
        local returnTable = fastClearPreEntitySpawnCollectible:main(subType)
        if returnTable ~= nil then
            return returnTable
        end
        return nil
    end
)
return ____exports
end,
["callbacks.preEntitySpawnFunctions"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____preEntitySpawnPickupFunctions = require("callbacks.preEntitySpawnPickupFunctions")
local preEntitySpawnPickupFunctions = ____preEntitySpawnPickupFunctions.default
local functionMap = __TS__New(Map)
____exports.default = functionMap
functionMap:set(
    EntityType.ENTITY_PICKUP,
    function(____, variant, subType, position, spawner, initSeed)
        local preEntitySpawnPickupFunction = preEntitySpawnPickupFunctions:get(variant)
        if preEntitySpawnPickupFunction ~= nil then
            return preEntitySpawnPickupFunction(nil, subType, position, spawner, initSeed)
        end
        return nil
    end
)
return ____exports
end,
["callbacks.preEntitySpawn"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____preEntitySpawnFunctions = require("callbacks.preEntitySpawnFunctions")
local preEntitySpawnFunctions = ____preEntitySpawnFunctions.default
function ____exports.main(self, entityType, variant, subType, position, _velocity, spawner, initSeed)
    local preEntityFunction = preEntitySpawnFunctions:get(entityType)
    if preEntityFunction ~= nil then
        return preEntityFunction(nil, variant, subType, position, spawner, initSeed)
    end
    return nil
end
return ____exports
end,
["callbacks.preGameExit"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local saveDat = require("saveDat")
function ____exports.main(self, shouldSave)
    if shouldSave then
        saveDat:save()
    end
end
return ____exports
end,
["modConfigMenu"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local config = require("config")
local ____configDescription = require("configDescription")
local ALL_DESCRIPTIONS = ____configDescription.ALL_DESCRIPTIONS
local CUSTOM_HOTKEYS = ____configDescription.CUSTOM_HOTKEYS
local GAMEPLAY_AND_QUALITY_OF_LIFE_CHANGES = ____configDescription.GAMEPLAY_AND_QUALITY_OF_LIFE_CHANGES
local MAJOR_CHANGES = ____configDescription.MAJOR_CHANGES
local ____globals = require("globals")
local g = ____globals.default
local CATEGORY_NAME, deleteOldConfig, validateConfigDescriptions, registerSubMenu, getDefaultValue, getDisplayText, onOff, getPopup, popup, popupGetDeviceString, popupGetKeepSettingString, getKeyName, popupGetBackKeyText, getPopupGfx, getPopupWidth
function deleteOldConfig(self)
    local categoryID = ModConfigMenu.GetCategoryIDByName(CATEGORY_NAME)
    if categoryID ~= nil then
        ModConfigMenu.MenuData[categoryID] = {Name = CATEGORY_NAME, Subcategories = {}}
    end
end
function validateConfigDescriptions(self)
    for ____, key in ipairs(
        __TS__ObjectKeys(g.config)
    ) do
        if not __TS__ArraySome(
            ALL_DESCRIPTIONS,
            function(____, array) return key == array[1] end
        ) then
            error(("Failed to find config key \"" .. key) .. "\" in the config descriptions.")
        end
    end
end
function registerSubMenu(self, subMenuName, descriptions)
    for ____, ____value in ipairs(descriptions) do
        local configName
        configName = ____value[1]
        local array
        array = ____value[2]
        local optionType, code, shortDescription, longDescription = table.unpack(array)
        ModConfigMenu.AddSetting(
            CATEGORY_NAME,
            subMenuName,
            {
                Type = optionType,
                CurrentSetting = function() return g.config[configName] end,
                Display = function() return getDisplayText(nil, configName, optionType, code, shortDescription) end,
                OnChange = function(newValue)
                    if newValue == nil then
                        newValue = getDefaultValue(nil, optionType)
                    end
                    config:set(configName, newValue)
                end,
                Popup = getPopup(nil, configName, optionType),
                PopupGfx = getPopupGfx(nil, optionType),
                PopupWidth = getPopupWidth(nil, optionType),
                Info = {longDescription}
            }
        )
    end
end
function getDefaultValue(self, optionType)
    local ____switch17 = optionType
    if ____switch17 == 4 then
        goto ____switch17_case_0
    elseif ____switch17 == 6 then
        goto ____switch17_case_1
    elseif ____switch17 == 7 then
        goto ____switch17_case_2
    end
    goto ____switch17_case_default
    ::____switch17_case_0::
    do
        do
            return true
        end
    end
    ::____switch17_case_1::
    do
    end
    ::____switch17_case_2::
    do
        do
            return -1
        end
    end
    ::____switch17_case_default::
    do
        do
            error(
                ("Option types of " .. tostring(optionType)) .. " are unsupported."
            )
            return false
        end
    end
    ::____switch17_end::
end
function getDisplayText(self, configName, optionType, code, shortDescription)
    local ____switch22 = optionType
    if ____switch22 == 4 then
        goto ____switch22_case_0
    elseif ____switch22 == 6 then
        goto ____switch22_case_1
    elseif ____switch22 == 7 then
        goto ____switch22_case_2
    end
    goto ____switch22_case_default
    ::____switch22_case_0::
    do
        do
            local currentValue = g.config[configName]
            return (((code .. " - ") .. shortDescription) .. ": ") .. onOff(nil, currentValue)
        end
    end
    ::____switch22_case_1::
    do
        do
            local currentValue = g.config[configName]
            local text
            if currentValue == -1 then
                text = "None"
            else
                local stringValue = InputHelper.KeyboardToString[currentValue]
                text = ((stringValue == nil) and "Unknown Key") or stringValue
            end
            return ((shortDescription .. ": ") .. text) .. " (keyboard)"
        end
    end
    ::____switch22_case_2::
    do
        do
            local currentValue = g.config[configName]
            local text
            if currentValue == -1 then
                text = "None"
            else
                local stringValue = InputHelper.ControllerToString[currentValue]
                text = ((stringValue == nil) and "Unknown Button") or stringValue
            end
            return ((shortDescription .. ": ") .. text) .. " (controller)"
        end
    end
    ::____switch22_case_default::
    do
        do
            error(
                ("Option types of " .. tostring(optionType)) .. " are unsupported."
            )
            return "Unknown"
        end
    end
    ::____switch22_end::
end
function onOff(self, setting)
    return (setting and "ON") or "OFF"
end
function getPopup(self, configName, optionType)
    return (((optionType == 6) or (optionType == 7)) and (function() return popup(nil, configName, optionType) end)) or nil
end
function popup(self, configName, optionType)
    local currentValue = g.config[configName]
    local deviceString = popupGetDeviceString(nil, optionType)
    local keepSettingString = popupGetKeepSettingString(nil, optionType, currentValue)
    local backKeyText = popupGetBackKeyText(nil)
    return ((((("Press a button on your " .. deviceString) .. " to change this setting.$newline$newline") .. keepSettingString) .. "Press \"") .. backKeyText) .. "\" to go back and clear this setting."
end
function popupGetDeviceString(self, optionType)
    local ____switch36 = optionType
    if ____switch36 == 6 then
        goto ____switch36_case_0
    elseif ____switch36 == 7 then
        goto ____switch36_case_1
    end
    goto ____switch36_case_default
    ::____switch36_case_0::
    do
        do
            return "keyboard"
        end
    end
    ::____switch36_case_1::
    do
        do
            return "controller"
        end
    end
    ::____switch36_case_default::
    do
        do
            error(
                ("Option types of " .. tostring(optionType)) .. " are unsupported."
            )
            return "unknown"
        end
    end
    ::____switch36_end::
end
function popupGetKeepSettingString(self, optionType, currentValue)
    if currentValue == -1 then
        return ""
    end
    local currentKeyName = getKeyName(nil, optionType, currentValue)
    return ("This setting is currently set to \"" .. tostring(currentKeyName)) .. "\".$newlinePress this button to keep it unchanged.$newline$newline"
end
function getKeyName(self, optionType, key)
    local ____switch43 = optionType
    if ____switch43 == 6 then
        goto ____switch43_case_0
    elseif ____switch43 == 7 then
        goto ____switch43_case_1
    end
    goto ____switch43_case_default
    ::____switch43_case_0::
    do
        do
            return InputHelper.KeyboardToString[key]
        end
    end
    ::____switch43_case_1::
    do
        do
            return InputHelper.ControllerToString[key]
        end
    end
    ::____switch43_case_default::
    do
        do
            error(
                ("Option types of " .. tostring(optionType)) .. " are unsupported."
            )
            return "unknown"
        end
    end
    ::____switch43_end::
end
function popupGetBackKeyText(self)
    local lastBackPressed = ModConfigMenu.Config.LastBackPressed
    local keyboardString = InputHelper.KeyboardToString[lastBackPressed]
    if keyboardString ~= nil then
        return keyboardString
    end
    local controllerString = InputHelper.ControllerToString[lastBackPressed]
    if controllerString ~= nil then
        return controllerString
    end
    return "back"
end
function getPopupGfx(self, optionType)
    return (((optionType == 6) or (optionType == 7)) and ModConfigMenu.PopupGfx.WIDE_SMALL) or nil
end
function getPopupWidth(self, optionType)
    return (((optionType == 6) or (optionType == 7)) and 280) or nil
end
CATEGORY_NAME = "Racing+"
function ____exports.register(self)
    if ModConfigMenu == nil then
        return
    end
    deleteOldConfig(nil)
    validateConfigDescriptions(nil)
    registerSubMenu(nil, "Major", MAJOR_CHANGES)
    registerSubMenu(nil, "Hotkeys", CUSTOM_HOTKEYS)
    registerSubMenu(nil, "Gameplay", GAMEPLAY_AND_QUALITY_OF_LIFE_CHANGES)
end
return ____exports
end,
["main"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local entityTakeDmg = require("callbacks.entityTakeDmg")
local executeCmd = require("callbacks.executeCmd")
local NPCUpdate = require("callbacks.NPCUpdate")
local postCurseEval = require("callbacks.postCurseEval")
local postEntityKill = require("callbacks.postEntityKill")
local postEntityRemove = require("callbacks.postEntityRemove")
local postGameStarted = require("callbacks.postGameStarted")
local postNewLevel = require("callbacks.postNewLevel")
local postNewRoom = require("callbacks.postNewRoom")
local postNPCInit = require("callbacks.postNPCInit")
local postRender = require("callbacks.postRender")
local postUpdate = require("callbacks.postUpdate")
local preEntitySpawn = require("callbacks.preEntitySpawn")
local preGameExit = require("callbacks.preGameExit")
local ____constants = require("constants")
local VERSION = ____constants.VERSION
local modConfigMenu = require("modConfigMenu")
local saveDat = require("saveDat")
local racingPlus = RegisterMod("Racing+", 1)
local modName = "Racing+"
local welcomeText = ((modName .. " ") .. VERSION) .. " initialized."
local hyphens = string.rep(
    "-",
    math.floor(#welcomeText)
)
local welcomeTextBorder = ("+-" .. hyphens) .. "-+"
Isaac.DebugString(welcomeTextBorder)
Isaac.DebugString(("| " .. welcomeText) .. " |")
Isaac.DebugString(welcomeTextBorder)
saveDat:setMod(racingPlus)
saveDat:load()
modConfigMenu:register()
racingPlus:AddCallback(ModCallbacks.MC_NPC_UPDATE, NPCUpdate.main)
racingPlus:AddCallback(ModCallbacks.MC_POST_UPDATE, postUpdate.main)
racingPlus:AddCallback(ModCallbacks.MC_POST_RENDER, postRender.main)
racingPlus:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, entityTakeDmg.main)
racingPlus:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, postCurseEval.main)
racingPlus:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, postGameStarted.main)
racingPlus:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, preGameExit.main)
racingPlus:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, postNewLevel.main)
racingPlus:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, postNewRoom.main)
racingPlus:AddCallback(ModCallbacks.MC_EXECUTE_CMD, executeCmd.main)
racingPlus:AddCallback(ModCallbacks.MC_PRE_ENTITY_SPAWN, preEntitySpawn.main)
racingPlus:AddCallback(ModCallbacks.MC_POST_NPC_INIT, postNPCInit.main)
racingPlus:AddCallback(ModCallbacks.MC_POST_ENTITY_REMOVE, postEntityRemove.main)
racingPlus:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, postEntityKill.main)
racingPlus:AddCallback(ModCallbacks.MC_NPC_UPDATE, NPCUpdate.ragling, EntityType.ENTITY_RAGLING)
racingPlus:AddCallback(ModCallbacks.MC_NPC_UPDATE, NPCUpdate.stoney, EntityType.ENTITY_STONEY)
return ____exports
end,
["features.fastClear.callbacks.postGameStarted"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____globals = require("globals")
local g = ____globals.default
local ____misc = require("misc")
local initRNG = ____misc.initRNG
local initVariables
function initVariables(self)
    local startSeed = g.seeds:GetStartSeed()
    g.run.fastClear.roomClearAwardSeed = startSeed
    local rng = initRNG(nil, startSeed)
    do
        local i = 0
        while i < 500 do
            rng:Next()
            i = i + 1
        end
    end
    g.run.fastClear.roomClearAwardSeedDevilAngel = rng:GetSeed()
end
function ____exports.postGameStarted(self)
    if not g.config.fastClear then
        return
    end
    initVariables(nil)
end
return ____exports
end,
["features.speedrun.enums"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
____exports.R7_SEASON_1_NAME = "R+7 (Season 1)"
____exports.CHANGE_CHAR_ORDER_NAME = "Change Char Order"
____exports.ChallengeCustom = ChallengeCustom or ({})
____exports.ChallengeCustom.R7_SEASON_1 = Isaac.GetChallengeIdByName(____exports.R7_SEASON_1_NAME)
____exports.ChallengeCustom[____exports.ChallengeCustom.R7_SEASON_1] = "R7_SEASON_1"
____exports.ChallengeCustom.CHANGE_CHAR_ORDER = Isaac.GetChallengeIdByName(____exports.CHANGE_CHAR_ORDER_NAME)
____exports.ChallengeCustom[____exports.ChallengeCustom.CHANGE_CHAR_ORDER] = "CHANGE_CHAR_ORDER"
return ____exports
end,
["features.speedrun.constants"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____enums = require("features.speedrun.enums")
local ChallengeCustom = ____enums.ChallengeCustom
____exports.CHALLENGE_DEFINITIONS = __TS__New(Map, {{ChallengeCustom.R7_SEASON_1, {"R7S1", 7}}})
return ____exports
end,
["features.speedrun.misc"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____constants = require("features.speedrun.constants")
local CHALLENGE_DEFINITIONS = ____constants.CHALLENGE_DEFINITIONS
function ____exports.inSpeedrun(self)
    local thisChallengeID = Isaac.GetChallenge()
    if thisChallengeID == 0 then
        return false
    end
    for ____, challengeDefinition in __TS__Iterator(CHALLENGE_DEFINITIONS) do
        local challengeID = challengeDefinition[1]
        if thisChallengeID == challengeID then
            return true
        end
    end
    return false
end
return ____exports
end,
["types.RevelCopyTable"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
end,
}
return require("main")
