// lib/screens/view_status_screen.dart
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:srichat/models/status_model.dart';

class ViewStatusScreen extends StatefulWidget {
  final List<Status> statuses;
  final int initialIndex;

  const ViewStatusScreen({
    super.key,
    required this.statuses,
    required this.initialIndex,
  });

  @override
  State<ViewStatusScreen> createState() => _ViewStatusScreenState();
}

class _ViewStatusScreenState extends State<ViewStatusScreen> {
  late PageController _pageController;
  int _currentStatusItem = 0;
  Timer? _timer;
  double _progress = 0;

  static const int statusDuration = 5; // detik per status

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _progress = 0;
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (!mounted) return;
      setState(() {
        _progress += 0.05 / statusDuration;
        if (_progress >= 1) {
          _nextStatus();
        }
      });
    });
  }

  void _nextStatus() {
    final int currentPageIndex = _pageController.page?.round() ?? widget.initialIndex;
    final status = widget.statuses[currentPageIndex];

    if (_currentStatusItem < status.statusItems.length - 1) {
      // Pindah ke item status berikutnya dalam pengguna yang sama
      setState(() {
        _currentStatusItem++;
        _progress = 0;
      });
    } else if (currentPageIndex < widget.statuses.length - 1) {
      // Pindah ke pengguna berikutnya
      setState(() {
        _currentStatusItem = 0;
        _progress = 0;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Ini adalah status terakhir, kembali ke layar sebelumnya
      _timer?.cancel();
      Navigator.pop(context);
    }
  }

  void _onTapDown(TapDownDetails details) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    final double screenWidth = box.size.width;
    
    // Jika ketukan di sebelah kiri layar, mundur. Jika di kanan, maju.
    if (localOffset.dx < screenWidth / 2) {
      // Logika untuk mundur bisa ditambahkan di sini jika diperlukan
    }
    
    _timer?.cancel();
  }

  void _onTapUp(TapUpDetails details) {
    _startTimer();
  }

  ImageProvider getImageProvider(String path) {
    if (path.startsWith('assets/')) {
      return AssetImage(path);
    } else {
      return FileImage(File(path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.statuses.length,
        onPageChanged: (index) {
          // Reset state saat halaman berubah
          setState(() {
            _currentStatusItem = 0;
            _progress = 0;
          });
          _startTimer();
        },
        itemBuilder: (context, pageIndex) {
          final status = widget.statuses[pageIndex];
          // Jika status tidak memiliki item, tampilkan widget kosong
          if (status.statusItems.isEmpty) {
            return const Scaffold(backgroundColor: Colors.black);
          }

          return GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            child: Stack(
              children: [
                // Gambar status
                Positioned.fill(
                  child: Image(
                    image: getImageProvider(status.statusItems[_currentStatusItem]),
                    fit: BoxFit.cover,
                  ),
                ),
                // Overlay UI
                _buildUIOverlay(status),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildUIOverlay(Status status) {
    return Stack(
      children: [
        // Progress bar
        Positioned(
          top: MediaQuery.of(context).padding.top + 10, // Menggunakan MediaQuery untuk safe area
          left: 10,
          right: 10,
          child: Row(
            children: status.statusItems.asMap().entries.map((entry) {
              int index = entry.key;
              double value;
              if (index < _currentStatusItem) {
                value = 1.0;
              } else if (index == _currentStatusItem) {
                value = _progress;
              } else {
                value = 0.0;
              }
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 1.5),
                  height: 3,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: value.clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        // Tombol Kembali dan Info Pengguna
        Positioned(
          top: MediaQuery.of(context).padding.top + 5,
          left: 5,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  _timer?.cancel();
                  Navigator.pop(context);
                },
              ),
              const SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    status.userName,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    status.time,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}