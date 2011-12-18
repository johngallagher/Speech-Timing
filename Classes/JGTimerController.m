#import "JGTimerController.h"
#import "JGTimerControllerDelegate.h"

@implementation JGTimerController

@synthesize duration;

+(JGTimerController *)timerWithDurationValue:(NSUInteger)durationValue delegate:(id <JGTimerControllerDelegate>)delegate_ {
    return [[JGTimerController alloc] initWithDurationValue:durationValue delegate:delegate_];
}

-(JGTimerController *)initWithDurationValue:(NSUInteger)durationValue delegate:(id <JGTimerControllerDelegate>)delegate_ {
    self = [super init];
    [self setDurationValue:durationValue];
    _delegate = delegate_;
    return self;
}

-(NSUInteger)durationValue {
	NSNumber *result = [self duration];
	return result ? [result intValue] : 0;
}

-(void)setDurationValue:(NSUInteger)value_ {
	[self setDuration:[NSNumber numberWithInt:value_]];
}

-(void)startTimer {
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerDidCountDownByASecond:) userInfo:nil repeats:YES];
}

-(void)stopTimer:(NSTimer *)timer_ {
    if ([_delegate conformsToProtocol:@protocol(JGTimerControllerDelegate)])
        [_delegate timerDidStop];

    [timer_ invalidate];
    [timer invalidate];
    timer = nil;
}

-(BOOL)timerIsRunning {
    return (timer != nil);
}

-(void)timerDidCountDownByASecond:(NSTimer *)timer_ {
    [self setDurationValue:[self durationValue] - 1];
    if ([self durationValue] == 0)
        [self stopTimer:timer_];
}

     
@end

