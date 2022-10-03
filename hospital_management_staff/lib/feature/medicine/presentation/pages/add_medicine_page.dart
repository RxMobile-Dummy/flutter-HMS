import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hospital_management_staff/core/base/base_bloc.dart';
import 'package:hospital_management_staff/core/error_bloc_builder/error_builder_listener.dart';
import 'package:hospital_management_staff/core/strings/strings.dart';
import 'package:hospital_management_staff/custom/progress_bar.dart';
import 'package:hospital_management_staff/feature/medicine/presentation/bloc/medicine_bloc.dart';
import 'package:hospital_management_staff/feature/medicine/presentation/bloc/medicine_event.dart';
import 'package:hospital_management_staff/utils/colors.dart';
import 'package:hospital_management_staff/utils/device_file.dart';
import 'package:hospital_management_staff/utils/style.dart';
import 'package:hospital_management_staff/widget/custom_appbar.dart';
import 'package:hospital_management_staff/widget/date_picker.dart';
import 'package:hospital_management_staff/widget/drop_down.dart';
import 'package:hospital_management_staff/widget/text_field.dart';
import 'package:hospital_management_staff/widget/text_field_with_border.dart';
import 'package:image_picker/image_picker.dart';

class AddMedicinePage extends StatefulWidget {
  const AddMedicinePage({Key? key}) : super(key: key);

  @override
  _AddMedicinePageState createState() => _AddMedicinePageState();
}

