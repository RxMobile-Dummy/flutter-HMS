import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hospital_management/core/common_keys/common_keys.dart';
import 'package:hospital_management/core/strings/strings.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/device_file.dart';
import '../../../../utils/style.dart';
import '../../../../widget/custom_appbar.dart';
import '../../../../widget/date_picker.dart';
import '../../../../widget/drop_down.dart';
import '../../../../widget/text_field.dart';

class SignUpScreen2 extends StatefulWidget {
  PageController pageController;
  Function nextClick;
   SignUpScreen2({Key? key,required this.nextClick,required this.pageController}) : super(key: key);

  @override
  _SignUpScreen2State createState() => _SignUpScreen2State();
}

class _SignUpScreen2State extends State<SignUpScreen2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController emergenyContactController = TextEditingController();
  TextEditingController cityContactController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController meritalStatusController = TextEditingController();
  File? imageFile;
  List<String> maritalList = [Strings.kSelectMaritalStatus, Strings.kYes, Strings.kNo];
  Map<String,dynamic> map = Map();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
        preferredSize: Size(double.infinity, 100),
        child: CustomAppBar(title: Strings.kFillOtherDetails,isBackPress: true),
      ),
      body: Form(
        key: _formKey,
        child: buildWidget(),
      ),
    );
  }

   buildWidget(){
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30,),
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
                              : imageFile.toString().contains(Strings.kStatic)
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
              const SizedBox(height: 15,),
              DatePicker(
                  dateController: dateController,
                  lableText: Strings.kDateOfBirth,
                firstDate: DateTime(1950),
                lastDate: DateTime.now(),
              ),
              const SizedBox(height: 15,),
              DropDown(
                dropDownList: maritalList,
                selectedValue: maritalList[0],
                controller: meritalStatusController,
                label: Strings.kSelectMaritalStatusLabel,
              ),
              const SizedBox(height: 15,),
              CustomTextField(
                key: const Key(Strings.kHeightKey),
                label: Strings.kHeightLabel,
                hint: Strings.kHeightHint,
                isEmail: true,
                textEditingController: heightController,
              ),
              const SizedBox(height: 15,),
              CustomTextField(
                key: const Key(Strings.kWeightKey),
                label: Strings.kWeightLabel,
                hint: Strings.kWeightHint,
                isEmail: true,
                textEditingController: weightController,
              ),
              const SizedBox(height: 15,),
              CustomTextField(
                key: const Key(Strings.kEmergencyContactNumberKey),
                label: Strings.kEmergencyContactNumberLabel,
                hint: Strings.kEmergencyContactNumberHint,
                errorMessage: Strings.kEmergencyContactNumberErrorMessage,
                isMobile: true,
                textInputType: TextInputType.phone,
                textEditingController: emergenyContactController,
              ),
              const SizedBox(height: 15,),
              CustomTextField(
                key: const Key(Strings.kCityKey),
                label: Strings.kCityLabel,
                hint: Strings.kCityHint,
                errorMessage: Strings.kCityErrorMessage,
                textEditingController: cityContactController,
              ),
              const SizedBox(height: 15,),
              CustomTextField(
                key: const Key(Strings.kOccupationKey),
                label: Strings.kOccupationLabel,
                hint: Strings.kOccupationHint,
                textEditingController: occupationController,
              ),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child:  Text(Strings.kPrevious,style: CustomTextStyle.styleBold
                        .copyWith(fontSize: DeviceUtil.isTablet ? 16 : 14, color: CustomColors.colorDarkBlue),),
                    onPressed: () {
                      widget.pageController.previousPage(
                          duration: Duration(seconds: 1), curve: Curves.ease);
                    },
                  ),
                  TextButton(
                    child:  Text(Strings.kRegister,style: CustomTextStyle.styleBold
                        .copyWith(fontSize: DeviceUtil.isTablet ? 16 : 14, color: CustomColors.colorDarkBlue),),
                    onPressed: () {
                      function();
                    },
                  ),
                ],
              )
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

  function(){
    map[CommonKeys.K_Profile_Pic] = imageFile?.path;
    map[CommonKeys.K_Date_Of_Birth] = dateController.text;
    map[CommonKeys.K_Marital_Status] = (meritalStatusController.text == maritalList[0]) ? "" : meritalStatusController.text;
    map[CommonKeys.K_Height] = heightController.text;
    map[CommonKeys.K_Weight] = weightController.text;
    map[CommonKeys.K_Emergency_Contact_Number] = emergenyContactController.text.isNotEmpty ? "+91${emergenyContactController.text}" : "";
    map[CommonKeys.K_City] = cityContactController.text;
    map[CommonKeys.K_Occupation] = occupationController.text;
    print(map);
    return widget.nextClick(map);
  }

}
