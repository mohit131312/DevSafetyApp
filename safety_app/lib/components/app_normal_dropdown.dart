import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_textsize.dart';

class AppNormalDropdown extends StatelessWidget {
  final List<String> items;
  final String? selectedItem;
  final ValueChanged<String?> onChanged;
  final bool enabled;
  final AppTextWidget? hint;
  final FormFieldValidator<String?>? validator;

  const AppNormalDropdown(
      {super.key,
      required this.items,
      required this.onChanged,
      this.selectedItem,
      this.enabled = true,
      this.hint,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor:
            Colors.white, // ✅ Ensures dropdown menu background is white
      ),
      child: DropdownButtonFormField<String>(
        style: GoogleFonts.inter(
          fontSize: AppTextSize.textSizeSmallm,
          fontWeight: FontWeight.w400,
          color: AppColors.primaryText,
        ),

        hint: hint,
        value: selectedItem?.isNotEmpty == true ? selectedItem : null,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.searchfeildcolor, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.searchfeildcolor, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.searchfeildcolor, width: 1),
          ),
        ),
        validator: validator, //

        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: GoogleFonts.inter(
                fontSize: AppTextSize.textSizeSmall,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryText,
              ),
            ),
          );
        }).toList(),
        onChanged: enabled ? onChanged : null,
        isExpanded: true,
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: AppColors.searchfeild,
          size: 24,
        ),
      ),
    );
  }
}
