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
   rx='([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])'
   ip="$1"
   if ! [[ "$ip" =~ ^$rx\.$rx\.$rx\.$rx$ ]]; then
      echo "$ip is not a valid ip adress"
      return $?
   fi
   echo $@ | sudo tee -a /etc/hosts
        return $?
}


case "$1" in
  edit) _hosts_action_edit;;
  list) _hosts_action_list;;
  grep) _hosts_action_grep "$2";;
  add) shift; _hosts_action_add "$@";;
  *)    _hosts_usage;;
esac

exit $?
