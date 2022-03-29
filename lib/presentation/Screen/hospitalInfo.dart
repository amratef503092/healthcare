import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helthcare/shared/bloc/AppCubit.dart';
import 'package:helthcare/shared/bloc/AppStates.dart';

import '../../constant/constants.dart';
import '../resources/assets/assetclass.dart';
import '../resources/text_manager.dart';
class HospitalInfo extends StatelessWidget {
   HospitalInfo({Key? key}) : super(key: key);

  @override


  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height;
    var screenWidth = size.width;

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {

      },
      builder: (context ,state) {

        var cubit = AppCubit.get(context);
        List<DataGet> list = [
          DataGet(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            text: TextManager.hospitalName,
            dataText: cubit.hospitalInfoModel?.name.toString()??"null",
          ),
          DataGet(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            text: TextManager.address,
            dataText: cubit.hospitalInfoModel?.address.toString()??"null",
          ),
          DataGet(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            text: TextManager.city,
            dataText: cubit.hospitalInfoModel?.city.toString()??"null",
          ),
          DataGet(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            text: TextManager.id,
            dataText: cubit.hospitalInfoModel?.id.toString()??"null",
          ),
          DataGet(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            text: TextManager.phoneNumber,
            dataText: cubit.hospitalInfoModel?.phone??"null",
          ),

        ];
        return SafeArea(child :Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetsManager.backGroundHospitalInfo),
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
            )));
      },
    );
  }
}
