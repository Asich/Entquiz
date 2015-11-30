#import <Foundation/Foundation.h>
#import "ModelObject.h"

@interface Answer : ModelObject<NSCoding> {

    NSNumber *answerId;
    NSString *img;
    BOOL isTrue;
    NSNumber *quesId;
    NSString *title;

}

@property (nonatomic, copy) NSNumber *answerId;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, assign) BOOL isTrue;
@property (nonatomic, copy) NSNumber *quesId;
@property (nonatomic, copy) NSString *title;

+ (Answer *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (void)encodeWithCoder:(NSCoder *)coder;
- (instancetype)initWithCoder:(NSCoder *)coder;

@end
