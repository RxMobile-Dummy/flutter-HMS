

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_management_doctor/core/strings/strings.dart';
import 'package:hospital_management_doctor/feature/profile/data/model/get_profile_model.dart';
import 'package:hospital_management_doctor/utils/colors.dart';
import 'package:hospital_management_doctor/utils/device_file.dart';
import 'package:hospital_management_doctor/widget/expandable_text.dart';
import 'package:hospital_management_doctor/widget/star_display_widget.dart';
import 'package:geocoding/geocoding.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorDetailsPage extends StatefulWidget {
  GetProfileModel getProfileModel;
  DoctorDetailsPage({Key? key,required this.getProfileModel,}) : super(key: key);

  @override
  _DoctorDetailsPageState createState() => _DoctorDetailsPageState();
}

class _DoctorDetailsPageState extends State<DoctorDetailsPage> {

  double ratings = 0.0;


  @override
  void initState() {
    if(widget.getProfileModel.data!.feedbacks!.isNotEmpty){
      for(int i=0;i<widget.getProfileModel.data!.feedbacks!.length;i++){
        ratings = ratings + double.parse(widget.getProfileModel.data!.feedbacks![i].rating.toString());
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Doctor Details",
          style: TextStyle(
              fontSize: 20,
              color: (Theme.of(context).brightness ==
                  Brightness.dark)
                  ? Colors.white
                  : Colors.black,
              fontWeight: FontWeight.w500),
        ),
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: buildWidget(),
    );
  }

  buildWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // SizedBox(height: 50,),
          Card(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              height: DeviceUtil.isTablet ? 200 :140,
                              width: MediaQuery.of(context).size.width / (DeviceUtil.isTablet ? 3.4 :2.6),
                              decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            Container(
                              height: DeviceUtil.isTablet ? 250 :190,
                              width: MediaQuery.of(context).size.width /(DeviceUtil.isTablet ? 3.4 :2.6),
                              decoration:  BoxDecoration(
                                image: DecorationImage(
                                  image: userProfilePic(
                                    imagePath:
                                    (widget.getProfileModel.data!.profilePic != null && widget.getProfileModel.data!.profilePic != "")
                                        ? "${Strings.baseUrl}${widget.getProfileModel.data!.profilePic}"
                                        : "",),
                                  //AssetImage("assets/images/ii_1.png"),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20, top: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Experience",
                                style: TextStyle(
                                    fontSize: DeviceUtil.isTablet ? 16 :14,
                                    color: (Theme.of(context).brightness ==
                                        Brightness.dark)
                                        ? Colors.white
                                        : Colors.grey.shade400,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: DeviceUtil.isTablet ? 8 :5,
                              ),
                              Text(
                                "${widget.getProfileModel.data!.yearsOfExperience} years",
                                style: TextStyle(
                                    fontSize: DeviceUtil.isTablet ? 18 :16,
                                    color: (Theme.of(context).brightness ==
                                        Brightness.dark)
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: DeviceUtil.isTablet ? 80 :50,
                              ),
                              Text(
                                "Consultancy Fees",
                                style: TextStyle(
                                    fontSize: DeviceUtil.isTablet ? 16 :14,
                                    color: (Theme.of(context).brightness ==
                                        Brightness.dark)
                                        ? Colors.white
                                        : Colors.grey.shade400,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: DeviceUtil.isTablet ? 10 :5,
                              ),
                              Text(
                                "${widget.getProfileModel.data!.inClinicAppointmentFees} \$",
                                style: TextStyle(
                                    fontSize: DeviceUtil.isTablet ? 18 :16,
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
                    SizedBox(
                      height: DeviceUtil.isTablet ? 20 :10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Dr.",
                              maxLines: 3,
                              style: TextStyle(
                                  fontSize: DeviceUtil.isTablet ? 24 :22,
                                  color: (Theme.of(context).brightness ==
                                      Brightness.dark)
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "${widget.getProfileModel.data!.firstName}",
                              maxLines: 3,
                              style: TextStyle(
                                  fontSize: DeviceUtil.isTablet ? 24 :22,
                                  color: (Theme.of(context).brightness ==
                                      Brightness.dark)
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "${widget.getProfileModel.data!.lastName}",
                              maxLines: 3,
                              style: TextStyle(
                                  fontSize: DeviceUtil.isTablet ? 24 :22,
                                  color: (Theme.of(context).brightness ==
                                      Brightness.dark)
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: DeviceUtil.isTablet ? 10 :7,
                            ),
                            Text(
                              "${widget.getProfileModel.data!.specialistField} Department",
                              style: TextStyle(
                                  fontSize: DeviceUtil.isTablet ? 18 :16,
                                  color: (Theme.of(context).brightness ==
                                      Brightness.dark)
                                      ? Colors.white
                                      : Colors.grey.shade400,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              (ratings > 0) ? Text(
                                "Feedbacks",
                                style: TextStyle(
                                    fontSize: DeviceUtil.isTablet ? 16 :14,
                                    color: (Theme.of(context).brightness ==
                                        Brightness.dark)
                                        ? Colors.white
                                        : Colors.grey.shade400,
                                    fontWeight: FontWeight.w500),
                              ) : const SizedBox(),
                              (ratings > 0) ? SizedBox(
                                height: DeviceUtil.isTablet ? 10 : 7,
                              ) : const SizedBox(),
                              (ratings > 0) ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  StarDisplayWidget(
                                    value: ratings.toInt()~/widget.getProfileModel.data!.feedbacks!.length,
                                    filledStar:  Icon(Icons.star, color: Colors.orange, size: DeviceUtil.isTablet ? 18 :15),
                                    unfilledStar:  Icon(Icons.star_border, color: Colors.grey,size: DeviceUtil.isTablet ? 18 :15,),
                                  ),
                                  Text(
                                    "  (${ratings.toInt()~/widget.getProfileModel.data!.feedbacks!.length})",
                                    style:  TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        fontFamily: 'Open Sans',
                                        fontSize: DeviceUtil.isTablet ? 18 :15,
                                        color: Colors.orange
                                    ),
                                  )
                                ],
                              ) : const SizedBox(),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Availability",
                                style: TextStyle(
                                    fontSize: DeviceUtil.isTablet ? 16 :14,
                                    color: (Theme.of(context).brightness ==
                                        Brightness.dark)
                                        ? Colors.white
                                        : Colors.grey.shade400,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: DeviceUtil.isTablet ? 10 :7,
                              ),
                              Text(
                                widget.getProfileModel.data!.nextAvailableAt ?? "",
                                style: TextStyle(
                                    fontSize: DeviceUtil.isTablet ? 18 :16,
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
                    )
                  ],
                ),
              )),
          Card(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "About",
                        style: TextStyle(
                            fontSize: DeviceUtil.isTablet ? 16 :14,
                            color: (Theme.of(context).brightness ==
                                Brightness.dark)
                                ? Colors.white
                                : Colors.grey.shade400,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: DeviceUtil.isTablet ? 10 :7,),
                       ExpandableText(
                        widget.getProfileModel.data!.about ?? "",
                        trimLines: 4,
                      )
                    ],
                  ))),
          Card(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: Text(
                          "Services At",
                          style: TextStyle(
                              fontSize: DeviceUtil.isTablet ? 16 :14,
                              color: (Theme.of(context).brightness ==
                                  Brightness.dark)
                                  ? Colors.white
                                  : Colors.grey.shade400,
                              fontWeight: FontWeight.w500),
                        ),),
                        InkWell(
                          child:  Text(
                            "View In Map",
                            style: TextStyle(
                                fontSize: DeviceUtil.isTablet ? 16 :14,
                                color: CustomColors.colorDarkBlue,
                                fontWeight: FontWeight.w500),
                          ),
                          onTap: () async {
                            List<Location> locations = await locationFromAddress("1, Tulsibaug Society, Opp. Doctor House, Nr. Parimal Garden, Ellisbridge, Ahmedabad – 380006");
                            navigateTo(locations.first.latitude, locations.first.longitude);
                          },
                        )
                      ],
                    ),
                    SizedBox(height: DeviceUtil.isTablet ? 18 :15,),
                    Text(
                      "Apollo Hospitals City Center",
                      style: TextStyle(
                          fontSize: DeviceUtil.isTablet ? 18 :16,
                          color: (Theme.of(context).brightness ==
                              Brightness.dark)
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: DeviceUtil.isTablet ? 10 :7,),
                    const Text(
                      "1, Tulsibaug Society, Opp. Doctor House, Nr. Parimal Garden, Ellisbridge, Ahmedabad – 380006",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ],
                )),
          ),
          (widget.getProfileModel.data!.feedbacks!.isNotEmpty) ? Card(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Feedbacks",
                        style: TextStyle(
                            fontSize: DeviceUtil.isTablet ? 16 :14,
                            color: (Theme.of(context).brightness ==
                                Brightness.dark)
                                ? Colors.white
                                : Colors.grey.shade400,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: DeviceUtil.isTablet ? 10 :7,),
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.getProfileModel.data!.feedbacks![index].patientName ?? "Saint Joseph",
                                style:  TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Open Sans',
                                    fontSize: DeviceUtil.isTablet ? 20 :18,
                                    color: Colors.black
                                ),
                              ),
                              SizedBox(height: DeviceUtil.isTablet ? 7 :5,),
                              Text(
                                widget.getProfileModel.data!.feedbacks![index].comment ?? "",
                                style:  TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Open Sans',
                                    fontSize: DeviceUtil.isTablet ? 17 :15,
                                    color: Colors.black
                                ),
                              ),
                              SizedBox(height: DeviceUtil.isTablet ? 7 :5,),
                              StarDisplayWidget(
                                value: double.parse(widget.getProfileModel.data!.feedbacks![index].rating ?? "").toInt(),
                                filledStar: Icon(Icons.star, color: Colors.orange, size: DeviceUtil.isTablet ? 20 :15),
                                unfilledStar: Icon(Icons.star_border, color: Colors.grey,size: DeviceUtil.isTablet ? 20 :15,),
                              ),
                              SizedBox(height: DeviceUtil.isTablet ? 20 :15,),
                            ],
                          );
                        },
                        itemCount: widget.getProfileModel.data!.feedbacks!.length,
                      )
                    ],
                  ))) : const SizedBox(),
        ],
      ),
    );
  }

  static void navigateTo(double lat, double lng) async {
    var uri = Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$lng");
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      Fluttertoast.showToast(
          msg: "Could not open google map",
          toastLength: Toast.LENGTH_LONG,
          fontSize: DeviceUtil.isTablet ? 20 : 12,
          backgroundColor: CustomColors.colorDarkBlue,
          textColor: Colors.white
      );
      //throw 'Could not launch ${uri.toString()}';
    }
  }

  userProfilePic({String? imagePath}) {
    return NetworkImage(
        (imagePath == null || imagePath == "")
            ? "https://mpng.subpng.com/20190123/jtv/kisspng-computer-icons-vector-graphics-person-portable-net-myada-baaranmy-teknik-servis-hizmetleri-5c48d5c2849149.051236271548277186543.jpg"
            : imagePath);
  }
}