import 'package:parcial/exports.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isRememberMe = false;
  /* ===============WIDGET'S===================== */
  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Correo electronico',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              const BoxShadow(
                  color: Colors.black38, blurRadius: 5, offset: Offset(0, 2)),
            ],
          ),
          height: 60,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 15),
                prefixIcon: Icon(Icons.email, color: HexColor('#E64A19')),
                hintText: 'Dirección de correo',
                hintStyle: TextStyle(color: HexColor('#212121'))),
          ),
        )
      ],
    );
  }

  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Contreña',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              const BoxShadow(
                  color: Colors.black38, blurRadius: 5, offset: Offset(0, 2)),
            ],
          ),
          height: 60,
          child: TextField(
            obscureText: true,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 15),
                prefixIcon: Icon(Icons.lock, color: HexColor('#E64A19')),
                hintText: 'Contraseña',
                hintStyle: TextStyle(color: HexColor('#212121'))),
          ),
        )
      ],
    );
  }

  Widget buildBtnLogin() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 25),
    width: double.infinity,
    child: ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        minimumSize:
            MaterialStateProperty.all<Size>(const Size(double.infinity, 50)),
        backgroundColor: MaterialStateProperty.all<Color>(HexColor('#E64A19')),
      ),
      onPressed: () {
         Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
      },
      child: const Text(
        'Ingresar',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18
        ),
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/fondo.jpg'), fit: BoxFit.cover),
                ),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 45,
                    vertical: 90,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Inicio de Sesión',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Open Sans'),
                      ),
                      const SizedBox(height: 48),
                      buildEmail(),
                      const SizedBox(height: 48),
                      buildPassword(),
                      const SizedBox(height: 25),
                      buildBtnLogin(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
