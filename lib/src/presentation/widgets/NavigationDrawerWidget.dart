import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mapata/src/data/util/Constants.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 10);
  final headerImage =
      "https://cdn0.iconfinder.com/data/icons/creatype-pet-shop-glyph/64/1_pin_gps_paw_pet_animal_map-512.png";

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Drawer(
      child: Material(
        color: Colors.redAccent,
        child: ListView(
          padding: padding,
          children: <Widget>[
            const SizedBox(
              height: 48,
            ),
            _buildHeader(
                title: kAppTitle,
                subtitle: locale.ndw_subtitle,
                image: headerImage,),
            Divider(
              color: Colors.white,
              height: 1,
            ),
            _buildMenuItem(
                text: locale.ndw_about,
                icon: Ionicons.list_circle,
                onClicked: () => selectedItem(context, 0)),
            const SizedBox(
              height: 12,
            ),
            Divider(
              color: Colors.white,
              height: 1,
            ),
            const SizedBox(
              height: 12,
            ),
            _buildMenuItem(
                text: locale.ndw_coming_soon, icon: Ionicons.code, onClicked: () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
      {required String text, required IconData icon, VoidCallback? onClicked}) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: TextStyle(color: color),
      ),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  selectedItem(BuildContext context, int index) {
    /*Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.pushNamed(context, kRouteHome);
        break;
      case 1:
        Navigator.pushNamed(context, kStoreDataView);
        break;
      case 2:
        Navigator.pushNamed(context, kLeagueView);
        break;
      case 3:
        Navigator.pushNamed(context, kStoresMapView);
        break;*/
    }

  Widget _buildHeader(
          {required String title,
          required String image,
          required String subtitle}) =>
      InkWell(
          onTap: () {},
          child: Container(
            padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(image),
                  backgroundColor: Colors.white,
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70),
                    ),
                  ],
                )
              ],
            ),
          ));
}