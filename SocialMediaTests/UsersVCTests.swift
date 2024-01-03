//
//  SignOutTests.swift
//  SocialMediaTests
//
//  Created by bartek on 03/01/2024.
//

import XCTest
@testable import SocialMedia

final class UsersVCTests: XCTestCase {

    var sut: UsersVC!
    var chatStoryboard: UIStoryboard!
    var mainStoryboard: UIStoryboard!
    var navigationController: UINavigationController!

    
    override func setUpWithError() throws {
        chatStoryboard = UIStoryboard(name: "Chat", bundle: nil)
        mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        sut = chatStoryboard.instantiateViewController(identifier: "UsersVC")
        navigationController = UINavigationController(rootViewController: sut)
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        chatStoryboard = nil
        mainStoryboard = nil
        sut = nil
    }

    func testLogOutButton_action_ShouldGoToWelcomeVC() throws {
        let predicate = NSPredicate { input, _ in
            return (input as? UINavigationController)?.topViewController is WelcomeVC
        }
        
        expectation(for: predicate, evaluatedWith: navigationController)
        
        sut.logOutButton.sendActions(for: .touchUpInside)
        XCTAssertNotNil(sut.logOutButton)
         
        waitForExpectations(timeout: 1.5)
    }

}
