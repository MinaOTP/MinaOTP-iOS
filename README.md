# MinaOTP-iOS
[![](https://img.shields.io/badge/platform-osx-red.svg)](https://github.com/MinaOTP/MinaOTP-iOS)    [![](https://img.shields.io/github/release/MinaOTP/MinaOTP-iOS.svg)](https://github.com/MinaOTP/MinaOTP-iOS/releases)    [![](https://img.shields.io/github/license/mashape/apistatus.svg)](https://github.com/MinaOTP/MinaOTP-iOS)   
MinaOTP-iOS is a two-factor authentication tray app that runs at iOS. It's based on [RFC6238](https://tools.ietf.org/html/rfc6238), and the algorithm was implement by `Objective-C`

The program will generate secure dynamic 2FA tokens for you, and the `add`, `edit`, `remove`,`import`, `export` are pretty convenient.

## Requirements
- iOS 9.0+
- Xcode 9.4.1+
- Swift 4.1

### Software Screenshot
Home
![screenshot](http://pdj9v67h5.bkt.clouddn.com/A4488CB48308D4C23B99BD15116D6F96.png)
Manual entry
![screenshot](http://pdj9v67h5.bkt.clouddn.com/C39507E017FFA5C919FF2584C0BEA483.png)
Scan a qr code to add a new token
![screenshot](http://pdj9v67h5.bkt.clouddn.com/503D85D02783D663D9BBE5F18931B85F.png)
Delete
![screenshot](http://pdj9v67h5.bkt.clouddn.com/29D72AD0393B3A37179D6485066506AD.jpg)
Edit
![screenshot](http://pdj9v67h5.bkt.clouddn.com/AD677022AC4320DBF256267EC8D16961.png)
Export
![screenshot](http://pdj9v67h5.bkt.clouddn.com/0D6CEFFBF22E76FC7B929B2FBA96E440.png)
Import Tokens from json text
![screenshot](http://pdj9v67h5.bkt.clouddn.com/1853716E59D5AC30799CA5C98A306159.png)

### Feature

* Generate the 2FA token
* Scan a qr code to add a new token
* Add a new token mannually
* Edit the issuer and remark info
* Remove a existed token
* Backup datas to json text
* Import datas from json text

### Todo
* [ ] sync to icloud
