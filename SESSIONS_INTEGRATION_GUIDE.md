# Sessions Screen Integration Guide

## Quick Start

### 1. Add to Navigation

#### Option A: Bottom Navigation Bar
```dart
// In your main navigation widget (e.g., home_screen.dart)
BottomNavigationBarItem(
  icon: Icon(Icons.event),
  label: 'Sessions',
),

// In the body/page switcher:
case 2: // or your sessions index
  return SessionsListScreen();
```

#### Option B: Drawer Menu
```dart
ListTile(
  leading: Icon(Icons.event),
  title: Text('My Sessions'),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SessionsListScreen(),
      ),
    );
  },
),
```

#### Option C: Direct Navigation
```dart
// From any screen
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => SessionsListScreen(),
  ),
);
```

### 2. Import Statements

Add these imports where you're navigating to the sessions screen:

```dart
import 'package:skillswap/screens/sessions_list_screen.dart';
import 'package:skillswap/screens/session_detail_screen.dart';
```

### 3. Required Firestore Indexes

Create these composite indexes in Firebase Console:

```
Collection: sessions
Index 1:
  - learnerId (Ascending)
  - status (Ascending)
  - scheduledDate (Ascending)

Index 2:
  - learnerId (Ascending)
  - status (Ascending)
  - createdAt (Descending)

Index 3:
  - learnerId (Ascending)
  - status (Array contains)
  - createdAt (Descending)
```

**How to create:**
1. Go to Firebase Console → Firestore Database
2. Click "Indexes" tab
3. Click "Create Index"
4. Add the fields as specified above
5. Wait for index to build (usually 1-2 minutes)

### 4. Test Data Setup

To test the screens, you need sessions in Firestore:

```javascript
// Example session document
{
  skillId: "skill123",
  skillTitle: "React Fundamentals",
  teacherId: "teacher_uid",
  teacherName: "John Doe",
  learnerId: "learner_uid",
  learnerName: "Jane Smith",
  credits: 10,
  mode: "Online",
  status: "Accepted",
  scheduledDate: Timestamp.fromDate(new Date("2024-01-20T14:00:00")),
  scheduledSlot: "2:00 PM - 3:00 PM",
  note: "Please review React hooks before the session",
  creditHeld: true,
  createdAt: Timestamp.now(),
  acceptedAt: Timestamp.now()
}
```

### 5. Verify Dependencies

Ensure these are in your `pubspec.yaml`:

```yaml
dependencies:
  cloud_firestore: ^5.0.0
  firebase_auth: ^5.7.0
  google_generative_ai: ^0.4.7
  intl: ^0.19.0
```

Run:
```bash
flutter pub get
```

## Features Overview

### Sessions List Screen
- **4 Tabs**: Upcoming, Active, Completed, Cancelled
- **Real-time Updates**: Firestore streams
- **Countdown Timers**: Updates every second
- **Swipe Actions**: 
  - Left: Cancel session
  - Right: Message
- **Tap**: View details

### Session Detail Screen
- **Pre-Session Tips**: AI-generated (1 hour before)
- **Full Information**: All session details
- **Actions**: Cancel, Report Issue, Message

## Common Integration Patterns

### Pattern 1: From Skill Detail
```dart
// After requesting a session
final sessionId = await SessionService.requestSession(...);

// Navigate to session details
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => SessionDetailScreen(
      sessionId: sessionId,
    ),
  ),
);
```

### Pattern 2: From Notifications
```dart
// When user taps a session notification
final sessionId = notification.data['sessionId'];

Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => SessionDetailScreen(
      sessionId: sessionId,
    ),
  ),
);
```

### Pattern 3: From Profile
```dart
// "My Sessions" button in profile
ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SessionsListScreen(),
      ),
    );
  },
  child: Text('View My Sessions'),
)
```

## Customization Options

### Change Colors
```dart
// In sessions_list_screen.dart
// Update the gradient colors in AppBar
flexibleSpace: Container(
  decoration: const BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFFYOURCOLOR1), Color(0xFFYOURCOLOR2)],
    ),
  ),
),
```

### Modify Tab Names
```dart
// In SessionsListScreen build method
tabs: const [
  Tab(text: 'Your Custom Name 1'),
  Tab(text: 'Your Custom Name 2'),
  Tab(text: 'Your Custom Name 3'),
  Tab(text: 'Your Custom Name 4'),
],
```

