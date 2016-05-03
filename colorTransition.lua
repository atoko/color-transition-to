-- Color transition wrapper
-- Author: atoko
-- Release date: 5/9/2012
-- Version: 1.0.0
-- 
--
--
--Description:
--      This is a wrapper for changing fill color within a transition
--  Time, delay and easing values are optional
--
--Usage:
-- cTrans = require( "colortransition" );
-- 
-- cTrans:colorTransition(displayObject, colorFrom, colorTo, [time], [delay], [easing]);
-- ex:
--  
--  local rect = display.newRect(0,0,250,250);
--  local white = {255,255,255}     
--  local red = {255,0,0};
--      
--  cTrans:colorTransition(rect, white, red, 1200);
 
 
 
 
 
local _M = {}
 
--Local reference to transition function
_M.callback = transition.to;
 
 
function _M:colorTransition(obj, colorFrom, colorTo, time, delay, ease)
        
        local _obj =  obj; 
        local ease = ease or easing.linear
        
        
        local fcolor = colorFrom or {255,255,255}; -- defaults to white
        local tcolor = colorTo or {0,0,0}; -- defaults to black
        local t = nil;
        local p = {} --hold parameters here
        local rDiff = tcolor[1] - fcolor[1]; --Calculate difference between values
        local gDiff = tcolor[2] - fcolor[2];
        local bDiff = tcolor[3] - fcolor[3];
        
                --Set up proxy
        local proxy = {step = 0};
        
        local mt = {
                __index = function(t,k)
                        --print("get");
                        return t["step"] 
                end,
                
                __newindex = function (t,k,v)
                        --print("set") 
                        --print(t,k,v)
                        if(_obj.setFillColor) then
                                _obj:setFillColor(fcolor[1] + (v*rDiff) ,fcolor[2] + (v*gDiff) ,fcolor[3] + (v*bDiff) ) 
                        end
                        t["step"] = v;
                        
                        
                end
                
        }
        
        p.time = time or 1000; --defaults to 1 second
        p.delay = delay or 0;
        p.transition = ease;
        
 
        setmetatable(proxy,mt);
        
        p.colorScale = 1;
        
        t = self.callback(proxy,p , 1 ) ;
 
        return t
 
end
 
 
 
 
return _M; 