function process_eel_script {
  local input_script="$1"
  local output_script="$2"
  local replace_str="$3"  # New argument for the replacement

  # Process the second script and append its contents to the output script
  sed -r -e "s/\/\/IF${replace_str}|\/\*IF${replace_str}\{|\}IF${replace_str}\*\///" \
    "$input_script" > "$output_script"
}

process_eel_script REAPERDenoiser.jsfx-template REAPERDenoiser.test TEST
process_eel_script REAPERDenoiser.jsfx-template REAPERDenoiser.eel EEL
process_eel_script REAPERDenoiser.jsfx-template REAPERDenoiser.jsfx JSFX