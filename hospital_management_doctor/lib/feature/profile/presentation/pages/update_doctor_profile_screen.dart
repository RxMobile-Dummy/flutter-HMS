import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hospital_management_doctor/core/base/base_bloc.dart';
import 'package:hospital_management_doctor/core/error_bloc_builder/error_builder_listener.dart';
import 'package:hospital_management_doctor/core/strings/strings.dart';
import 'package:hospital_management_doctor/custom/progress_bar.dart';
import 'package:hospital_management_doctor/feature/profile/data/model/get_profile_model.dart';
import 'package:hospital_management_doctor/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:hospital_management_doctor/feature/profile/presentation/bloc/profile_event.dart';
import 'package:hospital_management_doctor/feature/profile/presentation/bloc/profile_state.dart';
import 'package:hospital_management_doctor/utils/colors.dart';
import 'package:hospital_management_doctor/utils/device_file.dart';
import 'package:hospital_management_doctor/utils/style.dart';
import 'package:hospital_management_doctor/widget/custom_appbar.dart';
import 'package:hospital_management_doctor/widget/custom_button.dart';
import 'package:hospital_management_doctor/widget/date_picker.dart';
import 'package:hospital_management_doctor/widget/drop_down.dart';
import 'package:hospital_management_doctor/widget/text_field.dart';
import 'package:image_picker/image_picker.dart';

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
  TextEditingController nextAvailabilityController = TextEditingController();
  TextEditingController specialistFieldController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController clinicFeesController = TextEditingController();
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
  List<String> timeSlotDropDown = [
    "-- Select time slot --",
    "9:00 AM to 12:00 PM",
    "4:00 PM to 7:30 PM"
  ];
  List<String> departmentDropDown = [
    " -- Select department -- ",
    "Gynecologist",
    "Pediatrician",
    "Dermatologist",
    "Pathology",
    "Physiatrists",
    "Radiologists",
    "Cardiologists",
    "Anesthesiologists",
    "Endocrinologists",
    "Hematologists",
    "Gastroenterologists",
    "Neurologist"
  ];
  var doctorId;



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
    nextAvailabilityController.text = widget.getProfileModel.data?.nextAvailableAt ?? timeSlotDropDown[0];
    specialistFieldController.text = widget.getProfileModel.data?.specialistField ?? departmentDropDown[0];
    educationController.text = widget.getProfileModel.data?.education ?? "";
    aboutController.text = widget.getProfileModel.data?.about ?? "";
    clinicFeesController.text = widget.getProfileModel.data?.inClinicAppointmentFees ?? "";
    doctorId = widget.getProfileModel.data?.id.toString() ?? "";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 100),
        child: CustomAppBar(title: Strings.kUpdateDoctorProfile, isBackPress: true),
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
                            Strings.kPersonImage,
                          )
                              : imageFile.toString().contains(Strings.kDoctorImageStoredPath)
                              ? NetworkImage(
                            "${Strings.baseUrl}${imageFile?.path}",
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
              DropDown(
                controller: nextAvailabilityController,
                dropDownList: timeSlotDropDown,
                selectedValue:  nextAvailabilityController.text,
                label: Strings.kSelectAvailabilityLabel,
                errorMessage: Strings.kSelectAvailabilityErrorMessage,
              ),
              const SizedBox(height: 10,),
              DropDown(
                controller: specialistFieldController,
                dropDownList: departmentDropDown,
                selectedValue:  specialistFieldController.text.isNotEmpty ? specialistFieldController.text : departmentDropDown[0],
                label: Strings.kSpecialistField,
                errorMessage: Strings.kSpecialistField,
              ),
              const SizedBox(height: 10,),
              CustomTextField(
                key: const Key(Strings.kEducationKey),
                label: Strings.kEducationLabel,
                hint: Strings.kEducationHint,
                errorMessage: Strings.kEducationErrorMessage,
                textEditingController: educationController,
              ),
              const SizedBox(height: 10,),
              CustomTextField(
                key: const Key(Strings.kAboutKey),
                label: Strings.kAbout,
                hint: Strings.kAboutHint,
                minLines: 5,
                errorMessage: Strings.kAboutErrorMessage,
                textEditingController: aboutController,
              ),
              const SizedBox(height: 10,),
              CustomTextField(
                key: const Key(Strings.kClinicFeesKey),
                label: Strings.kClinicFeesLabel,
                hint: Strings.kClinicFeesHint,
                errorMessage: Strings.kClinicFeesErrorMessage,
                textEditingController: clinicFeesController,
              ),
              Button(
                Strings.kUpdateProfile,
                onPress: () {
                  FocusScope.of(context).unfocus();
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    _updateProfile(
                        profilePic: (imageFile!.path.isNotEmpty && !imageFile!.path.contains('doctor/app/doctor_images')) ? imageFile!.path : "",
                       yearOfExperience: yearOfExperienceController.text,
                      rating: "",
                      nextAvailableAt: nextAvailabilityController.text,
                      fees: clinicFeesController.text,
                      education: educationController.text,
                      dateOfBirth: dateController.text,
                       bloodGroup: bloodGroupController.text,
                      about: aboutController.text,
                      email: emailController.text,
                      gender: genderController.text,
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      mobileNumber: "+91${mobileNumberController.text}",
                      doctorId: doctorId,
                      hospitalId: "",
                      specialistField: specialistFieldController.text
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
    String? doctorId,firstName,lastName,email,mobileNumber,profilePic,gender,dateOfBirth,
    bloodGroup,yearOfExperience,nextAvailableAt,specialistField,about,education,hospitalId,fees,rating
  }) {
    return Future.delayed(const Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<ProfileBloc>(context).add(
          UpdateProfileEvent(
          specialistField: specialistField,
            hospitalId: hospitalId,
            doctorId: doctorId,
            mobileNumber: mobileNumber,
            lastName: lastName,
            firstName: firstName,
            gender: gender,
            email: email,
            profilePic: profilePic,
            about: about,
            bloodGroup: bloodGroup,
            dateOfBirth: dateOfBirth,
            education: education,
            fees: fees,
            nextAvailableAt: nextAvailableAt,
            rating: rating,
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
