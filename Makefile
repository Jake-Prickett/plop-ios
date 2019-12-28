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

## test              : Execute Tests
test:
	xcodebuild -scheme PLOP -project ./PLOP.xcodeproj -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 11,OS=13.1' build test

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