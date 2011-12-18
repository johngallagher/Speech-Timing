#import "AbstractSingletonObject.h"

@interface JGTimerController : AbstractSingletonObject {
    NSNumber    *duration;
    NSTimer     *timer;
}

@property (nonatomic, retain) NSNumber *duration;

-(NSUInteger)durationValue;

-(void)setDurationValue:(NSUInteger)value_;

-(void)startTimer;

-(void)stopTimer:(NSTimer *)timer_;

-(BOOL)timerIsRunning;

@end

