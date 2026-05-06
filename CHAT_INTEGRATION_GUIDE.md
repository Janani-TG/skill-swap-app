# Chat System Integration Guide

## Quick Start

### 1. Verify Dependencies

Ensure these are in your `pubspec.yaml`:

```yaml
dependencies:
  cloud_firestore: ^5.0.0
  firebase_auth: ^5.7.0
  firebase_storage: ^12.4.10
  image_picker: ^1.2.2
  google_generative_ai: ^0.4.7
  intl: ^0.19.0
```

Run:
```bash
flutter pub get
```

### 2. Configure Firebase Storage

#### Enable Firebase Storage
1. Go to Firebase Console → Storage
2. Click "Get Started"
3. Choose production mode or test mode
4. Select a location for your storage bucket

#### Set Storage Rules
```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    // Chat images
    match /chats/{chatId}/{imageFile} {
      // Only authenticated users can upload
      allow write: if request.auth != null;
      // Anyone can read (images are public once uploaded)
      allow read: if true;
    }
  }
}
```

### 3. Configure Firestore Security Rules

Add these rules to your Firestore:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Chats collection
    match /chats/{chatId} {
      // Users can only access chats they're part of
      allow read, write: if request.auth != null && 
        request.auth.uid in resource.data.participants;
      
      // Messages subcollection
      match /messages/{messageId} {
        // Same access as parent chat
        allow read, write: if request.auth != null && 
          request.auth.uid in get(/databases/$(database)/documents/chats/$(chatId)).data.participants;
      }
      
      // Typing status subcollection
      match /typing/{userId} {
        // Users can update their own typing status
        allow write: if request.auth != null && 
          request.auth.uid == userId;
        // Anyone in chat can read typing status
        allow read: if request.auth != null && 
          request.auth.uid in get(/databases/$(database)/documents/chats/$(chatId)).data.participants;
      }
    }
  }
}
```

### 4. Configure Image Picker Permissions

#### Android (`android/app/src/main/AndroidManifest.xml`)
```xml
<manifest>
    <!-- Add these permissions -->
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
    <uses-permission android:name="android.permission.CAMERA"/>
    
    <application>
        <!-- Your existing config -->
    </application>
</manifest>
```

#### iOS (`ios/Runner/Info.plist`)
```xml
<dict>
    <!-- Add these keys -->
    <key>NSPhotoLibraryUsageDescription</key>
    <string>We need access to your photo library to send images in chat</string>
    <key>NSCameraUsageDescription</key>
    <string>We need access to your camera to take photos for chat</string>
</dict>
```

### 5. Import and Use

```dart
import 'package:skillswap/screens/chat_screen.dart';

// Open chat screen
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ChatScreen(
      otherUserId: 'teacher_or_learner_uid',
      otherUserName: 'John Doe',
      sessionId: 'session_123',
    ),
  ),
);
```

## Integration Patterns

### Pattern 1: From Sessions List (Swipe Action)
```dart
// In sessions_list_screen.dart
void _openChat() {
  final data = widget.doc.data() as Map<String, dynamic>;
  final teacherId = data['teacherId'] as String?;
  final teacherName = data['teacherName'] as String? ?? 'Teacher';

  if (teacherId == null) return;

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ChatScreen(
        otherUserId: teacherId,
        otherUserName: teacherName,
        sessionId: widget.doc.id,
      ),
    ),
  );
}
```

### Pattern 2: From Session Detail Screen
```dart
// In session_detail_screen.dart
void _openChat() {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  final teacherId = _sessionData!['teacherId'] as String?;
  final learnerId = _sessionData!['learnerId'] as String?;
  final teacherName = _sessionData!['teacherName'] as String? ?? 'Teacher';
  final learnerName = _sessionData!['learnerName'] as String? ?? 'Learner';

  // Determine who to chat with
  final otherUserId = uid == teacherId ? learnerId : teacherId;
  final otherUserName = uid == teacherId ? learnerName : teacherName;

  if (otherUserId == null) return;

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ChatScreen(
        otherUserId: otherUserId,
        otherUserName: otherUserName,
        sessionId: widget.sessionId,
      ),
    ),
  );
}
```

### Pattern 3: From Notifications
```dart
// When user taps a chat notification
final sessionId = notification.data['sessionId'];
final otherUserId = notification.data['senderId'];
final otherUserName = notification.data['senderName'];

Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ChatScreen(
      otherUserId: otherUserId,
      otherUserName: otherUserName,
      sessionId: sessionId,
    ),
  ),
);
```

## Testing the Chat System

### 1. Create Test Users

Create two test accounts in Firebase Authentication:
- User A (Learner): `learner@test.com`
- User B (Teacher): `teacher@test.com`

### 2. Create Test Session

Add a test session in Firestore:

```javascript
// sessions/test_session_123
{
  skillId: "skill_123",
  skillTitle: "React Fundamentals",
  teacherId: "teacher_uid",
  teacherName: "John Teacher",
  learnerId: "learner_uid",
  learnerName: "Jane Learner",
  status: "Accepted",
  createdAt: Timestamp.now()
}
```

### 3. Test Scenarios

#### Test 1: Send Text Message
1. Login as User A
2. Open chat with User B
3. Type a message
4. Press send
5. Verify message appears
6. Login as User B
7. Verify message received
8. Check read receipt updates

#### Test 2: Send Image
1. Login as User A
2. Open chat
3. Tap image button
4. Select an image
5. Wait for upload
6. Verify image appears in chat
7. Login as User B
8. Verify image received and displays

#### Test 3: Typing Indicator
1. Login as User A
2. Open chat
3. Start typing (don't send)
4. Login as User B on another device
5. Open same chat
6. Verify "typing..." appears
7. Stop typing on User A
8. Verify indicator disappears after 3 seconds

#### Test 4: Read Receipts
1. Login as User A
2. Send a message
3. Verify single gray check mark
4. Login as User B
5. Open chat
6. Verify User A sees double purple check marks

#### Test 5: AI Suggestions
1. Login as User A
2. Open chat
3. Tap AI sparkle button
4. Wait for suggestions to load
5. Verify 3 suggestions appear
6. Tap a suggestion
7. Verify text inserted into input field
8. Send or edit the message

### 4. Performance Testing

#### Load Test
1. Send 100+ messages
2. Verify smooth scrolling
3. Check memory usage
4. Verify no lag

#### Image Test
1. Send 10 images in a row
2. Verify all upload successfully
3. Check loading indicators
4. Verify images display correctly

#### Network Test
1. Turn off WiFi
2. Try to send message
3. Verify error message
4. Turn WiFi back on
5. Retry sending

## Customization Options

### Change Colors

```dart
// In chat_screen.dart

