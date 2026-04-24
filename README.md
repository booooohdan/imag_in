# imag_in

Flutter test task: Mini gallery with authentication and Photo upload
Bohdan Ilkiv

## Features

### Authentication
- Email + password login via reqres.in
- Token stored in shared_preferences
- Pre-filled test credentials for test purposes
- Logout with confirmation dialog, clears token and redirects to login

### Gallery
- Fetches photos from https://picsum.photos/v2/list (30 per page)
- Infinite scroll, loads next page when within 200px of the bottom
- Tap any photo → fullscreen viewer with pinch-to-zoom
- Shimmer placeholders while remote images load

### Add Photo
- FAB opens system image picker (image_picker pakcage)
- Selected image is added to the list (in-memory only)

## Technical expectations
**State management:** Provider (ChangeNotifier + Consumer)
**Navigation:** GoRouter with auth/connectivity redirect guards
**HTTP:** Dio. Separate clients for auth and gallery
**Images:** extended_image for network caching and gesture zoom

## Getting Started

flutter pub get
flutter run

Login with the pre-filled credentials or any valid https://reqres.in account

### Extra features (from me)
- Monitors network state, redirects to a "No Internet" screen when offline, resumes automatically on reconnect
- Extensions for easy access and Assets class for images path
- Strong linter rules + free dcm linter rules to keep code style consistent
- Every loading state has an animated indicator: screen loading, photo loading. UI never freezes
- Prevents multiple taps on the login button and shows loading state while async code is running
- Added logo, splash screen, defined style in apptheme.dart, because all apps should be beautiful, even test task

Most of the code in lib/core is taken from my personal projects, so it might feel a bit overwhelming — not everything is used here
