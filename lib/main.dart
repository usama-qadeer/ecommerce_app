import 'package:ecommerce_app/screens/layout_screen.dart';
import 'package:ecommerce_app/screens/web_admin_area/addProducts_screen.dart';
import 'package:ecommerce_app/screens/web_admin_area/dashboard_screen.dart';
import 'package:ecommerce_app/screens/web_admin_area/deleteProducts_screen.dart';
import 'package:ecommerce_app/screens/web_admin_area/updateProducts.dart';
import 'package:ecommerce_app/screens/web_admin_area/web_body.dart';
import 'package:ecommerce_app/screens/web_admin_area/web_login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() async {
  if (kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        name: "aaa",
        options: const FirebaseOptions(
          apiKey: "AIzaSyDnpgMowXwWxcZuyYXs_r1UXNL3oUde8YM",
          authDomain: "online-bazar-99c5c.firebaseapp.com",
          projectId: "online-bazar-99c5c",
          storageBucket: "online-bazar-99c5c.appspot.com",
          messagingSenderId: "270593086385",
          appId: "1:270593086385:web:7bd075283b3567cf2c2390",
        ));
  } else {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Online Bazar',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
                .copyWith(background: Colors.white),
            scaffoldBackgroundColor: Colors.white,
          ),
          debugShowCheckedModeBanner: false,
          home: const LayoutScreen(),
          routes: {
            WebLoginScreen.id: (context) => const WebLoginScreen(),
            WebMainScreen.id: (context) => WebMainScreen(),
            DashboardScreen.id: (context) => const DashboardScreen(),
            AddProductScreen.id: (context) => AddProductScreen(),
            UpdateProductScreen.id: (context) => const UpdateProductScreen(),
            DeleteProductScreen.id: (context) => const DeleteProductScreen(),
          },
        );
      },
    );
  }
}
