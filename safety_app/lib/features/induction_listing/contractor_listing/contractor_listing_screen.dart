import 'dart:io';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/features/home/location_controller.dart';
import 'package:flutter_app/features/induction_listing/contractor_listing/contractor_listing_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../components/app_elevated_button_icon.dart';

class ContractorListingScreen extends StatelessWidget {
  final int userId;
  final String userName;
  final int projectId;
  final String userImg;
  final String userDesg;

  ContractorListingScreen({
    super.key,
    required this.userId,
    required this.userName,
    required this.projectId,
    required this.userImg,
    required this.userDesg,
  });

  final ContractorListingController contractorListingController =
      Get.put(ContractorListingController());
  final LocationController locationController = Get.find();



//   Future<void> downloadFile(String filePath, String label) async {
//     final fullUrl = "$baseUrl$filePath";
//     final fileName = filePath.split('/').last;
//
//     // Request storage permission
//     bool hasPermission = await _requestPermissions();
//     if (!hasPermission) {
//       Get.snackbar('Permission Denied', 'Storage permission is required to download files');
//       return;
//     }
//
//     try {
//       // Get the Downloads directory
//       Directory? downloadsDir;
//       if (Platform.isAndroid) {
//         downloadsDir = Directory('/storage/emulated/0/Download');
//       } else if (Platform.isIOS) {
//         downloadsDir = await getApplicationDocumentsDirectory();
//       }
//
//       // Ensure the Downloads directory exists
//       if (downloadsDir != null && !await downloadsDir.exists()) {
//         await downloadsDir.create(recursive: true);
//       }
//
//       final savePath = '${downloadsDir?.path}/$fileName';
//
//       // Start the download using flutter_downloader
//       final taskId = await FlutterDownloader.enqueue(
//         url: fullUrl,
//         savedDir: downloadsDir!.path,
//         fileName: fileName,
//         showNotification: true, // Show download progress in notification
//         openFileFromNotification: true, // Allow opening file from notification
//         saveInPublicStorage: true, // Save in public Downloads folder
//       );
//
//       // Optional: Listen for download progress
//       FlutterDownloader.registerCallback((id, status, progress) {
//         if (taskId == id) {
//           if (status == DownloadTaskStatus.complete) {
//             Get.snackbar('Success', '$label downloaded successfully to Downloads folder');
//           } else if (status == DownloadTaskStatus.failed) {
//             Get.snackbar('Error', 'Failed to download $label');
//           } else if (status == DownloadTaskStatus.running) {
//             print('Download progress: $progress%');
//             // Optionally update UI with progress
//           }
//         }
//       });
//     } catch (e) {
//       Get.snackbar('Error', 'Error downloading $label: $e');
//     }
//   }
//
// // Helper function to request permissions
//   Future<bool> _requestPermissions() async {
//     if (Platform.isAndroid) {
//       // For Android 11+ (API 30+), use MANAGE_EXTERNAL_STORAGE for Downloads folder
//       var imageStatus = await Permission.photos.request();
//       if (imageStatus.isGranted) {
//         return true;
//       }
//       if (await Permission.manageExternalStorage.request().isGranted) {
//         return true;
//       }
//       return false;
//     } else if (Platform.isIOS) {
//       // iOS typically doesn't require storage permissions for app directories
//       return true;
//     }
//     return false;
//   }

  // Future<void> downloadFile(String filePath, String label) async {
  //   final fullUrl = "$baseUrl$filePath";
  //   final fileName = filePath.split('/').last;
  //
  //   if (await Permission.storage.request().isGranted) {
  //     try {
  //       final dir = await getExternalStorageDirectory();
  //       final savePath = '${dir?.path}/$fileName';
  //
  //       final dio = Dio();
  //       await dio.download(
  //         fullUrl,
  //         savePath,
  //         onReceiveProgress: (received, total) {
  //           if (total != -1) {
  //             final progress = (received / total * 100).toStringAsFixed(0);
  //             print('Download progress: $progress%');
  //             // Optionally update UI with progress
  //           }
  //         },
  //       );
  //       Get.snackbar('Success', '$label downloaded successfully');
  //     } catch (e) {
  //       Get.snackbar('Error', 'Error downloading $label: $e');
  //     }
  //   } else {
  //     Get.snackbar('Permission Denied', 'Storage permission is required to download files');
  //   }
  // }



