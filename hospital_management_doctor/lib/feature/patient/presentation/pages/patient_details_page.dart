import 'package:flutter/material.dart';
import 'package:hospital_management_doctor/core/strings/strings.dart';
import 'package:hospital_management_doctor/feature/patient/data/model/get_patient_model.dart';
import 'package:hospital_management_doctor/utils/device_file.dart';
import 'package:intl/intl.dart';

class PatientDetailsPage extends StatefulWidget {
  GetPatientModel getPatientModel;
  int index;
   PatientDetailsPage({Key? key,required this.getPatientModel,required this.index}) : super(key: key);

  @override
  _PatientDetailsPageState createState() => _PatientDetailsPageState();
}

class _PatientDetailsPageState extends State<PatientDetailsPage> {
  String remotePDFpath = "";
  List<String> medicineList = [];

  @override
  void initState() {
    super.initState();
    if(widget.getPatientModel.data![widget.index].patientReportData != null &&
        widget.getPatientModel.data![widget.index].patientReportData!.medicineDetails!.isNotEmpty){
      for(int i=0;i<widget.getPatientModel.data![widget.index].patientReportData!.medicineDetails!.length;i++){
        medicineList.add(widget.getPatientModel.data![widget.index].patientReportData!.medicineDetails![i].medicineName ?? "");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title:  Text(
          Strings.kPatientDetails,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              fontSize: DeviceUtil.isTablet ? 26:20,
              color: Colors.black),
        ),
        leading: InkWell(
            child:  Icon(
              Icons.arrow_back_ios,
              size: DeviceUtil.isTablet ? 26:20,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context).pop();
            }),
      ),
      body: buildWidget(),
    );
  }

  buildWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: DeviceUtil.isTablet ? 220 :140,
                      width: MediaQuery.of(context).size.width / (DeviceUtil.isTablet ? 3.2 :2.6),
                      decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: userProfilePic(
                              imagePath:
                              (widget.getPatientModel.data![widget.index].profilePic != null && widget.getPatientModel.data![widget.index].profilePic != "")
                                  ? "${Strings.baseUrl}${widget.getPatientModel.data![widget.index].profilePic}"
                                  : "",),
                            fit: BoxFit.fill
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.getPatientModel.data![widget.index].firstName}",
                        maxLines: 3,
                        style: TextStyle(
                            fontSize: DeviceUtil.isTablet ? 28 :22,
                            color: (Theme.of(context).brightness ==
                                Brightness.dark)
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "${widget.getPatientModel.data![widget.index].lastName}",
                        maxLines: 3,
                        style: TextStyle(
                            fontSize: DeviceUtil.isTablet ? 28 :22,
                            color: (Theme.of(context).brightness ==
                                Brightness.dark)
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 25,),
            (widget.getPatientModel.data![widget.index].dateOfBirth != null &&
                widget.getPatientModel.data![widget.index].dateOfBirth != "")
                ? Text(
              Strings.kDateOfBirth,
              style: TextStyle(
                  fontSize: DeviceUtil.isTablet ? 20 :16,
                  color: (Theme.of(context).brightness ==
                      Brightness.dark)
                      ? Colors.white
                      : Colors.grey.shade400,
                  fontWeight: FontWeight.w500),
            ) : const SizedBox(),
            (widget.getPatientModel.data![widget.index].dateOfBirth != null &&
                widget.getPatientModel.data![widget.index].dateOfBirth != "")
                ?  SizedBox(height: DeviceUtil.isTablet ? 15 :10,) : const SizedBox(),
            (widget.getPatientModel.data![widget.index].dateOfBirth != null &&
                widget.getPatientModel.data![widget.index].dateOfBirth != "")
                ? IntrinsicHeight(
              child: Row(
                children: [
                  Text(
                    getFormattedDateFromFormattedString(
                        currentFormat: "dd-MM-yyyy - HH:mm",
                        desiredFormat: "dd MMM yyyy",
                        value:  "${widget.getPatientModel.data![widget.index].dateOfBirth} - 00:00".replaceAll("/", "-")),
                   style:  TextStyle(
                        fontSize: DeviceUtil.isTablet ? 22 :16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),) : const SizedBox(),
            const SizedBox(height: 25,),
            Text(
              Strings.kBloodGroup,
              style: TextStyle(
                  fontSize: DeviceUtil.isTablet ? 20 :16,
                  color: (Theme.of(context).brightness ==
                      Brightness.dark)
                      ? Colors.white
                      : Colors.grey.shade400,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10,),
            Text(
              widget.getPatientModel.data![widget.index].bloodGroup ?? "",
              style:  TextStyle(
                  fontSize: DeviceUtil.isTablet ? 22 :16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 25,),
            Text(
              Strings.kMobileNumber,
              style: TextStyle(
                  fontSize: DeviceUtil.isTablet ? 20 :16,
                  color: (Theme.of(context).brightness ==
                      Brightness.dark)
                      ? Colors.white
                      : Colors.grey.shade400,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10,),
            Text(
              widget.getPatientModel.data![widget.index].contactNumber.toString().substring(3),
              style:  TextStyle(
                  fontSize: DeviceUtil.isTablet ? 22 :16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 25,),
            Text(
              Strings.kEmail,
              style: TextStyle(
                  fontSize: DeviceUtil.isTablet ? 20 :16,
                  color: (Theme.of(context).brightness ==
                      Brightness.dark)
                      ? Colors.white
                      : Colors.grey.shade400,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10,),
            Text(
              widget.getPatientModel.data![widget.index].email ?? "",
              style:  TextStyle(
                  fontSize: DeviceUtil.isTablet ? 22 :16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 25,),
            (widget.getPatientModel.data![widget.index].patientReportData != null)
                ? Text(
              Strings.kReportSuggestion,
              style: TextStyle(
                  fontSize: DeviceUtil.isTablet ? 20 :16,
                  color: (Theme.of(context).brightness ==
                      Brightness.dark)
                      ? Colors.white
                      : Colors.grey.shade400,
                  fontWeight: FontWeight.w500),
            )
                : const SizedBox(),
            (widget.getPatientModel.data![widget.index].patientReportData != null)
                ? const SizedBox(height: 10,) : const SizedBox(),
            (widget.getPatientModel.data![widget.index].patientReportData != null)
                ?Text(
              widget.getPatientModel.data![widget.index].patientReportData!.reportDescription ?? "",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: DeviceUtil.isTablet ? 22 : 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            )
                : const SizedBox(),
            const SizedBox(height: 25,),
            (widget.getPatientModel.data![widget.index].patientReportData != null)
                ? Text(
              Strings.kMedicineGiven,
              style: TextStyle(
                  fontSize: DeviceUtil.isTablet ? 20 :16,
                  color: (Theme.of(context).brightness ==
                      Brightness.dark)
                      ? Colors.white
                      : Colors.grey.shade400,
                  fontWeight: FontWeight.w500),
            )
                : const SizedBox(),
            (widget.getPatientModel.data![widget.index].patientReportData != null)
                ? const SizedBox(height: 10,) : const SizedBox(),
            (widget.getPatientModel.data![widget.index].patientReportData != null)
                ?Text(
              medicineList.join(" , "),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: DeviceUtil.isTablet ? 22 : 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
  userProfilePic({String? imagePath}) {
    return NetworkImage(
        (imagePath == null || imagePath == "")
            ? Strings.kDummyPersonImage
            : imagePath);
  }

  String getFormattedDateFromFormattedString(
      {required String currentFormat,
        required String desiredFormat,
        String? value}) {
    String formattedDate = "";
    if (value != null || value!.isNotEmpty) {
      try {
        DateTime dateTime = DateFormat(currentFormat).parse(value, true).toLocal();
        formattedDate = DateFormat(desiredFormat).format(dateTime);
      } catch (e) {
        print("$e");
      }
    }
    return formattedDate.toString();
  }

}
