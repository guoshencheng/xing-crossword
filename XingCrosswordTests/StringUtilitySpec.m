//
//  StringUtilitySpec.m
//  XingCrossword
//
//  Created by Sherlock on 7/10/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+Utility.h"

@interface StringUtilitySpec : XCTestCase

@end

@implementation StringUtilitySpec

- (void)setUp {
  [super setUp];
}

- (void)tearDown {
  [super tearDown];
}

- (void)testConvertToLetterArray {
  NSString *str = @"aljwo0123adlf";
  NSArray *letterArray = [str letterArray];
  XCTAssertEqual(13, [letterArray count], @"Letter array should have the count equal to str length");
  XCTAssertEqualObjects(@"w", letterArray[3], @"Letter array should has the correct value");
  XCTAssertEqualObjects(@"0", letterArray[5], @"Letter array should has the correct value");
  XCTAssertEqualObjects(@"3", letterArray[8], @"Letter array should has the correct value");
  XCTAssertEqualObjects(@"f", letterArray[12], @"Letter array should has the correct value");
}

@end
