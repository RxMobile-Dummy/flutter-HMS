import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/device_file.dart';
import '../utils/style.dart';

class DropDown extends StatefulWidget {
  List<String> dropDownList;
  String selectedValue;
  String label;
  String? errorMessage;
  TextEditingController controller;
   DropDown({Key? key,this.errorMessage,required this.controller,required this.dropDownList,required this.selectedValue,required this.label}) : super(key: key);

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
    child:Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: CustomTextStyle.styleBold.copyWith(
              fontSize: DeviceUtil.isTablet ? 16 : 14
          ),
        ),
        const SizedBox(height: 15,),
        DropdownButtonFormField(
          isExpanded: true,
          style: CustomTextStyle.styleSemiBold.copyWith(
              fontSize: DeviceUtil.isTablet ? 16 : 14
          ),
          decoration:  InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:  const BorderSide(width: 1, color: CustomColors.colorDarkBlue),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(width: 1, color: CustomColors.colorDarkBlue),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(width: 1, color: CustomColors.colorDarkBlue),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(width: 1, color: CustomColors.colorDarkBlue),
            ),
            hintStyle: CustomTextStyle.styleSemiBold.copyWith(
                fontSize: DeviceUtil.isTablet ? 16 : 14
            ),
            labelStyle: CustomTextStyle.styleSemiBold.copyWith(
                fontSize: DeviceUtil.isTablet ? 16 : 14
            ),
              errorStyle:CustomTextStyle.styleMedium
                  .copyWith(fontSize: 12, color: Colors.red),
            contentPadding: EdgeInsets.symmetric(horizontal: 7,vertical: 0)
          ),
          validator: (value) {
            if (value == null || value == "" || widget.controller.text == "" || widget.controller.text == widget.dropDownList[0]) {
              return widget.errorMessage;
            }
            return null;
          },
          borderRadius: BorderRadius.circular(5),
          hint:  Text(widget.label),
          value: widget.selectedValue,
         // isDense: true,
          onChanged: (String? newValue) {
              widget.controller.text = newValue ?? "";
              widget.selectedValue = newValue!;
          },
          items: widget.dropDownList.map((gender) {
            return DropdownMenuItem(
              value: gender,
              child: Text(gender),
            );
          }).toList(),
        ),
        const SizedBox(height: 10,),
      ],
    ));
  }
}