// App bar gradient
flexibleSpace: Container(
  decoration: const BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFFYOURCOLOR1), Color(0xFFYOURCOLOR2)],
    ),
  ),
),

// Message bubble gradient (sender)
gradient: const LinearGradient(
  colors: [Color(0xFFYOURCOLOR1), Color(0xFFYOURCOLOR2)],
),

// Message bubble color (receiver)
color: Colors.yourColor,
```

### Adjust Image Quality

```dart
// In _pickAndSendImage method
final pickedFile = await picker.pickImage(
  source: ImageSource.gallery,
  maxWidth: 1920,  // Change resolution
  maxHeight: 1080, // Change resolution
  imageQuality: 85, // Change quality (0-100)
);
```

### Modify Typing Timeout

```dart
// In _onTextChanged method
_typingTimer = Timer(
  const Duration(seconds: 5), // Change from 3 to 5 seconds
  () {
    if (_isTyping) {
      setState(() => _isTyping = false);
      _setTypingStatus(false);
    }
  },
);
```

### Customize AI Prompt

```dart
// In _generateAISuggestions method
final prompt = '''
Your custom prompt here...
Skill: $_skillTitle
Role: $role
Generate suggestions that are:
- Your custom requirements
''';
```

### Disable Features

```dart
// Disable AI Assist
// Comment out or remove the AI button in build method

// Disable Image Sharing
// Comment out or remove the image button

// Disable Typing Indicator
// Comment out _listenToTypingStatus() in initState
// Comment out _setTypingStatus calls
```

## Troubleshooting

### Issue: "Permission denied" error
**Solution:**
1. Check Firestore security rules are deployed
2. Verify user is authenticated
3. Check chat participants array includes user
4. Review Firebase Console → Firestore → Rules

### Issue: Images not uploading
**Solution:**
1. Check Firebase Storage is enabled
2. Verify storage rules are set
3. Check image picker permissions in manifest
4. Ensure network connection
5. Check Firebase Console → Storage

### Issue: Typing indicator not showing
**Solution:**
1. Verify typing subcollection exists
2. Check Firestore rules for typing access
3. Ensure timer is running
4. Check timestamp validation logic
5. Test with two devices/emulators

### Issue: Read receipts not updating
**Solution:**
1. Check _markMessagesAsRead is called
2. Verify batch update completes
3. Check Firestore rules allow updates
4. Ensure read field exists in messages
5. Check user IDs match correctly

### Issue: AI suggestions not generating
**Solution:**
1. Verify Gemini API key is correct
2. Check internet connection
3. Ensure session info loaded (_skillTitle not null)
4. Check API quota limits
5. Review error logs in debug console

### Issue: Chat ID mismatch
**Solution:**
1. Verify chat ID generation logic
2. Check user IDs are sorted correctly
3. Ensure session ID is consistent
4. Test with known user IDs
5. Check Firestore document paths

## Advanced Features

### Add Push Notifications

```dart
// In _sendMessage method, after Firestore write
await _sendPushNotification(
  recipientId: widget.otherUserId,
  title: 'New message from ${currentUserName}',
  body: text ?? '📷 Image',
  data: {
    'type': 'chat_message',
    'sessionId': widget.sessionId,
    'senderId': _uid,
  },
);
```

### Add Message Pagination

```dart
// Modify StreamBuilder query
stream: _db
    .collection('chats')
    .doc(_chatId)
    .collection('messages')
    .orderBy('createdAt', descending: true)
    .limit(50) // Load 50 at a time
    .snapshots(),
