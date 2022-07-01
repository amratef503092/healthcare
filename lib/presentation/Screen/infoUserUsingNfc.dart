import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helthcare/presentation/resources/text_manager.dart';
import 'package:helthcare/presentation/resources/value_manager.dart';
import 'package:helthcare/shared/bloc/AppCubit.dart';
import 'package:helthcare/shared/bloc/AppStates.dart';

import '../../constant/constants.dart';
import '../resources/assets/assetclass.dart';


class UserInfoUsingNFC extends StatelessWidget {
  UserInfoUsingNFC({Key? key}) : super(key: key);
  var useNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;
    var screenHeight = _mediaQueryData.size.height;

    return BlocConsumer<AppCubit ,AppStates>(listener: (context, state) {

    },  builder:(context ,state){

      
      

      return  SafeArea(
          child: Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetsManager.userInfoBackground),
                  fit: BoxFit.cover,
                ),
              ),
              child: ConditionalBuilder(
                condition: AppCubit.get(context).userInfo2.isNotEmpty,
                builder: (context)=> SingleChildScrollView(
                  child: Expanded(
                    child: SizedBox(
                      width: screenWidth,
                      child: Column(
                        children: [
                          NavigatorWidget(
                            function: () {
                              AppCubit.get(context).userInfo2 =[];
                              Navigator.pop(context);
                            },
                          ),
                          Column(
                            children: [
                              DataGet(
                                dataText: AppCubit.get(context).userInfo2[0].fullName,
                                text: TextManager.fullName,
                                screenHeight: screenHeight,
                                screenWidth: screenWidth,
                              ),DataGet(
                                dataText: AppCubit.get(context).userInfo2[0].phoneNumber,
                                text: TextManager.phoneNumber,
                                screenHeight: screenHeight,
                                screenWidth: screenWidth,
                              ),
                              DataGet(
                                dataText: AppCubit.get(context).userInfo2[0].address,
                                text: TextManager.address,
                                screenHeight: screenHeight,
                                screenWidth: screenWidth,
                              ),
                              DataGet(
                                dataText: AppCubit.get(context).userInfo2[0].emergencyNumber,
                                text: TextManager.emergency,
                                screenHeight: screenHeight,
                                screenWidth: screenWidth,
                              ),
                              DataGet(
                                dataText: AppCubit.get(context).userInfo2[0].bloodTybe,
                                text: TextManager.bloodText,
                                screenHeight: screenHeight,
                                screenWidth: screenWidth,
                              ),
                              DataGet(
                                dataText: AppCubit.get(context).userInfo2[0].hospitalInfo.toString(),
                                text: TextManager.hospitalInfo,
                                screenHeight: screenHeight,
                                screenWidth: screenWidth,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                fallback: (context)=> CircularProgressIndicator (),
              )
            ),
          ));
    } );
  }
}
