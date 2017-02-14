# search google from terminal

function google() {
  emulate -L zsh

  # define search engine URLS
  google_search_url="https://www.google.com/search?q="
  google_home_url="https://www.google.com/"

  # search or go to main page depending on number of arguments passed
  if [[ $# -gt 0 ]]; then
    # build search url:
    # join arguments passed with '+', then append to search engine URL
    url="${google_search_url}${(j:+:)@[1,-1]}"
  else
    # go to google home page:
    url="${google_home_url}"
  fi

  "/c/Program Files (x86)/Google/Chrome/Application/chrome.exe" "$url"
}


