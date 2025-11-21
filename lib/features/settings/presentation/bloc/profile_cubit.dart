import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_banking_apps/features/settings/domain/usecases/get_profile_usecase.dart';
import 'package:mobile_banking_apps/features/settings/presentation/bloc/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfileUseCase;

  ProfileCubit(this.getProfileUseCase) : super(const ProfileState());

  Future<void> loadProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading));

    final result = await getProfileUseCase();

    result.fold(
      (error) => emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: error,
        ),
      ),
      (profile) => emit(
        state.copyWith(
          status: ProfileStatus.success,
          profile: profile,
        ),
      ),
    );
  }
}
