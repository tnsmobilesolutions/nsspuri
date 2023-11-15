import 'package:firebase_remote_config/firebase_remote_config.dart';

// class FirebaseRemoteConfigService {
//   FirebaseRemoteConfigService._()
//       : _remoteConfig = FirebaseRemoteConfig.instance; // MODIFIED

//   static FirebaseRemoteConfigService? _instance; // NEW
//   factory FirebaseRemoteConfigService() =>
//       _instance ??= FirebaseRemoteConfigService._(); // NEW

//   final FirebaseRemoteConfig _remoteConfig;
//   String getUpdateMessage(String mandatoryUpgradeText) =>
//       _remoteConfig.getString(mandatoryUpgradeText);
//   String getVersionNumber(String versionNumber) =>
//       _remoteConfig.getString(versionNumber);
//   bool getshouldShowMandatoryUpgradePrompt(
//           String shouldShowMandatoryUpgradePrompt) =>
//       _remoteConfig.getBool(shouldShowMandatoryUpgradePrompt);
//       String get welcomeMessage => _remoteConfig.getString(FirebaseRemoteConfigKeys.welcomeMessage);
// }

class RemoteConfigHelper {
  static final RemoteConfigHelper _networkHelper =
      RemoteConfigHelper._internal();
  //
  bool shouldShowMandatoryUpgradePrompt = false;
  bool get getShowMandatoryUpgradePrompt {
    return shouldShowMandatoryUpgradePrompt;
  }

  set setUpgradePrompt(bool upgradePrompt) {
    shouldShowMandatoryUpgradePrompt = upgradePrompt;
  }

  //
  String mandatoryUpgradeText = "";
  String get getMandatoryUpgradeText {
    return mandatoryUpgradeText;
  }

  set setUpgradeText(String upgradeText) {
    mandatoryUpgradeText = upgradeText;
  }

  //
  String versionNumber = "";
  String get getVersionNumber {
    return versionNumber;
  }

  set setVersionNumber(String versionNumberr) {
    versionNumber = versionNumberr;
  }

  factory RemoteConfigHelper() {
    return _networkHelper;
  }
  RemoteConfigHelper._internal();
}

fetchRemoteConfigData() async {
  FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  try {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(hours: 24), // Cache refresh time
      minimumFetchInterval: Duration.zero,
    ));
    await remoteConfig.fetchAndActivate();
    RemoteConfigHelper().setUpgradePrompt =
        remoteConfig.getBool('shouldShowMandatoryUpgradePrompt');
    RemoteConfigHelper().setUpgradeText =
        remoteConfig.getString('mandatoryUpgradeText');
    RemoteConfigHelper().setVersionNumber =
        remoteConfig.getString('versionNumber');
  } catch (e) {
    print('remote config error : $e');
  }
}
