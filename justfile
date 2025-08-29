# save krew plugin list
save-krew:
  kubectl krew list | tee packages/krew.txt

# load krew plugins
[confirm("Note that this will not uninstall any currently installed krew plugins (y/N):")]
load-krew:
  kubectl krew install < packages/krew.txt
