import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_management/features/doctor/data/model/filter_doctor_model.dart';
import 'package:hospital_management/features/doctor/data/model/get_doctor_model.dart';
import 'package:hospital_management/features/doctor/presentation/bloc/doctor_bloc.dart';
import 'package:hospital_management/features/doctor/presentation/bloc/doctor_event.dart';
import 'package:hospital_management/features/doctor/presentation/bloc/doctor_state.dart';
import 'package:hospital_management/features/doctor/presentation/pages/doctor_details_page.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../core/error_bloc_builder/error_builder_listener.dart';
import '../../../../core/strings/strings.dart';
import '../../../../custom/progress_bar.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/device_file.dart';
import '../../../../utils/style.dart';
import '../../../../widget/custom_appbar.dart';
import '../../../../widget/drop_down.dart';
import '../../../../widget/star_display_widget.dart';
import '../../../appoinment/presentation/bloc/appointment_bloc.dart';
import '../../../appoinment/presentation/pages/book_appointment_page.dart';
import 'package:hospital_management/injection_container.dart' as Sl;

class DoctorListPage extends StatefulWidget {
  const DoctorListPage({Key? key}) : super(key: key);

  @override
  _DoctorListPageState createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController departmentController = TextEditingController();
  List<String> departmentDropDown = [
    " -- Select department -- ",
    "Gynecologist",
    "Pediatrician",
    "Dermatologist",
    "Pathology",
    "Physiatrists",
    "Radiologists",
    "Cardiologists",
    "Anesthesiologists",
    "Endocrinologists",
    "Hematologists",
    "Gastroenterologists",
    "Neurologists"
  ];
  List colors = [
    Colors.pink.shade300,
    Colors.green.shade300,
    Colors.orange.shade300,
    Colors.blue.shade100,
    Colors.yellow.shade300,
  ];
  Random random = Random();

  int index = 0;
  GetDoctorModel getDoctorModel = GetDoctorModel();
  FilterDoctorModel filterDoctorModel = FilterDoctorModel();
  String? rating;

  void changeIndex() {
    setState(() => index = random.nextInt(3));
  }

  @override
  void initState() {
    changeIndex();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _getDoctor("");
    });
    super.initState();
  }

  Future<String> _getDoctor(String specialistField) {
    return Future.delayed(const Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<DoctorBloc>(context).add(GetDoctorEvent(specialistField: specialistField));
      return "";
    });
  }

  @override
  Widget build(BuildContext context) {
    Color colorList() {
      int min = 0;
      int max = colors.length - 1;
      random = Random();
      int r = min + random.nextInt(max - min);
      Color color = colors[r];
      return color;
    }

    return Scaffold(
      body: ErrorBlocListener<DoctorBloc>(
        bloc: BlocProvider.of<DoctorBloc>(context),
        // callback:  _loginUser(userName.text,tiePassword.text),
        child: BlocBuilder<DoctorBloc, BaseState>(builder: (context, state) {
          if (state is GetDoctorState) {
            ProgressDialog.hideLoadingDialog(context);
            getDoctorModel = state.model!;
          }else if(state is FilterDoctorState){
            filterDoctorModel = state.model!;
          }
          return (getDoctorModel.data != null)
              ? (getDoctorModel.data!.isNotEmpty) ? buildWidget(colorList())
              : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/noData.jpeg",
                    height: 150,
                  ),
                  const SizedBox(height: 20,),
                  const Text(
                    "No Data Found",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              )
          )
              : Center(
                  child: CircularProgressIndicator(color: Colors.black),
                );
        }),
      ),
    );
  }

  buildWidget(Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        topBar(),
        Padding(
          padding: EdgeInsets.only(right: 10, top: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children:  [
              InkWell(
                child: const Text(
                  "Apply filter",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'Open Sans',
                      fontSize: 16,
                      color: CustomColors.colorDarkBlue
                  ),
                ),
                onTap: (){
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => StatefulBuilder(
                          builder: (BuildContext context, StateSetter mystate) {
                            return Theme(
                                data: ThemeData(
                                    bottomSheetTheme: const BottomSheetThemeData(
                                        backgroundColor: Colors.black,
                                        modalBackgroundColor: Colors.grey)),
                                child: Padding(
                                    padding: MediaQuery.of(context).viewInsets,
                                    child: applyDoctorFilterDialog(mystate)));}));
                },
              )
            ],
          ),
        ),
        doctorList(color),
      ],
    );
  }


  applyDoctorFilterDialog(StateSetter mystate) {
    return Form(
      key: _formKey,
      child: Material(
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16), topLeft: Radius.circular(16)),
              color: Colors.white),
          child:  SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16,right: 16,top: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Doctor Filter",
                            style: CustomTextStyle.styleBold.copyWith(
                              color: CustomColors.colorDarkBlue,
                              fontSize: 18
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      DropDown(
                        controller: departmentController,
                        dropDownList: departmentDropDown,
                        selectedValue:  departmentController.text,
                        label: "Select Department",
                        errorMessage: "Select Department",
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                    ],
                  ),
                ),
                Container(
                  color: CustomColors.colorDarkBlue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: TextButton(
                        onPressed: () async {
                          if(_formKey.currentState!.validate()){
                            _formKey.currentState?.save();
                            FocusScope.of(context).unfocus();
                            Navigator.of(context).pop();
                           await _getDoctor(departmentController.text);
                            /*_sendFeedback(
                              ratings: ratings,
                              comment: commentController.text,
                              doctorId: widget.doctorId,
                              hospitalId: widget.hospitalId,
                              patientId: widget.patientId,
                              staffId: widget.staffId,
                            );*/
                          }
                        },
                        child:  Text(
                          "Apply Filter",
                          style: CustomTextStyle.styleSemiBold.copyWith(color: Colors.white,),
                        ),
                      ),),
                     Expanded(
                       child:  TextButton(
                         onPressed: () async {
                           Navigator.of(context).pop();
                           departmentController.clear();
                           await _getDoctor("");
                         },
                         child:  Text(
                           "Reset Filter",
                           style: CustomTextStyle.styleSemiBold.copyWith(color: Colors.white),
                         ),
                       ),
                     )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  topBar() {
    return Container(
        height: MediaQuery.of(context).size.height / 5,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          /*image: DecorationImage(
                  image: AssetImage("assets/images/doctors.png",),
                )*/
        ),
        padding: EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: Colors.black,
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Doctors",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        //fontFamily: 'Open Sans',
                        fontSize: 22,
                        color: Colors.black),
                  )
                ],
              ),
            ),
            Image.asset(
              "assets/images/doctors.png",
            ),
          ],
        ));
  }

  doctorList(Color color) {
    return Flexible(
      child: SingleChildScrollView(
        child: Container(
            child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Future.delayed(Duration.zero, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DoctorDetailsPage(
                              index: index,
                              getDoctorModel: getDoctorModel,
                            )),
                  );
                });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: itemForList(color, index),
              ),
            );
          },
          itemCount: getDoctorModel.data!.length,
        )),
      ),
    );
  }


