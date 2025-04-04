import 'package:get/get.dart';

class LabourProfessDetailsController extends GetxController {
  var selectedSkillLevel = 'Skilled'.obs; // Default value

  void updateSkillLevel(String value) {
    selectedSkillLevel.value = value;
  }

  List<String> yoenumbers = List.generate(51, (index) => index.toString());

  var selectedtrade = ''.obs;
  RxInt selectedyoe = 0.obs;
  var selectedTradeId = ''.obs;
  var selectedContractorId = ''.obs;
  var contractorCompanyName = ''.obs;
}
