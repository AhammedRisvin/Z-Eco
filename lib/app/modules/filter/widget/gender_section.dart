import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widgets.dart';
import '../../../utils/extentions.dart';
import '../../sections and details/view model/section_provider.dart';

class GenderSectionWidget extends StatelessWidget {
  const GenderSectionWidget({
    super.key,
    required this.filterProvider,
  });

  final SectionProvider? filterProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.width * 100,
      height: Responsive.height * 100,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.width * 2,
        vertical: Responsive.height * 2,
      ),
      child: Consumer<SectionProvider>(
        builder: (context, value, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTextWidgets(
              textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              text: "Gender",
            ),
            CustomGenderCheckBox(
              title: 'Male',
              onChanged: filterProvider?.selectMale,
              value: filterProvider?.isMaleSelected,
              selectedCheckBox: filterProvider!.isMaleSelected,
            ),
            CustomGenderCheckBox(
              title: 'Female',
              value: filterProvider?.isFemaleSelected,
              onChanged: filterProvider?.selectFemale,
              selectedCheckBox: filterProvider!.isFemaleSelected,
            ),
            CustomGenderCheckBox(
              title: 'Kids',
              value: filterProvider?.isKidsSelected,
              onChanged: filterProvider?.selectKids,
              selectedCheckBox: filterProvider!.isKidsSelected,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomGenderCheckBox extends StatelessWidget {
  final Function(bool?)? onChanged;
  final bool? value;
  final String title;
  final bool selectedCheckBox;
  const CustomGenderCheckBox(
      {super.key,
      this.onChanged,
      this.value,
      required this.title,
      this.selectedCheckBox = false});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: CustomTextWidgets(
        text: title,
        textStyle:
            Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15),
      ),
      value: value,
      onChanged: onChanged,
      tileColor: Colors.transparent,
      activeColor: const Color(0xff2F4EFF),
      checkColor: selectedCheckBox ? Colors.white : const Color(0xff2F4EFF),
      contentPadding: EdgeInsets.only(
        left: Responsive.width * 1,
        right: Responsive.width * 1,
      ),
      selectedTileColor: const Color(0xff2F4EFF),
      side: const BorderSide(
        color: Color(0xff2F4EFF),
        width: 1,
      ),
      checkboxShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      fillColor: selectedCheckBox
          ? const WidgetStatePropertyAll(
              Color(0xff2F4EFF),
            )
          : const WidgetStatePropertyAll(
              Colors.white,
            ),
    );
  }
}
