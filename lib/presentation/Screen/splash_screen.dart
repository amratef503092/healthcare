import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helthcare/presentation/resources/assets/assetclass.dart';
import 'package:helthcare/shared/bloc/AppCubit.dart';
import 'package:helthcare/shared/bloc/AppStates.dart';

import '../../constant/constants.dart';
import '../resources/text_manager.dart';
import 'LoginScreen.dart';
import 'addDoctorScreen.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer <AppCubit ,AppStates>( listener: (context, state) {

    }, builder: (context ,state){
      var cubit = AppCubit.get(context);
      return   SafeArea(
        child: Scaffold(
          body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetsManager.splashScreenBackground),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: const [
                    Image(image: AssetImage(
                        AssetsManager.splashScreenLogo
                    )),
                    SizedBox(
                      height: 40,
                    ),
                    Text(TextManager.textSplashScreen , style: TextStyle(
                      color: Color(0xff5B8DAA),
                      fontSize: 39,

                    ),
                    ),
                  ],
                ),



                Button(coloBorder: Colors.white, text: TextManager.buttonTextSplashScreen ,
                  colorButton: Color(0xff407884),fontSize: 39,height: 61,width: 239,
                  colorText: Colors.black,function: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder:
                        (context)=> LoginScreen()));
                  },
                )
              ],
            ) /* add child content here */,
          ),
        ),
      );
    },
     );
  }
}