```

### Add Offline Support

```dart
// Enable Firestore offline persistence
await FirebaseFirestore.instance.settings = const Settings(
  persistenceEnabled: true,
  cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
);
```

### Add Message Search

```dart
// Add search functionality
Future<List<Message>> searchMessages(String query) async {
  final snapshot = await _db
      .collection('chats')
      .doc(_chatId)
      .collection('messages')
      .where('text', isGreaterThanOrEqualTo: query)
      .where('text', isLessThanOrEqualTo: '$query\uf8ff')
      .get();
  
  return snapshot.docs.map((doc) => Message.fromFirestore(doc)).toList();
}
```

## Monitoring and Analytics

### Track Chat Metrics

```dart
// Add analytics events
await FirebaseAnalytics.instance.logEvent(
  name: 'message_sent',
  parameters: {
    'session_id': widget.sessionId,
    'message_type': imageUrl != null ? 'image' : 'text',
  },
);

await FirebaseAnalytics.instance.logEvent(
  name: 'ai_suggestion_used',
  parameters: {
    'session_id': widget.sessionId,
    'skill': _skillTitle,
  },
);
```

### Monitor Performance

```dart
// Add performance monitoring
final trace = FirebasePerformance.instance.newTrace('chat_load');
await trace.start();

// Your chat loading code

await trace.stop();
```

## Best Practices

### 1. Error Handling
Always wrap Firestore operations in try-catch:
```dart
try {
  await _sendMessage(text: text);
} catch (e) {
  debugPrint('Error: $e');
  _showErrorSnackBar('Failed to send message');
}
```

### 2. Resource Cleanup
Always dispose resources:
```dart
@override
void dispose() {
  _messageController.dispose();
  _scrollController.dispose();
  _typingTimer?.cancel();
  _setTypingStatus(false);
  super.dispose();
}
```

### 3. Loading States
Show loading indicators for async operations:
```dart
if (_isUploading)
  const CircularProgressIndicator()
else
  IconButton(...)
```

### 4. User Feedback
Provide feedback for all actions:
```dart
ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(content: Text('Message sent')),
);
```

### 5. Null Safety
Always check for null values:
```dart
final text = msg['text'] as String?;
if (text != null && text.isNotEmpty) {
  // Use text
}
```

## Support and Resources

### Documentation
- [Firestore Documentation](https://firebase.google.com/docs/firestore)
- [Firebase Storage Documentation](https://firebase.google.com/docs/storage)
- [Image Picker Documentation](https://pub.dev/packages/image_picker)
- [Gemini AI Documentation](https://ai.google.dev/docs)

### Common Issues
- Check Firebase Console for quota limits
- Review Firestore usage in Firebase Console
- Monitor Storage usage and costs
- Check API key restrictions

### Getting Help
1. Check debug console for errors
2. Review Firebase Console logs
3. Test with Firebase Emulator Suite
4. Check Firestore rules simulator
5. Review this documentation

## Next Steps

1. **Test Thoroughly**: Run through all test scenarios
2. **Customize UI**: Adjust colors and styling to match your brand
3. **Add Analytics**: Track usage and performance
4. **Monitor Costs**: Keep an eye on Firebase usage
5. **Gather Feedback**: Get user feedback on chat experience
6. **Iterate**: Add features based on user needs

## Example: Complete Integration

Here's a complete example of integrating chat into your app:

```dart
// In your session detail screen
class SessionDetailScreen extends StatelessWidget {
  final String sessionId;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Session Details'),
        actions: [
          // Add chat button
          IconButton(
            icon: Icon(Icons.message),
            onPressed: () => _openChat(context),
          ),
        ],
      ),
      body: YourSessionContent(),
    );
  }
  
  void _openChat(BuildContext context) async {
    // Load session data
    final sessionDoc = await FirebaseFirestore.instance
        .collection('sessions')
        .doc(sessionId)
        .get();
    
    final data = sessionDoc.data()!;
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    
    // Determine other user
    final isTeacher = currentUserId == data['teacherId'];
    final otherUserId = isTeacher ? data['learnerId'] : data['teacherId'];
    final otherUserName = isTeacher ? data['learnerName'] : data['teacherName'];
    
    // Navigate to chat
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          otherUserId: otherUserId,
          otherUserName: otherUserName,
          sessionId: sessionId,
        ),
      ),
    );
  }
}
```

That's it! Your chat system is now fully integrated and ready to use.
