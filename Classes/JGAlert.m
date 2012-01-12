#import "JGAlert.h"

@implementation JGAlert
@synthesize startTime;
@synthesize fireTime;

-(NSTimeInterval)duration {
    return [startTime timeIntervalSinceDate:fireTime];
}

-(void)dealloc {
    [startTime release];
    [fireTime release];
    [super dealloc];
}
@end