STB_SRC := 3rdparty/stb
CSTB_SRC := Sources/CSTB

lint:
	swiftlint autocorrect --format
	swiftlint lint --quiet

lintErrorOnly:
	@swiftlint lint --quiet | grep error

genLinuxTests:
	swift test --generate-linuxmain
	swiftlint autocorrect --format --path Tests/

test: genLinuxTests
	swift test

submodule:
	git submodule update --init --recursive

updateCSTB:
	cp $(STB_SRC)/*.h $(CSTB_SRC)/include

clean:
	swift package reset
	rm -rdf .swiftpm/xcode
	rm -rdf .build/
	rm Package.resolved
	rm .DS_Store

cleanArtifacts:
	swift package clean

latest:
	swift package update

resolve:
	swift package resolve

genXcode:
	swift package generate-xcodeproj --enable-code-coverage --skip-extra-files 

genXcodeOpen: genXcode
	open *.xcodeproj

precommit: lint genLinuxTests

testReadme:
	markdown-link-check -p -v ./README.md
