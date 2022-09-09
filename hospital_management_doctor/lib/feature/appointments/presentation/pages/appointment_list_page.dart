import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management_doctor/core/base/base_bloc.dart';
import 'package:hospital_management_doctor/core/error_bloc_builder/error_builder_listener.dart';
import 'package:hospital_management_doctor/core/strings/strings.dart';
import 'package:hospital_management_doctor/custom/progress_bar.dart';
import 'package:hospital_management_doctor/feature/appointments/data/model/get_appointment_model.dart';
import 'package:hospital_management_doctor/feature/appointments/presentation/bloc/appointment_bloc.dart';
import 'package:hospital_management_doctor/feature/appointments/presentation/bloc/appointment_event.dart';
import 'package:hospital_management_doctor/feature/appointments/presentation/bloc/appointment_state.dart';
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

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      doctorId = prefs.getString('id');
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:ErrorBlocListener<AppointmentBloc>(
        bloc: BlocProvider.of<AppointmentBloc>(context),
        // callback:  _loginUser(userName.text,tiePassword.text),
        child:  BlocBuilder<AppointmentBloc, BaseState>(builder: (context, state)  {
          if(state is GetAppointmentState) {
            ProgressDialog.hideLoadingDialog(context);
            getAppointmentModel = state.model!;
          }
          return (getAppointmentModel.data != null)
              ? (getAppointmentModel.data!.isNotEmpty) ? buildWidget()
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
              :  SizedBox();

        }),
      ),
    );
  }

  buildWidget() {
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
                child:  Text(
                  "Apply filter",
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
        ),
        appointmentList(),
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
                            "Appointment Filter",
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
                          "Apply Filter",
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
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                        child: const Icon(
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
                      "Appointments",
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
              child:  Image.asset(
                "assets/images/appointment.png",
              ),
            )
          ],
        ));
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
            Align(
              alignment: Alignment.topRight,
              child: Container(
                  decoration:  BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      color: Colors.grey.shade200
                    //color: Colors.orangeAccent.shade100,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                      /*  ElevatedButton(
                            onPressed: (){},
                          style: ElevatedButton.styleFrom(
                            primary: CustomColors.colorDarkBlue,
                            shape: StadiumBorder(),
                          ),
                            child: const Icon(Icons.edit,color: Colors.white,),),*/
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
                                      BlocProvider<MedicineBloc>(
                                        create: (context) => Sl.Sl<MedicineBloc>(),
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
                           /*  (value != null) ? BlocProvider.of<AppointmentBloc>(context).add(
                                 GetAppointmentEvent(id: doctorId!,date: "")) : const SizedBox();*/

                              await _getAppointment(doctorId, "");
                            });
                          },
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child:  InkWell(
                              child: const Icon(Icons.delete_outline_rounded,color: CustomColors.colorDarkBlue,),
                              onTap: (){
                                showDialog(
                                    context: context,
                                    builder: (ctx) => Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      child: AlertDialog(
                                        title:  Text(
                                          "Delete Appointment",
                                          style: TextStyle(fontSize:  DeviceUtil.isTablet ? 18 : 14),
                                        ),
                                        content:  Container(
                                          child: Text(
                                            "Are you sure you want to delete?",
                                            softWrap: true,
                                            overflow: TextOverflow.fade,
                                            style:  CustomTextStyle.styleMedium.copyWith(
                                                fontSize: DeviceUtil.isTablet ? 18 : 14
                                            ),
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                            },
                                            child: Text(
                                              "Yes",
                                              style: CustomTextStyle.styleSemiBold
                                                  .copyWith(color: CustomColors.colorDarkBlue, fontSize:
                                              DeviceUtil.isTablet ? 18 : 16),),
                                          ),
                                        ],
                                      ),
                                    ));
                              },
                            )
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
                            /*  Container(
                              height: 120,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  borderRadius: BorderRadius.circular(10)),
                            ),*/
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
                                          : "",),//AssetImage("assets/images/ii_1.png"),
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
                              //mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "${getAppointmentModel.data![index].firstName} ${getAppointmentModel.data![index].lastName}",
                                  style: TextStyle(
                                      fontSize: DeviceUtil.isTablet ? 18 :16,
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
                                   /* Text(
                                      "with",
                                      softWrap: false,
                                      overflow: TextOverflow.fade,
                                      maxLines: 4,
                                      style: TextStyle(
                                          fontSize: DeviceUtil.isTablet ? 15 :13,
                                          color: (Theme.of(context).brightness ==
                                              Brightness.dark)
                                              ? Colors.white
                                              : Colors.grey.shade400,
                                          fontWeight: FontWeight.w500),
                                    ),*/
                                    Text(
                                      getAppointmentModel.data![index].disease ?? ""/*"${getDoctorModel.data![index].specialistField} Department"*/,
                                      softWrap: false,
                                      overflow: TextOverflow.fade,
                                      maxLines: 4,
                                  style: TextStyle(
                                      fontSize: DeviceUtil.isTablet ? 15 :13,
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
                                        fontSize: DeviceUtil.isTablet ? 16 :14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
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
    // print("Formatted date time:  $formattedDate");
    return formattedDate.toString();
  }



}