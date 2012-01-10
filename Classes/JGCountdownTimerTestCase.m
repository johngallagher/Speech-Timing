#import "JGCountdownTimerTestCase.h"
#import "JGCountdownTimerDelegate.h"
#import "JGCountdownTimer.h"
#import "OCMockObject.h"
//#import <OCMock/OCMock.h>

@implementation JGCountdownTimerTestCase

-(void)testTimerRunningForOneSecondShouldDecreaseTimeRemaining {
    id mockDelegate = [OCMockObject mockForProtocol:@protocol(JGCountdownTimerDelegate)];
    [[mockDelegate expect] timeRemainingDidChangeTo:10];
    [[mockDelegate expect] timeRemainingDidChangeTo:9];

    JGCountdownTimer *timer = [JGCountdownTimer timerWithDurationValue:10 delegate:mockDelegate];
    [timer startTimer];

    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.1]];
    [timer stopTimer];

    [mockDelegate verify];
}

-(void)testTimerRunningForTwoSecondsShouldDecreaseTimeRemaining {
    id mockDelegate = [OCMockObject mockForProtocol:@protocol(JGCountdownTimerDelegate)];
    [[mockDelegate expect] timeRemainingDidChangeTo:10];
    [[mockDelegate expect] timeRemainingDidChangeTo:9];
    [[mockDelegate expect] timeRemainingDidChangeTo:8];

    JGCountdownTimer *timer = [JGCountdownTimer timerWithDurationValue:10 delegate:mockDelegate];
    [timer startTimer];

    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2.1]];
    [timer stopTimer];

    [mockDelegate verify];
}

-(void)testTimerRunningShouldGoNegative {
    id mockDelegate = [OCMockObject mockForProtocol:@protocol(JGCountdownTimerDelegate)];
    [[mockDelegate expect] timeRemainingDidChangeTo:1];
    [[mockDelegate expect] timeRemainingDidChangeTo:0];
    [[mockDelegate expect] timeRemainingDidChangeTo:-1];

    JGCountdownTimer *timer = [JGCountdownTimer timerWithDurationValue:1 delegate:mockDelegate];
    [timer startTimer];

    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2.1]];
    [timer stopTimer];

    [mockDelegate verify];
}

-(void)testTimerOnStopShouldStopTimer {
    id mockDelegate = [OCMockObject mockForProtocol:@protocol(JGCountdownTimerDelegate)];
    [[mockDelegate expect] timeRemainingDidChangeTo:1];
    [[mockDelegate expect] timeRemainingDidChangeTo:0];

    JGCountdownTimer *timer = [JGCountdownTimer timerWithDurationValue:1 delegate:mockDelegate];
    [timer startTimer];

    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.1]];
    [timer stopTimer];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];

    [mockDelegate verify];
}

@end
