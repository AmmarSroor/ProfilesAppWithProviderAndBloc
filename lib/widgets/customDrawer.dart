import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black,
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child: Image.asset('assets/images/itg.jpg',fit: BoxFit.fill,),
            ),
            ExpansionTile(
              title: Text('Location'),
              textColor: Colors.redAccent,
              iconColor: Colors.redAccent,
              children: [
                ListTile(
                  title: Text('Jabal Al Weibdeh,Amman-Jordan',),
                  //subtitle: Text('0781497808'),
                  leading: Icon(Icons.location_on,color: Colors.red,),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Contact us'),
              textColor: Colors.redAccent,
              iconColor: Colors.redAccent,
              children: [
                ListTile(
                  title: Text('Phone',),
                  subtitle: Text('06-1234567'),
                  leading: Icon(Icons.phone,color: Colors.green,),
                ),
                ListTile(
                  title: Text('Mobile',),
                  subtitle: Text('0777777777'),
                  leading: Icon(Icons.send_to_mobile,color: Colors.blue,),
                ),
                ListTile(
                  title: Text('E-mail',),
                  subtitle: Text('ammarabusroor@gmail.com'),
                  leading: Icon(Icons.email_outlined,color: Colors.red,),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
