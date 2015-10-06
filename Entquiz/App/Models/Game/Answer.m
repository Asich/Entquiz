#import "Answer.h"

@implementation Answer

@synthesize answerId;
@synthesize img;
@synthesize isTrue;
@synthesize quesId;
@synthesize title;

+ (Answer *)instanceFromDictionary:(NSDictionary *)aDictionary {

    Answer *instance = [[Answer alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    [self setValuesForKeysWithDictionary:aDictionary];

}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"answerId"];
    } else {
        [super setValue:value forUndefinedKey:key];
    }

}



@end
