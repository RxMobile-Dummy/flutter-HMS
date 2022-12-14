import 'package:flutter/material.dart';
import 'package:hospital_management_doctor/core/strings/strings.dart';

import '../utils/device_file.dart';

class ProgressDialog {
  static GlobalKey<State> keyLoader = new GlobalKey<State>();
  static bool isDialogVisible = false;


  static Future<void> showLoadingDialog(BuildContext context) async {
    isDialogVisible = true;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            backgroundColor: (Theme.of(context).brightness == Brightness.dark)? Colors.black :  Colors.white,
            child: Padding(
              padding:  EdgeInsets.symmetric(vertical: DeviceUtil.isTablet ? 20 : 10,horizontal: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children:  [
                  const CircularProgressIndicator(
                    color: Colors.deepOrange,
                  ),
                  SizedBox(
                    height: DeviceUtil.isTablet ? 15 : 10,
                  ),
                  Text(
                    Strings.kLoading,
                    style:
                    TextStyle(color: (Theme.of(context).brightness == Brightness.dark)? Colors.white :  Colors.black,
                        fontSize: DeviceUtil.isTablet ? 20 : 15,fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          );
        });

    await Future.delayed(const Duration(seconds: 3));
  }

  static hideLoadingDialog(BuildContext context) {
    if (isDialogVisible) {
      if (context != null)
        Navigator.of(context, rootNavigator: false).pop(); //close the dialoge
      else {
        Navigator.of(keyLoader.currentContext!, rootNavigator: false)
            .pop();
      }
    }
    isDialogVisible = false;
  }
}
