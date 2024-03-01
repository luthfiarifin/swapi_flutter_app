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
import '../../features/cinema/presentation/cubit/cinema_cubit.dart' as _i15;
import '../../features/detail/data/datasource/datasource.dart' as _i6;
import '../../features/detail/data/datasource/detail_remote_datasource.dart'
    as _i4;
import '../../features/detail/domain/repository/detail_repository.dart' as _i5;
import '../../features/detail/domain/repository/repository.dart' as _i9;
import '../../features/detail/domain/usecase/get_film_use_case.dart' as _i8;
import '../../features/detail/domain/usecase/get_people_use_case.dart' as _i10;
import '../../features/detail/domain/usecase/usecase.dart' as _i17;
import '../../features/detail/presentation/cubit/detail_cubit.dart' as _i16;
import '../../features/home/data/datasource/datasource.dart' as _i14;
import '../../features/home/data/datasource/home_remote_datasource.dart'
    as _i11;
import '../../features/home/domain/repository/home_repository.dart' as _i13;
import '../../features/home/domain/repository/repository.dart' as _i19;
import '../../features/home/domain/usecase/get_films_use_case.dart' as _i18;
import '../../features/home/domain/usecase/usecase.dart' as _i21;
import '../../features/home/presentation/cubit/home_cubit.dart' as _i20;
import 'core.injection.dart' as _i22;

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
    gh.factory<_i15.CinemaCubit>(
        () => _i15.CinemaCubit(gh<_i7.DirectionsService>()));
    gh.factory<_i16.DetailCubit>(() => _i16.DetailCubit(
          gh<_i17.GetFilmUseCase>(),
          gh<_i17.GetPeopleUseCase>(),
        ));
    gh.lazySingleton<_i18.GetFilmsUseCase>(
        () => _i18.GetFilmsUseCase(gh<_i19.HomeRepository>()));
    gh.factory<_i20.HomeCubit>(
        () => _i20.HomeCubit(gh<_i21.GetFilmsUseCase>()));
    return this;
  }
}

class _$CoreInjectionModule extends _i22.CoreInjectionModule {}
