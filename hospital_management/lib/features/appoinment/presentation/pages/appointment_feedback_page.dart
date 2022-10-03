import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_management/core/assets/images_name.dart';
import 'package:hospital_management/core/strings/strings.dart';
import 'package:hospital_management/features/feedback/presentation/bloc/feedback_bloc.dart';
import 'package:hospital_management/features/feedback/presentation/bloc/feedback_event.dart';
import 'package:hospital_management/features/feedback/presentation/bloc/feedback_state.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../core/error_bloc_builder/error_builder_listener.dart';
import '../../../../custom/progress_bar.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/device_file.dart';
import '../../../../utils/style.dart';
import '../../../../widget/text_field_with_border.dart';

class AppointmentFeedbackPage extends StatefulWidget {
  String appointmentId,staffId,patientId,hospitalId,doctorId;
   AppointmentFeedbackPage({
     Key? key,
     required this.appointmentId,
     required this.doctorId,
   required this.hospitalId,
   required this.patientId,
   required this.staffId}) : super(key: key);

  @override
  _AppointmentFeedbackPageState createState() =>
      _AppointmentFeedbackPageState();
}

class _AppointmentFeedbackPageState extends State<AppointmentFeedbackPage> {
  TextEditingController commentController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? ratings;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ErrorBlocListener<FeedbackBloc>(
        bloc: BlocProvider.of<FeedbackBloc>(context),
        // callback:  _loginUser(userName.text,tiePassword.text),
        child:  BlocBuilder<FeedbackBloc, BaseState>(builder: (context, state)  {
          /*if(state is SendDoctorFeedbackState){
            ProgressDialog.hideLoadingDialog(context);
              Navigator.of(context).pop();
          }*/
          return  Form(
            key: _formKey,
            child: buildWidget(),
          );
        }),
      ),
    );
  }

  buildWidget() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          topBar(),
          feedbackForm(),
        ],
      ),
    );
  }

  feedbackForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.kComment,
              style: TextStyle(
                  fontSize: DeviceUtil.isTablet ? 18 :16,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500),
            ),
             SizedBox(height: DeviceUtil.isTablet ? 15 :10,),
            CustomTextFieldWithBorder(
              key: const Key(Strings.kCommentKey),
              label: Strings.kComment,
              hint: Strings.kCommentHint,
              borderRadius: 10.0,
              maxLines: 10,
              minLines: 10,
              errorMessage: Strings.kCommentErrorMessage,
              textEditingController: commentController,
            ),
            const SizedBox(height: 20,),
            Text(
              Strings.kRatings,
              style: TextStyle(
                  fontSize: DeviceUtil.isTablet ? 18 : 16,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10,),
            RatingBar(
              initialRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 28,
              ratingWidget: RatingWidget(
                full: const Icon(
                  Icons.star,
                  color: Colors.orangeAccent,
                ),
                half: const Icon(
                  Icons.star_half,
                  color: Colors.orangeAccent,
                ),
                empty: const Icon(
                  Icons.star_border,
                  color: Colors.orangeAccent,
                ),
              ),
              itemPadding: const EdgeInsets.only(right: 8.0),
              onRatingUpdate: (rating) {
                ratings = rating.toString();
                print(rating);
              },
            ),
            const SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      _formKey.currentState?.save();
                      FocusScope.of(context).unfocus();
                      _sendFeedback(
                        ratings: ratings,
                        comment: commentController.text,
                        doctorId: widget.doctorId,
                        hospitalId: widget.hospitalId,
                        patientId: widget.patientId,
                        staffId: widget.staffId,
                      );
                    }else{
                      FocusScope.of(context).unfocus();
                      Fluttertoast.cancel();
                      Fluttertoast.showToast(
                          msg: Strings.kFillAllDetails,
                          toastLength: Toast.LENGTH_LONG,
                          fontSize: DeviceUtil.isTablet ? 20 : 12,
                          backgroundColor: CustomColors.colorDarkBlue,
                          textColor: Colors.white
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: CustomColors.colorDarkBlue,
                    shape: StadiumBorder(),
                  ),
                  child:  Text(
                    Strings.kSendFeedback,
                    style: CustomTextStyle.styleSemiBold.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  topBar() {
    return Container(
        height: MediaQuery.of(context).size.height / 5,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          /*image: DecorationImage(
                  image: AssetImage("assets/images/doctors.png",),
                )*/
        ),
        padding: EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: Colors.black,
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    Strings.kFeedback,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        //fontFamily: 'Open Sans',
                        fontSize: 22,
                        color: Colors.black),
                  )
                ],
              ),
            ),
            Image.asset(
              ImagesName.kAppointmentFeedback,
            ),
          ],
        ));
  }

  Future<String> _sendFeedback({String? patientId,doctorId,staffId,hospitalId,ratings,comment}) {
    return Future.delayed(const Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<FeedbackBloc>(context).add(
          SendDoctorFeedbackEvent(
           staffId: staffId,
            patientId: patientId,
            hospitalId: hospitalId,
            doctorId: doctorId,
            comment: comment,
            ratings: ratings
          ));
      return "";
    });
  }
}
