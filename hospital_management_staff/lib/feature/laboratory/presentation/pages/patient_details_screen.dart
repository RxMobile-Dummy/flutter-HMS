import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management_staff/core/base/base_bloc.dart';
import 'package:hospital_management_staff/core/error_bloc_builder/error_builder_listener.dart';
import 'package:hospital_management_staff/core/strings/strings.dart';
import 'package:hospital_management_staff/custom/progress_bar.dart';
import 'package:hospital_management_staff/feature/appointments/data/model/get_appointment_model.dart';
import 'package:hospital_management_staff/feature/appointments/presentation/bloc/appointment_bloc.dart';
import 'package:hospital_management_staff/feature/appointments/presentation/bloc/appointment_event.dart';
import 'package:hospital_management_staff/utils/colors.dart';
import 'package:hospital_management_staff/utils/device_file.dart';
import 'package:hospital_management_staff/widget/open_image_widget.dart';
import 'package:hospital_management_staff/widget/open_pdf_widget.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:file_picker/file_picker.dart';

class PatientDetailsPage extends StatefulWidget {
  GetAppointmentModel getAppointmentModel;
  int index;

  PatientDetailsPage(
      {Key? key, required this.getAppointmentModel, required this.index})
      : super(key: key);

  @override
  _PatientDetailsPageState createState() => _PatientDetailsPageState();
}

class _PatientDetailsPageState extends State<PatientDetailsPage> {
  String remotePDFpath = "";
  List<String> medicineList = [];
  List<String> allergyList = [];
  List<String> pastInjuryList = [];
  List<String> pastSurgeryList = [];
  List<String> foodPreferenceList = [];
  List<String> medicationList = [];
  String medicineGivenByDoctor = "";
  File? fileForReport;
  List<dynamic> reportUploadedList = [];
  Map<String,dynamic> reportMap = Map();

