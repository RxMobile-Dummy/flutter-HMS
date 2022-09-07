import 'package:flutter/material.dart';
import 'package:hospital_management/features/profile/data/model/get_patient_profile_model.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/device_file.dart';
import '../../../../utils/style.dart';
import '../../../../widget/custom_appbar.dart';

class PersonalInformationPage extends StatefulWidget {
  GetPatientProfileModel getPatientProfileModel;
   PersonalInformationPage({Key? key,required this.getPatientProfileModel}) : super(key: key);

  @override
  _PersonalInformationPageState createState() => _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 100),
        child: CustomAppBar(title: "Patient Personal Information", isBackPress: true),
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
            customCard(title: "Name : ${widget.getPatientProfileModel.data!.firstName ?? ""} ${widget.getPatientProfileModel.data!.lastName ?? ""}"),
            const SizedBox(height: 10,),
            customCard(title: "Contact Number : ${widget.getPatientProfileModel.data!.contactNumber.toString().substring(3)}"),
            const SizedBox(height: 10,),
            customCard(title: "Email : ${widget.getPatientProfileModel.data!.email}"),
            const SizedBox(height: 10,),
            (widget.getPatientProfileModel.data!.dateOfBirth!.isNotEmpty)
                ? customCard(title: "Date Of Birth : ${widget.getPatientProfileModel.data!.dateOfBirth}")
            : const SizedBox(),
            const SizedBox(height: 10,),
            customCard(title: "Gender : ${widget.getPatientProfileModel.data!.gender}"),
            const SizedBox(height: 10,),
            (widget.getPatientProfileModel.data!.height!.isNotEmpty)
                ?customCard(title: "Height : ${widget.getPatientProfileModel.data!.height}")
            : const SizedBox(),
            const SizedBox(height: 10,),
            (widget.getPatientProfileModel.data!.weight!.isNotEmpty)
            ? customCard(title: "Weight : ${widget.getPatientProfileModel.data!.weight}")
            : const SizedBox(),
            const SizedBox(height: 10,),
            (widget.getPatientProfileModel.data!.maritalStatus!.isNotEmpty)
            ? customCard(title: "Marital Status : ${widget.getPatientProfileModel.data!.maritalStatus}")
            : const SizedBox(),
            const SizedBox(height: 10,),
            (widget.getPatientProfileModel.data!.emergencyContactNumber!.isNotEmpty)
            ? customCard(title: "Emergency Contact number : ${widget.getPatientProfileModel.data!.emergencyContactNumber}")
            : const SizedBox(),
            const SizedBox(height: 10,),
            (widget.getPatientProfileModel.data!.occupation!.isNotEmpty)
            ? customCard(title: "Occupation : ${widget.getPatientProfileModel.data!.occupation}")
            : const SizedBox(),
            const SizedBox(height: 10,),
            (widget.getPatientProfileModel.data!.city!.isNotEmpty)
            ? customCard(title: "City : ${widget.getPatientProfileModel.data!.city}")
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
