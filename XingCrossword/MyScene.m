
#import "MyScene.h"
#import "PuzzleGame.h"

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
    if ([node.name isEqual:@"problem"]) {
      continue;
    }
    CGPoint mytouch = [self getCellPostionWithNodeName:node.name];
    if (mytouch.x >= 0 && mytouch.y >= 0 && mytouch.x < 14 && mytouch.y < 19) {
      if ([self isTextFieldCellWithPostion:mytouch] ) {
        if ([self isTextFieldCellWithPostion:mytouch] && [self haveHorTextField:mytouch] && ![self haveVerTextField:mytouch] ) {
          self.hor = YES;
        }
        if ([self isTextFieldCellWithPostion:mytouch] && ![self haveHorTextField:mytouch] && [self  haveVerTextField:mytouch]) {
          self.hor = NO;
        }
        if ([self isTextFieldCellWithPostion:mytouch] && [self haveHorTextField:mytouch] && [self haveVerTextField:mytouch]) {
          self.hor = !self.hor;
        }
        
        if (self.hor) {
          [self resetColor];
          [self fillingLeft:mytouch];
          [self fillingRight:mytouch];
          int problemNumber = [self findProblemInHorProblemWithCGPoint:mytouch];
          [self.labelNode setText:[NSString stringWithFormat:@"%@:%d",@"横向问题",problemNumber]];
          self.currentProblemNumber = problemNumber;
        }else {
          [self resetColor];
          [self fillingUp:mytouch];
          [self fillingDown:mytouch];
          int problemNumber = [self findProblemInVerProblemWithCGPoint:mytouch];
          [self.labelNode setText:[NSString stringWithFormat:@"%@:%d",@"纵向问题",problemNumber]];
          self.currentProblemNumber = problemNumber;
        }
      }
    }
    [self.textField setText:[self getStringFromCrossWordWithStringBefore:@""]];
  }
}

-(void)update:(CFTimeInterval)currentTime {
  /* Called before each frame is rendered */
}

- (CGPoint) getCellPostionWithTouchX:(float)x AndY:(float)y {
  int hor = [self approximatelyEqualForDividend:(390 - y) andDivisor:20];
  int ver = [self approximatelyEqualForDividend:(x - 30) andDivisor:20];
  return CGPointMake(ver, hor);
}

- (CGPoint) getCellPostionWithNodeName:(NSString*)nodeName {
  NSArray *strings = [nodeName componentsSeparatedByString:@","];
  float xValue = [[strings objectAtIndex:0]floatValue];
  float yValue = [[strings objectAtIndex:1]floatValue];
  return CGPointMake(xValue, yValue);
}
- (int) approximatelyEqualForDividend:(float)dividend  andDivisor:(float)divisor {
  float AccurateResult = dividend / divisor ;
  int quotient = dividend / divisor;
  float differencd = AccurateResult - quotient;
  if (differencd < 0.5) {
    return quotient;
  } else {
    return quotient + 1;
  }
}

- (BOOL)haveHorTextField:(CGPoint)point {
  return [self haveLeftTextFieldCellWithPostion:point] || [self haveRightTextFieldCellWithPostion:point];
}

- (BOOL)haveVerTextField:(CGPoint)point {
  return [self haveUpTextFieldCellWithPostion:point] || [self haveDownTextFieldCellWithPostion:point];
}

- (BOOL)haveLeftTextFieldCellWithPostion:(CGPoint)point {
  BOOL haveTextField = false;
  if (point.x > 0){
    NSString *currentLeftString= [[self.wordArray objectAtIndex:point.y] objectAtIndex:(point.x-1)];
    if ([currentLeftString isEqualToString:@"1"]) {
      haveTextField = true;
    }
  }
  return haveTextField;
}

- (BOOL)haveRightTextFieldCellWithPostion:(CGPoint)point {
  BOOL haveTextField = false;
  if (point.x < 13) {
    NSString *currentLeftString= [[self.wordArray objectAtIndex:point.y] objectAtIndex:(point.x+1)];
    if ([currentLeftString isEqualToString:@"1"]) {
      haveTextField = true;
    }
  }
  return haveTextField;
}

