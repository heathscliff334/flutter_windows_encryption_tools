import 'dart:developer';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_encryption_app/src/blocs/encryption/cubit/encryption_cubit.dart';
import 'package:flutter_encryption_app/src/components/default_content_layout.dart';
import 'package:flutter_encryption_app/src/services/encryption/encryption_service.dart';
import 'package:flutter_encryption_app/src/views/encryption/home_view.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class DataView extends StatefulWidget {
  const DataView({super.key});

  @override
  State<DataView> createState() => _DataViewState();
}

class _DataViewState extends State<DataView> {
  final List<Data> values = <Data>[
    Data(label: '128 bit', value: 32),
    Data(label: '192 bit', value: 64),
    Data(label: '256 bit', value: 128),
  ];
  TextEditingController inputController = TextEditingController();
  TextEditingController secretKeyController = TextEditingController();
  TextEditingController outputController = TextEditingController();
  String? _secretKey;
  String? comboBoxValue;
  int? _textBoxLength;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EncryptionCubit, EncryptionState>(
      listener: (context, state) {
        if (state is EncryptionLoading) {
          log("State loading");
        } else if (state is EncryptionError) {
          log("State Error => ${state.error.message}");
        } else if (state is EncryptionDataGetSuccess) {
          log("State success");
          inspect(state);
          inputController.text = state.data;
        }
      },
      builder: (context, state) {
        return DefaultContentLayout(
            contentHeader: const Text(
              "Data",
              style: TextStyle(fontSize: 60),
            ),
            contentWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    FilledButton(
                      child: const Text('Fetch'),
                      onPressed: () {
                        context.read<EncryptionCubit>().getData();
                      },
                    ),
                    const SizedBox(width: 20),
                    Button(
                      child: const Text('Decrypt'),
                      onPressed: () {
                        //  String trimmedString = inputController.text
                        //       .toString()
                        //       .replaceAll(' ', '')
                        //       .replaceAll('\n', '');

                        //   debugPrint("remove space => $trimmedString");
                        //   var jsonData =
                        //       AppConfig.fromJsonString(trimmedString);

                        //   inspect(jsonData);

                        //   debugPrint(
                        //       "jsonData (appMinimumVersion) => ${jsonData.appMinimumVersion}");
                        final secretKey =
                            encrypt.Key.fromUtf8(secretKeyController.text);
                        String encryptionResult = EncryptionService()
                            .aesDecryption(inputController.text, secretKey,
                                bits: 16);
                        outputController.text = encryptionResult;
                      },
                    ),
                    const SizedBox(width: 20),
                    FilledButton(
                      child: const Text('Clear'),
                      onPressed: () {
                        inputController.clear();
                        outputController.clear();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text("Status => $state"),
                const SizedBox(height: 10),
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
                const SizedBox(height: 10),
                InfoLabel(
                  label: 'Secret-Key:',
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
                const SizedBox(height: 10),
                InfoLabel(
                  label: 'Encrypted Data:',
                  child: TextBox(
                    placeholder: 'Encrypted data result',
                    expands: false,
                    maxLines: null,
                    readOnly: true,
                    controller: inputController,
                  ),
                ),
                const SizedBox(height: 10),
                InfoLabel(
                  label: 'Plain-Text:',
                  child: TextBox(
                    placeholder: 'Decrypted Data Result (Plain-text)',
                    expands: false,
                    maxLines: null,
                    readOnly: true,
                    controller: outputController,
                  ),
                ),
              ],
            ));
      },
    );
  }
}
