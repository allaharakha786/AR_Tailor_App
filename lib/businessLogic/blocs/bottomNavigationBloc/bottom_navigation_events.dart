class BottomNavigationEvents {}

class CurrentIndexEvent extends BottomNavigationEvents {
  int index;
  CurrentIndexEvent({required this.index});
}
