import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tips_app/data/bloc/notification_bloc.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  int _age = 30;
  String _fitnessGoal = 'general';
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showAppInfo,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildProfileCard(),
            const SizedBox(height: 24),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildAgeSelector(),
            const SizedBox(height: 20),
            _buildFitnessGoalDropdown(),
            const SizedBox(height: 20),
            _buildNotificationToggle(),
          ],
        ),
      ),
    );
  }

  Widget _buildAgeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Age: $_age',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Slider(
          value: _age.toDouble(),
          min: 10,
          max: 100,
          divisions: 90,
          label: '$_age',
          onChanged: (value) => setState(() => _age = value.round()),
        ),
      ],
    );
  }

  Widget _buildFitnessGoalDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fitness Goal',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _fitnessGoal,
          items: const [
            DropdownMenuItem(
              value: 'weight_loss',
              child: Text('Weight Loss'),
            ),
            DropdownMenuItem(
              value: 'muscle_gain',
              child: Text('Muscle Gain'),
            ),
            DropdownMenuItem(
              value: 'general',
              child: Text('General Fitness'),
            ),
          ],
          onChanged: (value) => setState(() => _fitnessGoal = value!),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationToggle() {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        return SwitchListTile(
          title: const Text('Enable Daily Tips'),
          subtitle: const Text('Receive personalized health notifications'),
          value: state is NotificationEnabled,
          onChanged: (value) {
            if (value) {
              context.read<NotificationBloc>().add(
                    EnableNotifications(age: _age, fitnessGoal: _fitnessGoal),
                  );
            } else {
              context.read<NotificationBloc>().add(DisableNotifications());
            }
          },
        );
      },
    );
  }

  Widget _buildSaveButton() {
    return BlocConsumer<NotificationBloc, NotificationState>(
      listener: (context, state) {
        if (state is NotificationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
        _isSaving = false;
      },
      builder: (context, state) {
        return ElevatedButton(
          onPressed: _isSaving || state is NotificationLoading
              ? null
              : () {
                  setState(() => _isSaving = true);
                  // Save profile logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile saved successfully!')),
                  );
                },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: _isSaving || state is NotificationLoading
              ? const CircularProgressIndicator()
              : const Text('Save Profile'),
        );
      },
    );
  }

  void _showAppInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About Daily Health Tips'),
        content: const Text(
          'This app provides personalized health recommendations based on your age and fitness goals. '
          'Enable notifications to receive daily tips.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}