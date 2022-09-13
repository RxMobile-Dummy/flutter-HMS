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
   /* if(widget.getPatientModel.data![widget.index].fileData != null
        && widget.getPatientModel.data![widget.index].fileData!.isNotEmpty){
      createFileOfPdfUrl(widget.getPatientModel.data![widget.index].fileData ?? "").then((f) {
        setState(() {
          remotePDFpath = f.path;
        });
      });
    }*/
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
        title: const Text(
          "Appointment Details",
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
      body: buildWidget(),
    );
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
                    /*  Container(
                    height: 190,
                    width: MediaQuery.of(context).size.width / 2.6,
                    decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(10)),
                  ),*/
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
                          //AssetImage("assets/images/ii_1.png"),
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
                            fontSize: DeviceUtil.isTablet ? 26 :22,
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
            (widget.getPatientModel.data![widget.index].dateOfBirth != null &&
                widget.getPatientModel.data![widget.index].dateOfBirth != "")
                ? Text(
              "Date of Birth",
              style: TextStyle(
                  fontSize: DeviceUtil.isTablet ? 18 :16,
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
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getFormattedDateFromFormattedString(
                        currentFormat: "dd-MM-yyyy - HH:mm",
                        desiredFormat: "dd MMM yyyy",
                        value:  "${widget.getPatientModel.data![widget.index].dateOfBirth} - 00:00".replaceAll("/", "-")),
                    // DateFormat.yMMMMd().format(DateTime.parse(DateFormat('dd-MM-yyyy hh:mm:ss a').parse("30/08/2022".replaceAll("/", "-")).toString())),
                    style:  TextStyle(
                        fontSize: DeviceUtil.isTablet ? 18 :16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  /*Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: VerticalDivider(
                    color: Colors.grey.shade400,
                    thickness: 2,
                  ),
                ),*/
                ],
              ),) : const SizedBox(),
            const SizedBox(height: 25,),
            Text(
              "Blood Group",
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
              widget.getPatientModel.data![widget.index].bloodGroup ?? "",
              style:  TextStyle(
                  fontSize: DeviceUtil.isTablet ? 18 :16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 25,),
            Text(
              "Mobile Number",
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
              widget.getPatientModel.data![widget.index].contactNumber.toString().substring(3),
              style:  TextStyle(
                  fontSize: DeviceUtil.isTablet ? 18 :16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 25,),
            Text(
              "Email",
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
              widget.getPatientModel.data![widget.index].email ?? "",
              style:  TextStyle(
                  fontSize: DeviceUtil.isTablet ? 18 :16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            /*  const SizedBox(height: 25,),
          (widget.getAppointmentModel.data![widget.index].fileData != null && widget.getAppointmentModel.data![widget.index].fileData!.isNotEmpty)
              ? Text(
            "Attachment",
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
                  SizedBox(width: 7,),
                  InkWell(
                    child: Text(
                      "View",
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
                            builder: (context) => OpenImageWidget(path: "${Strings.baseUrl}${widget.getAppointmentModel.data![widget.index].fileData}",),
                          ),
                        )
                        *//*  NetworkImage("${Strings.baseUrl}${widget.getAppointmentModel.data![widget.index].fileData}")*//*
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
          ) : const SizedBox(),*/
            const SizedBox(height: 25,),
            (widget.getPatientModel.data![widget.index].patientReportData != null)
                ? Text(
              "Report suggestion",
              style: TextStyle(
                  fontSize: DeviceUtil.isTablet ? 18 :16,
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
                  fontSize: DeviceUtil.isTablet ? 18 : 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            )
                : const SizedBox(),
            const SizedBox(height: 25,),
            (widget.getPatientModel.data![widget.index].patientReportData != null)
                ? Text(
              "Medicine Given",
              style: TextStyle(
                  fontSize: DeviceUtil.isTablet ? 18 :16,
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
                  fontSize: DeviceUtil.isTablet ? 18 : 16,
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
            ? "https://mpng.subpng.com/20190123/jtv/kisspng-computer-icons-vector-graphics-person-portable-net-myada-baaranmy-teknik-servis-hizmetleri-5c48d5c2849149.051236271548277186543.jpg"
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
    // print("Formatted date time:  $formattedDate");
    return formattedDate.toString();
  }

}
