# Teacher Certification System - Integration Guide

## Overview
The teacher certification upload system is **fully implemented** in `certification_screen.dart`. This guide shows how to integrate it into your app's navigation flow.

## Current Status
✅ **COMPLETE**: All features implemented
- File upload (images & PDFs)
- Metadata capture
- Upload progress tracking
- AI verification with Gemini
- Certificate management
- Beautiful UI

## How to Access

### From Teach Screen
The certification screen requires a `skillName` parameter. Here's how to integrate it:

#### Option 1: Add Button to Skill Card
Add a "Add Certification" button to each skill card in the teach screen:

```dart
// In teach_skill_card.dart or teach_screen.dart
ElevatedButton.icon(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CertificationScreen(
          skillName: widget.skill.name,
        ),
      ),
    );
  },
  icon: const Icon(Icons.workspace_premium),
  label: const Text('Add Certification'),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.amber,
    foregroundColor: Colors.white,
  ),
)
```

#### Option 2: Add to Skill Actions Menu
Add a menu item when user taps on a skill:

```dart
PopupMenuButton(
  itemBuilder: (context) => [
    const PopupMenuItem(
      value: 'edit',
      child: Row(
        children: [
          Icon(Icons.edit),
          SizedBox(width: 8),
          Text('Edit Skill'),
        ],
      ),
    ),
    const PopupMenuItem(
      value: 'certify',
      child: Row(
        children: [
          Icon(Icons.workspace_premium),
          SizedBox(width: 8),
          Text('Add Certification'),
        ],
      ),
    ),
    const PopupMenuItem(
      value: 'delete',
      child: Row(
        children: [
          Icon(Icons.delete),
          SizedBox(width: 8),
          Text('Delete Skill'),
        ],
      ),
    ),
  ],
  onSelected: (value) {
    if (value == 'certify') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CertificationScreen(
            skillName: skillName,
          ),
        ),
      );
    }
  },
)
```

#### Option 3: Add to Profile Setup Flow
After user adds a skill, prompt them to add certification:

```dart
// After skill is added
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: const Text('Add Certification?'),
    content: const Text(
      'Would you like to upload a certificate for this skill? '
      'This helps build trust with learners.',
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Later'),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CertificationScreen(
                skillName: skillName,
              ),
            ),
          );
        },
        child: const Text('Add Now'),
      ),
    ],
  ),
);
```

### From Profile Screen
Add a "Certifications" section in the profile:

```dart
ListTile(
  leading: const Icon(Icons.workspace_premium, color: Colors.amber),
  title: const Text('My Certifications'),
  subtitle: const Text('Manage your teaching credentials'),
  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
  onTap: () {
    // Navigate to certifications list screen
    // Or show dialog to select skill first
  },
)
```

## Required Import

```dart
import 'package:skillswap/screens/certification_screen.dart';
```

## Usage Example

### Basic Navigation
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => CertificationScreen(
      skillName: 'Guitar', // The skill name
    ),
  ),
);
```

### With Result Handling
```dart
final result = await Navigator.push<bool>(
  context,
  MaterialPageRoute(
    builder: (context) => CertificationScreen(
      skillName: 'Guitar',
    ),
  ),
);

if (result == true) {
  // Certificate was uploaded
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Certificate uploaded successfully!'),
      backgroundColor: Colors.green,
    ),
  );
}
```

## UI Flow

### 1. User Journey
```
Teach Screen
    ↓
Tap "Add Certification" on skill card
    ↓
Certification Screen opens
    ↓
User sees existing certificates (if any)
    ↓
User taps file picker
    ↓
Selects image or PDF
    ↓
Fills in certificate details
    ↓
Taps "Upload Certificate"
    ↓
Progress bar shows upload
    ↓
AI analyzes certificate
    ↓
AI assessment displayed
    ↓
Certificate added to list
    ↓
Status: "Pending Review"
```

### 2. Screen States

#### Empty State (No Certificates)
- Shows upload form immediately
- Helpful instructions
- File picker area prominent

#### With Existing Certificates
- Lists uploaded certificates at top
- Each shows status badge
- AI assessment visible
- Upload form below list

#### During Upload
- Progress bar animates
- Upload button disabled
- Percentage shows

#### After Upload
- Success checkmark
- AI analyzing indicator
- Assessment appears
- Form resets

## Certificate Status Flow

```
Upload → Pending Review → Admin Reviews → Approved/Rejected
         (Orange)         (Manual)        (Green/Red)
