alias l='ls -al'
alias gst='git status'
alias gac='git commit -a -m'

function update-repo --description 'Update a single APT repository'
   for source in $argv
      sudo apt-get update -o Dir::Etc::sourcelist="sources.list.d/$source" \
         -o Dir::Etc::sourceparts="-" -o APT::Get::List-Cleanup="0"
   end
end
