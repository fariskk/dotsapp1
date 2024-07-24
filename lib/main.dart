import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formapplication/features/homeScreen/bloc/form_bloc_bloc.dart';
import 'package:formapplication/features/homeScreen/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FormBlocBloc(),
      child: MaterialApp(
        theme: ThemeData(primaryColor: const Color.fromARGB(255, 179, 33, 23)),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
