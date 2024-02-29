# ensure latest testing script is available
./process_scripts.sh

function run_test {
  local test_script="$1"
  local test_output

  echo "TESTING $1"

  # Ensure latest testing script is available
  ./process_scripts.sh

  # Add defines to head of test script
  cat testing_defines.eel2 "$test_script" > "${test_script}.eel2"

  # Run the test and capture output
  test_output=$(./WDL/WDL/eel2/loose_eel "./${test_script}.eel2" 2>&1)
  echo "$test_output"

  # Get the last line of the output and check for failure
  if echo "$test_output" | tail -n 1 | grep -q "^FAILURE"; then
    echo "Failed Test Cases, will return -1!"
    exit -1
  fi
}

# Run tests for each script
run_test REAPERDenoiser.test
