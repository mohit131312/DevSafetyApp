import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatePickerController extends GetxController {
  var selectedDate = Rxn<DateTime>(); // Correct way to allow null values
  final TextEditingController dateController = TextEditingController();

  void updateDate(DateTime newDate) {
    selectedDate.value = newDate; // Now `selectedDate` can hold null or a date
    dateController.text =
        "${newDate.day}/${newDate.month}/${newDate.year}"; // Format date
  }

// // Initialize Controller
//   final DatePickerController datePickerController =
//       Get.put(DatePickerController());

//   void showDatePicker(BuildContext context) {
//     showCupertinoModalPopup(
//       context: context,
//       builder: (_) => Container(
//         height: 300,
//         color: Colors.white,
//         child: Column(
//           children: [
//             SizedBox(
//               height: 200,
//               child: CupertinoDatePicker(
//                 mode: CupertinoDatePickerMode.date,
//                 initialDateTime:
//                     datePickerController.selectedDate.value ?? DateTime.now(),
//                 onDateTimeChanged: (DateTime newDate) {
//                   datePickerController.updateDate(newDate);
//                 },
//               ),
//             ),
//             CupertinoButton(
//               child: Text("Done"),
//               onPressed: () => Navigator.of(context).pop(),
//             )
//           ],
//         ),
//       ),
//     );
//   }
}
