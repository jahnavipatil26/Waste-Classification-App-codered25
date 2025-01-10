// import 'package:deep_waste/screens/OnboardingScreen.dart';
import 'package:deep_waste/controller/category_notifier.dart';
import 'package:deep_waste/controller/item_notifier.dart';
import 'package:deep_waste/controller/reward_notifier.dart';
import 'package:deep_waste/controller/tips_notifier.dart';
import 'package:deep_waste/controller/user_notifier.dart';
import 'package:provider/provider.dart';
import 'package:deep_waste/routes.dart';
import 'package:deep_waste/screens/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CategoryNotifier()),
          ChangeNotifierProvider(create: (_) => ItemNotifier()),
          ChangeNotifierProvider(create: (_) => RewardNotifier()),
          ChangeNotifierProvider(create: (_) => UserNotifier()),
          ChangeNotifierProvider(create: (_) => TipsNotifier()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Deep Waste',
          theme: ThemeData(
            appBarTheme: AppBarTheme(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black //here you can give the text color
                ),
            brightness: Brightness.light,
            canvasColor: Colors.transparent,
            primarySwatch: Colors.blue,
            fontFamily: "Montserrat",
          ),
          builder: EasyLoading.init(),
          //initialRoute: SplashScreen.routeName,
          home: LoginPage(),
          routes: routes,
        ));
  }
}

// import 'package:flutter/material.dart';
// import 'login_page.dart'; // Import the login page
// import 'waste_classifier.dart'; // Import the waste classifier page
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Waste Classifier',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: LoginPage(), // Start with the LoginPage
//     );
//   }
// }