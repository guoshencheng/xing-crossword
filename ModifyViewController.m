//
//  ModifyViewController.m
//  XingCrossword
//
//  Created by guoshencheng on 5/11/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

#import "ModifyViewController.h"

@implementation ModifyViewController

+ (instancetype)create {
    return [[ModifyViewController alloc] initWithNibName:@"ModifyViewController" bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.questionTextField.delegate = self;
    self.answerTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)didClickBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)didClickSaveButton:(id)sender {
    if (self.answerTextField.text.length == self.wordCount) {
        if ([self.delegate respondsToSelector:@selector(ModifyViewController:shoudSaveQuestion:andAnswer:)]) {
            [self.delegate ModifyViewController:self shoudSaveQuestion:self.questionTextField.text andAnswer:self.answerTextField.text];
        }
    } else {
        
    }
}

- (IBAction)didClickBackgroundButton:(id)sender {
    [self.questionTextField resignFirstResponder];
    [self.answerTextField resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.questionTextField) {
        if ([string isEqual:@"\n"]) {
            [self.questionTextField resignFirstResponder];
            [self.answerTextField becomeFirstResponder];
        }
    } else if (textField == self.answerTextField) {
        if ([string isEqual:@"\n"]) {
            [self.answerTextField resignFirstResponder];
        }
    }
    return  YES;
}

@end
