import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<AuthRequested>((event, emit) async {
      bool isValidEmail(String email) {
        final emailRegex = RegExp(
          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
        );
        return emailRegex.hasMatch(email);
      }

      // TODO: implement event handler
      emit(
        LoginLoad(),
      );
      try {
        final email = event.email;
        final password = event.password;
        const uuid = Uuid();
        final uid = uuid.v4();
        // String generateUid() {
        //   final timestamp = DateTime.now().millisecondsSinceEpoch;
        //   final randomString =
        //       List.generate(6, (index) => Random().nextInt(4)).join();
        //   return '$timestamp$randomString';
        // }
        String generate6DigitUid() {
          // Get the current timestamp in milliseconds since epoch.
          int timestamp = DateTime.now().millisecondsSinceEpoch;

          // Generate a random number between 0 and 9999.
          int randomNum = Random().nextInt(10000);

          // Combine the timestamp and random number to create a unique base.
          int combined = timestamp + randomNum;

          // Convert the combined number to a string.
          String combinedString = combined.toString();

          // Ensure the UID is 6 digits long by taking the last 6 digits of the combined string.
          String uid = combinedString.substring(combinedString.length - 6);

          return uid;
        }

        final referral = generate6DigitUid();
        if (password.isEmpty || email.isEmpty) {
          return emit(
            LoginFailure(
              msg: 'your email or password cant be empty, please try again',
            ),
          );
        }
        if (password.length < 6) {
          return emit(
            LoginFailure(
              msg: 'Password cannot be less than 6',
            ),
          );
        }
        if (!isValidEmail(email)) {
          return emit(
            LoginFailure(
              msg: 'Please enter a valid email',
            ),
          );
        }
        await Future.delayed(
          const Duration(
            seconds: 2,
          ),
          () {
            return emit(
              LoginSuccess(
                referral: referral,
                uid: uid,
                email: email.split('@').first,
              ),
            );
          },
        );
      } catch (e) {
        return emit(
          LoginFailure(
            msg: e.toString(),
          ),
        );
      }
    });

    on<AuthLogOut>(
      (event, emit) async {
        emit(
          LoginLoad(),
        );
        try {
          await Future.delayed(
            const Duration(
              seconds: 2,
            ),
            () {
              return emit(
                LoginInitial(),
              );
            },
          );
        } catch (e) {
          return emit(
            LoginFailure(
              msg: e.toString(),
            ),
          );
        }
      },
    );
  }
}
