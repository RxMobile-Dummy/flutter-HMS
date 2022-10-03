import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management/core/common_keys/common_keys.dart';
import 'package:hospital_management/core/strings/strings.dart';
import 'package:hospital_management/features/authentication/data/model/get_alleries_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_food_prefrence_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_injuries_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_medication_model.dart';
import 'package:hospital_management/features/authentication/data/model/get_surgery_model.dart';
import 'package:hospital_management/features/authentication/presentation/bloc/authentication_event.dart';
import 'package:hospital_management/features/authentication/presentation/bloc/authentication_state.dart';
import 'package:hospital_management/features/authentication/presentation/bloc/food_preference_bloc.dart';
import 'package:hospital_management/features/authentication/presentation/bloc/injuries_bloc.dart';
import 'package:hospital_management/features/authentication/presentation/bloc/medication_bloc.dart';
import 'package:hospital_management/features/authentication/presentation/bloc/surgery_bloc.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../custom/progress_bar.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/device_file.dart';
import '../../../../utils/style.dart';
import '../../../../widget/custom_appbar.dart';
import '../../../../widget/drop_down.dart';
import '../../../../widget/multi_selection_widget.dart';
import '../../../../widget/radio_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../bloc/allergies_bloc.dart';

class SignUpScreen3 extends StatefulWidget {
  PageController pageController;
  Map<String,dynamic>? map;
  Function nextClick;
   SignUpScreen3({Key? key,required this.nextClick,required this.pageController,this.map}) : super(key: key);

  @override
  _SignUpScreen3State createState() => _SignUpScreen3State();
}

