//
//  ModifyViewController.h
//  XingCrossword
//
//  Created by guoshencheng on 5/11/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ModifyViewControllerDelegate;
@interface ModifyViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) NSString *questionText;
@property (strong, nonatomic) NSString *answerText;
@property (weak, nonatomic) IBOutlet UITextField *questionTextField;
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;
@property (assign, nonatomic) NSInteger wordCount;
@property (weak, nonatomic) id<ModifyViewControllerDelegate> delegate;

+ (instancetype)create;

@end

@protocol ModifyViewControllerDelegate <NSObject>
@optional
- (void)ModifyViewController:(ModifyViewController *)modifyViewController shoudSaveQuestion:(NSString *)question andAnswer:(NSString *)answer;

@end
