//
//  PuzzleUtilitySpec.m
//  XingCrossword
//
//  Created by Sherlock on 7/10/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CoreData+MagicalRecord.h"
#import "Puzzle+Utility.h"
#import "Item+Utility.h"

@interface PuzzleUtilitySpec : XCTestCase

@end

@implementation PuzzleUtilitySpec

- (void)setUp {
  [super setUp];
  [MagicalRecord setupCoreDataStackWithInMemoryStore];
}

- (void)tearDown {
  [MagicalRecord cleanUp];
  [super tearDown];
}

- (void)testGetOrderedDownItems {
  Puzzle *puzzle = [Puzzle MR_createEntity];
  Item *downItem1 = [Item MR_createEntity];
  downItem1.puzzle = puzzle;
  downItem1.order = @(1);
  downItem1.direction = @(ItemDirectionDown);
  Item *downItem2 = [Item MR_createEntity];
  downItem2.puzzle = puzzle;
  downItem2.order = @(5);
  downItem2.direction = @(ItemDirectionDown);
  Item *downItem3 = [Item MR_createEntity];
  downItem3.puzzle = puzzle;
  downItem3.order = @(3);
  downItem3.direction = @(ItemDirectionDown);
  Item *acrossItem1 = [Item MR_createEntity];
  acrossItem1.puzzle = puzzle;
  acrossItem1.order = @(2);
  acrossItem1.direction = @(ItemDirectionAcross);
  
  NSArray *downItems = [puzzle orderedDownItems];
  XCTAssertEqual([downItems count], 3, @"Should have 3 items");
  XCTAssertEqual(downItems[0], downItem1, @"Item 1 goes first");
  XCTAssertEqual(downItems[1], downItem3, @"Item 3 goes second");
  XCTAssertEqual(downItems[2], downItem2, @"Item 2 goes third");
}

- (void)testGetOrderedAcrossItems {
  Puzzle *puzzle = [Puzzle MR_createEntity];
  Item *acrossItem1 = [Item MR_createEntity];
  acrossItem1.puzzle = puzzle;
  acrossItem1.order = @(3);
  acrossItem1.direction = @(ItemDirectionAcross);
  Item *acrossItem2 = [Item MR_createEntity];
  acrossItem2.puzzle = puzzle;
  acrossItem2.order = @(7);
  acrossItem2.direction = @(ItemDirectionAcross);
  Item *acrossItem3 = [Item MR_createEntity];
  acrossItem3.puzzle = puzzle;
  acrossItem3.order = @(2);
  acrossItem3.direction = @(ItemDirectionAcross);
  Item *downItem1 = [Item MR_createEntity];
  downItem1.puzzle = puzzle;
  downItem1.order = @(1);
  downItem1.direction = @(ItemDirectionDown);
  
  NSArray *acrossItems = [puzzle orderedAcrossItems];
  XCTAssertEqual([acrossItems count], 3, @"Should have 3 items");
  XCTAssertEqual(acrossItems[0], acrossItem3, @"Item 3 goes first");
  XCTAssertEqual(acrossItems[1], acrossItem1, @"Item 1 goes second");
  XCTAssertEqual(acrossItems[2], acrossItem2, @"Item 2 goes third");
}

@end
