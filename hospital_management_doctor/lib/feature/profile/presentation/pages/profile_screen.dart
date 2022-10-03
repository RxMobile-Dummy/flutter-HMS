import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management_doctor/core/assets/images_name.dart';
import 'package:hospital_management_doctor/core/base/base_bloc.dart';
import 'package:hospital_management_doctor/core/common_keys/common_keys.dart';
import 'package:hospital_management_doctor/core/error_bloc_builder/error_builder_listener.dart';
import 'package:hospital_management_doctor/core/strings/strings.dart';
import 'package:hospital_management_doctor/custom/progress_bar.dart';
import 'package:hospital_management_doctor/feature/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:hospital_management_doctor/feature/authentication/presentation/pages/login_screen.dart';
import 'package:hospital_management_doctor/feature/profile/data/model/get_profile_model.dart';
import 'package:hospital_management_doctor/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:hospital_management_doctor/feature/profile/presentation/bloc/profile_event.dart';
import 'package:hospital_management_doctor/feature/profile/presentation/bloc/profile_state.dart';
import 'package:hospital_management_doctor/feature/profile/presentation/pages/doctor_detail_screen.dart';
import 'package:hospital_management_doctor/feature/profile/presentation/pages/update_doctor_profile_screen.dart';
import 'package:hospital_management_doctor/utils/colors.dart';
import 'package:hospital_management_doctor/utils/device_file.dart';
import 'package:hospital_management_doctor/utils/style.dart';
import 'package:hospital_management_doctor/widget/star_display_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hospital_management_doctor/injection_container.dart' as Sl;
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GetProfileModel getProfileModel = GetProfileModel();
  double ratings = 0.0;
  var doctorId;
  List<String> titleList = [
    Strings.kPersonalInformation,
    Strings.kUpdateProfile,
    Strings.kLogout
  ];


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      doctorId  = int.parse(prefs.getString(CommonKeys.K_Id) ?? "");
      await _getProfile(doctorId!);
    });
    super.initState();
  }

  Future<String> _getProfile(int id) {
    return Future.delayed(const Duration()).then((_) {
      BlocProvider.of<ProfileBloc>(context).add(
          GetProfileEvent(id: id));
      return "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.colorDarkBlue,
      body: ErrorBlocListener<ProfileBloc>(
        bloc: BlocProvider.of<ProfileBloc>(context),
        child:  BlocBuilder<ProfileBloc, BaseState>(builder: (context, state)  {
          if(state is GetProfileState) {
            ProgressDialog.hideLoadingDialog(context);
            getProfileModel = state.model!;
            ratings = 0.0;
            if(getProfileModel.data!.feedbacks!.isNotEmpty){
              for(int i=0;i<getProfileModel.data!.feedbacks!.length;i++){
                ratings = ratings + double.parse(getProfileModel.data!.feedbacks![i].rating.toString());
              }
            }
          }
          return buildWidget();
        }),
      ),
    );
  }

  buildWidget(){
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: CustomColors.colorDarkBlue,
                ),
                padding: EdgeInsets.all(0),
                child: Padding(
                    padding: EdgeInsets.only(left: 14,top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 20,),
                        )
                      ],
                    )
                )
            ),
            Flexible(child:
            Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(top: 8,left: 10,right: 10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(25.0),
                      topLeft: Radius.circular(25.0))
              ),
              child: userDetailsList(),
            ),
            )
          ],
        ),
        (getProfileModel.data != null) ? Positioned(
          top: ((MediaQuery.of(context).size.height / (DeviceUtil.isTablet ? 2.8 :3.8)) / 2) ,
          child:   userProfilePic(radius: DeviceUtil.isTablet ?  80.0: 46.0,
            imagePath:
            (getProfileModel.data?.profilePic != null && getProfileModel.data?.profilePic != "")
                ? "${CommonKeys.baseUrl}${getProfileModel.data?.profilePic}"
                : "",),
        ) :  Positioned(
          top: ((MediaQuery.of(context).size.height / (DeviceUtil.isTablet ? 2.8 :3.8)) / 2) ,
          child:   Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Card(
              elevation: 1.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const SizedBox(
                height: 200,
                width: 200,
              ),
            ),
          ),
        )
      ],
    );
  }
  userDetailsList(){
    return Padding(
      padding: EdgeInsets.only(top: 80,left: 20,right: 20),
      child: Column(
        children: [
          (getProfileModel.data != null) ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (ratings == 0.0)
                  ? const SizedBox()
                  :Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey.shade200
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18,vertical: 8),
                  child: StarDisplayWidget(
                    value: ratings.toInt()~/getProfileModel.data!.feedbacks!.length,
                    filledStar: Icon(Icons.star, color: Colors.orange, size: DeviceUtil.isTablet ? 26 :15),
                    unfilledStar: Icon(Icons.star_border, color: Colors.grey,size: DeviceUtil.isTablet ? 26 :15,),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Text(
                "Dr. ${getProfileModel.data?.firstName} ${getProfileModel.data?.lastName}",
                style: CustomTextStyle.styleBold.copyWith(fontSize: DeviceUtil.isTablet ? 22 : 20),
              ),
              SizedBox(height: 10,),
              Text(
                getProfileModel.data?.specialistField ?? "",
                style: CustomTextStyle.styleBold.copyWith(
                    color: Colors.grey.shade400).copyWith(fontSize: DeviceUtil.isTablet ? 20 : 18),
              ),
            ],
          ) : Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Card(
              elevation: 1.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const SizedBox(
                height: 80,
                width: 200,
              ),
            ),
          ),
          Expanded(child: (getProfileModel.data != null) ?
          ListView.builder(
            itemBuilder: (context, index) {
              return customCard(title: titleList[index],
                index: index,
              );
            },
            itemCount: 3,
          )
              :Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 1.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const SizedBox(
                    height: 60,
                  ),
                );
              },
            ),
          ),)
        ],
      )
    );
  }
