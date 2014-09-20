//
//  MainAppDelegate.m
//  goldenLocust
//
//  Created by Kong king sin on 20/9/14.
//
//

#import "MainAppDelegate.h"
#import "MainViewController.h"
#import "TutorialViewController.h"
@implementation MainAppDelegate
@synthesize navigationController;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [super applicationDidFinishLaunching:application];
    
    /**
     *
     *  Below is where you insert your own UIViewController and take control of the App.
     *  In this example im creating a UINavigationController and adding it as my RootViewController to the window. (this is essential)
     *  UINavigationController is handy for managing the navigation between multiple view controllers, more info here,
     *  http://developer.apple.com/library/ios/#documentation/uikit/reference/UINavigationController_Class/Reference/Reference.html
     *
     *  I then push MyAppViewController onto the UINavigationController stack.
     *  MyAppViewController is a custom view controller with a 3 button menu.
     *
     **/
    
    self.navigationController = [[[UINavigationController alloc] init] autorelease];
    [self.window setRootViewController:self.navigationController];
//    [self.window setRootViewController:[[[TutorialViewController alloc]initWithNibName:@"TutorialViewController" bundle:nil]autorelease]];
    [self.navigationController pushViewController:[[[MainViewController alloc] init] autorelease]
                                         animated:YES];
    
    //--- style the UINavigationController
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.topItem.title = @"Golden Locust";

    return YES;
}

- (void) dealloc {
    self.navigationController = nil;
    [super dealloc];
}

@end
