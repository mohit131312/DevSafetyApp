// import 'package:flutter/material.dart';
// import 'package:flutter_app/features/work_permit_all/work_permit_maker/work_permit_date/work_Permit_date_controller.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// class WorkPermitDateScreen extends GetxController {
//   final WorkPermitDateController workPermitDateController =
//       Get.put(WorkPermitDateController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Select Date & Time")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Select Duration",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             GestureDetector(
//               onTap: () => workPermitDateController.selectDateRange(context),
//               child: Obx(() => Container(
//                     padding: EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(DateFormat('MMM dd, yyyy')
//                             .format(controller.startDate.value)),
//                         Text(" to "),
//                         Text(DateFormat('MMM dd, yyyy')
//                             .format(controller.endDate.value)),
//                       ],
//                     ),
//                   )),
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Start Time"),
//                     GestureDetector(
//                       onTap: () => controller.selectTime(context, true),
//                       child: Obx(() => Text(
//                             "${controller.startTime.value.format(context)}",
//                             style: TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold),
//                           )),
//                     )
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("End Time"),
//                     GestureDetector(
//                       onTap: () => controller.selectTime(context, false),
//                       child: Obx(() => Text(
//                             "${controller.endTime.value.format(context)}",
//                             style: TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold),
//                           )),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 TextButton(
//                   onPressed: () => Get.back(),
//                   child: Text("Cancel"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: Text("Set"),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
