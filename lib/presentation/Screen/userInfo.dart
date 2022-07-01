import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helthcare/presentation/resources/text_manager.dart';
import 'package:helthcare/presentation/resources/value_manager.dart';
import 'package:helthcare/shared/bloc/AppCubit.dart';
import 'package:helthcare/shared/bloc/AppStates.dart';

import '../../constant/constants.dart';
import '../resources/assets/assetclass.dart';

class UserInfo extends StatelessWidget {
  UserInfo({Key? key}) : super(key: key);
  var useNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;
    var screenHeight = _mediaQueryData.size.height;
    return BlocConsumer<AppCubit ,AppStates>(listener: (context, state) {

    },  builder:(context ,state){

      var cubit = AppCubit.get(context);



      List<DataGet> list = [
        DataGet(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          text: TextManager.fullName,
          dataText: cubit.userInfo!.fullName,
        ),
        DataGet(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          text: TextManager.address,
          dataText: cubit.userInfo!.address,
        ),
        DataGet(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          text: TextManager.ageText,
          dataText: cubit.userInfo!.dateTime.toString(),
        ),
        DataGet(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          text: TextManager.id,
          dataText: cubit.userInfo!.id,
        ),
        DataGet(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          text: TextManager.phoneNumber,
          dataText: cubit.userInfo!.phoneNumber.toString(),
        ),
        DataGet(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          text: TextManager.emergency,
          dataText: cubit.userInfo!.emergencyNumber.toString(),
        ),
        DataGet(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          text: TextManager.bloodText,
          dataText: cubit.userInfo!.bloodTybe,
        ),
        DataGet(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          text: TextManager.loginId,
          dataText: cubit.userInfo!.loginID,
        ),
      ];
      return SafeArea(
          child: Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetsManager.userInfoBackground),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                width: screenWidth,
                child: Column(
                  children: [
                    NavigatorWidget(
                      function: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return DataGet(
                            dataText: list[index].dataText,
                            text: list[index].text,
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                          );
                        },
                        itemCount: list.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
    } );
  }
}
