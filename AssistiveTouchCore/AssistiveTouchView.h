///////////////////////////////////////////////////////////////
// AssistiveTouchView.h
// author:sundayliu
// date: 2016.07.31
///////////////////////////////////////////////////////////////

#ifndef __ASSISTIVE_TOUCH_VIEW_H__
#define __ASSISTIVE_TOUCH_VIEW_H__

#import <UIKit/UIKit.h>

@interface AssistiveTouchView : UIControl

@end

@interface AssistiveTouchBackgroundView : UIView

@end

@interface AssistiveTouchIconView : AssistiveTouchView

@end

enum ContentSubViewTag{
    BUTTON_TAG_1 = 1,
    BUTTON_TAG_2 = 2,
    BUTTON_TAG_CANCEL = 1000
};

@interface AssistiveTouchContentView : AssistiveTouchView

@property (nonatomic) UIButton* buttonDump1;
@property (nonatomic) UIButton* buttonDump2;
@property (nonatomic) UIButton* buttonCancel;

@end

#endif