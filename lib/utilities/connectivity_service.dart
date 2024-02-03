// import 'dart:async';
// import 'package:internet_connection_checker/internet_connection_checker.dart';

// class ConnectivityService {
//   final InternetConnectionChecker _internetConnectionChecker =
//       InternetConnectionChecker();

//   bool _isConnected = false;

//   bool get isConnected => _isConnected;

//   Future<void> checkConnectivity() async {
//     _isConnected = await _internetConnectionChecker.hasConnection;
//   }

//   StreamSubscription<InternetConnectionStatus> subscribeToConnectivityChanges(
//     void Function(InternetConnectionStatus) onStatusChange,
//   ) {
//     return _internetConnectionChecker.onStatusChange.listen(onStatusChange);
//   }

//   void cancelConnectivitySubscription(
//     StreamSubscription<InternetConnectionStatus> subscription,
//   ) {
//     subscription.cancel();
//   }
// }
