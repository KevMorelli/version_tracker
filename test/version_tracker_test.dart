import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:version_tracker/version_tracker.dart';

void main() {
  group('version_tracker Tests', () {
    TestWidgetsFlutterBinding.ensureInitialized();

    PackageInfo.setMockInitialValues(
      appName: 'version_tracker_example',
      packageName: 'io.flutter.plugins.packageinfoexample',
      version: '1.1',
      buildNumber: '2',
      buildSignature: 'Mock',
      installerStore: 'Mock',
    );
    SharedPreferences.setMockInitialValues(
        {'VersionTracker.Versions': '1.0|1.1', 'VersionTracker.Builds': '1|2'});

    final VersionTracker versionTracker = VersionTracker();

    setUp(() async {
      await versionTracker.track();
    });

    test('Test first launch ever', () {
      final isFirstLaunchEver = versionTracker.isFirstLaunchEver;
      expect(isFirstLaunchEver, false);
    });

    test('Test isFirstLaunchForCurrentVersion', () {
      final isFirstLaunchForCurrentVersion =
          versionTracker.isFirstLaunchForCurrentVersion;
      expect(isFirstLaunchForCurrentVersion, false);
    });

    test('Test isFirstLaunchForCurrentBuild', () {
      final isFirstLaunchForCurrentBuild =
          versionTracker.isFirstLaunchForCurrentBuild;
      expect(isFirstLaunchForCurrentBuild, false);
    });

    test('Test isFirstLaunchForVersion', () {
      final isFirstLaunchForVersion =
          versionTracker.isFirstLaunchForVersion('1.0');
      expect(isFirstLaunchForVersion, false);
    });

    test("Test isFirstLaunchForBuild", () {
      final isFirstLaunchForBuild = versionTracker.isFirstLaunchForBuild('1.0');
      expect(isFirstLaunchForBuild, false);
    });

    test('Test currentVersion', () {
      var currentVersion = versionTracker.currentVersion;
      expect(currentVersion, "1.1");
    });

    test('Test previousVersion', () {
      var previousVersion = versionTracker.previousVersion;
      expect(previousVersion, "1.0");
    });

    test('Test firstInstalledVersion', () {
      var firstInstalledVersion = versionTracker.firstInstalledVersion;
      expect(firstInstalledVersion, "1.0");
    });

    test('Test versionHistory', () {
      var versionHistory = versionTracker.versionHistory;
      expect(versionHistory, ["1.0", "1.1"]);
    });

    test('Test currentBuild', () {
      var currentBuild = versionTracker.currentBuild;
      expect(currentBuild, "2");
    });

    test('Test previousBuild', () {
      var previousBuild = versionTracker.previousBuild;
      expect(previousBuild, "1");
    });

    test('Test firstInstalledBuild', () {
      var firstInstalledBuild = versionTracker.firstInstalledBuild;
      expect(firstInstalledBuild, "1");
    });

    test('Test buildHistory', () {
      var buildHistory = versionTracker.buildHistory;
      expect(buildHistory, ["1", "2"]);
    });
  });
}
