//
//  JGDrawingTestView.h
//  DrawLineTest1
//
//  Created by John Gallagher on 04/01/2012.
//  Copyright 2012 Synaptic Mishap. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JGPieChartView;
@class JGPieChartAnimationParameters;

@interface JGTimerRunningView : UIView {
    JGPieChartView *pieChartLayer;
}

-(void)startCountdownAnimationWithParameters:(JGPieChartAnimationParameters *)parameters_;

-(void)suspendCountdownAnimation;


@end

