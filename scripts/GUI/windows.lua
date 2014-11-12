-- MTW GUI : handle new windows. We want more flexibility than Geyser (!) so this is the custom class for them.
-- It is advised to have a look at a lua manual before touching this...

function mtw.gui.new(
 Gtype, --the kind of Geyser window, like Geyser.Container, Geyser.HBox, Geyser.Label...
 cons, --the constraints, in a special format: either as a string that represents a constraints table '[[{x = 0, y = 42, width = blah, height = foo, ...}]]' or a function that will return such a table '[[function() return {x=42, y=whatever} end]]'
       -- we want to store something that has not been interpreted, for later reuse
 enabled, --check whether it's enabled or not on creation.
 container) -- the window containing this one WHEN IT IS ENABLED (this is the container we'll reattach the window to, when enabled)

 local t = {} -- this is the table we'll return at the end, it represents the window and all its info

 if type(cons) == "string" then
  local r
  local f,e = loadstring("return "..cons)
  if not f then
   f,_ = assert(loadstring(cons))
   if not f then
    t.cons = {}
   else
    t.cons = cons
   end
  else
   t.cons = "return "..cons
  end
 elseif type(cons) == "table" then
  t.cons = cons
 else
  t.cons = {}
 end
 -- what've done here, is to rewrite the cons so that its interpretation can be easily done later

 t.enabled = enabled
 t.cnt = container
 if enabled then
  t.win = Gtype:new(mtw.gui.parse_constraints(t.cons), container.win)
  t.win:show(true)
  table.insert(t.cnt.children, t)
 else
  t.win = Gtype:new(mtw.gui.parse_constraints(t.cons), mtw.gui.disabled)
 end

 t.children = {}

 function t:enable()
  if not self.enabled then
   self.cnt:add(self)
   mtw.gui.disabled:remove(self.win)
   self.enabled = true
  end
 end

 function t:disable()
  if self.enabled then
   for k,v in pairs(self.cnt.children) do
    if v == self then
     table.remove(self.cnt.children, k)
     break
    end
   end
   self.cnt:remove(self)
   mtw.gui.disabled:add(self.win, mtw.gui.parse_constraints(t.cons))
   if self.cnt == mtw.gui.root then
    mtw.gui.root:r()
   end
   local parent_empty = true
   for _,_ in pairs(self.cnt.children) do
    parent_empty = false
    break
   end
   if parent_empty then
    self.cnt:disable()
   end
   self.enabled = false
  end
 end

 function t:add(window)
  table.insert(self.children,window)
  self.win:add(window.win, mtw.gui.parse_constraints(window.cons))
  self:enable()
  self:resize_children()
 end

 function t:remove(window)
  self.win:remove(window.win)
  self:resize_children()
 end

 function t:reload()
  if self.cnt.type ~= "hbox" and self.cnt.type ~= "VBox" then
   self.win:set_constraints(mtw.gui.parse_constraints(self.cons))
   if self.type == "miniConsole" then -- we need to fix wrapping there
    self.win:setWrap(math.floor(self.win:getWidth()/self.win.fontSize))
   end
  end
  self:resize_children()
 end

 function t:resize_children(window)
  for _,v in pairs(self.children) do
   v:reload()
  end
 end

 function t:hide()
  self.win:hide(true)
 end

 function t:show()
  self.win:show(true)
 end

 setmetatable(t, {__index = function (tab,k)
  return tab.win[k]
 end})
 --the metatable magic :) here we want to be able to use the standard geyser functions without having to fetch the geyser component

 return t
end
