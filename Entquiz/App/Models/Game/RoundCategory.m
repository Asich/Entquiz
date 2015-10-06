#import "RoundCategory.h"

@implementation RoundCategory

@synthesize roundCategoryId;
@synthesize name;

+ (RoundCategory *)instanceFromDictionary:(NSDictionary *)aDictionary {

    RoundCategory *instance = [[RoundCategory alloc] init];
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
        [self setValue:value forKey:@"roundCategoryId"];
    } else {
        [super setValue:value forUndefinedKey:key];
    }

}



@end
