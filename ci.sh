#!/bin/bash

capitalize_first_letter() {
  echo "$1" | awk '{ $1=toupper(substr($1,1,1)) substr($1,2); print }'
}

commit_types=("feat" "refactor" "fix" "chore" "style" "test" "docs" "localize" "init")

type=$(printf '%s\n' "${commit_types[@]}" | fzf)

if [ $? -ne 0 ]; then
  echo "Commit aborted."
  exit 1
fi

current_branch=$(git branch --show-current)

ticket_number=$(echo "$current_branch" | grep -oE '([A-Z]+-[0-9]+)')

if [ -z "$*" ]; then
  read -p "Enter commit message: " commit_message
else
  commit_message="$*"
fi

if [ -z "$ticket_number" ]; then
  commit_message="$type: $(capitalize_first_letter "$commit_message")"
else
  commit_message="$type: [$ticket_number] $(capitalize_first_letter "$commit_message")"
fi

if [[ -n "$type" ]]; then
  git commit -m "$commit_message"
else
  echo "Invalid selection. Commit aborted."
fi
