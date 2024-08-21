import 'package:flutter/material.dart';
import 'add_pet_page.dart';
import 'pet_detail_page.dart';
import "package:aipet/Utility/typedefinition.dart";

class PetManagementPage extends StatelessWidget {
  final List<Pet> pets = [
    Pet(name: 'Buddy', type: 'Dog'),
    Pet(name: 'Mittens', type: 'Cat'),
  ];

 PetManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddPetPage()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: pets.length,
        itemBuilder: (context, index) {
          final pet = pets[index];
          return ListTile(
            leading: const Icon(Icons.pets),
            title: Text(pet.name),
            subtitle: Text(pet.type),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PetDetailPage(pet: pet)),
              );
            },
          );
        },
      ),
    );
  }
}