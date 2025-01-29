import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_pro/product_store/model/app_state_model.dart';
import 'package:store_pro/product_store/widgets/product_item.dart';
import 'package:velocity_x/velocity_x.dart';

class IcecreamView extends StatelessWidget {
  const IcecreamView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Icecreams'),
        actions: [
          const VxDarkModeButton(
            showSingleIcon: true,
          ).p12(),
        ],
      ),
      body: Consumer<AppStateModel>(
        builder: (context, value, child) {
          final iceCreams = value.getProducts();
          return ListView.builder(
            itemBuilder: (context, index) {
              return ProductItem(
                icecream: iceCreams[index],
              );
            },
            itemCount: iceCreams.length,
          );
        },
      ),
    );
  }
}
