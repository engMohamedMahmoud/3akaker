import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


import '../../../size_config.dart';


class Body extends StatelessWidget {
  @override

  final List<String> titles;
  const Body({Key key, @required this.titles}) : super(key: key);



  Widget build(BuildContext context) {
    return _myListView(context);
  }



  // get data from api
  // List<String> getDataSource(){
  //   var titles = List<String>.generate(100, (index) => "Item ${index + 1}");
  //   return titles;
  // }

  Widget _myListView(BuildContext context) {

    // var titles = getDataSource();
    var listView = ListView.builder(


      itemBuilder: (context, index){
        return  titles.length > 0 ?
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
            // padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Color(0xFFFFE6E6),
              borderRadius: BorderRadius.circular(15),
              border: Border(bottom: BorderSide(color: Colors.black,width: 0.5))
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
        Center(
              child: Text("No Notifications"),
            )

          ;
      },
    );
    return listView;
  }

}


