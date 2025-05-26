import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  bool isLoading;
  RoundButton({super.key, required this.title, required this.onTap, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: isLoading ? CircularProgressIndicator(strokeWidth: 3, color: Colors.white,) : Text(title, style: TextStyle(color: Colors.white,),)),  
      ),
    );
  }
}