@class JGAlert;
@class JGPieChartAnimationParameters;

@interface JGPieChartAnimationParameterCalculator : NSObject {

}

-(JGPieChartAnimationParameterCalculator *)initWithAlert:(JGAlert *)alert1;

-(JGPieChartAnimationParameters *)calculateParameters;
@end
