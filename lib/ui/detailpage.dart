import 'package:assignmentecom/models/fakedatamodel.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final FakeModel fakeModel;

  const DetailPage({Key? key, required this.fakeModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(fakeModel.image ?? ''),
            const SizedBox(height: 16),
            Text(
              fakeModel.title ?? '',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Price: \$${fakeModel.price?.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Category: ${fakeModel.category}',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Description: ${fakeModel.description}',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Rating: ${fakeModel.rating?.toString() ?? 'N/A'}',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
