//
//  Defaults.swift
//  hello
//
//  Created by Erik Gomez on 6/10/21.
//

import Foundation

let helloDefaults = UserDefaults.standard
let helloJSONPreferences = Utils().getHelloJSONPreferences()
let helloRefreshCycleTimer = Timer.publish(every: Double(2.0), on: .main, in: .common).autoconnect()
let deviceStagesJSON = getDeviceStagesJSON()
let userExperienceJSON = getUserExperienceJSON()

// userExperience
let aboutURL = userExperienceJSON?.aboutURL ?? "https://github.com/erikng/hello"
let companyLogoPath = userExperienceJSON?.companyLogoPath ?? ""
let exitScreenBodyText = userExperienceJSON?.exitScreenBodyText ?? "Your Mac has been successfully configured. Below are a few resources to help you get started."
let exitText = userExperienceJSON?.exitText ?? "Setup complete"
let disableWelcomeScreen = userExperienceJSON?.disableWelcomeScreen ?? false
let disableExitScreen = userExperienceJSON?.disableExitScreen ?? false
let enableWelcomeScreenTimer = userExperienceJSON?.enableWelcomeScreenTimer ?? false
let exitScreenItem1ButtonText = userExperienceJSON?.exitScreenItem1ButtonText ?? ""
let exitScreenItem1DescriptionText = userExperienceJSON?.exitScreenItem1DescriptionText ?? ""
let exitScreenItem1ImagePath = userExperienceJSON?.exitScreenItem1ImagePath ?? ""
let exitScreenItem1LaunchURL = userExperienceJSON?.exitScreenItem1LaunchURL ?? ""
let exitScreenItem1Title = userExperienceJSON?.exitScreenItem1Title ?? ""
let exitScreenItem2ButtonText = userExperienceJSON?.exitScreenItem2ButtonText ?? ""
let exitScreenItem2DescriptionText = userExperienceJSON?.exitScreenItem2DescriptionText ?? ""
let exitScreenItem2ImagePath = userExperienceJSON?.exitScreenItem2ImagePath ?? ""
let exitScreenItem2LaunchURL = userExperienceJSON?.exitScreenItem2LaunchURL ?? ""
let exitScreenItem2Title = userExperienceJSON?.exitScreenItem2Title ?? ""
let exitScreenItem3ButtonText = userExperienceJSON?.exitScreenItem3ButtonText ?? ""
let exitScreenItem3DescriptionText = userExperienceJSON?.exitScreenItem3DescriptionText ?? ""
let exitScreenItem3ImagePath = userExperienceJSON?.exitScreenItem3ImagePath ?? ""
let exitScreenItem3LaunchURL = userExperienceJSON?.exitScreenItem3LaunchURL ?? ""
let exitScreenItem3Title = userExperienceJSON?.exitScreenItem3Title ?? ""
let provisioningBodyText = userExperienceJSON?.provisioningBodyText ?? "Your Mac is being automatically configured by your organization. This process may take some time to complete. Please don't attempt to restart or shut down the computer unless you are prompted to do so."
let provisioningHeaderText = userExperienceJSON?.provisioningHeaderText ?? "Setting up your Mac..."
let quitButtonText = userExperienceJSON?.quitButtonText ?? "Quit"
let restartButtonText = userExperienceJSON?.restartButtonText ?? "Restart"
let restartStyle = userExperienceJSON?.restartStyle ?? "None"
let welcomeButtonText = userExperienceJSON?.welcomeButtonText ?? "Continue"
let welcomeHeaderText = userExperienceJSON?.welcomeHeaderText ?? "Welcome to"
let welcomeSubHeaderText = userExperienceJSON?.welcomeSubHeaderText ?? "hello"
let welcomeScreenItem1DescriptionText = userExperienceJSON?.welcomeScreenItem1DescriptionText ?? "Multiple settings are being configured, tailored to make your first day exceptional."
let welcomeScreenItem1SymbolName = userExperienceJSON?.welcomeScreenItem1SymbolName ?? "gear.circle"
let welcomeScreenItem1Title = userExperienceJSON?.welcomeScreenItem1Title ?? "Configurations"
let welcomeScreenItem2DescriptionText = userExperienceJSON?.welcomeScreenItem2DescriptionText ?? "While Apple has world class applications built in to macOS, we know that some of your favorite business applications still need to be added. Some are installing now, but checkout our self service application for even more."
let welcomeScreenItem2SymbolName = userExperienceJSON?.welcomeScreenItem2SymbolName ?? "slider.horizontal.below.rectangle"
let welcomeScreenItem2Title = userExperienceJSON?.welcomeScreenItem2Title ?? "Applications"
let welcomeScreenItem3DescriptionText = userExperienceJSON?.welcomeScreenItem3DescriptionText ?? "By applying security policies, we ensure that your device is fully up to date with the latest updates, all while still valuing your privacy."
let welcomeScreenItem3SymbolName = userExperienceJSON?.welcomeScreenItem3SymbolName ?? "mappin.circle"
let welcomeScreenItem3Title = userExperienceJSON?.welcomeScreenItem3Title ?? "Secure"
let welcomeTimer = userExperienceJSON?.welcomeTimer ?? 60

// deviceStages
let deviceStages = deviceStagesJSON ?? []

func getUserExperienceJSON() -> UserExperience? {
    if let userExperience = helloJSONPreferences?.userExperience {
        return userExperience
    } else {
        return nil
    }
}

func getDeviceStagesJSON() -> [DeviceStage]? {
    if let deviceStages = helloJSONPreferences?.deviceStages {
        return deviceStages
    } else {
        return nil
    }
}

