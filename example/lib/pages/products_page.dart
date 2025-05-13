import 'package:fake_store_package/models/product_model.dart';
import 'package:fake_store_package/util/failures.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatelessWidget {
  final List<ProductModel>? products;
  final Failure? failure;
  const ProductsPage({super.key, required this.products, this.failure});

  @override
  Widget build(BuildContext context) {
    if (failure != null) {
      return Center(child: Text(failure!.message));
    }
    if (products == null) {
      return Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
      itemCount: products?.length,
      itemBuilder: (context, index) {
        final product = products![index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.network(
                  product.image ?? '',
                  width: double.infinity,
                  height: 200,
                ),
              ),
              ListTile(
                title: Text(product.title ?? ''),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Precio: \$${product.price.toString()}'),
                    Text('Categoría: \$${product.category.toString()}'),
                    Text('Descripción: \$${product.description.toString()}'),
                    Text('Descripción: \$${product.description.toString()}'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
