#import "JGStringToNumberConverterTestCase.h"
#import "JGStringConverter.h"

@implementation JGStringToNumberConverterTestCase

-(void)testEmptyStringShouldReturnZero {
    STAssertEquals([[JGStringConverter converterWithString:@""] convertToInteger], (NSInteger)0, nil);
}

@end
