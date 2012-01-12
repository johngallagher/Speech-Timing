#import <Foundation/Foundation.h>
#import "JGCountdownTimerDelegate.h"

@interface JGCountdownTimer : NSObject {
    NSTimer *countdownTimer;
    id <NSObject, JGCountdownTimerDelegate> _delegate;
    NSDate *timerEndDate;
}

@property(nonatomic, retain) NSDate *timerEndDate;

+(JGCountdownTimer *)timerStartingAt:(NSDate *)startTime_ withFireDate:(NSDate *)fireDate_ delegate:(id <JGCountdownTimerDelegate>)delegate_;

+(JGCountdownTimer *)timerStartingNowWithTimeInterval:(NSTimeInterval)i delegate:(id)o;

-(JGCountdownTimer *)initStartingAt:(NSDate *)startTime_ withFireDate:(NSDate *)fireDate_ delegate:(id <JGCountdownTimerDelegate>)delegate_;

-(void)startTimer;

-(void)stopTimer;



@end
