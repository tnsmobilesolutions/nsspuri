// import 'package:flutter/material.dart';
// import 'package:sammilani_delegate/model/devotte_model.dart';
// import 'package:sammilani_delegate/screen/edit_devotee.dart';

// // ignore: must_be_immutable
// class DelegateCard extends StatelessWidget {
//   DelegateCard({super.key, required this.devoteeData});
//   Map<String, dynamic> devoteeData;

//   @override
//   Widget build(BuildContext context) {
//     final devotees = devoteeData["data"];
//     if (devotees.isEmpty) {
//       return const Center(child: Text("No data"));
//     }
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: SizedBox(
//           height: MediaQuery.of(context).size.height / 1.5,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(25),
//                     topRight: Radius.circular(25),
//                     bottomLeft: Radius.circular(25),
//                     bottomRight: Radius.circular(25)),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.2),
//                     spreadRadius: 3,
//                     blurRadius: 5,
//                     offset: const Offset(0, 3), // changes position of shadow
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Card(
//                   elevation: 1,
//                   shape: RoundedRectangleBorder(
//                     side: const BorderSide(
//                       width: 1,
//                       color: Color.fromARGB(255, 217, 217, 217),
//                     ),
//                     borderRadius: BorderRadius.circular(30), //<-- SEE HERE
//                   ),
//                   color: const Color.fromARGB(255, 240, 240, 240),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       ListView.builder(
//                         itemCount: devotees.length,
//                         shrinkWrap: true,
//                         itemBuilder: (BuildContext context, int index) {
//                           DevoteeModel devoteedata =
//                               DevoteeModel.fromMap(devotees[index]);
//                           // DevoteeModel singledevotee =
//                           //     DevoteeModel.fromMap(devotees[index]);
//                           return SingleChildScrollView(
//                             child: Padding(
//                               padding: const EdgeInsets.all(0.0),
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   Container(
//                                     decoration: const BoxDecoration(
//                                       color: Colors.blue,
//                                       borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(30.0),
//                                         topRight: Radius.circular(30.0),
//                                       ),
//                                     ),
//                                     width: 400,
//                                     height: 80,

//                                     // Background color of the container
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(4),
//                                       child: Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         children: [
//                                           const SizedBox(
//                                             width: 2,
//                                           ),
//                                           Image.asset(
//                                             'assets/images/nsslogo.png',
//                                             scale: 25,
//                                           ),
//                                           SizedBox(
//                                             height: 10,
//                                             width: 5,
//                                           ),
//                                           // Replace with your image path

//                                           const Padding(
//                                             padding: EdgeInsets.all(1),
//                                             child: Column(
//                                               children: [
//                                                 Text(
//                                                   'JAYAGURU',
//                                                   style: TextStyle(
//                                                     fontSize: 14,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors
//                                                         .white, // Text color
//                                                   ),
//                                                 ),
//                                                 SizedBox(
//                                                   height: 3,
//                                                 ),
//                                                 Text(
//                                                   'Nilachala Saraswat Sangha, Puri',
//                                                   style: TextStyle(
//                                                     fontSize: 12,
//                                                     color: Colors
//                                                         .white, // Text color
//                                                   ),
//                                                 ),
//                                                 SizedBox(
//                                                   height: 6,
//                                                 ),
//                                                 Text(
//                                                   '73RD UTKAL PRADESHIKA SAMMILANI',
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 14,
//                                                     color: Colors
//                                                         .white, // Text color
//                                                   ),
//                                                 ),
//                                                 SizedBox(
//                                                   height: 6,
//                                                 ),
//                                                 Text(
//                                                   'Pune-2023',
//                                                   style: TextStyle(
//                                                     fontSize: 12,
//                                                     color: Colors
//                                                         .white, // Text color
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       SizedBox(
//                                         width: 50,
//                                       ),
//                                       const Text(
//                                         'IDENTITY CARD',
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 18),
//                                       ),
//                                       IconButton(
//                                           onPressed: () {
//                                             Navigator.push(context,
//                                                 MaterialPageRoute(
//                                               builder: (context) {
//                                                 return EditDevoteeDetailsPage(
//                                                     title: "edit",
//                                                     devotee: devoteedata);
//                                               },
//                                             ));
//                                           },
//                                           icon: const Icon(
//                                             Icons.edit,
//                                             color: Colors.deepOrange,
//                                           )),
//                                     ],
//                                   ),
//                                   Center(
//                                     child: Container(
//                                       height: 150,
//                                       width: 120,
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                           color:
//                                               Color.fromARGB(255, 92, 32, 183),
//                                           width: 1,
//                                         ),
//                                         shape: BoxShape
//                                             .rectangle, // This makes the container circular
//                                         image: DecorationImage(
//                                           fit: BoxFit.cover,
//                                           image: NetworkImage(devoteedata
//                                               .profilePhotoUrl
//                                               .toString()),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       devoteedata.name != null
//                                           ? Text(
//                                               "${devoteedata.name}",
//                                               style: const TextStyle(
//                                                   color: Colors.deepOrange,
//                                                   fontSize: 32,
//                                                   fontWeight: FontWeight.bold),
//                                             )
//                                           : const Text(
//                                               "Name : Please Update your Name"),
//                                     ],
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       devoteedata.sangha != null
//                                           ? Text(
//                                               "${devoteedata.sangha}",
//                                               style: const TextStyle(
//                                                   fontSize: 18,
//                                                   fontWeight: FontWeight.bold),
//                                             )
//                                           : const Text(
//                                               "Name : Please Update your Sangha"),
//                                     ],
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(12),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         const SizedBox(
//                                           height: 10,
//                                         ),

//                                         const SizedBox(
//                                           height: 10,
//                                         ),
//                                         devoteedata.mobileNumber != null
//                                             ? Text(
//                                                 "Mobile     :    ${devoteedata.mobileNumber}",
//                                                 style: const TextStyle(
//                                                     fontSize: 20,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               )
//                                             : const Text(
//                                                 "Mobile : Please Update your Mobile Number"),
//                                         const SizedBox(
//                                           height: 10,
//                                         ),
//                                         devoteedata.gender != null
//                                             ? Text(
//                                                 "Gender    :    ${devoteedata.gender}",
//                                                 style: const TextStyle(
//                                                     fontSize: 20,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               )
//                                             : const Text(
//                                                 "Gender : Please Update your Gender"),
//                                         const SizedBox(
//                                           height: 10,
//                                         ),
//                                         devoteedata.dob != null
//                                             ? Text(
//                                                 "DOB         :    ${devoteedata.dob}",
//                                                 style: const TextStyle(
//                                                     fontSize: 20,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               )
//                                             : const Text(
//                                                 "DOB : Please Update your Date of birth"),
//                                         const SizedBox(
//                                           height: 10,
//                                         ),
//                                         // devoteedata.bloodGroup != null
//                                         //     ? Text(
//                                         //         "Blood Gr :    ${devoteedata.bloodGroup}",
//                                         //         style: const TextStyle(
//                                         //             fontSize: 18,
//                                         //             fontWeight:
//                                         //                 FontWeight.w300),
//                                         //       )
//                                         //     : const Text(
//                                         //         "Bloodgroup : Please Update your Bloodgroup"),
//                                       ],
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 10,
//                                   )
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
