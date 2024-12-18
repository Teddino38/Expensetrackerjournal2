# Expense and Photo Journal App

## Overview
The Expense and Photo Journal App is a SwiftUI-based iOS application that allows users to:

1. Track their expenses by categorizing and grouping them.
2. Add, view, and delete photos in a journal-like interface, creating a visual record of memories.
3. Navigate between different sections using a tab-based layout.
4. Ensure accessibility with VoiceOver support for users with visual impairments.

The app integrates SwiftData for data persistence, ensuring that expenses and photos remain saved even after the app is closed.

---

## Features

### Expense Management
- **Expense Tracking:** Users can view expenses sorted by date and grouped into categories.
- **Add Categories:** Users can create custom categories for better organization.
- **Add Expenses:** Each category can have multiple expenses added.
- **Delete Expenses:** Users can remove specific expenses from the app.

### Photo Journal
- **Add Photos:** Users can select photos from their library using a PhotosPicker.
- **View Photos:** Display photos in a scrollable list, similar to a visual journal.
- **Delete Photos:** Users can remove photos they no longer want to keep.
- **Persisted Data:** Photos are stored using SwiftData to ensure they remain available across app sessions.

### Accessibility
- **VoiceOver Support:** Comprehensive VoiceOver labels for buttons, lists, and interactive elements.
- **Dynamic Type:** Support for system font scaling to cater to users with different text size preferences.

### Navigation
- **Tab-Based Interface:** Navigate between "Expenses," "Categories," and "Album" using a TabView.
- **Navigation Stacks:** Each section of the app uses a NavigationStack for intuitive navigation.

---

## Technologies Used
- **SwiftUI** for the user interface.
- **SwiftData** for persistent data storage.
- **PhotosPicker** for photo selection.
- **Accessibility APIs** to enhance usability for users with visual impairments.

---

## How to Use

1. **Expenses Tab:**
   - View all your expenses grouped by categories.
   - Swipe left on an expense to delete it.
   - Use the "+" button in the toolbar to add new expenses.

2. **Categories Tab:**
   - View all your categories in a list format.
   - Tap a category to see its associated expenses.
   - Use the "+" button to create a new category.
   - Delete a category by swiping left on it.

3. **Photo Journal Tab:**
   - Add photos by tapping the "Add Photos" button.
   - View photos in a scrollable list.
   - Delete unwanted photos by tapping the trash icon.

---

## Setup and Installation
1. Clone the repository from GitHub.
2. Open the `.xcodeproj` file in Xcode.
3. Build and run the app on a simulator or a physical device.
4. Ensure you have SwiftData enabled in your project settings.

---

## Future Enhancements
- **Search Functionality:** Add search capabilities for expenses and photos.
- **Export Data:** Allow users to export expenses or photos as a report.
- **Cloud Sync:** Integrate iCloud for syncing data across devices.
- **Photo Editing:** Add basic editing tools for photos within the app.

---

## License
This app is licensed under the MIT License. Feel free to use, modify, and distribute it.

---

## Acknowledgments
Special thanks to the contributors and developers of SwiftUI, SwiftData, and PhotosPicker APIs for providing the tools to build this app.

