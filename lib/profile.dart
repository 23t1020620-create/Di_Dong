import 'package:flutter/material.dart';
import 'package:shopeasy/app_setting.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsScope.of(context);
    final ColorScheme mau = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(settings.dich('Cá nhân', 'Profile')),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            elevation: 4,
            margin: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: SizedBox(
              width: 350,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: 130,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=800',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -45,
                        child: CircleAvatar(
                          radius: 52,
                          // Viền ảnh đại diện theo màu nền thẻ (sáng/tối)
                          backgroundColor: Theme.of(context).cardColor,
                          child: const CircleAvatar(
                            radius: 47,
                            backgroundImage: NetworkImage(
                              'https://plus.unsplash.com/premium_photo-1789652752045-7db8caff8c0c?q=80&w=764&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=NHwxMjA3fDA%3D',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 55),

                  // TÊN
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Nguyễn Văn An',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: mau.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),

                  // NGHỀ NGHIỆP
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      settings.dich('Lập trình viên', 'Software developer'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: mau.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),

                  // ĐỊA CHỈ
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      settings.dich('Huế, Việt Nam', 'Hue, Vietnam'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: mau.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Divider(
                    height: 1,
                    thickness: 1,
                    indent: 16,
                    endIndent: 16,
                    color: mau.outlineVariant,
                  ),

                  // THỐNG KÊ
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildStat(
                            context,
                            '120',
                            settings.dich('Bài viết', 'Posts'),
                          ),
                        ),
                        Expanded(
                          child: _buildStat(
                            context,
                            '1.5K',
                            settings.dich('Người theo dõi', 'Followers'),
                          ),
                        ),
                        Expanded(
                          child: _buildStat(
                            context,
                            '350',
                            settings.dich('Đang theo dõi', 'Following'),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Divider(
                    height: 1,
                    thickness: 1,
                    indent: 16,
                    endIndent: 16,
                    color: mau.outlineVariant,
                  ),

                  // NÚT
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    settings.dich(
                                      'Bạn đã nhấn Theo dõi',
                                      'You pressed Follow',
                                    ),
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                            child: Text(
                              settings.dich('Theo dõi', 'Follow'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 2,
                          child: OutlinedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    settings.dich(
                                      'Bạn đã nhấn Nhắn tin',
                                      'You pressed Message',
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              settings.dich('Nhắn tin', 'Message'),
                            ),
                          ),
                        ),
                      ],
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

  static Widget _buildStat(BuildContext context, String number, String label) {
    final ColorScheme mau = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          number,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: mau.onSurface,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            color: mau.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
