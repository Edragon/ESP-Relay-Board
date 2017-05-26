-- demo board: G-D8/, R-D5/14, B-D6/12, W-D7-IO13

-- pwm.setup, pwm.start, pwm.setduty
function setup_led()
    pwm.setup(5, 500, 200) --R
    pwm.setup(8, 500, 200) --G
    pwm.setup(6, 500, 200) --B
    
    pwm.setup(7, 500, 100) -- W
    
    
    pwm.start(5)
    pwm.start(8)
    pwm.start(6)
    
    pwm.start(7)
end

function set_led(r, g, b, w)
    pwm.setduty(5, g)
    pwm.setduty(8, r)
    pwm.setduty(6, b)
    
    pwm.setduty(7, w)
end


