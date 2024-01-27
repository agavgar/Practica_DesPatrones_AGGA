//
//  Practica_DisPatrones_AGGATests.swift
//  Practica_DisPatrones_AGGATests
//
//  Created by Alejandro Alberto Gavira García on 22/1/24.
//

import XCTest
@testable import Practica_DisPatrones_AGGA

final class Practica_DisPatrones_AGGATests: XCTestCase {
    
    private var token: String?
    
    override func setUp() {
        super.setUp()
        print("SetUp para cada test")
    }
    
    override class func setUp() {
        super.setUp()
        print("SetUp para toda la clase")
    }
    
    override func tearDown() {
        super.tearDown()
        print("TearDown para cada test")
    }
    
    override class func tearDown() {
        super.tearDown()
        print("TearDown para toda la clase")
    }

    func test_HelloWorld() {
        token = "Hello World"
        
        XCTAssertEqual(token, "Hello World")
        XCTAssertNotEqual(token, "HolaMundo")
    }

    func test_notHelloWorld(){
        XCTAssertNil(token)
    }

}
