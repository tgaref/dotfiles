function brave --wraps='flatpak run com.brave.Browser' --description 'alias brave=flatpak run com.brave.Browser'
  flatpak run com.brave.Browser $argv
end
