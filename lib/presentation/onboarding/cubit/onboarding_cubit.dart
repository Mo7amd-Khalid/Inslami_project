import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:islami_app/core/base/base_cubit.dart';
import 'package:islami_app/core/constant/keywords.dart';
import 'package:islami_app/domain/repository/repo.dart';

import 'onboarding_contract.dart';

@injectable
class OnboardingCubit extends BaseCubit<OnboardingState,OnboardingActions,OnboardingNavigation>{
  OnboardingCubit(this._repo) : super(OnboardingState());

  final RepositoryContract _repo;

  @override
  Future<void> doAction(OnboardingActions action) async {
    switch(action) {
      case ChangeCurrentIndex():
        changeCurrentIndex(action.newIndex);
      case GoToHomeScreen():
        goToHomeScreen(action.context);
    }
  }

  void changeCurrentIndex(int newIndex) {
    emit(state.copyWith(currentIndex: newIndex));
  }

  void goToHomeScreen(BuildContext context) {
    _repo.saveDataInSharedPreferences(context, AppKeywords.onboardingKeyword, true);
    emitNavigation(NavigateToHomeScreen());
  }



}