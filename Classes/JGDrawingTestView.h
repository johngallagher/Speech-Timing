//
//  JGDrawingTestView.h
//  DrawLineTest1
//
//  Created by John Gallagher on 04/01/2012.
//  Copyright 2012 Synaptic Mishap. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PieChartLayer;

@interface JGDrawingTestView : UIView {
    PieChartLayer *pieChartLayer;
	BOOL			animating;
	BOOL			killing;
    
    NSUInteger      animationDuration;
}

@property (nonatomic) NSUInteger animationDuration;

-(void)animateCountdownOverDuration:(NSUInteger)duration_;
-(void)animateCountdown;





@end

