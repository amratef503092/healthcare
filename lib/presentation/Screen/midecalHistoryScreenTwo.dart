import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helthcare/presentation/Screen/Medical_History_Screen_Three.dart';
import 'package:helthcare/presentation/Screen/pdf.dart';
import 'package:helthcare/shared/bloc/AppCubit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../constant/constants.dart';
import '../../shared/bloc/AppStates.dart';
import '../resources/assets/assetclass.dart';
import '../resources/text_manager.dart';
class MedicalHistoryScreenTwo extends StatefulWidget {
  final int ?index;
   MedicalHistoryScreenTwo( {this.index});

  @override
  State<MedicalHistoryScreenTwo> createState() => _MedicalHistoryScreenTwoState();
}

class _MedicalHistoryScreenTwoState extends State<MedicalHistoryScreenTwo> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height;
    var screenWidth = size.width;

    return BlocConsumer<AppCubit,AppStates>( listener: (context, state) {

    } , builder: (context ,satate){
      var cubit = AppCubit.get(context);

      List<DataGet> list = [
        DataGet(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          text: TextManager.conditions,
          dataText: cubit.medicalHistoryModel[widget.index!].conditions.toString(),
        ),
        DataGet(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          text: TextManager.doctorQualifications,
          dataText: cubit.qualification.toString(),
        ),
        DataGet(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          text: TextManager.treatment,
          dataText: cubit.medicalHistoryModel[widget.index!].treatment.toString(),
        ),
      ];
      return SafeArea(child:
      Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetsManager.backGroundMedical),
                fit: BoxFit.cover,
              ),
            ),
            child:Column(
              children: [
                NavigatorWidget(
                  function: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  width: double.infinity,
                  height: screenHeight*.4,
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

                MaterialButton(onPressed: () async {
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>Pdf(index)));
                } ,
                  height: 56,
                  minWidth: screenWidth*.8,
                  color: Colors.white.withOpacity(0.7),
                  shape:  RoundedRectangleBorder(borderRadius:BorderRadius.circular(28.0), ),
                  child:  Text(TextManager.downloadFiles),
                ),
                SizedBox(height: screenHeight*0.3,),
                MaterialButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      MedicalHistoryScreenThree(),
                  ));
                } ,
                  height: 56,
                  minWidth: screenWidth*.5,
                  color: Colors.white.withOpacity(0.7),
                  shape:  RoundedRectangleBorder(borderRadius:BorderRadius.circular(28.0), ),
                  child: Text(TextManager.next),
                ),

              ],
            ),
          )
      ));
    },);
  }
}
