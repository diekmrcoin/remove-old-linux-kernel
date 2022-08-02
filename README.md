# remove-old-linux-kernel
Bash script that removes old linux kernels

- `sudo cp src/main.sh /usr/bin/remove-old-kernels`
- `sudo chmod +x /usr/bin/remove-old-kernels`
- `sudo remove-old-kernels`
  - See the `/boot` usage percentage
  - Enter the number of kernels you want to leave installed
  - Decide to proceed or not with the `apt purge` of the output displayed
  - See the new `/boot` usage percentage
  - Decide to proceed or not with the `apt autoremove` to clean the kernel headers left installed
  - Done
