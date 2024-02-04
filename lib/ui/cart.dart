import 'dart:developer';

import 'package:assignmentecom/data/controller/deataprovider.dart';
import 'package:assignmentecom/models/fakedatamodel.dart';
import 'package:assignmentecom/ui/detailpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MyDataProvider>(context, listen: false).getCartItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Consumer<MyDataProvider>(builder: (context, data, _) {
              log(data.cart.length.toString());

              final cart = data.cart;
              return data.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : cart.isEmpty
                      ? const Center(
                          child: Text("Cart is Empty"),
                        )
                      : Consumer<MyDataProvider>(
                          builder: (context, data, _) {
                            return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio:
                                    0.7, // Adjust the aspect ratio to increase the height
                              ),
                              itemCount: cart.length,
                              itemBuilder: (context, index) {
                                final product = cart[index];
                                return CartCard(product: product, index: index);
                              },
                            );
                          },
                        );
            }),
          ),
        ],
      ),
    );
  }
}

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.product,
    required this.index,
  }) : super(key: key);

  final CartItem product;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(fakeModel: product.fakeModel),
          ),
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  product.fakeModel.image ?? '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.fakeModel.title ?? '',
                    maxLines: 3,
                    style: const TextStyle(
                      overflow: TextOverflow.fade,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    '\$${product.fakeModel.price?.toStringAsFixed(2) ?? ''}',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  QuantityWidget(
                    initialQuantity: product.quantity,
                    index: index,
                  ),
                  const SizedBox(height: 8.0),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    onPressed: () {
                      Provider.of<MyDataProvider>(context, listen: false)
                          .deleteFromCart(product);
                    },
                    child: const Text('Remove from cart'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuantityWidget extends StatefulWidget {
  final int initialQuantity;
  final int index;

  const QuantityWidget({
    Key? key,
    required this.initialQuantity,
    required this.index,
  }) : super(key: key);

  @override
  _QuantityWidgetState createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialQuantity;
  }

  void _increaseQuantity() {
    setState(() {
      Provider.of<MyDataProvider>(context, listen: false)
          .updateQuantityByOne(widget.index);
    });
  }

  void _decreaseQuantity() {
    setState(() {
      if (_quantity > 1) {
        Provider.of<MyDataProvider>(context, listen: false)
            .deleteQuantityByOne(widget.index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: _decreaseQuantity,
          icon: Icon(Icons.remove),
        ),
        Text(
          '$_quantity',
          style: TextStyle(fontSize: 16.0),
        ),
        IconButton(
          onPressed: _increaseQuantity,
          icon: Icon(Icons.add),
        ),
      ],
    );
  }
}
