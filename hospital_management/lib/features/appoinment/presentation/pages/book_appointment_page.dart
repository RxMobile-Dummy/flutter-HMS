import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hospital_management/core/common_keys/common_keys.dart';
import 'package:hospital_management/features/appoinment/presentation/bloc/appointment_bloc.dart';
import 'package:hospital_management/features/appoinment/presentation/bloc/appointment_event.dart';
import 'package:hospital_management/features/appoinment/presentation/bloc/appointment_state.dart';
import 'package:hospital_management/widget/drop_down.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../core/error_bloc_builder/error_builder_listener.dart';
import '../../../../core/strings/strings.dart';
import '../../../../custom/progress_bar.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/device_file.dart';
import '../../../../utils/style.dart';
import '../../../../widget/custom_appbar.dart';
import '../../../../widget/date_picker.dart';
import '../../../../widget/text_field.dart';

class BookAppointmentPage extends StatefulWidget {
  String doctorId;
   BookAppointmentPage({Key? key,required this.doctorId}) : super(key: key);

  @override
  _BookAppointmentPageState createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController timeSlotController = TextEditingController();
  TextEditingController appointmentDateController = TextEditingController();
  TextEditingController diseaseController = TextEditingController();
  File? fileForProfilePic;
  File? fileForReport;
  List<String> timeSlotDropDown = [
    Strings.kSelectTimeSlot,
    Strings.kTimeSlot1,
    Strings.kTimeSlot2
  ];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

@override
  void initState() {
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var patientId = prefs.getString(CommonKeys.K_Id);
  });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 100),
        child: CustomAppBar(title: Strings.kBookAppointment,isBackPress: true),
      ),
      body: ErrorBlocListener<AppointmentBloc>(
        bloc: BlocProvider.of<AppointmentBloc>(context),
        // callback:  _loginUser(userName.text,tiePassword.text),
        child:  BlocBuilder<AppointmentBloc, BaseState>(builder: (context, state)  {
         /* if(state is BookAppointmentState){
            ProgressDialog.hideLoadingDialog(context);
            Future.delayed(Duration.zero, () {
              Navigator.of(context).pop();
            });
          }*/
          return  Form(
            key: _formKey,
            child: buildWidget(),
          );
        }),
      ),
    );
  }

  buildWidget(){
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  //fit: StackFit.expand,
                  children: [
                    GestureDetector(
                      child: CircleAvatar(
                        radius: DeviceUtil.isTablet ? 75 : 48,
                        backgroundColor: Colors.transparent,
                        backgroundImage: (fileForProfilePic == null || fileForProfilePic == "")
                            ? const AssetImage(
                          Strings.kPersonImage,
                        )
                            : fileForProfilePic.toString().contains(CommonKeys.K_Patient_Profile_Pic_Files)
                            ? NetworkImage(
                          "${fileForProfilePic?.path}",
                        )
                            : FileImage(
                          fileForProfilePic!,
                        ) as ImageProvider,
                      ),
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: Theme(
                                  data: ThemeData(
                                      bottomSheetTheme:
                                      const BottomSheetThemeData(
                                          backgroundColor: Colors.black,
                                          modalBackgroundColor:
                                          Colors.grey)),
                                  child: showSheetForImage()),
                            ));
                      },
                    ),
                    Positioned(
                      bottom: 3,
                      right: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 3,
                            color: Colors.white,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              50,
                            ),
                          ),
                          color: CustomColors.colorDarkBlue,
                          /*boxShadow: [
                              BoxShadow(
                                offset: Offset(2, 4),
                                color: Colors.transparent,
                                blurRadius: 3,
                              ),
                            ]*/
                        ),
                        child: InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.edit_outlined,
                              color: Colors.white,
                              size: DeviceUtil.isTablet ? 20 : 15,
                            ),
                          ),
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) => GestureDetector(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: Theme(
                                      data: ThemeData(
                                          bottomSheetTheme:
                                          const BottomSheetThemeData(
                                              backgroundColor:
                                              Colors.black,
                                              modalBackgroundColor:
                                              Colors.grey)),
                                      child: showSheetForImage()),
                                ));
                            print("OPEN");
                          },
                        ),
                      ),
                    ),
                  ],
                )),
            CustomTextField(
              key: const Key(Strings.kFirstNameKey),
              label: Strings.kFirstNameLabel,
              hint: Strings.kFirstNameHint,
              errorMessage: Strings.kFirstNameErrorMessage,
              textEditingController: firstNameController,
            ),
            CustomTextField(
              key: const Key(Strings.kLastNameKey),
              label: Strings.kLastNameLabel,
              hint: Strings.kLastNameHint,
              errorMessage: Strings.kLastNameErrorMessage,
              textEditingController: lastNameController,
            ),
            CustomTextField(
              key: const Key(Strings.kMobileKey),
              label: Strings.kMobileLabel,
              hint: Strings.kMobileHint,
              errorMessage: Strings.kMobileErrorMessage,
              isMobile: true,
              textInputType: TextInputType.phone,
              textEditingController: mobileNumberController,
            ),
            CustomTextField(
              key: const Key(Strings.kDiseaseKey),
              label: Strings.kDiseaseLabel,
              hint: Strings.kDiseaseHint,
              errorMessage: Strings.kDiseaseErrorMessage,
              textEditingController: diseaseController,
            ),
            DropDown(
                controller: timeSlotController,
                dropDownList: timeSlotDropDown,
                selectedValue: timeSlotDropDown[0],
                label: Strings.kSelectTimeSlotLabel,
              errorMessage: Strings.kSelectTimeSlotLabel,
            ),
            DatePicker(
                dateController: appointmentDateController,
                lableText: Strings.kAppointmentDate,
              firstDate: DateTime.now(),
              lastDate: DateTime(2024),
              errorMessage: Strings.kAppointmentDateErrorMessage,
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                fileForReport?.path != null
                    ? Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 2.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey.shade500,width: 2)
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5,vertical: 7),
                    child: Row(
                        children: [
                          Icon(Icons.picture_as_pdf_outlined,color: Colors.red),
                          SizedBox(width: 5,),
                          Flexible(child: Text(
                            fileForReport?.path.split('/').last ?? "",
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          ))
                        ],
                      ),
                    )
                )
                    : const SizedBox(),
                TextButton(
                  onPressed: (){
                    getFromGalleryForReport();
                  },
                  child:  Text(
                      Strings.kUploadFile,
                    style: CustomTextStyle.styleMedium.copyWith(color: CustomColors.colorDarkBlue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){
                        _formKey.currentState?.save();
                        FocusScope.of(context).unfocus();
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        var patientId = prefs.getString(CommonKeys.K_Id);
                        _bookAppointment(
                          doctorId: widget.doctorId ,
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                           appointmentDate: appointmentDateController.text,
                          bookingTime: getFormatedDate(DateTime.now().toString()),
                          fileData: (fileForReport?.path == null || fileForReport?.path == "") ? "" : fileForReport!.path,
                          hospitalId: "",
                          mobileNumber: "+91${mobileNumberController.text}",
                          patientId: patientId,
                          staffId: "",
                          statusId: "",
                          timeSlot: timeSlotController.text,
                          patientProfilePic: (fileForProfilePic?.path == null || fileForProfilePic?.path == "") ? "" : fileForProfilePic!.path,
                          disease: diseaseController.text
                        );
                      }else{
                        FocusScope.of(context).unfocus();
                        print(getFormatedDate(DateTime.now().toString()));
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
                      Strings.kBookAppointment,
                      style: CustomTextStyle.styleSemiBold.copyWith(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      )
    );
  }

  showSheetForImage() {
    return Material(
      child: Container(
        height: 150,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16), topLeft: Radius.circular(16)),
            color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.camera,
                    size: DeviceUtil.isTablet ? 35 : 27,
                  ),
                  onPressed: () {
                    Get.back();
                    getFromCamera();
                  },
                ),
                Text(
                  Strings.kCamera,
                  style: CustomTextStyle.styleBold,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 120),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.image_outlined,
                      size: DeviceUtil.isTablet ? 35 : 27,
                    ),
                    onPressed: () {
                      Get.back();
                      getFromGallery();
                    },
                  ),
                  Text(
                    Strings.kGallery,
                    style: CustomTextStyle.styleBold,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        fileForProfilePic = File(pickedFile.path);
        print(fileForProfilePic);
      });
    }
  }

  getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        fileForProfilePic = File(pickedFile.path);
        print(fileForProfilePic);
      });
    }
  }

  getFormatedDate(date) {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(date);
    var outputFormat = DateFormat('dd/MM/yyyy');
    print(outputFormat.format(inputDate));
    //date1 = outputFormat.format(inputDate).toString();
    return outputFormat.format(inputDate);
  }

  Future<String> _bookAppointment({String? firstName,lastName,bookingTime,doctorId,patientId,staffId,hospitalId,
    mobileNumber,timeSlot,statusId,appointmentDate,fileData,disease,patientProfilePic}) {
    return Future.delayed(const Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AppointmentBloc>(context).add(
          BookAppointmentEvent(
            timeSlot: timeSlot,
            statusId: statusId,
            staffId: staffId,
            patientId: patientId,
            mobileNumber: mobileNumber,
            hospitalId: hospitalId,
            fileData: fileData,
            bookingTime: bookingTime,
            appointmentDate: appointmentDate,
            lastName: lastName,
            firstName: firstName,
            doctorId: doctorId,
            disease: disease,
            patientProfilePic: patientProfilePic
          ));
      return "";
    });
  }

  getFromGalleryForReport() async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    /*PickedFile? pickedFile = await FilePiker(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800, 
    );*/
    if (pickedFile != null) {
      setState(() {
        fileForReport = File(pickedFile.files.first.path ?? "");
        print(fileForReport);
      });
    }
  }
}
