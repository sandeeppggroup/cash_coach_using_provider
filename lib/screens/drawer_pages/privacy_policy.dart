import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 4, 78, 207),
        title: const Text('Privacy Policy'),
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * .015),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                textAlign: TextAlign.justify,
                "Cash Coach is committed to protecting the privacy of our users. This Privacy Policy explains how we collect, use, disclose, and protect your personal information when you use our mobile application.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              const Text(
                textAlign: TextAlign.justify,
                "1. Information We Collect - We collect information that you provide to us directly through the App, such as your name, email address, and financial information. We may also collect information about your use of the App, such as your device type, operating system, IP address, and mobile carrier.",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .015,
              ),
              const Text(
                textAlign: TextAlign.justify,
                "2. Use of Information - We use your personal information to provide and improve the App, to communicate with you, to customize your experience, and to fulfill your requests. We may also use your information to send you marketing communications and to conduct research and analysis.",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .015,
              ),
              const Text(
                textAlign: TextAlign.justify,
                "3. Disclosure of Information - We may disclose your personal information to third parties, such as service providers, advertisers, and business partners, for the purposes described in this Privacy Policy. We may also disclose your information if required by law or in response to a court order or subpoena.",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .015,
              ),
              const Text(
                textAlign: TextAlign.justify,
                "4. Security - We take reasonable measures to protect your personal information from unauthorized access, disclosure, alteration, and destruction. However, no method of transmission over the internet or electronic storage is completely secure, so we cannot guarantee absolute security.",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .015,
              ),
              const Text(
                textAlign: TextAlign.justify,
                "5. Changes to this Privacy Policy - We may update this Privacy Policy from time to time by posting a new version on our website or within the App. You should check this page periodically to ensure that you are aware of any changes.",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
              ),
              RichText(
                text: TextSpan(
                  text:
                      'Contact Us - If you have any questions or concerns about this Privacy Policy or our privacy practices, please contact us at',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' support@cashcoach.com',
                      style: TextStyle(
                          color: Colors.blue.shade800,
                          fontStyle: FontStyle.italic,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
