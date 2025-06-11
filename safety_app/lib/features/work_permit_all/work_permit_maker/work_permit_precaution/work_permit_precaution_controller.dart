import 'package:flutter/material.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/new_work_permit/new_work_permit_controller.dart';
import 'package:get/get.dart';

import '../new_work_permit/new_work_permit_model.dart';

class WorkPermitPrecautionController extends GetxController {
  final Map<int, GlobalKey> categoryKeys =
      {}; // Map to store GlobalKeys for categories
  GlobalKey assigneekey = GlobalKey();
  // Initialize a GlobalKey for a category
  void initCategoryKey(int categoryId) {
    categoryKeys.putIfAbsent(categoryId, () => GlobalKey());
  }

  // Scroll to a widget using its GlobalKey
  void scrollToWidget(GlobalKey key) {
    final context = key.currentContext;
    if (context != null && context.mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Scrollable.ensureVisible(
          context,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: 0.2, // Aligns the widget 20% from the top of the viewport
        );
      });
    }
  }

  // Combined validation method
  void validateAndFocusFirstInvalidField(List<int> requiredCategories) {
    // Validate work permit selection
    workPermitErrorMap.clear();
    bool allValid = true;
    if (requiredCategories.isNotEmpty) {
      for (int categoryId in requiredCategories) {
        // Check if this category has any selectable items in the original list
        bool hasItems = newWorkPermitController.workPermitRequiredList
            .any((item) => item.categoriesId == categoryId);

        // Only validate if the category has items available
        if (hasItems) {
          bool isSelected = selectedWorkPermitData.containsKey(categoryId) &&
              selectedWorkPermitData[categoryId]!.isNotEmpty;

          if (!isSelected) {
            workPermitErrorMap[categoryId] =
                "Please select at least one option for this category.";
            allValid = false;
          }
        }
      }
    }
    if (!allValid) {
      // Scroll to the first category with an error
      if (workPermitErrorMap.isNotEmpty) {
        final firstErrorCategoryId = workPermitErrorMap.keys.first;
        final key = categoryKeys[firstErrorCategoryId];
        if (key != null) {
          scrollToWidget(key);
          return;
        }
      }
    }
  }

  var selectedWorkPermitData = <int, Set<int>>{}.obs;
  var filteredListfinal = <WorkPermitDetail>[].obs;
  final NewWorkPermitController newWorkPermitController = Get.find();

  void updateFilteredList(List<WorkPermitDetail> newList) {
    if (newList.isNotEmpty) {
      filteredListfinal.addAll(newList);
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

  // final searchQuery = ''.obs; // Add this line for search functionality
  // void updateSearchQuery(String query) {
  //   searchQuery.value = query.toLowerCase();
  // }

  // List<WorkPermitDetail> getFilteredDetails(
  //     List<WorkPermitDetail> allDetails, String categoryName) {
  //   return allDetails.where((item) {
  //     final matchesCategory = item.categoryName == categoryName;
  //     final matchesSearch =
  //         item.permitDetails.toLowerCase().contains(searchQuery.value);
  //     return matchesCategory && (searchQuery.value.isEmpty || matchesSearch);
  //   }).toList();
  // }
  final searchQueries =
      <int, String>{}.obs; // Changed to map for category-specific searches

  // Update search query for specific category
  void updateSearchQuery(int categoryId, String query) {
    searchQueries[categoryId] = query.toLowerCase();
  }

  // Updated to handle category-specific searches
  List<WorkPermitDetail> getFilteredDetails(
      List<WorkPermitDetail> allDetails, int categoryId, String categoryName) {
    final query = searchQueries[categoryId] ?? '';
    return allDetails.where((item) {
      final matchesCategory = item.categoryName == categoryName;
      final matchesSearch = item.permitDetails.toLowerCase().contains(query);
      return matchesCategory && (query.isEmpty || matchesSearch);
    }).toList();
  }

  // void toggleSelectAll(int categoryId, List<int> detailIds, bool isSelected) {
  //   if (isSelected) {
  //     selectedWorkPermitData[categoryId] = detailIds.toSet();
  //   } else {
  //     selectedWorkPermitData.remove(categoryId);
  //   }
  //   print(selectedWorkPermitData);
  //   selectedWorkPermitData.refresh();
  // }

  void toggleSelectAll(
      int categoryId, List<int> visibleDetailIds, bool isSelected) {
    if (isSelected) {
      // Add only the visible items
      selectedWorkPermitData.update(
        categoryId,
        (existingIds) => existingIds..addAll(visibleDetailIds),
        ifAbsent: () => visibleDetailIds.toSet(),
      );
    } else {
      // Remove only the visible items
      selectedWorkPermitData.update(
        categoryId,
        (existingIds) =>
            existingIds..removeWhere((id) => visibleDetailIds.contains(id)),
        ifAbsent: () => {},
      );
      // Remove category entry if empty
      if (selectedWorkPermitData[categoryId]?.isEmpty ?? false) {
        selectedWorkPermitData.remove(categoryId);
      }
    }
  }

  // Check if all VISIBLE items are selected
  bool isAllVisibleSelected(int categoryId, List<int> visibleDetailIds) {
    final selectedIds = selectedWorkPermitData[categoryId] ?? {};
    return visibleDetailIds.every((id) => selectedIds.contains(id));
  }

  List<Map<String, dynamic>> getSelectedDataForPost() {
    return selectedWorkPermitData.entries
        .map((entry) => {
              "work_permit_categories_id": entry.key,
              "work_permit_details_id": entry.value.toList(),
            })
        .toList();
  }

  var workPermitErrorMap = <int, String>{}.obs;
  bool validateWorkPermitSelection(List<int> requiredCategoryIds) {
    workPermitErrorMap.clear();

    if (requiredCategoryIds.isEmpty) {
      return true;
    }

    bool allValid = true;

    for (int categoryId in requiredCategoryIds) {
      // Check if this category has any selectable items in the original list
      bool hasItems = newWorkPermitController.workPermitRequiredList
          .any((item) => item.categoriesId == categoryId);

      // Only validate if the category has items available
      if (hasItems) {
        bool isSelected = selectedWorkPermitData.containsKey(categoryId) &&
            selectedWorkPermitData[categoryId]!.isNotEmpty;

        if (!isSelected) {
          workPermitErrorMap[categoryId] =
              "Please select at least one option for this category.";
          allValid = false;
        }
      }
    }

    return allValid;
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

    workPermitErrorMap.clear();

    print("All data cleared in WorkPermitPrecautionController!");
  }
}
