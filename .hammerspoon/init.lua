local function keyCode(key, modifiers)
  modifiers = modifiers or {}
  return function()
    hs.eventtap.event.newKeyEvent(modifiers, key, true):post()
    hs.timer.usleep(1000)
    hs.eventtap.event.newKeyEvent(modifiers, key, false):post()      
  end
end

local function keyCodeSet(keys)
  return function()
    for i, keyEvent in ipairs(keys) do
      keyEvent()
    end
  end
end

local function remapKey(modifiers, key, keyCode)
  hs.hotkey.bind(modifiers, key, keyCode, nil, keyCode)
end


-- disable IME on escaping
remapKey({ 'ctrl' }, 'g',  keyCodeSet({
  keyCode('escape'),
  keyCode(102)
}))

-- Ctrl+M to return
remapKey({ 'ctrl' }, 'm',  keyCodeSet({
  keyCode('return')
}))
