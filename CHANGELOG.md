## 3.1.0
- Widen the `package_info_plus` constraint to `>=9.0.0 <11.0.0` so the package can be
  used alongside `package_info_plus` 10.x. Version 10 only bumps `win32` from 5 to 6 and
  changes no Dart API that this package uses (`PackageInfo.fromPlatform`), so both major
  versions are supported.
- No change to the supported SDK range: apps on older SDKs continue to resolve
  `package_info_plus` 9.x, while apps meeting version 10's own floors (Dart 3.11, Flutter
  3.41.6) can resolve 10.x.

## 3.0.0
- Update dependencies and SDK version
- Fix warnings
- Fix issue [#5](https://github.com/KevMorelli/version_tracker/issues/5)

## 2.4.1
- Format code

## 2.4.0
- Update dependencies and SDK version

## 2.3.0
- Update dependencies and SDK version

## 2.2.0
- Flutter 3 support
- Updated the example app
- Test fixes

## 2.1.1
- Allow the max number of versions and builds to be optional

## 2.1.0
- Add the ability to set the max number of versions and builds to remember

## 2.0.0
- Migrate to null safety

## 1.0.1
- Update readme

## 1.0.0
- Plugin
- Example