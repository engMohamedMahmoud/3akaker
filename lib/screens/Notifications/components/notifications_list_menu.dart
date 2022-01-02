import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:aakaker/constants.dart';


import '../../../size_config.dart';

class NotificationsListMenu extends StatefulWidget {
  final List<String> titles;
  const NotificationsListMenu({Key key, @required this.titles}) : super(key: key);
  @override
  _NotificationsListMenuState createState() => _NotificationsListMenuState(titles);
}

class _NotificationsListMenuState extends State<NotificationsListMenu> {

  List<String> titles;
  _NotificationsListMenuState(this.titles);


  @override
  Widget build(BuildContext context) {
    return ListView.builder(

      itemBuilder: (context, index){
        return  titles.length != 0 ?
        Dismissible(
          key: Key(titles[index]),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            var item = titles.elementAt(index);
            titles.removeAt(index);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("${titles[index]} is deleted"),
            ));
          },
          background: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Color(0xFFFFE6E6),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Spacer(),
                SvgPicture.asset("assets/icons/Trash.svg"),
              ],
            ),
          ),
          child: Card( ////                         <-- Card widget
            child: ListTile(
              leading: (SvgPicture.asset("assets/icons/nav notification icon.svg")),
              title: Text(titles[index]),
              subtitle: Text("The body of the First element"),
              trailing: ClipOval(
                child: Material(
                  color: Colors.red, // button color
                  child: InkWell(
                    splashColor: Colors.red, // inkwell color
                    child: SizedBox(width: 7, height: 7, ),
                    onTap: () {


                    },
                  ),
                ),
              ),
              onTap: (){
                // showSnakeBar(context, "${titles[index]} is deleted");

              },

            ),
          ),
        ) :
        Container(
          child: Text("No Notifications"),
        )

        ;
      },
    );
  }

}
