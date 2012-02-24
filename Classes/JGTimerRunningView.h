//
//  JGDrawingTestView.h
//  DrawLineTest1
//
//  Created by John Gallagher on 04/01/2012.
//  Copyright 2012 Synaptic Mishap. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JGPieChartLayer;
@class JGPieChartAnimationParameters;

@interface JGTimerRunningView : UIView {
    JGPieChartLayer *pieChartLayer;
    NSTimeInterval animationDuration;

    JGPieChartAnimationParameters *pieChartAnimParams;
}

@property(nonatomic) NSTimeInterval animationDuration;

-(void)setupWithPieChartAnimation:(JGPieChartAnimationParameters *)pieChartAnimation;

-(void)startCountdownAnimation;


@end

