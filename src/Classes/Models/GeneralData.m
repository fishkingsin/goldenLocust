//
//  GeneralData.m
//  goldenLocust
//
//  Created by Kong king sin on 20/9/14.
//
//

#import "GeneralData.h"

@implementation GeneralData
static GeneralData *sharedInstance = nil;
+ (GeneralData *)sharedInstance
{
    
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
@end
