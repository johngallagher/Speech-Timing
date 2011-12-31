#import "JGTimerController.h"
#import "JGTimerControllerDelegate.h"

@implementation JGTimerController

@synthesize duration;

+(JGTimerController *)timerWithDurationValue:(NSUInteger)durationValue delegate:(id <JGTimerControllerDelegate>)delegate_ {
    JGTimerController *instance = [[[JGTimerController alloc] initWithDurationValue:durationValue delegate:delegate_] autorelease];
    return instance;
}

-(JGTimerController *)initWithDurationValue:(NSUInteger)durationValue delegate:(id <JGTimerControllerDelegate>)delegate_ {
    self = [super init];
    timer = nil;
    [self setDurationValue:durationValue];
    _delegate = delegate_;
    greenCardTime = 2;
    yellowCardTime = 1;
    return self;
}

-(NSUInteger)durationValue {
	NSNumber *result = [self duration];
	return result ? [result intValue] : 0;
}

-(void)setDurationValue:(NSUInteger)value_ {
	[self setDuration:[NSNumber numberWithInt:value_]];
}

-(BOOL)stopTimerAtZeroDuration:(NSTimer *)timer_ {
    if ([self durationValue] == 0) {
        [self stopTimer];
        return YES;
    }
    return NO;
}

-(void)startTimer {
    if ([self stopTimerAtZeroDuration:nil])
        return;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerDidCountDownByASecond:) userInfo:nil repeats:YES];
}

-(void)stopTimer {
    if ([self durationValue] == 0 && [_delegate conformsToProtocol:@protocol(JGTimerControllerDelegate)])
        [_delegate showRedCard];

    [timer invalidate];
    timer = nil;
}

-(BOOL)timerIsRunning {
    return (timer != nil);
}

-(void)timerDidCountDownByASecond:(NSTimer *)timer_ {
    [self setDurationValue:[self durationValue] - 1];
    if (greenCardTime == [self durationValue] && [_delegate conformsToProtocol:@protocol(JGTimerControllerDelegate)])
        [_delegate showGreenCard];
    
    if (yellowCardTime == [self durationValue] && [_delegate conformsToProtocol:@protocol(JGTimerControllerDelegate)])
        [_delegate showYellowCard];
    
    [self stopTimerAtZeroDuration:timer_];
}

-(void)dealloc {
    [duration release];
    [super dealloc];
}

@end

