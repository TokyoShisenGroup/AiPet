import 'package:aipet/Utility/http.dart';
import 'package:flutter/material.dart';
import 'add_pet_page.dart';
import 'pet_detail_page.dart';
import "package:aipet/Utility/typedefinition.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

class PetManagementPage extends StatefulWidget {
  PetManagementPage({super.key});

  @override
  _PetManagementPageState createState() => _PetManagementPageState();
}


class _PetManagementPageState extends State<PetManagementPage> {
  List<Pet> pets = [
    Pet(name: 'Buddy', type: 'Dog', kind: 'demu', weight: 5.00, birthday: DateTime(2021, 3, 6)),
    Pet(name: 'Mittens', type: 'Cat', kind: 'meiduan', weight: 6.00, birthday: DateTime(2022, 8, 4)),
    Pet(name: 'Leo', type: 'HakiRen', weight: 75.00, kind: 'shinajin', birthday: DateTime(2001, 1, 27)),
  ];


  void addPet(Pet pet) {
    setState(() {
      pets.add(pet);
    });
  }

  Future<void> _navigateToAddPetPage() async {
    final Pet? newPet = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddPetPage()),
    );

    if (newPet != null) {
      addPet(newPet);
      savePetToBackend(newPet);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _navigateToAddPetPage();
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
            subtitle: Text('${pet.type} - ${pet.kind}'),
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