### Adjust Timer Update Frequency
```dart
// In _SessionCardState._startCountdown()
_timer = Timer.periodic(
  const Duration(seconds: 5), // Change from 1 to 5 seconds
  (_) {
    if (mounted) {
      _updateCountdown();
    }
  },
);
```

### Disable AI Tips
```dart
// In session_detail_screen.dart
// Comment out or remove this line in initState:
// _checkAndGeneratePreSessionTip();
```

## Troubleshooting

### Issue: "No sessions showing"
**Solution:**
1. Check user is logged in: `FirebaseAuth.instance.currentUser`
2. Verify sessions exist in Firestore for this user
3. Check `learnerId` field matches current user's UID
4. Ensure Firestore indexes are built

### Issue: "Countdown timer not updating"
**Solution:**
1. Check timer is started in initState
2. Verify timer is disposed in dispose
3. Ensure `mounted` check is present
4. Check scheduledDate is a valid Timestamp

### Issue: "Swipe actions not working"
**Solution:**
1. Ensure Dismissible widget is not nested incorrectly
2. Check confirmDismiss returns false (to prevent actual dismissal)
3. Verify gesture detector doesn't conflict

### Issue: "AI tip not generating"
**Solution:**
1. Verify Gemini API key is correct
2. Check internet connection
3. Ensure session is within 1 hour
4. Check Firestore write permissions
5. Look for errors in debug console

### Issue: "Chat screen not opening"
**Solution:**
1. Verify ChatScreen import is correct
2. Check sessionId is being passed
3. Ensure otherUserId is not null
4. Verify ChatScreen constructor matches

## Performance Tips

### 1. Limit Query Results
```dart
// Add limit to Firestore queries
.limit(50)
.snapshots();
```

### 2. Use Pagination
```dart
// Implement pagination for large lists
.startAfterDocument(lastDocument)
.limit(20)
```

### 3. Optimize Timer Updates
```dart
// Update less frequently when far from session
final updateInterval = diff.inHours > 24 
  ? Duration(minutes: 1)
  : Duration(seconds: 1);
```

### 4. Cache AI Tips
The implementation already caches tips in Firestore. No additional work needed.

## Security Rules

Add these Firestore security rules:

```javascript
match /sessions/{sessionId} {
  // Users can read their own sessions
  allow read: if request.auth != null && (
    resource.data.learnerId == request.auth.uid ||
    resource.data.teacherId == request.auth.uid
  );
  
  // Only learners can create sessions
  allow create: if request.auth != null &&
    request.resource.data.learnerId == request.auth.uid;
  
  // Both parties can update (for status changes)
  allow update: if request.auth != null && (
    resource.data.learnerId == request.auth.uid ||
    resource.data.teacherId == request.auth.uid
  );
}
```

## Testing Checklist

Before deploying:
- [ ] Create test sessions in Firestore
- [ ] Test all 4 tabs
- [ ] Verify countdown timers work
- [ ] Test swipe left (cancel)
- [ ] Test swipe right (message)
- [ ] Test tap to view details
- [ ] Verify AI tip generation (1 hour before)
- [ ] Test cancel button
- [ ] Test report issue button
- [ ] Test message button
- [ ] Check empty states
- [ ] Verify error handling
- [ ] Test with slow network
- [ ] Test with no network

## Next Steps

1. **Add to Main Navigation**: Choose your preferred navigation pattern
2. **Create Firestore Indexes**: Required for queries to work
3. **Test with Real Data**: Create test sessions
4. **Customize UI**: Adjust colors and text to match your brand
5. **Monitor Performance**: Check for any lag or memory issues
6. **Gather Feedback**: Get user feedback on UX

## Support

If you encounter issues:
1. Check the diagnostics output
2. Review the SESSIONS_SCREEN_SUMMARY.md for detailed documentation
3. Verify all dependencies are installed
4. Check Firebase Console for errors
5. Review debug console for error messages

## Example: Complete Integration

Here's a complete example of adding Sessions to a bottom navigation bar:

```dart
// home_screen.dart
import 'package:skillswap/screens/sessions_list_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    LearnScreen(),
    TeachScreen(),
    SessionsListScreen(), // Add here
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Learn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.teach),
            label: 'Teach',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event), // Sessions icon
            label: 'Sessions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
```

That's it! Your Sessions screen is now fully integrated.
