import 'package:bloc/bloc.dart';
import 'package:mobile_banking_apps/features/transfer/domain/entities/beneficiary_entitiy.dart';
import 'package:mobile_banking_apps/features/transfer/domain/usecases/check_beneficiary_usecase.dart';

part 'beneficiary_state.dart';

class BeneficiaryCubit extends Cubit<BeneficiaryState> {
  final CheckBeneficiaryUsecase checkBeneficiaryUsecase;

  BeneficiaryCubit(this.checkBeneficiaryUsecase) : super(BeneficiaryState());

  Future<void> checkBeneficiary({
    required String internalAccountNumber,
    double amount = 0,
  }) async {
    emit(state.copyWith(status: BeneficiaryStatus.loading));

    try {
      final result = await checkBeneficiaryUsecase.call(
        internalAccountNumber,
        amount,
      );

      result.fold(
        (failure) => emit(
          state.copyWith(
            status: BeneficiaryStatus.error,
            message: failure,
          ),
        ),
        (result) {
          emit(
            state.copyWith(
              status: BeneficiaryStatus.success,
              message: result.message,
              data: result,
            ),
          );
        },
      );
    } catch (e) {
      emit(state.copyWith(
        status: BeneficiaryStatus.error,
        message: e.toString(),
      ));
    }
  }
}
