import 'package:flutter/material.dart';
import 'package:shopeasy/profile.dart';
import 'package:shopeasy/login.dart';
import 'package:shopeasy/app_setting.dart';

String dich(BuildContext context, String tiengViet, String tiengAnh) {
  return AppSettingsScope.of(context).dich(tiengViet, tiengAnh);
}

// Tên sản phẩm hiển thị theo ngôn ngữ đang chọn.
// 'ten' vẫn là khóa định danh (yêu thích, giỏ hàng), không dùng để hiển thị trực tiếp.
String tenSanPham(BuildContext context, Map<String, dynamic> sp) {
  final String tenViet = sp['ten'].toString();
  final String tenAnh = (sp['tenEn'] ?? sp['ten']).toString();
  return dich(context, tenViet, tenAnh);
}

// Hệ số phóng to chữ hiện tại (1.0 = bình thường), lấy từ cài đặt "Cỡ chữ".
double heSoCoChu(BuildContext context) {
  return MediaQuery.textScalerOf(context).scale(1.0).clamp(1.0, 2.0).toDouble();
}

class Danhsach extends StatefulWidget {
  const Danhsach({super.key});
  @override
  State<Danhsach> createState() => _DanhsachState();
}

class _DanhsachState extends State<Danhsach> {
  final TextEditingController searchController = TextEditingController();
  String tuKhoa = '';
  String danhMucChon = 'Tất cả';
  int tabChon = 0;
  final List<String> danhMuc = [
    'Tất cả',
    'Điện thoại',
    'Laptop',
    'Phụ kiện',
  ];

  final Set<String> yeuThich = {};
  final List<Map<String, dynamic>> gioHang = [];
  final List<Map<String, dynamic>> sanPham = [
    {
      'ten': 'iPhone 16',
      'tenEn': 'iPhone 16',
      'anh':
          'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iPhone-16/iphone-16-2_2.jpg',
      'danhMuc': 'Điện thoại',
      'gia': 21990000,
      'giaGoc': 28990000,
      'giamGia': 25,
      'diem': 4.8,
      'luotDanhGia': 1200,
    },
    {
      'ten': 'Samsung Galaxy S25',
      'tenEn': 'Samsung Galaxy S25',
      'anh':
          'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=600',
      'danhMuc': 'Điện thoại',
      'gia': 19990000,
      'giaGoc': 24990000,
      'giamGia': 20,
      'diem': 4.7,
      'luotDanhGia': 850,
    },
    {
      'ten': 'MacBook Air',
      'tenEn': 'MacBook Air',
      'anh':
          'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=600',
      'danhMuc': 'Laptop',
      'gia': 24990000,
      'giaGoc': 27990000,
      'giamGia': 11,
      'diem': 4.9,
      'luotDanhGia': 650,
    },
    {
      'ten': 'Dell Inspiron Laptop',
      'tenEn': 'Dell Inspiron Laptop',
      'anh':
          'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=600',
      'danhMuc': 'Laptop',
      'gia': 15990000,
      'giaGoc': 18990000,
      'giamGia': 16,
      'diem': 4.6,
      'luotDanhGia': 420,
    },
    {
      'ten': 'Tai nghe Bluetooth',
      'tenEn': 'Bluetooth Headphones',
      'anh':
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=600',
      'danhMuc': 'Phụ kiện',
      'gia': 790000,
      'giaGoc': 990000,
      'giamGia': 20,
      'diem': 4.8,
      'luotDanhGia': 320,
    },
    {
      'ten': 'Chuột không dây',
      'tenEn': 'Wireless Mouse',
      'anh':
          'https://images.unsplash.com/photo-1527814050087-3793815479db?w=600',
      'danhMuc': 'Phụ kiện',
      'gia': 350000,
      'giaGoc': 450000,
      'giamGia': 22,
      'diem': 4.5,
      'luotDanhGia': 180,
    },
  ];

  int get soLuongGioHang {
    int tong = 0;
    for (var sp in gioHang) {
      tong += sp['soLuong'] as int;
    }
    return tong;
  }

