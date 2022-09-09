import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_management_doctor/core/base/base_bloc.dart';
import 'package:hospital_management_doctor/core/error_bloc_builder/error_builder_listener.dart';
import 'package:hospital_management_doctor/custom/progress_bar.dart';
import 'package:hospital_management_doctor/feature/appointments/data/model/get_appointment_model.dart';
import 'package:hospital_management_doctor/feature/appointments/data/model/get_appointment_status.dart';
import 'package:hospital_management_doctor/feature/appointments/presentation/bloc/appointment_bloc.dart';
import 'package:hospital_management_doctor/feature/appointments/presentation/bloc/appointment_event.dart';
import 'package:hospital_management_doctor/feature/appointments/presentation/bloc/appointment_state.dart';
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
import 'package:hospital_management_doctor/widget/text_field.dart';
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
  List<String> statusRadioList = [
    "-- Select Status --"
  ];
  List<String> medicineList = [];
  String appointmentStatus = "";


  @override
  void initState() {
    List medicineList1 = [];
    if(widget.getAppointmentModel!.data![widget.index].patientReportData != null){
      for(int i=0;i< widget.getAppointmentModel!.data![widget.index].patientReportData!.medicineDetails!.length;i++){
        medicineList1.add(widget.getAppointmentModel!.data![widget.index].patientReportData!.medicineDetails![i].medicineName);
      }
    }
    medicineController.text = medicineList1.join(" , ");
    if(widget.getAppointmentModel!.data![widget.index].patientReportData != null){
      reportSuggestionController.text = widget.getAppointmentModel!.data![widget.index].patientReportData!.reportDescription ?? "";
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _getAppointmentStatus("");
      await _getMedicineList("");
    });
    super.initState();
  }

  Future<String> _getAppointmentStatus(String id) {
    return Future.delayed(const Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AppointmentBloc>(context).add(
          GetAppointmentStatusEvent(
              id: id,));
      return "";
    });
  }

  Future<String> _getMedicineList(String id) {
    return Future.delayed(const Duration()).then((_) {
      //ProgressDialog.showLoadingDialog(context);
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
        child: CustomAppBar(title: "Update Appointment",isBackPress: true),
      ),
      body: ErrorBlocListener<AppointmentBloc>(
        bloc: BlocProvider.of<AppointmentBloc>(context),
        child:  BlocBuilder<AppointmentBloc, BaseState>(builder: (context, state)  {
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
              }
            }
          }
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
                      label: "Select Medicine name",
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
             /* CustomTextField(
                key: const Key("tefMedicine"),
                label: "Medicine Name",
                hint: "Enter Medicine Name",
                errorMessage: "Please Enter Medicine name",
                textEditingController: medicineController,
              ),*/
              const SizedBox(height: 10,),
              CustomTextField(
                key: const Key("tefReportSuggestion"),
                label: "Report Suggestion Name",
                hint: "Enter Report Suggestion Name",
                errorMessage: "Please Enter Report Suggestion name",
                textEditingController: reportSuggestionController,
              ),
              const SizedBox(height: 10,),
              (getAppointmentStatusModel != null)
              ? DropDown(
                controller: appointmentStatusController,
                dropDownList: statusRadioList,
                selectedValue:  appointmentStatusController.text.isEmpty ?
                appointmentStatus.isEmpty
                    ?statusRadioList[0]
                    : appointmentStatus
                    : appointmentStatusController.text,
                label: "Select Appointment Status",
                errorMessage: "Select Appointment Status",
              ) : const SizedBox(),
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
                          var doctorId = prefs.getString('id');
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
                          _updateAppointment(
                            reportDescription: reportSuggestionController.text,
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
                              msg: "Please fill all the details.",
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
                        "Update Appointment",
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
    medicineId, statusId, hospitalId, reportDescription,}) {
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
          reportDescription: reportDescription));
      return "";
    });
  }
}