class _SignUpScreen3State extends State<SignUpScreen3> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController allergyController = TextEditingController();
  TextEditingController medicationController = TextEditingController();
  TextEditingController injuryController = TextEditingController();
  TextEditingController surgeryController = TextEditingController();
  TextEditingController foodController = TextEditingController();
  TextEditingController smokingController = TextEditingController();
  TextEditingController alcoholController = TextEditingController();
  TextEditingController activityController = TextEditingController();
  List<String> allergyList = [];
  List<String> medicationList = [];
  List<String> injuryList = [];
  List<String> surgeryList = [];
  List<String> foodPreferenceList = [];
  List<String> smokingHabitList = [Strings.kYes, Strings.kNo];
  List<String> activityLevelList = [
    Strings.kSelectActivityLevel,
    "1",
    "2",
    "3",
    "4",
    "5"
  ];
  Map<String,dynamic> map = Map();

  List<String> selectedAllergyList = [];
  var selectedRadioForSmoking;
  var selectedRadioForAlcohol;
  GetAllergiesModel getAllergiesModel = GetAllergiesModel();
  GetInjuriesModel getInjuriesModel = GetInjuriesModel();
  GetSurgeryModel getSurgeryModel = GetSurgeryModel();
  GetMedicationModel getMedicationModel = GetMedicationModel();
  GetFoodPreferenceModel getFoodPreferenceModel = GetFoodPreferenceModel();

  @override
  void initState() {
    selectedRadioForSmoking = smokingHabitList[1];
    selectedRadioForAlcohol = smokingHabitList[1];
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
      BlocProvider.of<AllergiesBloc>(context).add(
          GetAllergiesEvent());
      return "";
    });
  }

  Future<String> _getFoodPreferenceList() {
    return Future.delayed(const Duration()).then((_) {
      BlocProvider.of<FoodPreferenceBloc>(context).add(
          GetFoodPreferenceEvent());
      return "";
    });
  }

  Future<String> _getSurgeryList() {
    return Future.delayed(const Duration()).then((_) {
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
        child: CustomAppBar(title: Strings.kFillMedicineDetails, isBackPress: true),
      ),
      body:  Form(
        key: _formKey,
        child: buildWidget(),
      )
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
                      label: Strings.kSelectAllergy,
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
                      label: Strings.kSelectMedication,
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
                      label: Strings.kSelectPastInjury,
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
                      label: Strings.kSelectPastSurgery,
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
                      label: Strings.kSelectFoodPreference,
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
                selectedValue: activityLevelList[0],
                controller: activityController,
                label: Strings.kSelectActivityLevelLabel,
              ),
              const SizedBox(height: 15,),
              RadioWidget(
                label: Strings.kSmokingHabit,
                selectedRadio: selectedRadioForSmoking,
                radioList: smokingHabitList,
                controller: smokingController,
              ),
              const SizedBox(height: 15,),
              RadioWidget(
                label: Strings.kAlcoholConsumption,
                selectedRadio: selectedRadioForAlcohol,
                radioList: smokingHabitList,
                controller: alcoholController,
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
                    child:  Text(Strings.kNext,style: CustomTextStyle.styleBold
                        .copyWith(fontSize: DeviceUtil.isTablet ? 16 : 14, color: CustomColors.colorDarkBlue),),
                    onPressed: () {
                      function();
                      widget.pageController.nextPage(
                          duration: Duration(seconds: 1), curve: Curves.ease);
                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }
  function(){
    List<String> allergyList = allergyController.text.split(" , ");
    List<String> allergyIdList = [];
    print(allergyList);
    if(allergyController.text.isNotEmpty){
      for(int j=0;j<allergyList.length;j++){
        for(int i=0;i<getAllergiesModel.data!.length;i++){
          if(getAllergiesModel.data![i].allergy == allergyList[j]){
            allergyIdList.add(getAllergiesModel.data![i].id.toString());
          }
        }
      }
    }
    print(allergyIdList);
    String allergyIdString = allergyIdList.join(",");
    print(allergyIdString);
    map[CommonKeys.K_Allergy] = allergyController.text.isEmpty ? "" : allergyIdString;
    List<String> medicationList = medicationController.text.split(" , ");
    List<String> medicationIdList = [];
    print(medicationList);
   if(medicationController.text.isNotEmpty){
     for(int j=0;j<medicationList.length;j++){
       for(int i=0;i<getMedicationModel.data!.length;i++){
         if(getMedicationModel.data![i].currentMedication == medicationList[j]){
           medicationIdList.add(getMedicationModel.data![i].id.toString());
         }
       }
     }
   }
    print(medicationIdList);
    String medicationIdString = medicationIdList.join(",");
    print(medicationIdString);
    map[CommonKeys.K_Current_Medication] = medicationController.text.isEmpty ? "" : medicationIdString;
    List<String> injuryList = injuryController.text.split(" , ");
    List<String> injuryIdList = [];
    print(injuryList);
    if(injuryController.text.isNotEmpty){
      for(int j=0;j<injuryList.length;j++){
        for(int i=0;i<getInjuriesModel.data!.length;i++){
          if(getInjuriesModel.data![i].pastInjury == injuryList[j]){
            injuryIdList.add(getInjuriesModel.data![i].id.toString());
          }
        }
      }
    }
    print(injuryIdList);
    String injuryIdString = injuryIdList.join(",");
    print(injuryIdString);
    map[CommonKeys.K_Past_Injury] = injuryController.text.isEmpty ? "" : injuryIdString;
    List<String> surgeryList = surgeryController.text.split(" , ");
    List<String> surgeryIdList = [];
    print(surgeryList);
   if(surgeryController.text.isNotEmpty){
     for(int j=0;j<surgeryList.length;j++){
       for(int i=0;i<getSurgeryModel.data!.length;i++){
         if(getSurgeryModel.data![i].pastSurgery == surgeryList[j]){
           surgeryIdList.add(getSurgeryModel.data![i].id.toString());
         }
       }
     }
   }
    print(surgeryIdList);
    String surgeryIdString = surgeryIdList.join(",");
    print(surgeryIdString);
    map[CommonKeys.K_Past_Surgery] = surgeryController.text.isEmpty ? "": surgeryIdString;
    map[CommonKeys.K_Smoking_Habit] = smokingController.text.isEmpty ? Strings.kNo : smokingController.text;
    map[CommonKeys.K_Alcohol_Consumption] = alcoholController.text.isEmpty ? Strings.kNo : alcoholController.text;
    map[CommonKeys.K_Activity_Level] = activityController.text == activityLevelList[0] ? "" : activityController.text;
    List<String> foodList = foodController.text.split(" , ");
    List<String> foodIdList = [];
    print(foodList);
    if(foodController.text.isNotEmpty){
     for(int j=0;j<foodList.length;j++){
       for(int i=0;i<getFoodPreferenceModel.data!.length;i++){
         if(getFoodPreferenceModel.data![i].foodPreference == foodList[j]){
           foodIdList.add(getFoodPreferenceModel.data![i].id.toString());
         }
       }
     }
    }
    print(foodIdList);
    String foodIdString = foodIdList.join(",");
    print(foodIdString);
    map[CommonKeys.K_Food_Preference] = foodController.text.isEmpty ? "" : foodIdString;
    print(map);
    return widget.nextClick(map);
  }
}
