import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:neighbour_bazaar/login_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return  Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Column(children: [
        Container(
          width: w,
          height: h * 0.3,
          decoration:  BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("img/signup1.png"), fit: BoxFit.cover)
          ),
          // child: Column(
          //   children: [
          //     SizedBox(height: h*0.16,),
          //     CircleAvatar(
          //       radius: 60,
          //       backgroundImage: AssetImage(
          //         "img/signupicon.png"
          //       ),
          //     )
          //   ],
          // ),
        ),
        SizedBox(height: 50,),
        GestureDetector(
          onTap: ()
          {
            //  if(_formkey.currentState!.validate())
            //  {
            Get.offAll(()=>const LoginPage());
            //}
          },
          child: Container(
              width: w*0.5,
              height: h * 0.08,
              decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      image: AssetImage("img/loginbtn.png"), fit: BoxFit.cover)
              ),
              child: Center(
                child: Text("Log Out",
                  style: TextStyle(fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),

                ),
              )
          ),
        ),
        SizedBox(height: w*0.08,)


      ]),
    );
  }
}

