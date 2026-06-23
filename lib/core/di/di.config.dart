// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../data/datasource/contrarct/local_datasource.dart' as _i756;
import '../../data/datasource/contrarct/remote_datasource.dart' as _i127;
import '../../data/datasource/impl/local_datasource_impl.dart' as _i23;
import '../../data/datasource/impl/remote_datasource_impl.dart' as _i989;
import '../../data/network/api_client.dart' as _i927;
import '../../data/repo_impl/repo_impl.dart' as _i212;
import '../../domain/repository/repo.dart' as _i441;
import '../../presentation/display_ayat/cubit/display_ayat_cubit.dart' as _i28;
import '../../presentation/home/cubit/home_cubit.dart' as _i288;
import '../../presentation/onboarding/cubit/onboarding_cubit.dart' as _i657;
import '../../presentation/tabs/bookmark_tab/cubit/bookmark_cubit.dart' as _i78;
import '../../presentation/tabs/hadeth_tab/cubit/hadeth_cubit.dart' as _i827;
import '../../presentation/tabs/quran_tab/cubit/quran_cubit.dart' as _i457;
import '../../presentation/tabs/radio_and_reciters_tab/cubit/radio_and_reciters_cubit.dart'
    as _i997;
import '../../presentation/tabs/sebha_tab/cubit/sebha_cubit.dart' as _i559;
import 'provide_dio.dart' as _i833;
import 'provide_sharedPreferences.dart' as _i1041;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final provideSharedPreferences = _$ProvideSharedPreferences();
    final dioModule = _$DioModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => provideSharedPreferences.provideShared(),
      preResolve: true,
    );
    gh.factory<_i827.HadethCubit>(() => _i827.HadethCubit());
    gh.factory<_i559.SebhaCubit>(() => _i559.SebhaCubit());
    gh.lazySingleton<_i361.Dio>(() => dioModule.provideDio());
    gh.singleton<_i927.ApiClient>(() => _i927.ApiClient(gh<_i361.Dio>()));
    gh.factory<_i78.BookmarkCubit>(
      () => _i78.BookmarkCubit(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i756.LocalDatasource>(
      () => _i23.LocalDatasourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i127.RemoteDatasource>(
      () => _i989.RemoteDatasourceImpl(gh<_i927.ApiClient>()),
    );
    gh.factory<_i441.RepositoryContract>(
      () => _i212.RepoImpl(
        gh<_i756.LocalDatasource>(),
        gh<_i127.RemoteDatasource>(),
      ),
    );
    gh.factory<_i28.DisplayContentCubit>(
      () => _i28.DisplayContentCubit(
        gh<_i441.RepositoryContract>(),
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.factory<_i657.OnboardingCubit>(
      () => _i657.OnboardingCubit(gh<_i441.RepositoryContract>()),
    );
    gh.singleton<_i288.HomeCubit>(
      () => _i288.HomeCubit(gh<_i441.RepositoryContract>()),
    );
    gh.singleton<_i997.RadioAndRecitersCubit>(
      () => _i997.RadioAndRecitersCubit(gh<_i441.RepositoryContract>()),
    );
    gh.singleton<_i457.QuranCubit>(
      () => _i457.QuranCubit(
        gh<_i460.SharedPreferences>(),
        gh<_i441.RepositoryContract>(),
      ),
    );
    return this;
  }
}

class _$ProvideSharedPreferences extends _i1041.ProvideSharedPreferences {}

class _$DioModule extends _i833.DioModule {}
