import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management_staff/core/base/base_bloc.dart';
import 'package:hospital_management_staff/core/common_keys/common_keys.dart';
import 'package:hospital_management_staff/core/error_bloc_builder/error_builder_listener.dart';
import 'package:hospital_management_staff/core/strings/strings.dart';
import 'package:hospital_management_staff/custom/progress_bar.dart';
import 'package:hospital_management_staff/feature/patient/data/model/get_patient_model.dart';
import 'package:hospital_management_staff/feature/patient/presentation/bloc/patient_bloc.dart';
import 'package:hospital_management_staff/feature/patient/presentation/bloc/patient_event.dart';
import 'package:hospital_management_staff/feature/patient/presentation/bloc/patient_state.dart';
import 'package:hospital_management_staff/feature/patient/presentation/pages/patient_details_page.dart';
import 'package:hospital_management_staff/utils/device_file.dart';
import 'package:hospital_management_staff/utils/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientListPage extends StatefulWidget {
  const PatientListPage({Key? key}) : super(key: key);

  @override
  _PatientListPageState createState() => _PatientListPageState();
}

class _PatientListPageState extends State<PatientListPage> {
  GetPatientModel getPatientModel = GetPatientModel();
  //String? doctorId;
  TextEditingController filterDateController = TextEditingController();
  TextEditingController searchController = TextEditingController();


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
     // SharedPreferences prefs = await SharedPreferences.getInstance();
      //doctorId = prefs.getString(CommonKeys.K_Id);
      await _getPatient(
          doctorId: "",
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
        child: BlocBuilder<PatientBloc, BaseState>(builder: (context, state) {
          if (state is GetPatientState) {
            ProgressDialog.hideLoadingDialog(context);
            getPatientModel = state.model!;
          }
          return buildWidget();
        }),
      ),
    );
  }

  buildWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
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
                      child:  Icon(
                        Icons.close,
                        color: Colors.grey,
                        size: DeviceUtil.isTablet ? 28 : 26,
                      ),
                      onTap: () async {
                        setState(() {
                          FocusScope.of(context).unfocus();
                          searchController.clear();
                        });
                        await _getPatient(doctorId: "", search: "");
                      },
                    )
                  :  Icon(
                      Icons.search,
                      color: Colors.grey,
                size: DeviceUtil.isTablet ? 28 : 26,
                    ),
              contentPadding: EdgeInsets.all(15.0),
              hintText: Strings.kSearch,
              hintStyle: CustomTextStyle.styleMedium.copyWith(
                fontSize: DeviceUtil.isTablet ? 20 : 18
              )
            ),
            onChanged: (string) async {
              setState(() {});
              await _searchPatient(doctorId: "", search: string);
            },
          ),
        ),
        (getPatientModel.data != null)
            ? (getPatientModel.data!.isNotEmpty)
                ? appointmentList()
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                         Strings.kNoDataImage,
                          height: 150,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          Strings.kNoDataFound,
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
                  children: [
                    InkWell(
                        child:  Icon(
                          Icons.arrow_back_ios,
                          size: DeviceUtil.isTablet ? 26:20,
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
                     Text(
                    Strings.kPatients,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontSize: DeviceUtil.isTablet ? 26:20,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Image.asset(
                Strings.kDepartmentImage,
              ),
            )
          ],
        ));
  }


  appointmentList() {
    return Flexible(
      child:Padding(
        padding: const EdgeInsets.only(top: 30),
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 0),
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
        ? Strings.kDummyPersonImage
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
                                    fit: BoxFit.fill),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, top: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "${getPatientModel.data![index].firstName} ${getPatientModel.data![index].lastName}",
                                  style: TextStyle(
                                      fontSize: DeviceUtil.isTablet ? 20 : 16,
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
                                          3),
                                  softWrap: false,
                                  overflow: TextOverflow.fade,
                                  maxLines: 4,
                                  style: TextStyle(
                                      fontSize: DeviceUtil.isTablet ? 18 : 13,
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
                                      "",
                                  softWrap: false,
                                  overflow: TextOverflow.fade,
                                  maxLines: 4,
                                  style: TextStyle(
                                      fontSize: DeviceUtil.isTablet ? 18 : 13,
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
                                    ],
                                    style: TextStyle(
                                      fontSize: DeviceUtil.isTablet ? 18 : 14,
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

