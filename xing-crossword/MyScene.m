
#import "MyScene.h"

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

-(id)initWithSize:(CGSize)size {
  self.currentProblemNumber = 0;
  self.hor = YES;
  self.touchPoint = CGPointMake(-1, -1);
  self.horProblemArray = [[NSMutableArray alloc] init];
  self.verProblemArray = [[NSMutableArray alloc] init];
  self.wordArray = @[
                     @[@"1",@"1",@"1",@"1",@"1",@"1",@"0",@"0",@"1",@"1",@"1",@"0",@"0",@"1"],
                     @[@"1",@"0",@"1",@"0",@"0",@"1",@"1",@"1",@"1",@"0",@"1",@"1",@"1",@"1"],
                     @[@"0",@"1",@"1",@"1",@"1",@"0",@"1",@"0",@"1",@"0",@"1",@"0",@"0",@"1"],
                     @[@"0",@"1",@"0",@"0",@"0",@"0",@"1",@"0",@"0",@"0",@"1",@"0",@"0",@"1"],
                     @[@"1",@"1",@"1",@"1",@"1",@"0",@"1",@"1",@"1",@"1",@"0",@"1",@"1",@"1"],
                     @[@"1",@"0",@"0",@"1",@"0",@"1",@"0",@"1",@"0",@"1",@"1",@"1",@"0",@"1"],
                     @[@"1",@"0",@"0",@"1",@"0",@"1",@"1",@"1",@"1",@"0",@"0",@"1",@"0",@"1"],
                     @[@"1",@"0",@"1",@"1",@"1",@"1",@"0",@"1",@"0",@"1",@"0",@"1",@"0",@"1"],
                     @[@"1",@"1",@"1",@"0",@"0",@"0",@"0",@"1",@"0",@"1",@"0",@"1",@"0",@"1"],
                     @[@"0",@"1",@"0",@"1",@"0",@"1",@"1",@"1",@"1",@"1",@"0",@"1",@"0",@"0"],
                     @[@"1",@"1",@"1",@"1",@"0",@"0",@"1",@"0",@"0",@"0",@"1",@"1",@"1",@"1"],
                     @[@"1",@"0",@"0",@"1",@"1",@"0",@"1",@"1",@"1",@"1",@"1",@"0",@"0",@"1"],
                     @[@"1",@"1",@"1",@"0",@"1",@"0",@"1",@"0",@"1",@"0",@"1",@"0",@"1",@"1"],
                     @[@"1",@"0",@"1",@"0",@"1",@"0",@"0",@"0",@"1",@"0",@"1",@"1",@"1",@"0"],
                     @[@"0",@"0",@"1",@"0",@"0",@"1",@"0",@"1",@"1",@"1",@"0",@"0",@"1",@"1"],
                     @[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"0",@"1",@"0",@"0",@"1",@"0",@"1"],
                     @[@"0",@"1",@"0",@"1",@"0",@"1",@"0",@"0",@"1",@"0",@"1",@"1",@"1",@"1"],
                     @[@"0",@"1",@"0",@"1",@"0",@"1",@"0",@"1",@"1",@"1",@"1",@"0",@"0",@"1"],
                     @[@"1",@"1",@"1",@"0",@"1",@"1",@"1",@"1",@"0",@"0",@"1",@"1",@"0",@"1"]
                     ];
  
  
  
  if (self = [super initWithSize:size]) {
    /* Setup your scene here */
    
    self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
    [self initHorProblem];
    [self initVerProblem];
    for (int i = 0; i < self.wordArray.count; i++) {
      NSArray *currentArray = [self.wordArray objectAtIndex:i];
      for (int j = 0; j < currentArray.count; j++) {
        NSString *currentValue = [currentArray objectAtIndex:j];
        SKSpriteNode *currentSprite;
        if ([currentValue isEqualToString:@"1"]) {
          currentSprite = [SKSpriteNode spriteNodeWithColor:[SKColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:1.0] size:CGSizeMake(20, 20)];
        } else {
          currentSprite = [SKSpriteNode spriteNodeWithColor:[SKColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0] size:CGSizeMake(20, 20)];
        }
        [currentSprite setName:[NSString stringWithFormat:@"%d,%d",j,i]];
        currentSprite.position = CGPointMake( 30 + 20 * j, 390 - 20 * i );
        
        SKLabelNode *currentLabelNode = [SKLabelNode labelNodeWithFontNamed:@"Geogia"];
        currentLabelNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        currentLabelNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        currentLabelNode.fontSize = 12;
        currentLabelNode.fontColor = [UIColor blackColor];
        [currentLabelNode setName:@"text"];
        [currentLabelNode setUserInteractionEnabled:NO];
        [currentSprite addChild:currentLabelNode];
        [self addChild:currentSprite];
      }
      
      self.labelNode = [SKLabelNode labelNodeWithFontNamed:@"Geogia"];
      self.labelNode.fontSize = 16;
      self.labelNode.position = CGPointMake(160, 480);
      [self.labelNode setName:@"problem"];
      [self addChild:self.labelNode];
    }
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

- (void)fillingLeft:(CGPoint)point {
  if ([self haveLeftTextFieldCellWithPostion:point]) {
    [(SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]] setColor:[UIColor colorWithRed:1.0 green:0.0 blue:1.0 alpha:1.0]];
    [self fillingLeft:CGPointMake(point.x - 1, point.y)];
  } else {
    [(SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]] setColor:[UIColor colorWithRed:1.0 green:0.0 blue:1.0 alpha:1.0]];
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
    for (int i = 0; i < answerString.length; i ++) {
      char currentChar = [answerString characterAtIndex:i];
      SKSpriteNode *currentNode = [self getNodeWithPoint:CGPointMake(currentPoint.x+i, currentPoint.y)];
      SKLabelNode *label = (SKLabelNode*)[currentNode childNodeWithName:@"text"];
      label.text = [NSString stringWithFormat:@"%c",currentChar];
      if (![self haveRightTextFieldCellWithPostion:CGPointMake(currentPoint.x + i, currentPoint.y)]){
        break;
      }
    }
    CGPoint lastStringNodePoint = CGPointMake(currentPoint.x + answerString.length - 1, currentPoint.y);
    if ([self haveRightTextFieldCellWithPostion:lastStringNodePoint]) {
      
    }
    
  }else {
    CGPoint currentPoint = [[self.verProblemArray objectAtIndex:(self.currentProblemNumber - 1)] CGPointValue];
    for (int i = 0; i < answerString.length; i ++) {
      char currentChar = [answerString characterAtIndex:i];
      SKSpriteNode *currentNode = [self getNodeWithPoint:CGPointMake(currentPoint.x, currentPoint.y + i)];
      SKLabelNode *label = (SKLabelNode*)[currentNode childNodeWithName:@"text"];
      label.text = [NSString stringWithFormat:@"%c",currentChar];
      if (![self haveDownTextFieldCellWithPostion:CGPointMake(currentPoint.x, currentPoint.y + i)]) {
        break;
      }
    }
  }
  
  
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  return  YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [self setAnswerStringToCrossWithString:self.textField.text];
  [textField resignFirstResponder];
  return  YES;
}

@end
