import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:resturant_app_test/modules/login/cubit/cubit.dart';
import 'package:resturant_app_test/modules/login/cubit/states.dart';
import 'package:resturant_app_test/modules/resturants_list/resturants_list_screen.dart';
import 'package:resturant_app_test/shared/components/components.dart';
import 'package:resturant_app_test/shared/network/local/cache_helper.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            print(state.loginToken);
            CacheHelper.saveData(
              key: 'token',
              value: state.loginToken,
            ).then((value) {
              navigateAndFinish(
                context,
                RestruantsListScreen(),
              );
            });
          }
        },
        builder: (context, state) {
          LoginCubit loginCubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline4.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'please enter your Phone';
                          }
                        },
                        label: 'Phone',
                        prefix: Icons.phone,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Conditional.single(
                        context: context,
                        conditionBuilder: (BuildContext context) =>
                            state is! LoginLoadingState,
                        widgetBuilder: (BuildContext context) => defaultButton(
                          function: () {
                            if (formKey.currentState.validate()) {
                              loginCubit.userLogin(
                                phone: phoneController.text,
                              );
                            }
                          },
                          text: 'login',
                          isUpperCase: true,
                        ),
                        fallbackBuilder: (BuildContext context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
