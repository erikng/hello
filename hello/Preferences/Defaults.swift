//
//  Defaults.swift
//  hello
//
//  Created by Erik Gomez on 6/10/21.
//

import Foundation

// Dynamic SF Symbols based on macOS version
class PrefsWrapper {
    var welcomeScreenItem1SymbolName: String
    var pendingApplicationState: String
    
    init() {
        welcomeScreenItem1SymbolName = userExperienceJSON?.welcomeScreenItem1SymbolName ?? "gear.circle"
        pendingApplicationState = "circle.dashed.inset.filled"
    }
}

// Define default values as constants or a struct for easier maintenance
struct DefaultValues {
    static let exitScreenItem1ButtonText = "LAUNCH"
    static let exitScreenItem1DescriptionText = "Easily install apps and tools provided by your IT department."
    static let exitScreenItem1ImagePath = "file:///Applications/Safari.app/Contents/Resources/AppIcon.icns"
    static let exitScreenItem1LaunchURL = "file:///Applications/Safari.app"
    static let exitScreenItem1Title = "Self Service"
    static let exitScreenItem2ButtonText = "OPEN"
    static let exitScreenItem2DescriptionText = "Everything you need to know to start using your new Mac."
    static let exitScreenItem2ImagePath = "file:///System/Library/CoreServices/Finder.app/Contents/Resources/Finder.icns"
    static let exitScreenItem2LaunchURL = "https://support.apple.com/guide/mac-help/welcome/mac"
    static let exitScreenItem2Title = "macOS User Guide"
    static let exitScreenItem3ButtonText = "UPDATE"
    static let exitScreenItem3DescriptionText = "Updates may be available for your Mac. It is encouraged to install them."
    static let exitScreenItem3ImagePath = "file:///System/Library/CoreServices/ControlCenter.app/Contents/Resources/AppIcon.icns"
    static let exitScreenItem3LaunchURL = "file:///System/Library/PreferencePanes/SoftwareUpdate.prefPane"
    static let exitScreenItem3Title = "Software Updates"
    
    static let welcomeScreenItem1DescriptionText = "Multiple settings are being configured, tailored to make your first day exceptional."
    static let welcomeScreenItem1SymbolName = "gear.circle"
    static let welcomeScreenItem1Title = "Configurations"
    static let welcomeScreenItem2DescriptionText = "While Apple has world class applications built in to macOS, we know that some of your favorite business applications still need to be added. Some are installing now, but checkout our self service application for even more."
    static let welcomeScreenItem2SymbolName = "slider.horizontal.below.rectangle"
    static let welcomeScreenItem2Title = "Applications"
    static let welcomeScreenItem3DescriptionText = "By applying security policies, we ensure that your device is fully up to date with the latest updates, all while still valuing your privacy."
    static let welcomeScreenItem3SymbolName = "mappin.circle"
    static let welcomeScreenItem3Title = "Secure"
    
    static let companyLogoPath = "" // Add default company logo path if available
    static let companyLogoPath2 = "" // Add default secondary company logo path if available
    
    static let aboutURL = "https://github.com/erikng/hello" // Default value for aboutURL
    static let provisioningHeaderText = "Setting up your Mac..." // Default value for provisioningHeaderText
    static let provisioningBodyText = "Your Mac is being automatically configured by your organization. This process may take some time to complete. Please don't attempt to restart or shut down the computer unless you are prompted to do so." // Default value for provisioningBodyText
    static let welcomeSubHeaderText = "hello" // Default value for welcomeSubHeaderText
    static let exitText = "Setup complete" // Default value for exitText
    static let quitButtonText = "Quit" // Default value for quitButtonText
    static let restartButtonText = "Restart" // Default value for restartButtonText
    
