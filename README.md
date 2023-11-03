[![Pub Version](https://img.shields.io/pub/v/version_tracker)](https://pub.dev/packages/version_tracker)
[![GitHub](https://img.shields.io/github/license/KevMorelli/version_tracker)](https://github.com/KevMorelli/version_tracker/blob/main/LICENSE)
[![likes](https://img.shields.io/pub/likes/version_tracker)](https://pub.dev/packages/version_tracker/score)
[![pub points](https://img.shields.io/pub/points/version_tracker)](https://pub.dev/packages/version_tracker/score) 

# VersionTracker

Local version and build tracker plugin. Provides the ability to keep track of previous installations and easily migrate data between upgrades.

## Usage

Call this on the main function

```dart
var vt = VersionTracker();
await vt.track();
```

You can also set the max number for version and build history by giving a value to ``buildHistoryMaxLength`` and ``versionHistoryMaxLength`` in the track function.

```dart
var vt = VersionTracker();
await vt.track(buildHistoryMaxLength: 10, versionHistoryMaxLength: 10);
```

Then call these whenever you want (in these examples the user has launched a bunch of previous versions, and this is the first time he's launched the new version 1.0.11):

```dart
vt.isFirstLaunchEver;        // false
vt.isFirstLaunchForVersion;  // true
vt.isFirstLaunchForBuild;    // true

vt.currentVersion;           // 1.0.11
vt.previousVersion;          // 1.0.10
vt.firstInstalledVersion;    // 1.0.0
vt.versionHistory;           // [ 1.0.0, 1.0.1, 1.0.2, 1.0.3, 1.0.10, 1.0.11 ]

vt.currentBuild;             // 18
vt.previousBuild;            // 15
vt.firstInstalledBuild;      // 1
vt.buildHistory;             // [ 1, 2, 3, 4, 5, 8, 9, 10, 11, 13, 15, 18 ]
 ```
