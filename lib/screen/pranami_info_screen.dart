import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sammilani_delegate/firebase/firebase_remote_config.dart';
import 'package:sammilani_delegate/home_page/home_page.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';
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
                  launchUrlString(
                      "tel:+91${RemoteConfigHelper().paymentContact}");
                },
                child: Card(
                  color: Colors.deepOrange,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Text(
                          "Call - ${RemoteConfigHelper().getPaymentContact} ",
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
            ],
          ),
        ),
      ),
    );
  }
}
