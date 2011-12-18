#import "JGTimerController.h"

@implementation JGTimerController

@synthesize duration;

-(NSUInteger)durationValue {
	NSNumber *result = [self duration];
	return result ? [result intValue] : 0;
}

-(void)setDurationValue:(NSUInteger)value_ {
	[self setDuration:[NSNumber numberWithInt:value_]];
}

-(void)startTimer {
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerDidCountDownByASecond:) userInfo:nil repeats:YES];
}

-(void)timerDidCountDownByASecond:(NSTimer *)timer {
    [self setDurationValue:[self durationValue] - 1];
}

@end

