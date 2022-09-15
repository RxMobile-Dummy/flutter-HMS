import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hospital_management/features/authentication/data/model/get_alleries_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_food_prefrence_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_injuries_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_medication_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_surgery_model.dart';
import 'package:hospital_management/features/profile/data/model/get_patient_profile_model.dart';
import 'package:hospital_management/features/profile/presentation/bloc/patient_profile_event.dart';
import 'package:hospital_management/features/profile/presentation/bloc/patient_profile_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../core/error_bloc_builder/error_builder_listener.dart';
import '../../../../core/strings/strings.dart';
import '../../../../custom/progress_bar.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/device_file.dart';
import '../../../../utils/style.dart';
import '../../../../widget/custom_appbar.dart';
import '../../../../widget/custom_button.dart';
import '../../../../widget/date_picker.dart';
import '../../../../widget/drop_down.dart';
import '../../../../widget/multi_selection_widget.dart';
import '../../../../widget/radio_widget.dart';
import '../../../../widget/text_field.dart';
import '../../../authentication/presentation/bloc/allergies_bloc.dart';
import '../../../authentication/presentation/bloc/authentication_event.dart';
import '../../../authentication/presentation/bloc/authentication_state.dart';
import '../../../authentication/presentation/bloc/food_preference_bloc.dart';
import '../../../authentication/presentation/bloc/injuries_bloc.dart';
import '../../../authentication/presentation/bloc/medication_bloc.dart';
import '../../../authentication/presentation/bloc/surgery_bloc.dart';
import '../bloc/patient_profile_bloc.dart';

