//
//  LoginUseCaseTest.swift
//  Practica_DisPatrones_AGGATests
//
//  Created by Alejandro Alberto Gavira García on 27/1/24.
//
import XCTest
@testable import Practica_DisPatrones_AGGA // Asegúrate de usar el nombre correcto de tu módulo

class LoginUseCaseTests: XCTestCase {

    func testLoginSuccess() {
        let loginUseCase = LoginUseCaseFakeSuccess()
        let expectation = self.expectation(description: "Login success")

        loginUseCase.login(user: "testUser", password: "testPassword") { result in
            if case .success(let token) = result {
                XCTAssertNotNil(token)
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testLoginFailure() {
        let loginUseCase = LoginUseCaseFakeError()
        let expectation = self.expectation(description: "Login failure")

        loginUseCase.login(user: "testUser", password: "testPassword") { result in
            if case .failure(let error) = result {
                XCTAssertEqual(error, .tokenNotFound)
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

}
