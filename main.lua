--[[
 * main.lua
 * Matthew Wallace
 * version 0.1.0
 * 
 * example application for using view_manager.lua
 * 
 * Copyright (c) 2012 Matthew Wallace )
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 * 
 --]]

--[[ 
The following example is showing how to use the view_manager class
--]]

display.setStatusBar(display.HiddenStatusBar)

--first requier view_manager like so
local ViewManager = require("com.mattwallace.helpers.view_manager")

-- Then create a global variable so that you can keep using the same instance
-- throughout your application
view_manager = ViewManager:new()


--[[
	main() kicks everything off by creating a group and placing a rect 
	in the group. we then hand the group to the view manager showView function.

	Next we run a timer and then create another view and call showView on the new group.
	The view manager then replaces the old view with the new view

	If you remove the "fade" argument then the default effect will be implemented, witch as
	of right now is no effect at all will be applied and the views will just be 
	swapped out.
--]]
local function main()
	local group1 = display.newGroup()
	local rec1 = display.newRect(200,200,200, 200)
	rec1:setFillColor(255,255,255)
	group1:insert(rec1)

	view_manager.showView(group1, "fade")

	local function onDelay()
		local group2 = display.newGroup()
		local rec2 = display.newRect(100,200,200, 200)
		rec2:setFillColor(255,0,255)
		group2:insert(rec2)
		
		view_manager.showView(group2, "fade")
	end

	timer.performWithDelay(5000, onDelay, 1)
end

main()