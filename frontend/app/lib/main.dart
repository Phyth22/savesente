import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'screens/wallet_screen.dart';
import 'screens/signup_screen.dart'; // Verify this path is correct


// import 'screens/splash_screen.dart'; // initial splash screen

// import 'screens/access_screen.dart';
// import 'screens/sign_in_screen.dart';
// import 'screens/sign_up_screen.dart';
// import 'screens/terms_of_service.dart'; 

// import 'screens/home_screen.dart';
// import 'screens/wallet_actions_screen.dart'
// import 'screens/wallet_dashboard_screen.dart';
import 'screens/profile_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SignUpScreen(),
      routes: {
        '/home': (context) => const Home(),
        '/wallet': (context) => const WalletScreen(),
      },


      // home: const Splash(), 
      // home: const Access(),
      //  home: const SignIn(),
      // home: const SignUp(),
      // home: const Terms(),
      // home:  Home(), 
      // home:  WalletScreen(), 
      // home:  WalletDashboardScreen(),
      home:  ProfileScreen(), 
      theme: ThemeData(
        textTheme: GoogleFonts.ralewayTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}