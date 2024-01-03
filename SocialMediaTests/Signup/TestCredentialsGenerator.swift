//
//  TestCredentialsGenerator.swift
//  SocialMediaTests
//
//  Created by bartek on 22/12/2023.
//

import Foundation
@testable import SocialMedia

struct TestCredentialsGenerator {
    static func generateValidCredentials() -> SignupFormRequestModel {
        let validator = SignupFormModelValidator()

        // Generate random values for each field
        let firstName = randomString(length: Int.random(in: SignupConstants.firstNameMinLength...SignupConstants.firstNameMaxLength))
        let lastName = randomString(length: Int.random(in: SignupConstants.lastNameMinLength...SignupConstants.lastNameMaxLength))
        let email = randomEmail()
        let password = randomString(length: Int.random(in: SignupConstants.passwordMinLength...SignupConstants.passwordMaxLength))
        let repeatPassword = password  // For simplicity, repeatPassword is set to the same value

        // Validate the generated values
        guard validator.isFirstNameValid(firstName: firstName),
              validator.isLastNameValid(lastName: lastName),
              validator.isValidEmailFormat(email: email),
              validator.isPasswordValid(password: password),
              validator.doPasswordsMatch(password: password, repeatPassword: repeatPassword) else {
            // If generated values are not valid, recursively call the function to try again
            return generateValidCredentials()
        }

        // Return the valid credentials
        return SignupFormRequestModel(firstName: firstName, lastName: lastName, email: email, password: password, repeatPassword: repeatPassword)
    }

    // Helper function to generate a random string of a given length
    private static func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        return String((0..<length).map { _ in letters.randomElement()! })
    }

    // Helper function to generate a random email address
    private static func randomEmail() -> String {
        let username = randomString(length: 8)
        let domain = randomString(length: 5)
        return "\(username)@\(domain).com"
    }
}
