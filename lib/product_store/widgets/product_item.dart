import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:store_pro/Themes/styles.dart';
import 'package:store_pro/product_store/model/app_state_model.dart';
import 'package:store_pro/product_store/model/icecream.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({required this.icecream, super.key});
  final Icecreams icecream;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(icecream.image),
      ),
      title: Text(
        icecream.flavour,
        style: Styles.productRowItemName,
      ),
      subtitle: Text(
        '₹ ${icecream.price}',
        style: Styles.productRowItemPrice,
      ),
      trailing: IconButton(
        icon: const Icon(Ionicons.add_circle),
        onPressed: () {
          Provider.of<AppStateModel>(context, listen: false)
              .addProductToCart(icecream.id);
          VxToast.show(
            context,
            msg: 'Added to cart',
            position: VxToastPosition.center,
          );
        },
      ),
    );
  }
}
