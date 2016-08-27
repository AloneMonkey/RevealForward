# RevealForward
不在一个局域网下使用Reveal查看界面结构

(not in the same local area network uses Reveal)

# Usage

### Install deb

```
dpkg -i com.monkey.RevealForward_1.0-1_iphoneos-arm.deb
```

### Run App

open `Xcode-Window-Devices` look device output

![image](http://7xtdl4.com1.z0.glb.clouddn.com/script_1472273449939.png)

### Run On Terminal

```
dns-sd -P Reveal--08bd954e _reveal._tcp local 64770 IP IP  "devLocalModel=iPhone" "devSysVer=8.3" "isSim=false" "devName=“monkey”的 iPhone" "protoVer=25" "deviceID=79241DFF-XXXX-XXXX-BAC8-5B4C80070303" "appName=App Store" "appBundleId=com.apple.AppStore" "devSysName=iPhone OS"
```

### Open Reveal

![image](http://7xtdl4.com1.z0.glb.clouddn.com/script_1472273703209.png)

### Enjoy it


