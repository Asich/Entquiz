#import "GameRoundUser.h"

@implementation GameRoundUser

@synthesize gameRoundUserId;
@synthesize password;
@synthesize rating;
@synthesize username;

+ (GameRoundUser *)instanceFromDictionary:(NSDictionary *)aDictionary {

    GameRoundUser *instance = [[GameRoundUser alloc] init];
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
        [self setValue:value forKey:@"gameRoundUserId"];
    } else {
        [super setValue:value forUndefinedKey:key];
    }

}



@end
