all:

setup: flutter_install pubspec.lock

flutter_install: Brewfile.lock.json $(flutter_path_shim)
	flutter precache
	flutter doctor -v
	flutter --flutter-root

.PHONY: all setup flutter_setup flutter_install



pubspec.lock : pubspec.yaml
	flutter pub get

Brewfile.lock.json : Brewfile
	brew bundle
	flutter config --no-analytics

# flutter must be installed first
flutter_path_shim="/etc/paths.d/flutter-bin"
$(flutter_path_shim) : flutter_install
	#rebuild current shell path
	echo -n "$(FLUTTER_ROOT)/bin" > $@

