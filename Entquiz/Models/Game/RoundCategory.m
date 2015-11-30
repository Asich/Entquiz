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

    objectData = aDictionary;

    self.roundCategoryId = [self numberValueForKey:@"id"];
    self.name = [self stringValueForKey:@"name"];

    objectData = nil;

}

@end
