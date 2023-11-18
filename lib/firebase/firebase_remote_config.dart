import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info/package_info.dart';

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
  bool updateRequiredByVersionnumber = false;
  bool get getupdateRequiredByVersionnumber {
    return updateRequiredByVersionnumber;
  }

  set setupdateRequiredByVersionnumber(bool versionCheck) {
    updateRequiredByVersionnumber = versionCheck;
  }

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

  String accountInfo = "";
  String get getAccountInfo {
    return accountInfo;
  }

  set setAccountInfo(String acctInfo) {
    accountInfo = acctInfo;
  }

  String helpContactNo = "";
  String get gethelpContactNo {
    return helpContactNo;
  }

  set sethelpContactNo(String contactNo) {
    helpContactNo = contactNo;
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

    RemoteConfigHelper().setAccountInfo = remoteConfig.getString('accountInfo');

    RemoteConfigHelper().sethelpContactNo =
        remoteConfig.getString('helpContactNo');

    RemoteConfigHelper().setVersionNumber =
        remoteConfig.getString('versionNumber');
    String remoteVersion = remoteConfig.getString('versionNumber');
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appVersion = packageInfo.version;
    print('Version: $appVersion, remoteVersion: $remoteVersion');
    if (appVersion == remoteVersion) {
      RemoteConfigHelper().setupdateRequiredByVersionnumber = false;
    } else if (appVersion.compareTo(remoteVersion) < 0) {
      RemoteConfigHelper().setupdateRequiredByVersionnumber = true;
    } else {
      RemoteConfigHelper().setupdateRequiredByVersionnumber = false;
    }
  } catch (e) {
    print('remote config error : $e');
  }
}
