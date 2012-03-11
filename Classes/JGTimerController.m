#import "JGCardTimesCalculator.h"
#import "JGTimerController.h"
#import "JGTimerControllerDelegate.h"

@interface JGTimerController ()

-(JGTimerController *)initWithStartTime:(NSDate *)startTime andFireTime:(NSDate *)fireTime_ delegate_:(id <JGTimerControllerDelegate>)delegate_;


-(void)initDelegate:(id <JGTimerControllerDelegate>)delegate_;

-(void)initWithStartTime:(NSDate *)startTime_ fireTime:(NSDate *)fireTime_;

-(void)showCard:(NSString *)cardName;


@end

@implementation JGTimerController

+(JGTimerController *)timerStartingAt:(NSDate *)startTime_ withFireTime:(NSDate *)fireTime_ delegate:(id <JGTimerControllerDelegate>)delegate_ {
    return [[[JGTimerController alloc] initWithStartTime:startTime_ andFireTime:fireTime_ delegate_:delegate_] autorelease];
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
    JGCardTimesCalculator *calculator = [[JGCardTimesCalculator calculatorWithStartTime:startTime_ andFireTime:fireTime_] retain];
    greenCardTime  = [calculator greenCardTime];
    yellowCardTime = [calculator yellowCardTime];
    redCardTime    = [calculator redCardTime];
    // TODO add method to the protocol - vibrate - at the time limit. If we're past the time limit don't vibrate.
    [calculator release];
}

// TODO Refactor out all the repetition and have a "red/green/yellow" parameter which indicates the colour of card.
-(NSTimeInterval)redCardTimeIntervalSinceNow {
    NSTimeInterval redTimeInterval = [redCardTime timeIntervalSinceDate:[NSDate date]];
    return redTimeInterval;
}

-(NSTimeInterval)yellowCardTimeIntervalSinceNow {
    NSTimeInterval yellowTimeInterval = [yellowCardTime timeIntervalSinceDate:[NSDate date]];
    return yellowTimeInterval;
}

-(NSTimeInterval)greenCardTimeIntervalSinceNow {
    NSTimeInterval greenTimeInterval = [greenCardTime timeIntervalSinceDate:[NSDate date]];
    return greenTimeInterval;
}

-(BOOL)betweenGreenAndYellowCards {
    return [self greenCardTimeIntervalSinceNow] <= 0 && [self yellowCardTimeIntervalSinceNow] > 0;
}

-(BOOL)betweenYellowAndRedCards {
    return [self yellowCardTimeIntervalSinceNow] <= 0 && [self redCardTimeIntervalSinceNow] > 0;
}

-(BOOL)afterRedCard {
    return [self redCardTimeIntervalSinceNow] <= 0;
}

-(void)showCurrentCard {
    if ([self betweenGreenAndYellowCards]) {
        [self showCard:@"Green"];
        return;
    }

    if ([self betweenYellowAndRedCards]) {
        [self showCard:@"Yellow"];
        return;
    }

    if ([self afterRedCard]) {
        [self showCard:@"Red"];
    }
}

-(BOOL)beforeGreenCard {
    return [self greenCardTimeIntervalSinceNow] > 0;
}

-(BOOL)beforeYellowCard {
    return [self yellowCardTimeIntervalSinceNow] > 0;
}

-(BOOL)beforeRedCard {
    return [self redCardTimeIntervalSinceNow] > 0;
}


-(void)addGreenCardTimer {
    if ([self beforeGreenCard]) {
        [NSTimer scheduledTimerWithTimeInterval:[self greenCardTimeIntervalSinceNow] target:self selector:@selector(showGreenCard:) userInfo:nil repeats:NO];
    }
}

-(void)addYellowCardTimer {
    if ([self beforeYellowCard]) {
        [NSTimer scheduledTimerWithTimeInterval:[self yellowCardTimeIntervalSinceNow] target:self selector:@selector(showYellowCard:) userInfo:nil repeats:NO];
    }
}

-(void)addRedCardTimer {
    if ([self beforeRedCard]) {
        [NSTimer scheduledTimerWithTimeInterval:[self redCardTimeIntervalSinceNow] target:self selector:@selector(showRedCard:) userInfo:nil repeats:NO];
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

-(void)showCard:(NSString *)cardName {
    if (timerRunning) {
        [_delegate performSelector:NSSelectorFromString([NSString stringWithFormat:@"show%@Card", cardName])];
    }
}

-(void)showCard:(NSString *)cardName andInvalidateTimer:(NSTimer *)timer_ {
    [timer_ invalidate];
    [self showCard:cardName];
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