/*  userDetailsList(){
    return Padding(
      padding: EdgeInsets.only(top: 80,left: 20,right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          (getProfileModel.data != null) ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (ratings == 0.0)
                  ? const SizedBox()
                  :Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey.shade200
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18,vertical: 8),
                  child: StarDisplayWidget(
                    value: ratings.toInt()~/getProfileModel.data!.feedbacks!.length,
                    filledStar: Icon(Icons.star, color: Colors.orange, size: DeviceUtil.isTablet ? 20 :15),
                    unfilledStar: Icon(Icons.star_border, color: Colors.grey,size: DeviceUtil.isTablet ? 20 :15,),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Text(
                "Dr. ${getProfileModel.data?.firstName} ${getProfileModel.data?.lastName}",
                style: CustomTextStyle.styleBold.copyWith(fontSize: 18),
              ),
              SizedBox(height: 10,),
              Text(
                getProfileModel.data?.specialistField ?? "",
                style: CustomTextStyle.styleBold.copyWith(
                    color: Colors.grey.shade400),
              ),
            ],
          ) : SizedBox(
        width: 200.0,
        height: 100.0,
        child: Shimmer.fromColors(
          baseColor: Colors.red,
          highlightColor: Colors.yellow,
          child: Text(
            'Shimmer',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40.0,
              fontWeight:
              FontWeight.bold,
            ),
          ),
        ),
      ),
          SizedBox(height: 20,),
          (getProfileModel.data != null) ?  : SizedBox(
            width: 200.0,
            height: 100.0,
            child: Shimmer.fromColors(
              baseColor: Colors.red,
              highlightColor: Colors.yellow,
              child: Text(
                'Shimmer',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: DeviceUtil.isTablet ? 30 : 15,),
          (getProfileModel.data != null) ?  customCard(title: Strings.kUpdateProfile,
              index: 2,
              icon: Icon(Icons.edit, color: CustomColors.colorDarkBlue,
                size: DeviceUtil.isTablet ? 30 : 25,)): SizedBox(
            width: 200.0,
            height: 100.0,
            child: Shimmer.fromColors(
              baseColor: Colors.red,
              highlightColor: Colors.yellow,
              child: Text(
                'Shimmer',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: DeviceUtil.isTablet ? 30 : 15,),
          (getProfileModel.data != null) ?  customCard(title: Strings.kLogout,
              index: 3,
              icon: Icon(Icons.logout, color: CustomColors.colorDarkBlue,
                size: DeviceUtil.isTablet ? 30 : 25,)): SizedBox(
            width: 200.0,
            height: 100.0,
            child: Shimmer.fromColors(
              baseColor: Colors.red,
              highlightColor: Colors.yellow,
              child: Text(
                'Shimmer',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }*/
  customCard({String? title,Icon? icon,int? index}){
    return Column(
      children: [
        Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),
                side: BorderSide(
                    color: Colors.grey.shade200,
                    width: 2)),
            child: ListTile(
              title: Text(
                title ?? "",
                style: CustomTextStyle.styleMedium.copyWith(fontSize: DeviceUtil.isTablet ? 20 : 18),
              ),
              // leading: icon,
              trailing: Icon(Icons.arrow_forward_ios_rounded, color: CustomColors.colorDarkBlue,
                size: DeviceUtil.isTablet ? 26 : 20,),
              onTap: (){
                if(index == 0){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DoctorDetailsPage(getProfileModel: getProfileModel)),
                  );
                }else if(index == 1){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MultiBlocProvider(
                            providers: [
                              BlocProvider<ProfileBloc>(
                                create: (context) => Sl.Sl<ProfileBloc>(),
                              ),
                            ], child: UpdateProfilePage(getProfileModel: getProfileModel,))),
                  ).then((value) {
                    BlocProvider.of<ProfileBloc>(context).add(
                        GetProfileEvent(id: doctorId!));
                  });
                }else if(index == 2){
                  showDialog(
                    context: context,
                    builder: (ctx) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child:  AlertDialog(
                        title:  Text(
                          Strings.kLogout,
                          style: TextStyle(
                              fontSize:  DeviceUtil.isTablet ? 24 : 18),
                        ),
                        content:  Container(
                          child: Text(
                            Strings.kLogoutMessage,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                            style:  CustomTextStyle.styleMedium.copyWith(
                                fontSize: DeviceUtil.isTablet ? 22 : 16
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () async {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.clear();
                              prefs.setString(Strings.kOnBoardingBool, "true");
                              print(prefs);
                              Future.delayed(Duration.zero, () {
                                Navigator.pushAndRemoveUntil(
                                  context,MaterialPageRoute(builder: (context) =>BlocProvider<AuthenticationBloc>(
                                  create: (context) => Sl.Sl<AuthenticationBloc>(),
                                  child: LoginScreen(),
                                )),
                                      (route) => false,
                                );
                              });
                            },
                            child: Text(
                              Strings.kYes,
                              style: CustomTextStyle.styleSemiBold
                                  .copyWith(color: CustomColors.colorDarkBlue, fontSize:
                              DeviceUtil.isTablet ? 22 : 18),),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            )
        ),
        SizedBox(height: DeviceUtil.isTablet ? 30 : 15,),
      ],
    );
  }

  userProfilePic({radius=24.0,String? imagePath}) {
    return Container(
      height: DeviceUtil.isTablet ? 250 :200,
      width: DeviceUtil.isTablet ? 250 :200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              (imagePath == null || imagePath == "")
                  ? ImagesName.kDummyPersonImage
                  : imagePath)
        ),
        borderRadius: BorderRadius.circular(15)
      ),
    );
  }
}
