import 'dart:convert';
import 'package:parcial/exports.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /* ==================Functions================= */

  int _currentIndex = 0;
  void logout() async {
    SharedService.prefs.clear();
    Navigator.pushNamed(context, '/login');
  }

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
  void initState() {
    super.initState();
    getProducts().then((value) {
      setState(() {
        productss.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de productos'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
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
                              Image.network(productss[index].image!,
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
                                  productss[index].userName!,
                                  style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'Raleway'),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  productss[index].calification!,
                                  style: const TextStyle(fontFamily: 'Raleway'),
                                ),
                                const SizedBox(height: 8),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.star),
                                  color: Colors.blueGrey,
                                  padding: const EdgeInsets.only(left: 0),
                                  alignment: Alignment.centerLeft,
                                )
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
    );
  }
}
