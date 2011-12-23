#import <Foundation/Foundation.h>

@protocol JGTimerControllerDelegate;

@interface JGTimerController : NSObject {
    NSNumber    *duration;
    NSTimer     *timer;
    id <NSObject, JGTimerControllerDelegate> _delegate;
    
    NSUInteger  greenCardTime;
//    NSUInteger  yellowCardTime;
//    NSUInteger  redCardTime;
}

@property (nonatomic, retain) NSNumber *duration;

+(JGTimerController *)timerWithDurationValue:(NSUInteger)durationValue delegate:(id <JGTimerControllerDelegate>)delegate_;

-(JGTimerController *)initWithDurationValue:(NSUInteger)durationValue delegate:(id <JGTimerControllerDelegate>)delegate_;

-(NSUInteger)durationValue;

-(void)setDurationValue:(NSUInteger)value_;

-(void)startTimer;

-(void)stopTimer:(NSTimer *)timer_;

-(BOOL)timerIsRunning;

@end

