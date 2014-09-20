//
//  ofAppViewController.m
//  goldenLocust
//
//  Created by Kong king sin on 20/9/14.
//
//

#import "ofAppViewController.h"
#import "ofxiOSExtras.h"

@implementation ofAppViewController

- (id) initWithFrame:(CGRect)frame app:(ofxiOSApp *)app {
    
    ofxiOSGetOFWindow()->setOrientation( OF_ORIENTATION_DEFAULT );   //-- default portait orientation.
    
    return self = [super initWithFrame:frame app:app];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return NO;
}


@end