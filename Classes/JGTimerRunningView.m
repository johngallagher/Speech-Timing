//
//  JGDrawingTestView.m
//  DrawLineTest1
//
//  Created by John Gallagher on 04/01/2012.
//  Copyright 2012 Synaptic Mishap. All rights reserved.
//

#import "JGTimerRunningView.h"
#import <QuartzCore/QuartzCore.h>
#import "JGPieChartView.h"
#import "JGPieChartAnimationParameters.h"

@interface JGTimerRunningView ()

-(CABasicAnimation *)animationForKeyPath:(NSString *)keyPath fromValue:(CGFloat)fromValue toValue:(CGFloat)toValue duration:(NSTimeInterval)duration_;

@end


@implementation JGTimerRunningView

-(CABasicAnimation *)startAngleAnimationFromParameters:(JGPieChartAnimationParameters *)parameters_ {
    // The start angle is always the same - the pie chart always starts at the 12 o'clock position or -90
    CABasicAnimation *startAngleAnimation = [self animationForKeyPath:@"startAngle" fromValue:-90 toValue:-90 duration:[parameters_ duration]];
    return startAngleAnimation;
}

-(CABasicAnimation *)endAngleAnimationFromParameters:(JGPieChartAnimationParameters *)parameters_ {
    CABasicAnimation *endAngleAnimation = [self animationForKeyPath:@"endAngle" fromValue:[parameters_ fromAngle] toValue:[parameters_ toAngle] duration:[parameters_ duration]];
    return endAngleAnimation;
}

-(void)startCountdownAnimationWithParameters:(JGPieChartAnimationParameters *)parameters_ {
    if (!parameters_)
        return;

    JGPieChartView *layer = [[JGPieChartView alloc] initWithFrame:[self bounds]];
    pieChartLayer = [layer retain];
    [[self layer] addSublayer:pieChartLayer];
    [layer release];

    CABasicAnimation *endAngleAnimation   = [self endAngleAnimationFromParameters:parameters_];
    CABasicAnimation *startAngleAnimation = [self startAngleAnimationFromParameters:parameters_];

    [pieChartLayer addAnimation:startAngleAnimation forKey:@"animateStartAngle"];
    [pieChartLayer addAnimation:endAngleAnimation forKey:@"animateEndAngle"];
}

-(void)removePieChartLayerFromSuperlayer {
    [pieChartLayer removeFromSuperlayer];
}

-(void)suspendCountdownAnimation {
    [self removePieChartLayerFromSuperlayer];
}

-(CABasicAnimation *)animationForKeyPath:(NSString *)keyPath fromValue:(CGFloat)fromValue toValue:(CGFloat)toValue duration:(NSTimeInterval)duration_ {
    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.fromValue      = [NSNumber numberWithFloat:fromValue];
    animation.toValue        = [NSNumber numberWithFloat:toValue];
    animation.timingFunction = timingFunction;
    [animation setDuration:duration_];
    return animation;
}

-(void)dealloc {
    [pieChartLayer release];
    [super dealloc];
}

@end

