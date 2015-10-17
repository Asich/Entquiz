#import <Foundation/Foundation.h>

@class GameRoundUser;

@interface GameRound : NSObject {

    NSArray *data;
    NSNumber *roundId;
    NSNumber *gameId;
    NSNumber *scoreOne;
    NSNumber *scoreTwo;
    GameRoundUser *user;
    GameRoundUser *opponent;

}

@property (nonatomic, copy) NSArray *data;
@property (nonatomic, strong) NSNumber *roundId;
@property (nonatomic, copy) NSNumber *gameId;
@property (nonatomic, copy) NSNumber *scoreOne;
@property (nonatomic, copy) NSNumber *scoreTwo;
@property (nonatomic, strong) GameRoundUser *user;
@property (nonatomic, strong) GameRoundUser *opponent;

+ (GameRound *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
