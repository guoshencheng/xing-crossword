//
//  WebService.h
//  XingCrossword
//
//  Created by apple on 14-8-29.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WebServiceDelegate;

@interface WebService : NSObject

@property NSArray *puzzleArray;

@property (nonatomic, weak) id<WebServiceDelegate> delegate;

- (void)getAllPuzzleResponse;

@end

@protocol WebServiceDelegate <NSObject>

@optional

- (void) webServiceDidGetAllPuzzleResponse:(WebService *)webService;

@end