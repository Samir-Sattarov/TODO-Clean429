import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/auth_usecases.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInUsecase signInUsecase;
  SignInCubit(this.signInUsecase) : super(SignInInitial());

  signIn(String email, String password) async {
    emit(SignInLoading());

    final response = await signInUsecase.call(
      AuthUsecaseParams(email, password),
    );

    response.fold(
      (l) => emit(SignInError(l.errorMessage)),
      (r) => emit(
        SignInSuccess(),
      ),
    );
  }
}
