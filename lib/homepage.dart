import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_responsive_login_ui/bloc/login_bloc.dart';
import 'package:flutter_responsive_login_ui/login_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                context.read<LoginBloc>().add(AuthLogOut());
              },
              child: const Icon(
                Icons.logout,
              ),
            ),
          ),
          BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginInitial) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (route) => false,
                );
              }

              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is LoginLoad) {
                return const SpinKitThreeBounce(
                  size: 20,
                  color: Colors.white,
                );
              }
              // final authstate =
              //     context.watch<LoginBloc>().state as LoginSuccess;
              return Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'GOOD MORNING ${(state as LoginSuccess).email}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'UID: ${(state).uid}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'referralCode : ${(state).referral}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