  // Tìm theo cả tên tiếng Việt lẫn tên tiếng Anh.
  List<Map<String, dynamic>> get sanPhamLoc {
    final String tuKhoaThuong = tuKhoa.toLowerCase();

    return sanPham.where((sp) {
      bool dungTuKhoa = sp['ten']
              .toString()
              .toLowerCase()
              .contains(tuKhoaThuong) ||
          (sp['tenEn'] ?? '').toString().toLowerCase().contains(tuKhoaThuong);
      bool dungDanhMuc =
          danhMucChon == 'Tất cả' || sp['danhMuc'] == danhMucChon;
      return dungTuKhoa && dungDanhMuc;
    }).toList();
  }

  String dinhDangGia(int gia) {
    return gia.toString().replaceAllMapped(
              RegExp(r'\B(?=(\d{3})+(?!\d))'),
              (match) => '.',
            ) +
        ' đ';
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void themVaoGio(Map<String, dynamic> sp) {
    int viTri = gioHang.indexWhere(
      (item) => item['ten'] == sp['ten'],
    );

    setState(() {
      if (viTri >= 0) {
        gioHang[viTri]['soLuong']++;
      } else {
        gioHang.add({
          ...sp,
          'soLuong': 1,
        });
      }
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(dich(
            context,
            'Đã thêm ${tenSanPham(context, sp)} vào giỏ hàng',
            'Added ${tenSanPham(context, sp)} to cart',
          )),
          duration: const Duration(seconds: 1),
        ),
      );
  }

  Widget anhSanPham(String url) {
    return Image.network(
      url,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.contain,
      loadingBuilder: (context, child, progress) {
        if (progress == null) {
          return child;
        }

        return const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey.shade200,
          alignment: Alignment.center,
          child: const Icon(
            Icons.image_not_supported,
            size: 40,
            color: Colors.grey,
          ),
        );
      },
    );
  }

  Widget hangSao(double diem) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        IconData icon;

        if (diem >= i + 1) {
          icon = Icons.star;
        } else if (diem >= i + 0.5) {
          icon = Icons.star_half;
        } else {
          icon = Icons.star_border;
        }

