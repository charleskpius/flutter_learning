import 'package:first_app/app_theme.dart';
import 'package:first_app/cart.dart';
import 'package:first_app/cart_provider.dart';
import 'package:first_app/home.dart';  // Import the home page file
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:first_app/setting.dart';
import 'package:first_app/shared_preference.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  bool isLoggedIn = await SharedPreferencesService().getUserLoginStatus();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier(),),
      ChangeNotifierProvider(
        create: (context) => CartProvider(),
        child: const CartPage(),
      ),
      // Add other providers if needed
    ],
    child: MyApp(isLoggedIn: isLoggedIn),
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: AppTheme.festiveTheme(),
      dark: AppTheme.festiveTheme().copyWith(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Provider.of<ThemeNotifier>(context).isDarkMode ? AppTheme.darkTheme() : AppTheme.festiveTheme(),
        home: isLoggedIn ? const HomeScreen() : const SignUpPage(),  // Use HomePage for logged-in users, otherwise SignUpPage
      ),
    );
  }
}
