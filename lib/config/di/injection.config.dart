// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_directions_api/google_directions_api.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;

import '../../core/core.dart' as _i12;
import '../../core/data/network/api_client.dart' as _i3;
import '../../features/cinema/presentation/cubit/cinema_cubit.dart' as _i20;
import '../../features/detail/data/datasource/datasource.dart' as _i6;
import '../../features/detail/data/datasource/detail_remote_datasource.dart'
    as _i4;
import '../../features/detail/domain/repository/detail_repository.dart' as _i5;
import '../../features/detail/domain/repository/repository.dart' as _i9;
import '../../features/detail/domain/usecase/get_film_use_case.dart' as _i8;
import '../../features/detail/domain/usecase/get_people_use_case.dart' as _i10;
import '../../features/detail/domain/usecase/usecase.dart' as _i22;
import '../../features/detail/presentation/cubit/detail_cubit.dart' as _i21;
import '../../features/home/data/datasource/datasource.dart' as _i14;
import '../../features/home/data/datasource/home_remote_datasource.dart'
    as _i11;
import '../../features/home/domain/repository/home_repository.dart' as _i13;
import '../../features/home/domain/repository/repository.dart' as _i24;
import '../../features/home/domain/usecase/get_films_use_case.dart' as _i23;
import '../../features/home/domain/usecase/usecase.dart' as _i27;
import '../../features/home/presentation/cubit/home_cubit.dart' as _i26;
import '../../features/reminder/data/datasource/datasource.dart' as _i17;
import '../../features/reminder/data/datasource/reminder_local_datasource.dart'
    as _i15;
import '../../features/reminder/domain/repository/reminder_repository.dart'
    as _i16;
import '../../features/reminder/domain/repository/repository.dart' as _i19;
import '../../features/reminder/domain/usecase/get_reminder_use_case.dart'
    as _i25;
import '../../features/reminder/domain/usecase/save_reminder_use_case.dart'
    as _i18;
import '../../features/reminder/domain/usecase/usecase.dart' as _i29;
import '../../features/reminder/presentation/cubit/reminder_cubit.dart' as _i28;
import 'core.injection.dart' as _i30;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final coreInjectionModule = _$CoreInjectionModule();
    gh.lazySingleton<_i3.ApiClient>(() => coreInjectionModule.apiClient);
    gh.factory<_i4.DetailRemoteDataSource>(
        () => _i4.DetailRemoteDataSourceImpl(client: gh<_i3.ApiClient>()));
    gh.factory<_i5.DetailRepository>(() => _i5.DetailRepositoryImpl(
        remoteDataSource: gh<_i6.DetailRemoteDataSource>()));
    gh.lazySingleton<_i7.DirectionsService>(
        () => coreInjectionModule.directionService);
    gh.lazySingleton<_i8.GetFilmUseCase>(
        () => _i8.GetFilmUseCase(gh<_i9.DetailRepository>()));
    gh.lazySingleton<_i10.GetPeopleUseCase>(
        () => _i10.GetPeopleUseCase(gh<_i9.DetailRepository>()));
    gh.lazySingleton<_i11.HomeRemoteDataSource>(
        () => _i11.HomeRemoteDataSourceImpl(client: gh<_i12.ApiClient>()));
    gh.lazySingleton<_i13.HomeRepository>(() => _i13.HomeRepositoryImpl(
        remoteDataSource: gh<_i14.HomeRemoteDataSource>()));
    gh.factory<_i15.ReminderLocalDataSource>(
        () => _i15.ReminderLocalDataSourceImpl());
    gh.factory<_i16.ReminderRpository>(() => _i16.ReminderRpositoryImpl(
        localDataSource: gh<_i17.ReminderLocalDataSource>()));
    gh.lazySingleton<_i18.SaveReminderUseCase>(
        () => _i18.SaveReminderUseCase(gh<_i19.ReminderRpository>()));
    gh.factory<_i20.CinemaCubit>(
        () => _i20.CinemaCubit(gh<_i7.DirectionsService>()));
    gh.factory<_i21.DetailCubit>(() => _i21.DetailCubit(
          gh<_i22.GetFilmUseCase>(),
          gh<_i22.GetPeopleUseCase>(),
        ));
    gh.lazySingleton<_i23.GetFilmsUseCase>(
        () => _i23.GetFilmsUseCase(gh<_i24.HomeRepository>()));
    gh.lazySingleton<_i25.GetReminderUseCase>(
        () => _i25.GetReminderUseCase(gh<_i19.ReminderRpository>()));
    gh.factory<_i26.HomeCubit>(
        () => _i26.HomeCubit(gh<_i27.GetFilmsUseCase>()));
    gh.factory<_i28.ReminderCubit>(() => _i28.ReminderCubit(
          gh<_i29.GetReminderUseCase>(),
          gh<_i29.SaveReminderUseCase>(),
        ));
    return this;
  }
}

class _$CoreInjectionModule extends _i30.CoreInjectionModule {}