  @override
  void initState() {
    super.initState();
    List medicineList1 = [];
    if (widget.getAppointmentModel.data![widget.index].patientData != null) {
      for (int i = 0;
          i < widget.getAppointmentModel.data![widget.index].patientData!.patientMedicineReportDetails!.length;
          i++) {
        medicineList1.add(widget.getAppointmentModel.data![widget.index]
            .patientData!.patientMedicineReportDetails![i].medicineName);
      }
    }
    medicineGivenByDoctor = medicineList1.join(" , ");
    if (widget.getAppointmentModel.data![widget.index].fileData != null &&
        widget.getAppointmentModel.data![widget.index].fileData!.isNotEmpty) {
      createFileOfPdfUrl(
              widget.getAppointmentModel.data![widget.index].fileData ?? "")
          .then((f) {
        setState(() {
          remotePDFpath = f.path;
        });
      });
    }
    if (widget.getAppointmentModel.data![widget.index].patientData!.patientAllergies !=
            null && widget.getAppointmentModel.data![widget.index].patientData!.patientAllergies!.isNotEmpty) {
      for (int i = 0; i < widget.getAppointmentModel.data![widget.index].patientData!.patientAllergies!.length; i++) {
        allergyList.add(widget.getAppointmentModel.data![widget.index].patientData!.patientAllergies![i].allergy ?? "");
      }
    }
    if (widget.getAppointmentModel.data![widget.index].patientData!.patientPastSurgeries != null &&
        widget.getAppointmentModel.data![widget.index].patientData!.patientPastSurgeries!.isNotEmpty) {
      for (int i = 0; i < widget.getAppointmentModel.data![widget.index].patientData!.patientPastSurgeries!.length; i++) {
        pastSurgeryList.add(widget.getAppointmentModel.data![widget.index].patientData!.patientPastSurgeries![i].pastSurgery ?? "");
      }
    }
    if (widget.getAppointmentModel.data![widget.index].patientData!.patientPastInjuries != null && widget.getAppointmentModel.data![widget.index].patientData!.patientPastInjuries!.isNotEmpty) {
      for (int i = 0; i < widget.getAppointmentModel.data![widget.index].patientData!.patientPastInjuries!.length; i++) {
        pastInjuryList.add(widget.getAppointmentModel.data![widget.index].patientData!.patientPastInjuries![i].pastInjury ?? "");
      }
    }
    if (widget.getAppointmentModel.data![widget.index].patientData!.patientFoodPreferences != null &&
        widget.getAppointmentModel.data![widget.index].patientData!.patientFoodPreferences!.isNotEmpty) {
      for (int i = 0; i < widget.getAppointmentModel.data![widget.index].patientData!.patientFoodPreferences!.length; i++) {
        foodPreferenceList.add(widget.getAppointmentModel.data![widget.index].patientData!.patientFoodPreferences![i].foodPreference ?? "");
      }
    }
    if (widget.getAppointmentModel.data![widget.index].patientData!.patientCurrentMedications != null &&
        widget.getAppointmentModel.data![widget.index].patientData!.patientCurrentMedications!.isNotEmpty) {
      for (int i = 0; i < widget.getAppointmentModel.data![widget.index].patientData!.patientCurrentMedications!.length; i++) {
        medicationList.add(widget.getAppointmentModel.data![widget.index].patientData!.patientCurrentMedications![i].currentMedication ?? "");
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
        title: Text(
          Strings.kPatientDetails,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              fontSize: DeviceUtil.isTablet ? 26 : 20,
              color: Colors.black),
        ),
        leading: InkWell(
            child: Icon(
              Icons.arrow_back_ios,
              size: DeviceUtil.isTablet ? 26 : 20,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context).pop();
            }),
        actions: [
          InkWell(
              child: IconButton(
            onPressed: () {
              _updateAppointment(
                reportDescription: reportUploadedList,
                patientId: widget.getAppointmentModel.data![widget.index].patientId,
                appointmentId: widget.getAppointmentModel.data![widget.index].id.toString(),
                doctorId: widget.getAppointmentModel.data![widget.index].doctorData!.id.toString(),
                hospitalId: "",
              );
            },
            icon: Icon(
              Icons.save,
              size: DeviceUtil.isTablet ? 26 : 20,
              color: Colors.black,
            ),
          )),
        ],
      ),
      body: ErrorBlocListener<AppointmentBloc>(
        bloc: BlocProvider.of<AppointmentBloc>(context),
        child:
            BlocBuilder<AppointmentBloc, BaseState>(builder: (context, state) {
          return buildWidget();
        }),
      ),
    );
  }

  Future<String> _updateAppointment({ String? doctorId, patientId, appointmentId, hospitalId,
    List? reportDescription,}) {
    return Future.delayed(const Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AppointmentBloc>(context).add(
          UpdateAppointmentEvent(
              hospitalId: hospitalId,
              doctorId: doctorId ?? "",
              appointmentId: appointmentId,
              patientId: patientId,
              reportDescription: reportDescription ?? []));
      return "";
    });
  }



  Future<File> createFileOfPdfUrl(String filePath) async {
    Completer<File> completer = Completer();
    try {
      final url = "${Strings.baseUrl}$filePath";
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
                      height: DeviceUtil.isTablet ? 220 : 140,
                      width: MediaQuery.of(context).size.width /
                          (DeviceUtil.isTablet ? 3.2 : 2.6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: userProfilePic(
                              imagePath: (widget
                                              .getAppointmentModel
                                              .data![widget.index]
                                              .patientProfilePic !=
                                          null &&
                                      widget
                                              .getAppointmentModel
                                              .data![widget.index]
                                              .patientProfilePic !=
                                          "")
                                  ? "${Strings.baseUrl}${widget.getAppointmentModel.data![widget.index].patientProfilePic}"
                                  : "",
                            ),
                            fit: BoxFit.fill),
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
                            fontSize: DeviceUtil.isTablet ? 28 : 22,
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
                            fontSize: DeviceUtil.isTablet ? 28 : 22,
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
            const SizedBox(
              height: 25,
            ),
            Text(
              Strings.kAppointmentOn,
              style: TextStyle(
                  fontSize: DeviceUtil.isTablet ? 20 : 16,
                  color: (Theme.of(context).brightness == Brightness.dark)
                      ? Colors.white
                      : Colors.grey.shade400,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: DeviceUtil.isTablet ? 15 : 10,
            ),
            IntrinsicHeight(
              child: Row(
                children: [
                  Text(
                    getFormattedDateFromFormattedString(
                        currentFormat: "dd-MM-yyyy - HH:mm",
                        desiredFormat: "dd MMM yyyy",
                        value:
                            "${widget.getAppointmentModel.data![widget.index].appointmentDate} - 00:00"
                                .replaceAll("/", "-")),
                    style: TextStyle(
                        fontSize: DeviceUtil.isTablet ? 22 : 16,
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
                    widget.getAppointmentModel.data![widget.index].timeSlot ??
                        "",
                    style: TextStyle(
                        fontSize: DeviceUtil.isTablet ? 22 : 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              Strings.kAppointmentFor,
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
            Text(
              widget.getAppointmentModel.data![widget.index].disease ?? "",
              style: TextStyle(
                  fontSize: DeviceUtil.isTablet ? 22 : 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              Strings.kMobileNumber,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    widget.getAppointmentModel.data![widget.index].mobileNumber
                        .toString()
                        .substring(3),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: DeviceUtil.isTablet ? 22 : 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.call,
                      color: CustomColors.colorDarkBlue,
                      size: DeviceUtil.isTablet ? 20 : 16,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    InkWell(
                      child: Text(
                        Strings.kCall,
                        style: TextStyle(
                            fontSize: DeviceUtil.isTablet ? 22 : 16,
                            color: CustomColors.colorDarkBlue,
                            fontWeight: FontWeight.w500),
                      ),
                      onTap: () {
                        UrlLauncher.launch(
                            'tel:+${widget.getAppointmentModel.data![widget.index].mobileNumber.toString().substring(3).toString()}');
                      },
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            (widget.getAppointmentModel.data![widget.index].fileData != null &&
                    widget.getAppointmentModel.data![widget.index].fileData!
                        .isNotEmpty)
                ? Text(
                    Strings.kAttachment,
                    style: TextStyle(
                        fontSize: DeviceUtil.isTablet ? 20 : 16,
                        color: (Theme.of(context).brightness == Brightness.dark)
                            ? Colors.white
                            : Colors.grey.shade400,
                        fontWeight: FontWeight.w500),
                  )
                : const SizedBox(),
            (widget.getAppointmentModel.data![widget.index].fileData != null &&
                    widget.getAppointmentModel.data![widget.index].fileData!
                        .isNotEmpty)
                ? const SizedBox(
                    height: 10,
                  )
                : const SizedBox(),
            (widget.getAppointmentModel.data![widget.index].fileData != null &&
                    widget.getAppointmentModel.data![widget.index].fileData!
                        .isNotEmpty)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          widget
                              .getAppointmentModel.data![widget.index].fileData!
                              .split('/')
                              .last,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: DeviceUtil.isTablet ? 22 : 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.remove_red_eye,
                            color: CustomColors.colorDarkBlue,
                            size: DeviceUtil.isTablet ? 20 : 16,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          InkWell(
                            child: Text(
                              Strings.kView,
                              style: TextStyle(
                                  fontSize: DeviceUtil.isTablet ? 22 : 16,
                                  color: CustomColors.colorDarkBlue,
                                  fontWeight: FontWeight.w500),
                            ),
                            onTap: () {
                              if (remotePDFpath.isNotEmpty) {
                                (remotePDFpath.contains(".jpeg") ||
                                        remotePDFpath.contains(".jpg") ||
                                        remotePDFpath.contains(".png"))
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => OpenImageWidget(
                                            path:
                                                "${Strings.baseUrl}${widget.getAppointmentModel.data![widget.index].fileData}",
                                          ),
                                        ),
                                      )
                                    : Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PDFScreen(path: remotePDFpath),
                                        ),
                                      );
                              }
                            },
                          )
                        ],
                      )
                    ],
                  )
                : const SizedBox(),
            const SizedBox(
              height: 25,
            ),
            Text(
              Strings.kPatientDetails,
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${Strings.kBloodGroup} : ",
                          style: TextStyle(
                              fontSize: DeviceUtil.isTablet ? 20 : 16,
                              color: (Theme.of(context).brightness ==
                                      Brightness.dark)
                                  ? Colors.white
                                  : Colors.grey.shade400,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          widget.getAppointmentModel.data![widget.index]
                                  .patientData!.bloodGroup ??
                              "",
                          style: TextStyle(
                              fontSize: DeviceUtil.isTablet ? 20 : 16,
                              color: (Theme.of(context).brightness ==
                                      Brightness.dark)
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "${Strings.kMaritalStatus} : ",
                          style: TextStyle(
                              fontSize: DeviceUtil.isTablet ? 20 : 16,
                              color: (Theme.of(context).brightness ==
                                      Brightness.dark)
                                  ? Colors.white
                                  : Colors.grey.shade400,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          widget.getAppointmentModel.data![widget.index]
                                  .patientData!.maritalStatus ??
                              "",
                          style: TextStyle(
                              fontSize: DeviceUtil.isTablet ? 20 : 16,
                              color: (Theme.of(context).brightness ==
                                      Brightness.dark)
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "${Strings.kAlcoholConsumption} : ",
                          style: TextStyle(
                              fontSize: DeviceUtil.isTablet ? 20 : 16,
                              color: (Theme.of(context).brightness ==
                                      Brightness.dark)
                                  ? Colors.white
                                  : Colors.grey.shade400,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          widget.getAppointmentModel.data![widget.index]
                                  .patientData!.alcholConsumption ??
                              "",
                          style: TextStyle(
                              fontSize: DeviceUtil.isTablet ? 20 : 16,
                              color: (Theme.of(context).brightness ==
                                      Brightness.dark)
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "${Strings.kSmokingHabit} : ",
                          style: TextStyle(
                              fontSize: DeviceUtil.isTablet ? 20 : 16,
                              color: (Theme.of(context).brightness ==
                                      Brightness.dark)
                                  ? Colors.white
                                  : Colors.grey.shade400,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          widget.getAppointmentModel.data![widget.index]
                                  .patientData!.smokingHabits ??
                              "",
                          style: TextStyle(
                              fontSize: DeviceUtil.isTablet ? 20 : 16,
                              color: (Theme.of(context).brightness ==
                                      Brightness.dark)
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    (allergyList.isNotEmpty)
                        ? Text(
                            Strings.kAllergies,
                            style: TextStyle(
                                fontSize: DeviceUtil.isTablet ? 20 : 16,
                                color: (Theme.of(context).brightness ==
                                        Brightness.dark)
                                    ? Colors.white
                                    : Colors.grey.shade400,
                                fontWeight: FontWeight.w500),
                          )
                        : SizedBox(),
                    (allergyList.isNotEmpty)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                allergyList.join(" , "),
                                style: TextStyle(
                                    fontSize: DeviceUtil.isTablet ? 20 : 16,
                                    color: (Theme.of(context).brightness ==
                                            Brightness.dark)
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          )
                        : SizedBox(),
                    (pastSurgeryList.isNotEmpty)
                        ? Text(
                            Strings.kPastSurgeries,
                            style: TextStyle(
                                fontSize: DeviceUtil.isTablet ? 20 : 16,
                                color: (Theme.of(context).brightness ==
                                        Brightness.dark)
                                    ? Colors.white
                                    : Colors.grey.shade400,
                                fontWeight: FontWeight.w500),
                          )
                        : SizedBox(),
                    (pastSurgeryList.isNotEmpty)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pastSurgeryList.join(" , "),
                                style: TextStyle(
                                    fontSize: DeviceUtil.isTablet ? 20 : 16,
                                    color: (Theme.of(context).brightness ==
                                            Brightness.dark)
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          )
                        : SizedBox(),
                    (pastInjuryList.isNotEmpty)
                        ? Text(
                            Strings.kPastInjuries,
                            style: TextStyle(
                                fontSize: DeviceUtil.isTablet ? 20 : 16,
                                color: (Theme.of(context).brightness ==
                                        Brightness.dark)
                                    ? Colors.white
                                    : Colors.grey.shade400,
                                fontWeight: FontWeight.w500),
                          )
                        : SizedBox(),
                    (pastInjuryList.isNotEmpty)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pastInjuryList.join(" , "),
                                style: TextStyle(
                                    fontSize: DeviceUtil.isTablet ? 20 : 16,
                                    color: (Theme.of(context).brightness ==
                                            Brightness.dark)
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          )
                        : SizedBox(),
                    (foodPreferenceList.isNotEmpty)
                        ? Text(
                            Strings.kFoodPreference,
                            style: TextStyle(
                                fontSize: DeviceUtil.isTablet ? 20 : 16,
                                color: (Theme.of(context).brightness ==
                                        Brightness.dark)
                                    ? Colors.white
                                    : Colors.grey.shade400,
                                fontWeight: FontWeight.w500),
                          )
                        : SizedBox(),
                    (foodPreferenceList.isNotEmpty)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                foodPreferenceList.join(" , "),
                                style: TextStyle(
                                    fontSize: DeviceUtil.isTablet ? 20 : 16,
                                    color: (Theme.of(context).brightness ==
                                            Brightness.dark)
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          )
                        : SizedBox(),
                    (medicationList.isNotEmpty)
                        ? Text(
                            Strings.kMedication,
                            style: TextStyle(
                                fontSize: DeviceUtil.isTablet ? 20 : 16,
                                color: (Theme.of(context).brightness ==
                                        Brightness.dark)
                                    ? Colors.white
                                    : Colors.grey.shade400,
                                fontWeight: FontWeight.w500),
                          )
                        : SizedBox(),
                    (medicationList.isNotEmpty)
                        ? Text(
                            medicationList.join(" , "),
                            style: TextStyle(
                                fontSize: DeviceUtil.isTablet ? 20 : 16,
                                color: (Theme.of(context).brightness ==
                                        Brightness.dark)
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w500),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              Strings.kDoctorSuggestion,
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      Strings.kMedicineGiven,
                      style: TextStyle(
                          fontSize: DeviceUtil.isTablet ? 20 : 16,
                          color:
                              (Theme.of(context).brightness == Brightness.dark)
                                  ? Colors.white
                                  : Colors.grey.shade400,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      medicineGivenByDoctor,
                      style: TextStyle(
                          fontSize: DeviceUtil.isTablet ? 20 : 16,
                          color:
                              (Theme.of(context).brightness == Brightness.dark)
                                  ? Colors.white
                                  : Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    (widget.getAppointmentModel.data![widget.index].patientData!
                                    .patientReportData !=
                                null &&
                            widget.getAppointmentModel.data![widget.index]
                                .patientData!.patientReportData!.isNotEmpty)
                        ? Text(
                            Strings.kReportSuggestion,
                            style: TextStyle(
                                fontSize: DeviceUtil.isTablet ? 20 : 16,
                                color: (Theme.of(context).brightness ==
                                        Brightness.dark)
                                    ? Colors.white
                                    : Colors.grey.shade400,
                                fontWeight: FontWeight.w500),
                          )
                        : const SizedBox(),
                    (widget.getAppointmentModel.data![widget.index].patientData!
                                    .patientReportData !=
                                null &&
                            widget.getAppointmentModel.data![widget.index]
                                .patientData!.patientReportData!.isNotEmpty)
                        ? const SizedBox(
                            height: 7,
                          )
                        : const SizedBox(),
                    (widget.getAppointmentModel.data![widget.index].patientData!
                                    .patientReportData !=
                                null &&
                            widget.getAppointmentModel.data![widget.index]
                                .patientData!.patientReportData!.isNotEmpty)
                        ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget
                                            .getAppointmentModel
                                            .data![widget.index]
                                            .patientData!
                                            .patientReportData![index]
                                            .reportName ??
                                        "",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: DeviceUtil.isTablet ? 22 : 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  InkWell(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.upload_file,
                                          color: CustomColors.colorDarkBlue,
                                          size: DeviceUtil.isTablet ? 20 : 16,
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        (reportUploadedList.isNotEmpty &&
                                            (index) < reportUploadedList.length)
                                        ? (reportUploadedList[index]['file_data'] != null &&
                                            reportUploadedList[index]['file_data'] != "" ) ? Text(
                                          Strings.kUploaded,
                                          style: TextStyle(
                                              fontSize:
                                                  DeviceUtil.isTablet ? 22 : 16,
                                              color: CustomColors.colorDarkBlue,
                                              fontWeight: FontWeight.w500),
                                        ): Text(
                                          Strings.kUpload,
                                          style: TextStyle(
                                              fontSize:
                                              DeviceUtil.isTablet ? 22 : 16,
                                              color: CustomColors.colorDarkBlue,
                                              fontWeight: FontWeight.w500),
                                        ) : Text(
                                          Strings.kUpload,
                                          style: TextStyle(
                                              fontSize:
                                              DeviceUtil.isTablet ? 22 : 16,
                                              color: CustomColors.colorDarkBlue,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      getFromGalleryForReport(index);
                                    },
                                  ),
                                ],
                              );
                            },
                            itemCount: widget
                                .getAppointmentModel
                                .data![widget.index]
                                .patientData!
                                .patientReportData!
                                .length,
                          )
                        : SizedBox()
                  ],
                ),
              ),
            ),
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
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
                                height: DeviceUtil.isTablet ?  130 : 110,
                                width: DeviceUtil.isTablet ? 140 : 120,
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade100,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              Container(
                                height: DeviceUtil.isTablet ? 195 : 140,
                                width: DeviceUtil.isTablet ? 140 :120,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: userProfilePic(
                                      imagePath: (widget
                                                      .getAppointmentModel
                                                      .data![widget.index]
                                                      .doctorData!
                                                      .profilePic !=
                                                  null &&
                                              widget
                                                      .getAppointmentModel
                                                      .data![widget.index]
                                                      .doctorData!
                                                      .profilePic !=
                                                  "")
                                          ? "${Strings.baseUrl}${widget.getAppointmentModel.data![widget.index].doctorData!.profilePic}"
                                          : "",
                                    ), //AssetImage("assets/images/ii_1.png"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 25),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text(
                                  "Dr. ${widget.getAppointmentModel.data![widget.index].doctorData!.firstName} ${widget.getAppointmentModel.data![widget.index].doctorData!.lastName}",
                                  style: TextStyle(
                                      fontSize: DeviceUtil.isTablet ? 22 : 16,
                                      color: (Theme.of(context).brightness ==
                                              Brightness.dark)
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.w500),
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: DeviceUtil.isTablet ? 12 : 7,
                                ),
                                Text(
                                  "${widget.getAppointmentModel.data![widget.index].doctorData!.specialistField} Department",
                                  softWrap: false,
                                  overflow: TextOverflow.fade,
                                  maxLines: 4,
                                  style: TextStyle(
                                      fontSize: DeviceUtil.isTablet ? 20 : 13,
                                      color: (Theme.of(context).brightness ==
                                              Brightness.dark)
                                          ? Colors.white
                                          : Colors.grey.shade400,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: DeviceUtil.isTablet ? 15 : 10,
                                ),
                                Wrap(
                                  spacing:DeviceUtil.isTablet ? 100 : 40,
                                  children: [
                                    Text(
                                      widget
                                          .getAppointmentModel
                                          .data![widget.index]
                                          .doctorData!
                                          .contactNumber
                                          .toString()
                                          .substring(3),
                                      style: TextStyle(
                                          fontSize:
                                              DeviceUtil.isTablet ? 20 : 14,
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
                                        size: DeviceUtil.isTablet ? 22 : 14,
                                      ),
                                      onTap: () {
                                        UrlLauncher.launch(
                                            'tel:+${widget.getAppointmentModel.data![widget.index].mobileNumber.toString().substring(3).toString()}');
                                      },
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: DeviceUtil.isTablet ? 15 : 10,
                                ),
                                Text(
                                  widget.getAppointmentModel.data![widget.index]
                                          .doctorData!.email ??
                                      '',
                                  style: TextStyle(
                                      fontSize: DeviceUtil.isTablet ? 20 : 14,
                                      color: (Theme.of(context).brightness ==
                                              Brightness.dark)
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.w500),
                                  softWrap: false,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: DeviceUtil.isTablet ? 15 : 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Exp : ",
                                          style: TextStyle(
                                              fontSize:
                                                  DeviceUtil.isTablet ? 18 : 14,
                                              color: (Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark)
                                                  ? Colors.white
                                                  : Colors.grey.shade400,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          " ${widget.getAppointmentModel.data![widget.index].doctorData!.yearsOfExperience} years",
                                          style: TextStyle(
                                              fontSize:
                                                  DeviceUtil.isTablet ? 18 : 12,
                                              color: (Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark)
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Fees: ",
                                            style: TextStyle(
                                                fontSize: DeviceUtil.isTablet
                                                    ? 18
                                                    : 14,
                                                color: (Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark)
                                                    ? Colors.white
                                                    : Colors.grey.shade400,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            " ${widget.getAppointmentModel.data![widget.index].doctorData!.inClinicAppointmentFees} \$",
                                            style: TextStyle(
                                                fontSize: DeviceUtil.isTablet
                                                    ? 18
                                                    : 12,
                                                color: (Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark)
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontWeight: FontWeight.w500),
                                            softWrap: true,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: DeviceUtil.isTablet ? 15 : 10,
                                ),
                                Text(
                                  widget.getAppointmentModel.data![widget.index]
                                          .doctorData!.nextAvailableAt ??
                                      "",
                                  style: TextStyle(
                                      fontSize: DeviceUtil.isTablet ? 18 : 12,
                                      color: (Theme.of(context).brightness ==
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
    return NetworkImage((imagePath == null || imagePath == "")
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
        DateTime dateTime =
            DateFormat(currentFormat).parse(value, true).toLocal();
        formattedDate = DateFormat(desiredFormat).format(dateTime);
      } catch (e) {
        print("$e");
      }
    }
    return formattedDate.toString();
  }

  getFromGalleryForReport(int index) async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    /*PickedFile? pickedFile = await FilePiker(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );*/
    if (pickedFile != null) {
      setState(() {
        fileForReport = File(pickedFile.files.first.path ?? "");
        print(fileForReport);
        reportMap = Map();
        reportMap['report_id'] = widget
            .getAppointmentModel
            .data![widget.index]
            .patientData!
            .patientReportData![index]
            .reportId;
       /* reportMap['report_name'] = widget
            .getAppointmentModel
            .data![widget.index]
            .patientData!
            .patientReportData![index]
            .reportName;*/
        reportMap['file_data'] = fileForReport!.path;
        reportUploadedList.add(reportMap);
      });
    }
  }
}
