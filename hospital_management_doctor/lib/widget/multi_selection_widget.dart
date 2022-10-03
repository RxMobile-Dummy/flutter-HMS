import 'package:flutter/material.dart';
import 'package:hospital_management_doctor/core/strings/strings.dart';

import '../utils/colors.dart';
import '../utils/device_file.dart';
import '../utils/style.dart';
import 'multi_select_chip.dart';

class MultiSelectionWidget extends StatefulWidget {
  TextEditingController controller = TextEditingController();
  List<String> displayList;
  String label;
  String? errorMessage = "";
  MultiSelectionWidget({
    required this.controller,
    required this.displayList,
    required this.label,
    this.errorMessage});

  @override
  _MultiSelectionWidgetState createState() => _MultiSelectionWidgetState();
}

class _MultiSelectionWidgetState extends State<MultiSelectionWidget> {
  List<String>  selectionList = [];
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.label,
                  style: CustomTextStyle.styleBold.copyWith(
                      fontSize: DeviceUtil.isTablet ? 16 : 14
                  ),
                ),
                InkWell(
                  child: Icon(Icons.add,size: DeviceUtil.isTablet ? 25 : 18,),
                  onTap: () => _showReportDialog(),
                )
              ],
            ),
            const SizedBox(height: 15,),
            TextFormField(
              controller: widget.controller,
              readOnly: true,
              maxLines: 5,
              style: CustomTextStyle.styleMedium.copyWith(
                  fontSize: DeviceUtil.isTablet ? 16 : 14
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return widget.errorMessage;
                }
                return null;
              },
              onTap: () => _showReportDialog(),
              decoration:  InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide:   const BorderSide(width: 1, color: CustomColors.colorDarkBlue),
                  ),
                  hintText: widget.label,
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
                  contentPadding: EdgeInsets.symmetric(horizontal: 7,vertical: 10)
              ),
            ),
          ],
        )
    );
  }
  _showReportDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(widget.label),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  MultiSelectChip(
                    widget.displayList,
                    onSelectionChanged: (selectedList) {
                      setState(() {
                        selectionList = selectedList;
                        widget.controller.text = selectionList.join(" , ");
                      });
                    },
                    maxSelection: widget.displayList.length,
                  )
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(Strings.kAdd),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }
}
