import 'package:get_it/get_it.dart';
import 'package:test1/core/notification/firebase_notification_service.dart';
import 'package:test1/features/patient/data/datasource/patient_datasource.dart';
import 'package:test1/features/patient/data/repository_impl/patient_repository_impl.dart';
import 'package:test1/features/patient/domain/repository/patient_repository.dart';
import 'package:test1/features/patient/domain/usecases/search_patient_usecase.dart';
import 'package:test1/features/patient/presentation/bloc/patient_bloc.dart';

import '../notification/local_notification_service.dart';

final sl = GetIt.instance;

void init()
{
  sl.registerLazySingleton(
      ()=> PatientDataSource(),
  );

  sl.registerLazySingleton<PatientRepository>(
      ()=> PatientRepositoryImpl(sl<PatientDataSource>()),
  );

  sl.registerLazySingleton(
      ()=> SearchPatientUseCase(sl<PatientRepository>())
  );
  
  sl.registerFactory(
      ()=> PatientBloc(sl<SearchPatientUseCase>())
  );

  sl.registerLazySingleton(
      ()=> FirebaseNotificationService(),
  );

  sl.registerLazySingleton(
        () => LocalNotificationService(),
  );
}