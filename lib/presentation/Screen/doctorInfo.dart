import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helthcare/shared/bloc/AppCubit.dart';
import 'package:helthcare/shared/bloc/AppStates.dart';

import '../../constant/constants.dart';
import '../resources/assets/assetclass.dart';
import '../resources/color_manager.dart';
import '../resources/style_manager.dart';
import '../resources/text_manager.dart';
import '../resources/value_manager.dart';
import 'DoctorInformation.dart';
class DoctorInfo extends StatelessWidget {
  const DoctorInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height;
    var screenWidth = size.width;

    return BlocConsumer<AppCubit,AppStates>( listener: (context ,state ){

    } ,
    builder: (context ,state){
      var cubit = AppCubit.get(context);

        int lastindex =0;
        List<DataGet> list = [

          DataGet(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            text: TextManager.doctorName,
            dataText: cubit.doctorInfoModel[lastindex].name??'null',
          ),

          DataGet(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            text: TextManager.address,
            dataText: cubit.doctorInfoModel[lastindex].address??'null',
          ),
          DataGet(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            text: TextManager.department,
            dataText: cubit.doctorInfoModel[lastindex].department??'null',
          ),
          DataGet(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            text: TextManager.id,
            dataText: cubit.doctorInfoModel[lastindex].id??'null',
          ),
          DataGet(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            text: TextManager.phoneNumber,
            dataText: cubit.doctorInfoModel[lastindex].phoneNumber??'null',
          ),
          DataGet(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            text: TextManager.qualificationsDoctor,
            dataText: cubit.doctorInfoModel[lastindex].qualification??'null',
          ),

        ];
        return  SafeArea(
            child: Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetsManager.backGroundDoctorInfo),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  width: double.infinity,
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
      }


    ,);
  }
}
