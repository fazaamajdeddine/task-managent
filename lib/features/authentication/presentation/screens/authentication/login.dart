import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tasks_app/features/authentication/presentation/providers/auth_providers.dart';
import 'package:tasks_app/features/authentication/presentation/widgets/fields.dart';
import 'package:tasks_app/routes/app_router.gr.dart';

@RoutePage()
class LoginScreen extends ConsumerWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(loginNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Login'),
        leading: Icon(Icons.arrow_back_ios),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 18.h),
              SizedBox(height: 77.h),
              Padding(
                padding: EdgeInsets.only(left: 25.w),
                child: Row(
                  children: [
                    Text('Email'),
                  ],
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(4),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 34.w,
                  right: 25.w,
                ),
                child: CustomTextField(
                  hintText: "email",
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.grey,
                    size: 20.sp,
                  ),
                  borderColor: Colors.black87,
                ),
              ),
              SizedBox(height: 18.h),
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Row(
                  children: [
                    Text(
                      "Password",
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(4),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 34.w,
                  right: 25.w,
                ),
                child: CustomPasswordField(
                  hintText: 'Password',
                  controller: passwordController,
                  suffixIcon: const Icon(
                    Icons.remove_red_eye_sharp,
                    color: Colors.grey,
                  ),
                  borderColor: Colors.black87,
                ),
              ),
              SizedBox(height: 26.h),
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                  height: 40.h,
                  width: 157.w,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      ref.read(loginNotifierProvider.notifier).login(
                            emailController.text,
                            passwordController.text,
                          );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(
                      color: Colors.blue,
                      width: 1.w,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: ref.watch(loginNotifierProvider).when(
                        initial: () => Text(
                          "Login",
                        ),
                        loading: () => LoadingAnimationWidget.twistingDots(
                          leftDotColor: Colors.black,
                          rightDotColor: Colors.grey,
                          size: 20.sp,
                        ),
                        authenticated: (_) {
                          // Navigate to home route when authenticated
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            AutoRouter.of(context).replace(const TasksRoute());
                          });
                          return const SizedBox();
                        },
                        failure: (_) => Text(
                          "Login",
                        ),
                        success: () => const SizedBox(),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
