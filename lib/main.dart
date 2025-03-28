import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:railway/data/repositories/auth_repository_impl.dart';
import 'package:railway/domain/usecases/sign_up_usecase.dart';
import 'package:railway/presentation/bloc/auth/auth_bloc.dart';
import 'package:railway/presentation/ui/auth/register_screen.dart';
import 'package:railway/presentation/ui/home/booking_screen.dart';
import 'package:railway/storage/hive_storage.dart';
import 'domain/usecases/sign_in_usecase.dart';
import 'domain/usecases/sign_out_usecase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await Hive.initFlutter();

  // 🔹 Ensure Hive is open before using it
  await HiveStorage.init();

  // 🔹 Checking if user is already logged in
  String? token = await HiveStorage().getToken();

  runApp(MyApp(isUserLoggedIn: token != null));
}

class MyApp extends StatelessWidget {
  final bool isUserLoggedIn;
  const MyApp({Key? key, required this.isUserLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) => AuthBloc(
                signInUseCase: SignInUseCase(AuthRepositoryImpl()),
                signOutUseCase: SignOutUseCase(AuthRepositoryImpl()),
                signUpUseCase: SignUpUseCase(AuthRepositoryImpl()),
              ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: isUserLoggedIn ? BookingScreen() : RegisterPage(),
      ),
    );
  }
}
