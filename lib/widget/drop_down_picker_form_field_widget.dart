import 'package:flutter/material.dart';

class DropDownPickerFormFieldWidget extends StatelessWidget {
  const DropDownPickerFormFieldWidget({
    this.labelText,
    this.menuOptions,
    this.selectedOption,
    this.onChanged,
    this.validator,
    this.iconPrefix,
  });
  final String labelText;
  final List menuOptions;
  final String selectedOption;
  final void Function(String) onChanged;
  final String Function(String) validator;
  final IconData iconPrefix;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16),
      child: DropdownButtonFormField<String>(
          validator: validator,
          style: TextStyle(fontSize: 16),
          decoration: InputDecoration(
            labelText: labelText,
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            prefixIcon: Icon(iconPrefix),
            // fillColor: Colors.white,
            filled: true,
          ),
          items: menuOptions
              .map(
                (data) => DropdownMenuItem<String>(
                  value: data,
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Text(data)),
                    ],
                  ),
                ),
              )
              .toList(),
          value: selectedOption,
          isExpanded: true,
          onChanged: onChanged),
    );
  }
}
