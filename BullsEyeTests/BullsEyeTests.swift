//
//  BullsEyeTests.swift
//  BullsEyeTests
//
//  Created by fpc on 10/07/24.
//  Copyright © 2024 Ray Wenderlich. All rights reserved.
//

import XCTest
@testable import BullsEye

final class BullsEyeTests: XCTestCase {

    var gameUnderTest: BullsEyeGame!
    
    override func setUpWithError() throws {
        gameUnderTest = BullsEyeGame()
        gameUnderTest.startNewGame()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testScoreIsComputedWhenGuessIsGreaterThanTarget() throws {
        //given
        let guess = gameUnderTest.targetValue + 5
        
        //when
        _ = gameUnderTest.check(guess: guess)
        
        //then
        XCTAssertEqual(gameUnderTest.scoreRound, 95, "Score computed is wrong")
    }
    
    func testScoreIsComputedWhenGuessIsLowerThanTarget() throws {
        //given
        let guess = gameUnderTest.targetValue - 5
        
        //when
        _ = gameUnderTest.check(guess: guess)
        
        //then
        XCTAssertEqual(gameUnderTest.scoreRound, 95, "Score computed is wrong")
    }
    
    func testValidateFirstRound() throws { // #1
        var expectedRoundCount = 1
        var count = 10
        
        while (count >= 0) {
            XCTAssertEqual(gameUnderTest.round, expectedRoundCount, "Round incremented is wrong after start new round")
            gameUnderTest.startNewRound()
            count -= 1
            expectedRoundCount += 1
        }
    }
    
    func testValidateStartOverFunction() throws { // #2
        //given
        _ = gameUnderTest.round + 3
        _ = gameUnderTest.scoreTotal + 80
        
        //when
        gameUnderTest.startNewGame()
        
        //then
        XCTAssertEqual(gameUnderTest.round, 1, "Round computed is wrong after start over")
        XCTAssertEqual(gameUnderTest.scoreTotal, 0, "Score Total computed is wrong after start over")
    }
    
    func testValidateIfScoreIsBetween0And100() throws { // #3
        //given
        let guesses = [-1, 0, 25, 100, 101]
        
        for guess in guesses {
            //when
            _ = gameUnderTest.check(guess: guess)
            
            //then
            XCTAssertTrue(gameUnderTest.scoreRound >= 0 && gameUnderTest.scoreRound <= 100, "Score round computed is not between 0 and 100")
        }
      }
}
