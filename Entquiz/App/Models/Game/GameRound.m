#import "GameRound.h"

#import "GameRoundUser.h"
#import "RoundData.h"

@implementation GameRound

@synthesize data;
@synthesize gameId;
@synthesize scoreOne;
@synthesize scoreTwo;
@synthesize user;
@synthesize opponent;
@synthesize roundId;

+ (GameRound *)instanceFromDictionary:(NSDictionary *)aDictionary {

    GameRound *instance = [[GameRound alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    [self setValuesForKeysWithDictionary:aDictionary];

}

- (void)setValue:(id)value forKey:(NSString *)key {

    if ([key isEqualToString:@"data"]) {

        if ([value isKindOfClass:[NSArray class]]) {

            NSMutableArray *myMembers = [NSMutableArray arrayWithCapacity:[value count]];
            for (id valueMember in value) {
                RoundData *populatedMember = [RoundData instanceFromDictionary:valueMember];
                [myMembers addObject:populatedMember];
            }

            self.data = myMembers;

        }

    } else if ([key isEqualToString:@"user"]) {

        if ([value isKindOfClass:[NSDictionary class]]) {
            self.user = [GameRoundUser instanceFromDictionary:value];
        }

    } else if ([key isEqualToString:@"opponent"]) {

        if ([value isKindOfClass:[NSDictionary class]]) {
            self.opponent = [GameRoundUser instanceFromDictionary:value];
        }

    } else {
        [super setValue:value forKey:key];
    }

}



@end
