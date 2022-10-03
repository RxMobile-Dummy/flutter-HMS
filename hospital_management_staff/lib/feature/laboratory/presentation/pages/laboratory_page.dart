import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management_staff/core/assets/images_name.dart';
import 'package:hospital_management_staff/core/base/base_bloc.dart';
import 'package:hospital_management_staff/core/common_keys/common_keys.dart';
import 'package:hospital_management_staff/core/error_bloc_builder/error_builder_listener.dart';
import 'package:hospital_management_staff/core/strings/strings.dart';
import 'package:hospital_management_staff/custom/progress_bar.dart';
import 'package:hospital_management_staff/feature/appointments/data/model/get_appointment_model.dart';
import 'package:hospital_management_staff/feature/appointments/data/model/get_appointment_status.dart';
import 'package:hospital_management_staff/feature/appointments/presentation/bloc/appointment_bloc.dart';
import 'package:hospital_management_staff/feature/appointments/presentation/bloc/appointment_event.dart';
import 'package:hospital_management_staff/feature/appointments/presentation/bloc/appointment_state.dart';
import 'package:hospital_management_staff/feature/appointments/presentation/bloc/appointment_status_bloc.dart';
import 'package:hospital_management_staff/feature/laboratory/presentation/pages/patient_details_screen.dart';
import 'package:hospital_management_staff/utils/colors.dart';
import 'package:hospital_management_staff/utils/device_file.dart';
import 'package:hospital_management_staff/utils/style.dart';
import 'package:intl/intl.dart';
import 'package:hospital_management_staff/injection_container.dart' as Sl;

class LaboratoryPage extends StatefulWidget {
  const LaboratoryPage({Key? key}) : super(key: key);

  @override
  _LaboratoryPageState createState() => _LaboratoryPageState();
}

