//
//  PuzzleGameSpec.m
//  XingCrossword
//
//  Created by Sherlock on 7/9/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CoreData+MagicalRecord.h"
#import "PuzzleGame.h"

@interface PuzzleGameSpec : XCTestCase

@end

@implementation PuzzleGameSpec

- (void)setUp {
  [super setUp];
  [MagicalRecord setupCoreDataStackWithInMemoryStore];
}

- (void)tearDown {
  [MagicalRecord cleanUp];
  [super tearDown];
}

- (void)testInitWithPuzzleAndSize {
  PuzzleGame *game = [[PuzzleGame alloc] initWithPuzzle:nil size:CGSizeMake(0, 0)];
  XCTAssertNotNil(game, @"Game should be init successfully");
}

- (void)testGetRowsCount {
  Puzzle *puzzle = [Puzzle MR_createEntity];
  puzzle.map = @"101010,111110,001111";
  PuzzleGame *game = [[PuzzleGame alloc] initWithPuzzle:puzzle size:CGSizeMake(10, 10)];
  XCTAssertEqual(3, [game rowsCount], @"Game should return correct count of rows");
}

- (void)testGetColumnsCount {
  Puzzle *puzzle = [Puzzle MR_createEntity];
  puzzle.map = @"10101011,11101110,00110011, 01010101";
  PuzzleGame *game = [[PuzzleGame alloc] initWithPuzzle:puzzle size:CGSizeMake(10, 10)];
  XCTAssertEqual(8, [game columnsCount], @"Game should return correct count of columns");
}

@end
