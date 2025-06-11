import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';

import '../features/contractor/add_contractor/add_contractor_controller.dart';

class MatchUserContractor extends StatelessWidget {
  const MatchUserContractor({super.key});

  @override
  Widget build(BuildContext context) {
    final addcontractorController = Get.find<AddContractorController>();

    return AlertDialog(
      alignment: Alignment.center,
      backgroundColor: Colors.white,
      content: Container(
        decoration: BoxDecoration(color: Colors.white),
        width: double.maxFinite,
        height: SizeConfig.heightMultiplier * 38,
        child: ListView.builder(
          itemCount: addcontractorController.searchResults.length,
          itemBuilder: (context, index) {
            var contractor = addcontractorController.searchResults[index];
            return GestureDetector(
              onTap: () async {
                String selectedId = contractor['contractor_id'].toString();

                var selectedContractor =
                    addcontractorController.searchResults.firstWhere(
                  (contractor) =>
                      contractor['contractor_id'].toString() == selectedId,
                  orElse: () => {},
                );

                if (selectedContractor.isNotEmpty) {
                  addcontractorController.selectedContractorDetails.value =
                      selectedContractor;
                }
                log('--------selectedContractorDetails----------------${addcontractorController.selectedContractorDetails}');
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                height: SizeConfig.heightMultiplier * 7.5,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: AppTextWidget(
                            text: contractor['contractor_company_name'] ??
                                "Unknown",
                            fontSize: AppTextSize.textSizeSmall,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryText,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(width: 8),
                        Flexible(
                          flex: 2,
                          child: AppTextWidget(
                            text:
                                "(${contractor['contractor_phone_no'] ?? 'Unknown'})",
                            fontSize: AppTextSize.textSizeExtraSmall,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryText,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    Container(
                      height: 1,
                      color: AppColors.buttoncolor,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
