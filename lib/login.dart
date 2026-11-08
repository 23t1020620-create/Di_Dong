import 'package:flutter/material.dart';
import 'package:shopeasy/profile.dart';
import 'package:shopeasy/Danhsach.dart';
import 'package:shopeasy/app_setting.dart';

// ======================= ĐĂNG NHẬP =======================

class DangNhap extends StatelessWidget {
  const DangNhap({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          settings.dich('Đăng nhập', 'Login'),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            margin: const EdgeInsets.all(20),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.person,
                    size: 70,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    settings.dich('Xin chào!', 'Hello!'),
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: settings.dich('Email', 'Email'),
                      prefixIcon: const Icon(Icons.email),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: settings.dich(
                        'Mật khẩu',
                        'Password',
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const QuenMatKhau(),
                          ),
                        );
                      },
                      child: Text(
                        settings.dich(
                          'Quên mật khẩu?',
                          'Forgot password?',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Danhsach(),
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              settings.dich(
                                'Đăng nhập thành công!',
                                'Login successful!',
                              ),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        settings.dich('Đăng nhập', 'Login'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        settings.dich(
                          'Chưa có tài khoản?',
                          'No account yet?',
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DangKy(),
                            ),
                          );
                        },
                        child: Text(
                          settings.dich('Đăng ký', 'Register'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ======================= ĐĂNG KÝ =======================

class DangKy extends StatelessWidget {
  const DangKy({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          settings.dich('Đăng ký', 'Register'),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            margin: const EdgeInsets.all(20),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.person_add,
                    size: 70,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    settings.dich(
                      'Tạo tài khoản',
                      'Create account',
                    ),
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: settings.dich(
                        'Họ và tên',
                        'Full name',
                      ),
                      prefixIcon: const Icon(Icons.person),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: settings.dich(
                        'Mật khẩu',
                        'Password',
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: settings.dich(
                        'Xác nhận mật khẩu',
                        'Confirm password',
                      ),
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DangNhap(),
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              settings.dich(
                                'Đăng ký thành công!',
                                'Registration successful!',
                              ),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        settings.dich(
                          'Tạo tài khoản',
                          'Create account',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        settings.dich(
                          'Đã có tài khoản?',
                          'Already have an account?',
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          settings.dich(
                            'Đăng nhập',
                            'Login',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ======================= QUÊN MẬT KHẨU =======================

class QuenMatKhau extends StatelessWidget {
  const QuenMatKhau({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          settings.dich(
            'Quên mật khẩu',
            'Forgot password',
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            margin: const EdgeInsets.all(20),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.lock_reset,
                    size: 70,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    settings.dich(
                      'Quên mật khẩu?',
                      'Forgot password?',
                    ),
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    settings.dich(
                      'Vui lòng nhập email của bạn',
                      'Please enter your email',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              settings.dich(
                                'Bạn đã gửi yêu cầu',
                                'Your request has been sent',
                              ),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        settings.dich(
                          'Gửi yêu cầu',
                          'Send request',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      settings.dich(
                        'Quay lại đăng nhập',
                        'Back to login',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ======================= CÀI ĐẶT =======================

class CaiDat extends StatelessWidget {
  const CaiDat({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          settings.dich('Cài đặt', 'Settings'),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // TÀI KHOẢN

          Text(
            settings.dich('TÀI KHOẢN', 'ACCOUNT'),
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),

          SwitchListTile(
            secondary: Icon(
              settings.nhanThongBao
                  ? Icons.notifications
                  : Icons.notifications_off,
            ),
            title: Text(
              settings.dich(
                'Nhận thông báo',
                'Notifications',
              ),
            ),
            value: settings.nhanThongBao,
            onChanged: settings.doiThongBao,
          ),

          const Divider(),

          SwitchListTile(
            secondary: const Icon(
              Icons.dark_mode,
              color: Colors.indigo,
            ),
            title: Text(
              settings.dich(
                'Chế độ tối',
                'Dark mode',
              ),
            ),
            value: settings.cheDoToi,
            onChanged: settings.doiCheDoToi,
          ),

          const Divider(),

          SwitchListTile(
            secondary: const Icon(
              Icons.login,
              color: Colors.green,
            ),
            title: Text(
              settings.dich(
                'Nhớ đăng nhập',
                'Remember login',
              ),
            ),
            value: settings.nhoDangNhap,
            onChanged: settings.doiNhoDangNhap,
          ),

          const SizedBox(height: 20),

          // ỨNG DỤNG

          Text(
            settings.dich('ỨNG DỤNG', 'APPLICATION'),
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),

          ListTile(
            leading: const Icon(
              Icons.account_circle,
              color: Colors.blue,
              size: 28,
            ),
            title: Text(
              settings.dich('Cá nhân', 'Profile'),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyProfile(),
                ),
              );
            },
          ),

          const Divider(),

          // NGÔN NGỮ

          ListTile(
            leading: const Icon(
              Icons.language,
              color: Colors.blue,
            ),
            title: Text(
              settings.dich('Ngôn ngữ', 'Language'),
            ),
            subtitle: Text(settings.ngonNgu),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text(
                            settings.dich(
                              'Chọn ngôn ngữ',
                              'Choose language',
                            ),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.language),
                          title: const Text('Tiếng Việt'),
                          trailing: settings.ngonNgu == 'Tiếng Việt'
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.blue,
                                )
                              : null,
                          onTap: () {
                            settings.doiNgonNgu('Tiếng Việt');
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.language),
                          title: const Text('English'),
                          trailing: settings.ngonNgu == 'English'
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.blue,
                                )
                              : null,
                          onTap: () {
                            settings.doiNgonNgu('English');
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),

          const Divider(),

          // CỠ CHỮ

          ListTile(
            leading: const Icon(
              Icons.format_size,
              color: Colors.orange,
            ),
            title: Text(
              settings.dich('Cỡ chữ', 'Font size'),
            ),
            subtitle: Text(
              settings.dich(
                settings.coChu,
                settings.coChu == 'Nhỏ'
                    ? 'Small'
                    : settings.coChu == 'Lớn'
                        ? 'Large'
                        : 'Medium',
              ),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text(
                            settings.dich(
                              'Chọn cỡ chữ',
                              'Choose font size',
                            ),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            settings.dich('Nhỏ', 'Small'),
                          ),
                          trailing: settings.coChu == 'Nhỏ'
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.blue,
                                )
                              : null,
                          onTap: () {
                            settings.doiCoChu('Nhỏ');
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: Text(
                            settings.dich('Vừa', 'Medium'),
                          ),
                          trailing: settings.coChu == 'Vừa'
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.blue,
                                )
                              : null,
                          onTap: () {
                            settings.doiCoChu('Vừa');
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: Text(
                            settings.dich('Lớn', 'Large'),
                          ),
                          trailing: settings.coChu == 'Lớn'
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.blue,
                                )
                              : null,
                          onTap: () {
                            settings.doiCoChu('Lớn');
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),

          const Divider(),

          // THÔNG TIN ỨNG DỤNG

          ListTile(
            leading: const Icon(
              Icons.info_outline,
              color: Colors.teal,
            ),
            title: Text(
              settings.dich(
                'Về ứng dụng',
                'About application',
              ),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.info_outline,
                            size: 45,
                            color: Colors.blue,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            settings.dich(
                              'Ứng dụng ShopEasy',
                              'ShopEasy Application',
                            ),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            settings.dich(
                              'Ứng dụng bán hàng ShopEasy',
                              'ShopEasy shopping application',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 15),
                          Text(
                            'Version 1.0.0',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),

          const Divider(),

          // ĐĂNG XUẤT

          // ĐĂNG XUẤT

          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: Text(
              settings.dich('Đăng xuất', 'Logout'),
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (dialogContext) {
                  return AlertDialog(
                    title: Text(
                      settings.dich('Đăng xuất', 'Log out'),
                    ),
                    content: Text(
                      settings.dich(
                        'Bạn có chắc chắn muốn đăng xuất không?',
                        'Are you sure you want to log out?',
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                        },
                        child: Text(
                          settings.dich('Hủy', 'Cancel'),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Đóng hộp thoại
                          Navigator.pop(dialogContext);

                          // Về màn hình đăng nhập, xóa toàn bộ lịch sử màn hình
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DangNhap(),
                            ),
                            (route) => false,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                settings.dich(
                                  'Bạn đã đăng xuất!',
                                  'You have logged out!',
                                ),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          settings.dich('Đăng xuất', 'Log out'),
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
