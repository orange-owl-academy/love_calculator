import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController yourNameController = TextEditingController();
  final TextEditingController partnerNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _isCalculated = "";

  double calculateLove(String yourName, String partnerName) {
    //* Cumulative Sum of ASCII
    double partner1 = 0;
    double partner2 = 0;
    for (int i = 0; i < yourName.length; i++) {
      partner1 += yourName.codeUnitAt(i);
    }
    for (int i = 0; i < partnerName.length; i++) {
      partner2 += partnerName.codeUnitAt(i);
    }
    double value;
    if (partner1 > partner2) {
      value = (partner2 / partner1) * 100;
    } else {
      value = (partner1 / partner2) * 100;
    }

    return value;
  }

  @override
  void dispose() {
    yourNameController.dispose();
    partnerNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/back.jpg',
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: double.infinity),
                  const SizedBox(height: 20),
                  Text(
                    'Love Calculator',
                    style: TextStyle(
                      color: Colors.pink.shade400,
                      fontSize: 40,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: yourNameController,
                          onTap: () => setState(() {
                            _isCalculated = "";
                          }),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please input your name';
                            }
                            return null;
                          },
                          style: TextStyle(
                            color: Colors.pink.shade500,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.favorite),
                              prefixIconColor: Colors.pink,
                              labelText: 'Your Name',
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              )),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: partnerNameController,
                          onTap: () => setState(() {
                            _isCalculated = "";
                          }),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please input your partner\'s name';
                            }
                            return null;
                          }, //* regex
                          style: TextStyle(
                            color: Colors.pink.shade500,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.favorite),
                            prefixIconColor: Colors.pink,
                            labelText: 'Partner\'s Name',
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isCalculated = calculateLove(yourNameController.text, partnerNameController.text).toStringAsFixed(2);
                              FocusScope.of(context).unfocus();

                              yourNameController.clear();
                              partnerNameController.clear();
                              //* clear controllers
                            });
                          }
                        },
                        child: const Text(
                          'Calculate Love',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 40,
                          ),
                          elevation: 50,
                        ),
                      ),
                      const SizedBox(width: 25),
                      Offstage(
                        offstage: _isCalculated.isEmpty,
                        child: showResult(_isCalculated),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget showResult(String result) {
    return Center(
      child: Text(
        "$result 💞",
        style: const TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.bold,
          color: Colors.pink,
        ),
      ),
    );
  }
}
