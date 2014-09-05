
#import "MyScene.h"
#import "PuzzleGame.h"
#import "MyScene+fill.h"
#import "MyScene+PostionHandler.h"

@implementation MyScene

- (void)didMoveToView:(SKView *)view {
  self.textField = [[UITextField alloc] initWithFrame:CGRectMake(self.size.width / 4, self.size.height * 1 / 8 + 20, 160, 40)];
  self.textField.borderStyle = UITextBorderStyleRoundedRect;
  self.textField.textColor = [UIColor blackColor];
  self.textField.font = [UIFont systemFontOfSize:17.0];
  self.textField.placeholder = @"Enter your answer here";
  self.textField.backgroundColor = [UIColor whiteColor];
  self.textField.autocorrectionType = UITextAutocorrectionTypeYes;
  self.textField.keyboardType = UIKeyboardTypeDefault;
  self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
  self.textField.delegate = self;
  [self.view addSubview:self.textField];
}

- (void)createWordArray {
  PuzzleGame *puzzleGame = [[PuzzleGame alloc]initWithPuzzleTitle:self.title size:self.size];
  self.nodeArray = puzzleGame.grids;
  self.wordArray = puzzleGame.mapGrid;
  NSArray *firstArray = [self.wordArray objectAtIndex:0];
  self.wordArrayXMaxNumber = self.wordArray.count;
  self.wordArrayYMaxNumber = firstArray.count;
}

- (void)createAcross {
  [self createWordArray];
  [self initHorProblem];
  [self initVerProblem];
  for (int i = 0; i < self.nodeArray.count; i ++) {
    NSArray *nodeArray = [self.nodeArray objectAtIndex:i];
    for (int j = 0; j < nodeArray.count; j ++) {
      SKSpriteNode *currentSprite = [nodeArray objectAtIndex:j];
      [self addChild:currentSprite];
    }
  }
}

-(id)initWithSize:(CGSize)size {
  self.currentProblemNumber = 0;
  self.hor = YES;
  self.touchPoint = CGPointMake(-1, -1);
  self.horProblemArray = [[NSMutableArray alloc] init];
  self.verProblemArray = [[NSMutableArray alloc] init];
  if (self = [super initWithSize:size]) {
    self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
  }
  return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  for (UITouch *touch in touches) {
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    NSLog(@"%@",node.name);
    if ([node.name isEqual:@"text"]) {
      node = [node parent];
    }
    CGPoint mytouch = [self getCellPostionWithNodeName:node.name];
    if ([self isInGridWithPostion:mytouch]) {
      if ([self isTextFieldCellWithPostion:mytouch] ) {
        [self changeDirectionByTouch:mytouch];
        if (self.hor) {
          [self resetColor];
          [self fillingLeft:mytouch];
          [self fillingRight:mytouch];
          self.currentProblemNumber = [self findProblemInHorProblemWithCGPoint:mytouch];
          [self.labelNode setText:[NSString stringWithFormat:@"%@:%d",@"横向问题",self.currentProblemNumber]];
        }else {
          [self resetColor];
          [self fillDown:mytouch];
          [self fillUp:mytouch];
          self.currentProblemNumber = [self findProblemInVerProblemWithCGPoint:mytouch];
          [self.labelNode setText:[NSString stringWithFormat:@"%@:%d",@"纵向问题",self.currentProblemNumber]];
        }
      }
    }
    [self.textField setText:[self getStringFromCrossWordWithStringBefore:@""]];
  }
}

-(void)update:(CFTimeInterval)currentTime {
  /* Called before each frame is rendered */
}

- (CGPoint) getCellPostionWithNodeName:(NSString*)nodeName {
  NSArray *strings = [nodeName componentsSeparatedByString:@","];
  float xValue = [[strings objectAtIndex:0]floatValue];
  float yValue = [[strings objectAtIndex:1]floatValue];
  return CGPointMake(xValue, yValue);
}

