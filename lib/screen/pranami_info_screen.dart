import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sammilani_delegate/firebase/firebase_remote_config.dart';
import 'package:sammilani_delegate/home_page/home_page.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PranamiInfoScreen extends StatefulWidget {
  const PranamiInfoScreen({super.key});

  @override
  State<PranamiInfoScreen> createState() => _PranamiInfoScreenState();
}

void copyToClipboard(BuildContext context, String text) {
  Clipboard.setData(ClipboardData(text: text));
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text('Copied to Clipboard'),
  ));
}

class _PranamiInfoScreenState extends State<PranamiInfoScreen> {
  void _launchWhatsApp() async {
    String phoneNumber = RemoteConfigHelper().getPaymentContact;

    if (phoneNumber.isNotEmpty) {
      String whatsappUrl = "https://wa.me/+91$phoneNumber";

      // ignore: deprecated_member_use
      if (await canLaunch(whatsappUrl)) {
        // ignore: deprecated_member_use
        await launch(whatsappUrl);
      } else {
        print("Failed to launch WhatsApp.");
      }
    } else {
      print("Invalid phone number.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ScaffoldBackgroundColor,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: IconButtonColor),
        backgroundColor: AppBarColor,
        elevation: .5,
        title: Text('Delegate Pranami Info'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Text(
                        RemoteConfigHelper().getPaymentMessage,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _launchWhatsApp();
                },
                child: Card(
                  color: Colors.deepOrange,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Text(
                          "Whatsapp - ${RemoteConfigHelper().getPaymentContact} ",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              "Upi id:  ${RemoteConfigHelper().getUpiId}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              onPressed: () {
                                // Call a function to copy text to clipboard
                                copyToClipboard(
                                    context, RemoteConfigHelper().getUpiId);
                              },
                              icon: Icon(Icons.copy),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 370,
                  height: 400,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8.0), // Adjust the radius as needed
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          15.0), // Match the Card's borderRadius
                      child: Image.asset(
                        'assets/images/upi.jpeg',
                        width: 375,
                        height: 375,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                thickness: 2,
              ),
              SizedBox(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              "Bank Name:  ${RemoteConfigHelper().getBankName}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              onPressed: () {
                                // Call a function to copy text to clipboard
                                copyToClipboard(
                                    context, RemoteConfigHelper().getBankName);
                              },
                              icon: Icon(Icons.copy),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              "A/C No: ${RemoteConfigHelper().getBankAccountNo}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              onPressed: () {
                                // Call a function to copy text to clipboard
                                copyToClipboard(context,
                                    RemoteConfigHelper().getBankAccountNo);
                              },
                              icon: Icon(Icons.copy),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(
                            "Ifsc Code:${RemoteConfigHelper().getBankIfscCode}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            onPressed: () {
                              // Call a function to copy text to clipboard
                              copyToClipboard(context,
                                  RemoteConfigHelper().getBankIfscCode);
                            },
                            icon: Icon(Icons.copy),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(
                            "Branch: ${RemoteConfigHelper().getBranchName} ",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            onPressed: () {
                              // Call a function to copy text to clipboard
                              copyToClipboard(
                                  context, RemoteConfigHelper().getBranchName);
                            },
                            icon: Icon(Icons.copy),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(
                            "Branch: ${RemoteConfigHelper().getBranchName} ",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            onPressed: () {
                              // Call a function to copy text to clipboard
                              copyToClipboard(
                                  context, RemoteConfigHelper().getBranchName);
                            },
                            icon: Icon(Icons.copy),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
