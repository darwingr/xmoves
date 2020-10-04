# -*- mode: ruby -*-
# vi: set ft=ruby :

tap "adoptopenjdk/openjdk"

# Required by flutter for managing ios projects & libraries from cli.
# Install via homebrew to skip ruby dependency and/or avoid sudo install.
#brew "cocoapods"

# Guidance:
#   https://dev.to/0xdonut/how-to-install-flutter-on-macos-using-homebrew-and-asdf-3loa

## Flutter SDK / Dart Runtime & package manager
# exact same url folder downloaded as on the "Get Flutter SDK" official page
#   auto-updates
cask "flutter"
# OR flutter install by channel, not version, update via cli yourself
#tap "flschweiger/homebrew-flutter"
#brew "flutter"
# OR asdf to manage installs for dart, flutter & ruby, just like rbenv/pyenv.
#brew 'asdf'
# OR use the dedicated homebrew tap for dart.

cask "adoptopenjdk8"    # Java required for android-sdk
cask "android-sdk"      # for command line util `sdkmanager`, dependency checks
cask "android-ndk"      # for native android code code
cask "android-studio"   # to build flutter app for Android

brew "gradle" # included internally to other tools, not accessible in PATH

cask "intel-haxm"       # for faster flutter emulation & rendering


# Other resources:
#  https://medium.com/enappd/install-flutter-on-windows-and-mac-1fd1dde453ba
#  https://medium.com/enappd/install-flutter-on-windows-and-mac-1fd1dde453ba
