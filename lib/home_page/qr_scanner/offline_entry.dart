// // ignore_for_file: library_private_types_in_public_api

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:sammilani_delegate/model/offline_prasad.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class OfflineEntryWidget extends StatefulWidget {
//   final String offlinePrasadKey;
//   final VoidCallback onPressedUpload;
//   final VoidCallback onPressedAddOfflineCounter;

//  const OfflineEntryWidget({super.key, 
//     required this.offlinePrasadKey,
//     required this.onPressedUpload,
//     required this.onPressedAddOfflineCounter,
//   });

//   @override
//   _OfflineEntryWidgetState createState() => _OfflineEntryWidgetState();
// }

// class _OfflineEntryWidgetState extends State<OfflineEntryWidget> {
//   final GlobalKey<FormState> _offlinePrasadFormKey = GlobalKey<FormState>();
//   final TextEditingController devoteeInfoController = TextEditingController();
//   int _offlineCounter = 0;


//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: const Color.fromARGB(255, 250, 233, 233),
//       elevation: 10,
//       shadowColor: const Color.fromARGB(255, 250, 233, 233),
//       child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   "Offline Entry",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: widget.onPressedUpload,
//                   icon: const Icon(
//                     Icons.upload,
//                     color: Colors.deepOrange,
//                   ),
//                 ),
//               ],
//             ),
//             Form(
//               key: _offlinePrasadFormKey,
//               child: SizedBox(
//                 width: MediaQuery.of(context).size.width,
//                 child: TextFormField(
//                   controller: devoteeInfoController,
//                   // Implement other properties as needed
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Container(
//               height: 60,
//               width: 300,
//               child: ElevatedButton(
//                 onPressed: () {
//                   if (_offlinePrasadFormKey.currentState?.validate() == true) {
//                     //todo save data in a list
//                     String date = DateFormat("yyyy-MM-dd").format(DateTime.now()),
//                         time = DateFormat("HH:mm").format(DateTime.now());
//                     OfflinePrasad prasads = OfflinePrasad(
//                       devoteeCodes: convertStringToList(devoteeInfoController.text),
//                       date: date,
//                       time: time,
//                     );
//                     await saveToPrefs(
//                       widget.offlinePrasadKey,3
//                       prasads,
//                     );
//                     devoteeInfoController.clear();
//                   }
//                 },
//                 child: const Text(
//                   'Submit',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Text("OR"),
//             const SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Container(
//                   height: 60,
//                   width: 200,
//                   child: ElevatedButton(
//                     onPressed: widget.onPressedAddOfflineCounter,
//                     child: const Text(
//                       'Add Offline Counter',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Text(
//                   "$_offlineCounter",
//                   style: const TextStyle(fontSize: 40),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
