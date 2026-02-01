import 'package:flutter_bloc/flutter_bloc.dart';
import 'main_nav_event.dart';
import 'main_nav_state.dart';

class MainNavBloc extends Bloc<MainNavEvent, MainNavState> {
  MainNavBloc() : super(const MainNavState()) {
    on<MainNavTabChanged>((event, emit) {
      emit(state.copyWith(currentIndex: event.index));
    });
  }
}
