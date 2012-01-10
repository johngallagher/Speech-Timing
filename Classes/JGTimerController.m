#import "JGTimerController.h"
#import "JGTimerControllerDelegate.h"
#import "JGTimerDurationCalculator.h"

@implementation JGTimerController

-(void)initDelegate:(id <JGTimerControllerDelegate>)delegate_ {
    if (![delegate_ conformsToProtocol:@protocol(JGTimerControllerDelegate)]) {
        _delegate = nil;
        return;
    }
    _delegate = delegate_;
}

-(void)initCardTimesFromDuration:(NSUInteger)duration_ {
    JGTimerDurationCalculator *calculator = [[JGTimerDurationCalculator calculatorWithDuration:duration_] retain];
    greenCardTime  = [calculator greenCardTime];
    yellowCardTime = [calculator yellowCardTime];
    redCardTime    = [calculator redCardTime];
    [calculator release];
}

+(JGTimerController *)timerWithDurationValue:(NSUInteger)durationValue delegate:(id <JGTimerControllerDelegate>)delegate_ {
    JGTimerController *instance = [[[JGTimerController alloc] initWithDurationValue:durationValue delegate:delegate_] autorelease];
    return instance;
}

-(JGTimerController *)initWithDurationValue:(NSUInteger)durationValue delegate:(id <JGTimerControllerDelegate>)delegate_ {
    self = [super init];

    [self initDelegate:delegate_];
    [self initCardTimesFromDuration:durationValue];
    timerRunning = NO;

    return self;
}

-(void)startTimer {
    timerRunning = YES;

    if (redCardTime == 0) {
        [self showRedCard:nil];
        return;
    }

    [NSTimer scheduledTimerWithTimeInterval:greenCardTime target:self selector:@selector(showGreenCard:) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:yellowCardTime target:self selector:@selector(showYellowCard:) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:redCardTime target:self selector:@selector(showRedCard:) userInfo:nil repeats:NO];
}

-(void)showCard:(NSString *)cardName andInvalidateTimer:(NSTimer *)timer_ {
    [timer_ invalidate];
    if (timerRunning)
        [_delegate performSelector:NSSelectorFromString([NSString stringWithFormat:@"show%@Card", cardName])];
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