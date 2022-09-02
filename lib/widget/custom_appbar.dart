import 'package:flutter/material.dart';
import 'package:hospital_management/utils/colors.dart';

import '../utils/device_file.dart';

class CustomAppBar extends StatelessWidget {
  String title;
  bool isBackPress = false;

  CustomAppBar({Key? key, required this.title, this.isBackPress = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.black12, spreadRadius: 5, blurRadius: 2)
      ]),
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Container(
        decoration: const BoxDecoration(
            color: CustomColors.colorDarkBlue,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isBackPress
                  ? InkWell(
                      child: Icon(
                        Icons.navigate_before,
                        size: DeviceUtil.isTablet ? 38 : 27,
                        color: Colors.white,
                      ),
                      onTap: () {
                        isBackPress ? Navigator.of(context).pop() : null;
                      },
                    )
                  : SizedBox(),
              Text(
                title,
                style: TextStyle(
                    fontSize: DeviceUtil.isTablet ? 25 : 17,
                    color: Colors.white),
              ),
              Icon(
                Icons.navigate_before,
                size: DeviceUtil.isTablet ? 38 : 27,
                color: Colors.transparent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
