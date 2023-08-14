case $@ in
"Brave Browser")
  icon_result=":brave_browser:"
  ;;
"Final Cut Pro")
  icon_result=":final_cut_pro:"
  ;;
"FaceTime")
  icon_result=":face_time:"
  ;;
"Messages" | "Nachrichten")
  icon_result=":messages:"
  ;;
"Thunderbird")
  icon_result=":thunderbird:"
  ;;
"Notes")
  icon_result=":notes:"
  ;;
"Microsoft To Do" | "Things")
  icon_result=":things:"
  ;;
"GitHub Desktop")
  icon_result=":git_hub:"
  ;;
"App Store")
  icon_result=":app_store:"
  ;;
"Chromium" | "Google Chrome" | "Google Chrome Canary")
  icon_result=":google_chrome:"
  ;;
"zoom.us")
  icon_result=":zoom:"
  ;;
"Microsoft Word")
  icon_result=":microsoft_word:"
  ;;
"Microsoft Teams")
  icon_result=":microsoft_teams:"
  ;;
"Neovide" | "MacVim" | "Vim" | "VimR")
  icon_result=":vim:"
  ;;
"Notability")
  icon_result=":notability:"
  ;;
"WhatsApp")
  icon_result=":whats_app:"
  ;;
"Parallels Desktop")
  icon_result=":parallels:"
  ;;
"Microsoft Excel")
  icon_result=":microsoft_excel:"
  ;;
"Microsoft PowerPoint")
  icon_result=":microsoft_power_point:"
  ;;
"Numbers")
  icon_result=":numbers:"
  ;;
"Default")
  icon_result=":default:"
  ;;
"Firefox Developer Edition" | "Firefox Nightly")
  icon_result=":firefox_developer_edition:"
  ;;
"Trello")
  icon_result=":trello:"
  ;;
"Notion")
  icon_result=":notion:"
  ;;
"Calendar" | "Fantastical" | "Cron")
  icon_result=":calendar:"
  ;;
"Xcode")
  icon_result=":xcode:"
  ;;
"Slack")
  icon_result=":slack:"
  ;;
"System Preferences" | "System Settings")
  icon_result=":gear:"
  ;;
"Discord" | "Discord Canary" | "Discord PTB")
  icon_result=":discord:"
  ;;
"Firefox")
  icon_result=":firefox:"
  ;;
"Skype")
  icon_result=":skype:"
  ;;
"Dropbox")
  icon_result=":dropbox:"
  ;;
"Canary Mail" | "HEY" | "Mail" | "Mailspring" | "MailMate" | "邮件" | "Outlook" | "Mimestream")
  icon_result=":mail:"
  ;;
"Safari" | "Safari Technology Preview")
  icon_result=":safari:"
  ;;
"Telegram")
  icon_result=":telegram:"
  ;;
"Keynote")
  icon_result=":keynote:"
  ;;
"Spotify")
  icon_result=":spotify:"
  ;;
"Figma")
  icon_result=":figma:"
  ;;
"Spotlight")
  icon_result=":spotlight:"
  ;;
"Music")
  icon_result=":music:"
  ;;
"Alfred")
  icon_result=":alfred:"
  ;;
"Pages")
  icon_result=":pages:"
  ;;
"IntelliJ IDEA")
  icon_result=":idea:"
  ;;
"Obsidian")
  icon_result=":obsidian:"
  ;;
"Reminders")
  icon_result=":reminders:"
  ;;
"Preview" | "Skim" | "zathura")
  icon_result=":pdf:"
  ;;
"1Password 7")
  icon_result=":one_password:"
  ;;
"Code" | "Code - Insiders")
  icon_result=":code:"
  ;;
"VSCodium")
  icon_result=":vscodium:"
  ;;
"Finder" | "访达")
  icon_result=":finder:"
  ;;
"Linear")
  icon_result=":linear:"
  ;;
"Signal")
  icon_result=":signal:"
  ;;
"Podcasts")
  icon_result=":podcasts:"
  ;;
"Alacritty" | "Hyper" | "iTerm2" | "kitty" | "Terminal" | "WezTerm")
  icon_result=":terminal:"
  ;;
*)
  icon_result=":default:"
  ;;
esac
echo $icon_result
