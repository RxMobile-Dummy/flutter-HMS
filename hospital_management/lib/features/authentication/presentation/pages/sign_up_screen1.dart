import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hospital_management/core/common_keys/common_keys.dart';
import 'package:hospital_management/core/strings/strings.dart';
import 'package:hospital_management/widget/custom_appbar.dart';
import 'package:hospital_management/widget/drop_down.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/device_file.dart';
import '../../../../utils/style.dart';
import '../../../../widget/text_field.dart';

class SignUpScreen1 extends StatefulWidget {
  PageController pageController;
  Function nextClick;
  SignUpScreen1({Key? key,
    required this.nextClick,required this.pageController}) : super(key: key);

  @override
  _SignUpScreen1State createState() => _SignUpScreen1State();
}

class _SignUpScreen1State extends State<SignUpScreen1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  List<String> genderDropDown = [
    Strings.kSelectGender,
    Strings.kFemale,
    Strings.kMale,
    Strings.kOther
  ];
  List<String> bloodGroupDropDown = [
    Strings.kSelectBloodGroup,
    Strings.kOPositive,
    Strings.kONegative,
    Strings.kANegative,
    Strings.kAPositive,
    Strings.kBNegative,
    Strings.kBPositive,
    Strings.kABNegative,
    Strings.kABPositive,
  ];
  List<String> maritalList = [Strings.kSelectMaritalStatus,Strings.kYes , Strings.kNo];
  String? selectedGender;
  File? imageFile;
  List<String> smokingHabitList = [Strings.kYes, Strings.kNo];

  List<String> selectedAllergyList = [];
  var selectedRadioForSmoking;
  var selectedRadioForAlcohol;
  bool isPasswordShow = true;
  Map<String,dynamic> map = Map();

  @override
  void initState() {
    selectedRadioForSmoking = smokingHabitList[1];
    selectedRadioForAlcohol = smokingHabitList[1];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(selectedRadioForSmoking);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 100),
        child: CustomAppBar(title: Strings.kRegisterPatient, isBackPress: true),
      ),
      body: Form(
        key: _formKey,
        child: buildWidget(),
      ),
    );
  }

  buildWidget() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30,),
              CustomTextField(
                key: const Key(Strings.kFirstNameKey),
                label: Strings.kFirstNameLabel,
                hint: Strings.kFirstNameHint,
                errorMessage: Strings.kFirstNameErrorMessage,
                textEditingController: firstNameController,
              ),
              const SizedBox(height: 15,),
              CustomTextField(
                key: const Key(Strings.kLastNameKey),
                label: Strings.kLastNameLabel,
                hint: Strings.kLastNameHint,
                errorMessage: Strings.kLastNameErrorMessage,
                textEditingController: lastNameController,
              ),
              const SizedBox(height: 15,),
              CustomTextField(
                key: const Key(Strings.kMobileKey),
                label: Strings.kMobileLabel,
                hint: Strings.kMobileHint,
                errorMessage: Strings.kMobileErrorMessage,
                isMobile: true,
                textInputType: TextInputType.phone,
                textEditingController: mobileNumberController,
              ),
              const SizedBox(height: 15,),
              CustomTextField(
                key: const Key(Strings.kEmailKey),
                label: Strings.kEmail,
                hint: Strings.kEmailHint,
                errorMessage: Strings.kEmailErrorMessage,
                isEmail: true,
                textInputType: TextInputType.emailAddress,
                textEditingController: emailController,
              ),
              const SizedBox(height: 15,),
              CustomTextField(
                key: const Key(Strings.kPasswordKey),
                label: Strings.kPasswordLabel,
                hint: Strings.kPasswordHint,
                isObscureText: isPasswordShow,
                errorMessage: Strings.kPasswordErrorMessage,
                icon: IconButton(
                    icon: Icon(
                      isPasswordShow
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordShow = !isPasswordShow;
                      });
                    }),
                textEditingController: passwordController,
              ),
              const SizedBox(height: 15,),
              DropDown(
                dropDownList: genderDropDown,
                selectedValue: genderDropDown[0],
                label: Strings.kSelectGenderLabel,
                controller: genderController,
                errorMessage: Strings.kSelectGenderErrorMessage,
              ),
              const SizedBox(height: 20,),
             DropDown(
                dropDownList: bloodGroupDropDown,
                selectedValue: bloodGroupDropDown[0],
                controller: bloodGroupController,
                errorMessage: Strings.kSelectBloodGroupErrorMessage,
                label: Strings.kBloodGroupLabel,
              ),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                   TextButton(
                       child:  Text(Strings.kNext,style: CustomTextStyle.styleBold
                           .copyWith(fontSize: DeviceUtil.isTablet ? 16 : 14, color: CustomColors.colorDarkBlue),),
                       onPressed: ()async {
                         FocusScope.of(context).unfocus();
                         if(_formKey.currentState!.validate()){
                           if(genderController.text == ""){
                             Fluttertoast.showToast(
                                 msg: Strings.kSelectGenderErrorMessage,
                                 toastLength: Toast.LENGTH_LONG,
                                 fontSize: DeviceUtil.isTablet ? 20 : 12,
                                 backgroundColor: CustomColors.colorDarkBlue,
                                 textColor: Colors.white
                             );
                           }else if(bloodGroupController.text == ""){
                             Fluttertoast.showToast(
                                 msg: Strings.kSelectBloodGroupErrorMessage,
                                 toastLength: Toast.LENGTH_LONG,
                                 fontSize: DeviceUtil.isTablet ? 20 : 12,
                                 backgroundColor: CustomColors.colorDarkBlue,
                                 textColor: Colors.white
                             );
                           }else{
                             _formKey.currentState?.save();
                             function();
                             widget.pageController.nextPage(
                                 duration: Duration(seconds: 1), curve: Curves.ease);
                           }
                         }
                       },
                     ),
                ],
              )
            ],
          ),
        ));
  }


   function(){
    map[CommonKeys.K_First_Name] = firstNameController.text;
    map[CommonKeys.K_Last_Name] = lastNameController.text;
    map[CommonKeys.K_Contact_Number] = "+91${mobileNumberController.text}";
    map[CommonKeys.K_Password] = passwordController.text;
    map[CommonKeys.K_Email] = emailController.text;
    map[CommonKeys.K_Gender] = genderController.text;
    map[CommonKeys.K_Blood_Group] = bloodGroupController.text;
    print(map);
    return widget.nextClick(map);
  }


  border({color: Colors.grey}) {
    return UnderlineInputBorder(borderSide: BorderSide(color: color, width: 1));
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
