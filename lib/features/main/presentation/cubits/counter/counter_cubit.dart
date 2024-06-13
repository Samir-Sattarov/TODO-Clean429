import 'package:bloc/bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  int counter = 0;

  void plus() {
    counter++;
    print(counter);
    emit(counter);
  }

  void minus() {
    counter--;
    print(counter);
    emit(counter);
  }
}
