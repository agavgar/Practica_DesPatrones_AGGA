//
//  GenericArrayUseCaseTest.swift
//  Practica_DisPatrones_AGGATests
//
//  Created by Alejandro Alberto Gavira García on 27/1/24.
//

import XCTest
@testable import Practica_DisPatrones_AGGA // Asegúrate de usar el nombre correcto de tu módulo

class GenericArrayUseCaseTests: XCTestCase {

    func testGenericArrayUseCaseSuccess() {
        let useCase = GenericArrayUseCaseSucces()
        let expectation = self.expectation(description: "Generic array use case success")

        useCase.login(endpoint: "heroes", dataRequest: "name", value: "Goku") { (result: Result<[DragonBallHero], NetworkErrors>) in
            if case .success(let heroes) = result {
                XCTAssertFalse(heroes.isEmpty, "La lista de héroes no debe estar vacía")
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testGenericArrayUseCaseFailure() {
        let useCase = GenericArrayUseCaseFail()
        let expectation = self.expectation(description: "Generic array use case failure")

        useCase.login(endpoint: "heroes", dataRequest: "name", value: "Goku") { (result: Result<[DragonBallHero], NetworkErrors>) in
            if case .failure(let error) = result {
                XCTAssertEqual(error, .malformedURL, "El error esperado es malformedURL")
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

}
