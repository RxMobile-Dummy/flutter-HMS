import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hospital_management_staff/core/assets/images_name.dart';
import 'package:hospital_management_staff/core/base/base_bloc.dart';
import 'package:hospital_management_staff/core/common_keys/common_keys.dart';
import 'package:hospital_management_staff/core/error_bloc_builder/error_builder_listener.dart';
import 'package:hospital_management_staff/core/strings/strings.dart';
import 'package:hospital_management_staff/custom/progress_bar.dart';
import 'package:hospital_management_staff/feature/profile/data/model/get_profile_model.dart';
import 'package:hospital_management_staff/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:hospital_management_staff/feature/profile/presentation/bloc/profile_event.dart';
import 'package:hospital_management_staff/utils/colors.dart';
import 'package:hospital_management_staff/utils/style.dart';
import 'package:hospital_management_staff/widget/custom_appbar.dart';
import 'package:hospital_management_staff/widget/custom_button.dart';
import 'package:hospital_management_staff/widget/date_picker.dart';
import 'package:hospital_management_staff/widget/drop_down.dart';
import 'package:hospital_management_staff/widget/text_field.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../utils/device_file.dart';

class UpdateProfilePage extends StatefulWidget {
  GetProfileModel getProfileModel;
  UpdateProfilePage({Key? key,required this.getProfileModel}) : super(key: key);

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController yearOfExperienceController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  File? imageFile;
  List<String> genderDropDown = [
    "-- Select Gender --",
    "Female",
    "Male",
    "Other"
  ];
  List<String> bloodGroupDropDown = [
    "-- Select Blood Group --",
    "O+",
    "O-",
    "A-",
    "A+",
    "B-",
    "B+",
    "AB-",
    "AB+",
  ];
  var staffId;



