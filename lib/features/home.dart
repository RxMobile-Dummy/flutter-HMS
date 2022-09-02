import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management/features/appoinment/presentation/bloc/appointment_bloc.dart';
import 'package:hospital_management/features/appoinment/presentation/pages/appoinment_list_page.dart';
import 'package:hospital_management/features/appoinment/presentation/pages/appointment_details_page.dart';
import 'package:hospital_management/features/appoinment/presentation/pages/appointment_feedback_page.dart';
import 'package:hospital_management/features/appoinment/presentation/pages/book_appointment_page.dart';
import 'package:hospital_management/features/appoinment/presentation/pages/edit_appointment_page.dart';
import 'package:hospital_management/features/doctor/presentation/bloc/doctor_bloc.dart';
import 'package:hospital_management/features/doctor/presentation/pages/doctor_list_page.dart';
import 'package:hospital_management/features/feedback/presentation/bloc/feedback_bloc.dart';
import 'package:hospital_management/features/profile/presentation/bloc/patient_profile_bloc.dart';
import 'package:hospital_management/features/profile/presentation/pages/profile_page.dart';
import 'package:hospital_management/utils/colors.dart';
import 'package:hospital_management/widget/custom_appbar.dart';

import '../utils/device_file.dart';
import 'package:hospital_management/injection_container.dart' as Sl;

import 'doctor/presentation/pages/doctor_list_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin{
  late Widget doctorList;
  Widget dashboardWidget =  const AppoinmentListPage();

  Widget appointmentWidget = const AppoinmentListPage();
  Widget profileWidget = const ProfilePage();
  Widget? selectedWidget;
  int menuIndex = 0;
  GlobalKey keyFab = GlobalKey();
  bool isFabClicked = false;
  late AnimationController _controller;

  static const List<IconData> icons = const [ Icons.add_task, Icons.note_add_outlined, Icons.check_box_outlined ];
  static const _actionTitles = ['Create Post', 'Upload Photo', 'Upload Video'];
  List<String> gridNameList = [
    "Appointment",
    "Doctors",
    "Departments",
    "Profile",
    "Feedbacks"
  ];
  List<String> gridNameSubTitleList = [
    "289",
    "23",
    "14",
    "Set Profile",
    "123 people Reviewed"
  ];
  List imageList = [
    "assets/images/appointment.png",
    "assets/images/doctors.png",
    "assets/images/departments.png",
    "assets/images/profile.png",
    "assets/images/feedback.png",
  ];
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    /*doctorList =  DoctorListPage();
    selectedWidget = doctorList;*/
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: CustomColors.colorDarkBlue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: MediaQuery.of(context).size.height / 3.5,
              decoration: const BoxDecoration(
                  color: CustomColors.colorDarkBlue
              ),
              child: topBar()
          ),
          Flexible(child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(top: 8,left: 10,right: 10),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(25.0),
                    topLeft: Radius.circular(25.0))
            ),
            child: GridView.builder(
              itemCount: gridNameList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: DeviceUtil.isTablet ? 3 : 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4
              ),
              itemBuilder: (BuildContext context, int index) {
                return  InkWell(
                  onTap: (){
                    if(index == 0){
                      Future.delayed(Duration.zero, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MultiBlocProvider(
                                providers: [
                                  BlocProvider<AppointmentBloc>(
                                    create: (context) => Sl.Sl<AppointmentBloc>(),
                                  ),
                                ],
                                child:  AppoinmentListPage(),
                              )),
                        );
                      });
                    }else if(index == 1){
                      Future.delayed(Duration.zero, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MultiBlocProvider(
                                providers: [
                                  BlocProvider<DoctorBloc>(
                                    create: (context) => Sl.Sl<DoctorBloc>(),
                                  ),
                                ],
                                child:  DoctorListPage(),
                              )),
                        );
                      });
                    }else if(index == 2){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider<AppointmentBloc>(
                                  create: (context) => Sl.Sl<AppointmentBloc>(),
                                ),
                              ],
                              child:  BookAppointmentPage(doctorId:  "1"),
                            )),
                      );
                    /*  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider<AppointmentBloc>(
                                  create: (context) => Sl.Sl<AppointmentBloc>(),
                                ),
                              ],
                              child:  UpdateAppointmentPage(index: 1),
                            )),
                      );*/
                    }else if(index == 3){
                      Future.delayed(Duration.zero, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider<PatientProfileBloc>(
                                      create: (context) => Sl.Sl<PatientProfileBloc>(),
                                    ),
                                  ],
                                  child: ProfilePage(),
                              )),
                        );
                      });
                    }else if(index == 4){
                   /*   Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider<FeedbackBloc>(
                                  create: (context) => Sl.Sl<FeedbackBloc>(),
                                ),
                              ],
                              child:  AppointmentFeedbackPage(
                                patientId: "",
                                appointmentId: "",
                                doctorId: "",
                                hospitalId: "",
                                staffId: "",
                              ),
                            )),
                      );*/
                    }
                  },
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(width: 1,color: Colors.grey.shade200)
                      ),
                      //elevation: 2,
                      child: Stack(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: 15,top: 15),
                              child:  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    gridNameList[index],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        fontFamily: 'Open Sans',
                                        fontSize: 15,
                                        color: Colors.black
                                    ),
                                  ),
                                  Text(
                                    gridNameSubTitleList[index],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        fontFamily: 'Open Sans',
                                        fontSize: 12,
                                        color: Colors.grey
                                    ),),

                                ],
                              )
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 0),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(imageList[index]),
                                    fit: BoxFit.contain,
                                    alignment: Alignment.bottomCenter
                                )
                            ),
                          ),
                        ],
                      )
                  ),
                );
              },
            ),
          ))
        ],
      ),
    );
  }

  topBar(){
    return Padding(
      padding: const EdgeInsets.only(top: 25,left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              const Text(
                "Apollo Hospital",
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    //fontFamily: 'Open Sans',
                    fontSize: 22,
                    color: Colors.white
                ),
              ),
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.more_vert,color: Colors.white,),
              )
            ],
          ),
          const Text(
            "General Hospital",
            style: TextStyle(
                fontStyle: FontStyle.normal,
                //fontFamily: 'Open Sans',
                fontSize: 13,
                color: Colors.white24
            ),
          ),
          SizedBox(height: 25,),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "142",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Open Sans',
                          fontSize: 20,
                          color: Colors.white
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      "Appointments Today",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Open Sans',
                          fontSize: 16,
                          color: Colors.white24
                      ),)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "11",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Open Sans',
                          fontSize: 20,
                          color: Colors.white
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      "Doctors available",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Open Sans',
                          fontSize: 16,
                          color: Colors.white24
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  getMenuItem() {
    if (menuIndex == 0 && selectedWidget != doctorList) {
      selectedWidget = doctorList;
      setState(() {});
    } else if (menuIndex == 1 && selectedWidget != dashboardWidget) {
      selectedWidget = dashboardWidget;
      setState(() {});
    } else if (menuIndex == 2 && selectedWidget != appointmentWidget) {
      selectedWidget = appointmentWidget;
      setState(() {});
    }else if (menuIndex == 3 && selectedWidget != profileWidget) {
      selectedWidget = profileWidget;
      setState(() {});
    }
  }
}
