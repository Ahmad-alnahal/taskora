import 'package:equatable/equatable.dart';

class MainNavState extends Equatable {
  const MainNavState({this.currentIndex = 0});
  final int currentIndex;

  MainNavState copyWith({int? currentIndex}) {
    return MainNavState(currentIndex: currentIndex ?? this.currentIndex);
  }

  @override
  List<Object?> get props => [currentIndex];
}
