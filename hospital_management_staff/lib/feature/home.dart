import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management_staff/core/base/base_bloc.dart';
import 'package:hospital_management_staff/core/strings/strings.dart';
import 'package:hospital_management_staff/custom/progress_bar.dart';
import 'package:hospital_management_staff/feature/appointments/data/model/get_appointment_model.dart';
import 'package:hospital_management_staff/feature/appointments/presentation/bloc/appointment_bloc.dart';
import 'package:hospital_management_staff/feature/appointments/presentation/bloc/appointment_event.dart';
import 'package:hospital_management_staff/feature/appointments/presentation/bloc/appointment_state.dart';
import 'package:hospital_management_staff/feature/appointments/presentation/bloc/appointment_status_bloc.dart';
import 'package:hospital_management_staff/feature/appointments/presentation/pages/appointment_list_page.dart';
import 'package:hospital_management_staff/feature/medicine/presentation/bloc/medicine_bloc.dart';
import 'package:hospital_management_staff/feature/medicine/presentation/pages/medicine_list_page.dart';
import 'package:hospital_management_staff/feature/patient/presentation/bloc/patient_bloc.dart';
import 'package:hospital_management_staff/feature/patient/presentation/pages/patient_list_page.dart';
import 'package:hospital_management_staff/feature/profile/presentation/pages/profile_screen.dart';
import 'package:hospital_management_staff/utils/colors.dart';
import 'package:hospital_management_staff/utils/device_file.dart';
import 'package:intl/intl.dart';

import 'profile/presentation/bloc/profile_bloc.dart';
import 'package:hospital_management_staff/injection_container.dart' as Sl;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  late Widget doctorList;
  Widget? selectedWidget;
  int menuIndex = 0;
  GlobalKey keyFab = GlobalKey();
  bool isFabClicked = false;
  late AnimationController _controller;
  GetAppointmentModel getAppointmentModel = GetAppointmentModel();

  List<String> gridNameList = [
    Strings.kAppointments,
    Strings.kPatients,
    Strings.kProfile,
    Strings.kMedicine,
    Strings.kLabReport
  ];
  List imageList = [
    Strings.kAppointmentImage,
    Strings.kDepartmentImage,
    Strings.kProfileImage,
    Strings.kMedicineImage,
    Strings.kLabImage
  ];
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _getAppointment("","");
    });
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
            padding: const EdgeInsets.only(top: 8,left: 10,right: 10),
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
                      });
                    }else if(index == 1){
                      Future.delayed(Duration.zero, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MultiBlocProvider(
                                providers: [
                                  BlocProvider<PatientBloc>(
                                    create: (context) => Sl.Sl<PatientBloc>(),
                                  ),
                                ],
                                child:  PatientListPage(),
                              )),
                        );
                      });
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
                      });
                    }else if(index == 3){
                      Future.delayed(Duration.zero, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>MultiBlocProvider(
                                providers: [
                                  BlocProvider<MedicineBloc>(
                                    create: (context) => Sl.Sl<MedicineBloc>(),
                                  ),
                                ],
                                child:  MedicineListPage(),
                              )),
                        );
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
                              padding: const EdgeInsets.only(left: 15,top: 15),
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

/*  Future<String> _getAppointment(String id,String date) {
    return Future.delayed(const Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AppointmentBloc>(context).add(
          GetAppointmentEvent(
              id: id,
              date: date));
      return "";
    });
  }*/

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
                Strings.kHospitalName,
                style:  TextStyle(
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
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
            Strings.kGeneralHospitalName,
            style: TextStyle(
                fontStyle: FontStyle.normal,
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
                      Strings.kHomeAppointmentsLabel,
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
                      Strings.kTotalAppointments,
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
          ),
        ],
      ),
    );
  }

/*  getMenuItem() {
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
  }*/
}
