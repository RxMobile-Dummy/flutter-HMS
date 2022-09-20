import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/colors.dart';
import '../utils/device_file.dart';
import '../utils/style.dart';

class DatePicker extends StatefulWidget {
  TextEditingController dateController = TextEditingController();
  String lableText = "";
  String errorMessage = "";
  DateTime firstDate;
  DateTime lastDate;
   DatePicker({Key? key,
     required this.dateController,
      this.errorMessage = "",
     required this.firstDate,
     required this.lastDate,
   required this.lableText}) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5,),
        Container(
            padding: const EdgeInsets.only(top: 16),
            child: Center(
                child: TextFormField(
                  controller: widget.dateController,
                  style: CustomTextStyle.styleSemiBold.copyWith(
                      fontSize: DeviceUtil.isTablet ? 16 : 14
                  ),
                  decoration:  InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(width: 1, color: CustomColors.colorDarkBlue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(width: 1, color: CustomColors.colorDarkBlue),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 7,vertical: 1),
                    suffixIcon: const Icon(Icons.calendar_today,
                      color: CustomColors.colorDarkBlue,),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(width: 1, color: CustomColors.colorDarkBlue),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(width: 1, color: CustomColors.colorDarkBlue),
                    ),
                    labelText: widget.lableText,
                    hintStyle: CustomTextStyle.styleSemiBold.copyWith(
                        fontSize: DeviceUtil.isTablet ? 16 : 14
                    ),
                    labelStyle: CustomTextStyle.styleSemiBold.copyWith(
                        fontSize: DeviceUtil.isTablet ? 16 : 14
                    ),
                  ),
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value == "") {
                      return widget.errorMessage;
                    }
                    return null;
                  },
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        builder: (BuildContext context, Widget ?child) {
                          return Theme(
                            data: ThemeData(
                              primarySwatch: Colors.grey,
                              splashColor: Colors.black,
                              textTheme: const TextTheme(
                                subtitle1: TextStyle(color: Colors.black),
                                button: TextStyle(color: Colors.black),
                              ),
                              accentColor: Colors.black,
                              colorScheme:  const ColorScheme.light(
                                  primary: CustomColors.colorDarkBlue,
                                  primaryVariant: Colors.black,
                                  secondaryVariant: Colors.black,
                                  onSecondary: Colors.black,
                                  onPrimary: Colors.white,
                                  surface: Colors.black,
                                  onSurface: Colors.black,
                                  secondary: Colors.black),
                              dialogBackgroundColor: Colors.white,
                            ),
                            child: child ??const Text(""),
                          );
                        },
                        firstDate: widget.firstDate/*DateTime(1950)*/,
                        lastDate: widget.lastDate/*DateTime(2100)*/);

                    if (pickedDate != null) {
                      print(pickedDate);
                      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                      print(formattedDate);
                      setState(() {
                        widget.dateController.text =
                            formattedDate;
                      });
                    } else {}
                  },
                ))),
        const SizedBox(height: 10,),
      ],
    ));
  }
}
