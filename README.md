# ghettoVCB

### Description

This is a fork from William Lam's famous [ghettoVCB](https://github.com/lamw/ghettoVCB) script to backup and restore ESXi from the command line. I restructed the project and added a simple bash script to build the VIB without the need of the deprecated VIB Author. As a side effect the vib does not require the force flag during install/update.

### Requirements

The build script is implemented for the *bash* shell and therefore requires any linux. It is tested to run on Ubuntu 16/18 and QNAP Entware.

### Installation, Running

Clone the repo to a linux system.
Additionally you need the ar command to create the vib archive. This can be installed with the binutils packages.
e.g.
```
apt install binutils
```

Then run the script which will return you the command to deploy the new vib for convenience

```
cd ghettoVCB
./create-vib.sh
FINISHED

you could deploy the new vib by running:
scp dist/ghettoVCB-1.0.0.vib root@vmserver-1:/tmp/
ssh root@vmserver-1 "esxcli software vib remove -f -n ghettoVCB"
ssh root@vmserver-1 "esxcli software vib install -f -v /tmp/ghettoVCB-1.0.0.vib"
```

All module parameters are stored in the descriptor.xml.tmpl. Additional some parameters are stored in vib.env

### Additional Documentation & Resources

- [ghettoVCB Documentation](http://communities.vmware.com/docs/DOC-8760)
- [ghettoVCB VMTN Group](http://communities.vmware.com/groups/ghettovcb)
- [ghettoVCB Restore Documentation](http://communities.vmware.com/docs/DOC-10595)


### Licensing

The MIT License (MIT)

Copyright (c) 2015 www.virtuallyghetto.com

Copyright (c) 2019 www.ecm4u.de

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
