import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_management_doctor/core/base/base_bloc.dart';
import 'package:hospital_management_doctor/core/common_keys/common_keys.dart';
import 'package:hospital_management_doctor/core/error_bloc_builder/error_builder_listener.dart';
import 'package:hospital_management_doctor/core/strings/strings.dart';
import 'package:hospital_management_doctor/custom/progress_bar.dart';
import 'package:hospital_management_doctor/feature/appointments/data/model/get_appointment_model.dart';
import 'package:hospital_management_doctor/feature/appointments/data/model/get_appointment_status.dart';
import 'package:hospital_management_doctor/feature/appointments/data/model/get_report_model.dart';
import 'package:hospital_management_doctor/feature/appointments/presentation/bloc/appointment_bloc.dart';
import 'package:hospital_management_doctor/feature/appointments/presentation/bloc/appointment_event.dart';
import 'package:hospital_management_doctor/feature/appointments/presentation/bloc/appointment_state.dart';
import 'package:hospital_management_doctor/feature/appointments/presentation/bloc/appointment_status_bloc.dart';
import 'package:hospital_management_doctor/feature/appointments/presentation/bloc/report_list_bloc.dart';
import 'package:hospital_management_doctor/feature/medicine/data/model/get_medicine_model.dart';
import 'package:hospital_management_doctor/feature/medicine/presentation/bloc/medicine_bloc.dart';
import 'package:hospital_management_doctor/feature/medicine/presentation/bloc/medicine_event.dart';
import 'package:hospital_management_doctor/feature/medicine/presentation/bloc/medicine_state.dart';
import 'package:hospital_management_doctor/utils/colors.dart';
import 'package:hospital_management_doctor/utils/device_file.dart';
import 'package:hospital_management_doctor/utils/style.dart';
import 'package:hospital_management_doctor/widget/custom_appbar.dart';
import 'package:hospital_management_doctor/widget/drop_down.dart';
import 'package:hospital_management_doctor/widget/multi_selection_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateAppointmentPage extends StatefulWidget {
  String doctorId;
  GetAppointmentModel? getAppointmentModel;
  int index;
  UpdateAppointmentPage({Key? key,required this.doctorId, this.getAppointmentModel, required this.index}) : super(key: key);


  @override
  _UpdateAppointmentPageState createState() => _UpdateAppointmentPageState();
}

