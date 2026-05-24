import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:test1/core/notification/firebase_notification_service.dart';
import 'package:test1/features/patient/data/datasource/patient_datasource.dart';
import 'package:test1/features/patient/data/repository_impl/patient_repository_impl.dart';
import 'package:test1/features/patient/domain/repository/patient_repository.dart';
import 'package:test1/features/patient/domain/usecases/search_patient_usecase.dart';
import 'package:test1/features/patient/presentation/bloc/patient_bloc.dart';

import '../../features/auth/data/datasource/auth_remote_datasource.dart';
import '../../features/auth/data/datasource/auth_remote_datasource_impl.dart';
import '../../features/auth/data/repository/auth_repository_impl.dart';
import '../../features/auth/domain/repository/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/refresh_token_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../auth/session_manager.dart';
import '../auth/token_storage.dart';
import '../notification/local_notification_service.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton(() => PatientDataSource());

  sl.registerLazySingleton<PatientRepository>(
    () => PatientRepositoryImpl(sl<PatientDataSource>()),
  );

  sl.registerLazySingleton(() => SearchPatientUseCase(sl<PatientRepository>()));

  sl.registerFactory(() => PatientBloc(sl<SearchPatientUseCase>()));

  sl.registerLazySingleton(() => FirebaseNotificationService());

  sl.registerLazySingleton(() => LocalNotificationService());

  sl.registerLazySingleton(() => Client());

  sl.registerLazySingleton(() => TokenStorage());

  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(sl()),
  );

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  sl.registerLazySingleton(() => LoginUseCase(sl()));

  sl.registerLazySingleton(() => RefreshTokenUseCase(sl()));

  sl.registerLazySingleton(() => SessionManager(sl(), sl()));

  sl.registerFactory(() => AuthBloc(sl(), sl(), sl()));
}
