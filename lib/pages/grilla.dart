import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:parcial/exports.dart';
import 'package:http/http.dart' as http;

class Grilla extends StatefulWidget {
  const Grilla({super.key});

  @override
  State<Grilla> createState() => _GrillaState();

  static count({required int crossAxisCount, required List<Center> children}) {}
}

class _GrillaState extends State<Grilla> {
  List<Product> productss = <Product>[];
  Future<List<Product>> getProducts() async {
    var url = 'https://api.npoint.io/9c5fef5b63af7f36fb2d';
    var rta =
        await http.get(Uri.parse(url)).timeout(const Duration(seconds: 90));
    var datos = jsonDecode(rta.body);
    var register = <Product>[];
    for (datos in datos) {
      register.add(Product.fromJson(datos));
    }

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
        logout();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Lista de usuarios')),
        body: GridView.count(
          padding: const EdgeInsets.all(10),
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          crossAxisCount: 2,
          children: List.generate(productss.length, (index) {
            return Card(
                margin: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Column(
                      children: const [
                        /*Image.network(productss[index].image!,
                              height: 90, fit: BoxFit.cover)*/
                        SizedBox(
                          height: 90,
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
                          productss[index].userName!,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway'),
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              productss[index].calification!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Raleway'),
                            ),
                            const SizedBox(
                              width: 85,
                            ),
                            IconButton(
                              icon: const Icon(Icons.star),
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
