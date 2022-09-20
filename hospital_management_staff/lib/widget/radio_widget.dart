import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/device_file.dart';
import '../utils/style.dart';

class RadioWidget extends StatefulWidget {
  String label;
  var selectedRadio;
  List<String> radioList;
  TextEditingController controller = TextEditingController();
  RadioWidget({required this.label,required this.selectedRadio,required this.radioList,required this.controller});

  @override
  _RadioWidgetState createState() => _RadioWidgetState();
}

class _RadioWidgetState extends State<RadioWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
            child: Text(
              widget.label,
              style: CustomTextStyle.styleBold.copyWith(
                  fontSize: DeviceUtil.isTablet ? 16 : 14
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.all(0),
                    leading: Radio<String>(
                      value: widget.radioList[index],
                      groupValue: widget.selectedRadio,
                      activeColor: CustomColors.colorDarkBlue,
                      onChanged: (value) {
                        setState(() {
                          widget.selectedRadio = value!;
                          widget.controller.text = widget.selectedRadio.toString();
                        });
                      },
                    ),
                    title:  Text(
                      widget.radioList[index],
                    ),
                  );
                },
                itemCount: widget.radioList.length,
              ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
