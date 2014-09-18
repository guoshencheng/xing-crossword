
#import "ViewController.h"
#import "MyScene.h"

@implementation ViewController

+ (id)create {
  return [[ViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  SKView * skView = (SKView *)self.skView;
//  skView.showsFPS = YES;
//  skView.showsNodeCount = YES;
  self.scene = [MyScene sceneWithSize:skView.bounds.size];
  self.scene.scaleMode = SKSceneScaleModeAspectFill;
  
  self.scene.delegate = self;
  self.scene.title = self.title;
  self.scene.puzzleId = self.puzzleId;
  [self.scene createAcross];
  [skView presentScene:self.scene];
  [self configureScrollView];
}

- (void)configureScrollView {
  self.scrollView.frame = CGRectMake(0, 0, [self screenWidth], [self screenHeight] - 180);
  self.scrollView.delegate = self;
  [self.scrollView setMaximumZoomScale:2.5];
  [self.scrollView setMinimumZoomScale:1.0];
  [self.scrollView setZoomScale:1.5];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.backgroundImageView.image = [UIImage imageNamed:@"background.png"];
  self.backButtonImageView.image = [UIImage imageNamed:@"button.png"];
  self.textFieldImageView.image = [UIImage imageNamed:@"textfield.png"];
  self.textField.placeholder = @"Enter your answer here";
  self.textField.autocorrectionType = UITextAutocorrectionTypeYes;
  self.textField.keyboardType = UIKeyboardTypeDefault;
  self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
  self.textField.delegate = self;
}

- (IBAction)backButtonClickAction:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)MySceneSetLabelText:(NSString *)label {
  self.problemLabel.text = label;
}

- (void)MySceneTextfiledBecomeFirstResponse {
  [self.textField becomeFirstResponder];
}

- (void)MySceneTextfiledResignFirstResponder {
  [self.textField resignFirstResponder];
}

- (void)MySceneUpdateLabelColor:(UIColor *)color {
  self.problemLabel.textColor = color;
}

- (void)MySceneUpdateTextFieldText:(NSString *)text {
  self.textField.text = text;
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
  return self.skView;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  return  YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  textField.text = [self.scene textFieldWillBeginEditWithText];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [self.scene textfieldReturened:textField.text];
  return YES;
}

- (BOOL)shouldAutorotate
{
  return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    return UIInterfaceOrientationMaskAllButUpsideDown;
  } else {
    return UIInterfaceOrientationMaskAll;
  }
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

#pragma mark - UIScreen Tool

- (CGFloat)screenWidth {
  return [[UIScreen mainScreen] bounds].size.width;
}

- (CGFloat)screenHeight {
  return [[UIScreen mainScreen] bounds].size.height;
}


@end
