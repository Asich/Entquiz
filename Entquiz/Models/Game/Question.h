#import <Foundation/Foundation.h>
#import "ModelObject.h"

@class QuestionQues;
@class Answer;

@interface Question : ModelObject<NSCoding> {

    NSArray *answers;
    QuestionQues *ques;

}

@property (nonatomic, copy) NSArray *answers;
@property (nonatomic, strong) QuestionQues *ques;

- (instancetype)initWithCoder:(NSCoder *)coder;

- (void)encodeWithCoder:(NSCoder *)coder;

+ (Question *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (Answer *)getAnswerById:(NSNumber *)answerId;



@end
