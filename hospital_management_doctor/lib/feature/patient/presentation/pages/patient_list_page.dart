import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management_doctor/core/base/base_bloc.dart';
import 'package:hospital_management_doctor/core/error_bloc_builder/error_builder_listener.dart';
import 'package:hospital_management_doctor/core/strings/strings.dart';
import 'package:hospital_management_doctor/custom/progress_bar.dart';
import 'package:hospital_management_doctor/feature/patient/data/model/get_patient_model.dart';
import 'package:hospital_management_doctor/feature/patient/presentation/bloc/patient_bloc.dart';
import 'package:hospital_management_doctor/feature/patient/presentation/bloc/patient_event.dart';
import 'package:hospital_management_doctor/feature/patient/presentation/bloc/patient_state.dart';
import 'package:hospital_management_doctor/feature/patient/presentation/pages/patient_details_page.dart';
import 'package:hospital_management_doctor/utils/colors.dart';
import 'package:hospital_management_doctor/utils/device_file.dart';
import 'package:hospital_management_doctor/utils/style.dart';
import 'package:hospital_management_doctor/widget/date_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientListPage extends StatefulWidget {
  const PatientListPage({Key? key}) : super(key: key);

  @override
  _PatientListPageState createState() => _PatientListPageState();
}

class _PatientListPageState extends State<PatientListPage> {
  GetPatientModel getPatientModel = GetPatientModel();
  String? doctorId;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController filterDateController = TextEditingController();
  TextEditingController searchController = TextEditingController();


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      doctorId = prefs.getString('id');
      await _getPatient(
          doctorId: doctorId,
          search: "");
    });
    super.initState();
  }

  Future<String> _getPatient({String? doctorId, String? search}) {
    return Future.delayed(const Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<PatientBloc>(context)
          .add(GetPatientEvent(doctorId: doctorId ?? '', search: search ?? ""));
      return "";
    });
  }

  Future<String> _searchPatient({String? doctorId, String? search}) {
    return Future.delayed(const Duration()).then((_) {
      // ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<PatientBloc>(context)
          .add(GetPatientEvent(doctorId: doctorId ?? '', search: search ?? ""));
      return "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: ErrorBlocListener<PatientBloc>(
        bloc: BlocProvider.of<PatientBloc>(context),
        // callback:  _loginUser(userName.text,tiePassword.text),
        child: BlocBuilder<PatientBloc, BaseState>(builder: (context, state) {
          if (state is GetPatientState) {
            ProgressDialog.hideLoadingDialog(context);
            getPatientModel = state.model!;
          }
          return buildWidget(); /*(getPatientModel.data != null)
              ? (getPatientModel.data!.isNotEmpty)
              ? buildWidget()
              : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/noData.jpeg",
                  height: 150,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "No Data Found",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )
              : SizedBox()*/
        }),
      ),
    );
  }

  buildWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        topBar(),
        Container(
          padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
          child: TextField(
            textInputAction: TextInputAction.search,
            controller: searchController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              suffixIcon: searchController.text.isNotEmpty
                  ? InkWell(
                      child: const Icon(
                        Icons.close,
                        color: Colors.grey,
                      ),
                      onTap: () async {
                        setState(() {
                          FocusScope.of(context).unfocus();
                          searchController.clear();
                        });
                        await _getPatient(doctorId: doctorId, search: "");
                      },
                    )
                  : const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
              contentPadding: EdgeInsets.all(15.0),
              hintText: 'Search ',
            ),
            onChanged: (string) async {
              setState(() {});
              await _searchPatient(doctorId: doctorId, search: string);
            },
          ),
        ),
        (getPatientModel.data != null)
            ? (getPatientModel.data!.isNotEmpty)
                ? Padding(
                    padding: const EdgeInsets.only(right: 10, top: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          child: Text(
                            "Apply filter",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.normal,
                                fontFamily: 'Open Sans',
                                fontSize: DeviceUtil.isTablet ? 20 : 16,
                                color: CustomColors.colorDarkBlue),
                          ),
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => StatefulBuilder(builder:
                                        (BuildContext context,
                                            StateSetter mystate) {
                                      return Theme(
                                          data: ThemeData(
                                              bottomSheetTheme:
                                                  const BottomSheetThemeData(
                                                      backgroundColor:
                                                          Colors.black,
                                                      modalBackgroundColor:
                                                          Colors.grey)),
                                          child: Padding(
                                              padding: MediaQuery.of(context)
                                                  .viewInsets,
                                              child:
                                                  applyAppointmentFilterDialog(
                                                      mystate)));
                                    }));
                          },
                        ),
                        filterDateController.text.isNotEmpty
                            ? InkWell(
                                child: Icon(
                                  Icons.close,
                                  size: DeviceUtil.isTablet ? 22 : 19,
                                ),
                                onTap: () async {
                                  filterDateController.clear();
                                  //await  _getAppointment(doctorId,"");
                                },
                              )
                            : const SizedBox()
                      ],
                    ),
                  )
                : SizedBox()
            : SizedBox(),
        (getPatientModel.data != null)
            ? (getPatientModel.data!.isNotEmpty)
                ? appointmentList()
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/noData.jpeg",
                          height: 150,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "No Data Found",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  )
            : SizedBox(),
      ],
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
        padding: const EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                          color: Colors.black,
                        ),
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          searchController.clear();
                          Navigator.of(context).pop();
                        }),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Patients",
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
            ),
            Expanded(
              child: Image.asset(
                "assets/images/departments.png",
              ),
            )
          ],
        ));
  }

  applyAppointmentFilterDialog(StateSetter mystate) {
    return Form(
      key: _formKey,
      child: Material(
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16), topLeft: Radius.circular(16)),
              color: Colors.white),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Appointment Filter",
                            style: CustomTextStyle.styleBold.copyWith(
                                color: CustomColors.colorDarkBlue,
                                fontSize: DeviceUtil.isTablet ? 20 : 18),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      DatePicker(
                        dateController: filterDateController,
                        lableText: "Filter Appointment Date",
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2023),
                        errorMessage: "Please enter filter appointment date",
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
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState?.save();
                              FocusScope.of(context).unfocus();
                              Navigator.of(context).pop();
                              //await _getAppointment(doctorId,filterDateController.text);
                            }
                          },
                          child: Text(
                            "Apply Filter",
                            style: CustomTextStyle.styleSemiBold.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                            filterDateController.clear();
                            // await _getAppointment(doctorId,"");
                          },
                          child: Text(
                            "Reset Filter",
                            style: CustomTextStyle.styleSemiBold
                                .copyWith(color: Colors.white),
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

  appointmentList() {
    return Flexible(
      child: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Future.delayed(Duration.zero, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PatientDetailsPage(
                              index: index,
                              getPatientModel: getPatientModel,
                            )),
                  );
                });
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: itemForList(index),
              ),
            );
          },
          itemCount: getPatientModel.data!.length,
        ),
      ),
    );
  }

  userProfilePic({String? imagePath}) {
    return NetworkImage((imagePath == null || imagePath == "")
        ? "https://mpng.subpng.com/20190123/jtv/kisspng-computer-icons-vector-graphics-person-portable-net-myada-baaranmy-teknik-servis-hizmetleri-5c48d5c2849149.051236271548277186543.jpg"
        : imagePath);
  }

  itemForList(int index) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        child: Stack(
          children: [
            Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            /*  Container(
                              height: 120,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  borderRadius: BorderRadius.circular(10)),
                            ),*/
                            Container(
                              height: DeviceUtil.isTablet ? 140 : 120,
                              width: DeviceUtil.isTablet ? 120 : 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: userProfilePic(
                                      imagePath: (getPatientModel.data![index]
                                                      .profilePic !=
                                                  null &&
                                              getPatientModel.data![index]
                                                      .profilePic !=
                                                  "")
                                          ? "${Strings.baseUrl}${getPatientModel.data![index].profilePic}"
                                          : "",
                                    ),
                                    //AssetImage("assets/images/ii_1.png"),
                                    fit: BoxFit.fill),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, top: 25),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "${getPatientModel.data![index].firstName} ${getPatientModel.data![index].lastName}",
                                  style: TextStyle(
                                      fontSize: DeviceUtil.isTablet ? 18 : 16,
                                      color: (Theme.of(context).brightness ==
                                              Brightness.dark)
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: DeviceUtil.isTablet ? 18 : 12,
                                ),
                                Text(
                                  getPatientModel.data![index].contactNumber
                                      .toString()
                                      .substring(
                                          3) /*"${getDoctorModel.data![index].specialistField} Department"*/,
                                  softWrap: false,
                                  overflow: TextOverflow.fade,
                                  maxLines: 4,
                                  style: TextStyle(
                                      fontSize: DeviceUtil.isTablet ? 15 : 13,
                                      color: (Theme.of(context).brightness ==
                                              Brightness.dark)
                                          ? Colors.white
                                          : Colors.grey.shade400,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: DeviceUtil.isTablet ? 18 : 12,
                                ),
                                Text(
                                  getPatientModel.data![index].email ??
                                      "" /*"${getDoctorModel.data![index].specialistField} Department"*/,
                                  softWrap: false,
                                  overflow: TextOverflow.fade,
                                  maxLines: 4,
                                  style: TextStyle(
                                      fontSize: DeviceUtil.isTablet ? 15 : 13,
                                      color: (Theme.of(context).brightness ==
                                              Brightness.dark)
                                          ? Colors.white
                                          : Colors.grey.shade400,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: DeviceUtil.isTablet ? 18 : 12,
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            getPatientModel.data![index].gender,
                                      ),
                                      const WidgetSpan(
                                        child: Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 2),
                                          child: VerticalDivider(
                                            color: Colors.grey,
                                            thickness: 2,
                                          ),
                                        ),
                                      ),
                                      /* TextSpan(
                                        text:   "${getAppointmentModel.data![index].timeSlot}",
                                      )*/
                                    ],
                                    style: TextStyle(
                                      fontSize: DeviceUtil.isTablet ? 16 : 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: DeviceUtil.isTablet ? 16 : 10,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ))
          ],
        ));
  }
}

