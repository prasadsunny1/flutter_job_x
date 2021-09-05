import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final client = SupabaseClient('https://ovkldccyurbemqxryrcs.supabase.co',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYzMDg3Mjc0OSwiZXhwIjoxOTQ2NDQ4NzQ5fQ.4rJh0yOAsw3x0cYZOYIS-q9tRcMGBhIDaxyZzQluHL4');
  List<dynamic> data = [];
  getData() async {
    var a = await client.from('jobs').select().execute();
    setState(() {
      data = a.data;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Jobs X'),
      ),
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints(maxWidth: 800),
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              var item = data[index];
              return ListTile(
                title: Text("${item['title']}"),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("${item['company_name']}"),
                    Text("${item['location']}"),
                    Text("${item['role']}"),
                    Text("${item['salary_range_min']}"),
                    Text("${item['salary_range_max']}"),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    var _url = item['company_name'];
                    void _launchURL() async => await canLaunch(_url)
                        ? await launch(_url)
                        : throw 'Could not launch $_url';
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
