import 'dart:async';

import 'package:flutter/material.dart';

import 'main_navigation_page.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  // Durasi hitung mundur (detik) - Live Tweak 2: 10 detik
  int _durasiDetik = 10;

  // Nullable karena baru dibuat saat initState
  Timer? _timer;

  static const Color _warnaUtama = Color(0xFF4F0606);

  @override
  void initState() {
    super.initState();
    _mulaiHitungMundur();
  }

  void _mulaiHitungMundur() {
    // Timer berjalan setiap 1 detik
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_durasiDetik > 1) {
        setState(() {
          _durasiDetik--;
        });
      } else {
        _timer?.cancel();

        // Pastikan widget masih aktif sebelum pindah halaman
        if (!mounted) return;

        // pushReplacement: splash tidak bisa dikembalikan dengan tombol Back
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainNavigationPage()),
        );
      }
    });
  }

  @override
  void dispose() {
    // Matikan timer agar tidak terjadi memory leak
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _warnaUtama,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Icon(
                Icons.point_of_sale_rounded,
                size: 72,
                color: _warnaUtama,
              ),
            ),
            const SizedBox(height: 24),

            // Nama dan slogan
            const Text(
              'SmartKasir',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Aplikasi Kasir Point of Sale Digital',
              style: TextStyle(fontSize: 13, color: Colors.white70),
            ),
            const SizedBox(height: 36),

            // Indikator loading + teks timer
            const SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(
                color: Colors.amber,
                strokeWidth: 3,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Menyiapkan sistem SmartKasir ($_durasiDetik detik)...',
              style: const TextStyle(fontSize: 12, color: Colors.white70),
            ),
            const SizedBox(height: 40),

            const Text(
              'Versi 1.0.0 — Modul Pertemuan 10',
              style: TextStyle(fontSize: 11, color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }
}
