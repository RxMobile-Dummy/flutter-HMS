import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
  List<String> maritalList = ["-- Select Marital Status --", "Yes", "No"];
  Map<String,dynamic> map = Map();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
        preferredSize: Size(double.infinity, 100),
        child: CustomAppBar(title: "Fill other details",isBackPress: true),
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
              Center(
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
              DatePicker(
                  dateController: dateController,
                  lableText: "Date Of Birth",
                firstDate: DateTime(1950),
                lastDate: DateTime.now(),
              ),
              DropDown(
                dropDownList: maritalList,
                selectedValue: maritalList[0],
                controller: meritalStatusController,
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
              CustomTextField(
                key: const Key("tefOccupation"),
                label: "Occupation",
                hint: "Enter your occupation",
                textEditingController: occupationController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                    child:  Text("<< Previous",style: CustomTextStyle.styleBold
                        .copyWith(fontSize: 12, color: CustomColors.colorDarkBlue),),
                    onPressed: () {
                      widget.pageController.previousPage(
                          duration: Duration(seconds: 1), curve: Curves.ease);
                    },
                  ),
                  TextButton(
                    child:  Text("Register",style: CustomTextStyle.styleBold
                        .copyWith(fontSize: 12, color: CustomColors.colorDarkBlue),),
                    onPressed: () {
                      function();
                    },
                  ),
                ],
              )
              /*TextButton(
                child: Text("NEXT"),
                onPressed: (){
                  widget.pageController.nextPage(duration: Duration(seconds: 2),curve: Curves.easeIn);
                },
              )*/
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

  function(){
    map["profile_pic"] = imageFile?.path;
    map["date_of_birth"] = dateController.text;
    map["marital_status"] = meritalStatusController.text;
    map["height"] = heightController.text;
    map["weight"] = weightController.text;
    map["emergency_contact_number"] = "+91${emergenyContactController.text}";
    map["city"] = cityContactController.text;
    map["occupation"] = occupationController.text;
    print(map);
    return widget.nextClick(map);
  }

}
