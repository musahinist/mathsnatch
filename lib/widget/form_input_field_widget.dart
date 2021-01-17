import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/*
FormInputFieldWithIcon(
                controller: _email,
                iconPrefix: Icons.link,
                labelText: 'Post URL',
                validator: Validator.notEmpty,
                keyboardType: TextInputType.multiline,
                minLines: 3,
                onChanged: (value) => print('changed'),
                onSaved: (value) => print('implement me'),
              ),
*/

class FormInputFieldWidget extends StatelessWidget {
  const FormInputFieldWidget({
    this.controller,
    this.iconPrefix,
    this.labelText,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.minLines = 1,
    this.maxLines,
    this.onChanged,
    this.onSaved,
    this.onTap,
    this.readOnly = false,
    this.textCapitalization,
    this.next,
    this.fieldFocusNode,
    this.maxLenght,
  });

  final TextEditingController controller;
  final IconData iconPrefix;
  final String labelText;
  final String Function(String) validator;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  final TextInputAction next;
  final bool obscureText;
  final bool readOnly;
  final int minLines;
  final int maxLines;
  final int maxLenght;
  final void Function(String) onChanged;
  final void Function(String) onSaved;
  final void Function() onTap;
  final FocusNode fieldFocusNode;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16),
      child: TextFormField(
        focusNode: fieldFocusNode,
        style: TextStyle(fontSize: 16),
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          // fillColor: Colors.black38,
          filled: true,
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
          prefixIcon: Icon(iconPrefix),
          labelText: labelText,
        ),
        controller: controller,
        onSaved: onSaved,
        autocorrect: false,
        enableSuggestions: false,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        onChanged: onChanged,
        textInputAction: TextInputAction.next,
        onTap: onTap,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLength: maxLenght ?? null,
        maxLines: maxLines,
        minLines: minLines,
        validator: validator,
        readOnly: readOnly,
      ),
    );
  }
}
