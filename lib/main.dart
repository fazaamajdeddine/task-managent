import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_app/main/app.dart';
import 'package:tasks_app/main/app_env.dart';
import 'package:tasks_app/main/observer.dart';

void main() => mainCommon(AppEnvironment.DEV);

Future<void> mainCommon(AppEnvironment environment) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  EnvInfo.initialize(environment);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(ProviderScope(
    observers: [
      Observers(),
    ],
    child: MyApp(),
  ));
}