- (BOOL)haveUpTextFieldCellWithPostion:(CGPoint)point {
  BOOL haveTextField = false;
  if (point.y < 18) {
    NSString *currentLeftString= [[self.wordArray objectAtIndex:(point.y+1)] objectAtIndex:point.x];
    if ([currentLeftString isEqualToString:@"1"]) {
      haveTextField = true;
    }
  }
  return haveTextField;
}

- (BOOL)haveDownTextFieldCellWithPostion:(CGPoint)point {
  BOOL haveTextField = false;
  if (point.y > 0) {
    NSString *currentLeftString= [[self.wordArray objectAtIndex:(point.y-1)] objectAtIndex:point.x];
    if ([currentLeftString isEqualToString:@"1"]) {
      haveTextField = true;
    }
  }
  return haveTextField;
}

- (BOOL)isTextFieldCellWithPostion:(CGPoint)point {
  BOOL isTextField = false;
  NSString *currentLeftString= [[self.wordArray objectAtIndex:point.y] objectAtIndex:point.x];
  if ([currentLeftString isEqualToString:@"1"]) {
    isTextField = true;
  }
  return isTextField;
}

- (SKSpriteNode*)getNodeWithPoint:(CGPoint)point {
  return (SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
}

- (void)fillingUp:(CGPoint)point {
  if ([self haveUpTextFieldCellWithPostion:point]) {
    [(SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]] setColor:[UIColor colorWithRed:1.0 green:0.0 blue:1.0 alpha:1.0]];
    
    [self fillingUp:CGPointMake(point.x, point.y + 1)];
  } else {
    [(SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]] setColor:[UIColor colorWithRed:1.0 green:0.0 blue:1.0 alpha:1.0]];
  }
}
- (void)fillingDown:(CGPoint)point {
  if ([self haveDownTextFieldCellWithPostion:point]) {
    [(SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]] setColor:[UIColor colorWithRed:1.0 green:0.0 blue:1.0 alpha:1.0]];
    
    [self fillingDown:CGPointMake(point.x, point.y - 1)];
  } else {
    [(SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]] setColor:[UIColor colorWithRed:1.0 green:0.0 blue:1.0 alpha:1.0]];
  }
}

- (void)fillingUpWithEmpty:(CGPoint)point {
  if ([self haveUpTextFieldCellWithPostion:point]) {
    SKSpriteNode *currentNode = (SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
    SKLabelNode *currenttext = (SKLabelNode*)[currentNode childNodeWithName:@"text"];
    [currenttext setText:@""];
    [self fillingUpWithEmpty:CGPointMake(point.x , point.y + 1)];
  } else {
    SKSpriteNode *currentNode = (SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
    SKLabelNode *currenttext = (SKLabelNode*)[currentNode childNodeWithName:@"text"];
    [currenttext setText:@""];
  }
}

- (void)fillingLeft:(CGPoint)point {
  if ([self haveLeftTextFieldCellWithPostion:point]) {
    [(SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]] setColor:[UIColor colorWithRed:1.0 green:0.0 blue:1.0 alpha:1.0]];
    [self fillingLeft:CGPointMake(point.x - 1, point.y)];
  } else {
    [(SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]] setColor:[UIColor colorWithRed:1.0 green:0.0 blue:1.0 alpha:1.0]];
  }
}

