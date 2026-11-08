import 'package:flutter/material.dart';

class AppSettings extends ChangeNotifier {
  AppSettings._();

  static final AppSettings instance = AppSettings._();

  bool cheDoToi = false;
  bool nhanThongBao = true;
  bool nhoDangNhap = true;

  String ngonNgu = 'Tiếng Việt';
  String coChu = 'Vừa';

  // Hệ số thay đổi cỡ chữ trên toàn ứng dụng.
  double kichThuocChu = 1.0;

  bool get tiengAnh => ngonNgu == 'English';

  void doiCheDoToi(bool value) {
    cheDoToi = value;
    notifyListeners();
  }

  void doiNgonNgu(String value) {
    ngonNgu = value;
    notifyListeners();
  }

  void doiCoChu(String value) {
    coChu = value;

    if (value == 'Nhỏ') {
      kichThuocChu = 0.85;
    } else if (value == 'Lớn') {
      kichThuocChu = 1.25;
    } else {
      kichThuocChu = 1.0;
    }

    notifyListeners();
  }

  void doiThongBao(bool value) {
    nhanThongBao = value;
    notifyListeners();
  }

  void doiNhoDangNhap(bool value) {
    nhoDangNhap = value;
    notifyListeners();
  }

  String dich(String tiengViet, String banDichTiengAnh) {
    return this.tiengAnh ? banDichTiengAnh : tiengViet;
  }
}

class AppSettingsScope extends InheritedNotifier<AppSettings> {
  const AppSettingsScope({
    super.key,
    required AppSettings notifier,
    required Widget child,
  }) : super(
          notifier: notifier,
          child: child,
        );

  static AppSettings of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<AppSettingsScope>();

    return scope!.notifier!;
  }
}