```

### Status Badges
- **Pending**: 🕐 Orange - Awaiting admin review
- **Approved**: ✓ Green - Admin approved
- **Rejected**: ✗ Red - Admin rejected

## Data Structure

### Firestore Path
```
users/{userId}/certifications/{certId}
```

### Document Fields
```javascript
{
  skillName: "Guitar",
  certName: "Bachelor of Music",
  institution: "Berklee College of Music",
  certNumber: "MUS-2020-12345",
  issueDate: "2020-06-15T00:00:00.000Z",
  expiryDate: "2025-06-15T00:00:00.000Z",
  fileUrl: "https://firebasestorage.googleapis.com/...",
  fileType: "pdf",
  fileName: "degree.pdf",
  status: "pending",
  aiAssessment: "A Bachelor's degree from Berklee...",
  aiConfidence: "High",
  uploadedAt: Timestamp
}
```

## Features Available

### For Teachers
1. ✅ Upload certificate (image or PDF)
2. ✅ Fill in certificate details
3. ✅ See upload progress
4. ✅ View AI assessment
5. ✅ See approval status
6. ✅ Delete certificates
7. ✅ Upload multiple certificates per skill

### For Admins (Future)
1. ⏳ View all pending certifications
2. ⏳ See AI pre-check assessment
3. ⏳ View uploaded file
4. ⏳ Approve or reject
5. ⏳ Add admin notes
6. ⏳ Send notifications

## Best Practices

### When to Prompt for Certification
1. **After skill creation**: Immediately after user adds a new skill
2. **Profile completion**: During onboarding flow
3. **Before going live**: Before skill is published
4. **Periodic reminders**: For skills without certificates

### User Experience Tips
1. **Make it optional**: Don't force certification upload
2. **Explain benefits**: "Build trust with learners"
3. **Show examples**: "e.g., degree, diploma, certificate"
4. **Provide help**: Link to FAQ about accepted documents
5. **Celebrate upload**: Show success message and benefits

### UI Integration Tips
1. **Badge on skill card**: Show certification status
2. **Filter option**: "Certified teachers only"
3. **Profile badge**: "Verified Teacher" badge
4. **Search boost**: Prioritize certified teachers
5. **Trust indicators**: Show certification count

## Example: Skill Card with Certification Badge

```dart
Container(
  child: Column(
    children: [
      // Skill info
      Text(skillName),
      
      // Certification badge
      if (hasCertification)
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.verified, color: Colors.green, size: 14),
              SizedBox(width: 4),
              Text(
                'Certified',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      
      // Add certification button
      if (!hasCertification)
        TextButton.icon(
          onPressed: () => _openCertificationScreen(),
          icon: Icon(Icons.workspace_premium, size: 16),
          label: Text('Add Certification'),
        ),
    ],
  ),
)
```

## Testing Checklist

### Navigation
- [ ] Can open certification screen from teach screen
- [ ] Skill name passed correctly
- [ ] Back button works
- [ ] Can navigate multiple times

### Upload Flow
- [ ] File picker opens
- [ ] Can select image
- [ ] Can select PDF
- [ ] Form validation works
- [ ] Upload progresses
- [ ] Success state shows

### AI Verification
- [ ] AI check runs automatically
- [ ] Assessment displays
- [ ] Confidence level shows
- [ ] Fallback works on error

### Certificate List
- [ ] Existing certs load
- [ ] Status badges show
- [ ] Delete works
- [ ] List refreshes

## Troubleshooting

### Issue: Screen doesn't open
**Solution**: Check import statement and skill name parameter

### Issue: Upload fails
**Solution**: Check Firebase Storage rules and internet connection

### Issue: AI check fails
**Solution**: Check Gemini API key and quota

### Issue: Certificates don't load
**Solution**: Check Firestore security rules and user authentication

## Future Enhancements

### Short Term
1. Add certification badge to skill cards
2. Filter by certified teachers
3. Show certification count in profile
4. Add "Certified" badge to teacher profile

### Long Term
1. Admin approval panel
2. Email notifications
3. Certificate expiry reminders
4. Bulk upload
5. OCR for automatic data extraction

## Conclusion

The certification system is **ready to use**. Simply add navigation from your teach screen or profile screen to the `CertificationScreen` with the skill name parameter.

The system handles everything else:
- ✅ File upload
- ✅ Metadata capture
- ✅ Progress tracking
- ✅ AI verification
- ✅ Certificate management

All you need to do is integrate the navigation!

---

**Status**: ✅ READY FOR INTEGRATION  
**File**: `skill-swap-app/lib/screens/certification_screen.dart`  
**Required Parameter**: `skillName` (String)  
**Dependencies**: All included in pubspec.yaml
