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

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        self.roundCategoryId = [coder decodeObjectForKey:@"roundCategoryId"];
        self.name = [coder decodeObjectForKey:@"name"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:roundCategoryId forKey:@"roundCategoryId"];
    [coder encodeObject:name forKey:@"name"];
}

@end
