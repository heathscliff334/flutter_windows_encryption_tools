import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_encryption_app/src/components/custom_validator_message.dart';
import 'package:flutter_encryption_app/src/components/default_content_layout.dart';
import 'package:flutter_encryption_app/src/models/app_config_model.dart';
import 'package:flutter_encryption_app/src/res/colors.dart';
import 'package:flutter_encryption_app/src/services/encryption/encryption_service.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart' as material;

class EncryptionView extends StatefulWidget {
  const EncryptionView({Key? key}) : super(key: key);

  @override
  State<EncryptionView> createState() => _EncryptionViewState();
}

class _EncryptionViewState extends State<EncryptionView>
    with AutomaticKeepAliveClientMixin<EncryptionView> {
  @override
  bool get wantKeepAlive => true;
  String selectedColor = 'Green';
  String? _secretKey, _plainText;
  String filePath = '/config.json';
  // File? configFile;

  TextEditingController inputController = TextEditingController();
  TextEditingController secretKeyController = TextEditingController();
  TextEditingController outputController = TextEditingController();

  final List<Data> values = <Data>[
    Data(label: '128 bit', value: 32),
    Data(label: '192 bit', value: 64),
    Data(label: '256 bit', value: 128),
  ];
  String? comboBoxValue;
  int? _textBoxLength;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultContentLayout(
      contentHeader: const Text(
        "Encryption",
        style: TextStyle(fontSize: 60),
      ),
      contentWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          InfoLabel(
            label: 'Key Type:',
            child: SizedBox(
              width: 200,
              child: ComboBox<String>(
                placeholder: const Text('Selected secret key type'),
                isExpanded: true,
                items: values
                    .map((Data data) => ComboBoxItem<String>(
                          value: data.value.toString(),
                          child: Text(data.label.toString()),
                        ))
                    .toList(),
                value: comboBoxValue,
                onChanged: (value) {
                  // debugPrint(value);
                  if (value != null) {
                    setState(() => {
                          comboBoxValue = value,
                          _textBoxLength = int.parse(comboBoxValue!)
                        });
                  }
                },
              ),
            ),
          ),
          InfoLabel(
            label: 'Secret-Key:',
            child: Row(
              children: [
                Expanded(
                  child: TextBox(
                    placeholder: 'Enter your secret key',
                    expands: false,
                    enabled: _textBoxLength == null ? false : true,
                    maxLength: _textBoxLength,
                    controller: secretKeyController,
                    onChanged: (value) =>
                        setState(() => _secretKey = secretKeyController.text),
                  ),
                ),
                const SizedBox(width: 5),
                Button(
                  child: const Icon(material.Icons.add_rounded),
                  onPressed: () => showContentDialog(context),
                )
              ],
            ),
          ),
          CustomValidatorMessage(
              visibility: _secretKey != null && _secretKey != "" ? true : false,
              errorMsg: "Secret-key length: ${_secretKey?.length}",
              textColor: descriptionFontColor),
          const SizedBox(height: 10),
          InfoLabel(
            label: 'Plain-Text:',
            child: TextBox(
              placeholder: 'Enter your Plain-text',
              expands: false,
              maxLines: null,
              controller: inputController,
              onChanged: (value) =>
                  setState(() => _plainText = inputController.text),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              FilledButton(
                  onPressed: (_plainText == null && _secretKey == null)
                      ? null
                      : () {
                          String trimmedString = inputController.text
                              .toString()
                              .replaceAll(' ', '')
                              .replaceAll('\n', '');
                          debugPrint("remove space => $trimmedString");
                          // var jsonData =
                          //     AppConfig.fromJsonString(trimmedString);

                          // inspect(jsonData);

                          // debugPrint(
                          //     "jsonData (appMinimumVersion) => ${jsonData.appMinimumVersion}");
                          final secretKey =
                              encrypt.Key.fromUtf8(secretKeyController.text);
                          String encryptionResult = EncryptionService()
                              .aesEncryption(trimmedString, secretKey,
                                  bits: 16);
                          outputController.text = encryptionResult;
                        },
                  child: const Text("Encrypt")),
              const SizedBox(width: 20),
              FilledButton(
                  onPressed: (_plainText == null && _secretKey == null)
                      ? null
                      : () async {
                          try {
                            var result = await FilePicker.platform
                                .saveFile(fileName: 'config.hcplusMoba');
                            log(result.toString());
                            if (result != null) {
                              File configFile = File(result);
                              String configJson =
                                  jsonEncode(outputController.text);
                              await configFile.writeAsString(configJson);
                              debugPrint(
                                  'config.json file generated and saved.');
                            } else {
                              debugPrint('No file selected by the user.');
                            }
                          } catch (e) {
                            debugPrint(
                                'Error generating or saving config.json file: $e');
                          }
                        },
                  child: const Text("Export")),
            ],
          ),
          const SizedBox(height: 10),
          InfoLabel(
            label: 'Output:',
            child: TextBox(
              placeholder: 'Your encryption output',
              expands: false,
              readOnly: true,
              maxLines: 5,
              controller: outputController,
            ),
          ),
        ],
      ),
    );
  }

  void showContentDialog(BuildContext context) async {
    TextEditingController keyLabel = TextEditingController();
    TextEditingController keySecret = TextEditingController();
    ContentDialog dialog = ContentDialog(
      title: const Text('Add New Key'),
      content: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InfoLabel(
              label: 'Label:',
              child: TextBox(
                placeholder: 'Enter your label',
                expands: false,
                controller: keyLabel,
              ),
            ),
            InfoLabel(
              label: 'Secret-Key:',
              child: TextBox(
                placeholder: 'Enter your secret key',
                expands: false,
                controller: keySecret,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Button(
          child: const Text('Save'),
          onPressed: () {
            Navigator.pop(context, 'User save file');
            // Delete file here
          },
        ),
        FilledButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context, 'User canceled dialog'),
        ),
      ],
    );
    showDialog<String>(context: context, builder: (context) => dialog)
        .then((value) => null);
    setState(() {});
  }
}

class Data {
  String? label;
  int? value;
  Data({this.label, this.value});
}
