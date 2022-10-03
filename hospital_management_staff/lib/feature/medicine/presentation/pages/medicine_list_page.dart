import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management_staff/core/base/base_bloc.dart';
import 'package:hospital_management_staff/core/error_bloc_builder/error_builder_listener.dart';
import 'package:hospital_management_staff/core/strings/strings.dart';
import 'package:hospital_management_staff/custom/progress_bar.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/get_medicine_model.dart';
import 'package:hospital_management_staff/feature/medicine/presentation/bloc/medicine_bloc.dart';
import 'package:hospital_management_staff/feature/medicine/presentation/bloc/medicine_event.dart';
import 'package:hospital_management_staff/feature/medicine/presentation/bloc/medicine_state.dart';
import 'package:hospital_management_staff/feature/medicine/presentation/pages/add_medicine_page.dart';
import 'package:hospital_management_staff/feature/medicine/presentation/pages/edit_medicine_page.dart';
import 'package:hospital_management_staff/feature/medicine/presentation/pages/medicine_details_screen.dart';
import 'package:hospital_management_staff/utils/colors.dart';
import 'package:hospital_management_staff/utils/device_file.dart';
import 'package:hospital_management_staff/utils/style.dart';
import 'package:hospital_management_staff/injection_container.dart' as Sl;

class MedicineListPage extends StatefulWidget {
  const MedicineListPage({Key? key}) : super(key: key);

  @override
  _MedicineListPageState createState() => _MedicineListPageState();
}

