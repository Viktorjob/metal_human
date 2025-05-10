import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:metal_human/list_muscle_categories/repository.dart';
import 'package:metal_human/list_muscle_categories/task_bloc.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';
import 'screens/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Импортируем Bloc
import 'blocs/login/login_bloc.dart'; // Импортируем LoginBloc

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
    final taskRepository = TaskRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (_) => LoginBloc(),
        ),
        BlocProvider<TaskBloc>(
          create: (_) => TaskBloc(taskRepository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => const LoginScreen(),
          '/home': (_) => const HomeScreen(),
        },
      ),
    );
  }
}
