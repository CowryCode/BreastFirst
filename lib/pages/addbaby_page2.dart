import 'package:breastfirst/api/model/babydata.dart';
import 'package:breastfirst/pages/addbaby_page1.dart';
import 'package:breastfirst/statemanagement/valuenotifiers/NotifierCentral.dart';
import 'package:flutter/material.dart';

class AddBabyDetailsPage extends StatefulWidget {
  @override
  _AddBabyDetailsPageState createState() => _AddBabyDetailsPageState();
}

class _AddBabyDetailsPageState extends State<AddBabyDetailsPage> {
  TextEditingController _nameController = TextEditingController();
  late DateTime selectedDate = DateTime.now();
  late TimeOfDay selectedTime = TimeOfDay.now();
  String? gender;

  BabyData babyData = BabyData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
        actions: [Icon(Icons.more_vert)],  // placeholder for the dots in the top right
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Let's add your baby!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                    onTap: () {
                      print('Button tapped!');
                      babyData.setGender(gender: "Girl");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.star, color: Colors.pink, size: 100),
                        SizedBox(width: 2),  // Add some spacing between the icon and the text
                        Text('Girl'),
                      ],
                    ),
                  ),
                Text('or'),
                InkWell(
                  onTap: () {
                    print('Button tapped!');
                    babyData.setGender(gender: "Boy");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.star, color: Colors.blue, size: 100),
                      SizedBox(width: 2),  // Add some spacing between the icon and the text
                      Text('Boy'),
                    ],
                  ),
                ),
              ],
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Baby's name",
                border: OutlineInputBorder(),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        setState(() {
                          selectedDate = date;
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(selectedDate == null ? 'Date' : selectedDate.toLocal().toString().split(' ')[0]),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null) {
                        setState(() {
                          selectedTime = time;
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(selectedTime == null ? 'Time' : selectedTime.format(context)),
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // Handle continue button press
                if(_submitAction() == true){
                   Navigator.push(context, MaterialPageRoute(builder: (context) => AddBabyPage(isSignUp: true,)),);
                }else{
                  _showSnackBar(context);
                }
              },
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }


  bool _submitAction(){
    print('Gender : ${babyData.gender}');
    print('Name : ${_nameController.text.toString()}');
    print('Date : ${selectedDate.toString()}');
    print('Time : ${selectedTime.toString()}');

    if(babyData.gender == null || _nameController.text.isEmpty){
      return false;
    }else{
      babyData.setBabyname(babyname: _nameController.text.toString());
      babyData.setBirthDate(birthDate: selectedDate.toString());
      babyData.setBirthTime(birthTime: selectedTime.toString());
      babyDataNotifier.updateBabyDataNotifier(babydata: babyData);
      return true;
    }
  }

  void _showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text('Select gender and add baby name'),
      action: SnackBarAction(
        label: 'Warning',
        onPressed: () {
          // Perform some action when the "Close" button is pressed.
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}