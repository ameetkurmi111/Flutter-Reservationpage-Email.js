import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Reservation',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const ReservationPage(),
    );
  }
}



class ReservationPage extends StatefulWidget {
  const ReservationPage({Key? key}) : super(key: key);

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  final phoneController = TextEditingController();

  final guestController = TextEditingController();

  final nameController = TextEditingController();
  final surnameController = TextEditingController();

  final emailController = TextEditingController();

  final messageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    dateController.dispose();
    timeController.dispose();
    guestController.dispose();
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    messageController.dispose();
  }

  Future<void> selectTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        timeController.text = pickedTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffffffff),
        title: const Text(
          'Reservation',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xffA80000),
          ),
        ),
      ),
      backgroundColor: const Color(0xfff5f5fd),
      body: SingleChildScrollView(
        child: Center(
          child: Container( 
            height: MediaQuery.of(context).size.height * 1.5,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 5),
                      blurRadius: 10,
                      spreadRadius: 1,
                      color: Colors.grey[300]!)
                ]),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //date
                  const Row(
                    children: [
                      Text(
                        'Date',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffA80000),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: dateController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffA80000), width: 1),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                    onTap: () async {
                      FocusScope.of(context)
                          .requestFocus(FocusNode()); // Hide the keyboard
                      var selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      if (selectedDate != null) {
                        var formattedDate =
                            DateFormat('yyyy-MM-dd').format(selectedDate);
                        dateController.text = formattedDate;
                      }
                    },
                  ),
                  const Row(
                    children: [
                      Text(
                        'Time',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffA80000),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: timeController,
                    onTap: selectTime,
                    readOnly: true,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffA80000), width: 1),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                  ),
                  const Row(
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffA80000),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffA80000), width: 1),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                  ),
                  const Row(
                    children: [
                      Text(
                        'Surname',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffA80000),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: surnameController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffA80000), width: 1),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                  ),
                  const Row(
                    children: [
                      Text(
                        'Number of guests',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffA80000),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: guestController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffA80000), width: 1),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                  ),
                  const Row(
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffA80000),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffA80000), width: 1),
                      ),
                    ),
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return 'Required*';
                      } else if (!EmailValidator.validate(email)) {
                        return 'Please enter a valid Email';
                      }
                      return null;
                    },
                  ),
                  const Row(
                    children: [
                      Text(
                        'Phone Number',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffA80000),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffA80000), width: 1),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                  ),
                  const Row(
                    children: [
                      Text(
                        'Additional information',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffA80000),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffA80000), width: 1),
                      ),
                    ),
                    maxLines: 1,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    height: 45,
                    width: 110,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xffA80000),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40))),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final response = await sendEmail(
                              dateController.value.text,
                              timeController.value.text,
                              guestController.value.text,
                              nameController.value.text,
                              surnameController.value.text,
                              emailController.value.text,
                              phoneController.value.text,
                              messageController.value.text);

                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            response == 200
                                ? const SnackBar(
                                    content: Text('Message Sent!'),
                                    backgroundColor: Colors.green)
                                : const SnackBar(
                                    content: Text('Failed to send message!'),
                                    backgroundColor: Colors.red),
                          );
                          dateController.clear();
                          timeController.clear();
                          nameController.clear();
                          surnameController.clear();
                          guestController.clear();
                          emailController.clear();
                          phoneController.clear();
                          messageController.clear();
                        }
                      },
                      child: const Text('Send', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future sendEmail(String date, String time, String guests, String name,
    String surname, String email, String phone, String message) async {
  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  const serviceId = 'service_2vncsxo';
  const templateId = 'template_f381578';
  const userId = 'xqli5_ApQQpgdDJF_';
  final response = await http.post(url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json'
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'date_time': date,
          'booking_time': time,
          'guest_number': guests,
          'from_name': name,
          'from_surname': surname,
          'from_email': email,
          'from_phone': phone,
          'message': message
        }
      }));
  return response.statusCode;
}
