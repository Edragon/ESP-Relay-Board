dofile("pwm_ctrl.lua")

uart.setup(0, 115200, 8, uart.PARITY_NONE, uart.STOPBITS_1, 1)

setup_led()

set_led(100, 100, 100, 100) -- R G B W