class _LaboratoryPageState extends State<LaboratoryPage> {
  TextEditingController searchController = TextEditingController();
  GetAppointmentModel getAppointmentModel = GetAppointmentModel();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController filterDateController = TextEditingController();
  List<String> statusRadioList = [
    Strings.kSelectStatus
  ];
  GetAppointmentStatusModel getAppointmentStatusModel = GetAppointmentStatusModel();
  String appointmentStatus = "";


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _getAppointmentStatus("");
      await _getAppointment("", "","");
    });
    super.initState();
  }

  Future<String> _getAppointment(String id,String date,String search) {
    return Future.delayed(const Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AppointmentBloc>(context).add(
          GetAppointmentEvent(
              id: id,
              date: date,
              search: search));
      return "";
    });
  }

  Future<String> _getAppointmentStatus(String id) {
    return Future.delayed(const Duration()).then((_) {
      // ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AppointmentStatusBloc>(context).add(
          GetAppointmentStatusEvent(
            id: id,));
      return "";
    });
  }

  Future<String> _searchPatient({String? id,String? date,String? search}) {
    return Future.delayed(const Duration()).then((_) {
      //ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AppointmentBloc>(context).add(
          GetAppointmentEvent(
              id: id,
              date: date,
          search: search));
      return "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:ErrorBlocListener<AppointmentBloc>(
        bloc: BlocProvider.of<AppointmentBloc>(context),
        child:  BlocBuilder<AppointmentBloc, BaseState>(builder: (context, state)  {
          if(state is GetAppointmentState) {
            ProgressDialog.hideLoadingDialog(context);
            getAppointmentModel = state.model!;
          }
          return buildWidget();
        }),
      ),
    );
  }

  buildWidget(){
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
                    await _getAppointment("","","");
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
              await _searchPatient(date: "", search: string,id: "");
            },
          ),
        ),
        (getAppointmentModel.data != null)
            ? (getAppointmentModel.data!.isNotEmpty) ? appointmentList()
            : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  ImagesName.kNoDataImage,
                  height: 150,
                ),
                const SizedBox(height: 20,),
                const Text(
                  Strings.kNoDataFound,
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ],
            )
        )
            :  const SizedBox(),
      ],
    );
  }

  appointmentList() {
    return Flexible(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 0),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Future.delayed(Duration.zero, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider<AppointmentBloc>(
                                  create: (context) =>
                                      Sl.Sl<AppointmentBloc>(),
                                ),
                                BlocProvider<AppointmentStatusBloc>(
                                  create: (context) =>
                                      Sl.Sl<AppointmentStatusBloc>(),
                                ),
                              ],
                              child:  PatientDetailsPage(index: index,getAppointmentModel: getAppointmentModel,))
                             ),
                    );
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: itemForList(index),
                ),
              );
            },
            itemCount:getAppointmentModel.data!.length,
          ),
        )
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
                ImagesName.kDepartmentImage,
              ),
            )
          ],
        ));
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
                              height:DeviceUtil.isTablet ? 140 : 120,
                              width: DeviceUtil.isTablet ? 120 : 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: userProfilePic(
                                      imagePath:
                                      (getAppointmentModel.data![index].patientProfilePic != null
                                          && getAppointmentModel.data![index].patientProfilePic != "")
                                          ? "${CommonKeys.baseUrl}${getAppointmentModel.data![index].patientProfilePic}"
                                          : "",),
                                    fit: BoxFit.fill
                                ),
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
                                  "${getAppointmentModel.data![index].firstName} ${getAppointmentModel.data![index].lastName}",
                                  style: TextStyle(
                                      fontSize: DeviceUtil.isTablet ? 20 :16,
                                      color: (Theme.of(context).brightness ==
                                          Brightness.dark)
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: DeviceUtil.isTablet ? 18 :10,
                                ),
                                Text(
                                  getAppointmentModel.data![index].disease ?? "",
                                  softWrap: false,
                                  overflow: TextOverflow.fade,
                                  maxLines: 4,
                                  style: TextStyle(
                                      fontSize: DeviceUtil.isTablet ? 18 :14,
                                      color: (Theme.of(context).brightness ==
                                          Brightness.dark)
                                          ? Colors.white
                                          : Colors.grey.shade400,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: DeviceUtil.isTablet ? 18 :10,
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:  getFormattedDateFromFormattedString(
                                            currentFormat: "dd-MM-yyyy - HH:mm",
                                            desiredFormat: "dd MMM yyyy",
                                            value:  "${getAppointmentModel.data![index].appointmentDate} - 00:00".replaceAll("/", "-")),
                                      ),
                                      const WidgetSpan(child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 2),
                                        child: VerticalDivider(
                                          color: Colors.grey,
                                          thickness: 2,
                                        ),
                                      ),),
                                      TextSpan(
                                        text:   "${getAppointmentModel.data![index].timeSlot}",
                                      )
                                    ],
                                    style: TextStyle(
                                        fontSize: DeviceUtil.isTablet ? 18 :14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(height: DeviceUtil.isTablet ? 16 :10,),
                                Row(
                                  children: [
                                    Text(
                                      "with ",
                                      softWrap: false,
                                      overflow: TextOverflow.fade,
                                      maxLines: 4,
                                      style: TextStyle(
                                          fontSize: DeviceUtil.isTablet ? 18 :14,
                                          color: (Theme.of(context).brightness ==
                                              Brightness.dark)
                                              ? Colors.white
                                              : Colors.grey.shade400,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "Dr. ${getAppointmentModel.data![index].doctorData!.firstName} ${getAppointmentModel.data![index].doctorData!.lastName}",
                                      softWrap: false,
                                      overflow: TextOverflow.fade,
                                      maxLines: 4,
                                      style: TextStyle(
                                          fontSize: DeviceUtil.isTablet ? 18 :16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: DeviceUtil.isTablet ? 18 :10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    BlocBuilder<AppointmentStatusBloc, BaseState>(builder: (context, state)  {
                                      if(state is GetAppointmentStatusState){
                                        statusRadioList = [];
                                        appointmentStatus = "";
                                        ProgressDialog.hideLoadingDialog(context);
                                        getAppointmentStatusModel = state.model!;
                                        for(int i=0;i<getAppointmentStatusModel.data!.length;i++){
                                          statusRadioList.add(getAppointmentStatusModel.data![i].status ?? "");
                                        }
                                        if(getAppointmentModel.data != null && getAppointmentModel.data!.isNotEmpty){
                                          for(int i=0;i<getAppointmentStatusModel.data!.length;i++){
                                            if(int.parse(getAppointmentModel.data![index].statusId ?? "") == getAppointmentStatusModel.data![i].aId){
                                              appointmentStatus = getAppointmentStatusModel.data![i].status ?? "";
                                            }
                                          }
                                        }
                                        return Text(
                                          appointmentStatus,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontStyle: FontStyle.normal,
                                              fontFamily: 'Open Sans',
                                              fontSize: DeviceUtil.isTablet ? 20 :16,
                                              color: (getAppointmentModel.data![index].statusId == "3")
                                                  ? CustomColors.colorGrey
                                                  :(getAppointmentModel.data![index].statusId == "4")
                                                  ?CustomColors.colorGreen
                                                  :(getAppointmentModel.data![index].statusId == "5")
                                                  ?CustomColors.colorRed
                                                  :(getAppointmentModel.data![index].statusId == "6")
                                                  ?CustomColors.colorOrange
                                                  :(getAppointmentModel.data![index].statusId == "7")
                                                  ?CustomColors.colorYellow
                                                  :CustomColors.colorDarkBlue
                                          ),
                                        );
                                      }
                                      return  const SizedBox();

                                    }),
                                  ],
                                ),
                                SizedBox(height: DeviceUtil.isTablet ? 16 :10,),
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

  userProfilePic({String? imagePath}) {
    return NetworkImage((imagePath == null || imagePath == "")
        ? ImagesName.kDummyPersonImage
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
    return formattedDate.toString();
  }
}