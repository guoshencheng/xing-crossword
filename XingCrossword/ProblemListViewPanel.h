//
//  ProblemListViewPanel.h
//  XingCrossword
//
//  Created by apple on 14-9-19.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ProblemListViewCell.h"

typedef enum  {
  ProblemListViewInputMode,
  ProblemListViewShowProblemMode
} ProblemListViewMode;

@protocol ProblemListViewPanelDelegate;

@interface ProblemListViewPanel : UIView <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) id<ProblemListViewPanelDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSDictionary *horPorblemArray;
@property (strong, nonatomic) NSArray *horProblemNumebrArray;
@property (strong, nonatomic) NSArray *verProblemNumberArray;
@property (strong, nonatomic) NSDictionary *verProblemArray;
@property (assign, nonatomic) BOOL isHor;
@property (assign, nonatomic) ProblemListViewMode problemListViewMode;

+ (id)create;
- (void)animateToShow;
- (void)animateToHide;

@end

@protocol ProblemListViewPanelDelegate <NSObject>

- (void)problemListViewPanel:(ProblemListViewPanel *)problemListView DidClickWithIndex:(NSInteger)index andDirection:(NSNumber *)direction;

@end