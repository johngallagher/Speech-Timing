#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>

@class JGCountdownTimer;

@interface JGCountdownTimerTestCase : SenTestCase {
    JGCountdownTimer *timer;
    id mockDelegate;
}


@end
