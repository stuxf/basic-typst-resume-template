root := justfile_directory()

export TYPST_ROOT := root

[private]
default:
	@just --list --unsorted

# run visual regression tests with Tytanic 0.4.1
test *args:
	tt run --warnings promote --no-fail-fast {{ args }}

# compile the packaged template with the installed Typst, rejecting warnings
check:
	./scripts/check

# update visual references after reviewing intentional layout changes
update *args:
	tt update --warnings promote --no-fail-fast {{ args }}

# package the library into the specified destination folder
package target:
  ./scripts/package "{{target}}"

# tag the committed release and submit it to Typst Universe using local Git/gh login
publish *args:
  ./scripts/publish {{args}}

# install the library with the "@local" prefix
install: (package "@local")

# install the library with the "@preview" prefix (for pre-release testing)
install-preview: (package "@preview")

[private]
remove target:
  ./scripts/uninstall "{{target}}"

# uninstalls the library from the "@local" prefix
uninstall: (remove "@local")

# uninstalls the library from the "@preview" prefix (for pre-release testing)
uninstall-preview: (remove "@preview")

# run visual regression and packaged template compatibility checks
ci: test check
