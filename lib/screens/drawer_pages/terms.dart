import 'package:flutter/material.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 4, 78, 207),
        // ignore: prefer_const_constructors
        title: Text('Terms and conditions'),
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * .015),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                textAlign: TextAlign.justify,
                "Welcome to Cash Coach. These terms and conditions govern your use of the App. By using the App, you agree to be bound by these Terms. If you do not agree to these Terms, do not use the App.",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .015,
              ),
              const Text(
                textAlign: TextAlign.justify,
                "1. Use of App - You may use the App only for your personal, non-commercial use. You may not modify, copy, distribute, transmit, display, perform, reproduce, publish, license, create derivative works from, transfer, or sell any information, software, products or services obtained from the App.",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .015,
              ),
              const Text(
                textAlign: TextAlign.justify,
                "2. User Content - You may submit content, such as comments and feedback, to the App. By submitting User Content, you grant us a non-exclusive, perpetual, irrevocable, worldwide, royalty-free license to use, copy, modify, create derivative works from, distribute, transmit, display, and perform the User Content in all media now known or hereafter developed.",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .015,
              ),
              const Text(
                textAlign: TextAlign.justify,
                "3. Intellectual Property - The App and its content, including without limitation the text, software, scripts, graphics, photos, sounds, music, videos, interactive features and the like and the trademarks, service marks and logos contained therein, are owned by or licensed to us, subject to copyright and other intellectual property rights under United States and foreign laws and international conventions. Content on the App is provided to you for your information and personal use only and may not be used, copied, reproduced, distributed, transmitted, broadcast, displayed, sold, licensed, or otherwise exploited for any other purposes whatsoever without our prior written consent.",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .015,
              ),
              const Text(
                "We may terminate your access to and use of the App at any time and for any reason without",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }
}
