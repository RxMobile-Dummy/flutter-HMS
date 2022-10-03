import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hospital_management_staff/core/assets/images_name.dart';
import 'package:hospital_management_staff/core/common_keys/common_keys.dart';
import 'package:hospital_management_staff/core/strings/strings.dart';
import 'package:hospital_management_staff/feature/patient/data/model/get_patient_model.dart';
import 'package:hospital_management_staff/utils/colors.dart';
import 'package:hospital_management_staff/utils/device_file.dart';
import 'package:hospital_management_staff/widget/open_image_widget.dart';
import 'package:hospital_management_staff/widget/open_pdf_widget.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

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
        widget.getPatientModel.data![widget.index].patientMedicineReportDetails!.isNotEmpty){
      for(int i=0;i<widget.getPatientModel.data![widget.index].patientMedicineReportDetails!.length;i++){
        medicineList.add(widget.getPatientModel.data![widget.index].patientMedicineReportDetails![i].medicineName ?? "");
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
                                  ? "${CommonKeys.baseUrl}${widget.getPatientModel.data![widget.index].profilePic}"
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
            (widget.getPatientModel.data![widget.index].patientReportData != null &&
                widget.getPatientModel.data![widget.index].patientReportData!.isNotEmpty)
                ? const SizedBox(height: 10,) : const SizedBox(),
            (widget.getPatientModel.data![widget.index].patientReportData != null &&
                widget.getPatientModel.data![widget.index].patientReportData!.isNotEmpty)
                ?
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: Text(
                      widget.getPatientModel.data![widget.index].patientReportData![index].reportName ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: DeviceUtil.isTablet ? 22 : 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),),
                    widget.getPatientModel.data![widget.index].patientReportData![index].reportFile!.isNotEmpty ? Row(
                      children:  [
                        Icon(
                          Icons.remove_red_eye,
                          color: CustomColors.colorDarkBlue,
                          size: DeviceUtil.isTablet ? 20 :16,
                        ),
                        SizedBox(width: 7,),
                        InkWell(
                          child: Text(
                            Strings.kView,
                            style: TextStyle(
                                fontSize: DeviceUtil.isTablet ? 22 : 16,
                                color: CustomColors.colorDarkBlue,
                                fontWeight: FontWeight.w500),
                          ),
                          onTap: () async {
                            String path = "";
                            await  createFileOfPdfUrl(widget.getPatientModel.data![widget.index].patientReportData![index].reportFile ?? "").then((f) {
                              setState(() {
                                path = f.path;
                              });
                            });
                            if (path.isNotEmpty) {
                              (path.contains(".jpeg") ||
                                  path.contains(".jpg") ||
                                  path.contains(".png"))
                                  ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OpenImageWidget(path: "${CommonKeys.baseUrl}${widget.getPatientModel.data![widget.index].patientReportData![index].reportFile}",),
                                ),
                              )
                                  : Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PDFScreen(path: path),
                                ),
                              );
                            }
                          },
                        )
                      ],
                    )
                        : const SizedBox()
                  ],
                );
              },
              itemCount: widget.getPatientModel.data![widget.index].patientReportData!.length,
            )/*Text(
              reportList.join(" , "),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: DeviceUtil.isTablet ? 22 : 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            )*/
                : const SizedBox(),
            (widget.getPatientModel.data![widget.index].patientMedicineReportDetails != null &&
                widget.getPatientModel.data![widget.index].patientMedicineReportDetails!.isNotEmpty)
                ? const SizedBox(height: 25,) : const SizedBox(),
            (widget.getPatientModel.data![widget.index].patientMedicineReportDetails != null &&
                widget.getPatientModel.data![widget.index].patientMedicineReportDetails!.isNotEmpty)
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
            (widget.getPatientModel.data![widget.index].patientMedicineReportDetails != null &&
                widget.getPatientModel.data![widget.index].patientMedicineReportDetails!.isNotEmpty)
                ? const SizedBox(height: 10,) : const SizedBox(),
            (widget.getPatientModel.data![widget.index].patientMedicineReportDetails != null &&
                widget.getPatientModel.data![widget.index].patientMedicineReportDetails!.isNotEmpty)
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
            ? ImagesName.kDummyPersonImage
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

  Future<File> createFileOfPdfUrl(String filePath) async {
    Completer<File> completer = Completer();
    try {
      final url = "${CommonKeys.baseUrl}$filePath";
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception(Strings.kErrorParsing);
    }

    return completer.future;
  }

}
