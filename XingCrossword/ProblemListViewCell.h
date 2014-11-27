//
//  ProblemListViewCell.h
//  XingCrossword
//
//  Created by apple on 14-9-19.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CELL @"cell"

@interface ProblemListViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *problemText;
@property (weak, nonatomic) IBOutlet UITextField *textField;

- (void)updateWithProblemString:(NSString *)problemString;
- (void)updateWithProblemWordsCount:(NSInteger)count;

@end
