import '../exports.dart';

class ButtonFavorite extends StatefulWidget{
  String? idOffer;

  ButtonFavorite({super.key, this.idOffer});
  
  @override
  State<ButtonFavorite> createState() => _ButtonFavoriteState();
}

class _ButtonFavoriteState extends State<ButtonFavorite> {

  Color heartColor = Colors.blueGrey;

  addFavorite(String idOffer) async {
    String idUser = SharedService.prefs.getString('id') ?? 'default';
    if(idUser == 'default' || idOffer == 'default'){
      return;
    }
    int success = await APIService.addFavorite(idUser, idOffer);
    if(success == 0){
      setState(() {
        heartColor = Colors.red;
      });
    }else if(success == 1){
      setState(() {
        heartColor = Colors.blueGrey;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
                                  onPressed: () => addFavorite(widget.idOffer ?? 'default'),
                                  icon: const Icon(Icons.favorite),
                                  color: heartColor,
                                  padding: const EdgeInsets.only(left: 0),
                                  alignment: Alignment.centerLeft,
                                );
  }

}