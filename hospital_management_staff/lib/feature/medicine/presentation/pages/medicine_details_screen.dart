import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hospital_management_staff/core/strings/strings.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/get_medicine_model.dart';
import 'package:hospital_management_staff/utils/colors.dart';
import 'package:hospital_management_staff/utils/device_file.dart';
import 'package:hospital_management_staff/widget/expandable_text.dart';

class MedicineDetailsScreen extends StatefulWidget {
  GetMedicineModel getMedicineModel;
  int index;
   MedicineDetailsScreen({Key? key,
  required this.getMedicineModel,required this.index}) : super(key: key);

  @override
  _MedicineDetailsScreenState createState() => _MedicineDetailsScreenState();
}

class _MedicineDetailsScreenState extends State<MedicineDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            Strings.kMedicineDetails,
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
        ),
        body: buildWidget());
  }

  buildWidget() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(0),
        child: Column(
          children: [
            Card(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                children: [
                  (widget.getMedicineModel.data![widget.index].prescriptionRequiredOrNot == "yes")? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                          "℞",
                        style: TextStyle(
                            fontSize: DeviceUtil.isTablet ? 16 : 22,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ) : SizedBox(),
                  Image.network(
                    (widget.getMedicineModel.data![widget.index].medicinePhoto != null
                        && widget.getMedicineModel.data![widget.index].medicinePhoto != "")
                        ? "${Strings.baseUrl}${widget.getMedicineModel.data![widget.index].medicinePhoto}"
                        : "",
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.getMedicineModel.data![widget.index].name} ${widget.getMedicineModel.data![widget.index].unitOfQuantity}mg Tablet",
                            style: /*CustomTextStyle.styleMedium*/ TextStyle(
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontFamily: 'Open Sans',
                                fontSize: DeviceUtil.isTablet ? 20 : 18,
                                color: Colors.black87),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Text(
                            widget.getMedicineModel.data![widget.index].itemCategory ?? "",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontFamily: 'Open Sans',
                                fontSize: DeviceUtil.isTablet ? 18 : 16,
                                color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )),
            Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Item Category",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Open Sans',
                          fontSize: DeviceUtil.isTablet ? 18 : 16,
                          color: Colors.grey),
                    ),
                    SizedBox(height: 10,),
                    Card(
                      color: Colors.grey.shade200,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 14),
                        child: Text(
                          widget.getMedicineModel.data![widget.index].itemCategory ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontFamily: 'Open Sans',
                              fontSize: DeviceUtil.isTablet ? 18 : 16,
                              color: Colors.black),
                        ),
                      )
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "Sub Category",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Open Sans',
                          fontSize: DeviceUtil.isTablet ? 18 : 16,
                          color: Colors.grey),
                    ),
                    SizedBox(height: 10,),
                    Card(
                        color: Colors.grey.shade200,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 14),
                          child: Text(
                            widget.getMedicineModel.data![widget.index].itemSubCategory ?? "",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontFamily: 'Open Sans',
                                fontSize: DeviceUtil.isTablet ? 18 : 16,
                                color: Colors.black),
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),
            Card(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          Strings.kDescription,
                          style: TextStyle(
                              fontSize: DeviceUtil.isTablet ? 18 : 16,
                              color: (Theme.of(context).brightness ==
                                      Brightness.dark)
                                  ? Colors.white
                                  : Colors.grey.shade400,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: DeviceUtil.isTablet ? 10 : 7,
                        ),
                         ExpandableText(
                          widget.getMedicineModel.data![widget.index].description ?? "",
                           trimLines: 4,
                        )
                      ],
                    ))),
            Card(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "℞",
                              style: TextStyle(
                                  fontSize: DeviceUtil.isTablet ? 16 : 18,
                                  color: (Theme.of(context).brightness ==
                                          Brightness.dark)
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                Strings.kPrescriptionRequired,
                                style: TextStyle(
                                    fontSize: DeviceUtil.isTablet ? 16 : 18,
                                    color: (Theme.of(context).brightness ==
                                            Brightness.dark)
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                        FlutterSwitch(
                          width: 50.0,
                          height: 25.0,
                          //valueFontSize: 10.0,
                          inactiveColor: Colors.grey.shade200,
                          activeColor: Colors.grey.shade200,
                          toggleSize: 16.0,
                          toggleColor: CustomColors.colorDarkBlue,
                          inactiveToggleColor: Colors.grey,
                          value: widget.getMedicineModel.data![widget.index].prescriptionRequiredOrNot == "yes" ? true : false,
                          borderRadius: 20.0,
                          padding: 5.0,
                          showOnOff: false,
                          onToggle: (val) {
                            setState(() {
                              //status = val;
                            });
                          },
                        ),
                      ],
                    ))),
            Card(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Pricing",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Open Sans',
                                  fontSize: DeviceUtil.isTablet ? 18 : 16,
                                  color: Colors.grey),
                            ),
                            Text(
                              "Quantity",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Open Sans',
                                  fontSize: DeviceUtil.isTablet ? 18 : 16,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                           Expanded(
                             child:  Padding(
                               padding: EdgeInsets.only(right: 5),
                               child: Card(
                                   color: Colors.grey.shade200,
                                   child: Padding(
                                     padding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                                     child: Text(
                                       "\$ ${widget.getMedicineModel.data![widget.index].cost}",
                                       style: TextStyle(
                                           fontWeight: FontWeight.w500,
                                           fontStyle: FontStyle.normal,
                                           fontFamily: 'Open Sans',
                                           fontSize: DeviceUtil.isTablet ? 18 : 16,
                                           color: Colors.black),
                                     ),
                                   )
                               ),
                             ),
                           ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 5),
                                child:  Card(
                                    color: Colors.grey.shade200,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                                      child: Text(
                                        "Pack of ${widget.getMedicineModel.data![widget.index].quantity}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                            fontFamily: 'Open Sans',
                                            fontSize: DeviceUtil.isTablet ? 18 : 16,
                                            color: Colors.black),
                                      ),
                                    )
                                ),
                              )
                            ),
                          ],
                        )
                      ],
                    ))),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
