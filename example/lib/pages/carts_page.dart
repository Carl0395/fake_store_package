import 'package:fake_store_package/models/cart_model.dart';
import 'package:fake_store_package/util/failures.dart';
import 'package:flutter/material.dart';

class CartsPage extends StatelessWidget {
  final List<CartModel>? carts;
  final Failure? failure;
  const CartsPage({super.key, required this.carts, this.failure});

  @override
  Widget build(BuildContext context) {
    if (failure != null) {
      return Center(child: Text(failure!.message));
    }
    if (carts == null) {
      return Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
      itemCount: carts?.length,
      itemBuilder: (context, index) {
        final cart = carts![index];
        return Card(
          child: Column(
            children: [
              ListTile(
                title: Text('User: ${cart.userId}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Fecha: ${cart.date.toString().split(' ').first}'),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text('Productos:'),
                    ),
                    ...cart.products!.map(
                      (product) => Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          'ID: ${product.productId} - Cantidad: ${product.quantity}',
                        ),
                      ),
                    ),
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
