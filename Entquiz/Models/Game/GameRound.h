#import <Foundation/Foundation.h>
#import "ModelObject.h"

@class GameRoundUser;
@class OpAnswer;

@interface GameRound : ModelObject {

    NSArray *data;
    NSNumber *roundId;
    NSNumber *gameId;
    NSNumber *scoreOne;
    NSNumber *scoreTwo;
    GameRoundUser *user;
    GameRoundUser *opponent;
    NSArray *opAnswers;

}

@property (nonatomic, copy) NSArray *data;
@property (nonatomic, strong) NSNumber *roundId;
@property (nonatomic, copy) NSNumber *gameId;
@property (nonatomic, copy) NSNumber *scoreOne;
@property (nonatomic, copy) NSNumber *scoreTwo;
@property (nonatomic, strong) GameRoundUser *user;
@property (nonatomic, strong) GameRoundUser *opponent;
@property (nonatomic, strong) NSArray *opAnswers;

+ (GameRound *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
