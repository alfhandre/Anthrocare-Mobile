import 'package:flutter/material.dart';
import 'package:to_do_list/models/parentsModel.dart';
import 'package:to_do_list/services/parentsService.dart';

class DetailParent extends StatefulWidget {
  DetailParent({Key? key, required this.parent});
  final ParentModel parent;

  @override
  State<DetailParent> createState() => _DetailParentState();
}

class _DetailParentState extends State<DetailParent> {
  late Future<List<ParentModel>> futureParent;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureParent = ParentService().getParentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Detail Orang Tua ${widget.parent.nama_orangtua} ${widget.parent.id}'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text('Nama Ortu: ${widget.parent['nama_orangtua']}'),
          // Text('Tanggal Lahir: ${widget.parent['tgl_lahir_orangtua']}'),
          // Text('Alamat: ${widget.parent['alamat']}'),
          // Text('No KTP: ${widget.parent['no_ktp']}'),
          // Text('Golongan Darah: ${widget.parent['gol_darah']}'),
          // Tambahkan informasi lainnya sesuai kebutuhan
          // Text('No Telepon: ${widget.parent['no_telp']}'),
        ],
      ),
    );
  }
}