        return Icon(
          icon,
          color: Colors.amber,
          size: 13,
        );
      }),
    );
  }

  Widget theSanPham(BuildContext context, Map<String, dynamic> sp) {
    // 'ten' dùng làm khóa cho danh sách yêu thích.
    String ten = sp['ten'];
    bool daThich = yeuThich.contains(ten);
    final double heSo = heSoCoChu(context);

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.2,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(6),
                  child: anhSanPham(sp['anh']),
                ),
                Positioned(
                  top: 6,
                  left: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '-${sp['giamGia']}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (daThich) {
                          yeuThich.remove(ten);
                        } else {
                          yeuThich.add(ten);
                        }
                      });
                    },
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.white,
                      child: Icon(
                        daThich ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                        size: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30 * heSo,
                    child: Text(
                      tenSanPham(context, sp),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        height: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      hangSao(
                        (sp['diem'] as num).toDouble(),
                      ),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          '${sp['diem']} (${sp['luotDanhGia']})',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    dinhDangGia(sp['gia']),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    dinhDangGia(sp['giaGoc']),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    height: 30 * heSo,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        padding: EdgeInsets.zero,
                        textStyle: const TextStyle(
                          fontSize: 11,
                        ),
                      ),
                      onPressed: () => themVaoGio(sp),
                      child: Text(dich(context, 'Thêm vào giỏ', 'Add to cart')),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void moGioHang() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GioHangPage(
          gioHang: gioHang,
          dinhDangGia: dinhDangGia,
          onChanged: () {
            setState(() {});
          },
        ),
      ),
    ).then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> ds = sanPhamLoc;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ShopEasy'),
        actions: [
          // NÚT CÀI ĐẶT
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: dich(context, 'Cài đặt', 'Settings'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CaiDat(),
                ),
              );
            },
          ),
          IconButton(
            onPressed: moGioHang,
            icon: Badge(
              isLabelVisible: soLuongGioHang > 0,
              label: Text('$soLuongGioHang'),
              child: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Ô TÌM KIẾM
            TextField(
              controller: searchController,
              cursorColor: Colors.blue,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
              onChanged: (value) {
                setState(() {
                  tuKhoa = value;
                });
              },
              decoration: InputDecoration(
                hintText:
                    dich(context, 'Tìm sản phẩm...', 'Search products...'),
                hintStyle: TextStyle(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.65),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              height: 45,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: danhMuc.map((loai) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(
                        dich(
                          context,
                          loai,
                          loai == 'Tất cả'
                              ? 'All'
                              : loai == 'Điện thoại'
                                  ? 'Phones'
                                  : loai == 'Phụ kiện'
                                      ? 'Accessories'
                                      : 'Laptop',
                        ),
                        style: TextStyle(
                          color: danhMucChon == loai
                              ? Colors.black87
                              : Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      selected: danhMucChon == loai,
                      selectedColor: Colors.blue.shade100,
                      checkmarkColor: Colors.black87,
                      onSelected: (_) {
                        setState(() {
                          danhMucChon = loai;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 8),

            Expanded(
              child: ds.isEmpty
                  ? Center(
                      child: Text(dich(context, 'Không tìm thấy sản phẩm',
                          'No products found')),
                    )
                  : LayoutBuilder(
                      builder: (context, constraints) {
                        double cardWidth = (constraints.maxWidth - 10) / 2;

                        const double tiLeAnh = 1.2;
                        // Phần thông tin tăng theo cỡ chữ.
                        // Khi heSo = 1 thì kết quả đúng bằng 132 như cũ.
                        final double heSo = heSoCoChu(context);
                        final double chieuCaoThongTin =
                            27 + 92 * heSo + (12 * heSo > 13 ? 12 * heSo : 13);

                        double cardHeight =
                            cardWidth / tiLeAnh + chieuCaoThongTin;

                        return GridView.builder(
                          itemCount: ds.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            mainAxisExtent: cardHeight,
                          ),
                          itemBuilder: (context, index) {
                            return theSanPham(context, ds[index]);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabChon,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            setState(() {
              tabChon = 0;
            });
          } else if (index == 1) {
            setState(() {
              tabChon = 1;
            });

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => YeuThichPage(
                  sanPham: sanPham
                      .where((sp) => yeuThich.contains(sp['ten']))
                      .toList(),
                  dinhDangGia: dinhDangGia,
                  themVaoGio: themVaoGio,
                ),
              ),
            ).then((_) {
              if (mounted) {
                setState(() {
                  tabChon = 0;
                });
              }
            });
          } else if (index == 2) {
            setState(() {
              tabChon = 2;
            });

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DashboardPage(
                  sanPham: sanPham,
                ),
              ),
            ).then((_) {
              if (mounted) {
                setState(() {
                  tabChon = 0;
                });
              }
            });
          } else {
            setState(() {
              tabChon = 3;
            });

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyProfile(),
              ),
            ).then((_) {
              if (mounted) {
                setState(() {
                  tabChon = 0;
                });
              }
            });
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: dich(context, 'Trang chủ', 'Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: dich(context, 'Yêu thích', 'Favorites'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: dich(context, 'Cá nhân', 'Profile'),
          ),
        ],
      ),
    );
  }
}

// ======================= DASHBOARD =======================

class DashboardPage extends StatelessWidget {
  final List<Map<String, dynamic>> sanPham;

  const DashboardPage({
    super.key,
    required this.sanPham,
  });

  // Đơn hàng mẫu sử dụng trực tiếp link ảnh từ danh sách sanPham.
  // Vì vậy Dashboard không cần khai báo lại đường dẫn ảnh.
  List<Map<String, dynamic>> get donHangGanDay => [
        {
          'ma': '#DH001',
          'ten': 'Nguyễn Văn An',
          'ngay': '02/11/2026',
          'tongTien': '21.990.000 đ',
          'trangThai': 'Đã giao',
          'anh': sanPham.isNotEmpty ? sanPham[0]['anh'] : '',
        },
        {
          'ma': '#DH002',
          'ten': 'Trần Thị Bình',
          'ngay': '01/11/2026',
          'tongTien': '790.000 đ',
          'trangThai': 'Đang giao',
          'anh': sanPham.length > 4 ? sanPham[4]['anh'] : '',
        },
        {
          'ma': '#DH003',
          'ten': 'Lê Minh Cường',
          'ngay': '31/10/2026',
          'tongTien': '24.990.000 đ',
          'trangThai': 'Chờ xác nhận',
          'anh': sanPham.length > 2 ? sanPham[2]['anh'] : '',
        },
        {
          'ma': '#DH004',
          'ten': 'Phạm Thu Hà',
          'ngay': '30/10/2026',
          'tongTien': '350.000 đ',
          'trangThai': 'Đã hủy',
          'anh': sanPham.length > 5 ? sanPham[5]['anh'] : '',
        },
      ];

  Color mauTrangThai(String trangThai) {
    switch (trangThai) {
      case 'Đã giao':
        return Colors.green;
      case 'Đang giao':
        return Colors.blue;
      case 'Chờ xác nhận':
        return Colors.orange;
      case 'Đã hủy':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget theThongKe({
    required IconData icon,
    required String soLieu,
    required String nhan,
    required Color mau,
  }) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 17,
              backgroundColor: mau.withOpacity(0.12),
              child: Icon(
                icon,
                color: mau,
                size: 19,
              ),
            ),
            const SizedBox(height: 10),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                soLieu,
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              nhan,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dongDonHang(BuildContext context, Map<String, dynamic> donHang) {
    final Color mau = mauTrangThai(donHang['trangThai']);

    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 9),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: SizedBox(
                width: 58,
                height: 58,
                child: (donHang['anh'] ?? '').toString().isNotEmpty
                    ? Image.network(
                        donHang['anh'],
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade200,
                            child: const Icon(
                              Icons.image_not_supported,
                              color: Colors.grey,
                            ),
                          );
                        },
                      )
                    : Container(
                        color: Colors.grey.shade200,
                        child: const Icon(
                          Icons.shopping_bag_outlined,
                          color: Colors.grey,
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${donHang['ma']} - ${donHang['ten']}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${donHang['ngay']} • ${donHang['tongTien']}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: mau.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        dich(
                          context,
                          donHang['trangThai'],
                          donHang['trangThai'] == 'Đã giao'
                              ? 'Delivered'
                              : donHang['trangThai'] == 'Đang giao'
                                  ? 'Shipping'
                                  : donHang['trangThai'] == 'Chờ xác nhận'
                                      ? 'Pending'
                                      : 'Cancelled',
                        ),
                        style: TextStyle(
                          color: mau,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          dich(context, 'Tổng quan', 'Overview'),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: CustomScrollView(
        slivers: [
          // BỐN Ô THỐNG KÊ
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double chieuRongManHinh =
                      MediaQuery.of(context).size.width;

                  final int soCot = chieuRongManHinh > 600 ? 4 : 2;

                  return GridView.count(
                    crossAxisCount: soCot,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: soCot == 4 ? 1.05 : 1.35,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      theThongKe(
                        icon: Icons.receipt_long,
                        soLieu: '12',
                        nhan: dich(context, 'Đơn hàng', 'Orders'),
                        mau: Colors.blue,
                      ),
                      theThongKe(
                        icon: Icons.payments_outlined,
                        soLieu: '15,8 tr',
                        nhan: dich(context, 'Doanh thu', 'Revenue'),
                        mau: Colors.green,
                      ),
                      theThongKe(
                        icon: Icons.people_outline,
                        soLieu: '08',
                        nhan: dich(context, 'Khách hàng', 'Customers'),
                        mau: Colors.orange,
                      ),
                      theThongKe(
                        icon: Icons.inventory_2_outlined,
                        soLieu: '${sanPham.length}',
                        nhan: dich(context, 'Sản phẩm', 'Products'),
                        mau: Colors.purple,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 20, 14, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dich(context, 'Đơn hàng gần đây', 'Recent orders'),
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            dich(
                                context,
                                'Chức năng xem tất cả đơn hàng chưa được xây dựng',
                                'View all orders is not available yet'),
                          ),
                        ),
                      );
                    },
                    child: Text(dich(context, 'Xem tất cả', 'View all')),
                  ),
                ],
              ),
            ),
          ),

          // DANH SÁCH ĐƠN HÀNG
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return dongDonHang(context, donHangGanDay[index]);
                },
                childCount: donHangGanDay.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ======================= GIỎ HÀNG =======================

