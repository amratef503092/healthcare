import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../presentation/resources/color_manager.dart';
import '../presentation/resources/style_manager.dart';
import '../presentation/resources/text_manager.dart';
import '../presentation/resources/value_manager.dart';
import '../shared/bloc/AppCubit.dart';
Widget textFormField({required TextEditingController controller,  String ?labelTitle ,  String? validateText ,bool ?pass}){
  return TextFormField(
    controller: controller,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return validateText;
      }
      return null;
    },style:getMediumStyle(color: Colors.black ,fontSize: AppSize.s20),
    decoration:  InputDecoration(
        labelText: labelTitle,
        labelStyle: getBoldStyle(color: Colors.black,fontSize: AppSize.s20),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color:  Colors.black, width: 4),

          //  when the TextFormField in unfocused
        ) ,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color:  Colors.black , width: 4),
          //  when the TextFormField in focused
        ) ,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 4),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color:  ColorManager.error),
        )
    ),
    keyboardType: TextInputType.emailAddress,
    obscureText: pass!,
  );
}
 bool isLand(context){
  return  MediaQuery.of(context).orientation ==Orientation.landscape;

}
class Button extends StatelessWidget {
  Function ? function;
  String ? text ;
  double ? width;
  double ? height;
  Color ? colorButton;
  double ? fontSize;
  Color ? colorText;
  Color ? coloBorder;
  Button({this.function , this.text , this.height , this.width ,this.colorButton , this.fontSize ,  this.colorText , this.coloBorder} );
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        function!();
      },
      child:  AutoSizeText(text!, style: TextStyle(
        color: colorText,fontSize: fontSize,
      ),maxLines: 1,),
      style: ElevatedButton.styleFrom(
          primary: colorButton,
          fixedSize:  Size(width!, height!),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50) , ) ,side: BorderSide(
          color: coloBorder!
      ) ),
    );
  }
}
class IconHomePage extends StatelessWidget {
  double ? right;
  double ? top;
  double ? left;
  String ?image;
  String ? text;
  Function ? function;
  double ?width;
  IconHomePage({this.left, this.right ,this.top , this.image ,this.text , required this.function ,this.width});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: right,
      top: top,
      left: left,
      child: Container(
        width: width!*0.4,

        child: GestureDetector(
          onTap: (){
            function!();
          },
          child: Column(
            children:   [

              Image(image: AssetImage(image!)),
              SizedBox(
                height: 20,
              ),

              Text(text!, style:TextStyle(fontSize: 11,
                  color: Colors.white,
              ),textAlign: TextAlign.start ,maxLines: 1),
            ],
          ),
        ),
      ),
    );
  }
}
class NavigatorWidget extends StatelessWidget {
  Function ? function;
  NavigatorWidget({this.function});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: Align(
        alignment: Alignment.topLeft,
        child:CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white,
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Color(0xff0D2044),
            ),
            onPressed: (){

              function!();
            },
          ) ,
        ),
      ),
    );
  }
}
class ProfileData extends StatelessWidget {
  ImageProvider ? Image;
  String ? useName;
  String ? email;
  Function ? function;

