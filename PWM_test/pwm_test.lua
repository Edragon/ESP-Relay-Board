print("PWM Function test")
pwm.setup(5,10000,1023); -- D1 pin, 10000hz, 1023 duty max
pwm.start(5);

pwm.setup(6,10000,1023); -- D1 pin, 10000hz, 1023 duty max
pwm.start(6);

local r=512;
local g=512;

local flag_r=1;
local flag_g=1;

tmr.alarm(1,10000,1, function()
    tmr.stop(2)
    tmr.stop(3)
    
    pwm.setduty(5, 1023);
    pwm.setduty(6, 1023);
    
    end)

tmr.alarm(2,20,1,function()
    pwm.setduty(5,r);
    if flag_r==1 then 
    r=r-20;   if r<0 then flag_r=0 r=0 end
    else
    r= r+50;    if r>1023 then flag_r=1 r=1023 end
end
end)

tmr.alarm(3,20,1,function()
    pwm.setduty(6,g);
    if flag_g==1 then 
    g=g-20;   if g<0 then flag_g=0 g=0 end
    else
    g= g+50;    if g>1023 then flag_g=1 g=1023 end
end
end)
