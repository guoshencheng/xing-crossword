
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
  skView.showsFPS = YES;
  skView.showsNodeCount = YES;
  MyScene * scene = [MyScene sceneWithSize:skView.bounds.size];
  scene.scaleMode = SKSceneScaleModeAspectFill;
  scene.delegate = self;
  scene.title = self.title;
  scene.puzzleId = self.puzzleId;
  [scene createAcross];
  [skView presentScene:scene];
}

- (void)mySceneWillPop:(MyScene *)myscene {
  [self.navigationController popViewControllerAnimated:YES];
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

@end
