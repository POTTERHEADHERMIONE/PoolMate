import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:poolmate/colors.dart';
import 'package:poolmate/presentation/screens/screen.dart';
import 'package:poolmate/presentation/screens/signin_page.dart';

import 'package:poolmate/presentation/welcome/widget/NeumorphicButton.dart';

import '../detail/detail.dart';
import 'widget/InfoBtn.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isLocked = false;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: NeumorphicAppBar(
        color: AppColors.appBarBackgroundColor,
        title: isLocked ? FadeInDown(child: titleAppBar(context)) : null,
        actions: [
          if (!isLocked) ...{
            settingAppBar(context),
          } else ...{
            personAppBar(context)
          }
        ],
        leading: isLocked ? menueAppBar(context) : null,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2F353A),
              Color(0xff0D0B0D),
            ],
          ),
        ),
        child: ListView(
          children: [
            if (!isLocked) ...{
              AnimatedContainer(
                curve: Curves.linear,
                duration: const Duration(seconds: 2),
                transform: Matrix4.translationValues(
                  0,
                  isLocked ? -MediaQuery.of(context).size.height : 0,
                  0,
                ),
                child: topBody(context),
              )
            } ,
            const SizedBox(
              height: 20,
            ),
            if (!isLocked) ...{
              AnimatedContainer(
                  curve: Curves.linear,
                  duration: const Duration(seconds: 3),
                  transform: Matrix4.translationValues(
                      isLocked ? MediaQuery.of(context).size.height : 0, 0, 0),
                  child: centerBody(context))
            } else ...{
              statusCenter(context)
            },
            const SizedBox(
              height: 30,
            ),
            if (!isLocked) ...{
              AnimatedContainer(
                curve: Curves.linear,
                duration: const Duration(seconds: 3),
                transform: Matrix4.translationValues(
                    0, isLocked ? MediaQuery.of(context).size.height : 0, 0),
                child: endBody(context),
              ),
            } else ...{
              buttonAC(context)
            }
          ],
        ),
      ),
    );
  }

  Column titleAppBar(BuildContext context) {
    return Column(
    
    );
  }

  AnimatedContainer settingAppBar(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.linear,
      duration: const Duration(seconds: 3),
      transform: Matrix4.translationValues(
          0, isLocked ? -MediaQuery.of(context).size.height : 0, 0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: SizedBox(
          width: 90,
         
        ),
      ),
    );
  }

  AnimatedContainer menueAppBar(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.linear,
      duration: const Duration(seconds: 3),
      transform: Matrix4.translationValues(
          0, isLocked ? 0 : -MediaQuery.of(context).size.height, 0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: SizedBox(
          // width: 90,
     
        ),
      ),
    );
  }

  AnimatedContainer personAppBar(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.linear,
      duration: const Duration(seconds: 1),
      transform: Matrix4.translationValues(
          0, isLocked ? 0 : -MediaQuery.of(context).size.height, 0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: SizedBox(
          // width: 90,
      
        ),
      ),
    );
  }



  Widget buttonAC(BuildContext context) {
    return FadeInUp(
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [
              Color(0xFF353A40),
              Color(0xFF15161A),
            ],
          ),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          border: Border.all(
            strokeAlign: BorderSide.strokeAlignOutside,
            color: AppColors.neumorphicShadowDarkColorEmboss,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'START',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'Tap to turn off or swipe up\for a fast setup',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 75,
              child: buildNeumorphicButton(
                path: 'assets/images/power.png',
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          duration: const Duration(milliseconds: 400),
                          type: PageTransitionType.bottomToTopPop,
                          child: DetailScreen(),
                          childCurrent: WelcomeScreen(),
                          isIos: true));
                },
                borerWidth: 2,
                scale: 0.3,
                color: AppColors.neumorphicBackgroundColorbtnBlue,
                borderColor: AppColors.neumorphicBorderColorBtnBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget statusCenter(BuildContext context) {
    return FadeInLeft(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45),
            child: Text(
              'Status',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FadeIn(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/battery.png',
                          width: 8,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Battery',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '54%',
                      style: Theme.of(context).textTheme.titleSmall,
                    )
                  ],
                ),
              ),
              FadeIn(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/range.png',
                          width: 11,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Range',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                
                  ],
                ),
              ),
              FadeIn(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/tempreture.png',
                          width: 8,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Range',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                 
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          FadeInLeft(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: Text(
                'Information',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 200,
            child: FadeIn(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                scrollDirection: Axis.horizontal,
                children: [
                  infoButton(
                      context: context,
                      onPressed: () {},
                      borderRaduis: 5,
                      info: 'Engine',
                      subtitle: 'Sleeping mode',
                      borerWidth: 1),
                  const SizedBox(
                    width: 20,
                  ),
                  infoButton(
                      context: context,
                      onPressed: () {},
                      borderRaduis: 5,
                      info: 'Climate',
                      subtitle: 'A/C is ON',
                      borerWidth: 1),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Column endBody(BuildContext context) {
    return Column(
      children: [
        Text(
          'START',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
        width: 90,
          child: buildNeumorphicButton(
            path: 'assets/images/lock.png',
            onPressed: () {
              setState(() {
                isLocked = !isLocked; // Toggle the lock state
              });
              // Navigate to the login page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WelcomePage(),
                ),
              );
            },
            borerWidth: 2,
            scale: 0.9,
            color: AppColors.neumorphicBackgroundColorbtnBlue,
            borderColor: AppColors.neumorphicBorderColorBtnBlue,
          ),
        )
      ],
    );
  }

  Column topBody(BuildContext context) {
    return Column(
      children: [
        
        Text(
          'POOL MATE',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}

Stack centerBody(BuildContext context) {
  return Stack(
    alignment: Alignment.centerRight,
    children: [
      SizedBox(
        height: 450,
        width: MediaQuery.of(context).size.width,
      ),
   
    
      Positioned(
        child: FadeInRightBig(
          child: Image.asset(
            'assets/images/cybertruck-mod-black2 1.png',
            //width: MediaQuery.of(context).size.width * 0.9,
            height: 250,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ],
  );
}