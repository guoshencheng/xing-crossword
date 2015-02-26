//
//  MyScene+fill.m
//  XingCrossword
//
//  Created by apple on 14-9-5.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "MyScene+fill.h"
#import "Item+DataManager.h"
#import "MyScene+PostionHandler.h"

@implementation MyScene (fill)

- (void)fillDown:(CGPoint)point {
    if ([self isHaveDownTextFieldCellWithPostion:point]) {
        SKSpriteNode * currentnode = (SKSpriteNode*)[self.puzzleGame.puzzleNode childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
        currentnode.color = [self.puzzleGame.theme fillCellColor];
        
        [self fillDown:CGPointMake(point.x, point.y + 1)];
    } else {
        SKSpriteNode * currentnode = (SKSpriteNode*)[self.puzzleGame.puzzleNode childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
        currentnode.color = [self.puzzleGame.theme fillCellColor];
    }
}

- (void)unFillDown:(CGPoint)point {
    if ([self isHaveDownTextFieldCellWithPostion:point]) {
        SKSpriteNode * currentnode = (SKSpriteNode*)[self.puzzleGame.puzzleNode childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
        currentnode.color = [self.puzzleGame.theme entryCellColor];
        
        [self unFillDown:CGPointMake(point.x, point.y + 1)];
    } else {
        SKSpriteNode * currentnode = (SKSpriteNode*)[self.puzzleGame.puzzleNode childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
        currentnode.color = [self.puzzleGame.theme entryCellColor];
    }
}

- (void)fillUp:(CGPoint)point {
    if ([self isHaveUpTextFieldCellWithPostion:point]) {
        SKSpriteNode * currentnode = (SKSpriteNode*)[self.puzzleGame.puzzleNode childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
        currentnode.color = [self.puzzleGame.theme fillCellColor];
        
        [self fillUp:CGPointMake(point.x, point.y - 1)];
    } else {
        SKSpriteNode * currentnode = (SKSpriteNode*)[self.puzzleGame.puzzleNode childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
        currentnode.color = [self.puzzleGame.theme fillCellColor];
    }
}

- (void)unFillUp:(CGPoint)point {
    if ([self isHaveUpTextFieldCellWithPostion:point]) {
        SKSpriteNode * currentnode = (SKSpriteNode*)[self.puzzleGame.puzzleNode childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
        currentnode.color = [self.puzzleGame.theme entryCellColor];
        
        [self unFillUp:CGPointMake(point.x, point.y - 1)];
    } else {
        SKSpriteNode * currentnode = (SKSpriteNode*)[self.puzzleGame.puzzleNode childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
        currentnode.color = [self.puzzleGame.theme entryCellColor];
    }
}


- (void)fillingLeft:(CGPoint)point {
    if ([self haveLeftTextFieldCellWithPostion:point]) {
        SKSpriteNode * currentnode = (SKSpriteNode*)[self.puzzleGame.puzzleNode childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
        currentnode.color = [self.puzzleGame.theme fillCellColor];
        [self fillingLeft:CGPointMake(point.x - 1, point.y)];
    } else {
        SKSpriteNode * currentnode = (SKSpriteNode*)[self.puzzleGame.puzzleNode childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
        currentnode.color = [self.puzzleGame.theme fillCellColor];
    }
}

- (void)unFillingLeft:(CGPoint)point {
    if ([self haveLeftTextFieldCellWithPostion:point]) {
        SKSpriteNode * currentnode = (SKSpriteNode*)[self.puzzleGame.puzzleNode childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
        currentnode.color = [self.puzzleGame.theme entryCellColor];
        [self unFillingLeft:CGPointMake(point.x - 1, point.y)];
    } else {
        SKSpriteNode * currentnode = (SKSpriteNode*)[self.puzzleGame.puzzleNode childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
        currentnode.color = [self.puzzleGame.theme entryCellColor];
    }
}

- (void)fillingRight:(CGPoint)point {
    if ([self haveRightTextFieldCellWithPostion:point]) {
        SKSpriteNode * currentnode = (SKSpriteNode*)[self.puzzleGame.puzzleNode childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
        currentnode.color = [self.puzzleGame.theme fillCellColor];
        
        [self fillingRight:CGPointMake(point.x + 1, point.y)];
    } else {
        SKSpriteNode * currentnode = (SKSpriteNode*)[self.puzzleGame.puzzleNode childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
        currentnode.color = [self.puzzleGame.theme fillCellColor];
    }
}

- (void)unFillingRight:(CGPoint)point {
    if ([self haveRightTextFieldCellWithPostion:point]) {
        SKSpriteNode * currentnode = (SKSpriteNode*)[self.puzzleGame.puzzleNode childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
        currentnode.color = [self.puzzleGame.theme entryCellColor];
        
        [self unFillingRight:CGPointMake(point.x + 1, point.y)];
    } else {
        SKSpriteNode * currentnode = (SKSpriteNode*)[self.puzzleGame.puzzleNode childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
        currentnode.color = [self.puzzleGame.theme entryCellColor];
    }
}

- (void)fillingDownWithEmpty:(CGPoint)point {
    if ([self isHaveDownTextFieldCellWithPostion:point]) {
        SKSpriteNode *currentNode = (SKSpriteNode*)[self.puzzleGame.puzzleNode childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
        SKLabelNode *currenttext = (SKLabelNode*)[currentNode childNodeWithName:@"text"];
        [currenttext setText:@" "];
        [self fillingDownWithEmpty:CGPointMake(point.x , point.y + 1)];
    } else {
        SKSpriteNode *currentNode = (SKSpriteNode*)[self.puzzleGame.puzzleNode childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
        SKLabelNode *currenttext = (SKLabelNode*)[currentNode childNodeWithName:@"text"];
        [currenttext setText:@" "];
    }
}

- (void)fillingRightWithEmpty:(CGPoint)point {
    if ([self haveRightTextFieldCellWithPostion:point]) {
        SKSpriteNode *currentNode = (SKSpriteNode*)[self.puzzleGame.puzzleNode childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
        SKLabelNode *currenttext = (SKLabelNode*)[currentNode childNodeWithName:@"text"];
        [currenttext setText:@" "];
        [self fillingRightWithEmpty:CGPointMake(point.x + 1, point.y)];
    } else {
        SKSpriteNode *currentNode = (SKSpriteNode*)[self.puzzleGame.puzzleNode childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
        SKLabelNode *currenttext = (SKLabelNode*)[currentNode childNodeWithName:@"text"];
        [currenttext setText:@" "];
    }
}

- (void)fillWithInput {
    for (int i = 0; i < self.horProblemArray.count; i ++) {
        CGPoint currentPoint = [[self.horProblemArray objectAtIndex:i] CGPointValue];
        NSString *answerString = [Item findInputByDirection:@(0) andOrder:@(i) andPuzzleId:self.puzzleId];
        if (answerString) {
            for (int j = 0; j < answerString.length; j ++) {
                NSString *currentChar = [answerString substringWithRange:NSMakeRange(j, 1)];
                SKSpriteNode *currentNode = [self getNodeWithPoint:CGPointMake(currentPoint.x+j, currentPoint.y)];
                SKLabelNode *label = (SKLabelNode*)[currentNode childNodeWithName:@"text"];
                label.text = currentChar;
                if (![self haveRightTextFieldCellWithPostion:CGPointMake(currentPoint.x + j, currentPoint.y)]){
                    break;
                }
            }
        }
    }
    for (int i = 0; i < self.verProblemArray.count; i ++) {
        CGPoint currentPoint = [[self.verProblemArray objectAtIndex:i] CGPointValue];
        NSString *answerString = [Item findInputByDirection:@(1) andOrder:@(i) andPuzzleId:self.puzzleId];
        if (answerString) {
            for (int j = 0; j < answerString.length; j ++) {
                NSString *currentChar = [answerString substringWithRange:NSMakeRange(j, 1)];
                SKSpriteNode *currentNode = [self getNodeWithPoint:CGPointMake(currentPoint.x, currentPoint.y + j)];
                SKLabelNode *label = (SKLabelNode*)[currentNode childNodeWithName:@"text"];
                label.text = currentChar;
                if (![self isHaveDownTextFieldCellWithPostion:CGPointMake(currentPoint.x, currentPoint.y + j)]){
                    break;
                }
            }
        }
    }
}

//set textField String to WordCross's every Node
- (void)setAnswerStringToCrossWithString:(NSString*)answerString {
    if (self.hor) {
        CGPoint currentPoint = [[self.horProblemArray objectAtIndex:(self.currentProblemNumber - 1)] CGPointValue];
        if ( answerString.length < 1) {
            [self fillingRightWithEmpty:currentPoint];
        }else {
            for (int i = 0; i < answerString.length; i ++) {
                NSString *currentChar = [answerString substringWithRange:NSMakeRange(i, 1)];
                SKSpriteNode *currentNode = [self getNodeWithPoint:CGPointMake(currentPoint.x+i, currentPoint.y)];
                SKLabelNode *label = (SKLabelNode*)[currentNode childNodeWithName:@"text"];
                label.text = currentChar;
                if (![self haveRightTextFieldCellWithPostion:CGPointMake(currentPoint.x + i, currentPoint.y)]){
                    break;
                }
            }
            CGPoint lastStringNodePoint = CGPointMake(currentPoint.x + answerString.length - 1, currentPoint.y);
            if ([self haveRightTextFieldCellWithPostion:lastStringNodePoint]) {
                [self fillingRightWithEmpty:CGPointMake(currentPoint.x + answerString.length, currentPoint.y)];
            }
        }
    }else {
        CGPoint currentPoint = [[self.verProblemArray objectAtIndex:(self.currentProblemNumber - 1)] CGPointValue];
        if (answerString.length < 1) {
            [self fillingRightWithEmpty:currentPoint];
        } else {
            for (int i = 0; i < answerString.length; i ++) {
                NSString *currentChar = [answerString substringWithRange:NSMakeRange(i, 1)];
                SKSpriteNode *currentNode = [self getNodeWithPoint:CGPointMake(currentPoint.x, currentPoint.y + i)];
                SKLabelNode *label = (SKLabelNode*)[currentNode childNodeWithName:@"text"];
                label.text = currentChar;
                if (![self isHaveDownTextFieldCellWithPostion:CGPointMake(currentPoint.x, currentPoint.y + i)]) {
                    break;
                }
            }
            CGPoint lastStringNodePoint = CGPointMake(currentPoint.x, currentPoint.y + answerString.length - 1);
            if ([self isHaveDownTextFieldCellWithPostion:lastStringNodePoint]) {
                [self fillingDownWithEmpty:CGPointMake(currentPoint.x, currentPoint.y + answerString.length)];
            }
        }
    }
}

@end
