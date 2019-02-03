

import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/generated/server.pb.dart';
import 'package:ide/client/client.dart';
import 'package:ide/themeing/ide_theme.dart';
import 'package:ide/ui/home_page.dart';
import 'package:provider/provider.dart';

class TextEditor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SourceCode>(
     stream: Provider.of<VisualClient>(context).serverClient.streamSourceCode(InitSourceCodeStream()),
      builder: (context, snapshot) {
       String source;
       if(!snapshot.hasData) {
         source = "";
       } else {
         source = snapshot.requireData.sourceCode;
       }
       return WIPTextEditor(
         text: source,
       );
      },
    );
  }
}

class WIPTextEditor extends StatelessWidget {

  const WIPTextEditor({Key key, this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Material(
        color: IDETheme.of(context).darkerBackground,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              OutlineButton(
                child: Text("Print code to console", style: IDETheme.of(context).propertyChangerTheme.propertyContainer,),
                onPressed: (){
                  print(text);
                },
              ),
              SingleChildScrollView(
                child: Text(text, style: IDETheme.of(context).textEditorTheme.text,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
