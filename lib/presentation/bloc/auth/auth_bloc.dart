import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:railway/domain/entities/firebase_user.dart';
import 'package:railway/domain/usecases/sign_in_usecase.dart';
import 'package:railway/domain/usecases/sign_out_usecase.dart';
import 'package:railway/domain/usecases/sign_up_usecase.dart';
import 'package:railway/storage/hive_storage.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase signInUseCase;
  final SignOutUseCase signOutUseCase;
  final SignUpUseCase signUpUseCase; // Add SignUpUseCase

  AuthBloc({required this.signInUseCase, required this.signOutUseCase, required this.signUpUseCase,})
      : super(AuthInitial()) {
    on<SignInEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await signInUseCase(event.email, event.password);

        // Save token/UID after successful login
        await HiveStorage().saveToken(user.uid);

        emit(AuthSuccess(user));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    // 🔹 SignUp Event (Newly Added)
    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await signUpUseCase(event.email, event.password);

        // Save token/UID after successful signup
        await HiveStorage().saveToken(user.uid);

        emit(AuthSuccess(user));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<SignOutEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await signOutUseCase();
        await HiveStorage().clearToken(); // Remove token

        emit(AuthLoggedOut());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}