//reset all Node's Color
- (void)resetColor {
  for (int i = 0; i < self.wordArray.count; i++) {
    NSArray *currentArray = [self.wordArray objectAtIndex:i];
    for (int j = 0; j < currentArray.count; j++) {
      NSString *currentValue = [currentArray objectAtIndex:j];
      if ([currentValue isEqualToString:@"1"]) {
        [(SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)j,(int)i]] setColor:[UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:1.0]];
      } else {
        [(SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)j,(int)i]] setColor:[UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0]];
      }
    }
  }
}

//init all Hor Problem and Add Them To the Array With Its First Node Postion
- (void)initHorProblem {
  for (int i = 0; i < self.wordArray.count; i++) {
    NSArray *currentArray = [self.wordArray objectAtIndex:i];
    for (int j = 0; j < currentArray.count; j++) {
      if ([self isTextFieldCellWithPostion:CGPointMake(j, i)] && [self haveRightTextFieldCellWithPostion:CGPointMake(j, i)] && ![self haveLeftTextFieldCellWithPostion:CGPointMake(j, i)]) {
        [self.horProblemArray addObject:[NSValue valueWithCGPoint:CGPointMake(j, i)]];
      }
    }
  }
}

//init all Ver Problem and Add Them To the Array With Its First Node Postion
- (void)initVerProblem {
  for (int j = 0; j < self.wordArrayYMaxNumber; j++) {
    for (int i = 0; i < self.wordArray.count; i ++) {
      if ([self isTextFieldCellWithPostion:CGPointMake(j, i)] && ![self isHaveUpTextFieldCellWithPostion:CGPointMake(j, i)] && [self isHaveDownTextFieldCellWithPostion:CGPointMake(j, i)]) {
        [self.verProblemArray addObject:[NSValue valueWithCGPoint:CGPointMake(j, i)]];
      }
    }
  }
}

// find the First Node's Postion Hor a ver Problem
- (int)findProblemInHorProblemWithCGPoint:(CGPoint)point {
  int numberOfProblem = 0;
  for (int i = 0; i < self.horProblemArray.count; i ++) {
    CGPoint currentPoint = [[self.horProblemArray objectAtIndex:i] CGPointValue];
    float x = currentPoint.x;
    float y = currentPoint.y;
    if (x <= point.x && y == point.y) {
      numberOfProblem = i + 1;
    }
  }
  return numberOfProblem;
}


// find the First Node's Postion for a ver Problem
- (int)findProblemInVerProblemWithCGPoint:(CGPoint)point {
  int numberOfProble = 0;
  for (int i = 0; i < self.verProblemArray.count; i ++) {
    CGPoint currentPoint = [[self.verProblemArray objectAtIndex:i] CGPointValue];
    float x = currentPoint.x;
    float y = currentPoint.y;
    if (x == point.x && y <= point.y) {
      numberOfProble = i + 1;
    }
  }
  return  numberOfProble;
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

//get String From WordCross
- (NSString*)getStringFromCrossWordWithStringBefore:(NSString*)string {
  if (self.hor) {
    CGPoint currentPoint = [[self.horProblemArray objectAtIndex:(self.currentProblemNumber - 1)] CGPointValue];
    return [self getStringFromHorCrossWordWithPoint:currentPoint andStringBefore:string];
  } else {
    CGPoint currentPoint = [[self.verProblemArray objectAtIndex:(self.currentProblemNumber - 1)] CGPointValue];
    return  [self getStringFromVerCrossWordWithPoint:currentPoint andStringBefore:string];
  }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  return  YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  if (self.currentProblemNumber > 0) {
    [self.textField setText:[self getStringFromCrossWordWithStringBefore:@""]];
  }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  if (self.currentProblemNumber > 0) {
    [self setAnswerStringToCrossWithString:self.textField.text];
  }
  [self.textField resignFirstResponder];
  return  YES;
}

@end
