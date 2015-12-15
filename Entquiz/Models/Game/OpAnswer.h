#import <Foundation/Foundation.h>
#import "ModelObject.h"

@interface OpAnswer : ModelObject {

    NSNumber *a1Id;
    NSNumber *a2Id;
    NSNumber *a3Id;
    NSNumber *catId;
    NSNumber *q1Id;
    NSNumber *q2Id;
    NSNumber *q3Id;
    NSNumber *roundId;

}

@property (nonatomic, copy) NSNumber *a1Id;
@property (nonatomic, copy) NSNumber *a2Id;
@property (nonatomic, copy) NSNumber *a3Id;
@property (nonatomic, copy) NSNumber *catId;
@property (nonatomic, copy) NSNumber *q1Id;
@property (nonatomic, copy) NSNumber *q2Id;
@property (nonatomic, copy) NSNumber *q3Id;
@property (nonatomic, copy) NSNumber *roundId;

+ (OpAnswer *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
