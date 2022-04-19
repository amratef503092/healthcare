import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:helthcare/presentation/Screen/screenDocotorThree.dart';
import 'package:helthcare/presentation/Screen/selectDoctor.dart';

import '../../constant/constants.dart';
import '../../shared/bloc/AppCubit.dart';
import '../../shared/bloc/AppStates.dart';
import '../resources/assets/assetclass.dart';
class AddDoctorScreen extends StatefulWidget {
  const AddDoctorScreen({Key? key}) : super(key: key);

  @override
  State<AddDoctorScreen> createState() => _AddDoctorScreenState();
}

String? selectedValue;
String? selectedValue2;

class _AddDoctorScreenState extends State<AddDoctorScreen> {
  @override

  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(listener: (context, state) {

    },
      builder: (context ,state){
        var cubit = AppCubit.get(context);
        var size = MediaQuery.of(context).size;
        var screenHeight = size.height;
        var screenWidth = size.width;
      return SafeArea(
        child: Scaffold(
          body:Container(
          width: screenWidth,
          decoration: const BoxDecoration(
          image: DecorationImage(
          image: AssetImage(AssetsManager.backGroundAdmin),
        fit: BoxFit.cover,
        ),
        ),
        child: Column(

        children: [
          NavigatorWidget(
            function: () {
              Navigator.pop(context);
            },
          ),
          Container(
            width: screenWidth,
            height: screenHeight*.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: screenHeight*.1,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.83),
                          border: Border.all(
                              color: Color(0xff707070),
                              width: 3
                          ),

                          borderRadius: BorderRadius.circular(30)
                      ),

                      child:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            dropdownDecoration: BoxDecoration(
                                color:  Colors.white.withOpacity(0.83),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                )
                            ),
                            icon: const CircleAvatar(
                              radius: 20,
                              backgroundColor: Color(0xff707070),
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: Color(0xffFFFFFF),
                                child: Icon(
                                  Icons.arrow_downward,
                                  size: 30,
                                  color: Color(0xff707070),
                                ),
                              ),
                            ),
                            hint: Text(
                              'Doctor qualification',
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme
                                    .of(context)
                                    .hintColor,
                              ),
                            ),
                            items: cubit.doctorQualification
                                .map((item) =>
                                DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                                .toList(),
                            value: selectedValue,

                            onChanged: (value) async {
                              setState(()  {
                                selectedValue = value.toString();
                              });



                            },

                          ),
                        ),
                      ),

                    )
                ),

              ],
            ),
          ),
          Button(
            height: screenHeight*.1,
            width: screenWidth*.8,
            text: "Next",
            function: () async {
              if(selectedValue != null) {
                await cubit.getDoctorName(selectedValue!);
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    AddDoctorScreen2()
                ));
              }else{
                showToastFlutter(message: 'Select Doctor qualification',color: Colors.red
                );
              }


            },
            colorText: Colors.black,
            fontSize: 30,
            coloBorder: Color(0xff707070),
            colorButton: Colors.white,
          )
        ],
        ),
        ),
      ));
      },
    );
  }
}
