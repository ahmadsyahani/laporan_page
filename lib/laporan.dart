import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Laporan extends StatefulWidget {
  const Laporan({Key? key}) : super(key: key);

  @override
  State<Laporan> createState() => _LaporanState();
}

class _LaporanState extends State<Laporan> {
  File? imageFile;

  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Laporan"),
        leading: BackButton(),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // IF
                if (imageFile != null)
                  Container(
                    width: 450,
                    height: 250,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      image: DecorationImage(
                          image: FileImage(imageFile!), fit: BoxFit.cover),
                      border: Border.all(
                        color: Colors.black12,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  )

                // ELSE
                else
                  Container(
                    width: 450,
                    height: 250,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(
                        color: Colors.black12,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(
                            Icons.perm_media_rounded,
                            size: 35,
                          ),
                          onPressed: () =>
                              getImage(source: ImageSource.gallery),
                        ),
                        Text("Silahkan Pilih Foto")
                      ],
                    ),
                  ),

                SizedBox(
                  height: 12,
                ),

                // Row(
                //   children: [
                //     Expanded(
                //       child: ElevatedButton(
                //         onPressed: () => getImage(source: ImageSource.camera),
                //         child: const Text(
                //           "Kamera",
                //           style: TextStyle(fontSize: 16),
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       width: 20,
                //     ),
                //     Expanded(
                //       child: ElevatedButton(
                //         onPressed: () => getImage(source: ImageSource.gallery),
                //         child: const Text(
                //           "Galeri",
                //           style: TextStyle(fontSize: 16),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),

                SizedBox(
                  height: 8,
                ),

                Form(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _namapelapor(),
                        const SizedBox(
                          height: 15,
                        ),
                        _teleponpelapor(),
                        const SizedBox(
                          height: 15,
                        ),
                        _lokasikejaidan(),
                        const SizedBox(
                          height: 15,
                        ),
                        _tanggalkejadian(),
                        const SizedBox(
                          height: 15,
                        ),
                        _deskripsilaporan(),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(Icons.send_rounded),
                      label: Text("Submit"),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        fixedSize: const Size(140, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(
        source: source, maxHeight: 250, maxWidth: 450, imageQuality: 100);

    if (file?.path != null) {
      setState(() {
        imageFile = File(file!.path);
      });
    }
  }

  Widget _namapelapor() {
    return TextField(
      autocorrect: false,
      decoration: const InputDecoration(
        labelText: "Nama Pelapor",
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _teleponpelapor() {
    return TextField(
      keyboardType: TextInputType.number,
      autocorrect: false,
      decoration: const InputDecoration(
        labelText: "No.Telp Pelapor",
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _lokasikejaidan() {
    return TextField(
      maxLines: 3,
      autocorrect: false,
      decoration: const InputDecoration(
        labelText: "Lokasi Kejadian",
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _tanggalkejadian() {
    return TextField(
      controller: dateController,
      autocorrect: false,
      decoration: const InputDecoration(
        suffixIcon: Icon(Icons.calendar_month_rounded),
        labelText: "Tanggal Kejadian",
        border: OutlineInputBorder(),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          String formattedDate =
              DateFormat('E, d MMM yyy HH:mm:ss').format(pickedDate);

          setState(() {
            dateController.text = pickedDate.toString();
          });
        }
      },
    );
  }

  Widget _deskripsilaporan() {
    return TextField(
      maxLines: 7,
      autocorrect: false,
      decoration: const InputDecoration(
        labelText: "Deskripsi Laporan",
        border: OutlineInputBorder(),
      ),
    );
  }
}
