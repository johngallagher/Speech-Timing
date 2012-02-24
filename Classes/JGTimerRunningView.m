//
//  JGDrawingTestView.m
//  DrawLineTest1
//
//  Created by John Gallagher on 04/01/2012.
//  Copyright 2012 Synaptic Mishap. All rights reserved.
//

#import "JGTimerRunningView.h"
#import <QuartzCore/QuartzCore.h>
#import "JGPieChartLayer.h"
#import "JGPieChartAnimationParameters.h"

@interface JGTimerRunningView ()

-(CABasicAnimation *)_animationForKeyPath:(NSString *)keyPath
                                fromValue:(NSNumber *)fromValue
                                  toValue:(NSNumber *)toValue;

-(void)_animateToAngle:(CGFloat)angle;


@end


@implementation JGTimerRunningView

@synthesize animationDuration;

-(void)setupWithPieChartAnimation:(JGPieChartAnimationParameters *)animParams {
    pieChartAnimParams = [animParams retain];

    animationDuration = [animParams duration];

//    JGPieChartLayer *layer = [[JGPieChartLayer alloc] initWithPieChartAnimation:animParams andFrame:[self bounds]];
//    pieChartLayer = [layer retain];
//    [layer release];

}
//    [self _animateToAngle:270];
//    NSNumber *startAngle_ = [pieChartLayer lastValueForKey:@"endAngle"]; // [NSNumber numberWithFloat:-90.0]


-(void)startCountdownAnimation {

    JGPieChartAnimationParameters *animationParameters = [[[JGPieChartAnimationParameters alloc] initWithStartAngle:-90 endAngle:0 duration:60] autorelease];

    JGPieChartLayer *layer = [[JGPieChartLayer alloc] initWithPieChartAnimation:animationParameters andFrame:[self bounds]];
    pieChartLayer = [layer retain];
    [layer release];

    [[self layer] addSublayer:pieChartLayer];
    //    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//
//    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"endAngle"];
//    [anim setFromValue:[NSNumber numberWithFloat:-90]];
//    [anim setToValue:[NSNumber numberWithFloat:-45]];
//    [anim setTimingFunction:timingFunction];
//    [anim setDuration:60];
//    [pieChartLayer addAnimation:anim forKey:@"animateEndAngle"];



    //    [CATransaction begin];
    //    [CATransaction setAnimationDuration:[self animationDuration]];
    //    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    //
    //    CABasicAnimation *animEndAngle = [self _animationForKeyPath:@"endAngle"
    //                                                      fromValue:[NSNumber numberWithFloat:-90.0]
    //                                                        toValue:[NSNumber numberWithFloat:90.0]];
    //    [pieChartLayer addAnimation:animEndAngle forKey:@"animateEndAngle"];
    //
    //    [CATransaction commit];
}

-(void)_animateToAngle:(CGFloat)angle {
}

-(CABasicAnimation *)_animationForKeyPath:(NSString *)keyPath
                                fromValue:(NSNumber *)fromValue
                                  toValue:(NSNumber *)toValue {

    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];

    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:keyPath];
    anim.fromValue      = fromValue;
    anim.toValue        = toValue;
    anim.timingFunction = timingFunction;
    NSLog(@"Animating from %f to %f", [[anim fromValue] floatValue], [[anim toValue] floatValue]);
    return anim;
}

-(void)dealloc {
    [pieChartLayer release];
    [pieChartAnimParams release];
    [super dealloc];
}
@end

