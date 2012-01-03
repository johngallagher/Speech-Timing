#import <Foundation/Foundation.h>

@protocol JGTimerControllerDelegate;

@interface JGTimerController : NSObject {
    NSTimeInterval  timeRemaining;
    
    id <NSObject, JGTimerControllerDelegate> _delegate;
    
    NSTimeInterval  greenCardTime;
    NSTimeInterval  yellowCardTime;
    NSTimeInterval  redCardTime;
    
    BOOL timerRunning;
}

+(JGTimerController *)timerWithDurationValue:(NSUInteger)durationValue delegate:(id <JGTimerControllerDelegate>)delegate_;

-(JGTimerController *)initWithDurationValue:(NSUInteger)durationValue delegate:(id <JGTimerControllerDelegate>)delegate_;

-(void)startTimer;

-(void)stopTimer;

-(void)showGreenCard:(NSTimer *)timer_;

-(void)showYellowCard:(NSTimer *)timer_;

-(void)showRedCard:(NSTimer *)timer_;

@end