/*  Future<String> _filterDoctor(String specialistField) {
    return Future.delayed(const Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<DoctorBloc>(context).add(FilterDoctorEvent(specialistField: specialistField));
      return "";
    });
  }*/


  userProfilePic({String? imagePath}) {
    return NetworkImage((imagePath == null || imagePath == "")
        ? "https://mpng.subpng.com/20190123/jtv/kisspng-computer-icons-vector-graphics-person-portable-net-myada-baaranmy-teknik-servis-hizmetleri-5c48d5c2849149.051236271548277186543.jpg"
        : imagePath);
  }

  itemForList(Color color, int index) {
    double ratings = 0.0;
    if (getDoctorModel.data![index].feedbacks!.isNotEmpty) {
      for (int i = 0; i < getDoctorModel.data![index].feedbacks!.length; i++) {
        ratings = ratings +
            double.parse(
                getDoctorModel.data![index].feedbacks![i].rating.toString());
      }
    }
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color: Colors.blue.shade100
                    //color: Colors.orangeAccent.shade100,
                    ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        child: Text(
                          "Book Appointment",
                          style: CustomTextStyle.styleMedium
                              .copyWith(color: Colors.black),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MultiBlocProvider(
                                      providers: [
                                        BlocProvider<AppointmentBloc>(
                                          create: (context) =>
                                              Sl.Sl<AppointmentBloc>(),
                                        ),
                                      ],
                                      child: BookAppointmentPage(
                                          doctorId: getDoctorModel
                                              .data![index].id
                                              .toString()),
                                    )),
                          );
                          /* Future.delayed(Duration.zero, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider<DoctorBloc>(
                                      create: (context) => Sl.Sl<DoctorBloc>(),
                                    ),
                                  ],
                                  child:  BookAppointmentPage(doctorId: getDoctorModel.data![index].id.toString()),
                                )),
                          );
                        });*/
                        },
                      )
                    ],
                  ),
                )),
          ),
          Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            height: 90,
                            width: 100,
                            decoration: BoxDecoration(
                                color: colors[3],
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          Container(
                            height: 120,
                            width: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: userProfilePic(
                                  imagePath: (getDoctorModel
                                                  .data![index].profilePic !=
                                              null &&
                                          getDoctorModel
                                                  .data![index].profilePic !=
                                              "")
                                      ? "${Strings.baseUrl}${getDoctorModel.data![index].profilePic}"
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
                          children: <Widget>[
                            Text(
                              "Dr. ${getDoctorModel.data![index].firstName} ${getDoctorModel.data![index].lastName}",
                              style: TextStyle(
                                  fontSize: 16,
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
                              "${getDoctorModel.data![index].specialistField} Department",
                              softWrap: false,
                              overflow: TextOverflow.fade,
                              maxLines: 4,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: (Theme.of(context).brightness ==
                                          Brightness.dark)
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
                                Row(
                                  children: [
                                    Text(
                                      "Exp : ",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color:
                                              (Theme.of(context).brightness ==
                                                      Brightness.dark)
                                                  ? Colors.white
                                                  : Colors.grey.shade400,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      " ${getDoctorModel.data![index].yearsOfExperience} years",
                                      style: TextStyle(
                                          fontSize: 12,
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
                                  padding: EdgeInsets.only(left: 25),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Fees: ",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                (Theme.of(context).brightness ==
                                                        Brightness.dark)
                                                    ? Colors.white
                                                    : Colors.grey.shade400,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "${getDoctorModel.data![index].inClinicAppointmentFees}",
                                        style: TextStyle(
                                            fontSize: 12,
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
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  (ratings > 0)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            StarDisplayWidget(
                              value: ratings.toInt() ~/
                                  getDoctorModel.data![index].feedbacks!.length,
                              filledStar: Icon(Icons.star,
                                  color: Colors.orange, size: 15),
                              unfilledStar: Icon(
                                Icons.star_border,
                                color: Colors.grey,
                                size: 15,
                              ),
                            ),
                            Text(
                              "  (${getDoctorModel.data![index].feedbacks!.length.toString()})",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Open Sans',
                                  fontSize: 15,
                                  color: Colors.orange),
                            )
                          ],
                        )
                      : const SizedBox(),
                ],
              ))
        ],
      ),
    );
  }
}
