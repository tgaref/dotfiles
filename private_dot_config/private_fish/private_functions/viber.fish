function viber --wraps='flatpak run com.viber.Viber' --description 'alias viber=flatpak run com.viber.Viber'
  flatpak run com.viber.Viber $argv
end
