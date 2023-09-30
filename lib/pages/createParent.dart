import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do_list/pages/home.dart';
import 'package:to_do_list/services/parentsService.dart';

class CreateParent extends StatefulWidget {
  const CreateParent({super.key});

  @override
  State<CreateParent> createState() => _CreateParentState();
}

class _CreateParentState extends State<CreateParent> {
  final _formKey = GlobalKey<FormState>();

  final ParentService _parentService = ParentService();

  TextEditingController namaOrtuController = TextEditingController();
  TextEditingController tglLahirOrtuController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController noKTPController = TextEditingController();
  TextEditingController golDarahController = TextEditingController();
  TextEditingController noTelpController = TextEditingController();

  void submitForm() async {
    final String nama_orangtua = namaOrtuController.text;
    final String tgl_lahir_orangtua = tglLahirOrtuController.text;
    final String alamat = alamatController.text;
    final String no_ktp = noKTPController.text;
    final String gol_darah = golDarahController.text;
    final String no_telp = noTelpController.text;

    final Map newParent = {
      'nama_orangtua': nama_orangtua,
      'tgl_lahir_orangtua': tgl_lahir_orangtua,
      'alamat': alamat,
      'no_ktp': no_ktp,
      'gol_darah': gol_darah,
      'no_telp': no_telp,
    };

    bool data = await _parentService.CreateParent(newParent);
    print(data);

    if (data) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data Orang Tua Berhasil Ditambahkan')));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ParentsList()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal Menambahkan Data Orang Tua')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Parent")),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: namaOrtuController,
                    decoration: InputDecoration(
                        hintText: 'Nama Orang Tua',
                        prefixIcon: Icon(Icons.person)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Mohon Masukan Nama Orang Tua';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: tglLahirOrtuController,
                    decoration: InputDecoration(
                        hintText: 'Tanggal Lahir',
                        prefixIcon: Icon(Icons.date_range_rounded)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Mohon Masukan Tanggal Lahir';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: alamatController,
                    decoration: InputDecoration(
                        hintText: 'Alamat',
                        prefixIcon: Icon(Icons.location_on)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Mohon Masukan Alamat';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: noKTPController,
                    decoration: InputDecoration(
                        hintText: 'No KTP', prefixIcon: Icon(Icons.add_card)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Mohon Masukan No KTP';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: golDarahController,
                    decoration: InputDecoration(
                        hintText: 'Golongan Darah',
                        prefixIcon: Icon(Icons.bloodtype)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Mohon Masukan Golongan Darah';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: noTelpController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                        hintText: 'No Telpon', prefixIcon: Icon(Icons.phone)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Mohon Masukan No Telpon';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          submitForm(); // Submit the form if it's valid
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Please fill in all required fields.')),
                          );
                        }
                      },
                      child: Text('Submit'))
                ],
              )),
        ),
      ),
    );
  }
}
