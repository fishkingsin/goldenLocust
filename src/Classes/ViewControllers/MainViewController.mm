//
//  MainViewController.m
//  goldenLocust
//
//  Created by Kong king sin on 20/9/14.
//
//

#import "MainViewController.h"
#import "ofAppViewController.h"
#import "ofApp.h"
#import "TutorialViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController
- (UIButton*) makeButtonWithFrame:(CGRect)frame
                          andText:(NSString*)text {
    
    UILabel *label;
    label = [[[ UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)] autorelease];
    label.backgroundColor = [UIColor colorWithWhite:1 alpha:0.95];
    label.textColor = [UIColor colorWithWhite:0 alpha:1];
    label.text = [text uppercaseString];
    label.textAlignment = UITextAlignmentCenter;
    label.userInteractionEnabled = NO;
    label.exclusiveTouch = NO;
    
    UIButton* button = [[[UIButton alloc] initWithFrame:frame] autorelease];
    [button setBackgroundColor:[UIColor clearColor]];
    [button addSubview:label];
    
    return button;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *button;
      CGRect screenRect = [[UIScreen mainScreen] bounds];
    button = [self makeButtonWithFrame:screenRect
                               andText:@"Start"];

    [self addChildViewController:[[[TutorialViewController alloc]init]autorelease]];
    
    [button addTarget:self action:@selector(button1Pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    self.navigationController.navigationBar.topItem.rightBarButtonItem = [[[UIBarButtonItem alloc]initWithImage: [UIImage imageNamed:@"icon-info"]
                                                                                                          style:UIBarButtonItemStylePlain
                                                                                                         target:self
                                                                                                         action:@selector(infoBarButtonPress)]autorelease];
    self.navigationController.navigationBar.topItem.leftBarButtonItem = [[[UIBarButtonItem alloc]initWithImage: [UIImage imageNamed:@"icon-setting"]
                                                                                                          style:UIBarButtonItemStylePlain
                                                                                                         target:self
                                                                                                         action:@selector(settingBarButtonPress)]autorelease];

}
- (void)button1Pressed:(id)sender {
    ofAppViewController *viewController;
    viewController = [[[ofAppViewController alloc] initWithFrame:[[UIScreen mainScreen] bounds]
                                                                 app:new ofApp()] autorelease];
    
    [self.navigationController pushViewController:viewController animated:YES];
    self.navigationController.navigationBar.topItem.title = @"ofApp";


}
-(void)settingBarButtonPress
{
    
}

-(void)infoBarButtonPress
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
