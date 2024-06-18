import 'package:clean_arch_example/core/utils/todo_storage_service.dart';
import 'package:clean_arch_example/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:clean_arch_example/features/auth/data/repository/auth_repository_impl.dart';
import 'package:clean_arch_example/features/auth/domain/repository/auth_repository.dart';
import 'package:clean_arch_example/features/main/data/datasources/main_local_data_source.dart';
import 'package:clean_arch_example/features/main/data/datasources/main_remote_data_source.dart';
import 'package:clean_arch_example/features/main/presentation/cubits/counter/counter_cubit.dart';
import 'package:get_it/get_it.dart';

import 'core/api/api_firebase_client.dart';
import 'features/auth/domain/usecases/auth_usecases.dart';
import 'features/auth/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'features/auth/presentation/cubits/sign_up/sign_up_cubit.dart';
import 'features/main/data/repositories/main_repository_impl.dart';
import 'features/main/domain/repositories/main_repository.dart';
import 'features/main/domain/usecases/todo_usecases.dart';
import 'features/main/presentation/cubits/completed_todo/completed_todo_cubit.dart';
import 'features/main/presentation/cubits/delete_todo/delete_todo_cubit.dart';
import 'features/main/presentation/cubits/save_todo/save_todo_cubit.dart';
import 'features/main/presentation/cubits/todo/todo_cubit.dart';

final locator = GetIt.I;

void setup() {
  // ================ BLoC / Cubit ================ //


  // ================ Auth ================ //

  locator.registerFactory(() => SignInCubit(locator()));
  locator.registerFactory(() => SignUpCubit(locator()));

  locator.registerFactory(() => CounterCubit());
  locator.registerFactory(() => TodoCubit(locator()));
  locator.registerFactory(() => SaveTodoCubit(locator()));
  locator.registerFactory(() => DeleteTodoCubit(locator()));
  locator.registerFactory(() => CompletedTodoCubit(
        locator(),
        locator(),
      ));

  // ================ UseCases ================ //

  locator.registerLazySingleton(() => GetListTodoUsecase(locator()));
  locator.registerLazySingleton(() => SaveTodoUsecase(locator()));
  locator.registerLazySingleton(() => DeleteTodoUsecase(locator()));
  locator.registerLazySingleton(() => DeleteListTodoUsecase(locator()));

  // ================ Auth ================ //

  locator.registerLazySingleton(() => SignInUsecase(locator()));
  locator.registerLazySingleton(() => SignUpUsecase(locator()));

  // ================ Repository / Datasource ================ //

  locator.registerLazySingleton<MainRepository>(
    () => MainRepositoryImpl(
      locator(),
      locator(),
    ),
  );

  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      locator(),
    ),
  );

  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      locator(),
    ),
  );

  locator.registerLazySingleton<MainLocalDataSource>(
    () => MainLocalDataSourceImpl(
      locator(),
    ),
  );

  locator.registerLazySingleton<MainRemoteDataSource>(
    () => MainRemoteDataSourceImpl(
      locator(),
    ),
  );

  // ================ Core ================ //

  locator.registerLazySingleton(
    () => TodoStorageService(),
  );

  locator.registerLazySingleton(
    () => ApiFirebaseClient(),
  );
  // ================ External ================ //
}