class GioHangPage extends StatefulWidget {
  final List<Map<String, dynamic>> gioHang;
  final String Function(int) dinhDangGia;
  final VoidCallback onChanged;
  const GioHangPage({
    super.key,
    required this.gioHang,
    required this.dinhDangGia,
    required this.onChanged,
  });
  @override
  State<GioHangPage> createState() => _GioHangPageState();
}

class _GioHangPageState extends State<GioHangPage> {
  final int phiVanChuyenMacDinh = 30000;
  int get tamTinh {
    int tong = 0;
    for (var sp in widget.gioHang) {
      tong += (sp['gia'] as int) * (sp['soLuong'] as int);
    }
    return tong;
  }

  int get phiVanChuyen {
    if (widget.gioHang.isEmpty || tamTinh >= 500000) {
      return 0;
    }

    return phiVanChuyenMacDinh;
  }

  int get tongTien {
    return tamTinh + phiVanChuyen;
  }

  void thayDoiSoLuong(int index, int thayDoi) {
    setState(() {
      widget.gioHang[index]['soLuong'] += thayDoi;
      if (widget.gioHang[index]['soLuong'] <= 0) {
        widget.gioHang.removeAt(index);
      }
    });
    widget.onChanged();
  }

  void xoaSanPham(int index) {
    setState(() {
      widget.gioHang.removeAt(index);
    });

    widget.onChanged();
  }

