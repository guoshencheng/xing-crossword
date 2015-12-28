//
//  QuAndAnsPanelCell.h
//  XingCrossword
//
//  Created by guoshencheng on 5/10/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#define QU_AND_ANS_CELL @"QU_AND_ANS_CELL"

@interface QuAndAnsPanelCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (assign, nonatomic) NSInteger wordCount;

- (void)updateWithQuestion:(NSString *)question answer:(NSString *)answer andAnswerCount:(NSInteger)count;

@end
