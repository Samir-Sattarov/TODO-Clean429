import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/auth_usecases.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUsecase signUpUsecase;
  SignUpCubit(this.signUpUsecase) : super(SignUpInitial());

  signUp(String email, String password) async {
    emit(SignUpLoading());

    final response = await signUpUsecase.call(
      AuthUsecaseParams(email, password),
    );

    response.fold(
      (l) => emit(SignUpError(l.errorMessage)),
      (r) => emit(SignUpSuccess()),
    );
  }
}
