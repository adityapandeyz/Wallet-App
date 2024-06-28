import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persist_wallet_app/provider/google_signin_provider.dart';
import 'package:persist_wallet_app/provider/user_provider.dart';
import 'package:persist_wallet_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'provider/wallet_provider.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // Run the app
  runApp(const MyApp());

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      statusBarColor: Colors.black,
    ),
  );
}

/// The main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set preferred orientations
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MultiProvider(
      providers: [
        // Provider for Google Sign-In
        ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
        ),

        // Provider for User
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),

        // Provider for Wallet
        ChangeNotifierProvider(
          create: (_) => WalletProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
          primaryColor: Colors.grey,
          scaffoldBackgroundColor: Colors.black,
          textTheme: TextTheme(
            // Body Small
            bodySmall: GoogleFonts.jost(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),

            // Body Medium
            bodyMedium: GoogleFonts.jost(
              fontSize: 13,
            ),

            // Body Large
            bodyLarge: GoogleFonts.jost(
              fontSize: 14,
            ),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.black,
            titleTextStyle: GoogleFonts.jost(
              fontSize: 18,
            ),
            centerTitle: true,
          ),
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder()
            },
          ),
        ),
        home: const LoginScreen(),
      ),
    );
  }
}

/// The next screen widget.
class NextScreen extends StatelessWidget {
  const NextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show loading indicator while waiting for authentication state
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            // User is authenticated, show home screen
            return const HomeScreen();
          } else if (snapshot.hasError) {
            // Error occurred, show error message
            return const Center(
              child: Text('Something went wrong!'),
            );
          } else {
            // User is not authenticated, show login screen
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
