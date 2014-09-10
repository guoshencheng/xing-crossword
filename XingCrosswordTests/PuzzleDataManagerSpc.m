//
//  PuzzleDataManagerSpc.m
//  XingCrossword
//
//  Created by apple on 14-7-10.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "Kiwi.h"
#import "CoreData+MagicalRecord.h"
#import "Puzzle+DataManager.h"

SPEC_BEGIN(PuzzleDataManagerSpc)

beforeEach(^{
  [MagicalRecord setupCoreDataStackWithInMemoryStore];
});

describe(@"Create or update a puzzle in CoreData", ^{
  it(@"Create a enity that is not exist", ^{
    NSDictionary *response = @{@"id": @"xzm-20140714",
                               @"title": @"周末074",
                               @"map": @"0101010101010,1101010101010,0100101010101"
                               };
    __block Puzzle *puzzle;
    [Puzzle createPuzzleWithResponse:response completion:^(BOOL success, NSError *error){
      puzzle = [Puzzle MR_findFirstByAttribute:@"puzzleId" withValue:@"xzm-20140714"];
    }];
    [[expectFutureValue(puzzle.title) shouldEventually] equal:@"周末074"];
  });
  
  it(@"Update a exist enity if success return success else return fail", ^{
    NSDictionary *response1 = @{@"id": @"xzm-20140714",
                               @"title": @"周末074",
                               @"map": @"0101010101010,1101010101010,0100101010101"
                               };
    __block Puzzle *puzzle;
    [Puzzle createPuzzleWithResponse:response1 completion:^(BOOL success, NSError *error) {
      NSDictionary  *response2 = @{@"id": @"xzm-20140714",
                                   @"title": @"周末076",
                                   @"map": @"010,110110,0100101"
                                   };
      [Puzzle createPuzzleWithResponse:response2 completion:^(BOOL success, NSError *error){
        puzzle = [Puzzle MR_findFirstByAttribute:@"puzzleId" withValue:@"xzm-20140714"];
      }];
    }];
    [[expectFutureValue(puzzle.title) shouldEventually] equal:@"周末076"];
  });
});



afterEach(^{
  [MagicalRecord cleanUp];
});

SPEC_END
