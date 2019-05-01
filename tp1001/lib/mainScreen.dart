import 'package:flutter/material.dart';
import 'package:tp1001/api.dart';
import 'package:translator/translator.dart';
var l1,l2;
Future<String> results;
class mScreen extends StatelessWidget
{ TextEditingController inputTController=TextEditingController();
  //var l1,l2;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Abhivadin"),),
      body: Material(
        child: Container(
          padding: EdgeInsets.only(top:30.0),
          color: Colors.lightBlueAccent,
          child: Center(
            child: ListView(
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                   child:
                  dropDown(), 
                    ),
              //Expanded(
               // child: 
                   swapButton(),
                // ),
               Expanded(
                      child: 
                        dropDown2(), 
               ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left:10.0,right:10.0,bottom: 10.0,top:30.0),
              child:
            TextField(
              style: TextStyle(color: Colors.white),
              onSubmitted: (String userInput) async {
                   print(userInput);
                   print(l1);
                     print(l2);
                   results=(await convert1(userInput,l1,l2)) as Future<String>;  
              },
              controller: inputTController,
              decoration: InputDecoration(
                labelText: 'Enter text here',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
                ),
              ),
            ),
            ),
            Row(
              //mainAxisSize: MainAxisSize.min,
             // mainAxisAlignment: MainAxisAlignment.end,
               children: <Widget>[
                 Padding(
                   padding: EdgeInsets.only(top:30,left:10),
                   child:
                   Container(
                     child: RaisedButton(
                               child: Icon(Icons.mic,color: Colors.white,),
                              color: Colors.blue[400],
                              padding: EdgeInsets.all(0),
                              elevation: 10.0,
                              shape: CircleBorder(),
                              onPressed: ()=>micInp(context)
                           ),
                       width: 50.0,
                       height: 50.0,
                   ),
                 ),
                // Expanded(
                  // child: 
                   dropDown3(),
                 //),
               ],
            ),
            Container(
                             margin: EdgeInsets.only(left: 10.0,top: 30.0,right: 10.0),
                             
                             decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(5.0),
                         color: Colors.lightBlueAccent,
                         border: Border.all(
                                color: Colors.blue[400],
                                width: 2.0,
                                style: BorderStyle.solid,
                         ),
                         
                       ),
                       
                       width: 266.0,
                       height: 30.0,
                             child:
                             
                           Text(
                             "Suggested Translations:",
                             style: TextStyle(color: Colors.white,fontSize: 19.0,),
                             textAlign: TextAlign.center,
                        ),
                           ),
                    Container(
                      height: 30.0,
                       // child: 
                        //Text(
                         // result,
                        //),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void micInp(BuildContext context)
  {
    var alertDialog= AlertDialog(
            //title: Text("Languages swapped!!"),
            content: Text("Listening now!"),
    );
    showDialog(
            context: context,
            builder: (BuildContext context) => alertDialog
    );
  }
  Future<String> convert1(String input,String l1, String l2) async{
                   GoogleTranslator translator =GoogleTranslator();
                   //translator.translate(input, from: 'en', to: 'ru').then((s)
                   //{
                    // print(s);
                   //});
                   var translation = await translator.translate(input, from: l1, to: l2);
                   print(translation);
                   return
                     translation;
                   //results=translation as Future<String>;
                  }
}
class swapButtonImage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AssetImage assetImage = AssetImage('assests/icons/swap_horiz.png');
    Image image = Image(image: assetImage, height: 19.0,width: 19.0,);
    return Container(child: image,);
  }        
}
class swapButton extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        child: swapButtonImage(),
        color: Colors.blue[400],
        padding: EdgeInsets.all(0),
        elevation: 6.0,
        shape: CircleBorder(),
        onPressed: ()=>swapLan(context)
      ),
    );
  }

  void swapLan(BuildContext context)
  {
    var snackBar=SnackBar(
        content: Text("SWAPPED SUCCESSFULLY"),
        action: SnackBarAction(
          label: "UNDO",
          onPressed: (){
            debugPrint("Dummy undo");
          },
        ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
  
}
class dropDown extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return _dropDownState();
  }
}
class _dropDownState extends State<dropDown>
{
  var _languages=['Arabic','Bengali','Chinese Simplified','Chinese Traditional','Czech','English','Finnish','French','Gujarati',
                   'German','Hindi','Indonesian','Italian','Japanese','Korean','Portuguese','Russian','Spanish','Turkish','Urdu'];
  var _currentItemSelected = 'English';
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
             // Expanded(
               // child: 
              DropdownButton<String>(
                     items:_languages.map((String dropDownStringItem) {
                       _setFun(_currentItemSelected);
                       return DropdownMenuItem<String>(
                           value: dropDownStringItem,
                           
                           child:
                           Padding(
                             padding: EdgeInsets.only(left: 10.0),
                             child:
                           Container(
                             decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(5.0),
                         color: Colors.blue[400],
                       ),
                       
                       width: 102.0,
                             child:
                           Text(
                             dropDownStringItem,
                             style: TextStyle(color: Colors.white,fontSize: 20.0,),
                             textAlign: TextAlign.center,
                        ),
                           ),
                           ),
                       );
                     }).toList(),
                     onChanged: (String newValueSelected){
                       _onDropDownItemSelected(newValueSelected);
                       _setFun(_currentItemSelected);
                      // mScreen.l1=_currentItemSelected;
                     },
                     value: _currentItemSelected,
                     //mScreen.l1=_currentItemSelected;
            );       
      // );
  }
  void _onDropDownItemSelected(String newValueSelected)
  {
       setState(() {
                        this._currentItemSelected=newValueSelected; 
    });
  }
  void _setFun(var val)
  {
  var lanG=['Arabic','Bengali','Chinese Simplified','Chinese Traditional','Czech','English','Finnish','French','Gujarati',
                   'German','Hindi','Indonesian','Italian','Japanese','Korean','Portuguese','Russian','Spanish','Turkish','Urdu'];
  var lanC=['ar','bn','zh-CN','zh-TW','cs','en','fi','fr','gu','de','hi','id','it','ja','ko','pt','ru','es','tr','ur'];
  for(int i=0;i<lanG.length;i++)
  {
      if(val==lanG[i])
      {
        l1=lanC[i];
        break;
      }
  }
  }
}
class dropDown2 extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return _dropDownState2();
  }
}
class _dropDownState2 extends State<dropDown2>
{
  var _languages=['Arabic','Bengali','Chinese Simplified','Chinese Traditional','Czech','English','Finnish','French','Gujarati',
                   'German','Hindi','Indonesian','Italian','Japanese','Korean','Portuguese','Russian','Spanish','Turkish','Urdu'];
  var _currentItemSelected = 'English';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
             // Expanded(
               // child: 
              DropdownButton<String>(
                     items:_languages.map((String dropDownStringItem) {
                       _setFun(_currentItemSelected);
                       return DropdownMenuItem<String>(
                           value: dropDownStringItem,
                           
                           child:
                           Padding(
                             padding: EdgeInsets.only(left: 10.0),
                             child:
                           Container(
                             decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(5.0),
                         color: Colors.blue[400],
                       ),
                       
                       width: 102.0,
                             child:
                           Text(
                             dropDownStringItem,
                             style: TextStyle(color: Colors.white,fontSize: 20.0,),
                             textAlign: TextAlign.center,
                        ),
                           ),
                           ),
                       );
                     }).toList(),
                     onChanged: (String newValueSelected){
                       _onDropDownItemSelected(newValueSelected);
                       _setFun(_currentItemSelected);
                     },
                     value: _currentItemSelected,
                     
            );       
      // );
  }
  void _onDropDownItemSelected(String newValueSelected)
  {
       setState(() {
                        this._currentItemSelected=newValueSelected; 
    });
  }
  void _setFun(var val)
  {
  var lanG=['Arabic','Bengali','Chinese Simplified','Chinese Traditional','Czech','English','Finnish','French','Gujarati',
                   'German','Hindi','Indonesian','Italian','Japanese','Korean','Portuguese','Russian','Spanish','Turkish','Urdu'];
  var lanC=['ar','bn','zh-CN','zh-TW','cs','en','fi','fr','gu','de','hi','id','it','ja','ko','pt','ru','es','tr','ur'];
  for(int i=0;i<lanG.length;i++)
  {
      if(val==lanG[i])
      {
        l2=lanC[i];
        break;
      }
  }
  }
}
class dropDown3 extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return _dropDownState3();
  }
}
class _dropDownState3 extends State<dropDown3>
{
  var _languages=['😃 Grinning Face With Big Eyes','😆 Grinning Squinting Face','😅 Grinning Face With Sweat',
                  '😂 Face With Tears of Joy','🙂 Slightly Smiling Face','😍 Smiling Face & Heart-Eyes','😘 Face Blowing a Kiss',
                   '🤩 Star-Struck','😐 Neutral Face','😑 Expressionless Face','😶 Face Without Mouth','🙄 Face With Rolling Eyes',
                   '😋 Face Savoring Food','😔 Pensive Face','😟 Worried Face','😮 Face With Open Mouth','😨 Fearful Face',
                   '😢 Crying Face','😠 Angry Face'];
  var _currentItemSelected = '🙂 Slightly Smiling Face';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
              DropdownButton<String>(
                     items:_languages.map((String dropDownStringItem) {
                       return DropdownMenuItem<String>(
                           value: dropDownStringItem,
                           child:
                          // Padding(
                            // padding: EdgeInsets.only(left: 10.0,top: 0.0),
                             //child:
                           Container(
                             margin: EdgeInsets.only(left: 10.0,top: 5.0),
                             decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(5.0),
                         color: Colors.blue[400],
                       ),
                       
                       width: 266.0,
                       height: 25.0,
                             child:
                           Text(
                             dropDownStringItem,
                             style: TextStyle(color: Colors.white,fontSize: 19.0,),
                             textAlign: TextAlign.center,
                        ),
                           ),
                          // ),
                       );
                     }).toList(),
                     onChanged: (String newValueSelected){
                       _onDropDownItemSelected(newValueSelected);
                       
                     },
                     value: _currentItemSelected,
                     
            );       
      // );
  }
  void _onDropDownItemSelected(String newValueSelected)
  {
       setState(() {
                        this._currentItemSelected=newValueSelected; 
    });
  }
}
/*
class resultList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return resultListState;
  }
}
class resultListState extends State<resultList>{
  int count=0;
  @override
  Widget build(BuildContext context) {
    return ListView getListView(){
      return
       ListView.builder(
          itemCount: count,
          itemBuilder: (BuildContext context,int position){
            return Card(
                color: Colors.white,
                elevation: 8.0,
                child: ListTile(
                  leading: Icon(Icons.chevron_right),
                  title: Text(result),
                  trailing: GestureDetector(
                      child:Icon(Icons.arrow_upward),
                      onTap:(){}
                  ),
                  onTap: (){
                    debugPrint("List Tapped");
                  }
                ),
            );
          },
      );
    };
  }
}
*/