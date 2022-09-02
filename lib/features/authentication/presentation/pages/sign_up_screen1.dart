import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_management/features/authentication/presentation/bloc/authentication_event.dart';
import 'package:hospital_management/features/authentication/presentation/bloc/allergies_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hospital_management/widget/custom_appbar.dart';
import 'package:hospital_management/widget/drop_down.dart';
import 'package:hospital_management/widget/multi_selection_widget.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/device_file.dart';
import '../../../../utils/style.dart';
import '../../../../widget/date_picker.dart';
import '../../../../widget/multi_select_chip.dart';
import '../../../../widget/radio_widget.dart';
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
  List<String> maritalList = ["-- Select Marital Status --", "Yes", "No"];
  String? selectedGender;
  File? imageFile;
  List<String> allergyList = [
    "Drug Allergy",
    "Food Allergy",
    "Insect Allergy",
    "Latex Allergy",
    "Mold Allergy",
    "Pet Allergy",
    "Pollen Allergy"
  ];
  List<String> smokingHabitList = ["Yes", "No"];

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
        child: CustomAppBar(title: "Register Patient", isBackPress: true),
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
            /*  Center(
                  child: Stack(
                clipBehavior: Clip.none,
                //fit: StackFit.expand,
                children: [
                  GestureDetector(
                    child: CircleAvatar(
                      radius: DeviceUtil.isTablet ? 75 : 48,
                      backgroundColor: Colors.transparent,
                      backgroundImage: (imageFile == null || imageFile == "")
                          ? const AssetImage(
                              'assets/images/person_image.jpeg',
                            )
                          : imageFile.toString().contains("static")
                              ? NetworkImage(
                                  "${imageFile?.path}",
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
                      print("OPEN");
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
                        *//*boxShadow: [
                              BoxShadow(
                                offset: Offset(2, 4),
                                color: Colors.transparent,
                                blurRadius: 3,
                              ),
                            ]*//*
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
              )),*/
              CustomTextField(
                key: const Key("tefFirstname"),
                label: "First Name",
                hint: "Enter First Name",
                errorMessage: "Please Enter First name",
                textEditingController: firstNameController,
              ),
              CustomTextField(
                key: const Key("tefLastName"),
                label: "Last Name",
                hint: "Enter Last Name",
                errorMessage: "Please Enter Last name",
                textEditingController: lastNameController,
              ),
              CustomTextField(
                key: const Key("tefMobilenumber"),
                label: "Mobile number",
                hint: "Enter mobile number",
                errorMessage: "Please Enter mobile number",
                isMobile: true,
                textInputType: TextInputType.phone,
                textEditingController: mobileNumberController,
              ),
              CustomTextField(
                key: const Key("tefEmail"),
                label: "Email",
                hint: "Enter email",
                errorMessage: "Please Enter email",
                isEmail: true,
                textInputType: TextInputType.emailAddress,
                textEditingController: emailController,
              ),
              CustomTextField(
                key: const Key("tefPassword"),
                label: "Password",
                hint: "Enter password",
                isObscureText: isPasswordShow,
                errorMessage: "Please Enter password",
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
              DropDown(
                dropDownList: genderDropDown,
                selectedValue: genderDropDown[0],
                label: "Select Gender",
                controller: genderController,
                errorMessage: "Please select gender",
              ),
            /*  DatePicker(
                  dateController: dateController, lableText: "Date Of Birth"),*/
              DropDown(
                dropDownList: bloodGroupDropDown,
                selectedValue: bloodGroupDropDown[0],
                controller: bloodGroupController,
                errorMessage: "Please select Blood group",
                label: "Select Blood Group",
              ),
              /*DropDown(
                dropDownList: maritalList,
                selectedValue: maritalList[0],
                label: "Select Marital status",
              ),
              CustomTextField(
                key: const Key("tefHeight"),
                label: "Height",
                hint: "Enter Height",
                isEmail: true,
                textEditingController: heightController,
              ),
              CustomTextField(
                key: const Key("tefWeight"),
                label: "Weight",
                hint: "Enter Weight",
                isEmail: true,
                textEditingController: weightController,
              ),
              CustomTextField(
                key: const Key("tefEmergencynumber"),
                label: "Emergency Contact number",
                hint: "Enter Emergency Contact number",
                errorMessage: "Please Enter Emergency Contact number",
                isMobile: true,
                textInputType: TextInputType.phone,
                textEditingController: emergenyContactController,
              ),
              CustomTextField(
                key: const Key("tefCity"),
                label: "City",
                hint: "Enter City name",
                errorMessage: "Please Enter City name",
                textEditingController: cityContactController,
              ),
              MultiSelectionWidget(
                controller: allergyController,
                displayList: allergyList,
                label: "Select Allergy",
              ),
              RadioWidget(
                label: "Smoking Habit",
                selectedRadio: selectedRadioForSmoking,
                radioList: smokingHabitList,
                controller: smokingController,
              ),
              RadioWidget(
                label: "Alcohol Consumption",
                selectedRadio: selectedRadioForAlcohol,
                radioList: smokingHabitList,
                controller: alcoholController,
              ),
              CustomTextField(
                key: const Key("tefOccupation"),
                label: "Occupation",
                hint: "Enter your occupation",
                textEditingController: occupationController,
              ),*/
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                   TextButton(
                       child:  Text("NEXT >>",style: CustomTextStyle.styleBold
                           .copyWith(fontSize: 12, color: CustomColors.colorDarkBlue),),
                       onPressed: ()async {
                         FocusScope.of(context).unfocus();
                         if(_formKey.currentState!.validate()){
                           if(genderController.text == ""){
                             Fluttertoast.showToast(
                                 msg: "Please select gender.",
                                 toastLength: Toast.LENGTH_LONG,
                                 fontSize: DeviceUtil.isTablet ? 20 : 12,
                                 backgroundColor: CustomColors.colorDarkBlue,
                                 textColor: Colors.white
                             );
                           }else if(bloodGroupController.text == ""){
                             Fluttertoast.showToast(
                                 msg: "Please select blood group.",
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
                         }/*else{
                           Fluttertoast.cancel();
                           Fluttertoast.showToast(
                               msg: "Please fill all the details.",
                               toastLength: Toast.LENGTH_LONG,
                               fontSize: DeviceUtil.isTablet ? 20 : 12,
                               backgroundColor: CustomColors.colorBlue,
                               textColor: Colors.white
                           );
                         }*/
                       },
                     ),
                ],
              )
            ],
          ),
        ));
  }


   function(){
    map["first_name"] = firstNameController.text;
    map["last_name"] = lastNameController.text;
    map["contact_number"] = "+91${mobileNumberController.text}";
    map["password"] = passwordController.text;
    map["email"] = emailController.text;
    map["gender"] = genderController.text;
    map["blood_group"] = bloodGroupController.text;
    print(map);
    return widget.nextClick(map);
  }


  border({color: Colors.grey}) {
    return UnderlineInputBorder(borderSide: BorderSide(color: color, width: 1));
  }

  /* _showReportDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          //Here we will build the content of the dialog
          return AlertDialog(
            title: Text("Select Allergies"),
            content: MultiSelectChip(
              allergyList,
              onSelectionChanged: (selectedList) {
                setState(() {
                  selectedAllergyList = selectedList;
                  allergyController.text = selectedAllergyList.join(" , ");
                });
              },
              maxSelection: allergyList.length,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Add"),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }*/

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
                  "Camera",
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
                    "Gallery",
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
