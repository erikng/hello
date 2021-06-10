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
    let id: Int
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
        id: Int? = nil,
        title: String? = nil,
        iconPath: String? = nil,
        installedPath: String? = nil
    ) -> DeviceStage {
        return DeviceStage(
            id: id ?? self.id,
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
    let aboutURL, body, companyLogoPath: String
    let disableWelcomeScreen: Bool
    let header, welcomeBody, welcomeButton, welcomeHeader: String
    let welcomeScreenItem1Description, welcomeScreenItem1ImageName, welcomeScreenItem1Title, welcomeScreenItem2Description: String
    let welcomeScreenItem2ImageName, welcomeScreenItem2Title, welcomeScreenItem3Description, welcomeScreenItem3ImageName: String
    let welcomeScreenItem3Title: String
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
        aboutURL: String? = nil,
        body: String? = nil,
        companyLogoPath: String? = nil,
        disableWelcomeScreen: Bool? = nil,
        header: String? = nil,
        welcomeBody: String? = nil,
        welcomeButton: String? = nil,
        welcomeHeader: String? = nil,
        welcomeScreenItem1Description: String? = nil,
        welcomeScreenItem1ImageName: String? = nil,
        welcomeScreenItem1Title: String? = nil,
        welcomeScreenItem2Description: String? = nil,
        welcomeScreenItem2ImageName: String? = nil,
        welcomeScreenItem2Title: String? = nil,
        welcomeScreenItem3Description: String? = nil,
        welcomeScreenItem3ImageName: String? = nil,
        welcomeScreenItem3Title: String? = nil
    ) -> UserExperience {
        return UserExperience(
            aboutURL: aboutURL ?? self.aboutURL,
            body: body ?? self.body,
            companyLogoPath: companyLogoPath ?? self.companyLogoPath,
            disableWelcomeScreen: disableWelcomeScreen ?? self.disableWelcomeScreen,
            header: header ?? self.header,
            welcomeBody: welcomeBody ?? self.welcomeBody,
            welcomeButton: welcomeButton ?? self.welcomeButton,
            welcomeHeader: welcomeHeader ?? self.welcomeHeader,
            welcomeScreenItem1Description: welcomeScreenItem1Description ?? self.welcomeScreenItem1Description,
            welcomeScreenItem1ImageName: welcomeScreenItem1ImageName ?? self.welcomeScreenItem1ImageName,
            welcomeScreenItem1Title: welcomeScreenItem1Title ?? self.welcomeScreenItem1Title,
            welcomeScreenItem2Description: welcomeScreenItem2Description ?? self.welcomeScreenItem2Description,
            welcomeScreenItem2ImageName: welcomeScreenItem2ImageName ?? self.welcomeScreenItem2ImageName,
            welcomeScreenItem2Title: welcomeScreenItem2Title ?? self.welcomeScreenItem2Title,
            welcomeScreenItem3Description: welcomeScreenItem3Description ?? self.welcomeScreenItem3Description,
            welcomeScreenItem3ImageName: welcomeScreenItem3ImageName ?? self.welcomeScreenItem3ImageName,
            welcomeScreenItem3Title: welcomeScreenItem3Title ?? self.welcomeScreenItem3Title
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
