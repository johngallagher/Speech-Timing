#import "JGAlert.h"

@implementation JGAlert


@synthesize name = _name;
@synthesize startTime = _startTime;
@synthesize fireTime = _fireTime;


+(id)alertWithStartTime:(NSDate *)startTime_ fireTime:(NSDate *)fireTime_ name:(NSString *)name_ {
    return [[[[self class] alloc] initWithStartTime:startTime_ fireTime:fireTime_] autorelease];
}

-(id)initWithStartTime:(NSDate *)startTime_ fireTime:fireTime_ name:name_ {
    self = [super init];
    if (self) {
        _startTime = [startTime_ retain];
        _fireTime = [fireTime_ retain];
        _name = [name_ retain];
    }

    return self;
}

-(NSTimeInterval)duration {
    return [_startTime timeIntervalSinceDate:_fireTime];
}

-(void)dealloc {
    [_startTime release];
    [_fireTime release];
    [_name release];
    [super dealloc];
}
@end