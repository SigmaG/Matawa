--MTW : chat geyser additions

function Geyser.MiniConsole:clear()
 clearWindow(self.name)
end

function Geyser.MiniConsole:append()
 appendBuffer(self.name)
end