  @override
  void initState() {
    imageFile = File(widget.getProfileModel.data?.profilePic ?? "");
    firstNameController.text = widget.getProfileModel.data?.firstName ?? "";
    lastNameController.text = widget.getProfileModel.data?.lastName ?? "";
    mobileNumberController.text = widget.getProfileModel.data?.contactNumber.toString().substring(3) ?? "";
    emailController.text = widget.getProfileModel.data?.email ?? "";
    genderController.text = widget.getProfileModel.data?.gender ?? genderDropDown[0];
    bloodGroupController.text = widget.getProfileModel.data?.bloodGroup ?? bloodGroupDropDown[0];
    dateController.text = widget.getProfileModel.data?.dateOfBirth ?? "";
    yearOfExperienceController.text = widget.getProfileModel.data?.yearsOfExperience ?? "";
    educationController.text = widget.getProfileModel.data?.education ?? "";
    staffId = widget.getProfileModel.data?.id.toString() ?? "";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 100),
        child: CustomAppBar(title: Strings.kUpdateStaffProfile, isBackPress: true),
      ),
      body:ErrorBlocListener<ProfileBloc>(
        bloc: BlocProvider.of<ProfileBloc>(context),
        child:  BlocBuilder<ProfileBloc, BaseState>(builder: (context, state)  {
          return  Form(
            key: _formKey,
            child: buildWidget(),
          );
        }),
      ),
    );
  }

  buildWidget() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      GestureDetector(
                        child: CircleAvatar(
                          radius: DeviceUtil.isTablet ? 75 : 48,
                          backgroundColor: Colors.transparent,
                          backgroundImage: (imageFile == null || imageFile == "")
                              ? const AssetImage(
                            ImagesName.kPersonImage,
                          )
                              : imageFile.toString().contains(Strings.kStaffImageStoredPath)
                              ? NetworkImage(
                            "${CommonKeys.baseUrl}${imageFile?.path}",
                          )
                              : FileImage(
                            imageFile!,
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
                            },
                          ),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 20,),
              CustomTextField(
                key: const Key(Strings.kFirstNameKey),
                label: Strings.kFirstNameLabel,
                hint: Strings.kFirstNameHint,
                errorMessage: Strings.kFirstNameErrorMessage,
                textEditingController: firstNameController,
              ),
              const SizedBox(height: 10,),
              CustomTextField(
                key: const Key(Strings.kLastNameKey),
                label: Strings.kLastNameLabel,
                hint: Strings.kLastNameHint,
                errorMessage: Strings.kLastNameErrorMessage,
                textEditingController: lastNameController,
              ),
              const SizedBox(height: 10,),
              CustomTextField(
                key: const Key(Strings.kMobileKey),
                label: Strings.kMobileLabel,
                hint: Strings.kMobileHint,
                errorMessage: Strings.kMobileHErrorMessage,
                isMobile: true,
                readOnly: true,
                textInputType: TextInputType.phone,
                textEditingController: mobileNumberController,
              ),
              const SizedBox(height: 10,),
              CustomTextField(
                key: const Key(Strings.kEmailKey),
                label: Strings.kEmail,
                hint: Strings.kEmailHint,
                errorMessage: Strings.kEmailErrorMessage,
                isEmail: true,
                readOnly: true,
                textInputType: TextInputType.emailAddress,
                textEditingController: emailController,
              ),
              const SizedBox(height: 10,),
              DropDown(
                dropDownList: genderDropDown,
                selectedValue: genderController.text,
                label: Strings.kGenderLabel,
                controller: genderController,
                errorMessage: Strings.kGenderErrorMessage,
              ),
              const SizedBox(height: 10,),
              DropDown(
                dropDownList: bloodGroupDropDown,
                selectedValue: bloodGroupController.text,
                controller: bloodGroupController,
                errorMessage: Strings.kBloodGroupErrorMessage,
                label: Strings.kBloodGroupLabel,
              ),
              DatePicker(
                dateController: dateController,
                lableText: Strings.kDateOfBirth,
                firstDate: DateTime(1950),
                lastDate: DateTime.now(),
              ),
              const SizedBox(height: 10,),
              CustomTextField(
                key: const Key(Strings.kYearOfExperienceKey),
                label: Strings.kYearOfExperienceLabel,
                hint: Strings.kYearOfExperienceHint,
                textEditingController: yearOfExperienceController,
              ),
              const SizedBox(height: 10,),
              CustomTextField(
                key: const Key(Strings.kEducationKey),
                label: Strings.kEducationLabel,
                hint: Strings.kEducationHint,
                errorMessage: Strings.kEducationErrorMessage,
                textEditingController: educationController,
              ),
              Button(
                Strings.kUpdateProfile,
                onPress: () {
                  FocusScope.of(context).unfocus();
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    _updateProfile(
                        profilePic: (imageFile!.path.isNotEmpty && !imageFile!.path.contains(Strings.kStaffImageStoredPath)) ? imageFile!.path : "",
                        yearOfExperience: yearOfExperienceController.text,
                        education: educationController.text,
                        dateOfBirth: dateController.text,
                        bloodGroup: bloodGroupController.text,
                        email: emailController.text,
                        gender: genderController.text,
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        contactNumber: "+91${mobileNumberController.text}",
                        staffId: staffId,
                        hospitalId: "",
                    );
                  } else {
                    Fluttertoast.cancel();
                    Fluttertoast.showToast(
                        msg: Strings.kPleaseFillAllDetails,
                        toastLength: Toast.LENGTH_LONG,
                        fontSize: DeviceUtil.isTablet ? 20 : 12,
                        backgroundColor: CustomColors.colorDarkBlue,
                        textColor: Colors.white
                    );
                  }
                },
              ),
            ],
          ),
        ));
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

  Future<String> _updateProfile({
    String? staffId,firstName,lastName,contactNumber,email,profilePic,gender,dateOfBirth, bloodGroup, yearOfExperience, education, hospitalId
  }) {
    return Future.delayed(const Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<ProfileBloc>(context).add(
          UpdateProfileEvent(
              hospitalId: hospitalId,
              staffId: staffId,
              contactNumber: contactNumber,
              lastName: lastName,
              firstName: firstName,
              gender: gender,
              email: email,
              profilePic: profilePic,
              bloodGroup: bloodGroup,
              dateOfBirth: dateOfBirth,
              education: education,
              yearOfExperience: yearOfExperience
          ));
      return "";
    });
  }

  getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        print(imageFile);
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
        imageFile = File(pickedFile.path);
        print(imageFile);
      });
    }
  }
}