    static let disableExitScreen = false // Default value for disableExitScreen
    static let restartStyle = "default" // Default value for restartStyle
    static let disableWelcomeScreen = false // Default value for disableWelcomeScreen
    static let enableWelcomeScreenTimer = true // Default value for enableWelcomeScreenTimer
    static let welcomeButtonText = "Start" // Default value for welcomeButtonText
    static let welcomeHeaderText = "Welcome" // Default value for welcomeHeaderText
    
    static let exitScreenBodyText = "Your exit process is complete. Please follow any additional instructions if provided." // Default value for exitScreenBodyText
}

// Define a function to fetch values with defaults
func getUserExperienceValue<T>(_ keyPath: KeyPath<UserExperience, T?>, defaultValue: T) -> T {
    return userExperienceJSON?[keyPath: keyPath] ?? defaultValue
}

// Setup UserExperience JSON and DeviceStage JSON
let helloDefaults = UserDefaults.standard
let dynamicOSPreferences = PrefsWrapper()
let helloJSONPreferences = Utils().getHelloJSONPreferences()
let helloRefreshCycleTimer = Timer.publish(every: 2.0, on: .main, in: .common).autoconnect()
let deviceStagesJSON = getDeviceStagesJSON()
let userExperienceJSON = getUserExperienceJSON()

// Fetch values using the function
let exitScreenItem1ButtonText = getUserExperienceValue(\.exitScreenItem1ButtonText, defaultValue: DefaultValues.exitScreenItem1ButtonText)
let exitScreenItem1DescriptionText = getUserExperienceValue(\.exitScreenItem1DescriptionText, defaultValue: DefaultValues.exitScreenItem1DescriptionText)
let exitScreenItem1ImagePath = getUserExperienceValue(\.exitScreenItem1ImagePath, defaultValue: DefaultValues.exitScreenItem1ImagePath)
let exitScreenItem1LaunchURL = getUserExperienceValue(\.exitScreenItem1LaunchURL, defaultValue: DefaultValues.exitScreenItem1LaunchURL)
let exitScreenItem1Title = getUserExperienceValue(\.exitScreenItem1Title, defaultValue: DefaultValues.exitScreenItem1Title)

let exitScreenItem2ButtonText = getUserExperienceValue(\.exitScreenItem2ButtonText, defaultValue: DefaultValues.exitScreenItem2ButtonText)
let exitScreenItem2DescriptionText = getUserExperienceValue(\.exitScreenItem2DescriptionText, defaultValue: DefaultValues.exitScreenItem2DescriptionText)
let exitScreenItem2ImagePath = getUserExperienceValue(\.exitScreenItem2ImagePath, defaultValue: DefaultValues.exitScreenItem2ImagePath)
let exitScreenItem2LaunchURL = getUserExperienceValue(\.exitScreenItem2LaunchURL, defaultValue: DefaultValues.exitScreenItem2LaunchURL)
let exitScreenItem2Title = getUserExperienceValue(\.exitScreenItem2Title, defaultValue: DefaultValues.exitScreenItem2Title)

let exitScreenItem3ButtonText = getUserExperienceValue(\.exitScreenItem3ButtonText, defaultValue: DefaultValues.exitScreenItem3ButtonText)
let exitScreenItem3DescriptionText = getUserExperienceValue(\.exitScreenItem3DescriptionText, defaultValue: DefaultValues.exitScreenItem3DescriptionText)
let exitScreenItem3ImagePath = getUserExperienceValue(\.exitScreenItem3ImagePath, defaultValue: DefaultValues.exitScreenItem3ImagePath)
let exitScreenItem3LaunchURL = getUserExperienceValue(\.exitScreenItem3LaunchURL, defaultValue: DefaultValues.exitScreenItem3LaunchURL)
let exitScreenItem3Title = getUserExperienceValue(\.exitScreenItem3Title, defaultValue: DefaultValues.exitScreenItem3Title)

let welcomeScreenItem1DescriptionText = getUserExperienceValue(\.welcomeScreenItem1DescriptionText, defaultValue: DefaultValues.welcomeScreenItem1DescriptionText)
let welcomeScreenItem1SymbolName = dynamicOSPreferences.welcomeScreenItem1SymbolName
let welcomeScreenItem1Title = getUserExperienceValue(\.welcomeScreenItem1Title, defaultValue: DefaultValues.welcomeScreenItem1Title)

