//
//  Preferences Structure.swift
//  hello
//
//  Created by Erik Gomez on 6/10/21.
//

import Foundation

// MARK: - HelloPreferences
struct HelloPreferences: Codable {
    let userExperience: UserExperience?
    let deviceStages: [DeviceStage]?
}

// MARK: HelloPreferences Convenience Initializers and Mutators
extension HelloPreferences {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(HelloPreferences.self, from: data)
    }

    init(json: String, encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON string encoding"])
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: Data(contentsOf: url))
    }

    func with(
        userExperience: UserExperience? = nil,
        deviceStages: [DeviceStage]? = nil
    ) -> HelloPreferences {
        HelloPreferences(
            userExperience: userExperience ?? self.userExperience,
            deviceStages: deviceStages ?? self.deviceStages
        )
    }

    func jsonData() throws -> Data {
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - DeviceStage
struct DeviceStage: Codable, Identifiable, Hashable {
    let id: Int
    let title, iconPath, installedPath: String
}

// MARK: DeviceStage Convenience Initializers and Mutators
extension DeviceStage {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DeviceStage.self, from: data)
    }

    init(json: String, encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON string encoding"])
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: Data(contentsOf: url))
    }

    func with(
        id: Int,
        title: String,
        iconPath: String,
        installedPath: String
    ) -> DeviceStage {
        DeviceStage(id: id, title: title, iconPath: iconPath, installedPath: installedPath)
    }

    func jsonData() throws -> Data {
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - UserExperience
struct UserExperience: Codable {
    // Exit Screen Items
    var exitScreenItem1ButtonText: String?
    var exitScreenItem1DescriptionText: String?
    var exitScreenItem1ImagePath: String?
    var exitScreenItem1LaunchURL: String?
    var exitScreenItem1Title: String?
    
    var exitScreenItem2ButtonText: String?
    var exitScreenItem2DescriptionText: String?
    var exitScreenItem2ImagePath: String?
    var exitScreenItem2LaunchURL: String?
    var exitScreenItem2Title: String?
    
    var exitScreenItem3ButtonText: String?
    var exitScreenItem3DescriptionText: String?
    var exitScreenItem3ImagePath: String?
    var exitScreenItem3LaunchURL: String?
    var exitScreenItem3Title: String?
    
    // Welcome Screen Items
    var welcomeScreenItem1DescriptionText: String?
    var welcomeScreenItem1SymbolName: String?
    var welcomeScreenItem1Title: String?
    
    var welcomeScreenItem2DescriptionText: String?
    var welcomeScreenItem2SymbolName: String?
    var welcomeScreenItem2Title: String?
    
    var welcomeScreenItem3DescriptionText: String?
    var welcomeScreenItem3SymbolName: String?
    var welcomeScreenItem3Title: String?
    
    // Other parameters
    var aboutURL: String?
    var companyLogoPath: String?
    var companyLogoPath2: String?
    var exitScreenBodyText: String?
    var exitText: String?
    var disableWelcomeScreen: Bool?
    var disableExitScreen: Bool?
    var enableWelcomeScreenTimer: Bool?
    var provisioningBodyText: String?
    var provisioningHeaderText: String?
    var quitButtonText: String?
    var restartButtonText: String?
    var restartStyle: String?
    var welcomeButtonText: String?
    var welcomeHeaderText: String?
    var welcomeSubHeaderText: String?
    var welcomeTimer: Int?
}

// MARK: UserExperience convenience initializers and mutators

extension UserExperience {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(UserExperience.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        exitScreenItem1ButtonText: String?? = nil,
        exitScreenItem1DescriptionText: String?? = nil,
        exitScreenItem1ImagePath: String?? = nil,
        exitScreenItem1LaunchURL: String?? = nil,
        exitScreenItem1Title: String?? = nil,
        exitScreenItem2ButtonText: String?? = nil,
        exitScreenItem2DescriptionText: String?? = nil,
        exitScreenItem2ImagePath: String?? = nil,
        exitScreenItem2LaunchURL: String?? = nil,
        exitScreenItem2Title: String?? = nil,
        exitScreenItem3ButtonText: String?? = nil,
        exitScreenItem3DescriptionText: String?? = nil,
        exitScreenItem3ImagePath: String?? = nil,
        exitScreenItem3LaunchURL: String?? = nil,
        exitScreenItem3Title: String?? = nil,
        welcomeScreenItem1DescriptionText: String?? = nil,
        welcomeScreenItem1SymbolName: String?? = nil,
        welcomeScreenItem1Title: String?? = nil,
        welcomeScreenItem2DescriptionText: String?? = nil,
        welcomeScreenItem2SymbolName: String?? = nil,
        welcomeScreenItem2Title: String?? = nil,
        welcomeScreenItem3DescriptionText: String?? = nil,
        welcomeScreenItem3SymbolName: String?? = nil,
        welcomeScreenItem3Title: String?? = nil,
        aboutURL: String?? = nil,
        companyLogoPath: String?? = nil,
        companyLogoPath2: String?? = nil,
        exitScreenBodyText: String?? = nil,
        exitText: String?? = nil,
        disableWelcomeScreen: Bool?? = nil,
        disableExitScreen: Bool?? = nil,
        enableWelcomeScreenTimer: Bool?? = nil,
        provisioningBodyText: String?? = nil,
        provisioningHeaderText: String?? = nil,
        quitButtonText: String?? = nil,
        restartButtonText: String?? = nil,
        restartStyle: String?? = nil,
        welcomeButtonText: String?? = nil,
        welcomeHeaderText: String?? = nil,
        welcomeSubHeaderText: String?? = nil,
        welcomeTimer: Int?? = nil
    ) -> UserExperience {
        return UserExperience(
            exitScreenItem1ButtonText: exitScreenItem1ButtonText ?? self.exitScreenItem1ButtonText,
            exitScreenItem1DescriptionText: exitScreenItem1DescriptionText ?? self.exitScreenItem1DescriptionText,
            exitScreenItem1ImagePath: exitScreenItem1ImagePath ?? self.exitScreenItem1ImagePath,
            exitScreenItem1LaunchURL: exitScreenItem1LaunchURL ?? self.exitScreenItem1LaunchURL,
            exitScreenItem1Title: exitScreenItem1Title ?? self.exitScreenItem1Title,
            exitScreenItem2ButtonText: exitScreenItem2ButtonText ?? self.exitScreenItem2ButtonText,
            exitScreenItem2DescriptionText: exitScreenItem2DescriptionText ?? self.exitScreenItem2DescriptionText,
            exitScreenItem2ImagePath: exitScreenItem2ImagePath ?? self.exitScreenItem2ImagePath,
            exitScreenItem2LaunchURL: exitScreenItem2LaunchURL ?? self.exitScreenItem2LaunchURL,
            exitScreenItem2Title: exitScreenItem2Title ?? self.exitScreenItem2Title,
            exitScreenItem3ButtonText: exitScreenItem3ButtonText ?? self.exitScreenItem3ButtonText,
            exitScreenItem3DescriptionText: exitScreenItem3DescriptionText ?? self.exitScreenItem3DescriptionText,
            exitScreenItem3ImagePath: exitScreenItem3ImagePath ?? self.exitScreenItem3ImagePath,
            exitScreenItem3LaunchURL: exitScreenItem3LaunchURL ?? self.exitScreenItem3LaunchURL,
            exitScreenItem3Title: exitScreenItem3Title ?? self.exitScreenItem3Title,
            welcomeScreenItem1DescriptionText: welcomeScreenItem1DescriptionText ?? self.welcomeScreenItem1DescriptionText,
            welcomeScreenItem1SymbolName: welcomeScreenItem1SymbolName ?? self.welcomeScreenItem1SymbolName,
            welcomeScreenItem1Title: welcomeScreenItem1Title ?? self.welcomeScreenItem1Title,
            welcomeScreenItem2DescriptionText: welcomeScreenItem2DescriptionText ?? self.welcomeScreenItem2DescriptionText,
            welcomeScreenItem2SymbolName: welcomeScreenItem2SymbolName ?? self.welcomeScreenItem2SymbolName,
            welcomeScreenItem2Title: welcomeScreenItem2Title ?? self.welcomeScreenItem2Title,
            welcomeScreenItem3DescriptionText: welcomeScreenItem3DescriptionText ?? self.welcomeScreenItem3DescriptionText,
            welcomeScreenItem3SymbolName: welcomeScreenItem3SymbolName ?? self.welcomeScreenItem3SymbolName,
            welcomeScreenItem3Title: welcomeScreenItem3Title ?? self.welcomeScreenItem3Title,
            aboutURL: aboutURL ?? self.aboutURL,
            companyLogoPath: companyLogoPath ?? self.companyLogoPath,
            companyLogoPath2: companyLogoPath2 ?? self.companyLogoPath2,
            exitScreenBodyText: exitScreenBodyText ?? self.exitScreenBodyText,
            exitText: exitText ?? self.exitText,
            disableWelcomeScreen: disableWelcomeScreen ?? self.disableWelcomeScreen,
            disableExitScreen: disableExitScreen ?? self.disableExitScreen,
            enableWelcomeScreenTimer: enableWelcomeScreenTimer ?? self.enableWelcomeScreenTimer,
            provisioningBodyText: provisioningBodyText ?? self.provisioningBodyText,
            provisioningHeaderText: provisioningHeaderText ?? self.provisioningHeaderText,
            quitButtonText: quitButtonText ?? self.quitButtonText,
            restartButtonText: restartButtonText ?? self.restartButtonText,
            restartStyle: restartStyle ?? self.restartStyle,
            welcomeButtonText: welcomeButtonText ?? self.welcomeButtonText,
            welcomeHeaderText: welcomeHeaderText ?? self.welcomeHeaderText,
            welcomeSubHeaderText: welcomeSubHeaderText ?? self.welcomeSubHeaderText,
            welcomeTimer: welcomeTimer ?? self.welcomeTimer
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ExitScreenItem
struct ExitScreenItem: Codable {
    let buttonText, descriptionText, imagePath, launchURL, title: String?
}

// MARK: - WelcomeScreenItem
struct WelcomeScreenItem: Codable {
    let descriptionText, symbolName, title: String?
}


// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    return encoder
}