  ProfileData({required this.useName,
    required this.function,
    required  this.Image,
    required this.email,

    required this.screenHeight,
  }) ;

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children:  [
            CircleAvatar(
              radius: 75,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 70,
                backgroundImage:  Image,
              ),
            ),
            Positioned(
              bottom: 4,
              right: 5,
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 20,
                  child: IconButton(onPressed: (){
                    function!();
                  }
                      , icon: const Icon(
                          Icons.edit
                      )),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: screenHeight*.02,
        ),
        Text(useName!, style: const TextStyle(
            fontSize: AppSize.s24,
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),),
        Text(email! , style: const TextStyle(
            fontSize: AppSize.s14,
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold
        ),),
      ],
    );
  }
}
Widget rowInformation({String ? gender , String ?age , String ? blood}) {
  return IntrinsicHeight(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Column(
          children: [
            Text(gender! , style: const TextStyle(
              color: Colors.white,
              fontSize: AppSize.s28,
              fontWeight: FontWeight.bold,
            ),) ,
            const Text(TextManager.genderText , style: TextStyle(
              color: Colors.blueGrey,
              fontSize: AppSize.s12,
              fontWeight: FontWeight.bold,
            ),) ,
          ],
        ),
        const VerticalDivider(
          color: Colors.white,
          width: 4,
          thickness: 2,
        ),
        Column(
          children: [
            Text(age! , style: const TextStyle(
              color: Colors.white,
              fontSize: AppSize.s20,
              fontWeight: FontWeight.bold,
            ),) ,
            const Text(TextManager.ageText , style: TextStyle(
              color: Colors.blueGrey,
              fontSize: AppSize.s12,
              fontWeight: FontWeight.bold,
            ),) ,
          ],
        ),
        const VerticalDivider(
          color: Colors.white,
          thickness: 2,
        ),
        Column(
          children: [
            Text(blood!, style: const TextStyle(
              color: Colors.white,
              fontSize: AppSize.s28,
              fontWeight: FontWeight.bold,
            ),) ,
            const Text(TextManager.bloodText , style: TextStyle(
              color: Colors.blueGrey,
              fontSize: AppSize.s12,
              fontWeight: FontWeight.bold,
            ),) ,
          ],
        ),

      ],
    ),
  );
}
Column Information({required double screenWidth , required String emergency , required String userInformation}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(41.0),
        child: SizedBox(
          width: screenWidth,
          child: Row(
            children: [
              Text(emergency, style: const TextStyle(
                color: Colors.white,
                fontSize: AppSize.s18,
                fontWeight: FontWeight.bold,
              ),) ,
              const SizedBox(
                width: 5,
              ),
              const Expanded(child: Divider(color: Colors.white, height: 4, thickness: 4,))
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(41,0,0,5),
        child: Container(
          width: screenWidth,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userInformation , style: const TextStyle(
                color: Colors.white,
                fontSize: AppSize.s18,
                fontWeight: FontWeight.bold,
              ),) ,





            ],
          ),
        ),
      ),
    ],
  );
}

 userInfo({required double screenHeight  , required String data}) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
                style: BorderStyle.solid, color: Colors.white)),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(data ,style:TextStyle(
                  fontSize: AppSize.s24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),),
            ),
          ],
        ),

      ),
    ),
  );
}
class DataGet extends StatelessWidget {
  double ?screenWidth;
  double ? screenHeight;
  String ? text;
  String dataText;
  DataGet({
    required this.dataText,
    required this.text,
    required this.screenWidth,
    required this.screenHeight,
  });



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(42,0,42,10),
      child: Container(
        child: Column(
          children: [
            Text(text! , style: TextStyle(
                fontSize: AppSize.s20,
                color: Colors.white
            ),),
            Container(
              width: screenWidth,
              decoration: BoxDecoration(
                color: Color(0xffF5F5F5).withOpacity(0.27),
                borderRadius: BorderRadius.circular(24),
              ),
              child:  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(dataText , style: TextStyle(
                      fontSize: AppSize.s20,
                      color: Colors.white
                  ),),
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }
}
class PatientModel {
  String ? fullName;
  String ? address;
  String ? age;
  String ? iD;
  String ? phoneNumber;
  String ? emergencyNumber;
  String ? bloodTybe;
  String ? loginID;
  PatientModel({this.fullName  , this.address , this.age,this.bloodTybe,this.emergencyNumber,this.iD,this.loginID,this.phoneNumber});

}

Future<bool?> showToastFlutter({ required String ? message , required Color color , }){
  return Fluttertoast.showToast(
      msg: message!,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0
  );
}
// Widget  buildColumn(double screenWidth, BuildContext context, AppCubit cubit )  {
//   return Column(
//     children: [
//       const Text(
//         "Date of birth",
//         style: TextStyle(fontSize: AppSize.s20, color: Colors.white),
//       ),
//       Container(
//         width: screenWidth,
//         decoration: BoxDecoration(
//           color: Color(0xffF5F5F5).withOpacity(0.27),
//           borderRadius: BorderRadius.circular(24),
//         ),
//         child: Center(
//           child: Padding(
//               padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
//               child: InkWell(
//                 onTap: () async{
//                   await showDatePicker(context: context,
//                       initialDate: DateTime.now(), lastDate: DateTime.now(),
//                       firstDate: DateTime((1920))
//
//                   ).then((value)  {
//                     cubit.getDate(value);
//                   });
//
//                 },
//                 child: Container(
//                   height: 60,
//                   child: Center(
//                     child: Text(
//                       cubit.date ??"Enter birth DAte" ,style: const TextStyle(
//                         fontSize: AppSize.s18,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold
//
//                     ),
//                     ),
//                   ),
//                 ),
//               )
//           ),
//         ),
//       ),
//       SizedBox(
//         height: 16,
//       )
//     ],
//   );
// }

Container enterDate({
  required double screenWidth,
  required String text,
  required TextEditingController controller,
  Function? function,
  required FormFieldValidator<String> validator,
  bool password = false
}) {
  return Container(
    child: Column(
      children: [
        Text(
          text,
          style: TextStyle(fontSize: AppSize.s20, color: Colors.white),
        ),
        Container(
          width: screenWidth,
          decoration: BoxDecoration(
            color: Color(0xffF5F5F5).withOpacity(0.27),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
              child: TextFormField(
                onTap: () {
                  function!();
                },
                obscureText: password,
                validator: validator,
                controller: controller,
                cursorColor: Colors.white,
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  filled: false,
                  contentPadding:
                  EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 18,
        )
      ],
    ),
  );
}