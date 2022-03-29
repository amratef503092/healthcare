import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helthcare/shared/bloc/AppCubit.dart';
import 'package:helthcare/shared/bloc/AppStates.dart';

import '../../constant/constants.dart';
import '../resources/assets/assetclass.dart';
import 'addDoctorScreen.dart';
import 'midecalHistoryScreenTwo.dart';
import 'package:intl/intl.dart';

class Medicaladd extends StatelessWidget {
  const Medicaladd({Key? key}) : super(key: key);
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
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            //     MedicalHistoryScreenTwo(cubit.doctor[index]) ));
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
                                  Text(cubit.doctorInfoModel[index].name.toString() ,
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold
                                    ),),

                                ],
                              ),
                            ),
                          ),
                        );
                      }, separatorBuilder: (context , index){
                        return SizedBox(
                          height: 45,
                        );

                      }, itemCount: cubit.doctorInfoModel.length,
                      )
                  )

                ],
              ),
            ) ,
          ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        cubit.getDoctorQualifications().then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>
            AddDoctorScreen())));

      },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          size: 40,
          color: Colors.blue,
        ),

      ),
      )

      );
    },);
  }
}
