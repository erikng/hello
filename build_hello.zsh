#!/bin/zsh
#
# Build script for Hello
# ./build_hello.zsh "CREATE_PKG"

# Variables
XCODE_PATH="/Applications/Xcode_13.1.app"
SIGNING_IDENTITY="Developer ID Installer: Clever DevOps Co. (9GQZ7KUFR6)"
MP_SHA="71c57fcfdf43692adcd41fa7305be08f66bae3e5"
MP_BINDIR="/tmp/munki-pkg"
CONSOLEUSER=$(/usr/bin/stat -f "%Su" /dev/console)
TOOLSFULLDIR=$(pwd)
TOOLSDIR=$(dirname $0)
BUILDSFULLDIR="$TOOLSFULLDIR/build"
BUILDSDIR="$TOOLSDIR/build"
OUTPUTSDIR="$TOOLSDIR/outputs"
MP_ZIP="/tmp/munki-pkg.zip"
XCODE_BUILD_PATH="$XCODE_PATH/Contents/Developer/usr/bin/xcodebuild"
XCODE_NOTARY_PATH="$XCODE_PATH/Contents/Developer/usr/bin/notarytool"
XCODE_STAPLER_PATH="$XCODE_PATH/Contents/Developer/usr/bin/stapler"
CURRENT_HELLO_MAIN_BUILD_VERSION=$(/usr/libexec/PlistBuddy -c Print:CFBundleVersion $TOOLSDIR/hello/Info.plist)
DATE=$(/bin/date -u "+%m%d%Y%H%M%S")

# automate the build version bump
AUTOMATED_HELLO_BUILD="$CURRENT_HELLO_MAIN_BUILD_VERSION.$DATE"
/usr/bin/xcrun agvtool new-version -all $AUTOMATED_HELLO_BUILD
/usr/bin/xcrun agvtool new-marketing-version $AUTOMATED_HELLO_BUILD

# Create files to use for build process info
echo "$AUTOMATED_HELLO_BUILD" > $TOOLSDIR/build_info.txt

# Ensure Xcode is set to run-time
sudo xcode-select -s "$XCODE_PATH"

# build hello
echo "Building hello"
if [ -e $XCODE_BUILD_PATH ]; then
  XCODE_BUILD="$XCODE_BUILD_PATH"
else
  ls -la /Applications
  echo "Could not find required Xcode build. Exiting..."
  exit 1
fi
$XCODE_BUILD -scheme "hello (Release)" -project "$TOOLSDIR/hello.xcodeproj" BUILD_DIR=${BUILDSFULLDIR} CODE_SIGN_IDENTITY=$CODE_SIGN_IDENTITY OTHER_CODE_SIGN_FLAGS="--timestamp"
XCB_RESULT="$?"
if [ "${XCB_RESULT}" != "0" ]; then
    echo "Error running xcodebuild: ${XCB_RESULT}" 1>&2
    exit 1
fi

if ! [ -n "$1" ]; then
  echo "Did not pass option to create package"
  exit 0
fi

# Create outputs folder
if [ -e $OUTPUTSDIR ]; then
  /bin/rm -rf $OUTPUTSDIR
fi
/bin/mkdir -p "$OUTPUTSDIR"

# move the app to the payload folder
echo "Moving hello.app to payload folder"
HELLO_PKG_PATH="$TOOLSDIR/helloPkg"
if [ -e $HELLO_PKG_PATH ]; then
  /bin/rm -rf $HELLO_PKG_PATH
fi
/bin/mkdir -p "$HELLO_PKG_PATH/payload/Applications/Utilities"
/usr/bin/sudo /usr/sbin/chown -R ${CONSOLEUSER}:wheel "$HELLO_PKG_PATH"
/bin/mv "/Users/runner/work/hello/hello/Build/Release/hello.app" "$HELLO_PKG_PATH/payload/Applications/Utilities/hello.app"

# Download specific version of munki-pkg
echo "Downloading munki-pkg tool from github..."
if [ -f "${MP_ZIP}" ]; then
    /usr/bin/sudo /bin/rm -rf ${MP_ZIP}
fi
/usr/bin/curl https://github.com/munki/munki-pkg/archive/${MP_SHA}.zip -L -o ${MP_ZIP}
if [ -d ${MP_BINDIR} ]; then
    /usr/bin/sudo /bin/rm -rf ${MP_BINDIR}
fi
/usr/bin/unzip ${MP_ZIP} -d ${MP_BINDIR}
DL_RESULT="$?"
if [ "${DL_RESULT}" != "0" ]; then
    echo "Error downloading munki-pkg tool: ${DL_RESULT}" 1>&2
    exit 1
fi

# Create the json file for signed munkipkg hello pkg
/bin/cat << SIGNED_JSONFILE > "$HELLO_PKG_PATH/build-info.json"
{
  "ownership": "recommended",
  "suppress_bundle_relocation": true,
  "identifier": "com.github.erikng.hello",
  "postinstall_action": "none",
  "distribution_style": true,
  "version": "$AUTOMATED_HELLO_BUILD",
  "name": "hello-$AUTOMATED_HELLO_BUILD.pkg",
  "install_location": "/",
  "signing_info": {
    "identity": "$SIGNING_IDENTITY",
    "timestamp": true
  }
}
SIGNED_JSONFILE

/bin/cat << JSONFILE > "$HELLO_PKG_PATH/build-info.json"
{
  "ownership": "recommended",
  "suppress_bundle_relocation": true,
  "identifier": "com.github.erikng.hello",
  "postinstall_action": "none",
  "distribution_style": true,
  "version": "$AUTOMATED_HELLO_BUILD",
  "name": "hello-$AUTOMATED_HELLO_BUILD.pkg",
  "install_location": "/"
}
JSONFILE

# Create the signed pkg
"${MP_BINDIR}/munki-pkg-${MP_SHA}/munkipkg" "$HELLO_PKG_PATH"
PKG_RESULT="$?"
if [ "${PKG_RESULT}" != "0" ]; then
  echo "Could not sign package: ${PKG_RESULT}" 1>&2
else
  # Move the signed pkg
  /bin/mv "$HELLO_PKG_PATH/build/hello-$AUTOMATED_HELLO_BUILD.pkg" "$OUTPUTSDIR"
fi
