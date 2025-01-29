import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:store_pro/Themes/styles.dart';
import 'package:store_pro/product_store/model/app_state_model.dart';

import 'package:store_pro/product_store/widgets/cart_item.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  String? name;
  String? email;
  String? phone;
  String? address;
  DateTime? dateTime = DateTime.now();
  final formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Name',
        prefixIcon: Icon(Ionicons.person_outline),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your name';
        }
        return null;
      },
      onSaved: (String? value) {
        name = value;
      },
      onChanged: (value) => setState(() => name = value),
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Email',
        prefixIcon: Icon(Ionicons.mail_outline),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your email';
        }
        if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
            .hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
      onSaved: (String? value) {
        email = value;
      },
      onChanged: (value) => setState(() => email = value),
    );
  }

  Widget _buildPhone() {
    return TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Phone',
        prefixIcon: Icon(Ionicons.call_outline),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your phone number';
        }
        if (!RegExp(r'^\d{10}$').hasMatch(value)) {
          return 'Please enter a valid 10-digit phone number';
        }
        return null;
      },
      onSaved: (String? value) {
        phone = value;
      },
      onChanged: (value) => setState(() => phone = value),
    );
  }

  Widget _buildAddress() {
    return TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Address',
        prefixIcon: Icon(Ionicons.location_outline),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your address';
        }
        return null;
      },
      onSaved: (String? value) {
        address = value;
      },
      onChanged: (value) => setState(() => address = value),
    );
  }

  Widget _buildTimePicker() {
    return InkWell(
      onTap: () async {
        final newTime = await showDatePicker(
          context: context,
          initialDate: dateTime,
          firstDate: DateTime(2000),
          lastDate: DateTime(
            2025,
          ),
        );
        if (newTime != null) {
          setState(() {
            dateTime = newTime;
          });
        }
      },
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Row(
                children: <Widget>[
                  Icon(
                    Ionicons.time_outline,
                    size: 28,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Delivery Time',
                    style: Styles.deliveryTextStyle,
                  ),
                ],
              ),
              Text(
                DateFormat.yMMMMd().add_jm().format(dateTime!),
                style: Styles.deliveryTime,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Consumer<AppStateModel>(
        builder: (context, value, child) {
          return ListView(
            children: [
              ExpansionTile(
                title: const Text('Address Details'),
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: _buildName(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: _buildEmail(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: _buildPhone(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: _buildAddress(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: _buildTimePicker(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(),
              if (value.productsInCart.isNotEmpty)
                ListView.builder(
                  itemBuilder: (context, index) {
                    return CartItem(
                      product: value.getProductById(
                        value.productsInCart.keys.toList()[index],
                      ),
                      quantity: value.productsInCart.values.toList()[index],
                    );
                  },
                  itemCount: value.productsInCart.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Shipping + Tax',
                      style: Styles.productRowItemPrice,
                    ),
                    Text(
                      // ignore: lines_longer_than_80_chars
                      '${value.shippingCost.toStringAsFixed(2)} + ${value.tax.toStringAsFixed(2)}',
                      style: Styles.productRowItemPrice,
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: Styles.productRowItemName,
                    ),
                    Text(
                      value.totalCost.toStringAsFixed(2),
                      style: Styles.productRowItemName,
                    ),
                  ],
                ),
              ),
              const Divider(),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    value.clearCart();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Order placed successfully'),
                      ),
                    );
                  }
                },
                child: const Text('Place Order'),
              ),
            ],
          );
        },
      ),
    );
  }
}
