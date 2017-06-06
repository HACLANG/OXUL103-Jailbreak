OXUL103/getsymbols_armv7.sh
7d3115d  on 6 of June 2017
@ZOMBIEFTW
1 contributor
RawBlameHistory    
Executable File  26 lines (19 sloc)  785 Bytes
##!/bin/sh

ddi="$(find /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/DeviceSupport 2>/dev/null | grep "10.3/.*.dmg$" || echo './data/DeveloperDiskImage.dmg' | head -1)"

### Ddi mount function ###

function mount_ddi(){
echo "Mounting DDI..."
./bin/ideviceimagemounter "$ddi" >/dev/null || echo "Couldn't mount DDI. Not an issue if Xcode's running, an issue if it isn't."
}

function getsymbols_armv7()
{
./bin/fetchsymbols -f "$(./bin/fetchsymbols -l 2>&1 | (grep arm64 ) | tr ':' '\n'|tr -d ' '|head -1)" ./tmp/cache64
  # ./bin/fetchsymbols -f "$(./bin/fetchsymbols -l 2>&1 | (grep armv7) | tr ':' '\n'|tr -d ' '|head -1)" ./tmp/cache
}

function make_run()
{
  cd ./data/dyldmagic
  ./make-run.sh
  cd ../../
}

mount_ddi && make_run&&fetchsymbols_armv7
