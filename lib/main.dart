import 'package:app_chatting_habiskerja/firebase_options.dart';
import 'package:app_chatting_habiskerja/screens/auth_screen.dart';
import 'package:app_chatting_habiskerja/screens/chat_screen.dart';
import 'package:app_chatting_habiskerja/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.brown,
            scaffoldBackgroundColor: Colors.grey,
            buttonTheme: ButtonTheme.of(context).copyWith(
                buttonColor: Colors.brown,
                textTheme: ButtonTextTheme.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),
            useMaterial3: true,
          ),
          home: snapshot.connectionState != ConnectionState.done ? const SplashScreen(): StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(), builder: (ctx, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const SplashScreen();
                }
                if (userSnapshot.hasData) {
                  return const ChatScreen();
                }
                return const AuthScreen();
          }),
        );
      },
    );
  }
}

