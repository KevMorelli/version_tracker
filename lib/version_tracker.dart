library version_tracker;

import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provides an easy way to track versions and builds
class VersionTracker {
  final String _versionsKey = "VersionTracker.Versions";
  final String _buildsKey = "VersionTracker.Builds";

  /// Gets a value indicating whether this is the first time this app has ever been launched on this device.
  bool? get isFirstLaunchEver => _isFirstLaunchEver;
  bool? _isFirstLaunchEver;

  /// Gets a value indicating if this is the first launch of the app for the current version number.
  bool? get isFirstLaunchForCurrentVersion => _isFirstLaunchForCurrentVersion;
  bool? _isFirstLaunchForCurrentVersion;

  /// Gets a value indicating if this is the first launch of the app for the current build number.
  bool? get isFirstLaunchForCurrentBuild => _isFirstLaunchForCurrentBuild;
  bool? _isFirstLaunchForCurrentBuild;

  /// Gets the current version number of the app.
  String? get currentVersion => _currentVersion;
  String? _currentVersion;

  /// Gets the current build of the app.
  String? get currentBuild => _currentBuild;
  String? _currentBuild;

  /// Gets the version number for the previously run version.
  String? get previousVersion => _previousVersion;
  String? _previousVersion;

  /// Gets the build number for the previously run version.
  String? get previousBuild => _previousBuild;
  String? _previousBuild;

  /// Gets the version number of the first version of the app that was installed on this device.
  String? get firstInstalledVersion => _firstInstalledVersion;
  String? _firstInstalledVersion;

  /// Gets the build number of first version of the app that was installed on this device.
  String? get firstInstalledBuild => _firstInstalledBuild;
  String? _firstInstalledBuild;

  /// Gets the collection of version numbers of the app that ran on this device.
  List<String?>? get versionHistory => _versionHistory;
  List<String?>? _versionHistory;

  /// Gets the collection of build numbers of the app that ran on this device.
  List<String?>? get buildHistory => _buildHistory;
  List<String?>? _buildHistory;

  /// Determines if this is the first launch of the app for a specified version number.
  bool isFirstLaunchForVersion(String version) =>
      _currentVersion == version && _isFirstLaunchForCurrentVersion!;

  /// Determines if this is the first launch of the app for a specified build number.
  bool isFirstLaunchForBuild(String build) =>
      _currentBuild == build && _isFirstLaunchForCurrentBuild!;

  /// Start tracking versions and builds
  Future<void> track() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    Map<String, List<String?>> versionTrail = Map<String, List<String?>>();

    _isFirstLaunchEver = !sharedPreferences.containsKey(_versionsKey) ||
        !sharedPreferences.containsKey(_buildsKey);
    if (_isFirstLaunchEver!)
      versionTrail.addAll({_versionsKey: [], _buildsKey: []});
    else
      versionTrail.addAll({
        _versionsKey: _readHistory(sharedPreferences, _versionsKey).toList(),
        _buildsKey: _readHistory(sharedPreferences, _buildsKey).toList()
      });

    _currentVersion = packageInfo.version;
    _currentBuild = packageInfo.buildNumber;

    _isFirstLaunchForCurrentVersion =
        !versionTrail[_versionsKey]!.contains(_currentVersion);
    if (_isFirstLaunchForCurrentVersion!)
      versionTrail[_versionsKey]!.add(_currentVersion);

    _isFirstLaunchForCurrentBuild =
        !versionTrail[_buildsKey]!.contains(_currentBuild);
    if (_isFirstLaunchForCurrentBuild!)
      versionTrail[_buildsKey]!.add(_currentBuild);

    if (_isFirstLaunchForCurrentVersion! || _isFirstLaunchForCurrentBuild!) {
      _writeHistory(
          sharedPreferences, _versionsKey, versionTrail[_versionsKey]!);
      _writeHistory(sharedPreferences, _buildsKey, versionTrail[_buildsKey]!);
    }

    _previousVersion = _getPrevious(versionTrail, _versionsKey);
    _previousBuild = _getPrevious(versionTrail, _buildsKey);
    _firstInstalledVersion = versionTrail[_versionsKey]!.first;
    _firstInstalledBuild = versionTrail[_buildsKey]!.first;
    _versionHistory = versionTrail[_versionsKey]!.toList();
    _buildHistory = versionTrail[_buildsKey]!.toList();
  }

  /// Show all the available data in a formatted string
  @override
  String toString() {
    var sb = StringBuffer();
    sb.writeln('VersionTracker');
    sb.writeln();
    sb.writeln('IsFirstLaunchEver: $_isFirstLaunchEver');
    sb.writeln(
        'IsFirstLaunchForCurrentVersion: $_isFirstLaunchForCurrentVersion');
    sb.writeln('IsFirstLaunchForCurrentBuild: $_isFirstLaunchForCurrentBuild');
    sb.writeln();
    sb.writeln('CurrentVersion: $_currentVersion');
    sb.writeln('PreviousVersion: $_previousVersion');
    sb.writeln('FirstInstalledVersion: $_firstInstalledVersion');
    sb.writeln('VersionHistory: ${_versionHistory!.join(", ")}');
    sb.writeln();
    sb.writeln('CurrentBuild: $_currentBuild');
    sb.writeln('PreviousBuild: $_previousBuild');
    sb.writeln('FirstInstalledBuild: $_firstInstalledBuild');
    sb.writeln('BuildHistory: ${_buildHistory!.join(", ")}');
    return sb.toString();
  }

  List<String?> _readHistory(SharedPreferences preferences, String key) =>
      preferences.getString(key)!.split('|');

  void _writeHistory(
          SharedPreferences preferences, String key, List<String?> history) =>
      preferences.setString(key, history.join('|'));

  String? _getPrevious(Map<String, List<String?>> versionTrail, String key) {
    var trail = versionTrail[key]!;
    return (trail.length >= 2) ? trail[trail.length - 2] : null;
  }
}
