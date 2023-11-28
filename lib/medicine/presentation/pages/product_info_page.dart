import 'package:flutter/material.dart';

class ProductInfoPage extends StatelessWidget {
  const ProductInfoPage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(
          'name',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        color: Colors.black,
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
        child: Column(
          children: [
            Image.asset(
              '',
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Ingredients',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.orangeAccent),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              '',
              style: const TextStyle(color: Colors.white38, fontSize: 16),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Steps',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.orangeAccent),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              '',
              style: const TextStyle(color: Colors.white38, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}