class _AddMedicinePageState extends State<AddMedicinePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   File? imageFile;
  TextEditingController medicineNameController = TextEditingController();
  TextEditingController medicinePriceController = TextEditingController();
  TextEditingController medicineCategoryController = TextEditingController();
  TextEditingController medicineSubCategoryController = TextEditingController();
  TextEditingController medicineDescriptionController = TextEditingController();
  TextEditingController medicineQuantityController = TextEditingController();
  TextEditingController medicineManufactureController = TextEditingController();
  TextEditingController medicineExpiryController = TextEditingController();
  TextEditingController medicineMgController = TextEditingController();
  TextEditingController prescriptionRequiredController = TextEditingController();
  TextEditingController stockOfMedicineController = TextEditingController();
  TextEditingController soldOutMedicineController = TextEditingController();
  List<String> prescriptionList = ["-- Select Prescription Status --", "yes", "no"];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 100),
        child: CustomAppBar(title: Strings.kAddMedicine, isBackPress: true),
      ),
      body: ErrorBlocListener<MedicineBloc>(
        bloc: BlocProvider.of<MedicineBloc>(context),
        child:  BlocBuilder<MedicineBloc, BaseState>(builder: (context, state)  {
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
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    height: DeviceUtil.isTablet ? 120 : 110,
                    width: DeviceUtil.isTablet ? 120 : 110,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2, color: Colors.grey),
                        image: DecorationImage(
                          image: (imageFile == null || imageFile == "")
                              ? AssetImage(
                            'assets/images/image_holder.png',
                          )
                              : imageFile.toString().contains("medicine/app/medicine_photos")
                              ? NetworkImage(
                            "${Strings.baseUrl}${imageFile!.path}",

                          )
                              : FileImage(
                            imageFile!,
                          )  as ImageProvider,
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(10,)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:  [
                        const SizedBox(height: 25,),
                          const CircleAvatar(
                            backgroundColor: CustomColors.colorDarkBlue,
                            radius: 15,
                            child: Icon(
                                Icons.camera_alt_outlined,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        const SizedBox(height: 15,),
                        GestureDetector(
                            onTap: (){
                              FocusScope.of(context).unfocus();
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
                            child:Text(
                              "Add Medicine Image",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Open Sans',
                                  fontSize: DeviceUtil.isTablet ? 18:14,
                                  color: CustomColors.colorDarkBlue
                              ),
                            )
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20,),
            CustomTextField(
              key: const Key(Strings.kMedicineNameKey),
              label: Strings.kMedicineLabel,
              hint: Strings.kMedicineHint,
              errorMessage: Strings.kMedicineErrorMessage,
              textEditingController: medicineNameController,
            ),
            const SizedBox(height: 10,),
            CustomTextField(
              key: const Key(Strings.kMedicineCategoryKey),
              label: Strings.kMedicineCategoryLabel,
              hint: Strings.kMedicineCategoryHint,
              errorMessage: Strings.kMedicineCategoryErrorMessage,
              textEditingController: medicineCategoryController,
            ),
            const SizedBox(height: 10,),
            CustomTextField(
              key: const Key(Strings.kMedicineSubCategoryKey),
              label: Strings.kMedicineSubCategoryLabel,
              hint: Strings.kMedicineSubCategoryHint,
              errorMessage: Strings.kMedicineSubCategoryErrorMessage,
              textEditingController: medicineSubCategoryController,
            ),
            const SizedBox(height: 10,),
            CustomTextField(
              key: const Key(Strings.kMedicineMgKey),
              label: Strings.kMedicineMgLabel,
              hint: Strings.kMedicineMgHint,
              errorMessage: Strings.kMedicineMgErrorMessage,
              textEditingController: medicineMgController,
            ),
            const SizedBox(height: 10,),
            CustomTextField(
              key: const Key(Strings.kMedicinePriceKey),
              label: Strings.kMedicinePriceLabel,
              hint: Strings.kMedicinePriceHint,
              errorMessage: Strings.kMedicinePriceErrorMessage,
              textEditingController: medicinePriceController,
            ),
            const SizedBox(height: 10,),
            CustomTextField(
              key: const Key(Strings.kMedicineQuantityKey),
              label: Strings.kMedicineQuantityLabel,
              hint: Strings.kMedicineQuantityHint,
              errorMessage: Strings.kMedicineQuantityErrorMessage,
              textEditingController: medicineQuantityController,
            ),
            DatePicker(
              dateController: medicineManufactureController,
              lableText: Strings.kMedicineManufactureLabel,
              firstDate: DateTime(1950),
              lastDate: DateTime.now(),
              errorMessage: Strings.kMedicineManufactureErrorMessage,
            ),
            DatePicker(
              dateController: medicineExpiryController,
              lableText: Strings.kMedicineExpiryLabel,
              firstDate: DateTime.now(),
              lastDate: DateTime(2023),
              errorMessage: Strings.kMedicineExpiryErrorMessage,
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CustomTextFieldWithBorder(
                key: const Key(Strings.kMedicineDescriptionKey),
                label: Strings.kMedicineDescriptionLabel,
                hint: Strings.kMedicineDescriptionHint,
                borderRadius: 7,
                minLines: 7,
               // lengthLimit: 300,
                maxLines: 7,
                errorMessage: Strings.kMedicineDescriptionErrorMessage,
                textEditingController: medicineDescriptionController,
              ),
            ),
            const SizedBox(height: 10,),
            DropDown(
              dropDownList: prescriptionList,
              selectedValue: prescriptionList[0],
              controller: prescriptionRequiredController,
              label: Strings.kPrescriptionLabel,
              errorMessage: Strings.kPrescriptionErrorMessage,
            ),
            const SizedBox(height: 10,),
            CustomTextField(
              key: const Key(Strings.kStockItemKey),
              label: Strings.kStockItemLabel,
              hint: Strings.kStockItemHint,
              errorMessage: Strings.kStockItemErrorMessage,
              textEditingController: stockOfMedicineController,
            ),
            const SizedBox(height: 10,),
            CustomTextField(
              key: const Key(Strings.kSoldItemKey),
              label: Strings.kSoldItemLabel,
              hint: Strings.kSoldItemHint,
              errorMessage: Strings.kSoldItemErrorMessage,
              textEditingController: soldOutMedicineController,
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){
                        _formKey.currentState?.save();
                        FocusScope.of(context).unfocus();
                        if(imageFile!.path != ""){
                          _addMedicine(
                              stockOfItem: stockOfMedicineController.text,
                              soldItem: soldOutMedicineController.text,
                              quantity: medicineQuantityController.text,
                              price: medicinePriceController.text,
                              prescriptionRequired: prescriptionRequiredController.text,
                              photo: imageFile!.path,
                              name: medicineNameController.text,
                              mg: medicineMgController.text,
                              itemSubCategory: medicineSubCategoryController.text,
                              itemCategory: medicineCategoryController.text,
                              description: medicineDescriptionController.text,
                              manufactureDate: medicineManufactureController.text,
                              expiryDate: medicineExpiryController.text
                          );
                        }else{
                          FocusScope.of(context).unfocus();
                          Fluttertoast.cancel();
                          Fluttertoast.showToast(
                              msg: "Enter Medicine Image.",
                              toastLength: Toast.LENGTH_LONG,
                              fontSize: DeviceUtil.isTablet ? 20 : 12,
                              backgroundColor: CustomColors.colorDarkBlue,
                              textColor: Colors.white
                          );
                        }
                      }else{
                        FocusScope.of(context).unfocus();
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
                    style: ElevatedButton.styleFrom(
                      primary: CustomColors.colorDarkBlue,
                      shape: StadiumBorder(),
                    ),
                    child:  Text(
                      Strings.kAddMedicine,
                      style: CustomTextStyle.styleSemiBold.copyWith(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
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

  Future<String> _addMedicine({
    required String name,
    required String photo,
    required String price,
    required String quantity,
    required String prescriptionRequired,
    required String stockOfItem,
    required String description,
    required String itemCategory,
    required String itemSubCategory,
    required String mg,
    required String soldItem,
    required String manufactureDate,
    required String expiryDate, }) {
    return Future.delayed(const Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<MedicineBloc>(context).add(
          AddMedicineEvent(
              expiryDate: expiryDate,
            manufactureDate: manufactureDate,
            description: description,
            itemCategory: itemCategory,
            itemSubCategory: itemSubCategory,
              mg: mg,
             name: name,
            photo: photo,
            prescriptionRequired: prescriptionRequired,
            price: price,
            quantity: quantity,
            soldItem: soldItem,
            stockOfItem: stockOfItem
          ));
      return "";
    });
  }
}
