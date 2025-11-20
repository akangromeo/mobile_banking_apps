import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_banking_apps/features/transfer/domain/entities/transfer_entitiy.dart';
import 'package:mobile_banking_apps/features/transfer/domain/usecases/post_transfer_usecase.dart';

part 'transfer_state.dart';

class TransferCubit extends Cubit<TransferState> {
  final PostTransferUsecase transferUsecase;

  TransferCubit(this.transferUsecase) : super(const TransferState());

  Future<void> transfer(TransferEntitiy payload) async {
    emit(state.copyWith(status: TransferStatus.loading));

    final result = await transferUsecase(payload);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: TransferStatus.failure,
          errorMessage: failure,
        ),
      ),
      (result) {
        emit(
          state.copyWith(
            status: TransferStatus.success,
            succesMessage: result,
          ),
        );
      },
    );
  }
}
