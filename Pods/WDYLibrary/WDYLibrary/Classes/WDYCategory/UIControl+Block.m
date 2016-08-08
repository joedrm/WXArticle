//
//  UIControl+Block.m
//  FXCategories
//
//  Created by fox softer on 15/2/23.
//  Copyright (c) 2015年 foxsofter. All rights reserved.
//

#import "UIControl+Block.h"
#import "NSObject+AssociatedObject.h"

// UIControlEventTouchDown           = 1 <<  0,      // on all touch downs
// UIControlEventTouchDownRepeat     = 1 <<  1,      // on multiple touchdowns
// (tap count > 1)
// UIControlEventTouchDragInside     = 1 <<  2,
// UIControlEventTouchDragOutside    = 1 <<  3,
// UIControlEventTouchDragEnter      = 1 <<  4,
// UIControlEventTouchDragExit       = 1 <<  5,
// UIControlEventTouchUpInside       = 1 <<  6,
// UIControlEventTouchUpOutside      = 1 <<  7,
// UIControlEventTouchCancel         = 1 <<  8,
//
// UIControlEventValueChanged        = 1 << 12,     // sliders, etc.
//
// UIControlEventEditingDidBegin     = 1 << 16,     // UITextField
// UIControlEventEditingChanged      = 1 << 17,
// UIControlEventEditingDidEnd       = 1 << 18,
// UIControlEventEditingDidEndOnExit = 1 << 19,     // 'return key' ending
// editing
//
// UIControlEventAllTouchEvents      = 0x00000FFF,  // for touch events
// UIControlEventAllEditingEvents    = 0x000F0000,  // for UITextField
// UIControlEventApplicationReserved = 0x0F000000,  // range available for
// application use
// UIControlEventSystemReserved      = 0xF0000000,  // range reserved for
// internal framework use
// UIControlEventAllEvents           = 0xFFFFFFFF

//- (void)touchDown:(void (^)(void))eventBlock {
//  [self setAssignObject:eventBlock withKey:@selector(touchDown:)];
//  [self addTarget:self action:@selector(touchDownAction:)
//  forControlEvents:UIControlEventTouchUpInside];
//}
//- (void)touchDownAction:(id)sender {
//  void (^block)() = [self assignObject:@selector(touchDown:)];
//  if (block) {
//    block();
//  }
//}

#define UICONTROLEVENT(methodName, eventName)                                \
  -(void)methodName : (void (^)(void))eventBlock {                           \
    [self setCopyNonatomicObject:eventBlock withKey:@selector(methodName:)]; \
    [self addTarget:self                                                     \
                  action:@selector(methodName##Action:)                      \
        forControlEvents:UIControlEvent##eventName];                         \
  }                                                                          \
  -(void)methodName##Action : (id)sender {                                   \
    void (^block)() = [self object:@selector(methodName:)];                  \
    if (block) {                                                             \
      block();                                                               \
    }                                                                        \
  }

@interface UIControl ()

@end

@implementation UIControl (Block)

UICONTROLEVENT(touchDown, TouchDown)
UICONTROLEVENT(touchDownRepeat, TouchDownRepeat)
UICONTROLEVENT(touchDragInside, TouchDragInside)
UICONTROLEVENT(touchDragOutside, TouchDragOutside)
UICONTROLEVENT(touchDragEnter, TouchDragEnter)
UICONTROLEVENT(touchDragExit, TouchDragExit)
UICONTROLEVENT(touchUpInside, TouchUpInside)
UICONTROLEVENT(touchUpOutside, TouchUpOutside)
UICONTROLEVENT(touchCancel, TouchCancel)
UICONTROLEVENT(valueChanged, ValueChanged)
UICONTROLEVENT(editingDidBegin, EditingDidBegin)
UICONTROLEVENT(editingChanged, EditingChanged)
UICONTROLEVENT(editingDidEnd, EditingDidEnd)
UICONTROLEVENT(editingDidEndOnExit, EditingDidEndOnExit)

//- (void)touchUpInside:(void (^)(void))eventBlock {
//  [self setAssignObject:eventBlock withKey:@selector(touchUpInside:)];
//  [self addTarget:self action:@selector(touchUpInsideAction:)
//  forControlEvents:UIControlEventTouchUpInside];
//}
//- (void)touchUpInsideAction:(id)sender {
//  void (^block)() = [self assignObject:@selector(touchUpInside:)];
//  if (block) {
//    block();
//  }
//}

@end
