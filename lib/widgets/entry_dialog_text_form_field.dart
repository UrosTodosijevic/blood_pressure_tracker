import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**
 * If we want even more customizations for fields (e.g range of possible
 * values for every field) we could pass validator function to constructor,
 * or different [TextInputFormatter]s.
 */

/// Custom [TextFormField] widget.
class EntryDialogTextFormField extends TextFormField {
  final TextEditingController controller;
  final String labelText;
  final BuildContext context;

  EntryDialogTextFormField({
    Key key,
    @required this.controller,
    @required this.labelText,
    @required this.context,
  }) : super(
          key: key,
          controller: controller,
          cursorWidth: 3.0,
          cursorColor: Theme.of(context).accentColor,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(3),
            FilteringTextInputFormatter.digitsOnly,
          ],
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
              //color: Colors.black45,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            isDense: true,
          ),
          autovalidateMode: AutovalidateMode.disabled,
          validator: (String value) {
            if (value.isEmpty) {
              return 'Value is required';
            }
            return null;
          },
        );
}
