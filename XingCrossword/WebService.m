//
//  WebService.m
//  XingCrossword
//
//  Created by apple on 14-8-29.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "WebService.h"
#import "AFHTTPRequestOperationManager.h"

#define DATA_JASON_URL_STRING @"http://crossword.sinaapp.com/api/puzzles.json"
@implementation WebService

- (void)getAllPuzzleResponse {
  __weak typeof(self) weakSelf = self;
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  [manager GET:DATA_JASON_URL_STRING parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    weakSelf.puzzleArray = responseObject;
    if ([self.delegate respondsToSelector:@selector(webServiceDidGetAllPuzzleResponse:)]) {
      [self.delegate webServiceDidGetAllPuzzleResponse:self];
    }
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
  }];
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
