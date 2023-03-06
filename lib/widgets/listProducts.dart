import 'package:parcial/exports.dart';

// ignore: must_be_immutable
class ListProducts extends StatefulWidget {
  List<Product> products;

  ListProducts({super.key, required this.products});

  @override
  State<ListProducts> createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: widget.products.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Card(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Image.network(widget.products[index].photo!,
                                height: 120, width: 150, fit: BoxFit.cover),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.products[index].name!,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Raleway'),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                widget.products[index].description!,
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontFamily: 'Raleway'),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "\$ ${widget.products[index].price}",
                                style: const TextStyle(fontFamily: 'Raleway'),
                              ),
                              const SizedBox(height: 8),
                              ButtonFavorite(idOffer: widget.products[index].id)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
