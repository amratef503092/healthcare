import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helthcare/model/Hospital_info_Model.dart';
import 'package:helthcare/presentation/Screen/LoginScreen.dart';
import 'package:helthcare/presentation/Screen/Medical_History_Screen_Three.dart';
import 'package:helthcare/presentation/Screen/profile_screen.dart';
import 'package:helthcare/presentation/Screen/userInfo.dart';
import 'package:helthcare/presentation/resources/value_manager.dart';
import 'package:helthcare/shared/bloc/AppCubit.dart';
import 'package:helthcare/shared/bloc/AppStates.dart';
import '../../constant/constants.dart';
import '../resources/assets/assetclass.dart';
import '../resources/text_manager.dart';
import 'DoctorInformation.dart';
import 'NFC_scan.dart';
import 'doctorInfo.dart';
import 'hospitalInfo.dart';
import 'medical_history.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height;
    var screenWidth = size.width;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
            key: _key,
            drawer: Drawer(
              backgroundColor: const Color(0xff0D2044),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  NavigatorWidget(
                    function: () {
                      Navigator.pop(context);
                    },
                  ),
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(
                      cubit.userInfo!.photo ??
                          "https://cdn1.vectorstock.com/i/thumb-large/22/05/male-profile-picture-vector-1862205.jpg",
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Button(
                      width: 231,
                      height: 50,
                      colorButton: const Color(0xffFFFFFF),
                      coloBorder: const Color(0xff707070),
                      fontSize: AppSize.s28,
                      colorText: Colors.black,
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileScreen()));
                      },
                      text: TextManager.profileText),
                  SizedBox(
                    height: 30,
                  ),
                  Button(
                      width: 231,
                      height: 50,
                      colorButton: Color(0xffFFFFFF),
                      coloBorder: Color(0xff707070),
                      fontSize: AppSize.s28,
                      colorText: Colors.black,
                      function: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      text: TextManager.logOut),
                ],
              ),
            ),
            body: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetsManager.homeBackGround),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    IconHomePage(
                      width: screenWidth,
                      function: () {
                        _key.currentState?.openDrawer();
                      },
                      image: AssetsManager.profile,
                      text: '',
                      right: 30,
                      top: 40,
                    ),
                    IconHomePage(
                      width: screenWidth,
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyApp()));
                      },
                      left: 20,
                      top: 58,
                      image: AssetsManager.nfcScan,
                      text: TextManager.nfcScan,
                    ),
                    IconHomePage(
                      width: screenWidth,
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserInfo()));
                      },
                      top: 200,
                      right: 30,
                      image: AssetsManager.Logo1,
                      text: TextManager.userInfo,
                    ),
                    IconHomePage(
                      width: screenWidth,
                      function: () {
                        if (cubit.hospitalInfoModel != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HospitalInfo()));
                        } else {
                          cubit.getHospitalInformation().then((value) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HospitalInfo()));
                          });
                        }
                      },
                      left: 20,
                      top: 330,
                      image: AssetsManager.hospital,
                      text: TextManager.hospitalInfo,
                    ),
                    IconHomePage(
                      width: screenWidth,
                      function: () async {
                        await cubit.getDoctorInfo();
                        if (cubit.doctorInfoModel.isNotEmpty) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DoctorInfo()));
                        }
                      },
                      right: 30,
                      top: 470,
                      image: AssetsManager.doctor,
                      text: TextManager.doctorInfo,
                    ),
                    IconHomePage(
                      width: screenWidth,
                      function: () {
                        cubit.getDoctorInfo();
                        cubit.getDoctorHistory().whenComplete(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MedicalHistory()));
                        });
                      },
                      left: 27,
                      top: 600,
                      image: AssetsManager.medicalHistory,
                      text: TextManager.medicalHistory,
                    ),
                  ],
                )));
      },
    );
  }
}
