//
//  WebService.m
//  XingCrossword
//
//  Created by apple on 14-8-29.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "WebService.h"
#import "PuzzleTool.h"
#import "ItemTool.h"
#import "Puzzle+DataManager.h"
#import "Item+DataManager.h"
#import "AFHTTPRequestOperationManager.h"

#define DATA_JASON_URL_STRING @"http://crossword.sinaapp.com/api/puzzles.json"
@implementation WebService

- (void)getAllPuzzleResponse {
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  [manager GET:DATA_JASON_URL_STRING parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    self.puzzleArray = responseObject;
    if ([self.delegate respondsToSelector:@selector(webServiceDidGetAllPuzzleResponse:)]) {
      [self.delegate webServiceDidGetAllPuzzleResponse:self];
    }
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
  }];
}

- (void)savaAllPuzzleResponseWithCompletion:(void (^)(BOOL, NSError *))completion{
  for (NSDictionary *puzzle in self.puzzleArray) {
    PuzzleTool *currentPuzzle = [[PuzzleTool alloc] init];
    NSArray *acrossHint = [self getPuzzleAcrossHintWithPuzzleDictionary:puzzle];
    NSArray *acrossWord = [self getPuzzleAcrossWordWithPuzzleDictionary:puzzle];
    NSArray *downHint = [self getPuzzleDownHintWithPuzzleDictionary:puzzle];
    NSArray *downWord = [self getPuzzleDownWordWithPuzzleDictionary:puzzle];
    currentPuzzle.title = [self getPuzzleTitleWithPuzzleDictionary:puzzle];
    currentPuzzle.puzzleId = [self getPuzzleIdWithPuzzleDictionary:puzzle];
    currentPuzzle.map = [self getPuzzleMapWithPuzzleDictionary:puzzle];
    ItemTool *itemTool = [[ItemTool alloc] init];
    [Puzzle createPuzzleWithPuzzle:currentPuzzle completion:^(BOOL success, NSError *error) {
      for (int i = 0;i < acrossHint.count;i ++)
      {
        itemTool.hint = [acrossHint objectAtIndex:i];
        itemTool.word = [acrossWord objectAtIndex:i];
        itemTool.direction = @(0);
        itemTool.order = @(i);
        [Item createItemWithItemTool:itemTool andPuzzleId:currentPuzzle.puzzleId completion:completion];
      }
      for (int i =0; i < downHint.count; i ++) {
        itemTool.hint = [downHint objectAtIndex:i];
        itemTool.word = [downWord objectAtIndex:i];
        itemTool.direction = @(1);
        itemTool.order = @(i);
        [Item createItemWithItemTool:itemTool andPuzzleId:currentPuzzle.puzzleId completion:completion];
      }
    }];
    
  }
}

#pragma mark - Private Method

- (NSString *)getPuzzleIdWithPuzzleDictionary:(NSDictionary *)puzzle {
  NSString *puzzleid = [puzzle objectForKey:@"id"];
  return puzzleid;
}

- (NSString *)getPuzzleTitleWithPuzzleDictionary:(NSDictionary *)puzzle {
  NSString *puzzleTitle = [puzzle objectForKey:@"title"];
  return puzzleTitle;
}

- (NSString *)getPuzzleMapWithPuzzleDictionary:(NSDictionary *)puzzle {
  NSString *puzzleMap = [puzzle objectForKey:@"map"];
  return puzzleMap;
}

- (NSArray *)getPuzzleAcrossHintWithPuzzleDictionary:(NSDictionary *)puzzle {
  NSDictionary *hint = [puzzle objectForKey:@"hint"];
  NSArray *accross = [hint objectForKey:@"across"];
  return accross;
}

- (NSArray *)getPuzzleDownHintWithPuzzleDictionary:(NSDictionary *)puzzle {
  NSDictionary *hint = [puzzle objectForKey:@"hint"];
  NSArray *down = [hint objectForKey:@"down"];
  return down;
}

- (NSArray *)getPuzzleAcrossWordWithPuzzleDictionary:(NSDictionary *)puzzle {
  NSDictionary *word = [puzzle objectForKey:@"word"];
  NSArray *across = [word objectForKey:@"across"];
  return across;
}

- (NSArray *)getPuzzleDownWordWithPuzzleDictionary:(NSDictionary *)puzzle {
  NSDictionary *word = [puzzle objectForKey:@"word"];
  NSArray *down = [word objectForKey:@"down"];
  return down;
}

@end
