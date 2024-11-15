// ignore_for_file: constant_identifier_names

enum AppEnvironment { DEV, STAGING, PROD }

abstract class EnvInfo {
  static AppEnvironment _environment = AppEnvironment.DEV;

  static void initialize(AppEnvironment environment) {
    EnvInfo._environment = environment;
  }

  static String get appName => _environment._appTitle;
  static String get envName => _environment._envName;
  static String get connectionString => _environment._connectionString;
  static AppEnvironment get environment => _environment;
  static bool get isProduction => _environment == AppEnvironment.PROD;
}

extension _EnvProperties on AppEnvironment {
  static const _appTitles = {
    AppEnvironment.DEV: 'task management Dev',
  };

  static const _connectionStrings = {
    AppEnvironment.DEV: 'https:',
   
  };

  static const _envs = {
    AppEnvironment.DEV: 'dev',
  
  };

  String get _appTitle => _appTitles[this]!;
  String get _envName => _envs[this]!;
  String get _connectionString => _connectionStrings[this]!;
}