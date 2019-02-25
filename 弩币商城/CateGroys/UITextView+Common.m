//
//  UITextView+Common.m
//  test
//
//  Created by Jack on 17/1/12.
//  Copyright © 2017年 毕研超. All rights reserved.
//

#import "UITextView+Common.h"
#import <objc/runtime.h>
@implementation UITextView (Common)

static NSString *PLACEHOLDLABEL = @"placelabel";
static NSString *PLACEHOLD = @"placehold";
static NSString *WORDCOUNTLABEL = @"wordcount";
static const void *limitLengthKey = &limitLengthKey;

-(void)setPlaceholderLabel:(UILabel *)placeholderLabel {
    
    objc_setAssociatedObject(self, &PLACEHOLDLABEL, placeholderLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)placeholderLabel {
    
    return objc_getAssociatedObject(self, &PLACEHOLDLABEL);
    
}

- (void)setPlaceholder:(NSString *)placeholder {
    
    objc_setAssociatedObject(self, &PLACEHOLD, placeholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setPlaceHolderLabel:placeholder];
}

- (NSString *)placeholder {
    
    return objc_getAssociatedObject(self, &PLACEHOLD);
}


- (UILabel *)wordCountLabel {
    
    return objc_getAssociatedObject(self, &WORDCOUNTLABEL);
    
}
- (void)setWordCountLabel:(UILabel *)wordCountLabel {
    
    objc_setAssociatedObject(self, &WORDCOUNTLABEL, wordCountLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}


- (NSNumber *)limitLength {
    
    return objc_getAssociatedObject(self, limitLengthKey);
}

- (void)setLimitLength:(NSNumber *)limitLength {
    objc_setAssociatedObject(self, limitLengthKey, limitLength, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addLimitLengthObserver:[limitLength intValue]];
    
    [self setWordcountLable:limitLength];
    
}

#pragma mark -- 配置占位符标签

- (void)setPlaceHolderLabel:(NSString *)placeholder {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextViewTextDidChangeNotification object:self];
    /*
     *  占位字符
     */
    self.placeholderLabel = [[UILabel alloc] init];
//    self.placeholderLabel.font =  [UIFont fontWithName:font_pingfangR size:14];
    self.placeholderLabel.text = placeholder;
    self.placeholderLabel.numberOfLines = 0;
    self.placeholderLabel.font = TextFont(15);
    self.placeholderLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.placeholderLabel.textColor = LineColor;
    CGRect rect = [placeholder boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame)-7, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13.]} context:nil];
    self.placeholderLabel.frame = CGRectMake(5,6, rect.size.width , rect.size.height);
    [self addSubview:self.placeholderLabel];
    [self.placeholderLabel sizeToFit];
    
}

#pragma mark -- 配置字数限制标签

- (void)setWordcountLable:(NSNumber *)limitLength {
    
    /*
     *  字数限制
     */
    self.wordCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 75, CGRectGetHeight(self.frame) - 37, 60, 20)];
    self.wordCountLabel.textAlignment = NSTextAlignmentRight;
    self.wordCountLabel.textColor = LineColor;
    self.wordCountLabel.font = [UIFont systemFontOfSize:14];
    self.wordCountLabel.text = [NSString stringWithFormat:@"0/%@",limitLength];
    [self addSubview:self.wordCountLabel];
}


#pragma mark -- 增加限制位数的通知
- (void)addLimitLengthObserver:(int)length {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(limitLengthEvent) name:UITextViewTextDidChangeNotification object:self];
}

#pragma mark -- 限制输入的位数
- (void)limitLengthEvent {
    
    if ([self.text length] > [self.limitLength intValue]) {
        
        self.text = [self.text substringToIndex:[self.limitLength intValue]];
    }
}


#pragma mark -- NSNotification

- (void)textFieldChanged:(NSNotification *)notification {
    if (self.placeholder) {
        self.placeholderLabel.hidden = YES;
        
        if (self.text.length == 0) {
            
            self.placeholderLabel.hidden = NO;
        }
    }
    if (self.limitLength) {
        
        NSInteger wordCount = self.text.length;
        if (wordCount > [self.limitLength integerValue]) {
            wordCount = [self.limitLength integerValue];
        }
        self.wordCountLabel.text = [NSString stringWithFormat:@"%ld/%@",wordCount,self.limitLength];
        
    }
    
}


- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (!newSuperview) {
      
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UITextViewTextDidChangeNotification
                                                      object:self];
        
    }
    
}



@end
