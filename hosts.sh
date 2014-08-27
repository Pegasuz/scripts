#!/bin/bash


_hosts_usage() {
  cat <<EOF
Usage: $(basename $0) command
   edit   manage hosts file
   list   show all hosts
   grep   use grep to find entries
   add    add a new entry
EOF

  return 1
}

_hosts_action_edit() {
  sudo vim /etc/hosts

  return $?
}

_hosts_action_list() {
  cat /etc/hosts | awk '/^[^#]/{print $0}'

  return $?
}

_hosts_action_grep() {
  _hosts_action_list | grep -E "$1"

  return $?
}

_hosts_action_add() {
	echo $1 $2 | sudo tee -a /etc/hosts
	return $?
}


case ${1:-edit} in
  edit) _hosts_action_edit;;
  list) _hosts_action_list;;
  grep) _hosts_action_grep "$2";;
  add) _hosts_action_add "$2 $3";;
  *)    _hosts_usage;;
esac

exit $?
