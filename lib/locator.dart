import 'package:clean_arch_example/core/utils/todo_storage_service.dart';
import 'package:clean_arch_example/features/main/data/datasources/main_local_data_source.dart';
import 'package:get_it/get_it.dart';

import 'features/main/data/repositories/main_repository_impl.dart';
import 'features/main/domain/repositories/main_repository.dart';

final locator = GetIt.I;

void setup() {
  // ================ BLoC / Cubit ================ //

  // ================ UseCases ================ //

  // ================ Repository / Datasource ================ //

  locator.registerLazySingleton<MainRepository>(
    () => MainRepositoryImpl(
      locator(),
    ),
  );

  locator.registerLazySingleton<MainLocalDataSource>(
    () => MainLocalDataSourceImpl(
      locator(),
    ),
  );

  // ================ Core ================ //

  locator.registerLazySingleton(
    () => TodoStorageService(),
  );
  // ================ External ================ //
}
