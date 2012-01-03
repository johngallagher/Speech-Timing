#import <Foundation/Foundation.h>
#import "JGCountdownTimerDelegate.h"

@interface JGCountdownTimer : NSObject {
    NSTimeInterval  timeRemaining;
    NSTimer        *countdownTimer;
    id <NSObject, JGCountdownTimerDelegate> _delegate;
}

+(JGCountdownTimer *)timerWithDurationValue:(NSUInteger)durationValue delegate:(id <JGCountdownTimerDelegate>)delegate_;


-(void)startTimer;

-(void)stopTimer;


-(void)timerDidCountDownByOneSecond:(NSTimer *)timer_;





@end
