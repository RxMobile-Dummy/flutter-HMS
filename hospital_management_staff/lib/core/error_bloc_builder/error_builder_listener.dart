
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management_staff/core/strings/strings.dart';
import 'package:hospital_management_staff/feature/profile/presentation/bloc/profile_state.dart';

import '../../custom/progress_bar.dart';
import '../../utils/colors.dart';
import '../../utils/device_file.dart';
import '../../utils/style.dart';
import '../base/base_bloc.dart';

class ErrorBlocListener<b extends Bloc<BaseEvent, BaseState>>
    extends BlocListener<b, BaseState> {
  ErrorBlocListener({Key? key,Widget? child,dynamic bloc,dynamic callback})
      : super(
      key: key,
      child: child,
      bloc: bloc,
      listener: (context, state) async {
        if (state is StateErrorGeneral) {
          ProgressDialog.hideLoadingDialog(context);
          showDialogForError(
            context: context,
            errorMessage: state.message,
            callBackFunction: callback,
          );
        }else  if(state is UpdateProfileState) {
          ProgressDialog.hideLoadingDialog(context);
          return Navigator.of(context).pop();
        } else if (state is StateOnSuccess) {
          ProgressDialog.hideLoadingDialog(context);
        }
      });
}

showDialogForError({required BuildContext context, String? errorMessage,dynamic callBackFunction}){
  return showDialog(
    context: context,
    builder: (ctx) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child:  AlertDialog(
        content:  Container(
          child: Text(
            errorMessage!,
            softWrap: true,
            overflow: TextOverflow.fade,
            style:  CustomTextStyle.styleMedium.copyWith(
                fontSize: DeviceUtil.isTablet ? 18 : 14
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Future.delayed(Duration.zero, () {
                Navigator.of(context).pop();
              });
            },
            child: Text(
              Strings.kYes,
              style: CustomTextStyle.styleSemiBold
                  .copyWith(color: CustomColors.colorDarkBlue, fontSize:
              DeviceUtil.isTablet ? 18 : 16),),
          ),
        ],
      ),
    ),
  );
}