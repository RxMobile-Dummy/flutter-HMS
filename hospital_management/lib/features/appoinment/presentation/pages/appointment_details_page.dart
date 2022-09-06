import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hospital_management/features/appoinment/data/model/get_appointment_model.dart';
import 'package:hospital_management/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/strings/strings.dart';
import '../../../../utils/device_file.dart';
import '../../../../widget/open_image_widget.dart';
import '../../../../widget/open_pdf_widget.dart';

class AppointmentDetailsPage extends StatefulWidget {
  GetAppointmentModel getAppointmentModel;
  int index;
   AppointmentDetailsPage({Key? key,required this.getAppointmentModel, required this.index}) : super(key: key);

  @override
  _AppointmentDetailsPageState createState() => _AppointmentDetailsPageState();
}

class _AppointmentDetailsPageState extends State<AppointmentDetailsPage> {
  String remotePDFpath = "";
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


  Future<File> createFileOfPdfUrl(String filePath) async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
      // final url = "https://pdfkit.org/docs/guide.pdf";
      final url = "${Strings.baseUrl}$filePath";
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }


  buildWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                          (widget.getAppointmentModel.data![widget.index].patientProfilePic != null && widget.getAppointmentModel.data![widget.index].patientProfilePic != "")
                              ? "${Strings.baseUrl}${widget.getAppointmentModel.data![widget.index].patientProfilePic}"
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
            "Appointment On",
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
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getFormattedDateFromFormattedString(
                      currentFormat: "dd-MM-yyyy - HH:mm",
                      desiredFormat: "dd MMM yyyy",
                      value:  "${widget.getAppointmentModel.data![widget.index].appointmentDate} - 00:00".replaceAll("/", "-")),
                  // DateFormat.yMMMMd().format(DateTime.parse(DateFormat('dd-MM-yyyy hh:mm:ss a').parse("30/08/2022".replaceAll("/", "-")).toString())),
                  style:  TextStyle(
                      fontSize: DeviceUtil.isTablet ? 18 :16,
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
                      fontSize: DeviceUtil.isTablet ? 18 :16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),),
          const SizedBox(height: 25,),
          Text(
            "Appointment For",
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
                      /*  NetworkImage("${Strings.baseUrl}${widget.getAppointmentModel.data![widget.index].fileData}")*/
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
          ) : const SizedBox()
        ],
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
