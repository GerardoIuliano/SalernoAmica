import 'package:flutter/material.dart';
import 'package:frontend_sws/main.dart';
import 'package:getwidget/getwidget.dart';

class Events extends StatelessWidget {
  const Events({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>['Mensa', 'Potito'];

    return Scaffold(
      appBar: GFAppBar(
        leading: GFIconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {},
          type: GFButtonType.transparent,
        ),
        searchBar: true,
        backgroundColor: appTheme.primaryColor,
        title: const Text("Sezione Eventi"),
        actions: <Widget>[
          GFIconButton(
            icon: const Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            onPressed: () {},
            type: GFButtonType.transparent,
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(top: 18, bottom: 18),
                  child: Text(
                    "Filtra per:",
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(12),
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                return GFCard(
                  color: Colors.white,
                  boxFit: BoxFit.cover,
                  titlePosition: GFPosition.start,
                  elevation: 5,
                  borderOnForeground: true,
                  image: Image.asset(
                    'assets/images/servizi-sociali.jpg',
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  showImage: true,
                  title: GFListTile(
                    avatar: const GFAvatar(
                      backgroundImage: AssetImage('assets/images/logo.png'),
                    ),
                    titleText: 'Evento ${entries[index]}',
                    subTitleText: 'Nome Ente',
                  ),
                  content: const Text("Descrizione evento"),
                  buttonBar: const GFButtonBar(
                    children: <Widget>[
                      GFAvatar(
                        backgroundColor: GFColors.PRIMARY,
                        child: Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                      ),
                      GFAvatar(
                        backgroundColor: GFColors.SECONDARY,
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                      GFAvatar(
                        backgroundColor: GFColors.SUCCESS,
                        child: Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          ],
        ),
      ),
    );
  }
}
