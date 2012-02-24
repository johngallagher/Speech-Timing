#import "JGTimerDefaults.h"
#import <OCMock/OCMock.h>
#import "JGTimerDefaultsTestCase.h"

@implementation JGTimerDefaultsTestCase
// Timer is running
-(void)testGivenStartTimeAndFireTimeNilTimerShouldNotBeRunning {
    JGTimerDefaults *timerDefaults = [JGTimerDefaults sharedInstance];
    mockUserDefaults = [OCMockObject mockForClass:[NSUserDefaults class]];

    [[[mockUserDefaults expect] andReturn:nil] objectForKey:kStartTime];
    [[[mockUserDefaults expect] andReturn:nil] objectForKey:kFireTime];

    [timerDefaults setValue:mockUserDefaults forKey:@"userDefaults"];

    STAssertFalse([timerDefaults timerIsRunning], nil);
    
    [mockUserDefaults verify];
}

#pragma mark currentTimeNearFireTime
-(void)testGivenFireTimeIsNowShouldReturnYes {
    [[JGTimerDefaults sharedInstance] setFireTime:[NSDate date]];
    STAssertTrue([[JGTimerDefaults sharedInstance] currentTimeNearFireTime], nil);
}
-(void)testGivenFireTimeIsOneSecondBeforeNowShouldReturnNo {
    [[JGTimerDefaults sharedInstance] setFireTime:[NSDate dateWithTimeIntervalSinceNow:1]];
    STAssertFalse([[JGTimerDefaults sharedInstance] currentTimeNearFireTime], nil);
}

-(void)testGivenFireTimeIsOneSecondAfterNowShouldReturnNo {
    [[JGTimerDefaults sharedInstance] setFireTime:[NSDate dateWithTimeIntervalSinceNow:-1]];
    STAssertFalse([[JGTimerDefaults sharedInstance] currentTimeNearFireTime], nil);
}

@end