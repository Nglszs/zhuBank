//
//  UITextField+Common.m
//  Fast
//
//  Created by 詹姆斯 on 2017/8/28.
//  Copyright © 2017年 詹姆斯. All rights reserved.
//

#import "UITextField+Common.h"
#import <objc/runtime.h>
@implementation UITextField (Common)
static void *preSelectionKey = &preSelectionKey;
static void *preTextKey = &preTextKey;



- (void)setPreviousTextFieldContent:(NSString *)previousTextFieldContent {
    
    objc_setAssociatedObject(self, &preTextKey,previousTextFieldContent, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    
}

- (NSString *)previousTextFieldContent {
    
    return objc_getAssociatedObject(self, &preTextKey);
    
    
}


- (void)setPreviousSelection:(UITextRange *)previousSelection {
    
    objc_setAssociatedObject(self, &preSelectionKey,previousSelection, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}


- (UITextRange *)previousSelection {
    
    return objc_getAssociatedObject(self, &preSelectionKey);
    
    
}


- (void)textfieldWithPhoneNumber {
    
    [self addTarget:self action:@selector(reformatAsCardNumber:)
   forControlEvents:UIControlEventEditingChanged];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hehe:) name:UITextFieldTextDidChangeNotification object:self];
    
    
    
    
    
}


- (void)hehe:(NSNotification *)noti {
    
    
    
    
    UITextField *newTextfield = (UITextField *)noti.object;
    
    if ([newTextfield.text isEqualToString:[UIPasteboard generalPasteboard].string]) {//这里禁止粘贴
        
        
        [UIPasteboard generalPasteboard].string = @"";
        newTextfield.text = @"";
        return;
    }
    self.previousTextFieldContent = newTextfield.text;
    self.previousSelection = newTextfield.selectedTextRange;
    
    
}

- (void)reformatAsCardNumber:(UITextField *)textField
{
    
    
    
    
    NSUInteger targetCursorPosition =
    [textField offsetFromPosition:textField.beginningOfDocument
                       toPosition:textField.selectedTextRange.start];
    
    //删除非数字字符
    NSString *cardNumberWithoutSpaces =
    [self removeNonDigits:textField.text andPreserveCursorPosition:&targetCursorPosition];
    
    
    if ([cardNumberWithoutSpaces length] == 11) {

    if (![self isMobileNumber:cardNumberWithoutSpaces]){
        
        
        [self showErrorHUD:@"手机号码有误"];
    }
    }
    
    if ([cardNumberWithoutSpaces length] > 11) {
        
        
        
           
     
        [textField setText:self.previousTextFieldContent];
        textField.selectedTextRange = self.previousSelection;
        
        return;
    }
    
    NSString *cardNumberWithSpaces =[self insertSpacesEveryFourDigitsIntoString:cardNumberWithoutSpaces
                                                      andPreserveCursorPosition:&targetCursorPosition];
    
    textField.text = cardNumberWithSpaces;
    UITextPosition *targetPosition =
    [textField positionFromPosition:[textField beginningOfDocument]
                             offset:targetCursorPosition];
    
    [textField setSelectedTextRange:[textField textRangeFromPosition:targetPosition toPosition :targetPosition]
     ];
}

- (NSString *)removeNonDigits:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition
{
    NSUInteger originalCursorPosition = *cursorPosition;
    
    NSMutableString *digitsOnlyString = [NSMutableString new];
    
    for (NSUInteger i = 0; i < [string length]; i++) {
        unichar characterToAdd = [string characterAtIndex:i];
        
        if (isdigit(characterToAdd)) {
            NSString *stringToAdd =
            [NSString stringWithCharacters:&characterToAdd
                                    length:1];
            
            [digitsOnlyString appendString:stringToAdd];
        } else {
            if (i < originalCursorPosition) {
                (*cursorPosition)--;
            }
        }
    }
    
    return digitsOnlyString;
}

- (NSString *)insertSpacesEveryFourDigitsIntoString:(NSString *)string
                          andPreserveCursorPosition:(NSUInteger *)cursorPosition
{
    NSMutableString *stringWithAddedSpaces = [NSMutableString new];
    
    NSUInteger cursorPositionInSpacelessString = *cursorPosition;
    
    for (NSUInteger i = 0; i < [string length]; i++) {
        //if ((i > 0) && ((i % 4) == 0)) {//4位间隔
        if (i ==3 || i == 7) {
            
            [stringWithAddedSpaces appendString:@" "];
            
            if (i < cursorPositionInSpacelessString) {
                (*cursorPosition)++;
            }
        }
        
        unichar     characterToAdd = [string characterAtIndex:i];
        NSString    *stringToAdd =
        [NSString stringWithCharacters:&characterToAdd length:1];
        
        [stringWithAddedSpaces appendString:stringToAdd];
    }
    
    return stringWithAddedSpaces;
}




- (void)changePlaceholderColor:(UIColor *)color {
    
    
    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    
}


- (void)changePlaceholderFont:(UIFont *)font {
    
    
    [self setValue:font forKeyPath:@"_placeholderLabel.font"];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (!newSuperview) {
        
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UITextFieldTextDidChangeNotification
                                                      object:self];
        
    }
    
}

- (BOOL)onlyInputNumber:(NSString *)string {

    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:kNumbers] invertedSet];
            NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    

    return  [string isEqualToString:filtered];
    


}


- (BOOL)onlyInputNumberAndAlpha:(NSString *)string {

    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
    NSString *filtered =
    [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return  [string isEqualToString:filtered];
}
@end
