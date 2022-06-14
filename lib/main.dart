import 'package:breeds_recognition/ui/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'application/cubit/breeds_recognition_cubit.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData.light(),
        home: BlocProvider<BreedsRecognitionCubit>(
          lazy: false,
          create: (context) => BreedsRecognitionCubit(),
          child: const HomePage(),
        ),
        debugShowCheckedModeBanner: false,
      );
}
