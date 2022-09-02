import 'package:flutter/material.dart';
import 'package:hospital_management/features/profile/data/model/get_patient_profile_model.dart';

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
    for(int i=0;i< widget.getPatientProfileModel.data!.patientAllergies!.length;i++){
        allergiesList.add(widget.getPatientProfileModel.data!.patientAllergies![i].allergy ?? "");
    }
    for(int i=0;i< widget.getPatientProfileModel.data!.patientPastSurgeries!.length;i++){
      surgeryList.add(widget.getPatientProfileModel.data!.patientPastSurgeries![i].pastSurgery ?? "");
    }
    for(int i=0;i< widget.getPatientProfileModel.data!.patientPastInjuries!.length;i++){
      injuryList.add(widget.getPatientProfileModel.data!.patientPastInjuries![i].pastInjury ?? "");
    }
    for(int i=0;i< widget.getPatientProfileModel.data!.patientFoodPreferences!.length;i++){
      foodList.add(widget.getPatientProfileModel.data!.patientFoodPreferences![i].foodPreference ?? "");
    }
    for(int i=0;i< widget.getPatientProfileModel.data!.patientCurrentMedications!.length;i++){
      medicationList.add(widget.getPatientProfileModel.data!.patientCurrentMedications![i].currentMedication ?? "");
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
            customCard(title: "Alcohol Consumption  : ${widget.getPatientProfileModel.data!.alcholConsumption}"),
            customCard(title: "Smoking Habit : ${widget.getPatientProfileModel.data!.smokingHabits}"),
            customCard(title: "Activity Level : ${widget.getPatientProfileModel.data!.activityLevel}"),
            customCard(title: "Allergy List : ${allergiesList.join(" , ")}"),
            customCard(title: "Medication List : ${medicationList.join(" , ")}"),
            customCard(title: "Past Surgeries List : ${surgeryList.join(" , ")}"),
            customCard(title: "Past Injuries List : ${injuryList.join(" , ")}"),
            customCard(title: "Food Consumption List : ${foodList.join(" , ")}"),
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
          child: Text(title ?? ""),
        )
    ) : const SizedBox();
  }
}
