#import <Foundation/Foundation.h>
#import "ModelObject.h"

@interface GameRoundUser : ModelObject {

    NSNumber *gameRoundUserId;
    NSString *password;
    NSNumber *rating;
    NSString *username;

}

@property (nonatomic, copy) NSNumber *gameRoundUserId;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSNumber *rating;
@property (nonatomic, copy) NSString *username;

+ (GameRoundUser *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
