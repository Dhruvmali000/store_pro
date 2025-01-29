import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_pro/product_store/model/app_state_model.dart';
import 'package:store_pro/product_store/widgets/product_item.dart';
import 'package:store_pro/product_store/widgets/search_bar.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late TextEditingController _controller = TextEditingController();
  late FocusNode _focusNode = FocusNode();

  String query = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: query)
      ..addListener(_onQueryChanged);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onQueryChanged() {
    setState(() {
      query = _controller.text;
    });
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Search(controller: _controller, focusNode: _focusNode),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppStateModel>(context);
    final filterdProducts = model.search(query);
    return Scaffold(
      appBar: AppBar(
        title: const Text('search'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBox(),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ProductItem(
                    icecream: filterdProducts[index],
                  );
                },
                itemCount: filterdProducts.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
