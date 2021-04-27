import 'package:GRSON/secondPages/customer_screens/EditProfile.dart';
import 'package:GRSON/secondPages/customer_screens/Queue/QueuePage.dart';
import 'package:GRSON/secondPages/customer_screens/Take%20Away/TakeAwayPage.dart';
import 'package:GRSON/secondPages/customer_screens/home.dart';
import 'package:GRSON/secondPages/customer_screens/cus-profile.dart';
import 'package:GRSON/secondPages/restaurant_screens/My_Restaurant/Operation_pages/TakeAwayAccepet.dart';
import 'package:GRSON/secondPages/restaurant_screens/My_Restaurant/Operation_pages/queueAccepet.dart';
import 'package:GRSON/secondPages/restaurant_screens/My_Restaurant/Operation_pages/queueAcceptDetails.dart';
import 'package:GRSON/secondPages/restaurant_screens/REditProfile.dart';
import 'package:GRSON/secondPages/restaurant_screens/res-profile.dart';
import 'package:GRSON/secondPages/restaurant_screens/home.dart';
import 'package:GRSON/secondPages/visitor_screens/home.dart';
import 'package:GRSON/welcomePages/Signin/components/forgot_password.dart';
import 'package:GRSON/welcomePages/Signin/components/password_validation.dart';
import 'package:GRSON/welcomePages/Signin/login_screen.dart';
import 'package:GRSON/welcomePages/Signup/components/email_validation.dart';
import 'package:GRSON/welcomePages/Signup/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:GRSON/welcomePages/Welcome/welcome_screen.dart';
import 'package:GRSON/welcomePages/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'secondPages/restaurant_screens/My_Restaurant/Restaurant_Pages/Queue/queueAdd.dart';
import 'secondPages/restaurant_screens/My_Restaurant/Restaurant_Pages/Take_Away/AddItem.dart';
import 'secondPages/restaurant_screens/My_Restaurant/Restaurant_Pages/myRestaurant.dart';

void main() async {
  await GetStorage.init();
  final box = GetStorage();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final UserData = await box.read('UserRole');
  runApp(MyApp(
    currentUserRole: UserData,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({this.currentUserRole});

  String currentUserRole;

  @override
  Widget build(BuildContext context) {
    print(currentUserRole);
    return GetMaterialApp(
        title: 'GRSON',
        theme: ThemeData(
            fontFamily: 'OpenSans',
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: Colors.white),
        home: FirebaseAuth.instance.currentUser == null
            ? WelcomeScreen()
            : currentUserRole == 'SingingCharacter.restaurant'
                ? RHome()
                : CHome(),
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          //SecondPages
          "/home": (BuildContext context) => new CHome(),
          "Restaurant": (BuildContext context) => new RHome(),
          "Restaurant page": (BuildContext context) => new RestaurantPage(),
          "Queue add": (BuildContext context) => new QueueAdd(),
          "Queue acc": (BuildContext context) => new QueueAccepet(),
          "Take Away acc": (BuildContext context) => new TakeAwayAccepet(),
          "Add item": (BuildContext context) => new AddItem(),
          "/profile": (BuildContext context) => new Profile(),
          "/editprofile": (BuildContext context) => new CEditProfile(),
          "/editprofile2": (BuildContext context) => new REditProfile(),
          "resprofile": (BuildContext context) => new ResProfile(),
          "Queue page user side": (BuildContext context) => new QueuePage(),
          "Take Away page user side": (BuildContext context) =>
              new TakeAwayPage(),
          "V home": (BuildContext context) => new VHome(),
          //WelcomePages
          "WelcomePage": (BuildContext context) => new WelcomeScreen(),
          "Sign Up": (BuildContext context) => new SignUpScreen(),
          'Sign In': (BuildContext context) => new LoginScreen(),
          'Forgot Password': (BuildContext context) => new ForgotPassword(),
          'validation': (BuildContext context) => new VerifyEmail(),
          'queueAcceptDetails': (BuildContext context) =>
              new queueAcceptDetails(),
          'passValidation': (BuildContext context) =>
              new VerifyEmailForPassword(),
        });
  }
}
