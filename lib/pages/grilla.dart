import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:parcial/exports.dart';
import 'package:parcial/services/api_service.dart';

class Grilla extends StatefulWidget {
  const Grilla({super.key});

  @override
  State<Grilla> createState() => _GrillaState();

  static count({required int crossAxisCount, required List<Center> children}) {}
}

class _GrillaState extends State<Grilla> {
  List<Product> productss = <Product>[];
  Future<List<Product>> getProducts() async {
    var register= await APIService.getProducts();
    return register;
  }

  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    getProducts().then((value) {
      setState(() {
        productss.addAll(value);
      });
    });
  }

  void logout() async {
    SharedService.prefs.clear();
    Navigator.pushNamed(context, '/login');
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
        break;
      case 1:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Grilla()));
        break;
      case 2:
        print("FUNCION DE FAV'S");
        break;
      case 3:
        logout();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Lista de productos'),
          backgroundColor: Colors.deepOrange,
        ),
        body: GridView.count(
          padding: const EdgeInsets.all(5),
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          crossAxisCount: 2,
          children: List.generate(productss.length, (index) {
            return Card(
                margin: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(15.0),
                          child: Image.network(productss[index].photo!,
                              height: 90, fit: BoxFit.cover),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          productss[index].name!,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway'),
                        ),
                        Text(
                          productss[index].description!,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.w200,
                              fontFamily: 'Raleway'),
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              productss[index].price.toString() + "\$",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Raleway'),
                            ),
                            const SizedBox(
                              width: 90,
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.star,
                                color: Colors.deepOrangeAccent,
                              ),
                              onPressed: () {},
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ));
          }),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.list, color: Colors.deepOrange),
              label: 'Lista',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.grid_4x4, color: Colors.deepOrange),
              label: 'Grilla',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.favorite, color: Colors.deepOrange),
              label: 'Favoritos',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.logout, color: Colors.deepOrange),
              label: 'Salir',
            ),
          ],
          selectedLabelStyle: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