- (void)fillingRightWithEmpty:(CGPoint)point {
  if ([self haveRightTextFieldCellWithPostion:point]) {
    SKSpriteNode *currentNode = (SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
    SKLabelNode *currenttext = (SKLabelNode*)[currentNode childNodeWithName:@"text"];
    [currenttext setText:@""];
    [self fillingRightWithEmpty:CGPointMake(point.x + 1, point.y)];
  } else {
    SKSpriteNode *currentNode = (SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
    SKLabelNode *currenttext = (SKLabelNode*)[currentNode childNodeWithName:@"text"];
    [currenttext setText:@""];
  }
}

- (void)fillingRight:(CGPoint)point {
  if ([self haveRightTextFieldCellWithPostion:point]) {
    [(SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]] setColor:[UIColor colorWithRed:1.0 green:0.0 blue:1.0 alpha:1.0]];
    
    [self fillingRight:CGPointMake(point.x + 1, point.y)];
  } else {
    [(SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]] setColor:[UIColor colorWithRed:1.0 green:0.0 blue:1.0 alpha:1.0]];
  }
}

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

- (void)initVerProblem {
  for (int j = 0; j < 14; j++) {
    for (int i = 0; i < self.wordArray.count; i ++) {
      if ([self isTextFieldCellWithPostion:CGPointMake(j, i)] && ![self haveDownTextFieldCellWithPostion:CGPointMake(j, i)] && [self haveUpTextFieldCellWithPostion:CGPointMake(j, i)]) {
        [self.verProblemArray addObject:[NSValue valueWithCGPoint:CGPointMake(j, i)]];
      }
    }
  }
}

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
        if (![self haveUpTextFieldCellWithPostion:CGPointMake(currentPoint.x, currentPoint.y + i)]) {
        break;
        }
      }
      CGPoint lastStringNodePoint = CGPointMake(currentPoint.x, currentPoint.y + answerString.length - 1);
      if ([self haveUpTextFieldCellWithPostion:lastStringNodePoint]) {
        [self fillingUpWithEmpty:CGPointMake(currentPoint.x, currentPoint.y + answerString.length)];
      }
    }
  }
}

- (NSString*)getStringFromCrossWordWithStringBefore:(NSString*)string {
  if (self.hor) {
    CGPoint currentPoint = [[self.horProblemArray objectAtIndex:(self.currentProblemNumber - 1)] CGPointValue];
    return [self getStringFromHorCrossWordWithPoint:currentPoint andStringBefore:string];
  } else {
    CGPoint currentPoint = [[self.verProblemArray objectAtIndex:(self.currentProblemNumber - 1)] CGPointValue];
    return  [self getStringFromVerCrossWordWithPoint:currentPoint andStringBefore:string];
  }
}

- (NSString*)getStringFromHorCrossWordWithPoint:(CGPoint)point andStringBefore:(NSString*)string {
  if ([self haveRightTextFieldCellWithPostion:point]) {
    SKSpriteNode *currentNode = [self getNodeWithPoint:point];
    SKLabelNode *currentlabel = (SKLabelNode*)[currentNode childNodeWithName:@"text"];
    return [self getStringFromHorCrossWordWithPoint:CGPointMake(point.x+1, point.y) andStringBefore:[NSString stringWithFormat:@"%@%@",string,currentlabel.text]];
  } else {
    SKSpriteNode *currentNode = [self getNodeWithPoint:point];
    SKLabelNode *currentlabel = (SKLabelNode*)[currentNode childNodeWithName:@"text"];
    return [NSString stringWithFormat:@"%@%@",string,currentlabel.text];
  }
}

- (NSString*)getStringFromVerCrossWordWithPoint:(CGPoint)point andStringBefore:(NSString*)string {
  if ([self haveUpTextFieldCellWithPostion:point]) {
    SKSpriteNode *currentNode = [self getNodeWithPoint:point];
    SKLabelNode *currentlabel = (SKLabelNode*)[currentNode childNodeWithName:@"text"];
    return [self getStringFromVerCrossWordWithPoint:CGPointMake(point.x, point.y+1) andStringBefore:[NSString stringWithFormat:@"%@%@",string,currentlabel.text]];
  } else {
    SKSpriteNode *currentNode = [self getNodeWithPoint:point];
    SKLabelNode *currentlabel = (SKLabelNode*)[currentNode childNodeWithName:@"text"];
    return [NSString stringWithFormat:@"%@%@",string,currentlabel.text];
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
