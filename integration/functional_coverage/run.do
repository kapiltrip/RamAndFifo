# Keep the self-checking testbench's $finish inside the simulation and return
# control here so the coverage report is still printed afterward.
onfinish stop;
run -all;
coverage report -cvg -details;
quit -f;
