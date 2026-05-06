# Online Session System - UI Guide

## Visual Layout in Session Detail Screen

### Screen Structure
```
┌─────────────────────────────────────┐
│  Session Details (AppBar)      💬  │
├─────────────────────────────────────┤
│                                     │
│  ┌───────────────────────────────┐ │
│  │ 💡 Pre-Session Tip            │ │ ← Amber gradient card
│  │ (Shows 1 hour before session) │ │
│  └───────────────────────────────┘ │
│                                     │
│  ┌───────────────────────────────┐ │
│  │ Session Info Card             │ │
│  │ • Skill Title                 │ │
│  │ • Teacher / Learner           │ │
│  │ • Date / Time                 │ │
│  │ • Mode / Credits              │ │
│  │ • Note                        │ │
│  └───────────────────────────────┘ │
│                                     │
│  ┌───────────────────────────────┐ │
│  │ 📹 Online Meeting             │ │ ← NEW: Blue gradient card
│  │                               │ │
│  │ [Teacher View]                │ │
│  │ ┌─────────────────────────┐   │ │
│  │ │ Paste meeting link...   │   │ │
│  │ └─────────────────────────┘   │ │
│  │ [Save Link / Update Link]     │ │
│  │                               │ │
│  │ Meeting Link:                 │ │
│  │ https://meet.google.com/...   │ │
│  │                               │ │
│  │ [Copy]  [Join Meeting]        │ │
│  │                               │ │
│  │ [Start Session] (green)       │ │ ← When status = Accepted
│  │ [End Session] (red)           │ │ ← When status = In Progress
│  └───────────────────────────────┘ │
│                                     │
│  ┌───────────────────────────────┐ │
│  │ 🧠 Post-Session Reflection    │ │ ← NEW: Purple gradient card
│  │ (Learner only, after session) │ │
│  │                               │ │
│  │ Take a moment to reflect on   │ │
│  │ what you learned              │ │
│  │                               │ │
│  │ [Start Reflection]            │ │
│  └───────────────────────────────┘ │
│                                     │
│  [Cancel Session] (red outline)   │ │
│  [Report Issue] (orange outline)  │ │
│  [Message] (purple filled)        │ │
│                                     │
└─────────────────────────────────────┘
```

## Component Details

### 1. Online Meeting Card (Teacher View)

#### Before Setting Link
```
┌─────────────────────────────────────┐
│ 📹 Online Meeting                   │
├─────────────────────────────────────┤
│                                     │
│ ┌─────────────────────────────────┐ │
│ │ 🔗 Paste Google Meet or Zoom... │ │
│ └─────────────────────────────────┘ │
│                                     │
│ ┌─────────────────────────────────┐ │
│ │      💾 Save Link               │ │
│ └─────────────────────────────────┘ │
│                                     │
└─────────────────────────────────────┘
```

#### After Setting Link
```
┌─────────────────────────────────────┐
│ 📹 Online Meeting                   │
├─────────────────────────────────────┤
│                                     │
│ ┌─────────────────────────────────┐ │
│ │ 🔗 https://meet.google.com/...  │ │
│ └─────────────────────────────────┘ │
│                                     │
│ ┌─────────────────────────────────┐ │
│ │      💾 Update Link             │ │
│ └─────────────────────────────────┘ │
│                                     │
│ Meeting Link:                       │
│ https://meet.google.com/abc-defg    │
│                                     │
│ ┌──────────┐  ┌──────────────────┐ │
│ │ 📋 Copy  │  │ 📹 Join Meeting  │ │
│ └──────────┘  └──────────────────┘ │
│                                     │
│ ┌─────────────────────────────────┐ │
│ │      ▶️ Start Session           │ │ ← Green button
│ └─────────────────────────────────┘ │
│                                     │
└─────────────────────────────────────┘
```

#### During Session
```
┌─────────────────────────────────────┐
│ 📹 Online Meeting                   │
├─────────────────────────────────────┤
│                                     │
│ Meeting Link:                       │
│ https://meet.google.com/abc-defg    │
│                                     │
│ ┌──────────┐  ┌──────────────────┐ │
│ │ 📋 Copy  │  │ 📹 Join Meeting  │ │
│ └──────────┘  └──────────────────┘ │
│                                     │
│ ┌─────────────────────────────────┐ │
│ │      ⏹️ End Session             │ │ ← Red button
│ └─────────────────────────────────┘ │
│                                     │
└─────────────────────────────────────┘
```

### 2. Online Meeting Card (Learner View)

#### Before Link Set
```
┌─────────────────────────────────────┐
│ 📹 Online Meeting                   │
├─────────────────────────────────────┤
│                                     │
│ Waiting for teacher to set          │
│ meeting link...                     │
│                                     │
└─────────────────────────────────────┘
```

