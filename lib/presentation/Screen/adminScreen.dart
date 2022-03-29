import 'package:flutter/material.dart';
import 'package:helthcare/presentation/Screen/CreateUser.dart';
import 'package:helthcare/presentation/Screen/searchPatint.dart';

import '../resources/assets/assetclass.dart';
class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: width,
          decoration: const BoxDecoration(
          image: DecorationImage(
          image: AssetImage(AssetsManager.backGroundAdmin),
           fit: BoxFit.cover,
      ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){

              Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateUserScreen()));
            },
            child: Image(image: AssetImage(
              AssetsManager.buttonBackGround
            ),

            ),
          ),
          SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: (){

              Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPatient()));
            },
            child: Image(image: AssetImage(
                AssetsManager.searchButton
            ),

            ),
          )
        ],

      )
      ),),
    );
  }
}
