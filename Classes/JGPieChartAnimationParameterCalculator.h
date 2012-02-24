#import <Foundation/Foundation.h>

@class JGAlert;
@class JGPieChartAnimationParameters;

@interface JGPieChartAnimationParameterCalculator : NSObject {
    JGAlert *_alert;
}

-(JGPieChartAnimationParameterCalculator *)initWithAlert:(JGAlert *)alert1;

-(JGPieChartAnimationParameters *)calculateParameters;
@end
