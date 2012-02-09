--[[
 * view_manager.lua
 * Matthew Wallace
 * version 0.1.0
 * 
 * Class for managing views in coronasdk
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
This class is intended for you to push display object to it in order
to transition between views in  your Corona SDK application
--]]

local ViewManager = {}

function ViewManager:new()
	local group = display.newGroup()
	local current_view
	local new_view

	-- effects --
	local fadeIn
	local fadeOut
	local defaultEffect
	local effectFunction

	--[[
		runs after the first transition in order to finish 
		the effect by running the second transition
	--]]
	local function onTransComplete()
		display.remove(current_view)
		current_view = nil
		current_view = new_view
		group:insert(current_view)
		effectFunction(current_view)
	end

	defaultEffect = function(view)
		--TODO // not sure what the defaultEffect will be
	end

	--fade
	fadeOut = function(view)
		transition.to(current_view, {alpha=0, time=500, 
					onComplete=onTransComplete})
	end

	fadeIn = function(view)
		transition.to(view, {time=500, alpha=1})
	end

	function group.showView(view, effect)
		new_view = view
		
		if effect ~= nil then
			if effect == "fade" then
				effectFunction = fadeIn
				view.alpha = 0
			else
				effectFunction = defaultEffect
			end
		else
			effectFunction = defaultEffect
		end

		if effect ~= nil and current_view ~= nil then
			if effect == "fade" then
				fadeOut(current_view)
			else
				onTransComplete()
			end
		else
			onTransComplete()
		end
	end

	return group
end

return ViewManager