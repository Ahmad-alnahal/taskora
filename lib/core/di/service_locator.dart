import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskora/core/services/remote/dio_client.dart';
import 'package:taskora/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:taskora/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:taskora/features/splash/presentation/bloc/splash_bloc.dart';
import '../services/local/shared_pref_service.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/signup_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/domain/usecases/forgot_password_usecase.dart';
import '../../features/auth/domain/usecases/verify_reset_code_usecase.dart';
import '../../features/auth/domain/usecases/reset_password_usecase.dart';
import '../../features/auth/domain/usecases/get_saved_token_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // External
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);

  // Services
  sl.registerLazySingleton<SharedPrefService>(() => SharedPrefService(sl()));

  // DataSources
  sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSource(sl()));
  sl.registerLazySingleton<DioClient>(() => DioClient(sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSource(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(remote: sl(), local: sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignupUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));
  sl.registerLazySingleton(() => VerifyResetCodeUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => GetSavedTokenUseCase(sl()));

  // Blocs
  sl.registerFactory(
    () => AuthBloc(
      login: sl(),
      signup: sl(),
      logout: sl(),
      forgotPassword: sl(),
      verifyResetCode: sl(),
      resetPassword: sl(),
      getSavedTokenUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => SplashBloc(
      sharedPrefService: sl(),
      getSavedToken: sl(),
    ),
  );
}
