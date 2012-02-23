//
//  Created by John on 23/02/2012.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface JGPieChartAnimation : NSObject {
    CGFloat        _startAngle;
    CGFloat        _endAngle;
    NSTimeInterval _duration;
}

@property(nonatomic, readonly) CGFloat startAngle;
@property(nonatomic, readonly) CGFloat endAngle;
@property(nonatomic, readonly) NSTimeInterval duration;


+(id)animationWithStartAngle:(CGFloat)startAngle_ endAngle:(CGFloat)endAngle_ duration:(NSTimeInterval)duration_;

-(id)initWithStartAngle:(CGFloat)startAngle_ endAngle:(CGFloat)endAngle_ duration:(NSTimeInterval)duration_;

@end