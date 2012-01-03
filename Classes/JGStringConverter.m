#import "JGStringConverter.h"

@implementation JGStringConverter

@synthesize stringToConvert;

+(JGStringConverter *)converterWithString:(NSString *)string_ {
    return [[JGStringConverter alloc] initWithString:string_];
}

-(JGStringConverter *)initWithString:(NSString *)string_ {
    self = [super init];
    if (self) {
        stringToConvert = [string_ retain];
    }
    return self;
}

-(NSInteger)convertToInteger {
    return 0;
}

-(void)dealloc {
    [stringToConvert release];
    [super dealloc];
}

@end

