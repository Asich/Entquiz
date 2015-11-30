#import "GameRound.h"

#import "GameRoundUser.h"
#import "RoundData.h"

@implementation GameRound

@synthesize gameId;
@synthesize scoreOne;
@synthesize scoreTwo;
@synthesize roundId;
@synthesize data;
@synthesize user;
@synthesize opponent;


+ (GameRound *)instanceFromDictionary:(NSDictionary *)aDictionary {

    GameRound *instance = [[GameRound alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    objectData = aDictionary;


    self.gameId = [self numberValueForKey:@"gameId"];
    self.scoreOne = [self numberValueForKey:@"scoreOne"];
    self.scoreTwo = [self numberValueForKey:@"scoreTwo"];
    self.roundId = [self numberValueForKey:@"roundId"];

    if ([objectData[@"data"] isKindOfClass:[NSArray class]]) {
        NSMutableArray *myMembers = [NSMutableArray arrayWithCapacity:[objectData[@"data"] count]];
        for (id valueMember in objectData[@"data"]) {
            RoundData *populatedMember = [RoundData instanceFromDictionary:valueMember];
            [myMembers addObject:populatedMember];
        }

        self.data = myMembers;
    }

    if ([objectData[@"user"] isKindOfClass:[NSDictionary class]]) {
        self.user = [GameRoundUser instanceFromDictionary:objectData[@"user"]];
    }

    if ([objectData[@"opponent"] isKindOfClass:[NSDictionary class]]) {
        self.opponent = [GameRoundUser instanceFromDictionary:objectData[@"opponent"]];
    }

    objectData = nil;

}

@end
