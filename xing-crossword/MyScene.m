
#import "MyScene.h"

@implementation MyScene

-(id)initWithSize:(CGSize)size {
  
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
                     @[@"1",@"1",@"1",@"0",@"1",@"1",@"1",@"1",@"0",@"0",@"1",@"1",@"0",@"1"]];
  
  
  
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
        
        SKSpriteNode *answerBackgroundNode = [SKSpriteNode spriteNodeWithColor:[SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0] size:CGSizeMake(160, 20)];
        [answerBackgroundNode setName:@"answerbackground"];
        answerBackgroundNode.position = CGPointMake(160, 455);
        [self addChild:answerBackgroundNode];
        
        self.labelNode = [SKLabelNode labelNodeWithFontNamed:@"Geogia"];
        self.labelNode.fontSize = 16;
        self.labelNode.position = CGPointMake(160, 480);
        [self.labelNode setName:@"problem"];
        [self addChild:self.labelNode];
        
        self.answerLabelNode = [SKLabelNode labelNodeWithFontNamed:@"Geogia"];
        self.answerLabelNode.fontSize = 16;
        self.answerLabelNode.position = CGPointMake(160, 450);
        self.answerLabelNode.fontColor  = [UIColor blackColor];
        [self.answerLabelNode setName:@"answer"];
        [self addChild:self.answerLabelNode];
        [self addChild:currentSprite];
      }
    }
  }
  return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  for (UITouch *touch in touches) {
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    NSLog(@"%@",node.name);
    if ([node.name isEqual:@"problem"]) {
      [self.field resignFirstResponder];
      continue;
    }
    if ([node.name isEqual:@"answer"]) {
      continue;
    }
    if ([node.name isEqual:@"answerbackground"]) {
      if (self.field == nil){
          self.field = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
          self.field.delegate = self;
          self.field.hidden = true;
          [self.view addSubview:self.field];
        }
      self.field.text = self.answerLabelNode.text;
      [self.field becomeFirstResponder];
      continue;
    }
    [self.field resignFirstResponder];
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
  
        }else {
          [self resetColor];
          [self fillingUp:mytouch];
          [self fillingDown:mytouch];
          int problemNumber = [self findProblemInVerProblemWithCGPoint:mytouch];
          [self.labelNode setText:[NSString stringWithFormat:@"%@:%d",@"纵向问题",problemNumber]];

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

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
  self.answerLabelNode.text = newString;
  return  YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return  YES;
}

@end
