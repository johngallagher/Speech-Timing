#import "JGPieChartAnimationParameterCalculator.h"
#import "JGAlert.h"
#import "JGPieChartAnimationParameters.h"

@implementation JGPieChartAnimationParameterCalculator

/*
* Parameter Calculator
*
* Purpose: Takes a and start date, fire date from an alert and converts it into
*          an animation parameters object that can be used to start the animation.
*
* Rationale: If the timer has been started 10 seconds ago and we're coming back
*            to the timer screen we need to start a fresh animation starting
*            10 seconds into the pie chart, whatever angle that's at.
*
*            If we come back to the timer screen after the fire date we shouldn't even
*            see an animation.
*/

+(id)calculatorWithAlert:(JGAlert *)alert_ {
    return [[[[self class] alloc] initWithAlert:alert_] autorelease];
}

-(id)initWithAlert:(JGAlert *)alert_ {
    self = [super init];
    if (self) {
        _alert = [alert_ retain];
    }

    return self;
}

-(NSTimeInterval)timeElapsed {
    return [[NSDate date] timeIntervalSinceDate:[_alert startTime]];
}

-(NSTimeInterval)durationRemaining {
    return [[_alert fireTime] timeIntervalSinceNow];
}

-(NSTimeInterval)fractionElapsed {
    return [self timeElapsed] / [_alert duration];
}

-(CGFloat)fromAngle {
    return (CGFloat)(([self fractionElapsed] * 360) - 90);
}

-(JGPieChartAnimationParameters *)calculateParameters {
    return [JGPieChartAnimationParameters animationFromAngle:[self fromAngle]
                                                     toAngle:270
                                                    duration:[self durationRemaining]];
}

-(void)dealloc {
    [_alert release];
    [super dealloc];
}
@end

