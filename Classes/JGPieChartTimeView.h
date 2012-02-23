//
//  JGDrawingTestView.h
//  DrawLineTest1
//
//  Created by John Gallagher on 04/01/2012.
//  Copyright 2012 Synaptic Mishap. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JGPieChartTimeLayer;

@interface JGPieChartTimeView : UIView {
    JGPieChartTimeLayer *pieChartLayer;
    NSUInteger animationDuration;
}

@property(nonatomic) NSUInteger animationDuration;

-(void)animateCountdownOverDuration:(NSUInteger)duration_;

-(void)animateCountdown;


@end

