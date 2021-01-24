# Want to decouple how it's installed from it's location,
# how flutter is installed from where it is installed
# thus use FLUTTER_ROOT instead to refer to the src dir after.
flutter_git_src_dir=/usr/local/src/flutter
FLUTTER_ROOT=$(flutter_git_src_dir)

flutter=$(FLUTTER_ROOT)/bin/flutter
flutter_path_shim:=/etc/paths.d/flutter-bin
flutter_bash_completion=/usr/local/etc/bash_completion.d/flutter
flutter_version_file=$(FLUTTER_ROOT)/version

all:
	echo $(flutter_version_file)
	echo $(FLUTTER_ROOT)

# Setup the project
setup: flutter_install flutter_setup pubspec.lock

# Configure system flutter, Post-Install
flutter_setup: \
		$(flutter) \
		Brewfile.lock.json \
		$(flutter_path_shim) \
		$(flutter_bash_completion)
	$(flutter) config --no-analytics
	$(flutter) doctor -v
	$(flutter) config --flutter-root

# Installing Flutter
#   Version file only needs to exist when installing.
flutter_install: $(flutter_version_file)

update_cocoapods:
	gem install cocoapods --user-install

studio_config:

.PHONY: all setup flutter_setup flutter_install studio_config update_cocoapods

# Executable binary exists
#   Depend on this for any recipe calling flutter.
#   Don't re-clone if the dir already exists though.
$(flutter): | $(flutter_git_src_dir)


pubspec.lock : pubspec.yaml $(flutter_setup) $(flutter)
	$(flutter) pub get


# Install other tools for flutter development
Brewfile.lock.json : Brewfile
	brew bundle


# Access flutter via PATH
$(flutter_path_shim) : | $(flutter)
	echo "$(FLUTTER_ROOT)/bin" \
		| sudo tee $@ > /dev/null
	# Rebuild current shell path
	@echo "To use flutter either Reload shell or run:"
	@echo "	path+=($(FLUTTER_ROOT)/bin"


# Reinstall whenever flutter is upgraded
$(flutter_bash_completion) : $(flutter_version_file) $(flutter)
	$(flutter) bash-completion \
		| sudo tee $@ > /dev/null


# Marks flutter version change,
#   separate timestamp from git.
$(flutter_version_file): $(FLUTTER_ROOT) $(flutter)
	$(flutter) precache



### HOW IT's INSTALLED

# Shallow clone on the stable release branch,
#   should be tagged the latest with the release version number.
#
#   To Track change on git repo as a whole use:
#     .git/ORIG_HEAD
$(flutter_git_src_dir): | /usr/local/src
	git clone \
		-b stable \
		--depth 1 \
		https://github.com/flutter/flutter.git $@

/usr/local/src:
	mkdir -p $@
