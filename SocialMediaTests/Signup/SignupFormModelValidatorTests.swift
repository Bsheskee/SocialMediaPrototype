//
//  SignupFormModelValidator.swift
//  SocialMediaTests
//
//  Created by bartek on 21/12/2023.
//

import XCTest
@testable import SocialMedia

final class SignupFormModelValidatorTests: XCTestCase {

    var sut: SignupFormModelValidator!

    
    override func setUpWithError() throws {
        sut = SignupFormModelValidator()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testSignFormModelValidator_WhenValidFirstNameProvided_ShouldReturnTrue() {
        
        // Arrange
        // Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "Bartek")
        
        // Assert
        XCTAssertTrue(isFirstNameValid, "The isFirstNameValid() should have returned TRUE for a valid first name but returned FALSE")
    }
    
    func testSignupFormModelValidator_WhenTooShortFirstNameProvided_ShouldReturnFalse() {
        
        // Arrange
        // Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "B")
        
        // Assert
        XCTAssertFalse(isFirstNameValid, "The isFirstNameValid() should have returned FALSE for a first name that is shorter than \(SignupConstants.firstNameMinLength) characters but it has returned TRUE")
        
    }
    
    func testSignupFormModelValidator_WhenTooLongFirstNameProvided_ShouldReturnFalse() {
        
        let isFirstNameValid = sut.isFirstNameValid(firstName: "SergeySergey")
        
        XCTAssertFalse(isFirstNameValid, "The isFirstNameValid() should have returned FALSE for a first name that is longer than \(SignupConstants.firstNameMaxLength) characters but it has returned TRUE")
    }
    func testSignupFormModelValidator_WhenLastNameTooShort_ShouldReturnFalse() {
        let isLastNameValid = sut.isLastNameValid(lastName: "B")
        
        XCTAssertFalse(isLastNameValid, "The isLastNameValid should have returned FALSE for a last name shorter than 2 characters \(SignupConstants.lastNameMinLength)")
    }
    
    func testSignupFormModelValidator_WhenLastNameTooLong_ShouldReturnFalse() {
        let isLastNameValid = sut.isLastNameValid(lastName: "BiałobrzewskiBiało")
        
        XCTAssertFalse(isLastNameValid, "The isLastNameValid should have returned FALSE for a last name longer than 12 characters \(SignupConstants.lastNameMaxLength)")
    }
    func testSignupFormModelValidator_WhenPasswordTooShort_ShouldReturnFalse() {
        let isPasswordValid = sut.isPasswordValid(password: "123456")
        
        XCTAssertFalse(isPasswordValid, "The isLastNameValid should have returned FALSE for a password shorter than 2 characters \(SignupConstants.passwordMinLength)")
    }
    
    func testSignupFormModelValidator_WhenPasswordTooLong_ShouldReturnFalse() {
        let isPasswordValid = sut.isPasswordValid(password: "123456789123456789")
        
        XCTAssertFalse(isPasswordValid, "The isLastNameValid should have returned FALSE for a password longer than 16 characters \(SignupConstants.passwordMaxLength)")
    }
    func testSignupFormModelValidator_WhenEmailValid_ShouldReturnTrue() {
        let isEmailValid = sut.isValidEmailFormat(email: "bartlomiejbialobrzewski@gmail.com")
        
        XCTAssertTrue(isEmailValid, "The isValidEmailFormat should have returned TRUE if the email has valid format")
    }
    func testSignupFormModelValidator_WhenPasswordsMatch_ShouldReturnTrue() {
        let doPasswordsMatch = sut.doPasswordsMatch(password: "password", repeatPassword: "password")
        
        XCTAssertTrue(doPasswordsMatch, "The doPasswordsMatch should have returned TRUE if they are equal")
    }
    func testSignupFormModelValidator_WhenPasswordsDoNotMatch_ShouldReturnFalse() {
        let doPasswordsMatch = sut.doPasswordsMatch(password: "password", repeatPassword: "myPassword")
        
        XCTAssertFalse(doPasswordsMatch, "The doPasswordsMatch should have returned TRUE if they are equal")
    }

}
