#import <Foundation/Foundation.h>

@protocol JGTimerControllerDelegate;

@interface JGTimerController : NSObject {
    NSTimer     *greenCardTimer;
    NSTimer     *yellowCardTimer;
    NSTimer     *redCardTimer;
    
    id <NSObject, JGTimerControllerDelegate> _delegate;
    
    NSUInteger  greenCardTime;
    NSUInteger  yellowCardTime;
    NSUInteger  redCardTime;
    
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

