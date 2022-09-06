import 'package:flutter/material.dart';
import 'package:hospital_management/features/profile/data/model/get_patient_profile_model.dart';
import 'package:hospital_management/utils/style.dart';

import '../../../../widget/custom_appbar.dart';

class MedicalInformationPage extends StatefulWidget {
  GetPatientProfileModel getPatientProfileModel;
   MedicalInformationPage({Key? key,required this.getPatientProfileModel}) : super(key: key);

  @override
  _MedicalInformationPageState createState() => _MedicalInformationPageState();
}

class _MedicalInformationPageState extends State<MedicalInformationPage> {
  List<String> allergiesList = [];
  List<String> surgeryList = [];
  List<String> injuryList = [];
  List<String> foodList = [];
  List<String> medicationList = [];

  @override
  void initState() {
    if(widget.getPatientProfileModel.data!.patientAllergies!.isNotEmpty){
      for(int i=0;i< widget.getPatientProfileModel.data!.patientAllergies!.length;i++){
        allergiesList.add(widget.getPatientProfileModel.data!.patientAllergies![i].allergy ?? "");
      }
    }
    if(widget.getPatientProfileModel.data!.patientPastSurgeries!.isNotEmpty){
      for(int i=0;i< widget.getPatientProfileModel.data!.patientPastSurgeries!.length;i++){
        surgeryList.add(widget.getPatientProfileModel.data!.patientPastSurgeries![i].pastSurgery ?? "");
      }
    }
    if(widget.getPatientProfileModel.data!.patientPastInjuries!.isNotEmpty){
      for(int i=0;i< widget.getPatientProfileModel.data!.patientPastInjuries!.length;i++){
        injuryList.add(widget.getPatientProfileModel.data!.patientPastInjuries![i].pastInjury ?? "");
      }
    }
    if(widget.getPatientProfileModel.data!.patientFoodPreferences!.isNotEmpty){
      for(int i=0;i< widget.getPatientProfileModel.data!.patientFoodPreferences!.length;i++){
        foodList.add(widget.getPatientProfileModel.data!.patientFoodPreferences![i].foodPreference ?? "");
      }
    }
    if(widget.getPatientProfileModel.data!.patientCurrentMedications!.isNotEmpty){
      for(int i=0;i< widget.getPatientProfileModel.data!.patientCurrentMedications!.length;i++){
        medicationList.add(widget.getPatientProfileModel.data!.patientCurrentMedications![i].currentMedication ?? "");
      }
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 100),
        child: CustomAppBar(title: "Patient Medical Information", isBackPress: true),
      ),
      body: buildWidget(),
    );
  }

  buildWidget(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            customCard(title: "Blood group : ${widget.getPatientProfileModel.data!.bloodGroup ?? ""}"),
            const SizedBox(height: 10,),
            customCard(title: "Alcohol Consumption  : ${widget.getPatientProfileModel.data!.alcholConsumption}"),
            const SizedBox(height: 10,),
            customCard(title: "Smoking Habit : ${widget.getPatientProfileModel.data!.smokingHabits}"),
            const SizedBox(height: 10,),
            (widget.getPatientProfileModel.data!.activityLevel!.isNotEmpty)
            ? customCard(title: "Activity Level : ${widget.getPatientProfileModel.data!.activityLevel}")
            : const SizedBox(),
            const SizedBox(height: 10,),
            (allergiesList.isNotEmpty)
            ? customCard(title: "Allergy List : ${allergiesList.join(" , ")}")
            : const SizedBox(),
            const SizedBox(height: 10,),
            (medicationList.isNotEmpty)
            ? customCard(title: "Medication List : ${medicationList.join(" , ")}")
            : const SizedBox(),
            const SizedBox(height: 10,),
            (surgeryList.isNotEmpty)
            ? customCard(title: "Past Surgeries List : ${surgeryList.join(" , ")}")
            : const SizedBox(),
            const SizedBox(height: 10,),
            (injuryList.isNotEmpty)
            ? customCard(title: "Past Injuries List : ${injuryList.join(" , ")}")
            : const SizedBox(),
            const SizedBox(height: 10,),
            (foodList.isNotEmpty)
            ? customCard(title: "Food Consumption List : ${foodList.join(" , ")}")
            : const SizedBox(),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  customCard({String? title}){
    return (title != null || title != "") ? Card(
        color: Colors.grey.shade200,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical:  15),
          child: Text(
              title ?? "",
            style: CustomTextStyle.styleMedium,
          ),
        )
    ) : const SizedBox();
  }
}
