#import "JGCardTimesCalculator.h"
#import "JGTimerController.h"
#import "JGTimerControllerDelegate.h"

@interface JGTimerController ()

-(JGTimerController *)initWithStartTime:(NSDate *)startTime andFireTime:(NSDate *)fireTime_ delegate_:(id <JGTimerControllerDelegate>)delegate_;


-(void)initDelegate:(id <JGTimerControllerDelegate>)delegate_;

-(void)initWithStartTime:(NSDate *)startTime_ fireTime:(NSDate *)fireTime_;

-(void)_showCard:(NSString *)cardName;


@end

@implementation JGTimerController

+(JGTimerController *)timerStartingAt:(NSDate *)startDate_ withFireDate:(NSDate *)fireDate_ delegate:(id <JGTimerControllerDelegate>)delegate_ {
    return [[[JGTimerController alloc] initWithStartTime:startDate_ andFireTime:fireDate_ delegate_:delegate_] autorelease];
}

+(JGTimerController *)timerStartingNowWithTimeInterval:(NSTimeInterval)timeInterval_ delegate:(id <JGTimerControllerDelegate>)delegate_ {
    return [[[JGTimerController alloc] initWithStartTime:[NSDate date] andFireTime:[NSDate dateWithTimeIntervalSinceNow:timeInterval_] delegate_:delegate_] autorelease];
}

-(JGTimerController *)initWithStartTime:(NSDate *)startTime andFireTime:(NSDate *)fireTime_ delegate_:(id <JGTimerControllerDelegate>)delegate_ {
    BOOL startTimeIsLaterThanFireTime = ([startTime compare:fireTime_] == NSOrderedDescending);
    if (startTimeIsLaterThanFireTime) {
        return nil;
    }
    
    self = [super init];

    [self initDelegate:delegate_];
    [self initWithStartTime:startTime fireTime:fireTime_];
    timerRunning = NO;

    return self;
}

-(void)initDelegate:(id <JGTimerControllerDelegate>)delegate_ {
    if (![delegate_ conformsToProtocol:@protocol(JGTimerControllerDelegate)]) {
        _delegate = nil;
        return;
    }
    _delegate = delegate_;
}

-(void)initWithStartTime:(NSDate *)startTime_ fireTime:(NSDate *)fireTime_ {
    // TODO change duration calculator to time interval
    JGCardTimesCalculator *calculator = [[JGCardTimesCalculator calculatorWithStartTime:startTime_ andFireTime:fireTime_] retain];
    greenCardTime  = [calculator greenCardTime];
    yellowCardTime = [calculator yellowCardTime];
    redCardTime    = [calculator redCardTime];
//    NSLog(@"Green time: %@ Yellow time: %@ REd Time %@", greenCardTime, yellowCardTime, redCardTime);
    // TODO add method to the protocol - vibrate - at the time limit. If we're past the time limit don't vibrate.
    // TODO work out what card we should be showing right now
    [calculator release];
}

-(void)showCurrentCard {
    NSTimeInterval greenTimeInterval = [greenCardTime timeIntervalSinceDate:[NSDate date]];
//    NSLog(@"Green time interval is %f", greenTimeInterval);
    if (greenTimeInterval < 0) {
        [self _showCard:@"Green"];
    }
}

-(void)addGreenCardTimer {
    NSTimeInterval greenTimeInterval = [greenCardTime timeIntervalSinceDate:[NSDate date]];
    if (greenTimeInterval > 0) {
        [NSTimer scheduledTimerWithTimeInterval:greenTimeInterval target:self selector:@selector(showGreenCard:) userInfo:nil repeats:NO];
    }
}

-(void)addYellowCardTimer {
    NSTimeInterval yellowTimeInterval = [yellowCardTime timeIntervalSinceDate:[NSDate date]];
    if (yellowTimeInterval > 0) {
        [NSTimer scheduledTimerWithTimeInterval:yellowTimeInterval target:self selector:@selector(showYellowCard:) userInfo:nil repeats:NO];
    }
}

-(void)addRedCardTimer {
    NSTimeInterval redTimeInterval = [redCardTime timeIntervalSinceDate:[NSDate date]];
    if (redTimeInterval > 0) {
        [NSTimer scheduledTimerWithTimeInterval:redTimeInterval target:self selector:@selector(showRedCard:) userInfo:nil repeats:NO];
    }
}

-(void)startTimer {
    timerRunning = YES;

    if (round([redCardTime timeIntervalSinceNow]) == 0) {
        [self showRedCard:nil];
        return;
    }

    [self showCurrentCard];
    [self addGreenCardTimer];
    [self addYellowCardTimer];
    [self addRedCardTimer];
}

-(void)_showCard:(NSString *)cardName {
    if (timerRunning) {
        [_delegate performSelector:NSSelectorFromString([NSString stringWithFormat:@"show%@Card", cardName])];
    }
}

-(void)showCard:(NSString *)cardName andInvalidateTimer:(NSTimer *)timer_ {
    [timer_ invalidate];
    [self _showCard:cardName];
}



-(void)showGreenCard:(NSTimer *)timer_ {
    [self showCard:@"Green" andInvalidateTimer:timer_];
}

-(void)showYellowCard:(NSTimer *)timer_ {
    [self showCard:@"Yellow" andInvalidateTimer:timer_];
}

-(void)showRedCard:(NSTimer *)timer_ {
    [self showCard:@"Red" andInvalidateTimer:timer_];
}

-(void)stopTimer {
    timerRunning = NO;
}

-(void)dealloc {
    [super dealloc];
}

@end