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
}
@end