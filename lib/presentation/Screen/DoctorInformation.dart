import 'package:flutter/material.dart';

import '../../constant/constants.dart';
import '../resources/assets/assetclass.dart';
import '../resources/text_manager.dart';
class DoctorInformation extends StatelessWidget {
  const DoctorInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height;
    var screenWidth = size.width;
    List<DataGet> list = [
      DataGet(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        text: TextManager.doctorName,
        dataText: "sameh",
      ),


      DataGet(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        text: TextManager.address,
        dataText: "Egypt Cairo",
      ),
      DataGet(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        text: TextManager.department,
        dataText: "hart",
      ),
      DataGet(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        text: TextManager.id,
        dataText: "22314",
      ),
      DataGet(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        text: TextManager.phoneNumber,
        dataText: "141asdasd4",
      ),
      DataGet(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        text: TextManager.qualificationsDoctor,
        dataText: "10010010101010010",
      ),

    ];
    return SafeArea(
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
}
