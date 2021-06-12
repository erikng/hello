//
//  Defaults.swift
//  hello
//
//  Created by Erik Gomez on 6/10/21.
//

import Foundation

let helloDefaults = UserDefaults.standard
let helloJSONPreferences = Utils().getHelloJSONPreferences()

// userExperience
let userExperienceJSON = getUserExperienceJSON()
let aboutURL = userExperienceJSON?.aboutURL ?? "https://github.com/erikng/hello"
let companyLogoPath = userExperienceJSON?.companyLogoPath ?? ""
let disableWelcomeScreen = userExperienceJSON?.disableWelcomeScreen ?? false
let enableExitScreen = userExperienceJSON?.enableExitScreen ?? true
let exitScreenItem1ButtonText = userExperienceJSON?.exitScreenItem1ButtonText ?? ""
let exitScreenItem1Description = userExperienceJSON?.exitScreenItem1Description ?? ""
let exitScreenItem1ImagePath = userExperienceJSON?.exitScreenItem1ImagePath ?? ""
let exitScreenItem1LaunchURL = userExperienceJSON?.exitScreenItem1LaunchURL ?? ""
let exitScreenItem1Title = userExperienceJSON?.exitScreenItem1Title ?? ""
let exitScreenItem2ButtonText = userExperienceJSON?.exitScreenItem2ButtonText ?? ""
let exitScreenItem2Description = userExperienceJSON?.exitScreenItem2Description ?? ""
let exitScreenItem2ImagePath = userExperienceJSON?.exitScreenItem2ImagePath ?? ""
let exitScreenItem2LaunchURL = userExperienceJSON?.exitScreenItem2LaunchURL ?? ""
let exitScreenItem2Title = userExperienceJSON?.exitScreenItem2Title ?? ""
let exitScreenItem3ButtonText = userExperienceJSON?.exitScreenItem3ButtonText ?? ""
let exitScreenItem3Description = userExperienceJSON?.exitScreenItem3Description ?? ""
let exitScreenItem3ImagePath = userExperienceJSON?.exitScreenItem3ImagePath ?? ""
let exitScreenItem3LaunchURL = userExperienceJSON?.exitScreenItem3LaunchURL ?? ""
let exitScreenItem3Title = userExperienceJSON?.exitScreenItem3Title ?? ""
let header = userExperienceJSON?.header ?? "Setting up your Mac..."
let bodyText = userExperienceJSON?.body ?? "Your Mac is being automatically configured by your organization. This process may take some time to complete. Please don't attempt to restart or shut down the computer unless you are prompted to do so."

let welcomeHeader = userExperienceJSON?.welcomeHeader ?? "Welcome to"
let welcomeBody = userExperienceJSON?.welcomeBody ?? "hello"
let welcomeButton = userExperienceJSON?.welcomeButton ?? "Continue"
let welcomeScreenItem1Title = userExperienceJSON?.welcomeScreenItem1Title ?? "Configurations"
let welcomeScreenItem1Description = userExperienceJSON?.welcomeScreenItem1Description ?? "Multiple settings are being configured, tailored to make your first day exceptional."
let welcomeScreenItem1ImageName = userExperienceJSON?.welcomeScreenItem1ImageName ?? "gear.circle"

let welcomeScreenItem2Title = userExperienceJSON?.welcomeScreenItem2Title ?? "Applications"
let welcomeScreenItem2Description = userExperienceJSON?.welcomeScreenItem2Description ?? "While Apple has world class applications built in to macOS, we know that some of your favorite business applications still need to be added. Some are installing now, but checkout our self service application for even more."
let welcomeScreenItem2ImageName = userExperienceJSON?.welcomeScreenItem2ImageName ?? "slider.horizontal.below.rectangle"

let welcomeScreenItem3Title = userExperienceJSON?.welcomeScreenItem3Title ?? "Secure"
let welcomeScreenItem3Description = userExperienceJSON?.welcomeScreenItem3Description ?? "By applying security policies, we ensure that your device is fully up to date with the latest updates, all while still valuing your privacy."
let welcomeScreenItem3ImageName = userExperienceJSON?.welcomeScreenItem3ImageName ?? "mappin.circle"

// deviceStages
let deviceStagesJSON = getDeviceStagesJSON()
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

