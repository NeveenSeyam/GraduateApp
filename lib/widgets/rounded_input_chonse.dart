import 'package:flutter/material.dart';
import 'package:hogo_app/widgets/text_field_container.dart';
import 'package:sizer/sizer.dart';

import '../utils/theme/app_colors.dart';

class RoundedInputChoese extends StatefulWidget {
  final String hintText;
  double? height;
  double? width;
  Color? color;
  List<String>? list;

  final ValueChanged<String> onChanged;

  RoundedInputChoese({
    required this.hintText,
    required this.onChanged,
    this.height,
    this.list,
    this.width,
    this.color,
  });

  @override
  State<RoundedInputChoese> createState() => _RoundedInputChoeseState();
}

class _RoundedInputChoeseState extends State<RoundedInputChoese> {
  var dropValue = null;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      height: widget.height,
      width: widget.width,
      color: widget.color,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(
            widget.hintText,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 16.0,
            ),
          ),
          value: dropValue,
          onChanged: (value) {
            setState(() {
              dropValue = value;
            });
          },
          items: widget.list?.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList() ??
              <String>[
                'NY, NY city',
                'NY, NY city 2',
                'NY, NY city 3',
                'NY, NY city 4'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
        ),
      ),
    );
  }
}
