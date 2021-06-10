//
//  Preferences Structure.swift
//  hello
//
//  Created by Erik Gomez on 6/10/21.
//

import Foundation

// MARK: - HelloPreferences
struct HelloPreferences: Codable {
    let userExperience: UserExperience
    let deviceStages: [DeviceStage]
}

// MARK: HelloPreferences convenience initializers and mutators

extension HelloPreferences {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(HelloPreferences.self, from: data)
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
        userExperience: UserExperience? = nil,
        deviceStages: [DeviceStage]? = nil
    ) -> HelloPreferences {
        return HelloPreferences(
            userExperience: userExperience ?? self.userExperience,
            deviceStages: deviceStages ?? self.deviceStages
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - DeviceStage
struct DeviceStage: Codable {
    let title, iconPath, installedPath: String
}

// MARK: DeviceStage convenience initializers and mutators

extension DeviceStage {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DeviceStage.self, from: data)
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
        title: String? = nil,
        iconPath: String? = nil,
        installedPath: String? = nil
    ) -> DeviceStage {
        return DeviceStage(
            title: title ?? self.title,
            iconPath: iconPath ?? self.iconPath,
            installedPath: installedPath ?? self.installedPath
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - UserExperience
struct UserExperience: Codable {
    let companyLogoPath: String
    let disableWelcomeScreen: Bool
    let aboutURL: String
    let header: String
    let body: String
    let welcomeHeader: String
    let welcomeBody: String
    let welcomeButton: String
    let welcomeScreenItem1Title: String
    let welcomeScreenItem1Description: String
    let welcomeScreenItem1ImageName: String
    let welcomeScreenItem2Title: String
    let welcomeScreenItem2Description: String
    let welcomeScreenItem2ImageName: String
    let welcomeScreenItem3Title: String
    let welcomeScreenItem3Description: String
    let welcomeScreenItem3ImageName: String
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
        companyLogoPath: String? = nil,
        disableWelcomeScreen: Bool? = nil,
        aboutURL: String? = nil,
        header: String? = nil,
        body: String? = nil,
        welcomeHeader: String? = nil,
        welcomeBody: String? = nil,
        welcomeButton: String? = nil,
        welcomeScreenItem1Title: String? = nil,
        welcomeScreenItem1Description: String? = nil,
        welcomeScreenItem1ImageName: String? = nil,
        welcomeScreenItem2Title: String? = nil,
        welcomeScreenItem2Description: String? = nil,
        welcomeScreenItem2ImageName: String? = nil,
        welcomeScreenItem3Title: String? = nil,
        welcomeScreenItem3Description: String? = nil,
        welcomeScreenItem3ImageName: String? = nil
    ) -> UserExperience {
        return UserExperience(
            companyLogoPath: companyLogoPath ?? self.companyLogoPath,
            disableWelcomeScreen: disableWelcomeScreen ?? self.disableWelcomeScreen,
            aboutURL: aboutURL ?? self.aboutURL,
            header: header ?? self.header,
            body: body ?? self.body,
            welcomeHeader: welcomeHeader ?? self.welcomeHeader,
            welcomeBody: welcomeBody ?? self.welcomeBody,
            welcomeButton: welcomeButton ?? self.welcomeButton,
            welcomeScreenItem1Title: welcomeScreenItem1Title ?? self.welcomeScreenItem1Title,
            welcomeScreenItem1Description: welcomeScreenItem1Description ?? self.welcomeScreenItem1Description,
            welcomeScreenItem1ImageName: welcomeScreenItem1Description ?? self.welcomeScreenItem1Description,
            welcomeScreenItem2Title: welcomeScreenItem1Title ?? self.welcomeScreenItem1Title,
            welcomeScreenItem2Description: welcomeScreenItem1Description ?? self.welcomeScreenItem1Description,
            welcomeScreenItem2ImageName: welcomeScreenItem1Description ?? self.welcomeScreenItem1Description,
            welcomeScreenItem3Title: welcomeScreenItem1Title ?? self.welcomeScreenItem1Title,
            welcomeScreenItem3Description: welcomeScreenItem1Description ?? self.welcomeScreenItem1Description,
            welcomeScreenItem3ImageName: welcomeScreenItem1Description ?? self.welcomeScreenItem1Description
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
