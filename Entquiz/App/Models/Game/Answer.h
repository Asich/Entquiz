#import <Foundation/Foundation.h>

@interface Answer : NSObject {

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

@end