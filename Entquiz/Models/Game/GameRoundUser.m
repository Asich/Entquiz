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

    objectData = aDictionary;

    self.gameRoundUserId = [self numberValueForKey:@"id"];
    self.password = [self stringValueForKey:@"password"];
    self.rating = [self numberValueForKey:@"rating"];
    self.username = [self stringValueForKey:@"username"];

    objectData = nil;

}


@end
