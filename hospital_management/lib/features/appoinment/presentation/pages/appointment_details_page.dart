import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management/core/assets/images_name.dart';
import 'package:hospital_management/core/common_keys/common_keys.dart';
import 'package:hospital_management/custom/progress_bar.dart';
import 'package:hospital_management/features/appoinment/data/model/get_appointment_model.dart';
import 'package:hospital_management/features/appoinment/data/model/get_appointment_status_model.dart';
import 'package:hospital_management/features/appoinment/presentation/bloc/appointment_bloc.dart';
import 'package:hospital_management/features/appoinment/presentation/bloc/appointment_event.dart';
import 'package:hospital_management/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/strings/strings.dart';
import '../../../../utils/device_file.dart';
import '../../../../widget/open_image_widget.dart';
import '../../../../widget/open_pdf_widget.dart';
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
  List<String> statusRadioList = [
    Strings.kSelectStatus
  ];
  GetAppointmentStatusModel getAppointmentStatusModel = GetAppointmentStatusModel();
  String appointmentStatus = "";
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
    if(widget.getAppointmentModel.data![widget.index].patientData!.patientMedicineReportDetails != null &&
        widget.getAppointmentModel.data![widget.index].patientData!.patientMedicineReportDetails!.isNotEmpty){
      for(int i=0;i<widget.getAppointmentModel.data![widget.index].patientData!.patientMedicineReportDetails!.length;i++){
        medicineList.add(widget.getAppointmentModel.data![widget.index].patientData!.patientMedicineReportDetails![i].medicineName ?? "");
      }
    }
    if(widget.getAppointmentModel.data![widget.index].patientData!.patientReportData != null &&
        widget.getAppointmentModel.data![widget.index].patientData!.patientReportData!.isNotEmpty){
      for(int i=0;i<widget.getAppointmentModel.data![widget.index].patientData!.patientReportData!.length;i++){
        reportList.add(widget.getAppointmentModel.data![widget.index].patientData!.patientReportData![i].reportName ?? "");
      }
    }

  }


  Future<String> _getAppointmentStatus(String id) {
    return Future.delayed(const Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AppointmentBloc>(context).add(
          GetAppointmentStatusEvent(
            id: id,));
      return "";
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          Strings.kAppointmentDetails,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              //fontFamily: 'Open Sans',
              fontSize: 22,
              color: Colors.black),
        ),
        leading: InkWell(
            child: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context).pop();
            }),
      ),
      body: buildWidget()
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
      throw Exception(Strings.kErrorParsingAssets);
    }

    return completer.future;
  }


  buildWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
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
                          //AssetImage("assets/images/ii_1.png"),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.getAppointmentModel.data![widget.index].firstName}",
                        maxLines: 3,
                        style: TextStyle(
                            fontSize: DeviceUtil.isTablet ? 26 :22,
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
                            fontSize: DeviceUtil.isTablet ? 26 :22,
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
                  fontSize: DeviceUtil.isTablet ? 18 :16,
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
                        fontSize: DeviceUtil.isTablet ? 18 :16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: VerticalDivider(
                      color: Colors.grey.shade400,
                      thickness: 2,
                    ),
                  ),
                  Text(
                    widget.getAppointmentModel.data![widget.index].timeSlot ?? "",
                    style:  TextStyle(
                        fontSize: DeviceUtil.isTablet ? 18 :16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),),
            const SizedBox(height: 25,),
            Text(
              Strings.kAppointmentFor,
              style: TextStyle(
                  fontSize: DeviceUtil.isTablet ? 18 :16,
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
                  fontSize: DeviceUtil.isTablet ? 18 :16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 25,),
            (widget.getAppointmentModel.data![widget.index].fileData != null && widget.getAppointmentModel.data![widget.index].fileData!.isNotEmpty)
                ? Text(
              Strings.kAttachment,
              style: TextStyle(
                  fontSize: DeviceUtil.isTablet ? 18 :16,
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
                      fontSize: DeviceUtil.isTablet ? 18 : 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),),
                Row(
                  children:  [
                    Icon(
                      Icons.remove_red_eye,
                      color: CustomColors.colorDarkBlue,
                      size: DeviceUtil.isTablet ? 18 :16,
                    ),
                    const SizedBox(width: 7,),
                    InkWell(
                      child: Text(
                        Strings.kView,
                        style: TextStyle(
                            fontSize: DeviceUtil.isTablet ? 18 : 16,
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
            (widget.getAppointmentModel.data![widget.index].patientData!.patientReportData != null &&
                widget.getAppointmentModel.data![widget.index].patientData!.patientReportData!.isNotEmpty)
                ? const SizedBox(height: 25,) : const SizedBox(),
            (widget.getAppointmentModel.data![widget.index].patientData!.patientReportData != null &&
                widget.getAppointmentModel.data![widget.index].patientData!.patientReportData!.isNotEmpty)
                ? Text(
              Strings.kReportSuggestion,
              style: TextStyle(
                  fontSize: DeviceUtil.isTablet ? 18 :16,
                  color: (Theme.of(context).brightness ==
                      Brightness.dark)
                      ? Colors.white
                      : Colors.grey.shade400,
                  fontWeight: FontWeight.w500),
            )
                : const SizedBox(),
            (widget.getAppointmentModel.data![widget.index].patientData!.patientReportData != null &&
                widget.getAppointmentModel.data![widget.index].patientData!.patientReportData!.isNotEmpty)
                ? const SizedBox(height: 10,) : const SizedBox(),
            (widget.getAppointmentModel.data![widget.index].patientData!.patientReportData != null &&
                widget.getAppointmentModel.data![widget.index].patientData!.patientReportData!.isNotEmpty)
                ?Text(
              reportList.join(" , "),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: DeviceUtil.isTablet ? 18 : 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            )
                : const SizedBox(),
            (widget.getAppointmentModel.data![widget.index].patientData!.patientReportData != null &&
                widget.getAppointmentModel.data![widget.index].patientData!.patientReportData!.isNotEmpty)
                ? const SizedBox(height: 25,) : const SizedBox(),
            (widget.getAppointmentModel.data![widget.index].patientData!.patientMedicineReportDetails != null &&
                widget.getAppointmentModel.data![widget.index].patientData!.patientMedicineReportDetails!.isNotEmpty)
                ? Text(
              Strings.kMedicineGiven,
              style: TextStyle(
                  fontSize: DeviceUtil.isTablet ? 18 :16,
                  color: (Theme.of(context).brightness ==
                      Brightness.dark)
                      ? Colors.white
                      : Colors.grey.shade400,
                  fontWeight: FontWeight.w500),
            )
                : const SizedBox(),
            (widget.getAppointmentModel.data![widget.index].patientData!.patientMedicineReportDetails != null &&
                widget.getAppointmentModel.data![widget.index].patientData!.patientMedicineReportDetails!.isNotEmpty)
                ? const SizedBox(height: 10,) : const SizedBox(),
            (widget.getAppointmentModel.data![widget.index].patientData!.patientMedicineReportDetails != null &&
                widget.getAppointmentModel.data![widget.index].patientData!.patientMedicineReportDetails!.isNotEmpty)
                ?Text(
              medicineList.join(" , "),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: DeviceUtil.isTablet ? 18 : 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            )
                : const SizedBox(),
            const SizedBox(
              height: 25,
            ),
            Text(
              Strings.kDoctorDetails,
              style: TextStyle(
                  fontSize: DeviceUtil.isTablet ? 20 : 16,
                  color: (Theme.of(context).brightness == Brightness.dark)
                      ? Colors.white
                      : Colors.grey.shade400,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child:  Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                height: DeviceUtil.isTablet ? 110 : 110,
                                width: DeviceUtil.isTablet ? 120 : 120,
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade100,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              Container(
                                height: DeviceUtil.isTablet ? 145 : 140,
                                width: DeviceUtil.isTablet ? 120 :120,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: userProfilePic(
                                      imagePath: (widget.getAppointmentModel
                                          .data![widget.index].doctorData!.profilePic !=
                                          null &&
                                          widget.getAppointmentModel
                                              .data![widget.index].doctorData!.profilePic !=
                                              "")
                                          ? "${CommonKeys.baseUrl}${widget.getAppointmentModel
                                          .data![widget.index].doctorData!.profilePic}"
                                          : "",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text(
                                  "Dr. ${widget.getAppointmentModel
                                      .data![widget.index].doctorData!.firstName} ${widget.getAppointmentModel
                                      .data![widget.index].doctorData!.lastName}",
                                  style: TextStyle(
                                      fontSize: DeviceUtil.isTablet ? 20 : 16,
                                      color: (Theme.of(context).brightness ==
                                          Brightness.dark)
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: DeviceUtil.isTablet ? 12 : 7,
                                ),
                                Text(
                                  "${widget.getAppointmentModel
                                      .data![widget.index].doctorData!.specialistField} ${Strings.kDepartment}",
                                  softWrap: false,
                                  overflow: TextOverflow.fade,
                                  maxLines: 4,
                                  style: TextStyle(
                                      fontSize: DeviceUtil.isTablet ? 16 :13,
                                      color: (Theme.of(context).brightness ==
                                          Brightness.dark)
                                          ? Colors.white
                                          : Colors.grey.shade400,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: DeviceUtil.isTablet ? 15 :10,
                                ),
                                Wrap(
                                  spacing: 100,
                                  children: [
                                    Text(
                                      widget.getAppointmentModel.data![widget.index].doctorData!.contactNumber.toString().substring(3),
                                      style: TextStyle(
                                          fontSize: DeviceUtil.isTablet ? 14 :14,
                                          color:
                                          (Theme.of(context).brightness ==
                                              Brightness.dark)
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    InkWell(
                                      child: Icon(
                                        Icons.call,
                                        color: CustomColors.colorDarkBlue,
                                        size: DeviceUtil.isTablet ? 20 : 14,
                                      ),
                                      onTap: () {
                                        UrlLauncher.launch(
                                            'tel:+${widget.getAppointmentModel.data![widget.index].mobileNumber.toString().substring(3).toString()}');
                                      },
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: DeviceUtil.isTablet ? 15 :10,
                                ),
                                Text(
                                  widget.getAppointmentModel.data![widget.index].doctorData!.email ?? '',
                                  style: TextStyle(
                                      fontSize: DeviceUtil.isTablet ? 14 :14,
                                      color:
                                      (Theme.of(context).brightness ==
                                          Brightness.dark)
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: DeviceUtil.isTablet ? 15 :10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          Strings.kExp,
                                          style: TextStyle(
                                              fontSize: DeviceUtil.isTablet ? 16 : 14,
                                              color:
                                              (Theme.of(context).brightness ==
                                                  Brightness.dark)
                                                  ? Colors.white
                                                  : Colors.grey.shade400,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          " ${widget.getAppointmentModel
                                              .data![widget.index].doctorData!.yearsOfExperience} ${Strings.kYears}",
                                          style: TextStyle(
                                              fontSize: DeviceUtil.isTablet ? 14 :12,
                                              color:
                                              (Theme.of(context).brightness ==
                                                  Brightness.dark)
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 25),
                                      child: Row(
                                        children: [
                                          Text(
                                            Strings.kFees,
                                            style: TextStyle(
                                                fontSize: DeviceUtil.isTablet ? 16 :14,
                                                color:
                                                (Theme.of(context).brightness ==
                                                    Brightness.dark)
                                                    ? Colors.white
                                                    : Colors.grey.shade400,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            " ${widget.getAppointmentModel
                                                .data![widget.index].doctorData!.inClinicAppointmentFees} \$",
                                            style: TextStyle(
                                                fontSize:DeviceUtil.isTablet ? 14 : 12,
                                                color:
                                                (Theme.of(context).brightness ==
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
                                SizedBox(
                                  height: DeviceUtil.isTablet ? 15 :10,
                                ),
                                Text(
                                  widget.getAppointmentModel.data![widget.index].doctorData!.nextAvailableAt ?? "",
                                  style: TextStyle(
                                      fontSize: DeviceUtil.isTablet ? 14 :12,
                                      color:
                                      (Theme.of(context).brightness ==
                                          Brightness.dark)
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            )
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