#### After Link Set (Before Activation)
```
┌─────────────────────────────────────┐
│ 📹 Online Meeting                   │
├─────────────────────────────────────┤
│                                     │
│ Meeting Link:                       │
│ https://meet.google.com/abc-defg    │
│                                     │
│ ┌──────────┐  ┌──────────────────┐ │
│ │ 📋 Copy  │  │   Not Yet Active │ │ ← Gray button
│ └──────────┘  └──────────────────┘ │
│                                     │
│ Join button will be active 5        │
│ minutes before session              │
│                                     │
└─────────────────────────────────────┘
```

#### After Activation (5 min before)
```
┌─────────────────────────────────────┐
│ 📹 Online Meeting                   │
├─────────────────────────────────────┤
│                                     │
│ Meeting Link:                       │
│ https://meet.google.com/abc-defg    │
│                                     │
│ ┌──────────┐  ┌──────────────────┐ │
│ │ 📋 Copy  │  │ 📹 Join Meeting  │ │ ← Green button
│ └──────────┘  └──────────────────┘ │
│                                     │
└─────────────────────────────────────┘
```

### 3. Post-Session Reflection Card (Learner Only)

#### Before Completing Reflection
```
┌─────────────────────────────────────┐
│ 🧠 Post-Session Reflection          │
├─────────────────────────────────────┤
│                                     │
│ Take a moment to reflect on what    │
│ you learned                         │
│                                     │
│ ┌─────────────────────────────────┐ │
│ │   ✨ Start Reflection           │ │ ← Purple button
│ └─────────────────────────────────┘ │
│                                     │
└─────────────────────────────────────┘
```

#### After Completing Reflection
```
┌─────────────────────────────────────┐
│ 🧠 Post-Session Reflection          │
├─────────────────────────────────────┤
│                                     │
│ You've completed your reflection.   │
│ Great job!                          │
│                                     │
│ ┌─────────────────────────────────┐ │
│ │   ✏️ View Reflection            │ │ ← Purple button
│ └─────────────────────────────────┘ │
│                                     │
└─────────────────────────────────────┘
```

### 4. Reflection Dialog

```
┌─────────────────────────────────────┐
│ 🧠 Reflect on Your Learning         │
│ Guitar Session                      │
├─────────────────────────────────────┤
│                                     │
│ Question 1 of 3                     │
│ ▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░   │ ← Progress bar
│                                     │
│ What was the most challenging       │
│ concept you encountered today?      │
│                                     │
│ ┌─────────────────────────────────┐ │
│ │ Type your answer here...        │ │
│ │                                 │ │
│ │                                 │ │
│ │                                 │ │
│ └─────────────────────────────────┘ │
│                                     │
│ ┌──────────┐  ┌──────────────────┐ │
│ │ Previous │  │      Next        │ │
│ └──────────┘  └──────────────────┘ │
│                                     │
│              [Skip]                 │
│                                     │
└─────────────────────────────────────┘
```

#### Last Question
```
┌─────────────────────────────────────┐
│ 🧠 Reflect on Your Learning         │
│ Guitar Session                      │
├─────────────────────────────────────┤
│                                     │
│ Question 3 of 3                     │
│ ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓   │ ← Full progress
│                                     │
│ What questions do you still have    │
│ about Guitar?                       │
│                                     │
│ ┌─────────────────────────────────┐ │
│ │ Type your answer here...        │ │
│ │                                 │ │
│ │                                 │ │
│ │                                 │ │
│ └─────────────────────────────────┘ │
│                                     │
│ ┌──────────┐  ┌──────────────────┐ │
│ │ Previous │  │     Submit       │ │ ← Submit on last
│ └──────────┘  └──────────────────┘ │
│                                     │
│              [Skip]                 │
│                                     │
└─────────────────────────────────────┘
```

## Color Scheme

### Online Meeting Card
- **Background**: Blue gradient (`Colors.blue.withValues(alpha: 0.1)` to `0.05`)
- **Border**: Blue with 30% opacity
- **Icon**: Blue (`Colors.blue`)
- **Save Button**: Blue background, white text
- **Copy Button**: Blue outline, blue text
- **Join Button (Active)**: Green background, white text
- **Join Button (Inactive)**: Gray background, white text
- **Start Button**: Green background, white text
- **End Button**: Red background, white text

### Reflection Card
- **Background**: Purple gradient (`Colors.purple.withValues(alpha: 0.1)` to `0.05`)
- **Border**: Purple with 30% opacity
- **Icon**: Purple (`Colors.purple`)
- **Button**: Purple background, white text