class UpdateProfilePage extends StatefulWidget {
  GetPatientProfileModel getPatientProfileModel;
   UpdateProfilePage({Key? key,required this.getPatientProfileModel}) : super(key: key);

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  TextEditingController allergyController = TextEditingController();
  TextEditingController medicationController = TextEditingController();
  TextEditingController injuryController = TextEditingController();
  TextEditingController surgeryController = TextEditingController();
  TextEditingController foodController = TextEditingController();
  TextEditingController activityController = TextEditingController();
  TextEditingController smokingController = TextEditingController();
  TextEditingController alcoholController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController meritalStatusController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController emergenyContactController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  bool isPasswordShow = true;
  var selectedRadioForSmoking;
  var selectedRadioForAlcohol;
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
  List<String> smokingHabitList = ["Yes", "No"];
  List<String> activityLevelList = [
    "-- Select Activity Level --",
    "1",
    "2",
    "3",
    "4",
    "5"
  ];
  List<String> maritalList = ["-- Select Marital Status --", "Yes", "No"];
  List<String> allergyList = [];
  List<String> medicationList = [];
  List<String> injuryList = [];
  List<String> surgeryList = [];
  List<String> foodPreferenceList = [];
  GetAllergiesModel getAllergiesModel = GetAllergiesModel();
  GetMedicationModel getMedicationModel = GetMedicationModel();
  GetInjuriesModel getInjuriesModel = GetInjuriesModel();
  GetSurgeryModel getSurgeryModel = GetSurgeryModel();
  GetFoodPreferenceModel getFoodPreferenceModel = GetFoodPreferenceModel();
  String? patientId;


@override
  void initState() {
  imageFile = File(widget.getPatientProfileModel.data?.profilePic ?? "");
  firstNameController.text = widget.getPatientProfileModel.data?.firstName ?? "";
  lastNameController.text = widget.getPatientProfileModel.data?.lastName ?? "";
  mobileNumberController.text = widget.getPatientProfileModel.data?.contactNumber.toString().substring(3) ?? "";
  emailController.text = widget.getPatientProfileModel.data?.email ?? "";
  genderController.text = widget.getPatientProfileModel.data?.gender ?? genderDropDown[0];
  bloodGroupController.text = widget.getPatientProfileModel.data?.bloodGroup ?? bloodGroupDropDown[0];
  List allergyList1 = [];
  for(int i=0;i< widget.getPatientProfileModel.data!.patientAllergies!.length;i++){
    allergyList1.add(widget.getPatientProfileModel.data!.patientAllergies![i].allergy);
  }
  allergyController.text = allergyList1.join(" , ");
  List medicationList1 = [];
  for(int i=0;i< widget.getPatientProfileModel.data!.patientCurrentMedications!.length;i++){
    medicationList1.add(widget.getPatientProfileModel.data!.patientCurrentMedications![i].currentMedication);
  }
  medicationController.text = medicationList1.join(" , ");
  List injuryList1 = [];
  for(int i=0;i< widget.getPatientProfileModel.data!.patientPastInjuries!.length;i++){
    injuryList1.add(widget.getPatientProfileModel.data!.patientPastInjuries![i].pastInjury);
  }
  injuryController.text = injuryList1.join(" , ");
  List surgeryList1 = [];
  for(int i=0;i< widget.getPatientProfileModel.data!.patientPastSurgeries!.length;i++){
    surgeryList1.add(widget.getPatientProfileModel.data!.patientPastSurgeries![i].pastSurgery);
  }
  surgeryController.text = surgeryList1.join(" , ");
  List foodList1 = [];
  for(int i=0;i< widget.getPatientProfileModel.data!.patientFoodPreferences!.length;i++){
    foodList1.add(widget.getPatientProfileModel.data!.patientFoodPreferences![i].foodPreference);
  }
  foodController.text = foodList1.join(" , ");
  activityController.text =
  (widget.getPatientProfileModel.data?.activityLevel != null && widget.getPatientProfileModel.data?.activityLevel != "")
  ? widget.getPatientProfileModel.data?.activityLevel ?? activityLevelList[0] :activityLevelList[0];
  smokingController.text = widget.getPatientProfileModel.data?.smokingHabits ?? "No";
  selectedRadioForSmoking = smokingController.text;
  alcoholController.text = widget.getPatientProfileModel.data?.alcholConsumption ?? "No";
  selectedRadioForAlcohol = alcoholController.text;
  dateController.text = widget.getPatientProfileModel.data?.dateOfBirth ?? "";
  meritalStatusController.text =
      (widget.getPatientProfileModel.data?.maritalStatus != null && widget.getPatientProfileModel.data?.maritalStatus != "")
          ? widget.getPatientProfileModel.data?.maritalStatus?? maritalList[0] : maritalList[0];
  heightController.text = widget.getPatientProfileModel.data?.height ?? "";
  weightController.text = widget.getPatientProfileModel.data?.weight ?? "";
  emergenyContactController.text = widget.getPatientProfileModel.data?.emergencyContactNumber.toString().substring(3) ?? "";
  cityController.text = widget.getPatientProfileModel.data?.city ?? "";
  occupationController.text = widget.getPatientProfileModel.data?.occupation ?? "";
  patientId = widget.getPatientProfileModel.data?.id.toString() ?? "";
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    await _getAllergiesList();
    await  _getMedicationList();
    await _getInjuriesList();
    await  _getSurgeryList();
    await  _getFoodPreferenceList();
  });
    super.initState();
  }

  Future<String> _getAllergiesList() {
    return Future.delayed(const Duration()).then((_) {
      // ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AllergiesBloc>(context).add(
          GetAllergiesEvent());
      return "";
    });
  }

  Future<String> _getFoodPreferenceList() {
    return Future.delayed(const Duration()).then((_) {
      // ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<FoodPreferenceBloc>(context).add(
          GetFoodPreferenceEvent());
      return "";
    });
  }

  Future<String> _getSurgeryList() {
    return Future.delayed(const Duration()).then((_) {
      //ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<SurgeryBloc>(context).add(
          GetSurgeryEvent());
      return "";
    });
  }


  Future<String> _getMedicationList() {
    return Future.delayed(const Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<MedicationBloc>(context).add(
          GetMedicationEvent());
      return "";
    });
  }

  Future<String> _getInjuriesList() {
    return Future.delayed(const Duration()).then((_) {
      BlocProvider.of<InjuryBloc>(context).add(
          GetInjuriesEvent());
      return "";
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 100),
        child: CustomAppBar(title: "Update Patient Profile", isBackPress: true),
      ),
      body: ErrorBlocListener<PatientProfileBloc>(
        bloc: BlocProvider.of<PatientProfileBloc>(context),
        // callback:  _loginUser(userName.text,tiePassword.text),
        child:  BlocBuilder<PatientProfileBloc, BaseState>(builder: (context, state)  {
         /* if(state is UpdatePatientProfileState) {
            ProgressDialog.hideLoadingDialog(context);
            Navigator.of(context).pop();
          }*/
          return Form(
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
               Text(
                "Personal Information",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.normal,
                    fontFamily: 'Open Sans',
                    fontSize:  DeviceUtil.isTablet ? 22 : 18,
                    color: CustomColors.colorDarkBlue
                ),
              ),
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
                          backgroundImage: (imageFile!.path == null || imageFile!.path == "")
                              ? AssetImage('assets/images/person_image.jpeg')
                              :  imageFile.toString().contains("patient/app/patient_images")
                              ? NetworkImage( "${Strings.baseUrl}${imageFile?.path}")
                              : FileImage(imageFile!) as ImageProvider, /*(imageFile == null || imageFile == "")
                              ? const AssetImage(
                            'assets/images/person_image.jpeg',
                          )
                              : imageFile.toString().contains("patient/app/patient_images")
                              ? NetworkImage(
                            "${Strings.baseUrl}${imageFile?.path}",
                          )
                              : FileImage(
                            imageFile!,
                          ) as ImageProvider,*/
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
              const SizedBox(height: 20,),
              CustomTextField(
                key: const Key("tefFirstname"),
                label: "First Name",
                hint: "Enter First Name",
                errorMessage: "Please Enter First name",
                textEditingController: firstNameController,
              ),
              const SizedBox(height: 10,),
              CustomTextField(
                key: const Key("tefLastName"),
                label: "Last Name",
                hint: "Enter Last Name",
                errorMessage: "Please Enter Last name",
                textEditingController: lastNameController,
              ),
              const SizedBox(height: 10,),
              CustomTextField(
                key: const Key("tefMobilenumber"),
                label: "Mobile number",
                hint: "Enter mobile number",
                errorMessage: "Please Enter mobile number",
                isMobile: true,
                readOnly: true,
                textInputType: TextInputType.phone,
                textEditingController: mobileNumberController,
              ),
              const SizedBox(height: 10,),
              CustomTextField(
                key: const Key("tefEmail"),
                label: "Email",
                hint: "Enter email",
                errorMessage: "Please Enter email",
                isEmail: true,
                readOnly: true,
                textInputType: TextInputType.emailAddress,
                textEditingController: emailController,
              ),
              const SizedBox(height: 10,),
              DropDown(
                dropDownList: genderDropDown,
                selectedValue: genderController.text,
                label: "Select Gender",
                controller: genderController,
                errorMessage: "Please select gender",
              ),
              const SizedBox(height: 10,),
              DropDown(
                dropDownList: bloodGroupDropDown,
                selectedValue: bloodGroupController.text,
                controller: bloodGroupController,
                errorMessage: "Please select Blood group",
                label: "Select Blood Group",
              ),
              const SizedBox(height: 20,),
               Text(
                "Medical Information",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.normal,
                    fontFamily: 'Open Sans',
                    fontSize:DeviceUtil.isTablet ? 22 : 18,
                    color: CustomColors.colorDarkBlue
                ),
              ),
              const SizedBox(height: 20,),
              BlocBuilder<AllergiesBloc, BaseState>(
                builder: (context, state) {
                  if (state is GetAllergiesState) {
                    ProgressDialog.hideLoadingDialog(context);
                    allergyList = [];
                    getAllergiesModel = state.model!;
                    for(int i=0;i<getAllergiesModel.data!.length;i++){
                      allergyList.add(getAllergiesModel.data![i].allergy ?? "");
                    }
                    print(allergyList);
                    return MultiSelectionWidget(
                      controller: allergyController,
                      displayList: allergyList,
                      label: "Select Allergy",
                    );
                  }else if (state is StateErrorGeneral) {
                    ProgressDialog.hideLoadingDialog(context);
                    Fluttertoast.cancel();
                    Fluttertoast.showToast(
                        msg: state.message,
                        toastLength: Toast.LENGTH_LONG,
                        fontSize: DeviceUtil.isTablet ? 20 : 12,
                        backgroundColor: CustomColors.colorDarkBlue,
                        textColor: Colors.white
                    );
                    return const SizedBox();
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const SizedBox(height: 15,),
              BlocBuilder<MedicationBloc, BaseState>(
                builder: (context, state) {
                  if (state is GetMedicationState) {
                    ProgressDialog.hideLoadingDialog(context);
                    medicationList = [];
                    getMedicationModel = state.model!;
                    for(int i=0;i<getMedicationModel.data!.length;i++){
                      medicationList.add(getMedicationModel.data![i].currentMedication ?? "");
                    }
                    print(medicationList);
                    return  MultiSelectionWidget(
                      controller: medicationController,
                      displayList: medicationList,
                      label: "Select Medication",
                    );
                  }else if (state is StateErrorGeneral) {
                    ProgressDialog.hideLoadingDialog(context);
                    Fluttertoast.cancel();
                    Fluttertoast.showToast(
                        msg: state.message,
                        toastLength: Toast.LENGTH_LONG,
                        fontSize: DeviceUtil.isTablet ? 20 : 12,
                        backgroundColor: CustomColors.colorDarkBlue,
                        textColor: Colors.white
                    );
                    return const SizedBox();
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const SizedBox(height: 15,),
              BlocBuilder<InjuryBloc, BaseState>(
                builder: (context, state) {
                  if (state is GetInjuriesState) {
                    ProgressDialog.hideLoadingDialog(context);
                    injuryList = [];
                    getInjuriesModel = state.model!;
                    for(int i=0;i<getInjuriesModel.data!.length;i++){
                      injuryList.add(getInjuriesModel.data![i].pastInjury ?? "");
                    }
                    print(injuryList);
                    return   MultiSelectionWidget(
                      controller: injuryController,
                      displayList: injuryList,
                      label: "Select Past Injury",
                    );
                  }else if (state is StateErrorGeneral) {
                    ProgressDialog.hideLoadingDialog(context);
                    Fluttertoast.cancel();
                    Fluttertoast.showToast(
                        msg: state.message,
                        toastLength: Toast.LENGTH_LONG,
                        fontSize: DeviceUtil.isTablet ? 20 : 12,
                        backgroundColor: CustomColors.colorDarkBlue,
                        textColor: Colors.white
                    );
                    return const SizedBox();
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const SizedBox(height: 15,),
              BlocBuilder<SurgeryBloc, BaseState>(
                builder: (context, state) {
                  if (state is GetSurgeryState) {
                    ProgressDialog.hideLoadingDialog(context);
                    surgeryList = [];
                    getSurgeryModel = state.model!;
                    for(int i=0;i<getSurgeryModel.data!.length;i++){
                      surgeryList.add(getSurgeryModel.data![i].pastSurgery ?? "");
                    }
                    print(surgeryList);
                    return  MultiSelectionWidget(
                      controller: surgeryController,
                      displayList: surgeryList,
                      label: "Select Past Surgery",
                    );
                  }else if (state is StateErrorGeneral) {
                    ProgressDialog.hideLoadingDialog(context);
                    Fluttertoast.cancel();
                    Fluttertoast.showToast(
                        msg: state.message,
                        toastLength: Toast.LENGTH_LONG,
                        fontSize: DeviceUtil.isTablet ? 20 : 12,
                        backgroundColor: CustomColors.colorDarkBlue,
                        textColor: Colors.white
                    );
                    return const SizedBox();
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const SizedBox(height: 15,),
              BlocBuilder<FoodPreferenceBloc, BaseState>(
                builder: (context, state) {
                  if (state is GetFoodPreferenceState) {
                    ProgressDialog.hideLoadingDialog(context);
                    foodPreferenceList = [];
                    getFoodPreferenceModel = state.model!;
                    for(int i=0;i<getFoodPreferenceModel.data!.length;i++){
                      foodPreferenceList.add(getFoodPreferenceModel.data![i].foodPreference ?? "");
                    }
                    print(foodPreferenceList);
                    return MultiSelectionWidget(
                      controller: foodController,
                      displayList: foodPreferenceList,
                      label: "Select Food Preference",
                    );
                  }else if (state is StateErrorGeneral) {
                    ProgressDialog.hideLoadingDialog(context);
                    Fluttertoast.cancel();
                    Fluttertoast.showToast(
                        msg: state.message,
                        toastLength: Toast.LENGTH_LONG,
                        fontSize: DeviceUtil.isTablet ? 20 : 12,
                        backgroundColor: CustomColors.colorDarkBlue,
                        textColor: Colors.white
                    );
                    return const SizedBox();
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const SizedBox(height: 15,),
              DropDown(
                dropDownList: activityLevelList,
                selectedValue: activityController.text,
                controller: activityController,
                label: "Select Activity Level",
              ),
              const SizedBox(height: 10,),
              RadioWidget(
                label: "Smoking Habit",
                selectedRadio: selectedRadioForSmoking,
                radioList: smokingHabitList,
                controller: smokingController,
              ),
              const SizedBox(height: 10,),
              RadioWidget(
                label: "Alcohol Consumption",
                selectedRadio: selectedRadioForAlcohol,
                radioList: smokingHabitList,
                controller: alcoholController,
              ),
              const SizedBox(height: 20,),
               Text(
                "Other Information",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.normal,
                    fontFamily: 'Open Sans',
                    fontSize: DeviceUtil.isTablet ? 22 : 18,
                    color: CustomColors.colorDarkBlue
                ),
              ),
              const SizedBox(height: 20,),
              DatePicker(
                  dateController: dateController,
                lableText: "Date Of Birth",
                firstDate: DateTime(1950),
                lastDate: DateTime.now(),
              ),
              const SizedBox(height: 10,),
              DropDown(
                dropDownList: maritalList,
                selectedValue: meritalStatusController.text,
                controller: meritalStatusController,
                label: "Select Marital status",
              ),
              const SizedBox(height: 10,),
              CustomTextField(
                key: const Key("tefHeight"),
                label: "Height",
                hint: "Enter Height",
                textEditingController: heightController,
              ),
              const SizedBox(height: 10,),
              CustomTextField(
                key: const Key("tefWeight"),
                label: "Weight",
                hint: "Enter Weight",
                textEditingController: weightController,
              ),
              const SizedBox(height: 10,),
              CustomTextField(
                key: const Key("tefEmergencynumber"),
                label: "Emergency Contact number",
                hint: "Enter Emergency Contact number",
                errorMessage: "Please Enter Emergency Contact number",
                isMobile: true,
                textInputType: TextInputType.phone,
                textEditingController: emergenyContactController,
              ),
              const SizedBox(height: 10,),
              CustomTextField(
                key: const Key("tefCity"),
                label: "City",
                hint: "Enter City name",
                errorMessage: "Please Enter City name",
                textEditingController: cityController,
              ),
              const SizedBox(height: 10,),
              CustomTextField(
                key: const Key("tefOccupation"),
                label: "Occupation",
                hint: "Enter your occupation",
                textEditingController: occupationController,
              ),
              const SizedBox(height: 10,),
              Button(
                "Update Profile",
                onPress: () {
                  FocusScope.of(context).unfocus();
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    List<String> allergyList = allergyController.text.split(" , ");
                    List<String> allergyIdList = [];
                    print(allergyList);
                    for(int j=0;j<allergyList.length;j++){
                      for(int i=0;i<getAllergiesModel.data!.length;i++){
                        if(getAllergiesModel.data![i].allergy == allergyList[j]){
                          allergyIdList.add(getAllergiesModel.data![i].id.toString());
                        }
                      }
                    }
                    print(allergyIdList);
                    String allergyIdString = allergyIdList.join(",");
                    print(allergyIdString);
                    List<String> medicationList = medicationController.text.split(" , ");
                    List<String> medicationIdList = [];
                    print(medicationList);
                   for(int j=0;j<medicationList.length;j++){
                     for(int i=0;i<getMedicationModel.data!.length;i++){
                       if(getMedicationModel.data![i].currentMedication == medicationList[j]){
                         medicationIdList.add(getMedicationModel.data![i].id.toString());
                       }
                     }
                   }
                    print(medicationIdList);
                    String medicationIdString = medicationIdList.join(",");
                    print(medicationIdString);
                    List<String> injuryList = injuryController.text.split(" , ");
                    List<String> injuryIdList = [];
                    print(injuryList);
                    for(int j=0;j<injuryList.length;j++){
                      for(int i=0;i<getInjuriesModel.data!.length;i++){
                        if(getInjuriesModel.data![i].pastInjury == injuryList[j]){
                          injuryIdList.add(getInjuriesModel.data![i].id.toString());
                        }
                      }
                    }
                    print(injuryIdList);
                    String injuryIdString = injuryIdList.join(",");
                    print(injuryIdString);
                    List<String> surgeryList = surgeryController.text.split(" , ");
                    List<String> surgeryIdList = [];
                    print(surgeryList);
                    for(int j=0;j<surgeryList.length;j++){
                      for(int i=0;i<getSurgeryModel.data!.length;i++){
                        if(getSurgeryModel.data![i].pastSurgery == surgeryList[j]){
                          surgeryIdList.add(getSurgeryModel.data![i].id.toString());
                        }
                      }
                    }
                    print(surgeryIdList);
                    String surgeryIdString = surgeryIdList.join(",");
                    print(surgeryIdString);
                    List<String> foodList = foodController.text.split(" , ");
                    List<String> foodIdList = [];
                    print(foodList);
                    for(int j=0;j<foodList.length;j++){
                      for(int i=0;i<getFoodPreferenceModel.data!.length;i++){
                        if(getFoodPreferenceModel.data![i].foodPreference == foodList[j]){
                          foodIdList.add(getFoodPreferenceModel.data![i].id.toString());
                        }
                      }
                    }
                    print(foodIdList);
                    String foodIdString = foodIdList.join(",");
                    print(foodIdString);
                    _updatePatient(
                      patient_id: patientId,
                        height: heightController.text,
                        email: emailController.text,
                        profile_pic: (imageFile!.path.isNotEmpty && !imageFile!.path.contains('patient_images')) ? imageFile!.path : "",
                        last_name: lastNameController.text,
                        first_name: firstNameController.text,
                        occupation: occupationController.text,
                        activity_level: activityController.text,
                        alchol_consumption: alcoholController.text,
                        allergy: allergyController.text.isEmpty ? "" :allergyIdString,
                        blood_group: bloodGroupController.text,
                        city: cityController.text,
                        contact_number: "+91${mobileNumberController.text}",
                        current_medication: medicationController.text.isEmpty ? "" : medicationIdString,
                        date_of_birth: dateController.text,
                        emergency_contact_number: "+91${emergenyContactController.text}",
                        food_preference:foodController.text.isEmpty ? "" : foodIdString,
                        gender: genderController.text,
                        marital_status: meritalStatusController.text,
                        past_injury: injuryController.text.isEmpty ? "" : injuryIdString,
                        past_surgery: surgeryController.text.isEmpty ? "" :surgeryIdString,
                        smoking_habits: smokingController.text,
                        weight: weightController.text
                    );
                  } else {
                    Fluttertoast.cancel();
                    Fluttertoast.showToast(
                        msg: 'Please fill all the details.',
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
  Future<String> _updatePatient({
    String? patient_id,
    String? first_name,
    String? last_name,
    String? contact_number,
    String? email,
    String? gender,
    String? date_of_birth,
    String? blood_group,
    String? marital_status,
    String? height,
    String? weight,
    String? emergency_contact_number,
    String? city,
    String? allergy,
    String? current_medication,
    String? past_injury,
    String? past_surgery,
    String? smoking_habits,
    String? alchol_consumption,
    String? activity_level,
    String? food_preference,
    String? occupation,
    String? profile_pic,
  }) {
    return Future.delayed(const Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<PatientProfileBloc>(context).add(
          UpdatePatientEvent(
            patient_id: patient_id,
            weight: weight,
            smoking_habits: smoking_habits,
            past_surgery: past_surgery,
            past_injury: past_injury,
            marital_status: marital_status,
            gender: gender,
            food_preference: food_preference,
            emergency_contact_number: emergency_contact_number,
            date_of_birth: date_of_birth,
            current_medication: current_medication,
            contact_number: contact_number,
            city: city,
            blood_group: blood_group,
            allergy: allergy,
            alchol_consumption: alchol_consumption,
            activity_level: activity_level,
            occupation: occupation,
            first_name: first_name,
            last_name: last_name,
            profile_pic: profile_pic,
            email: email,
            height: height,
          ));
      return "";
    });
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
}
