import 'package:parcial/exports.dart';

// ignore: must_be_immutable
class GridProducts extends StatefulWidget {
  List<Product> products;

  GridProducts({super.key, required this.products});

  @override
  State<GridProducts> createState() => _GridProductsState();
}

class _GridProductsState extends State<GridProducts> {

  Widget gridElement(BuildContext context, int index) {
    return Card(
        margin: const EdgeInsets.all(3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 5,
            ),
            Image.network(widget.products[index].photo!,
                height: 90, fit: BoxFit.cover),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.products[index].name!,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: 'Raleway'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.products[index].description!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w200,
                        fontFamily: 'Raleway',
                        fontSize: 12),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$ ${widget.products[index].price}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontFamily: 'Raleway'),
                      ),
                      ButtonFavorite(idOffer: widget.products[index].id)
                    ],
                  ),
                )
              ],
            )
          ],
        ));
  }


  @override
  Widget build(BuildContext context) {
    return GridView.count(
        childAspectRatio: 0.8,
        mainAxisSpacing: 3,
        crossAxisSpacing: 3,
        crossAxisCount: 2,
        children: List.generate(widget.products.length, (index) {
          return gridElement(context, index);
        }),
      );
  }
}
