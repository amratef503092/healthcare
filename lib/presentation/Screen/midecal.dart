import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helthcare/shared/bloc/AppCubit.dart';
import 'package:helthcare/shared/bloc/AppStates.dart';

import '../../constant/constants.dart';
import '../resources/assets/assetclass.dart';
import '../resources/value_manager.dart';
import 'midecalHistoryScreenTwo.dart';
import 'package:intl/intl.dart';

class Medical extends StatelessWidget {
  const Medical({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit ,AppStates>(listener: (context, state) {

    } , builder: (context ,state){
      var size = MediaQuery.of(context).size;
      var screenHeight = size.height;
      var screenWidth = size.width;
      var cubit = AppCubit.get(context);

      return   SafeArea(child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetsManager.backGroundMedical),
                fit: BoxFit.cover,
              ),
            ),
            child:SizedBox(
              child: Column(
                children: [
                  NavigatorWidget(
                    function: () {

                      Navigator.pop(context);

                    },
                  ),
                  Expanded(
                      child: ListView.separated(itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            cubit.index = index;
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                MedicalHistoryScreenTwo(index: index) ));

                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.47),
                                borderRadius: BorderRadius.circular(79)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text(cubit.medicalHistoryModel[index].conditions.toString() ,
                                       style: const TextStyle(
                                           fontWeight: FontWeight.bold
                                       ),),

                                     AutoSizeText(cubit.medicalHistoryModel[index].date.toString() ,
                                       style: const TextStyle(
                                           fontWeight: FontWeight.bold,
                                       ),  maxLines: 2,
                                       minFontSize: 14,
                                       stepGranularity: 0.1,
                                     ),




                                   ],

                                 )

                                ],
                              ),
                            ),
                          ),
                        );
                      }, separatorBuilder: (context , index){
                        return SizedBox(
                          height: 45,
                        );

                      }, itemCount: cubit.medicalHistoryModel.length,
                      )
                  )

                ],
              ),
            ) ,
          )));
    },);
  }
}
