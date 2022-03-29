import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helthcare/presentation/Screen/home_screen.dart';
import 'package:helthcare/shared/bloc/AppCubit.dart';
import 'package:helthcare/shared/bloc/AppStates.dart';

import '../../constant/constants.dart';
import '../resources/assets/assetclass.dart';
import '../resources/text_manager.dart';
import '../resources/value_manager.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;
    var screenHeight = _mediaQueryData.size.height;
    return BlocConsumer<AppCubit,AppStates>( listener: (context ,sttate){

    } , builder: (context ,state){
      var cupit = AppCubit.get(context);
      return SafeArea(
        child: Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetsManager.profileImageBackGround),
                  fit: BoxFit.cover,
                ),
              ),
              child: SizedBox(
                width: screenWidth,
                child: Column(
                  children: [
                    NavigatorWidget(
                      function: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => HomeScreen()));
                      },
                    ),
                    ProfileData(
                        Image: NetworkImage(cupit.userInfo?.photo ??
                           "https://cdn1.vectorstock.com/i/thumb-large/22/05/male-profile-picture-vector-1862205.jpg"),
                      screenHeight: screenHeight,

                      function: () {
                          cupit.getDoctorInfo();
                      },
                      useName: cupit.userInfo?.fullName,
                      email: cupit.userInfo?.emailAddres,
                    ),
                    SizedBox(
                      height: screenHeight * .04,
                    ),
                    rowInformation(
                        age:   cupit.userInfo!.dateTime.toString(),
                        blood: cupit.userInfo?.bloodTybe,
                        gender:cupit.userInfo?.gender
                    ),
                    Information(
                      screenWidth: screenWidth,
                      emergency: cupit.userInfo!.emergencyNumber.toString(),
                      userInformation: TextManager.userInformation,
                    ),
                    userInfo(screenHeight: screenHeight, data: 'User Info'),
                  ],
                ),
              ),
            )),
      );
      });
  }

}

