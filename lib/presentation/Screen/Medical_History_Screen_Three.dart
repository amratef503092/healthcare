import 'package:flutter/material.dart';
import 'package:helthcare/presentation/resources/value_manager.dart';

import '../../constant/constants.dart';
import '../resources/assets/assetclass.dart';
import '../resources/text_manager.dart';

class MedicalHistoryScreenThree extends StatefulWidget {
   MedicalHistoryScreenThree({Key? key}) : super(key: key);

  @override
  State<MedicalHistoryScreenThree> createState() => _MedicalHistoryScreenThreeState();
}

class _MedicalHistoryScreenThreeState extends State<MedicalHistoryScreenThree> {
   List<TableRow> listYes = [];

   List<TableRow> listNo = [];

   bool isSelectYes = false;
   bool isSelectNo = false;


   @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height;
    var screenWidth = size.width;
    List<DataGet> list = [
      DataGet(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        text: TextManager.patientName,
        dataText: "sameh",
      ),
      DataGet(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        text: TextManager.height,
        dataText: "Egypt Cairo",
      ),
      DataGet(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        text: TextManager.weight,
        dataText: "hart",
      ),
      DataGet(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        text: TextManager.diagnosis,
        dataText: "hart",
      ),
      DataGet(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        text: TextManager.howDidTheInjuryOccur,
        dataText: "hart",
      ),
      DataGet(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        text: TextManager.haveYouHadSurgeryBefore,
        dataText: "hart",
      ),
      DataGet(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        text: TextManager.yourLastMedicalConddition,
        dataText: "hart",
      ),
      DataGet(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        text: TextManager.date,
        dataText: "hart",
      ),
    ];
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsManager.backGroundMedical),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              NavigatorWidget(
                function: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 40,
              ),
              const Text(
                TextManager.medicalHistoryUpdate,
                style: TextStyle(
                    fontSize: AppSize.s28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: screenHeight,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
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
              Table(
                border: TableBorder.all(color: Colors.white, width: 4),
                columnWidths: const <int, TableColumnWidth>{
                  0: FlexColumnWidth(3),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: <TableRow>[
                  TableRow(
                    children: <Widget>[
                      TableWidgetText(text: TextManager.condditions),
                      (!isSelectYes) ? InkWell(child: TableWidgetText(text: TextManager.yes) , onTap: (){
                        setState(() {
                          isSelectYes = !isSelectYes;
                        });
                        print(isSelectYes);
                      },) :InkWell(child: TableWidgetText(text: TextManager.yes ,color :Colors.green) , onTap: (){
                        setState(() {
                          isSelectYes = !isSelectYes;
                        });
                        print(isSelectYes);
                      },),

                      (isSelectYes) ? InkWell(child: TableWidgetText(text: TextManager.no) , onTap: (){
                        setState(() {
                          isSelectYes = !isSelectYes;
                        });
                        print(isSelectNo);
                      },) :InkWell(child: TableWidgetText(text: TextManager.no ,color :Colors.red) , onTap: (){
                        setState(() {
                          isSelectYes = !isSelectYes;
                        });
                        print(isSelectYes);
                      },),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TableWidgetText(text: TextManager.headache),
                      TableWidgetText(text: TextManager.yes),
                      TableWidgetText(text: TextManager.no),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TableWidgetText(text: TextManager.backInjury),
                      TableWidgetText(text: TextManager.yes),
                      TableWidgetText(text: TextManager.no),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TableWidgetText(text: TextManager.bleedingDisorder),
                      TableWidgetText(text: TextManager.yes),
                      TableWidgetText(text: TextManager.no),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TableWidgetText(text: TextManager.cancer),
                      TableWidgetText(text: TextManager.yes),
                      TableWidgetText(text: TextManager.no),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TableWidgetText(text: TextManager.dizzyOrFainting),
                      TableWidgetText(text: TextManager.yes),
                      TableWidgetText(text: TextManager.no),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TableWidgetText(text: TextManager.hernia),
                      TableWidgetText(text: TextManager.yes),
                      TableWidgetText(text: TextManager.no),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TableWidgetText(text: TextManager.highBloodPressure),
                      TableWidgetText(text: TextManager.yes),
                      TableWidgetText(text: TextManager.no),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TableWidgetText(text: TextManager.pregnancy),
                      TableWidgetText(text: TextManager.yes),
                      TableWidgetText(text: TextManager.no),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TableWidgetText(text: TextManager.smoking),
                      TableWidgetText(text: TextManager.yes),
                      TableWidgetText(text: TextManager.no),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TableWidgetText(text: TextManager.specialDietGuidelines),
                      TableWidgetText(text: TextManager.yes),
                      TableWidgetText(text: TextManager.no),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TableWidgetText(text: TextManager.kidneyProblems),
                      TableWidgetText(text: TextManager.yes),
                      TableWidgetText(text: TextManager.no),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TableWidgetText(text: TextManager.vomiing),
                      TableWidgetText(text: TextManager.yes),
                      TableWidgetText(text: TextManager.no),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TableWidgetText(text: TextManager.fracture),
                      TableWidgetText(text: TextManager.yes),
                      TableWidgetText(text: TextManager.no),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}

class TableWidgetText extends StatelessWidget {
  String? text;
  Color ?  color;
  TableWidgetText({required this.text ,  this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          text!,
          style: TextStyle(
              color: color??Colors.white,
              fontSize: AppSize.s20,
              fontWeight: FontWeight.bold),
          maxLines: 2,
        ),
      ),
    );
  }
}
