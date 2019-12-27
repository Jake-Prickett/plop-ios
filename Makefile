.PHONY : log setup xcodeproj lint reset_simulators help

SHELL = /bin/bash

log:help

## install             : Local setup/install for fresh clones
install:
	brew install xcodegen
	brew install swiftlint
	brew install carthage

## setup             : Local setup for Software Engineers (Quits xcode, removes existing project, creates new project & workspace, opens workspace)
setup:
	osascript -e 'tell application "Xcode" to quit'
	rm -rf PLOP.xc*
	$(MAKE) xcodeproj
	open PLOP.xcodeproj/

## xcodeproj         : Generate xcodeproj
xcodeproj:
	xcodegen

## lint              : Executes Swiftlint and outputs any warnings/errors in readable format
lint:
	swiftlint lint --reporter emoji --config .swiftlint.yml

## reset_simulators  : Resets simulators for CI (if needed)
reset_simulators:
	osascript -e 'tell application "iOS Simulator" to quit'
	osascript -e 'tell application "Simulator" to quit'
	xcrun simctl erase all

help: Makefile
	sed -n "s/^##//p" $<