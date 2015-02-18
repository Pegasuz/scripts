for VM in `VBoxManage list runningvms | awk '{ print $2; }'`; do VBoxManage controlvm $VM poweroff; done
