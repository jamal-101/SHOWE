# Missing Usage Descriptions in Info.plist

The app upload to App Store Connect failed because the `Info.plist` file is missing the required purpose strings for camera and photo library access. This is mandatory when the app or its dependencies (like `image_picker`, `camera`, etc.) reference these APIs.

## User Review Required

> [!IMPORTANT]
> I will add generic but clear purpose strings for camera and photo library access. Please review if these descriptions accurately reflect how your app uses these features.

## Proposed Changes

### iOS Runner

#### [MODIFY] [Info.plist](file:///Users/binarybirds/StudioProjects/digital-Event/ios/Runner/Info.plist)

- Add `NSCameraUsageDescription`: "This app needs camera access to take photos for event registration and profile updates."
- Add `NSPhotoLibraryUsageDescription`: "This app needs photo library access to upload photos for event registration and profile updates."

## Verification Plan

### Manual Verification
- Verify that the `Info.plist` file contains the new keys and strings.
- The user will need to rebuild and re-upload the app to App Store Connect to confirm the fix.