### Reflection Dialog
- **Header**: Purple gradient
- **Progress Bar**: Purple filled, gray unfilled
- **Buttons**: Purple background, white text
- **Skip**: Text button, gray text

## Responsive Behavior

### Button States
1. **Loading**: Shows spinner, button disabled
2. **Disabled**: Gray color, no interaction
3. **Active**: Full color, tap enabled
4. **Success**: Brief green flash, then normal

### Text Overflow
- Meeting links: Ellipsis after 2 lines
- Questions: Wrap to multiple lines
- Answers: Multi-line text field

### Keyboard Behavior
- Text fields auto-focus
- Keyboard pushes content up
- Submit on keyboard "done" action

## Animations

### Button Press
- Scale down to 0.95 on press
- Spring back on release
- Ripple effect

### Card Appearance
- Fade in from 0 to 1 opacity
- Slide up 20px
- Duration: 300ms

### Loading States
- Circular spinner rotation
- Infinite loop
- Smooth animation

## Accessibility

### Screen Reader Support
- All buttons have semantic labels
- Card headers are properly marked
- Progress indicator announces percentage
- Error messages are announced

### Touch Targets
- Minimum 48x48 dp for all buttons
- Adequate spacing between elements
- Large tap areas for important actions

### Color Contrast
- Text meets WCAG AA standards
- Icons are clearly visible
- Disabled states are distinguishable

## Error States

### Invalid URL
```
┌─────────────────────────────────────┐
│ ❌ Please enter a valid URL         │
│    (starting with http:// or        │
│     https://)                       │
└─────────────────────────────────────┘
```

### Network Error
```
┌─────────────────────────────────────┐
│ ❌ Failed to save meeting link:     │
│    Network error. Please try again. │
└─────────────────────────────────────┘
```

### AI Generation Error
```
(Silent fallback to generic questions)
No visible error to user
```

## Success States

### Link Saved
```
┌─────────────────────────────────────┐
│ ✅ Meeting link saved and sent to   │
│    learner                          │
└─────────────────────────────────────┘
```

### Session Started
```
┌─────────────────────────────────────┐
│ ✅ Session started                  │
└─────────────────────────────────────┘
```

### Session Ended
```
┌─────────────────────────────────────┐
│ ✅ Session ended successfully       │
└─────────────────────────────────────┘
```

### Reflection Saved
```
┌─────────────────────────────────────┐
│ ✅ Reflection saved successfully    │
└─────────────────────────────────────┘
```

### Link Copied
```
┌─────────────────────────────────────┐
│ ✅ Meeting link copied to clipboard │
└─────────────────────────────────────┘
```

## Confirmation Dialogs

### Start Session
```
┌─────────────────────────────────────┐
│ Start Session?                      │
├─────────────────────────────────────┤
│                                     │
│ This will notify the learner that   │
│ the session has started.            │
│                                     │
│         [Cancel]  [Start]           │
│                                     │
└─────────────────────────────────────┘
```

### End Session
```
┌─────────────────────────────────────┐
│ End Session?                        │
├─────────────────────────────────────┤
│                                     │
│ This will mark the session as       │
│ completed and generate reflection   │
│ questions for the learner.          │
│                                     │
│         [Cancel]  [End Session]     │
│                                     │
└─────────────────────────────────────┘
```

## Integration Points

### With Existing Features
1. **Pre-Session Tip**: Shows above online meeting card
2. **Session Info**: Shows above online meeting card
3. **Action Buttons**: Show below online meeting card
4. **Chat**: Meeting link sent automatically
5. **Notifications**: Sent for all events

### Data Flow
```
User Action
    ↓
OnlineSessionControls Widget
    ↓
OnlineSessionService
    ↓
Firestore Update
    ↓
Notification Service
    ↓
Chat Service
    ↓
User Notification
```

## Best Practices

### When to Show
- ✅ Only for online sessions (`mode == 'Online'`)
- ✅ Hide for in-person sessions
- ✅ Show appropriate controls based on role
- ✅ Show appropriate controls based on status

### When to Hide
- ❌ Don't show for in-person sessions
- ❌ Don't show teacher controls to learners
- ❌ Don't show reflection to teachers
- ❌ Don't show controls after session cancelled

### User Feedback
- ✅ Always show loading states
- ✅ Always show success messages
- ✅ Always show error messages
- ✅ Always require confirmation for critical actions

## Conclusion

The Online Session System UI is designed to be:
- **Intuitive**: Clear visual hierarchy and labels
- **Responsive**: Adapts to different states and roles
- **Accessible**: Meets accessibility standards
- **Beautiful**: Consistent with app design language
- **Functional**: All features work seamlessly

The integration into the Session Detail Screen is seamless and doesn't disrupt existing functionality.
