import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_wave/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/home/view_model/home_cubit.dart';

import 'features/init/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    BlocProvider(
      create: (context) => HomeCubit(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); 

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}