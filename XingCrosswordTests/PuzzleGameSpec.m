//
//  PuzzleGameSpec.m
//  XingCrossword
//
//  Created by Sherlock on 7/9/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PuzzleGame.h"

@interface PuzzleGameSpec : XCTestCase

@end

@implementation PuzzleGameSpec

- (void)setUp {
  [super setUp];
}

- (void)tearDown {
  [super tearDown];
}

- (void)testInitWithPuzzleAndSize {
  PuzzleGame *game = [[PuzzleGame alloc] initWithPuzzle:nil size:CGSizeMake(0, 0)];
  XCTAssertNotNil(game, @"Game should be init successfully");
}

@end
