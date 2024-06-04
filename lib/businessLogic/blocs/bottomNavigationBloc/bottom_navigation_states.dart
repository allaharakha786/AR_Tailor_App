class BottomNavigationStates {
  int currentIndex;
  BottomNavigationStates({
    this.currentIndex = 0,
  });

  BottomNavigationStates copyWith({int? currentIndex}) {
    return BottomNavigationStates(
        currentIndex: currentIndex ?? this.currentIndex);
  }

  List<Object>? get props => [currentIndex];
}
