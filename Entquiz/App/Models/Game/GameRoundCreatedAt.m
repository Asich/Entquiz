#import "GameRoundCreatedAt.h"

@implementation GameRoundCreatedAt

@synthesize timestamp;

+ (GameRoundCreatedAt *)instanceFromDictionary:(NSDictionary *)aDictionary {

    GameRoundCreatedAt *instance = [[GameRoundCreatedAt alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    [self setValuesForKeysWithDictionary:aDictionary];

}


@end
