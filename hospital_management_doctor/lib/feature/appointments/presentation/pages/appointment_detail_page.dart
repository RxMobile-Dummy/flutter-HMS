import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hospital_management_doctor/core/assets/images_name.dart';
import 'package:hospital_management_doctor/core/common_keys/common_keys.dart';
import 'package:hospital_management_doctor/core/strings/strings.dart';
import 'package:hospital_management_doctor/feature/appointments/data/model/get_appointment_model.dart';
import 'package:hospital_management_doctor/utils/colors.dart';
import 'package:hospital_management_doctor/utils/device_file.dart';
import 'package:hospital_management_doctor/widget/open_image_widget.dart';
import 'package:hospital_management_doctor/widget/open_pdf_widget.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class AppointmentDetailsPage extends StatefulWidget {
  GetAppointmentModel getAppointmentModel;
  int index;
  AppointmentDetailsPage({Key? key,required this.getAppointmentModel, required this.index}) : super(key: key);

  @override
  _AppointmentDetailsPageState createState() => _AppointmentDetailsPageState();
}

class _AppointmentDetailsPageState extends State<AppointmentDetailsPage> {
  String remotePDFpath = "";
  List<String> medicineList = [];
  List<String> reportList = [];


  @override
  void initState() {
    super.initState();
    if(widget.getAppointmentModel.data![widget.index].fileData != null
        && widget.getAppointmentModel.data![widget.index].fileData!.isNotEmpty){
      createFileOfPdfUrl(widget.getAppointmentModel.data![widget.index].fileData ?? "").then((f) {
        setState(() {
          remotePDFpath = f.path;
        });
      });
    }
    if(widget.getAppointmentModel.data![widget.index].patientData != null &&
        widget.getAppointmentModel.data![widget.index].patientData != ""){
      if(widget.getAppointmentModel.data![widget.index].patientData!.patientMedicineReportDetails != null &&
          widget.getAppointmentModel.data![widget.index].patientData!.patientMedicineReportDetails!.isNotEmpty){
        for(int i=0;i<widget.getAppointmentModel.data![widget.index].patientData!.patientMedicineReportDetails!.length;i++){
          medicineList.add(widget.getAppointmentModel.data![widget.index].patientData!.patientMedicineReportDetails![i].medicineName ?? "");
        }
      }
    }
    if(widget.getAppointmentModel.data![widget.index].patientData != null &&
        widget.getAppointmentModel.data![widget.index].patientData != ""){
      if(widget.getAppointmentModel.data![widget.index].patientData!.patientReportData != null &&
          widget.getAppointmentModel.data![widget.index].patientData!.patientReportData!.isNotEmpty){
        for(int i=0;i<widget.getAppointmentModel.data![widget.index].patientData!.patientReportData!.length;i++){
          reportList.add(widget.getAppointmentModel.data![widget.index].patientData!.patientReportData![i].reportName ?? "");
        }
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
          Strings.kAppointmentDetails,
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


  buildWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                              (widget.getAppointmentModel.data![widget.index].patientProfilePic != null && widget.getAppointmentModel.data![widget.index].patientProfilePic != "")
                                  ? "${CommonKeys.baseUrl}${widget.getAppointmentModel.data![widget.index].patientProfilePic}"
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
                        "${widget.getAppointmentModel.data![widget.index].firstName}",
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
                        "${widget.getAppointmentModel.data![widget.index].lastName}",
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
            Text(
              Strings.kAppointmentOn,
              style: TextStyle(
                  fontSize: DeviceUtil.isTablet ? 20 :16,
                  color: (Theme.of(context).brightness ==
                      Brightness.dark)
                      ? Colors.white
                      : Colors.grey.shade400,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: DeviceUtil.isTablet ? 15 :10,),
            IntrinsicHeight(
              child: Row(
                children: [
                  Text(
                    getFormattedDateFromFormattedString(
                        currentFormat: "dd-MM-yyyy - HH:mm",
                        desiredFormat: "dd MMM yyyy",
                        value:  "${widget.getAppointmentModel.data![widget.index].appointmentDate} - 00:00".replaceAll("/", "-")),
                    style:  TextStyle(
                        fontSize: DeviceUtil.isTablet ? 22 :16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    child: VerticalDivider(
                      color: Colors.grey.shade400,
                      thickness: 2,
                    ),
                  ),
                  Text(
                    widget.getAppointmentModel.data![widget.index].timeSlot ?? "",
                    style:  TextStyle(
                        fontSize: DeviceUtil.isTablet ? 22 :16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),),
            const SizedBox(height: 25,),
            Text(
              Strings.kAppointmentFor,
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
              widget.getAppointmentModel.data![widget.index].disease ?? "",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: Text(
                  widget.getAppointmentModel.data![widget.index].mobileNumber.toString().substring(3),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: DeviceUtil.isTablet ? 22 : 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),),
                Row(
                  children:  [
                    Icon(
                      Icons.call,
                      color: CustomColors.colorDarkBlue,
                      size: DeviceUtil.isTablet ? 20 :16,
                    ),
                    SizedBox(width: 7,),
                    InkWell(
                      child: Text(
                        Strings.kCall,
                        style: TextStyle(
                            fontSize: DeviceUtil.isTablet ? 22 : 16,
                            color: CustomColors.colorDarkBlue,
                            fontWeight: FontWeight.w500),
                      ),
                      onTap: (){
                        UrlLauncher.launch('tel:+${widget.getAppointmentModel.data![widget.index].mobileNumber.toString().substring(3).toString()}');
                      },
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 25,),
            (widget.getAppointmentModel.data![widget.index].fileData != null && widget.getAppointmentModel.data![widget.index].fileData!.isNotEmpty)
                ? Text(
              Strings.kAttachment,
              style: TextStyle(
                  fontSize: DeviceUtil.isTablet ? 20 :16,
                  color: (Theme.of(context).brightness ==
                      Brightness.dark)
                      ? Colors.white
                      : Colors.grey.shade400,
                  fontWeight: FontWeight.w500),
            ) : const SizedBox(),
            (widget.getAppointmentModel.data![widget.index].fileData != null && widget.getAppointmentModel.data![widget.index].fileData!.isNotEmpty)
                ? const SizedBox(height: 10,) : const SizedBox(),
            (widget.getAppointmentModel.data![widget.index].fileData != null && widget.getAppointmentModel.data![widget.index].fileData!.isNotEmpty)
                ?  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: Text(
                  widget.getAppointmentModel.data![widget.index].fileData!.split('/').last,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: DeviceUtil.isTablet ? 22 : 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),),
                Row(
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
                      onTap: (){
                        if (remotePDFpath.isNotEmpty) {
                          (remotePDFpath.contains(".jpeg") ||
                              remotePDFpath.contains(".jpg") ||
                              remotePDFpath.contains(".png"))
                              ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OpenImageWidget(path: "${CommonKeys.baseUrl}${widget.getAppointmentModel.data![widget.index].fileData}",),
                            ),
                          )
                              : Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PDFScreen(path: remotePDFpath),
                            ),
                          );
                        }
                      },
                    )
                  ],
                )
              ],
            ) : const SizedBox(),
            (widget.getAppointmentModel.data![widget.index].patientData != null &&
                widget.getAppointmentModel.data![widget.index].patientData != "") ?(widget.getAppointmentModel.data![widget.index].patientData!.patientReportData != null &&
                widget.getAppointmentModel.data![widget.index].patientData!.patientReportData!.isNotEmpty)
                ? const SizedBox(height: 25,) : const SizedBox() : const SizedBox(),
            (widget.getAppointmentModel.data![widget.index].patientData != null &&
                widget.getAppointmentModel.data![widget.index].patientData != "") ? (widget.getAppointmentModel.data![widget.index].patientData!.patientReportData != null &&
                widget.getAppointmentModel.data![widget.index].patientData!.patientReportData!.isNotEmpty)
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
                : const SizedBox() : const SizedBox(),
            (widget.getAppointmentModel.data![widget.index].patientData != null &&
                widget.getAppointmentModel.data![widget.index].patientData != "") ? (widget.getAppointmentModel.data![widget.index].patientData!.patientReportData != null &&
                widget.getAppointmentModel.data![widget.index].patientData!.patientReportData!.isNotEmpty)
                ? const SizedBox(height: 10,) : const SizedBox() : const SizedBox(),
            (widget.getAppointmentModel.data![widget.index].patientData != null &&
                widget.getAppointmentModel.data![widget.index].patientData != "") ? (widget.getAppointmentModel.data![widget.index].patientData!.patientReportData != null &&
                widget.getAppointmentModel.data![widget.index].patientData!.patientReportData!.isNotEmpty)
                ?
            ListView.builder(
              shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                      return  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(child: Text(
                            widget.getAppointmentModel.data![widget.index].patientData!.patientReportData![index].reportName ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: DeviceUtil.isTablet ? 22 : 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),),
                          widget.getAppointmentModel.data![widget.index].patientData!.patientReportData![index].reportFile!.isNotEmpty ? Row(
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
                                 await  createFileOfPdfUrl(widget.getAppointmentModel.data![widget.index].patientData!.patientReportData![index].reportFile ?? "").then((f) {
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
                                        builder: (context) => OpenImageWidget(path: "${CommonKeys.baseUrl}${widget.getAppointmentModel.data![widget.index].patientData!.patientReportData![index].reportFile}",),
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
                          ) : const SizedBox()
                        ],
                      );
                },
              itemCount: widget.getAppointmentModel.data![widget.index].patientData!.patientReportData!.length,
            )/*Text(
              reportList.join(" , "),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: DeviceUtil.isTablet ? 22 : 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            )*/
                : const SizedBox() : const SizedBox(),
            (widget.getAppointmentModel.data![widget.index].patientData != null &&
                widget.getAppointmentModel.data![widget.index].patientData != "") ?(widget.getAppointmentModel.data![widget.index].patientData!.patientMedicineReportDetails != null &&
                widget.getAppointmentModel.data![widget.index].patientData!.patientMedicineReportDetails!.isNotEmpty)
                ? const SizedBox(height: 25,) : const SizedBox() : const SizedBox(),
            (widget.getAppointmentModel.data![widget.index].patientData != null &&
                widget.getAppointmentModel.data![widget.index].patientData != "") ? (widget.getAppointmentModel.data![widget.index].patientData!.patientMedicineReportDetails != null &&
                widget.getAppointmentModel.data![widget.index].patientData!.patientMedicineReportDetails!.isNotEmpty)
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
                : const SizedBox() : const SizedBox(),
            (widget.getAppointmentModel.data![widget.index].patientData != null &&
                widget.getAppointmentModel.data![widget.index].patientData != "") ? (widget.getAppointmentModel.data![widget.index].patientData!.patientMedicineReportDetails != null &&
                widget.getAppointmentModel.data![widget.index].patientData!.patientMedicineReportDetails!.isNotEmpty)
                ? const SizedBox(height: 10,) : const SizedBox() : const SizedBox(),
            (widget.getAppointmentModel.data![widget.index].patientData != null &&
                widget.getAppointmentModel.data![widget.index].patientData != "") ? (widget.getAppointmentModel.data![widget.index].patientData!.patientMedicineReportDetails != null &&
                widget.getAppointmentModel.data![widget.index].patientData!.patientMedicineReportDetails!.isNotEmpty)
                ?Text(
              medicineList.join(" , "),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: DeviceUtil.isTablet ? 22 : 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            )
                : const SizedBox() : const SizedBox(),
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

}