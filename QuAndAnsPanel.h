//
//  QuAndAnsPanel.h
//  XingCrossword
//
//  Created by guoshencheng on 5/10/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

#import "QuAndAnsPanelCell.h"
#import "AutoLayoutView.h"

@protocol QuAndAnsPanelDelegate;
@interface QuAndAnsPanel : AutoLayoutView <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) BOOL isHor;
@property (strong, nonatomic) NSArray *horQuestionList;
@property (strong, nonatomic) NSArray *verQuestionList;
@property (assign, nonatomic) NSInteger selectCellIndex;
@property (weak, nonatomic) id<QuAndAnsPanelDelegate> delegate;
- (void)animateToShow;
- (void)animateToHide;
- (NSArray *)downArrayForUpLoad;
- (NSArray *)acrossArrayForUpLoad;
- (void)updateWithQuestion:(NSString *)question andAnswer:(NSString *)answer;

@end

@protocol QuAndAnsPanelDelegate <NSObject>
@optional
- (void)quAndAnsPanel:(QuAndAnsPanel *)quAndAnsPanel didClickCellWithQuestion:(NSString *)question answer:(NSString *)answer andWordCount:(NSInteger)wordCount;

@end
