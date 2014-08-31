//
//  Item.h
//  XingCrossword
//
//  Created by Sherlock on 7/9/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Item : NSManagedObject

//0 for across ,1 for down 
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * word;
@property (nonatomic, retain) NSString * hint;
@property (nonatomic, retain) NSString * input;
@property (nonatomic, retain) NSNumber * direction;
@property (nonatomic, retain) NSManagedObject *puzzle;

@end
