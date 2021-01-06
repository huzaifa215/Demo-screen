

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/authentication.dart';

import 'UploadImage.dart';
import 'home_screen.dart';
import 'login_screen.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  static const routeName = '/home';
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _passwordController = new TextEditingController();

  Map<String, String> _authData = {
    'gender' : '',
    'dateofbirth' : '',
    'favouritedish' :'',
    'favouritesoccerteam':''
  };

  void _showErrorDialog(String msg)
  {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An Error Occured'),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: (){
                Navigator.of(ctx).pop();
              },
            )
          ],
        )
    );
  }

  Future<void> _submit() async
  {
    if(!_formKey.currentState.validate())
    {
      return;
    }
    _formKey.currentState.save();

    try{
      await Provider.of<Authentication>(context, listen: false).dataemtry(
          _authData['gender'],
          _authData['dateofbirth'],
          _authData['favouritedish'],
          _authData['favouritesoccerteam'],

      );
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);

    } catch(error)
    {
      var errorMessage = 'Authentication Failed. Please try again later.';
      _showErrorDialog(errorMessage);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Entry'),

      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.grey,
                      Colors.grey,
                    ]
                )
            ),
          ),
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                height: 450,
                width: 310,
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        //email
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Gender'),
                          keyboardType: TextInputType.emailAddress,

                          onSaved: (value)
                          {
                            _authData['gender'] = value;
                          },
                        ),

                        TextFormField(
                          decoration: InputDecoration(labelText: 'Date Of Birth'),
                          keyboardType: TextInputType.text,
                          validator: (value)
                          {
                            if(value.isEmpty || !value.contains('-'))
                            {
                              return 'invalid email';
                            }
                            return null;
                          },
                          onSaved: (value)
                          {
                            _authData['dateofbirth'] = value;
                          },
                        ),


                        TextFormField(
                          decoration: InputDecoration(labelText: 'Favourite dish '),
                          keyboardType: TextInputType.text,

                          onSaved: (value)
                          {
                            _authData['favouritedish'] = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Favourite soccer Team'),
                          keyboardType: TextInputType.text,

                          onSaved: (value)
                          {
                            _authData['favouritesoccerteam'] = value;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          child: Text(
                              'Upload Image'
                          ),
                          onPressed: ()
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                 return UploadingImageToFirebaseStorage();
                                },
                              ),
                            );
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          color: Colors.blue,
                          textColor: Colors.white,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        RaisedButton(
                          child: Text(
                              'Submit'
                          ),
                          onPressed: ()
                          {
                            _submit();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          color: Colors.blue,
                          textColor: Colors.white,
                        ),


                      ],
                    ),
                  ),
                ),

              ),
            ),
          )

        ],
      ),
    );
  }
}

