import 'package:flutter/material.dart';
import 'package:hospital_management/features/doctor/data/model/get_doctor_model.dart';

import '../../../../core/strings/strings.dart';
import '../../../../widget/custom_appbar.dart';
import '../../../../widget/expandable_text.dart';
import '../../../../widget/star_display_widget.dart';

class DoctorDetailsPage extends StatefulWidget {
  GetDoctorModel getDoctorModel;
  int index;
   DoctorDetailsPage({Key? key,required this.getDoctorModel,required this.index}) : super(key: key);

  @override
  _DoctorDetailsPageState createState() => _DoctorDetailsPageState();
}

class _DoctorDetailsPageState extends State<DoctorDetailsPage> {

  double ratings = 0.0;


  @override
  void initState() {
    if(widget.getDoctorModel.data![widget.index].feedbacks!.isNotEmpty){
      for(int i=0;i<widget.getDoctorModel.data![widget.index].feedbacks!.length;i++){
        ratings = ratings + double.parse(widget.getDoctorModel.data![widget.index].feedbacks![i].rating.toString());
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
                              height: 140,
                              width: MediaQuery.of(context).size.width / 2.6,
                              decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            Container(
                              height: 190,
                              width: MediaQuery.of(context).size.width / 2.6,
                              decoration:  BoxDecoration(
                                image: DecorationImage(
                                  image: userProfilePic(
                                    imagePath:
                                    (widget.getDoctorModel.data![widget.index].profilePic != null && widget.getDoctorModel.data![widget.index].profilePic != "")
                                        ? "${Strings.baseUrl}${widget.getDoctorModel.data![widget.index].profilePic}"
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
                                    fontSize: 14,
                                    color: (Theme.of(context).brightness ==
                                        Brightness.dark)
                                        ? Colors.white
                                        : Colors.grey.shade400,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${widget.getDoctorModel.data![widget.index].yearsOfExperience} years",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: (Theme.of(context).brightness ==
                                        Brightness.dark)
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Text(
                                "Consultancy Fees",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: (Theme.of(context).brightness ==
                                        Brightness.dark)
                                        ? Colors.white
                                        : Colors.grey.shade400,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${widget.getDoctorModel.data![widget.index].inClinicAppointmentFees}",
                                style: TextStyle(
                                    fontSize: 16,
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
                      height: 10,
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
                                  fontSize: 22,
                                  color: (Theme.of(context).brightness ==
                                      Brightness.dark)
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "${widget.getDoctorModel.data![widget.index].firstName}",
                              maxLines: 3,
                              style: TextStyle(
                                  fontSize: 22,
                                  color: (Theme.of(context).brightness ==
                                      Brightness.dark)
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "${widget.getDoctorModel.data![widget.index].lastName}",
                              maxLines: 3,
                              style: TextStyle(
                                  fontSize: 22,
                                  color: (Theme.of(context).brightness ==
                                      Brightness.dark)
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Text(
                              "${widget.getDoctorModel.data![widget.index].specialistField} Department",
                              style: TextStyle(
                                  fontSize: 16,
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
                              Text(
                                "Feedbacks",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: (Theme.of(context).brightness ==
                                        Brightness.dark)
                                        ? Colors.white
                                        : Colors.grey.shade400,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              (ratings > 0) ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  StarDisplayWidget(
                                    value: ratings.toInt()~/widget.getDoctorModel.data![widget.index].feedbacks!.length,
                                    filledStar: const Icon(Icons.star, color: Colors.orange, size: 15),
                                    unfilledStar: const Icon(Icons.star_border, color: Colors.grey,size: 15,),
                                  ),
                                  Text(
                                    "  (${widget.getDoctorModel.data![widget.index].feedbacks!.length.toString()})",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        fontFamily: 'Open Sans',
                                        fontSize: 15,
                                        color: Colors.orange
                                    ),
                                  )
                                ],
                              ) : const SizedBox(),
                              /*Row(
                                children: const [
                                  Icon(
                                    Icons.star,
                                    color: Colors.orangeAccent,
                                    size: 18,
                                  ),
                                 *//* Text(
                                    "(${widget.getDoctorModel.data![widget.index].rating})",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: (Theme.of(context).brightness ==
                                            Brightness.dark)
                                            ? Colors.white
                                            : Colors.orangeAccent,
                                        fontWeight: FontWeight.w500),
                                  )*//*
                                ],
                              ),*/
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Availability",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: (Theme.of(context).brightness ==
                                        Brightness.dark)
                                        ? Colors.white
                                        : Colors.grey.shade400,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Text(
                                "12:00 to 13:00",
                                style: TextStyle(
                                    fontSize: 16,
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
                            fontSize: 14,
                            color: (Theme.of(context).brightness ==
                                Brightness.dark)
                                ? Colors.white
                                : Colors.grey.shade400,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 7,),
                      const ExpandableText(
                       "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."/* "${widget.getDoctorModel.data![widget.index].about}",*/
                        ,trimLines: 4,
                      )
                    ],
                  ))),
          Card(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Services At",
                      style: TextStyle(
                          fontSize: 14,
                          color: (Theme.of(context).brightness ==
                              Brightness.dark)
                              ? Colors.white
                              : Colors.grey.shade400,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 15,),
                    Text(
                        "Apollo Hospitals City Center",
                      style: TextStyle(
                          fontSize: 16,
                          color: (Theme.of(context).brightness ==
                              Brightness.dark)
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 7,),
                    const Text(
                        "1, Tulsibaug Society, Opp. Doctor House, Nr. Parimal Garden, Ellisbridge, Ahmedabad – 380006"
                    )
                  ],
                )),
          ),
          Card(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Feedbacks",
                        style: TextStyle(
                            fontSize: 14,
                            color: (Theme.of(context).brightness ==
                                Brightness.dark)
                                ? Colors.white
                                : Colors.grey.shade400,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 7,),
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.getDoctorModel.data![widget.index].feedbacks![index].patientName ?? "Saint Joseph",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Open Sans',
                                    fontSize: 18,
                                    color: Colors.black
                                ),
                              ),
                              const SizedBox(height: 5,),
                              Text(
                                  widget.getDoctorModel.data![widget.index].feedbacks![index].comment ?? "",
                                style: const TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Open Sans',
                                    fontSize: 15,
                                    color: Colors.black
                                ),
                              ),
                              const SizedBox(height: 5,),
                              StarDisplayWidget(
                                value: double.parse(widget.getDoctorModel.data![widget.index].feedbacks![index].rating ?? "").toInt(),
                                filledStar: Icon(Icons.star, color: Colors.orange, size: 15),
                                unfilledStar: Icon(Icons.star_border, color: Colors.grey,size: 15,),
                              ),
                              const SizedBox(height: 15,),
                            ],
                          );
                        },
                        itemCount: widget.getDoctorModel.data![widget.index].feedbacks!.length,
                      )
                    ],
                  ))),
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
}