let welcomeScreenItem2DescriptionText = getUserExperienceValue(\.welcomeScreenItem2DescriptionText, defaultValue: DefaultValues.welcomeScreenItem2DescriptionText)
let welcomeScreenItem2SymbolName = getUserExperienceValue(\.welcomeScreenItem2SymbolName, defaultValue: DefaultValues.welcomeScreenItem2SymbolName)
let welcomeScreenItem2Title = getUserExperienceValue(\.welcomeScreenItem2Title, defaultValue: DefaultValues.welcomeScreenItem2Title)

let welcomeScreenItem3DescriptionText = getUserExperienceValue(\.welcomeScreenItem3DescriptionText, defaultValue: DefaultValues.welcomeScreenItem3DescriptionText)
let welcomeScreenItem3SymbolName = getUserExperienceValue(\.welcomeScreenItem3SymbolName, defaultValue: DefaultValues.welcomeScreenItem3SymbolName)
let welcomeScreenItem3Title = getUserExperienceValue(\.welcomeScreenItem3Title, defaultValue: DefaultValues.welcomeScreenItem3Title)

let welcomeTimer = getUserExperienceValue(\.welcomeTimer, defaultValue: 60)

// Company logos
let companyLogoPath = getUserExperienceValue(\.companyLogoPath, defaultValue: DefaultValues.companyLogoPath)
let companyLogoPath2 = getUserExperienceValue(\.companyLogoPath2, defaultValue: DefaultValues.companyLogoPath2)

// Additional values
let aboutURL = getUserExperienceValue(\.aboutURL, defaultValue: DefaultValues.aboutURL)
let provisioningHeaderText = getUserExperienceValue(\.provisioningHeaderText, defaultValue: DefaultValues.provisioningHeaderText)
let provisioningBodyText = getUserExperienceValue(\.provisioningBodyText, defaultValue: DefaultValues.provisioningBodyText)
let welcomeSubHeaderText = getUserExperienceValue(\.welcomeSubHeaderText, defaultValue: DefaultValues.welcomeSubHeaderText)
let exitText = getUserExperienceValue(\.exitText, defaultValue: DefaultValues.exitText)
let quitButtonText = getUserExperienceValue(\.quitButtonText, defaultValue: DefaultValues.quitButtonText)
let restartButtonText = getUserExperienceValue(\.restartButtonText, defaultValue: DefaultValues.restartButtonText)
let disableExitScreen = getUserExperienceValue(\.disableExitScreen, defaultValue: DefaultValues.disableExitScreen)
let restartStyle = getUserExperienceValue(\.restartStyle, defaultValue: DefaultValues.restartStyle)
let disableWelcomeScreen = getUserExperienceValue(\.disableWelcomeScreen, defaultValue: DefaultValues.disableWelcomeScreen)
let enableWelcomeScreenTimer = getUserExperienceValue(\.enableWelcomeScreenTimer, defaultValue: DefaultValues.enableWelcomeScreenTimer)
let welcomeButtonText = getUserExperienceValue(\.welcomeButtonText, defaultValue: DefaultValues.welcomeButtonText)
let welcomeHeaderText = getUserExperienceValue(\.welcomeHeaderText, defaultValue: DefaultValues.welcomeHeaderText)
let exitScreenBodyText = getUserExperienceValue(\.exitScreenBodyText, defaultValue: DefaultValues.exitScreenBodyText)

// Device Stages
let deviceStages = deviceStagesJSON ?? []

// Functions to retrieve JSON
func getUserExperienceJSON() -> UserExperience? {
    return helloJSONPreferences?.userExperience
}

func getDeviceStagesJSON() -> [DeviceStage]? {
    return helloJSONPreferences?.deviceStages
}
