import 'package:get/get.dart';

import '../new_work_permit/new_work_permit_model.dart';

class WorkPermitPrecautionController extends GetxController {
  var selectedWorkPermitData = <int, Set<int>>{}.obs;
  var filteredListfinal = <WorkPermitDetail>[].obs;

  void updateFilteredList(List<WorkPermitDetail> newList) {
    if (newList.isNotEmpty) {
      filteredListfinal.addAll(newList); // Keep previous data
    }
  }

  void toggleSelection(int categoryId, int detailId, bool isSelected) {
    if (isSelected) {
      selectedWorkPermitData.putIfAbsent(categoryId, () => {}).add(detailId);
    } else {
      selectedWorkPermitData[categoryId]?.remove(detailId);
      if (selectedWorkPermitData[categoryId]?.isEmpty ?? false) {
        selectedWorkPermitData.remove(categoryId);
      }
    }

    // **DEBUG: Print to check**
    print("Updated selectedWorkPermitData: ${selectedWorkPermitData}");

    // **Trigger update manually**
    selectedWorkPermitData.refresh();
  }

  void toggleSelectAll(int categoryId, List<int> detailIds, bool isSelected) {
    if (isSelected) {
      selectedWorkPermitData[categoryId] = detailIds.toSet();
    } else {
      selectedWorkPermitData.remove(categoryId);
    }
    print(selectedWorkPermitData);
    selectedWorkPermitData.refresh();
  }

  List<Map<String, dynamic>> getSelectedDataForPost() {
    return selectedWorkPermitData.entries
        .map((entry) => {
              "work_permit_categories_id": entry.key,
              "work_permit_details_id": entry.value.toList(),
            })
        .toList();
  }

  var workPermitError = ''.obs;
  bool validateWorkPermitSelection(List<int> requiredCategoryIds) {
    // 🔹 Get only categories that actually have data
    List<int> nonEmptyCategories = requiredCategoryIds.where((categoryId) {
      return filteredListfinal.any(
        (item) => item.categoriesId == categoryId, // Check if category has data
      );
    }).toList();

    // 🔹 If no non-empty categories exist, skip validation
    if (nonEmptyCategories.isEmpty) {
      return true; // Allow navigation
    }

    bool allRequiredSelected = nonEmptyCategories.every(
      (categoryId) =>
          selectedWorkPermitData.containsKey(categoryId) &&
          selectedWorkPermitData[categoryId]!.isNotEmpty,
    );

    if (!allRequiredSelected) {
      workPermitError.value =
          "Please select at least one option for each required category.";
    } else {
      workPermitError.value = "";
    }

    return allRequiredSelected;
  }

  void clearSelectedWorkPermitData() {
    selectedWorkPermitData.clear();
    selectedWorkPermitData.refresh();
    filteredListfinal.clear();
    filteredListfinal.refresh();
    print("Cleared selectedWorkPermitData: $selectedWorkPermitData");
  }

  void resetData() {
    selectedWorkPermitData.clear();
    selectedWorkPermitData.refresh();

    filteredListfinal.clear();
    filteredListfinal.refresh();

    workPermitError.value = "";

    print("All data cleared in WorkPermitPrecautionController!");
  }
}
