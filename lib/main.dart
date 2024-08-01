import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:formapplication/features/adminScreen/provider/admin_provider.dart';
import 'package:formapplication/features/adminScreen/screens/admin_screen.dart';
import 'package:formapplication/features/login/screens/provider/login_provider.dart';
import 'package:formapplication/features/myRequestsScreen/provider/my_request_screen_provider.dart';
import 'package:formapplication/features/myRequestsScreen/screnns/my_requests_screen.dart';
import 'package:formapplication/features/homeScreen/provider/home_screen_provider.dart';
import 'package:formapplication/features/homeScreen/screens/home_screen.dart';
import 'package:formapplication/features/login/screens/splash_screen.dart';
import 'package:formapplication/features/myRequestsScreen/screnns/request_details_screen.dart';
import 'package:formapplication/firebase_options.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localization.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeScreenProvider()),
        ChangeNotifierProvider(create: (_) => MyRequestProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => AdminProvider()),
      ],
      child: Consumer<HomeScreenProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: provider.language,
            theme:
                ThemeData(primaryColor: const Color.fromARGB(255, 179, 33, 23)),
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
