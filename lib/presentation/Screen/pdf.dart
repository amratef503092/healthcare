import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helthcare/shared/bloc/AppCubit.dart';
import 'package:helthcare/shared/bloc/AppStates.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../resources/assets/assetclass.dart';
class Pdf extends StatelessWidget {
  const Pdf({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {

      },builder: (context ,state){
        var cubit = AppCubit.get(context);
        print(cubit.medicalHistoryModel[ cubit.index].conditions.toString());
        print(cubit.index);
        return   SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xff335971),
              title:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text( cubit.medicalHistoryModel[ cubit.index].conditions.toString()) ,

                  Text( cubit.medicalHistoryModel[ cubit.index].date.toString()) ,


                ],
              ) ,
            ),
      body: Padding(
        padding:  EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Row(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Date   / " ,style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),) ,
                        Text(
                          cubit.medicalHistoryModel[ cubit.index].date.toString(),style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text("Name / " ,style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),) ,
                        Text(
                          cubit.userInfo!.fullName,style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text("age / " ,style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),) ,
                        Text(
                          cubit.userInfo!.dateTime.toString(),style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image(image:     AssetImage(AssetsManager.logo),),
                     Text(   cubit.userInfo!.hospitalInfo.toString() ,style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),) ,
                  ],
                ),


              ],
            )

          ],
        ),
      )
      ),
        );
    },
    );
  }
}
