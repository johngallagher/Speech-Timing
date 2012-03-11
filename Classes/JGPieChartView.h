//
//  PacmanLayer.h
//  Pacman
//
//  Created by Romain Vincens on 08/03/2011.
//  Copyright 2011 Nomad Planet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@class JGPieChartAnimationParameters;


@interface JGPieChartView : CALayer {
    CGFloat startAngle;
    CGFloat endAngle;
}

@property(nonatomic, assign) CGFloat startAngle;
@property(nonatomic, assign) CGFloat endAngle;

-(id)initWithFrame:(CGRect)frame_;

@end