  void khoiPhucSanPham(
    Map<String, dynamic> sp,
    int index,
  ) {
    setState(() {
      widget.gioHang.insert(
        index.clamp(0, widget.gioHang.length),
        sp,
      );
    });
    widget.onChanged();
  }

  Widget dongTien(BuildContext context, String ten, int tien,
      {bool inDam = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            dich(
                context,
                ten,
                ten == 'Tạm tính'
                    ? 'Subtotal'
                    : ten == 'Phí vận chuyển'
                        ? 'Shipping fee'
                        : 'Total'),
            style: TextStyle(
              fontSize: 13,
              fontWeight: inDam ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            tien == 0 && ten == 'Phí vận chuyển'
                ? dich(context, 'Miễn phí', 'Free')
                : widget.dinhDangGia(tien),
            style: TextStyle(
              fontSize: inDam ? 16 : 13,
              fontWeight: inDam ? FontWeight.bold : FontWeight.normal,
              color: inDam
                  ? Colors.deepOrange
                  : Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget gioHangTrong(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 85,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 15),
          Text(
            dich(context, 'Giỏ hàng đang trống', 'Your cart is empty'),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            dich(context, 'Hãy thêm sản phẩm vào giỏ hàng nhé!',
                'Add some products to your cart!'),
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(dich(context, 'Tiếp tục mua sắm', 'Continue shopping')),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(dich(context, 'Giỏ hàng (${widget.gioHang.length})',
            'Cart (${widget.gioHang.length})')),
        centerTitle: true,
      ),
      body: widget.gioHang.isEmpty
          ? gioHangTrong(context)
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: widget.gioHang.length,
              itemBuilder: (context, index) {
                var sp = widget.gioHang[index];
                return Dismissible(
                  key: ValueKey(sp['ten']),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.only(right: 20),
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 30,
                        ),
                        Text(
                          dich(context, 'Xóa', 'Delete'),
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  onDismissed: (direction) {
                    Map<String, dynamic> spXoa = sp;
                    int viTri = index;
                    setState(() {
                      widget.gioHang.removeAt(index);
                    });
                    widget.onChanged();
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text(
                            dich(
                              context,
                              'Đã xóa ${tenSanPham(context, spXoa)} khỏi giỏ hàng',
                              'Removed ${tenSanPham(context, spXoa)} from cart',
                            ),
                          ),
                          duration: const Duration(seconds: 3),
                          action: SnackBarAction(
                            label: dich(context, 'Hoàn tác', 'Undo'),
                            onPressed: () {
                              khoiPhucSanPham(spXoa, viTri);
                            },
                          ),
                        ),
                      );
                  },
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    elevation: 1,
                    color: Theme.of(context).cardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              sp['anh'],
                              width: 65,
                              height: 65,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 65,
                                  height: 65,
                                  color: Colors.grey.shade200,
                                  child: const Icon(
                                    Icons.image_not_supported,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tenSanPham(context, sp),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  widget.dinhDangGia(sp['gia']),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        thayDoiSoLuong(index, -1);
                                      },
                                      icon: const Icon(
                                        Icons.remove_circle_outline,
                                      ),
                                      iconSize: 22,
                                      color: Colors.blue,
                                      constraints: const BoxConstraints(
                                        minWidth: 32,
                                        minHeight: 30,
                                      ),
                                      padding: EdgeInsets.zero,
                                    ),
                                    Container(
                                      width: 30,
                                      alignment: Alignment.center,
                                      child: Text(
                                        '${sp['soLuong']}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        thayDoiSoLuong(index, 1);
                                      },
                                      icon: const Icon(
                                        Icons.add_circle_outline,
                                      ),
                                      iconSize: 22,
                                      color: Colors.blue,
                                      constraints: const BoxConstraints(
                                        minWidth: 32,
                                        minHeight: 30,
                                      ),
                                      padding: EdgeInsets.zero,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: widget.gioHang.isEmpty
          ? null
          : SafeArea(
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    dongTien(context, 'Tạm tính', tamTinh),
                    dongTien(context, 'Phí vận chuyển', phiVanChuyen),
                    const Divider(),
                    dongTien(
                      context,
                      'Tổng cộng',
                      tongTien,
                      inDam: true,
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                dich(
                                    context,
                                    'Chức năng thanh toán chưa được xây dựng',
                                    'Checkout is not available yet'),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          dich(context, 'Thanh toán', 'Checkout'),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

// ======================= YÊU THÍCH =======================

class YeuThichPage extends StatelessWidget {
  final List<Map<String, dynamic>> sanPham;
  final String Function(int) dinhDangGia;
  final void Function(Map<String, dynamic>) themVaoGio;

  const YeuThichPage({
    super.key,
    required this.sanPham,
    required this.dinhDangGia,
    required this.themVaoGio,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dich(context, 'Sản phẩm yêu thích', 'Favorite products')),
      ),
      body: sanPham.isEmpty
          ? Center(
              child: Text(
                dich(context, 'Bạn chưa có sản phẩm yêu thích',
                    'You have no favorite products'),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: sanPham.length,
              itemBuilder: (context, index) {
                var sp = sanPham[index];

                return Card(
                  child: ListTile(
                    leading: Image.network(
                      sp['anh'],
                      width: 55,
                      height: 55,
                      fit: BoxFit.contain,
                      errorBuilder: (
                        context,
                        error,
                        stackTrace,
                      ) {
                        return const Icon(
                          Icons.shopping_bag,
                        );
                      },
                    ),
                    title: Text(tenSanPham(context, sp)),
                    subtitle: Text(
                      dinhDangGia(sp['gia']),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.add_shopping_cart,
                      ),
                      onPressed: () {
                        themVaoGio(sp);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
