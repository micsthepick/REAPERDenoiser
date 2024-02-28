cat testing_defines.eel2 > REAPERDenoiser.test.eel2
sed -r -e 's/^(desc|slider[0-9]+|(in|out)_pin):.*|^@(init|slider|block|serialize|sample)//' \
    -e 's/\/\/DEBUGPRINT/printf/' \
    -e 's/\/\/IFTEST|\/\*IFTEST\{\*|\*\}IFTEST\*\///' \
    -e 's/\*IFNTEST\*|IFNTEST\{\*|\*\}IFNTEST//' \
    REAPERDenoiser >> REAPERDenoiser.test.eel2

# Initialize a flag to indicate stderr output
stderr_output=0

output=$(./WDL/WDL/eel2/loose_eel ./REAPERDenoiser.test.eel2 2>&1)

echo "$output"

# Get the last line of the output
last_line=$(echo "$output" | tail -n 1)

# Check if the last line starts with 'FAILURE'
if echo "$last_line" | grep -q "^FAILURE"; then
  echo "Failed Test Cases, will return -1!"
  exit -1
fi

##//DEBUGPRINT("HI");
##//IFTEST code_here();
##/*IFTEST{*
##  more_code();
##*}IFTEST*/
##/*IFNTEST*/called_when_not_testing();
##/*IFNTEST{*/
## also_called_when_not_testing();
##/*}IFNTEST*/

# will transform to

##printf("HI");
## code_here();
##
##  more_code();
## 
##//called_when_not_testing();
##/*IFNTEST{*/
## also_called_when_not_testing();
##/*IFNTEST}*/