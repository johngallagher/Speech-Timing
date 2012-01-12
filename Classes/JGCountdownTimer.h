#import <Foundation/Foundation.h>
#import "JGCountdownTimerDelegate.h"

@interface JGCountdownTimer : NSObject {
    NSTimer *countdownTimer;
    id <NSObject, JGCountdownTimerDelegate> _delegate;
    NSDate *timerEndDate;
}

@property(nonatomic, retain) NSDate *timerEndDate;

+(JGCountdownTimer *)timerStartingAt:(NSDate *)startTime_ withFireDate:(NSDate *)fireDate_ delegate:(id <JGCountdownTimerDelegate>)delegate_;


-(void)startTimer;

-(void)stopTimer;


-(void)timerDidCountDownByOneSecond:(NSTimer *)timer_;


@end
