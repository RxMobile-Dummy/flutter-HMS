import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management_doctor/core/base/base_bloc.dart';
import 'package:hospital_management_doctor/custom/progress_bar.dart';
import 'package:hospital_management_doctor/feature/appointments/data/model/get_appointment_model.dart';
import 'package:hospital_management_doctor/feature/appointments/presentation/bloc/appointment_bloc.dart';
import 'package:hospital_management_doctor/feature/appointments/presentation/bloc/appointment_event.dart';
import 'package:hospital_management_doctor/feature/appointments/presentation/bloc/appointment_state.dart';
import 'package:hospital_management_doctor/feature/appointments/presentation/bloc/appointment_status_bloc.dart';
import 'package:hospital_management_doctor/feature/appointments/presentation/pages/appointment_list_page.dart';
import 'package:hospital_management_doctor/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:hospital_management_doctor/feature/profile/presentation/pages/profile_screen.dart';
import 'package:hospital_management_doctor/utils/colors.dart';
import 'package:hospital_management_doctor/utils/device_file.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hospital_management_doctor/injection_container.dart' as Sl;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  late Widget doctorList;
  Widget dashboardWidget =   AppoinmentListPage();

  Widget appointmentWidget =  AppoinmentListPage();
  Widget profileWidget =  ProfileScreen();
  Widget? selectedWidget;
  int menuIndex = 0;
  GlobalKey keyFab = GlobalKey();
  bool isFabClicked = false;
  late AnimationController _controller;
  var doctorId;
  GetAppointmentModel getAppointmentModel = GetAppointmentModel();

  static const List<IconData> icons = const [ Icons.add_task, Icons.note_add_outlined, Icons.check_box_outlined ];
  static const _actionTitles = ['Create Post', 'Upload Photo', 'Upload Video'];
  List<String> gridNameList = [
    "Appointments",
    "Doctors",
    /*"Departments",*/
    "Profile"
    /*"Feedbacks"*/
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      doctorId = prefs.getString('id');
      await _getAppointment(doctorId ?? "","");
    });
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
                  crossAxisCount: DeviceUtil.isTablet ? 2 : 2,
                  crossAxisSpacing:DeviceUtil.isTablet ? 14 : 4,
                  mainAxisSpacing: DeviceUtil.isTablet ? 14 : 4
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
                                    BlocProvider<AppointmentStatusBloc>(
                                      create: (context) => Sl.Sl<AppointmentStatusBloc>(),
                                    ),
                                  ],
                                  child: AppoinmentListPage())),
                        );
                      }).then((value) async {
                        // await _getAppointment(doctorId ?? "","");
                      });
                    }else if(index == 1){
                     /* Future.delayed(Duration.zero, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MultiBlocProvider(
                                providers: [
                                  BlocProvider<DoctorBloc>(
                                    create: (context) => Sl.Sl<DoctorBloc>(),
                                  ),
                                  BlocProvider<AppointmentBloc>(
                                    create: (context) => Sl.Sl<AppointmentBloc>(),
                                  ),
                                ],
                                child:  DoctorListPage(),
                              )),
                        );
                      }).then((value) async {
                        await _getAppointment(patientId ?? "","");
                      });*/
                    }else if(index == 2){
                      Future.delayed(Duration.zero, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MultiBlocProvider(
                                providers: [
                                  BlocProvider<ProfileBloc>(
                                    create: (context) => Sl.Sl<ProfileBloc>(),
                                  ),
                                ],
                                child: ProfileScreen(),
                              )),
                        );
                      }).then((value) async {
                        await _getAppointment(doctorId ?? "","");
                      });
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
                                    style:  TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        fontFamily: 'Open Sans',
                                        fontSize: DeviceUtil.isTablet ? 20:15,
                                        color: Colors.black
                                    ),
                                  ),
                                  /* Text(
                                    gridNameSubTitleList[index],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        fontFamily: 'Open Sans',
                                        fontSize: 12,
                                        color: Colors.grey
                                    ),),*/

                                ],
                              )
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 0),
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

  Future<String> _getAppointment(String id,String date) {
    return Future.delayed(const Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AppointmentBloc>(context).add(
          GetAppointmentEvent(
              id: id,
              date: date));
      return "";
    });
  }

  getFormatedDate(date) {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(date);
    var outputFormat = DateFormat('dd/MM/yyyy');
    print(outputFormat.format(inputDate));
    return outputFormat.format(inputDate);
  }

  topBar(){
    return Padding(
      padding:  EdgeInsets.only(top: DeviceUtil.isTablet ? 50 : 25,left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Text(
                "Apollo Hospital",
                style:  TextStyle(
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    //fontFamily: 'Open Sans',
                    fontSize: DeviceUtil.isTablet ? 28 : 22,
                    color: Colors.white
                ),
              ),
              IconButton(
                onPressed: (){},
                icon: Icon(Icons.more_vert,color: Colors.transparent,),
              )
            ],
          ),
          Text(
            "General Hospital",
            style: TextStyle(
                fontStyle: FontStyle.normal,
                //fontFamily: 'Open Sans',
                fontSize: DeviceUtil.isTablet ? 18: 13,
                color: Colors.white24
            ),
          ),
          SizedBox(height: DeviceUtil.isTablet ? 160 :25,),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    BlocBuilder<AppointmentBloc, BaseState>(builder: (context, state)  {
                      if(state is GetAppointmentState) {
                        ProgressDialog.hideLoadingDialog(context);
                        getAppointmentModel = state.model!;
                        int count =0;
                        if(getAppointmentModel != null && getAppointmentModel.data!.isNotEmpty){
                          for(int i=0;i<getAppointmentModel.data!.length;i++){
                            if(getAppointmentModel.data![i].appointmentDate == getFormatedDate(DateTime.now().toString())){
                              count++;
                            }
                          }
                        }
                        return Text(
                          count.toString(),
                          style:  TextStyle(
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontFamily: 'Open Sans',
                              fontSize: DeviceUtil.isTablet ? 25:20,
                              color: Colors.white
                          ),
                        );
                      }
                      return  const SizedBox();

                    }),

                    const SizedBox(height: 5,),
                    Text(
                      "Today's Appointments",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Open Sans',
                          fontSize: DeviceUtil.isTablet ? 20 :16,
                          color: Colors.white24
                      ),)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    BlocBuilder<AppointmentBloc, BaseState>(builder: (context, state) {
                      if (state is GetAppointmentState) {
                        ProgressDialog.hideLoadingDialog(context);
                        getAppointmentModel = state.model!;
                        return Text(
                          getAppointmentModel.data!.length.toString(),
                          style:  TextStyle(
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontFamily: 'Open Sans',
                              fontSize: DeviceUtil.isTablet ? 25 :  20,
                              color: Colors.white
                          ),
                        );
                      }
                      return const SizedBox();
                    }),
                    const SizedBox(height: 5,),
                    Text(
                      "Total Appointment",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Open Sans',
                          fontSize:DeviceUtil.isTablet ? 20 :  16,
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
