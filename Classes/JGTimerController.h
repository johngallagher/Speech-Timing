#import <Foundation/Foundation.h>

@protocol JGTimerControllerDelegate;

@interface JGTimerController : NSObject {

    id <NSObject, JGTimerControllerDelegate> _delegate;

    NSDate *greenCardTime;
    NSDate *yellowCardTime;
    NSDate *redCardTime;

    BOOL timerRunning;
}

+(JGTimerController *)timerStartingAt:(NSDate *)startTime_ withFireTime:(NSDate *)fireTime_ delegate:(id <JGTimerControllerDelegate>)delegate_;

-(void)startTimer;

-(void)stopTimer;

-(void)showGreenCard:(NSTimer *)timer_;

-(void)showYellowCard:(NSTimer *)timer_;

-(void)showRedCard:(NSTimer *)timer_;

+(JGTimerController *)timerStartingNowWithTimeInterval:(NSTimeInterval)timeInterval_ delegate:(id <JGTimerControllerDelegate>)delegate_;
@end

