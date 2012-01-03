#import <Foundation/Foundation.h>

@interface JGStringConverter : NSObject {
    NSString *stringToConvert;
}

@property (nonatomic, retain) NSString *stringToConvert;

+(JGStringConverter *)converterWithString:(NSString *)string_;

-(NSInteger)convertToInteger;

@end