class _MedicineListPageState extends State<MedicineListPage> {
  GetMedicineModel getMedicineModel = GetMedicineModel();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _getMedicine("", "");
    });
    super.initState();
  }

  Future<String> _getMedicine(
    String id,
    String name,
  ) {
    return Future.delayed(const Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<MedicineBloc>(context).add(GetMedicineEvent(
        id: id,
        name: name,
      ));
      return "";
    });
  }

  Future<String> _searchMedicine({
    String? id,
    String? name,
  }) {
    return Future.delayed(const Duration()).then((_) {
      BlocProvider.of<MedicineBloc>(context).add(GetMedicineEvent(
        id: id ?? "",
        name: name ?? "",
      ));
      return "";
    });
  }

  Future<String> _deleteMedicine(
      String id,
      ) {
    return Future.delayed(const Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<MedicineBloc>(context).add(DeleteMedicineEvent(
        id: id,
      ));
      return "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          Strings.kMedicineList,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              //fontFamily: 'Open Sans',
              fontSize: 22,
              color: Colors.black),
        ),
        leading: InkWell(
            child: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context).pop();
            }),
       /* actions: [
          InkWell(
              child: const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.search,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                //Navigator.of(context).pop();
              }),
        ],*/
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.colorDarkBlue,
        child: const Icon(
          Icons.add,
          size: 28,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider<MedicineBloc>(
                      create: (context) => Sl.Sl<MedicineBloc>(),
                    ),
                  ],
                  child: AddMedicinePage(),
                )),
          ).then((value) async {
            await _getMedicine("", "");
          });
        },
      ),
      body: ErrorBlocListener<MedicineBloc>(
        bloc: BlocProvider.of<MedicineBloc>(context),
        child: BlocBuilder<MedicineBloc, BaseState>(builder: (context, state) {
          if (state is GetMedicineState) {
            ProgressDialog.hideLoadingDialog(context);
            getMedicineModel = state.model!;
          }else if (state is DeleteMedicineState) {
            ProgressDialog.hideLoadingDialog(context);
             _getMedicine("", "");
          }
          return (getMedicineModel.data != null)
              ? (getMedicineModel.data!.isNotEmpty)
                  ? buildWidget()
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
                    ))
              : const SizedBox();
        }),
      ),
    );
  }

  buildWidget() {
    return Column(
      children: [
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
                    await _getMedicine("", "");
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
              await _searchMedicine(name: string, id: "");
            },
          ),
        ),
        const SizedBox(height: 25,),
        Flexible(child: GridView.builder(
          itemCount: getMedicineModel.data!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: DeviceUtil.isTablet ? 2 : 2,
              crossAxisSpacing: DeviceUtil.isTablet ? 14 : 4,
              mainAxisSpacing: DeviceUtil.isTablet ? 14 : 4),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Future.delayed(Duration.zero, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MultiBlocProvider(
                          providers: [
                            BlocProvider<MedicineBloc>(
                              create: (context) => Sl.Sl<MedicineBloc>(),
                            ),
                          ],
                          child: MedicineDetailsScreen(
                            index: index,
                            getMedicineModel: getMedicineModel,
                          ),
                        )),
                  );
                });
              },
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(width: 1, color: Colors.grey.shade200)),
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
                                color: Colors.grey.shade200),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    child:  Icon(Icons.edit,
                                        color: CustomColors.colorDarkBlue,
                                        size: DeviceUtil.isTablet? 28:20),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MultiBlocProvider(
                                                  providers: [
                                                    BlocProvider<MedicineBloc>(
                                                      create: (context) =>
                                                          Sl.Sl<MedicineBloc>(),
                                                    ),
                                                  ],
                                                  child: EditMedicinePage(
                                                    getMedicineModel: getMedicineModel,
                                                    index: index,
                                                  ),
                                                )),
                                      ).then((value) async {
                                        _getMedicine("", "");
                                      });
                                    },
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                    child: InkWell(
                                      child:  Icon(
                                          Icons.delete_outline_rounded,
                                          color: CustomColors.colorDarkBlue,
                                          size: DeviceUtil.isTablet? 28:20),
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (ctx) => Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              child: AlertDialog(
                                                title: Text(
                                                  "Delete Appointment",
                                                  style: TextStyle(
                                                      fontSize:
                                                      DeviceUtil.isTablet
                                                          ? 18
                                                          : 14),
                                                ),
                                                content: Container(
                                                  child: Text(
                                                    "Are you sure you want to delete?",
                                                    softWrap: true,
                                                    overflow: TextOverflow.fade,
                                                    style: CustomTextStyle
                                                        .styleMedium
                                                        .copyWith(
                                                        fontSize: DeviceUtil
                                                            .isTablet
                                                            ? 18
                                                            : 14),
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      _deleteMedicine(
                                                          getMedicineModel.data![index].id.toString()
                                                      );
                                                      Navigator.of(ctx).pop();
                                                    },
                                                    child: Text(
                                                      "Yes",
                                                      style: CustomTextStyle
                                                          .styleSemiBold
                                                          .copyWith(
                                                          color: CustomColors
                                                              .colorDarkBlue,
                                                          fontSize: DeviceUtil
                                                              .isTablet
                                                              ? 18
                                                              : 16),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ));
                                      },
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Image.network(
                                  (getMedicineModel.data![index].medicinePhoto !=
                                      null &&
                                      getMedicineModel
                                          .data![index].medicinePhoto !=
                                          "")
                                      ? "${Strings.baseUrl}${getMedicineModel.data![index].medicinePhoto}"
                                      : "",
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                getMedicineModel.data![index].name ?? "",
                                style: /*CustomTextStyle.styleMedium*/ TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Open Sans',
                                    fontSize: DeviceUtil.isTablet ? 20 : 14,
                                    color: Colors.black87),
                              ),
                              Text(
                                "Tablet",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Open Sans',
                                    fontSize: DeviceUtil.isTablet ? 20 : 14,
                                    color: Colors.black87),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                "\$ ${getMedicineModel.data![index].cost}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Open Sans',
                                    fontSize: DeviceUtil.isTablet ? 20 : 16,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                "${getMedicineModel.data![index].itemSold} sold",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Open Sans',
                                    fontSize: DeviceUtil.isTablet ? 20 : 14,
                                    color: Colors.grey.shade400),
                              ),
                              /* Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$ 4.00",
                                style:  TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Open Sans',
                                    fontSize: DeviceUtil.isTablet ? 18:16,
                                    color: Colors.black
                                ),
                              ),
                              Text(
                                "125 sold",
                                style:  TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Open Sans',
                                    fontSize: DeviceUtil.isTablet ? 16:14,
                                    color: Colors.grey.shade400
                                ),
                              ),
                            ],
                          )*/
                            ],
                          )),
                    ],
                  )),
            );
          },
        ))
      ],
    );
  }
}
