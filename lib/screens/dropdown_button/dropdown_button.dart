// import 'package:flutter/material.dart';

// class DropdownButtonWidge extends StatefulWidget {
//   const DropdownButtonWidge({Key? key}) : super(key: key);
//   @override
//   State<DropdownButtonWidge> createState() => _DropdownButtonWidgeState();
// }

// class _DropdownButtonWidgeState extends State<DropdownButtonWidge> {
//   String dropdownValue = '';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Colors.white,
//         child: DropdownButton<String>(
//           icon: Icon(
//             Icons.sort_rounded,
//             size: 25,
//           ),
//           underline: Container(),
//           elevation: 0,
//           borderRadius: BorderRadius.circular(20),
//           style: const TextStyle(
//             color: Colors.black,
//           ),

//           value: dropdownValue,

//           items: <String>['', 'All', 'Today', 'Yesterday', 'Week', 'Month']
//               .map<DropdownMenuItem<String>>(
//             (String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     value,
//                     style: const TextStyle(fontSize: 18),
//                   ),
//                 ),
//               );
//             },
//           ).toList(),
//           // Step 5.
//           onChanged: (String? newValue) {
//             setState(
//               () {
//                 dropdownValue = newValue!;
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
