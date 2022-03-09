import 'package:flutter/material.dart';

class NoConnectionWidget extends StatelessWidget {
  final VoidCallback onTap;
  const NoConnectionWidget({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Tidak Ada Koneksi Internet'),
            SizedBox(width: 10),
            Icon(Icons.error_outline),
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: onTap,
          child: const Text('Muat Ulang'),
        )
      ],
    );
  }
}
