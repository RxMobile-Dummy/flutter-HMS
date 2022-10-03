import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management_doctor/core/base/base_bloc.dart';
import 'package:hospital_management_doctor/core/common_keys/common_keys.dart';
import 'package:hospital_management_doctor/core/error_bloc_builder/error_builder_listener.dart';
import 'package:hospital_management_doctor/core/strings/strings.dart';
import 'package:hospital_management_doctor/custom/progress_bar.dart';
import 'package:hospital_management_doctor/feature/appointments/data/model/get_appointment_model.dart';
import 'package:hospital_management_doctor/feature/appointments/data/model/get_appointment_status.dart';
import 'package:hospital_management_doctor/feature/appointments/presentation/bloc/appointment_bloc.dart';
import 'package:hospital_management_doctor/feature/appointments/presentation/bloc/appointment_event.dart';
import 'package:hospital_management_doctor/feature/appointments/presentation/bloc/appointment_state.dart';
import 'package:hospital_management_doctor/feature/appointments/presentation/bloc/appointment_status_bloc.dart';
import 'package:hospital_management_doctor/feature/appointments/presentation/bloc/report_list_bloc.dart';
import 'package:hospital_management_doctor/feature/appointments/presentation/pages/appointment_detail_page.dart';
import 'package:hospital_management_doctor/feature/appointments/presentation/pages/update_appointment_page.dart';
import 'package:hospital_management_doctor/feature/medicine/presentation/bloc/medicine_bloc.dart';
import 'package:hospital_management_doctor/utils/colors.dart';
import 'package:hospital_management_doctor/utils/device_file.dart';
import 'package:hospital_management_doctor/utils/style.dart';
import 'package:hospital_management_doctor/widget/date_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hospital_management_doctor/injection_container.dart' as Sl;

class AppoinmentListPage extends StatefulWidget  {
  const AppoinmentListPage({Key? key}) : super(key: key);

  @override
  _AppoinmentListPageState createState() => _AppoinmentListPageState();
}

class _AppoinmentListPageState extends State<AppoinmentListPage> {
  GetAppointmentModel getAppointmentModel = GetAppointmentModel();
  var doctorId;
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      doctorId = prefs.getString(CommonKeys.K_Id);
      await _getAppointmentStatus("");
      await _getAppointment(doctorId ?? "","");
    });
    super.initState();
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

  Future<String> _getAppointmentStatus(String id) {
    return Future.delayed(const Duration()).then((_) {
      // ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AppointmentStatusBloc>(context).add(
          GetAppointmentStatusEvent(
            id: id,));
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
          return buildWidget();/*(getAppointmentModel.data != null)
              ? (getAppointmentModel.data!.isNotEmpty) ? buildWidget()
              : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    Strings.kNoDataImage,
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
              :  SizedBox();*/

        }),
      ),
    );
  }

  buildWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        topBar(),
        (getAppointmentModel.data != null)
            ? Padding(
          padding: EdgeInsets.only(right: 10, top: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children:  [
              InkWell(
                child:  Text(
                  Strings.kApplyFilter,
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'Open Sans',
                      fontSize:  DeviceUtil.isTablet ? 20 :16,
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
                                    child: applyAppointmentFilterDialog(mystate)));}));
                },
              ),
              filterDateController.text.isNotEmpty ? InkWell(
                child:  Icon(
                  Icons.close,
                  size: DeviceUtil.isTablet ? 22 : 19,),
                onTap: () async {
                  filterDateController.clear();
                  await  _getAppointment(doctorId,"");
                },
              ) : const SizedBox()
            ],
          ),
        )
            :  SizedBox(),
        (getAppointmentModel.data != null)
            ? (getAppointmentModel.data!.isNotEmpty) ? appointmentList()
            : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Strings.kNoDataImage,
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
            :  SizedBox(),
      ],
    );
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
                            Strings.kAppointmentFilter,
                            style: CustomTextStyle.styleBold.copyWith(
                                color: CustomColors.colorDarkBlue,
                                fontSize: DeviceUtil.isTablet ? 20 :18
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      DatePicker(
                        dateController: filterDateController,
                        lableText: Strings.kFilterAppointmentDateLabel,
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2023),
                        errorMessage: Strings.kFilterAppointmentErrorMessage,
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
                            await _getAppointment(doctorId,filterDateController.text);
                          }
                        },
                        child:  Text(
                          Strings.kApplyFilter,
                          style: CustomTextStyle.styleSemiBold.copyWith(color: Colors.white,),
                        ),
                      ),),
                      Expanded(
                        child:  TextButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                            filterDateController.clear();
                            await _getAppointment(doctorId,"");
                          },
                          child:  Text(
                            Strings.kResetFilter,
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
        ),
        padding: const EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child:  Padding(
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
                          Navigator.of(context).pop();
                        }),
                    const SizedBox(
                      height: 30,
                    ),
                     Text(
                      Strings.kAppointments,
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
              child:  Image.asset(
                Strings.kAppointmentImage,
              ),
            )
          ],
        ));
  }

  appointmentList() {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
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
                        builder: (context) => AppointmentDetailsPage(index: index,getAppointmentModel: getAppointmentModel,)),
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
            Align(
              alignment: Alignment.topRight,
              child: Container(
                  decoration:  BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      color: Colors.grey.shade200
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          child: const Icon(Icons.edit,color: CustomColors.colorDarkBlue,),
                          onTap: () async {
                            await Navigator.push(
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
                                      BlocProvider<MedicineBloc>(
                                        create: (context) => Sl.Sl<MedicineBloc>(),
                                      ),
                                      BlocProvider<ReportListBloc>(
                                        create: (context) => Sl.Sl<ReportListBloc>(),
                                      ),
                                    ],
                                    child:  UpdateAppointmentPage(
                                      doctorId: doctorId,
                                      index: index,
                                      getAppointmentModel: getAppointmentModel,
                                    ),
                                  )),
                            ).
                            then((value) async {
                                print(value);
                              await _getAppointment(doctorId, "");
                            });
                          },
                        ),
                      ],
                    ),
                  )
              ),
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
                              height:DeviceUtil.isTablet ? 140 : 120,
                              width: DeviceUtil.isTablet ? 120 : 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: userProfilePic(
                                      imagePath:
                                      (getAppointmentModel.data![index].patientProfilePic != null
                                          && getAppointmentModel.data![index].patientProfilePic != "")
                                          ? "${Strings.baseUrl}${getAppointmentModel.data![index].patientProfilePic}"
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
                                  height: DeviceUtil.isTablet ? 18 :15,
                                ),
                                Row(
                                  children: [
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
                                  ],
                                ),
                                SizedBox(
                                  height: DeviceUtil.isTablet ? 18 :15,
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
                                      WidgetSpan(child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 2),
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