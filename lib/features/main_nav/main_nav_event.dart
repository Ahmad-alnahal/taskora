import 'package:equatable/equatable.dart';

abstract class MainNavEvent extends Equatable {
  const MainNavEvent();

  @override
  List<Object?> get props => [];
}

class MainNavTabChanged extends MainNavEvent {
  const MainNavTabChanged(this.index);
  final int index;

  @override
  List<Object?> get props => [index];
}
