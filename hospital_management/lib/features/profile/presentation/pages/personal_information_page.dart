import 'package:flutter/material.dart';
import 'package:hospital_management/core/strings/strings.dart';
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
        child: CustomAppBar(title: Strings.kPatientPersonalInformation, isBackPress: true),
      ),
      body: buildWidget(),
    );
  }
  buildWidget(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            customCard(title: "${Strings.kName} : ${widget.getPatientProfileModel.data!.firstName ?? ""} ${widget.getPatientProfileModel.data!.lastName ?? ""}"),
            customCard(title: "${Strings.kContactNumber} : ${widget.getPatientProfileModel.data!.contactNumber.toString().substring(3)}"),
            customCard(title: "${Strings.kEmail} : ${widget.getPatientProfileModel.data!.email}"),
            (widget.getPatientProfileModel.data!.dateOfBirth!.isNotEmpty)
                ? customCard(title: "${Strings.kDateOfBirth} : ${widget.getPatientProfileModel.data!.dateOfBirth}")
            : const SizedBox(),
            customCard(title: "${Strings.kGender} : ${widget.getPatientProfileModel.data!.gender}"),
            (widget.getPatientProfileModel.data!.height!.isNotEmpty)
                ?customCard(title: "${Strings.kHeightLabel} : ${widget.getPatientProfileModel.data!.height}")
            : const SizedBox(),
            (widget.getPatientProfileModel.data!.weight!.isNotEmpty)
            ? customCard(title: "${Strings.kWeightLabel} : ${widget.getPatientProfileModel.data!.weight}")
            : const SizedBox(),
            (widget.getPatientProfileModel.data!.maritalStatus!.isNotEmpty)
            ? customCard(title: "${Strings.kMaritalStatus} : ${widget.getPatientProfileModel.data!.maritalStatus}")
            : const SizedBox(),
            (widget.getPatientProfileModel.data!.emergencyContactNumber!.isNotEmpty)
            ? customCard(title: "${Strings.kEmergencyContactNumber} : ${widget.getPatientProfileModel.data!.emergencyContactNumber}")
            : const SizedBox(),
            (widget.getPatientProfileModel.data!.occupation!.isNotEmpty)
            ? customCard(title: "${Strings.kOccupationLabel} : ${widget.getPatientProfileModel.data!.occupation}")
            : const SizedBox(),
            (widget.getPatientProfileModel.data!.city!.isNotEmpty)
            ? customCard(title: "${Strings.kCityLabel} : ${widget.getPatientProfileModel.data!.city}")
            : const SizedBox(),
          ],
        ),
      ),
    );
  }

  customCard({String? title}){
    return (title != null || title != "") ? Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Card(
          color: Colors.grey.shade200,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical:  15),
            child: Text(
              title ?? "",
              style: CustomTextStyle.styleMedium,
            ),
          )
      ),
    ) : const SizedBox();
  }
}
