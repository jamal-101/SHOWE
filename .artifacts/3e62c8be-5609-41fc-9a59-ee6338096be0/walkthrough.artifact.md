# Walkthrough - Fixing App Store Upload Errors

I have added the mandatory usage descriptions to the iOS `Info.plist` file to resolve the "Missing purpose string" errors during App Store Connect upload.

## Changes Made

### iOS Runner

#### [Info.plist](file:///Users/binarybirds/StudioProjects/digital-Event/ios/Runner/Info.plist)
Added the following keys to satisfy Apple's privacy requirements for apps using camera and photo library APIs:
- `NSCameraUsageDescription`
- `NSPhotoLibraryUsageDescription`

```xml
    <!-- 🔹 Permissions for Camera and Photo Library -->
    <key>NSCameraUsageDescription</key>
    <string>This app needs camera access to take photos for event registration and profile updates.</string>
    <key>NSPhotoLibraryUsageDescription</key>
    <string>This app needs photo library access to upload photos for event registration and profile updates.</string>
```

## Verification Results

### Manual Verification
- Verified that the `Info.plist` file now contains the required `NSCameraUsageDescription` and `NSPhotoLibraryUsageDescription` keys.
- You can now rebuild your iOS app and re-upload it to App Store Connect. The errors should no longer appear.

> [!TIP]
> If your app uses other sensitive features (like Location, Microphone, or Contacts) in the future, remember to add similar usage descriptions to avoid build rejections.
