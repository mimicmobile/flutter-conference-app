abstract class IHomeView {
  void refreshState(bool shouldShow);

  void onTabTapped(int index);

  void showNetworkError() {}
}

abstract class IScheduleView {}

abstract class ISpeakersView {}

abstract class IAboutView {}