class _UpdateAppointmentPageState extends State<UpdateAppointmentPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GetAppointmentStatusModel getAppointmentStatusModel = GetAppointmentStatusModel();
  GetMedicineModel getMedicineModel = GetMedicineModel();
  TextEditingController medicineController = TextEditingController();
  TextEditingController reportSuggestionController = TextEditingController();
  TextEditingController appointmentStatusController = TextEditingController();
  GetReportListModel getReportListModel = GetReportListModel();
  List<String> statusRadioList = [
    Strings.kSelectStatus
  ];
  List<String> medicineList = [];
  List<String> reportList = [];
  String appointmentStatus = "";


  @override
  void initState() {
    List medicineList1 = [];
    if(widget.getAppointmentModel!.data![widget.index].patientData != null){
      for(int i=0;i< widget.getAppointmentModel!.data![widget.index].patientData!.patientMedicineReportDetails!.length;i++){
        medicineList1.add(widget.getAppointmentModel!.data![widget.index].patientData!.patientMedicineReportDetails![i].medicineName);
      }
    }
    medicineController.text = medicineList1.join(" , ");
    List reportList1 = [];
    if(widget.getAppointmentModel!.data![widget.index].patientData != null){
      for(int i=0;i< widget.getAppointmentModel!.data![widget.index].patientData!.patientReportData!.length;i++){
        reportList1.add(widget.getAppointmentModel!.data![widget.index].patientData!.patientReportData![i].reportName);
      }
      reportSuggestionController.text = reportList1.join(" , ");
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _getAppointmentStatus("");
      await _getMedicineList("");
      await _getReportList();
    });
    super.initState();
  }

  Future<String> _getAppointmentStatus(String id) {
    return Future.delayed(const Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AppointmentStatusBloc>(context).add(
          GetAppointmentStatusEvent(
              id: id,));
      return "";
    });
  }

  Future<String> _getReportList() {
    return Future.delayed(const Duration()).then((_) {
     // ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<ReportListBloc>(context).add(
          GetReportListEvent());
      return "";
    });
  }


  Future<String> _getMedicineList(String id) {
    return Future.delayed(const Duration()).then((_) {
      BlocProvider.of<MedicineBloc>(context).add(
          GetMedicineEvent(id: id));
      return "";
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 100),
        child: CustomAppBar(title: Strings.kUpdateAppointment,isBackPress: true),
      ),
      body: ErrorBlocListener<AppointmentBloc>(
        bloc: BlocProvider.of<AppointmentBloc>(context),
        child:  BlocBuilder<AppointmentBloc, BaseState>(builder: (context, state)  {
          return  Form(
            key: _formKey,
            child: buildWidget(),
          );
        }),
      ),
    );
  }

  buildWidget(){
    return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              BlocBuilder<MedicineBloc, BaseState>(
                builder: (context, state) {
                  if (state is GetMedicineState) {
                    ProgressDialog.hideLoadingDialog(context);
                    medicineList = [];
                    getMedicineModel = state.model!;
                    for(int i=0;i<getMedicineModel.data!.length;i++){
                      medicineList.add(getMedicineModel.data![i].name ?? "");
                    }
                    print(medicineList);
                    return MultiSelectionWidget(
                      controller: medicineController,
                      displayList: medicineList,
                      label: Strings.kSelectMedicineName,
                      //errorMessage: Strings.kErrorMessageForMedicine,
                    );
                  }else if (state is StateErrorGeneral) {
                    ProgressDialog.hideLoadingDialog(context);
                    Fluttertoast.cancel();
                    Fluttertoast.showToast(
                        msg: state.message,
                        toastLength: Toast.LENGTH_LONG,
                        fontSize: DeviceUtil.isTablet ? 20 : 12,
                        backgroundColor: CustomColors.colorDarkBlue,
                        textColor: Colors.white
                    );
                    return const SizedBox();
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const SizedBox(height: 10,),
              BlocBuilder<ReportListBloc, BaseState>(
                builder: (context, state) {
                  if (state is GetReportListState) {
                    ProgressDialog.hideLoadingDialog(context);
                    reportList = [];
                    getReportListModel = state.model!;
                    for(int i=0;i<getReportListModel.data!.length;i++){
                      reportList.add(getReportListModel.data![i].reportData ?? "");
                    }
                    print(reportList);
                    return MultiSelectionWidget(
                      controller: reportSuggestionController,
                      displayList: reportList,
                      label: Strings.kReportSuggestionName,
                      //errorMessage: Strings.kReportSuggestionErrorMessage,
                    );
                  }else if (state is StateErrorGeneral) {
                    ProgressDialog.hideLoadingDialog(context);
                    Fluttertoast.cancel();
                    Fluttertoast.showToast(
                        msg: state.message,
                        toastLength: Toast.LENGTH_LONG,
                        fontSize: DeviceUtil.isTablet ? 20 : 12,
                        backgroundColor: CustomColors.colorDarkBlue,
                        textColor: Colors.white
                    );
                    return const SizedBox();
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const SizedBox(height: 10,),
            /*MultiSelectionWidget(
              controller: reportSuggestionController,
              displayList: reportList,
              label: Strings.kReportSuggestionName,
              errorMessage: Strings.kReportSuggestionErrorMessage,
            ),*/
            /*  CustomTextField(
                key: const Key(Strings.kReportSuggestionKey),
                label: Strings.kReportSuggestionName,
                hint: Strings.kReportSuggestionHint,
                errorMessage: Strings.kReportSuggestionErrorMessage,
                textEditingController: reportSuggestionController,
              ),*/
              BlocBuilder<AppointmentStatusBloc, BaseState>(builder: (context, state)  {
                if(state is GetAppointmentStatusState){
                  statusRadioList = [];
                  ProgressDialog.hideLoadingDialog(context);
                  getAppointmentStatusModel = state.model!;
                  for(int i=0;i<getAppointmentStatusModel.data!.length;i++){
                    statusRadioList.add(getAppointmentStatusModel.data![i].status ?? "");
                  }
                  for(int i=0;i<getAppointmentStatusModel.data!.length;i++){
                    if(int.parse(widget.getAppointmentModel!.data![widget.index].statusId ?? "") == getAppointmentStatusModel.data![i].aId){
                      appointmentStatus = getAppointmentStatusModel.data![i].status ?? "";
                      appointmentStatusController.text = appointmentStatus;
                    }
                  }
                  return DropDown(
                    controller: appointmentStatusController,
                    dropDownList: statusRadioList,
                    selectedValue:  appointmentStatusController.text.isEmpty ?
                    appointmentStatus.isEmpty
                        ?statusRadioList[0]
                        : appointmentStatus
                        : appointmentStatusController.text,
                    label: Strings.kSelectAppointmentStatus,
                    errorMessage: Strings.kSelectAppointmentStatus,
                  );
                }
                return  const SizedBox();

              }),
              const SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if(_formKey.currentState!.validate()){
                          _formKey.currentState?.save();
                          FocusScope.of(context).unfocus();
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          var doctorId = prefs.getString(CommonKeys.K_Id);
                          String? statusIdForUpdateAppointment;
                          for(int i=0;i<getAppointmentStatusModel.data!.length;i++){
                            if(appointmentStatusController.text == getAppointmentStatusModel.data![i].status){
                              statusIdForUpdateAppointment = getAppointmentStatusModel.data![i].aId.toString();
                              break;
                            }
                          }
                          List<String> medicineList = medicineController.text.split(" , ");
                          List<String> medicineIdList = [];
                          print(medicineList);
                          if(medicineController.text.isNotEmpty){
                            for(int j=0;j<medicineList.length;j++){
                              for(int i=0;i<getMedicineModel.data!.length;i++){
                                if(getMedicineModel.data![i].name == medicineList[j]){
                                  medicineIdList.add(getMedicineModel.data![i].id.toString());
                                }
                              }
                            }
                          }
                          print(medicineIdList);
                          String medicineIdString = medicineIdList.join(",");
                          print(medicineIdString);
                          List<String> reportList = reportSuggestionController.text.split(" , ");
                          List<dynamic> reportIdList = [];
                          Map<String,dynamic> reportMap = Map();
                          print(medicineList);
                          if(reportSuggestionController.text.isNotEmpty){
                            for(int j=0;j<reportList.length;j++){
                              for(int i=0;i<getReportListModel.data!.length;i++){
                                if(getReportListModel.data![i].reportData == reportList[j]){
                                  reportMap = Map();
                                  reportMap[CommonKeys.K_Report_Id] = getReportListModel.data![i].id.toString();
                                  reportMap[CommonKeys.K_File_Data] = "";
                                  reportIdList.add(reportMap);
                                }
                              }
                            }
                          }
                          print(reportIdList);
                          String reportIdString = reportIdList.join(",");
                          print(reportIdString);
                          _updateAppointment(
                            reportDescription: reportIdList,
                            medicineId: medicineController.text.isEmpty ? "" : medicineIdString,
                            statusId: statusIdForUpdateAppointment,
                            patientId: widget.getAppointmentModel!.data![widget.index].patientId,
                            appointmentId: widget.getAppointmentModel!.data![widget.index].id.toString(),
                            doctorId: doctorId,
                            hospitalId: "",
                          );
                        }else{
                          FocusScope.of(context).unfocus();
                          Fluttertoast.cancel();
                          Fluttertoast.showToast(
                              msg: Strings.kPleaseFillAllDetails,
                              toastLength: Toast.LENGTH_LONG,
                              fontSize: DeviceUtil.isTablet ? 20 : 12,
                              backgroundColor: CustomColors.colorDarkBlue,
                              textColor: Colors.white
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: CustomColors.colorDarkBlue,
                        shape: StadiumBorder(),
                      ),
                      child:  Text(
                        Strings.kUpdateAppointment,
                        style: CustomTextStyle.styleSemiBold.copyWith(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        )
    );
  }

  Future<String> _updateAppointment({ String? doctorId, patientId, appointmentId,
    medicineId, statusId, hospitalId,
    List? reportDescription,}) {
    return Future.delayed(const Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AppointmentBloc>(context).add(
          UpdateAppointmentEvent(
            hospitalId: hospitalId,
          doctorId: doctorId ?? "",
          appointmentId: appointmentId,
          patientId: patientId,
          statusId: statusId,
          medicineId: medicineId,
          reportDescription: reportDescription ?? []));
      return "";
    });
  }
}
