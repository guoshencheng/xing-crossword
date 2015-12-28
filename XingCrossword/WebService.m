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

#define GETJSON 1

//#define DATA_JASON_URL_STRING @"http://crossword.sinaapp.com/api/puzzles.json"
#define DATA_JASON_URL_STRING @"http://localhost/xingcrossword/xingcrossword/1/getAllPuzzles.php"
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

+ (void)saveNewPuzzleWithParameters:(NSDictionary *)parameters {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:@"http://localhost/xingcrossword/xingcrossword/1/savePuzzle.php" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *result = responseObject;
        NSLog(@"%@", result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)savaAllPuzzleResponseWithCompletion:(void (^)(BOOL success, NSError *error))completion {
  for (NSDictionary *puzzle in self.puzzleArray) {
    PuzzleTool *currentPuzzle = [[PuzzleTool alloc] init];
    NSArray *acrossHint = [self getPuzzleAcrossHintWithPuzzleDictionary:puzzle];
    NSArray *acrossWord = [self getPuzzleAcrossWordWithPuzzleDictionary:puzzle];
    NSArray *downHint = [self getPuzzleDownHintWithPuzzleDictionary:puzzle];
    NSArray *downWord = [self getPuzzleDownWordWithPuzzleDictionary:puzzle];
    currentPuzzle.title = [self getPuzzleTitleWithPuzzleDictionary:puzzle];
    currentPuzzle.puzzleId = [self getPuzzleIdWithPuzzleDictionary:puzzle];
    currentPuzzle.map = [self getPuzzleMapWithPuzzleDictionary:puzzle];
    [Puzzle createPuzzleWithPuzzle:currentPuzzle acrossHint:acrossHint acrossWord:acrossWord downHint:downHint downWord:downWord completion:completion];
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
    if (GETJSON == 0) {
        NSDictionary *hint = [puzzle objectForKey:@"hints"];
        NSArray *accross = [hint objectForKey:@"across"];
        return accross;
    } else {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSArray *directionArray = [puzzle objectForKey:@"acrossArray"];
        for (int i = 0; i < directionArray.count; i ++) {
            NSDictionary *item = [directionArray objectAtIndex:i];
            [array addObject:[item objectForKey:@"hint"]];
        }
        return array;
    }

}

- (NSArray *)getPuzzleDownHintWithPuzzleDictionary:(NSDictionary *)puzzle {
    if (GETJSON == 0) {
        NSDictionary *hint = [puzzle objectForKey:@"hints"];
        NSArray *down = [hint objectForKey:@"down"];
        return down;
    } else {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSArray *directionArray = [puzzle objectForKey:@"downArray"];
        for (int i = 0; i < directionArray.count; i ++) {
            NSDictionary *item = [directionArray objectAtIndex:i];
            [array addObject:[item objectForKey:@"hint"]];
        }
        return array;

    }
}

- (NSArray *)getPuzzleAcrossWordWithPuzzleDictionary:(NSDictionary *)puzzle {
    if (GETJSON == 0) {
        NSDictionary *word = [puzzle objectForKey:@"words"];
        NSArray *across = [word objectForKey:@"across"];
        return across;
    } else {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSArray *directionArray = [puzzle objectForKey:@"acrossArray"];
        for (int i = 0; i < directionArray.count; i ++) {
            NSDictionary *item = [directionArray objectAtIndex:i];
            [array addObject:[item objectForKey:@"word"]];
        }
        return array;

    }
}

- (NSArray *)getPuzzleDownWordWithPuzzleDictionary:(NSDictionary *)puzzle {
    if (GETJSON == 0) {
        NSDictionary *word = [puzzle objectForKey:@"words"];
        NSArray *down = [word objectForKey:@"down"];
        return down;
    } else {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSArray *directionArray = [puzzle objectForKey:@"downArray"];
        for (int i = 0; i < directionArray.count; i ++) {
            NSDictionary *item = [directionArray objectAtIndex:i];
            [array addObject:[item objectForKey:@"word"]];
        }
        return array;

    }
}

@end
