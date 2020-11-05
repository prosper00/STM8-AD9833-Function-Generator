#!/bin/bash
openocd -f interface/stlink-dap.cfg -f target/stm8s103.cfg  &
BGPID=$!
trap 'kill $BGPID' EXIT
#openocd -f interface/stlink-dap.cfg -f target/stm8s103.cfg -c "init" -c "reset halt" &
stm8-gdb dist/STM8-AD9833-Function-Generator.elf --eval-command "target extended-remote localhost:3333" --eval-command "break main" --tui
