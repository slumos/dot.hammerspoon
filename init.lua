# Oh yay, Hammerspoon moved to Lua 5.4 before Homebrew packaged it? So do this now to use the ASDF Lua.
-- package.path = "/Users/slumos/.asdf/installs/lua/5.4.0/share/lua/5.4/?.lua;/Users/slumos/.asdf/installs/lua/5.4.0/share/lua/5.4/?/init.lua;/Users/slumos/.asdf/installs/lua/5.4.0/luarocks/share/lua/5.4/?.lua;/Users/slumos/.asdf/installs/lua/5.4.0/luarocks/share/lua/5.4/?/init.lua;"..package.path
-- package.cpath = "/Users/slumos/.asdf/installs/lua/5.4.0/lib/lua/5.4/?.so;/Users/slumos/.asdf/installs/lua/5.4.0/luarocks/lib/lua/5.4/?.so;"..package.cpath

package.path = "/Users/slumos/.local/share/mise/installs/lua/5.4.6/share/lua/5.4/?.lua;/Users/slumos/.local/share/mise/installs/lua/5.4.6/share/lua/5.4/?/init.lua;/Users/slumos/.local/share/mise/installs/lua/5.4.6/luarocks/share/lua/5.4/?.lua;/Users/slumos/.local/share/mise/installs/lua/5.4.6/luarocks/share/lua/5.4/?/init.lua;"..package.path
package.cpath = "/Users/slumos/.local/share/mise/installs/lua/5.4.6/lib/lua/5.4/?.so;/Users/slumos/.local/share/mise/installs/lua/5.4.6/luarocks/lib/lua/5.4/?.so;"..package.cpath

local fennel = require "fennel"
table.insert(package.loaders or package.searchers, fennel.searcher)
fennel.dofile("init.fnl", {allowedGlobals = false})
