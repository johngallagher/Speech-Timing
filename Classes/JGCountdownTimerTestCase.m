#import <OCMock/OCMock.h>
#import "JGCountdownTimerTestCase.h"
#import "JGCountdownTimerDelegate.h"
#import "JGCountdownTimer.h"

@interface JGCountdownTimerTestCase ()
-(void)startTimerWithTimeInterval:(NSTimeInterval)timeInterval_;

-(void)stopTimerAfterTimeInterval:(NSTimeInterval)timeInterval_;

-(void)pauseForTimeInterval:(NSTimeInterval)timeInterval_;

@end

@implementation JGCountdownTimerTestCase

-(void)setUp {
    [super setUp];
    mockDelegate = [OCMockObject mockForProtocol:@protocol(JGCountdownTimerDelegate)];
}

-(void)startTimerWithTimeInterval:(NSTimeInterval)timeInterval_ {
    timer = [JGCountdownTimer timerStartingNowWithTimeInterval:timeInterval_ delegate:mockDelegate];
    [timer startTimer];
}

-(void)stopTimerAfterTimeInterval:(NSTimeInterval)timeInterval_ {
    [self pauseForTimeInterval:timeInterval_];
    [timer stopTimer];
}

-(void)pauseForTimeInterval:(NSTimeInterval)timeInterval_ {
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:timeInterval_]];
}

//-(void)testTimerRunningForOneSecondShouldDecreaseTimeRemaining {
//    [[mockDelegate expect] timeRemainingDidChangeTo:10];
//    [[mockDelegate expect] timeRemainingDidChangeTo:9];
//
//    [self startTimerWithTimeInterval:10];
//    [self stopTimerAfterTimeInterval:1.1];
//
//    [mockDelegate verify];
//}

-(void)testTimerRunningForTwoSecondsShouldDecreaseTimeRemaining {
    [[mockDelegate expect] timeRemainingDidChangeTo:10];
    [[mockDelegate expect] timeRemainingDidChangeTo:9];
    [[mockDelegate expect] timeRemainingDidChangeTo:8];

    [self startTimerWithTimeInterval:10];
    [self stopTimerAfterTimeInterval:2.1];

    [mockDelegate verify];
}

-(void)testTimerRunningShouldGoNegative {
    [[mockDelegate expect] timeRemainingDidChangeTo:1];
    [[mockDelegate expect] timeRemainingDidChangeTo:0];
    [[mockDelegate expect] timeRemainingDidChangeTo:-1];

    [self startTimerWithTimeInterval:1];

    [self stopTimerAfterTimeInterval:2.1];

    [mockDelegate verify];
}

-(void)testTimerOnStopShouldStopTimer {
    [[mockDelegate expect] timeRemainingDidChangeTo:1];
    [[mockDelegate expect] timeRemainingDidChangeTo:0];

    [self startTimerWithTimeInterval:1];

    [self stopTimerAfterTimeInterval:1.1];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];

    [mockDelegate verify];
}

@end
