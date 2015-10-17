#import <Foundation/Foundation.h>

@class QuestionQues;

@interface Question : NSObject {

    NSArray *answers;
    QuestionQues *ques;
    NSNumber *opponentAnsweredId;

}

@property (nonatomic, copy) NSArray *answers;
@property (nonatomic, strong) QuestionQues *ques;
@property (nonatomic, copy) NSNumber *opponentAnsweredId;

+ (Question *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
