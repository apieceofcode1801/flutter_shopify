import 'package:flutter/material.dart';
import 'package:flutter_shopify/ui/views/styles/colors.dart';
import 'package:flutter_shopify/ui/views/styles/text_styles.dart';

class TextFormInputField extends StatelessWidget {
  final CustomFormItem item;
  const TextFormInputField({required this.item});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.title,
          style: TextStyles.label,
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          style: TextStyles.value,
          enabled: item.onTap == null,
          validator: (text) {
            if (!item.canBeEmpty) {
              if (text?.isEmpty ?? false) {
                return 'Can not be empty';
              }
            }
            return item.validator != null ? item.validator!(text) : null;
          },
          decoration: InputDecoration(
              isDense: true,
              hintText: item.placeholder,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.border, width: 1))),
          controller: item.controller,
          obscureText: item.obscureText,
        ),
      ],
    );
  }
}

class CustomFormItem {
  final String title;
  final String placeholder;
  final bool canBeEmpty;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool obscureText;
  final void Function()? onTap;

  const CustomFormItem(
      {required this.title,
      this.placeholder = '',
      this.canBeEmpty = true,
      this.validator,
      this.onTap,
      required this.controller,
      this.obscureText = false});
}

class SelectionInputItem {
  final String value;
  final String text;
  const SelectionInputItem({required this.value, required this.text});
}

class SelectionInputField extends StatelessWidget {
  final List<SelectionInputItem> selections;
  final int? selectedIndex;
  final String? placeholder;
  final String? title;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  const SelectionInputField(
      {required this.selections,
      this.title,
      this.placeholder,
      this.selectedIndex,
      this.validator,
      this.onChanged});
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: validator,
      builder: (FormFieldState<String> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title != null
                ? Text(
                    title!,
                    style: TextStyles.label,
                  )
                : SizedBox.shrink(),
            SizedBox(
              height: 44,
              child: InputDecorator(
                decoration: InputDecoration(
                  errorStyle:
                      TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  hintText: placeholder,
                ),
                isEmpty: selectedIndex == null,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedIndex != null
                        ? selections[selectedIndex!].value
                        : null,
                    isDense: true,
                    onChanged: onChanged,
                    items: selections.map((item) {
                      return DropdownMenuItem<String>(
                        value: item.value,
                        child: Text(
                          item.text,
                          style: TextStyles.value,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
