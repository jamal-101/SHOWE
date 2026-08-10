# Update iOS Minimum Deployment Target

The app was uploaded with a warning because the minimum iOS version (13.0) is becoming obsolete. We need to update it to at least 15.0 to comply with future App Store requirements.

## Proposed Changes

### iOS Runner Project

#### [MODIFY] [project.pbxproj](file:///Users/binarybirds/StudioProjects/digital-Event/ios/Runner.xcodeproj/project.pbxproj)
- Update `IPHONEOS_DEPLOYMENT_TARGET` from `13.0` to `15.0` across all build configurations (Debug, Release, Profile).

## Verification Plan

### Manual Verification
- Verify that `IPHONEOS_DEPLOYMENT_TARGET` is set to `15.0` in the `project.pbxproj` file.
- The user should build the archive again and verify that the warning no longer appears in the App Store Connect upload log.
