Widget buildLista(BuildContext context) {
    return Center(
        child: ListView.builder(
          itemCount: productss.length,
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
                              Image.network(productss[index].photo!,
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
                                  productss[index].name!,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Raleway'),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  productss[index].description!,
                                  style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'Raleway'),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "\$ ${productss[index].price}",
                                  style: const TextStyle(fontFamily: 'Raleway'),
                                ),
                                const SizedBox(height: 8),
                                ButtonFavorite(idOffer: productss[index].id)
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
      ),