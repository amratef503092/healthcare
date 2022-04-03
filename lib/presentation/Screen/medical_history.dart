import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helthcare/shared/bloc/AppCubit.dart';
import 'package:helthcare/shared/bloc/AppStates.dart';

import '../../constant/constants.dart';
import '../resources/assets/assetclass.dart';
import 'midecal.dart';
import 'midecalHistoryScreenTwo.dart';
import 'package:intl/intl.dart';

class MedicalHistory extends StatelessWidget {
  const MedicalHistory({Key? key}) : super(key: key);
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
            width: screenWidth,
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
                         cubit.doctorNameId= cubit.doctor[index];
                          cubit.getDoctorDataHistory(cubit.doctor[index]).then((value) {
                            cubit.getQualifications(cubit.doctor[index]);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                Medical() ));
                          });

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
                                FittedBox(
                                  child: Text(cubit.doctor[index].toString() ,
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold
                                  ),),
                                ),

                              ],
                            ),
                          ),
                        ),
                      );
                    }, separatorBuilder: (context , index){
                      return SizedBox(
                        height: 45,
                      );

                    }, itemCount: cubit.doctor.length,
                    )
                  )

                ],
              ),
            ) ,
          )));
    },);
  }
}
