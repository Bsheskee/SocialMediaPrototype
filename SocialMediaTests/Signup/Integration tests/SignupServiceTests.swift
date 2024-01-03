//
//  SignupTests.swift
//  SocialMediaTests
//
//  Created by bartek on 22/12/2023.
//

import XCTest
@testable import SocialMedia

final class SignupServiceTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    ///this tests Firestore signup hence the connection to the Internet is needed
    func testSignup_WhenGivenUniqueCredentials_ReturnsSuccess() {

        let sut = SignupService()
        
        ///generator creates valid random credentials automatically in accordance to the validator and its constants
        let signFormRequestModel = TestCredentialsGenerator.generateValidCredentials()
        let expectation = self.expectation(description: "Signup service response expectation")
        
        sut.signup(withForm: signFormRequestModel) { (signupResult, error) in
            XCTAssertNil(error, "Expected no error")
            XCTAssertNotNil(signupResult, "Expected successful result")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }

}