  Future<void> viewFile(BuildContext context, String filePath, String label) async {
    final fullUrl = "$baseUrl$filePath";
    final fileName = filePath.split('/').last;
    final fileExtension = fileName.split('.').last.toLowerCase();
    const imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp'];

    if (imageExtensions.contains(fileExtension)) {
      // Show image in a dialog (unchanged)
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: InteractiveViewer(
              panEnabled: true,
              minScale: 0.5,
              maxScale: 3.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: fullUrl,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
      );
    } else if (fileExtension == 'pdf') {
      // Download PDF and view it
      // if (await Permission.storage.request().isGranted) {
        try {
          final dir = await getApplicationDocumentsDirectory();
          final savePath = '${dir.path}/$fileName';
          final file = File(savePath);

          // Download if file doesn't exist
          if (!await file.exists()) {
            final response = await http.get(Uri.parse(fullUrl));
            if (response.statusCode == 200) {
              await file.writeAsBytes(response.bodyBytes);
            } else {
              Get.snackbar('Error', 'Failed to download $label');
              return;
            }
          }

          // Navigate to PDF viewer
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  Scaffold(
                    appBar: AppBar(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(20),
                        ),
                      ),
                      scrolledUnderElevation: 0.0,
                      elevation: 0,
                      backgroundColor: AppColors.buttoncolor,
                      foregroundColor: AppColors.buttoncolor,
                      centerTitle: true,
                      toolbarHeight: SizeConfig.heightMultiplier * 10,
                      title: Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.heightMultiplier * 2),
                        child: AppTextWidget(
                          text: "$label",
                          fontSize: AppTextSize.textSizeMedium,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primary,
                        ),
                      ),
                      leading: Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.heightMultiplier * 2),
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: SizeConfig.heightMultiplier * 2.5,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),

                    body: PDFView(
                      filePath: savePath,
                      enableSwipe: true,
                      swipeHorizontal: true,
                      autoSpacing: false,
                      pageFling: false,
                      onError: (error) {
                        Get.snackbar('Error', 'Failed to load PDF: $error');
                      },
                    ),
                  ),
            ),
          );
        } catch (e) {
          Get.snackbar('Error', 'Error opening $label: $e');
        }
      // }
      // } else {
      //   Get.snackbar('Permission Denied', 'Storage permission is required to view files');
      // }
    } else {
      // Fallback to OpenFilex for other file types
      try {
        final dir = await getApplicationDocumentsDirectory();
        final savePath = '${dir.path}/$fileName';
        final file = File(savePath);

        if (!await file.exists()) {
          final response = await http.get(Uri.parse(fullUrl));
          if (response.statusCode == 200) {
            await file.writeAsBytes(response.bodyBytes);
          } else {
            Get.snackbar('Error', 'Failed to download $label');
            return;
          }
        }

        final result = await OpenFilex.open(savePath);
        if (result.type != ResultType.done) {
          Get.snackbar('Error', 'Could not open $label: ${result.message}');
        }
      } catch (e) {
        Get.snackbar('Error', 'Error opening $label: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          scrolledUnderElevation: 0.0,
          elevation: 0,
          backgroundColor: AppColors.buttoncolor,
          foregroundColor: AppColors.buttoncolor,
          centerTitle: true,
          toolbarHeight: SizeConfig.heightMultiplier * 10,
          title: Padding(
            padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 2),
            child: AppTextWidget(
              text: AppTexts.preview,
              fontSize: AppTextSize.textSizeMedium,
              fontWeight: FontWeight.w400,
              color: AppColors.primary,
            ),
          ),
          leading: Padding(
            padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 2),
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: SizeConfig.heightMultiplier * 2.5,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 4,
                  vertical: SizeConfig.heightMultiplier * 2,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextWidget(
                      text: AppTexts.previewsubmit,
                      fontSize: AppTextSize.textSizeMediumm,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryText,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 0.3,
                    ),
                    AppTextWidget(
                      text: AppTexts.checkdetailssubmit,
                      fontSize: AppTextSize.textSizeSmall,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryText,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2.5,
                    ),
                    Row(
                      children: [
                        AppTextWidget(
                          text: "Induction ID :  ",
                          fontSize: AppTextSize.textSizeSmallm,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryText,
                        ),
                        AppTextWidget(
                          text: contractorListingController
                              .contractorInductionTrainingsList[0].inductionId
                              .toString(),
                          fontSize: AppTextSize.textSizeSmall,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryText,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1,
                    ),
                  ],
                ),
              ),
              Obx(
                () => contractorListingController
                        .isPersonalDetailsExpanded.value
                    ? Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 4,
                          vertical: SizeConfig.heightMultiplier * 2,
                        ),
                        width: SizeConfig.widthMultiplier * 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xFFFEFEFE),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x10000000),
                              blurRadius: 20,
                              spreadRadius: 0,
                              offset: Offset(0, -4),
                            ),
                          ],
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: Image.asset(
                                          'assets/icons/Contractor.png')),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  AppTextWidget(
                                    text: AppTexts.contractordetails,
                                    fontSize: AppTextSize.textSizeSmall,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.buttoncolor,
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                      onTap: () {
                                        contractorListingController
                                            .toggleExpansion();
                                      },
                                      child: Icon(Icons.keyboard_arrow_up)),
                                ],
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 2,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.widthMultiplier * 4,
                                  vertical: SizeConfig.heightMultiplier * 3,
                                ),
                                width: SizeConfig.widthMultiplier * 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColors.appgreycolor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: SizeConfig.widthMultiplier * 40,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            AppTextWidget(
                                                text: AppTexts.contractorfirm,
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.searchfeild),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            ),
                                            AppTextWidget(
                                                text: (contractorListingController
                                                            .contractorCompanyDetailsList
                                                            .isNotEmpty &&
                                                        contractorListingController
                                                                .contractorCompanyDetailsList[
                                                                    0]
                                                                // ignore: unnecessary_null_comparison
                                                                .contractorCompanyName !=
                                                            null &&
                                                        contractorListingController
                                                            .contractorCompanyDetailsList[
                                                                0]
                                                            .contractorCompanyName
                                                            .trim()
                                                            .isNotEmpty)
                                                    ? contractorListingController
                                                        .contractorCompanyDetailsList[
                                                            0]
                                                        .contractorCompanyName
                                                    : '',
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.primaryText),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      2.5,
                                            ),
                                            AppTextWidget(
                                                text: AppTexts.gstn,
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.searchfeild),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            ),
                                            AppTextWidget(
                                              text: contractorListingController
                                                      .contractorCompanyDetailsList
                                                      .isNotEmpty
                                                  ? (contractorListingController
                                                                  .contractorCompanyDetailsList[
                                                                      0]
                                                                  .gstnNumber ??
                                                              '')
                                                          .trim()
                                                          .isNotEmpty
                                                      ? contractorListingController
                                                          .contractorCompanyDetailsList[
                                                              0]
                                                          .gstnNumber!
                                                          .trim()
                                                      : ''
                                                  : '',
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.primaryText,
                                            ),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      2.5,
                                            ),
                                          ]),
                                    ),
                                    SizedBox(
                                      width: 20,
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: SizeConfig.widthMultiplier * 36,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            AppTextWidget(
                                                text: AppTexts.reasonforvisit,
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.searchfeild),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            ),
                                            AppTextWidget(
                                                text: contractorListingController
                                                        .contractorReasonOfVisitList[
                                                            0]
                                                        .reasonOfVisit!
                                                        .isNotEmpty
                                                    ? contractorListingController
                                                        .contractorReasonOfVisitList[
                                                            0]
                                                        .reasonOfVisit!
                                                    : '',
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.primaryText),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      2.5,
                                            ),
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                      )
                    : Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 4,
                          vertical: SizeConfig.heightMultiplier * 2,
                        ),
                        width: SizeConfig.widthMultiplier * 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xFFFEFEFE),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x10000000),
                              blurRadius: 20,
                              spreadRadius: 0,
                              offset: Offset(0, -4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: Image.asset(
                                        'assets/icons/Contractor.png')),
                                SizedBox(
                                  width: 5,
                                ),
                                AppTextWidget(
                                  text: AppTexts.contractordetails,
                                  fontSize: AppTextSize.textSizeSmall,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.buttoncolor,
                                ),
                                Spacer(),
                                GestureDetector(
                                    onTap: () {
                                      contractorListingController
                                          .toggleExpansion();
                                    },
                                    child: Icon(Icons.keyboard_arrow_up)),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 2,
                            ),
                          ],
                        ),
                      ),
              ),

              //---------------------------------------------------------------------

              //-----------------------------------------------------------------
              Obx(() => contractorListingController
                      .isidproofDetailsExpanded.value
                  ? Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 4,
                        vertical: SizeConfig.heightMultiplier * 2,
                      ),
                      width: SizeConfig.widthMultiplier * 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xFFFEFEFE),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x10000000),
                            blurRadius: 20,
                            spreadRadius: 0,
                            offset: Offset(0, -4),
                          ),
                        ],
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: Image.asset(
                                        'assets/icons/phone_small_phone.png')),
                                SizedBox(
                                  width: 5,
                                ),
                                AppTextWidget(
                                  text: 'Contact Details',
                                  fontSize: AppTextSize.textSizeSmall,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.buttoncolor,
                                ),
                                Spacer(),
                                GestureDetector(
                                    onTap: () {
                                      contractorListingController
                                          .toggleExpansionidProof();
                                    },
                                    child: Icon(Icons.keyboard_arrow_up)),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 3,
                            ),
                            AppTextWidget(
                              text: 'Primary Contact Details',
                              fontSize: AppTextSize.textSizeSmall,
                              fontWeight: FontWeight.w500,
                              color: AppColors.searchfeild,
                            ),
                            SizedBox(height: SizeConfig.heightMultiplier * 2),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.widthMultiplier * 4,
                                vertical: SizeConfig.heightMultiplier * 3,
                              ),
                              width: SizeConfig.widthMultiplier * 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColors.appgreycolor,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: SizeConfig.widthMultiplier * 43,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          AppTextWidget(
                                              text: AppTexts.name,
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.searchfeild),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 1,
                                          ),
                                          AppTextWidget(
                                              text: contractorListingController
                                                      .contractorDetailsList[0]
                                                      .contractorName
                                                      .isNotEmpty
                                                  ? contractorListingController
                                                      .contractorDetailsList[0]
                                                      .contractorName
                                                  : '',
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.primaryText),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    2.5,
                                          ),
                                          AppTextWidget(
                                              text: AppTexts.emailid,
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.searchfeild),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 1,
                                          ),
                                          AppTextWidget(
                                            text: contractorListingController
                                                    .contractorDetailsList[0]
                                                    .contractorEmail!
                                                    .isNotEmpty
                                                ? contractorListingController
                                                    .contractorDetailsList[0]
                                                    .contractorEmail!
                                                : '',
                                            fontSize: AppTextSize.textSizeSmall,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.primaryText,
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    2.5,
                                          ),
                                          AppTextWidget(
                                              text: AppTexts.idproofno,
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.searchfeild),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 1,
                                          ),
                                          AppTextWidget(
                                            text: contractorListingController
                                                    .contractorDetailsList[0]
                                                    .idProofNumber!
                                                    .isNotEmpty
                                                ? contractorListingController
                                                    .contractorDetailsList[0]
                                                    .idProofNumber!
                                                    .toString()
                                                : '',
                                            fontSize: AppTextSize.textSizeSmall,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.primaryText,
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    2.5,
                                          ),
                                        ]),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.widthMultiplier * 4,
                                  ),
                                  SizedBox(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          AppTextWidget(
                                              text: AppTexts.contactno,
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.searchfeild),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 1,
                                          ),
                                          AppTextWidget(
                                              text: contractorListingController
                                                      .contractorDetailsList[0]
                                                      .contractorPhoneNo!
                                                      .isNotEmpty
                                                  ? contractorListingController
                                                      .contractorDetailsList[0]
                                                      .contractorPhoneNo!
                                                      .toString()
                                                  : '',
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.primaryText),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    2.5,
                                          ),
                                          AppTextWidget(
                                              text: AppTexts.idprooftype,
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.searchfeild),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 1,
                                          ),
                                          AppTextWidget(
                                            text: contractorListingController.
                                                        // ignore: unnecessary_null_comparison
                                                        documentType !=
                                                    null
                                                ? contractorListingController
                                                    .documentType
                                                    .toString()
                                                : '',
                                            fontSize: AppTextSize.textSizeSmall,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.primaryText,
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    2.5,
                                          ),
                                          AppTextWidget(
                                              text: AppTexts.photos,
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.searchfeild),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 1,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (contractorListingController
                                                      .contractorDetailsList
                                                      .isNotEmpty &&
                                                  contractorListingController
                                                          .contractorDetailsList[
                                                              0]
                                                          // ignore: unnecessary_null_comparison
                                                          .documentPath !=
                                                      null &&
                                                  contractorListingController
                                                      .contractorDetailsList[0]
                                                      .documentPath!
                                                      .isNotEmpty) {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Dialog(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      child: InteractiveViewer(
                                                        panEnabled: true,
                                                        minScale: 0.5,
                                                        maxScale: 3.0,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: Image.network(
                                                            "$baseUrl${contractorListingController.contractorDetailsList[0].documentPath}",
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              }
                                            },
                                            child: SizedBox(
                                              height: SizeConfig
                                                      .imageSizeMultiplier *
                                                  16,
                                              width: SizeConfig
                                                      .imageSizeMultiplier *
                                                  16,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: (contractorListingController
                                                            .contractorDetailsList[
                                                                0]
                                                            .documentPath!
                                                            .isNotEmpty &&
                                                        // ignore: unnecessary_null_comparison
                                                        contractorListingController
                                                                .contractorDetailsList[
                                                                    0]
                                                                .documentPath !=
                                                            null)
                                                    ? Image.network(
                                                        "$baseUrl${contractorListingController.contractorDetailsList[0].documentPath}",
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Image.asset(""),
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                            ),

                            //----------------------------

                            SizedBox(
                              height: SizeConfig.heightMultiplier * 3,
                            ),
                            AppTextWidget(
                              text: 'Secondary Contact Details',
                              fontSize: AppTextSize.textSizeSmall,
                              fontWeight: FontWeight.w500,
                              color: AppColors.searchfeild,
                            ),
                            SizedBox(height: SizeConfig.heightMultiplier * 2),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.widthMultiplier * 4,
                                vertical: SizeConfig.heightMultiplier * 3,
                              ),
                              width: SizeConfig.widthMultiplier * 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColors.appgreycolor,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: SizeConfig.widthMultiplier * 40,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          AppTextWidget(
                                              text: AppTexts.name,
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.searchfeild),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 1,
                                          ),
                                          AppTextWidget(
                                              text: contractorListingController
                                                      .contractorDetailsList[0]
                                                      .secondaryContactPersonName!
                                                      .isNotEmpty
                                                  ? contractorListingController
                                                      .contractorDetailsList[0]
                                                      .secondaryContactPersonName!
                                                  : '',
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.primaryText),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    2.5,
                                          ),
                                        ]),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.widthMultiplier * 40,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          AppTextWidget(
                                              text: AppTexts.contactno,
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.searchfeild),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 1,
                                          ),
                                          AppTextWidget(
                                              text: contractorListingController
                                                      .contractorDetailsList[0]
                                                      .secondaryContactPersonNumber!
                                                      .isNotEmpty
                                                  ? contractorListingController
                                                      .contractorDetailsList[0]
                                                      .secondaryContactPersonNumber!
                                                  : '',
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.primaryText),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    2.5,
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 3,
                            ),
                            AppTextWidget(
                              text: 'Documents',
                              fontSize: AppTextSize.textSizeSmall,
                              fontWeight: FontWeight.w500,
                              color: AppColors.searchfeild,
                            ),
                            SizedBox(height: SizeConfig.heightMultiplier * 2),
                            if (contractorListingController.contractorInductionTrainingsList.isNotEmpty &&
                                (contractorListingController.contractorInductionTrainingsList.first.docWcPolicy?.isNotEmpty == true ||
                                    contractorListingController.contractorInductionTrainingsList.first.docWorkPermit?.isNotEmpty == true))
                              Padding(
                                padding: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 1),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (contractorListingController.contractorInductionTrainingsList.first.docWcPolicy?.isNotEmpty == true)
                                      Expanded(
                                        child: AppElevatedButtonIcon(
                                          text: 'WC Policy',
                                          icon: Icon(
                                            Icons.visibility, // Icon for View Work Permit
                                            size: SizeConfig.imageSizeMultiplier * 5,
                                            color: AppColors.primary, // Adjust color to match your theme
                                          ),
                                          onPressed: () {
                                            viewFile(
                                              context,
                                              contractorListingController.contractorInductionTrainingsList[0].docWcPolicy!,
                                              'WC Policy',
                                            );
                                          },
                                        ),
                                      ),
                                    if (contractorListingController.contractorInductionTrainingsList.first.docWcPolicy?.isNotEmpty == true &&
                                        contractorListingController.contractorInductionTrainingsList.first.docWorkPermit?.isNotEmpty == true)
                                      SizedBox(width: SizeConfig.widthMultiplier * 2),
                                    if (contractorListingController.contractorInductionTrainingsList.first.docWorkPermit?.isNotEmpty == true)
                                      Expanded(
                                        child: AppElevatedButtonIcon(
                                          text: 'Work Permit',
                                          icon: Icon(
                                            Icons.visibility, // Icon for View Work Permit
                                            size: SizeConfig.imageSizeMultiplier * 5,
                                            color: AppColors.primary, // Adjust color to match your theme
                                          ),
                                          onPressed: () {
                                            viewFile(
                                              context,
                                              contractorListingController.contractorInductionTrainingsList[0].docWorkPermit!,
                                              'Work Permit',
                                            );
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            // SizedBox(height: SizeConfig.heightMultiplier * 2),
                            // if (contractorListingController.contractorInductionTrainingsList.isNotEmpty &&
                            //     contractorListingController.contractorInductionTrainingsList.first.docWcPolicy?.isNotEmpty == true)
                            //   Padding(
                            //     padding: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 1),
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //       children: [
                            //         // Expanded(
                            //         //   child: AppElevatedButton(
                            //         //     text: 'Download WC Policy',
                            //         //     onPressed: () {
                            //         //       downloadFile(
                            //         //         contractorListingController.contractorInductionTrainingsList[0].docWcPolicy!,
                            //         //         'WC Policy',
                            //         //       );
                            //         //     },
                            //         //   ),
                            //         // ),
                            //         SizedBox(width: SizeConfig.widthMultiplier * 2),
                            //         Expanded(
                            //           child: AppElevatedButton(
                            //             text: 'View WC Policy',
                            //             onPressed: () {
                            //               viewFile(
                            //                 context,
                            //                 contractorListingController.contractorInductionTrainingsList[0].docWcPolicy!,
                            //                 'WC Policy',
                            //               );
                            //             },
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // if (contractorListingController.contractorInductionTrainingsList.isNotEmpty &&
                            //     contractorListingController.contractorInductionTrainingsList.first.docWorkPermit?.isNotEmpty == true)
                            //   Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       // Expanded(
                            //       //   child: AppElevatedButton(
                            //       //     text: 'Download Work Permit',
                            //       //     onPressed: () {
                            //       //       downloadFile(
                            //       //         contractorListingController.contractorInductionTrainingsList[0].docWorkPermit!,
                            //       //         'Work Permit',
                            //       //       );
                            //       //     },
                            //       //   ),
                            //       // ),
                            //       SizedBox(width: SizeConfig.widthMultiplier * 2),
                            //       Expanded(
                            //         child: AppElevatedButton(
                            //           text: 'View Work Permit',
                            //           onPressed: () {
                            //             viewFile(
                            //               context,
                            //               contractorListingController.contractorInductionTrainingsList[0].docWorkPermit!,
                            //               'Work Permit',
                            //             );
                            //           },
                            //         ),
                            //       ),
                            //     ],
                            //   ),

                          ]),
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 4,
                        vertical: SizeConfig.heightMultiplier * 2,
                      ),
                      width: SizeConfig.widthMultiplier * 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xFFFEFEFE),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x10000000),
                            blurRadius: 20,
                            spreadRadius: 0,
                            offset: Offset(0, -4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Image.asset(
                                      'assets/icons/phone_small_phone.png')),
                              SizedBox(
                                width: 5,
                              ),
                              AppTextWidget(
                                text: 'Contact Details',
                                fontSize: AppTextSize.textSizeSmall,
                                fontWeight: FontWeight.w500,
                                color: AppColors.buttoncolor,
                              ),
                              Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    contractorListingController
                                        .toggleExpansionidProof();
                                  },
                                  child: Icon(Icons.keyboard_arrow_up)),
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 3,
                          ),
                        ],
                      ),
                    )),
              //------------------------------------------------------------------
              Obx(
                () =>
                    contractorListingController
                            .isprecautionDetailsExpanded.value
                        ? Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.widthMultiplier * 4,
                              vertical: SizeConfig.heightMultiplier * 2,
                            ),
                            width: SizeConfig.widthMultiplier * 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color(0xFFFEFEFE),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x10000000),
                                  blurRadius: 20,
                                  spreadRadius: 0,
                                  offset: Offset(0, -4),
                                ),
                              ],
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: Image.asset(
                                              'assets/icons/precaution.png')),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      AppTextWidget(
                                        text: 'Service Details',
                                        fontSize: AppTextSize.textSizeSmall,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.buttoncolor,
                                      ),
                                      Spacer(),
                                      GestureDetector(
                                          onTap: () {
                                            contractorListingController
                                                .toggleExpansionPrecaution();
                                          },
                                          child: Icon(Icons.keyboard_arrow_up)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier * 3,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          SizeConfig.widthMultiplier * 4,
                                      vertical: SizeConfig.widthMultiplier * 4,
                                    ),
                                    width: SizeConfig.widthMultiplier * 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: AppColors.appgreycolor,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                contractorListingController
                                                        .contractorServicesDetail
                                                        .isNotEmpty
                                                    ? Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                // color:
                                                                //     AppColors.primary,
                                                                border: Border.all(
                                                                    width: 0.7,
                                                                    color: AppColors
                                                                        .backbuttoncolor)),
                                                        width: SizeConfig
                                                                .widthMultiplier *
                                                            92,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 10,
                                                                      right: 6),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          SizedBox(
                                                                            child:
                                                                                ListView.separated(
                                                                              physics: NeverScrollableScrollPhysics(),
                                                                              itemCount: contractorListingController.contractorServicesDetail.length,
                                                                              shrinkWrap: true,
                                                                              itemBuilder: (context, index) {
                                                                                if (index >= contractorListingController.contractorServicesDetail.length) {
                                                                                  return SizedBox.shrink();
                                                                                }
                                                                                return Padding(
                                                                                  padding: EdgeInsets.only(top: 20),
                                                                                  child: Column(
                                                                                    children: [
                                                                                      Row(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          Expanded(
                                                                                            child: Column(
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                AppTextWidget(text: 'Activity', fontSize: AppTextSize.textSizeSmall, fontWeight: FontWeight.w400, color: AppColors.searchfeild),
                                                                                                SizedBox(
                                                                                                  height: SizeConfig.heightMultiplier * 1,
                                                                                                ),
                                                                                                AppTextWidget(text: contractorListingController.contractorServicesDetail[index].activityName, fontSize: AppTextSize.textSizeSmalle, fontWeight: FontWeight.w400, color: AppColors.primaryText),
                                                                                                SizedBox(
                                                                                                  height: SizeConfig.heightMultiplier * 2.5,
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: SizeConfig.widthMultiplier * 1,
                                                                                          ),
                                                                                          Expanded(
                                                                                            child: Column(
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                AppTextWidget(text: 'Sub Activity', fontSize: AppTextSize.textSizeSmall, fontWeight: FontWeight.w400, color: AppColors.searchfeild),
                                                                                                SizedBox(
                                                                                                  height: SizeConfig.heightMultiplier * 1,
                                                                                                ),
                                                                                                AppTextWidget(
                                                                                                    // text:
                                                                                                    //     serviceDetailsController.activityExist[index]['sub_activity_id'].toString(),
                                                                                                    text: contractorListingController.contractorServicesDetail[index].activityName,
                                                                                                    fontSize: AppTextSize.textSizeSmalle,
                                                                                                    fontWeight: FontWeight.w400,
                                                                                                    color: AppColors.primaryText),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                );
                                                                              },
                                                                              separatorBuilder: (BuildContext context, int index) {
                                                                                return Container(
                                                                                  height: 1,
                                                                                  color: AppColors.searchfeildcolor,
                                                                                );
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: AppColors
                                                                .primary,
                                                            border: Border.all(
                                                                width: 0.7,
                                                                color: AppColors
                                                                    .backbuttoncolor)),
                                                        width: SizeConfig
                                                                .widthMultiplier *
                                                            92,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 10,
                                                                      right:
                                                                          10),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      SizedBox(
                                                                        child: ListView
                                                                            .separated(
                                                                          physics:
                                                                              NeverScrollableScrollPhysics(),
                                                                          itemCount: contractorListingController
                                                                              .contractorServicesDetail
                                                                              .length,
                                                                          shrinkWrap:
                                                                              true,
                                                                          itemBuilder:
                                                                              (context, index) {
                                                                            if (index >=
                                                                                contractorListingController.contractorServicesDetail.length) {
                                                                              return SizedBox.shrink();
                                                                            }
                                                                            return Stack(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsets.only(top: 20),
                                                                                  child: Column(
                                                                                    children: [
                                                                                      Row(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          Expanded(
                                                                                            child: Column(
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                AppTextWidget(text: 'Activity', fontSize: AppTextSize.textSizeSmall, fontWeight: FontWeight.w400, color: AppColors.searchfeild),
                                                                                                SizedBox(
                                                                                                  height: SizeConfig.heightMultiplier * 1,
                                                                                                ),
                                                                                                AppTextWidget(text: contractorListingController.contractorServicesDetail[index].activityName, fontSize: AppTextSize.textSizeSmalle, fontWeight: FontWeight.w400, color: AppColors.primaryText),
                                                                                                SizedBox(
                                                                                                  height: SizeConfig.heightMultiplier * 2.5,
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: SizeConfig.heightMultiplier * 2.5,
                                                                                          ),
                                                                                          Expanded(
                                                                                            child: Column(
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                AppTextWidget(text: 'Sub Activity', fontSize: AppTextSize.textSizeSmall, fontWeight: FontWeight.w400, color: AppColors.searchfeild),
                                                                                                SizedBox(
                                                                                                  height: SizeConfig.heightMultiplier * 1,
                                                                                                ),
                                                                                                AppTextWidget(text: contractorListingController.contractorServicesDetail[index].subActivityName, fontSize: AppTextSize.textSizeSmalle, fontWeight: FontWeight.w400, color: AppColors.primaryText),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            );
                                                                          },
                                                                          separatorBuilder:
                                                                              (BuildContext context, int index) {
                                                                            return Container(
                                                                              height: 1,
                                                                              color: AppColors.searchfeildcolor,
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ]),
                          )
                        : Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.widthMultiplier * 4,
                              vertical: SizeConfig.heightMultiplier * 2,
                            ),
                            width: SizeConfig.widthMultiplier * 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color(0xFFFEFEFE),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x10000000),
                                  blurRadius: 20,
                                  spreadRadius: 0,
                                  offset: Offset(0, -4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: Image.asset(
                                            'assets/icons/precaution.png')),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    AppTextWidget(
                                      text: 'Service Details',
                                      fontSize: AppTextSize.textSizeSmall,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.buttoncolor,
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                        onTap: () {
                                          contractorListingController
                                              .toggleExpansionPrecaution();
                                        },
                                        child: Icon(Icons.keyboard_arrow_up)),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.heightMultiplier * 3,
                                ),
                              ],
                            ),
                          ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 4,
                  vertical: SizeConfig.heightMultiplier * 3,
                ),
                width: SizeConfig.widthMultiplier * 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.appgreycolor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextWidget(
                        text: 'Inducted By',
                        fontSize: AppTextSize.textSizeSmall,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondaryText),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1,
                    ),
                    Row(
                      children: [
                        Container(
                          width: SizeConfig.imageSizeMultiplier * 15,
                          height: SizeConfig.imageSizeMultiplier * 15,
                          child: Image.network(
                            "$baseUrl${userImg}",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 3,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextWidget(
                                text: userName,
                                fontSize: AppTextSize.textSizeSmallm,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryText),
                            AppTextWidget(
                                text: userDesg,
                                fontSize: AppTextSize.textSizeSmall,
                                fontWeight: FontWeight.w400,
                                color: AppColors.searchfeild),
                            SizedBox(
                              width: SizeConfig.widthMultiplier * 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    AppTextWidget(
                        text: 'Created On',
                        fontSize: AppTextSize.textSizeSmalle,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondaryText),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1,
                    ),
                    AppTextWidget(
                      text: contractorListingController
                                  // ignore: unnecessary_null_comparison
                                  .contractorInductionTrainingsList[0]
                                  // ignore: unnecessary_null_comparison
                                  .createdAt !=
                              null
                          ? DateFormat('dd-MM-yyyy hh:mm a')
                              .format(DateTime.parse(contractorListingController
                                  // ignore: unnecessary_null_comparison
                                  .contractorInductionTrainingsList[0]
                                  // ignore: unnecessary_null_comparison
                                  .createdAt
                                  .toString()))
                          : "",
                      fontSize: AppTextSize.textSizeSmall,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryText,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    AppTextWidget(
                        text: 'Geolocation',
                        fontSize: AppTextSize.textSizeSmalle,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondaryText),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1,
                    ),
                    Obx(() {
                      final city = locationController.cityName.value;

                      return AppTextWidget(
                        text: city.isNotEmpty
                            ? 'City: $city'
                            : 'Fetching city...',
                        fontSize: AppTextSize.textSizeSmall,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryText,
                      );
                    }),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 3,
              ),

              SizedBox(
                height: SizeConfig.heightMultiplier * 6,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.heightMultiplier * 1,
            horizontal: SizeConfig.widthMultiplier * 4,
          ),
          child: AppElevatedButton(
              text: 'Close',
              onPressed: () {
                Get.back();
              }),
        ),
      ),
    );
  }
}
