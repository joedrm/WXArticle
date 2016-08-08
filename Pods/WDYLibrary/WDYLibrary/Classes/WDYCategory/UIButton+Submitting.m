//
//  UIButton+Submitting.m
//  FXCategories
//
//  Created by foxsofter on 15/4/2.
//  Copyright (c) 2015年 foxsofter. All rights reserved.
//

#import "UIButton+Submitting.h"
#import "NSObject+AssociatedObject.h"

@interface UIButton ()

@property(nonatomic, strong) UIView *modalView;
@property(nonatomic, strong) UIActivityIndicatorView *spinnerView;
@property(nonatomic, strong) UILabel *spinnerTitleLabel;

@end

@implementation UIButton (Submitting)

- (void)beginSubmitting:(NSString *)title {
  [self endSubmitting];

  self.submitting = @YES;
  self.hidden = YES;

  self.modalView = [[UIView alloc] initWithFrame:self.frame];
  self.modalView.backgroundColor =
      [self.backgroundColor colorWithAlphaComponent:0.6];
  self.modalView.layer.cornerRadius = self.layer.cornerRadius;
  self.modalView.layer.borderWidth = self.layer.borderWidth;
  self.modalView.layer.borderColor = self.layer.borderColor;

  CGRect viewBounds = self.modalView.bounds;
  self.spinnerView = [[UIActivityIndicatorView alloc]
      initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
  self.spinnerView.tintColor = self.titleLabel.textColor;

  CGRect spinnerViewBounds = self.spinnerView.bounds;
  self.spinnerView.frame = CGRectMake(
      15, viewBounds.size.height / 2 - spinnerViewBounds.size.height / 2,
      spinnerViewBounds.size.width, spinnerViewBounds.size.height);
  self.spinnerTitleLabel = [[UILabel alloc] initWithFrame:viewBounds];
  self.spinnerTitleLabel.textAlignment = NSTextAlignmentCenter;
  self.spinnerTitleLabel.text = title;
  self.spinnerTitleLabel.font = self.titleLabel.font;
  self.spinnerTitleLabel.textColor = self.titleLabel.textColor;
  [self.modalView addSubview:self.spinnerView];
  [self.modalView addSubview:self.spinnerTitleLabel];
  [self.superview addSubview:self.modalView];
  [self.spinnerView startAnimating];
}

- (void)endSubmitting {
  if (!self.isSubmitting.boolValue) {
    return;
  }

  self.submitting = @NO;
  self.hidden = NO;

  [self.modalView removeFromSuperview];
  self.modalView = nil;
  self.spinnerView = nil;
  self.spinnerTitleLabel = nil;
}

- (NSNumber *)isSubmitting {
  return [self object:@selector(setSubmitting:)];
}

- (void)setSubmitting:(NSNumber *)submitting {
  [self setRetainNonatomicObject:submitting withKey:@selector(setSubmitting:)];
}

- (UIActivityIndicatorView *)spinnerView {
  return [self object:@selector(setSpinnerView:)];
}

- (void)setSpinnerView:(UIActivityIndicatorView *)spinnerView {
  [self setRetainNonatomicObject:spinnerView
                         withKey:@selector(setSpinnerView:)];
}

- (UIView *)modalView {
  return [self object:@selector(setModalView:)];
}

- (void)setModalView:(UIView *)modalView {
  [self setRetainNonatomicObject:modalView withKey:@selector(setModalView:)];
}

- (UILabel *)spinnerTitleLabel {
  return [self object:@selector(setSpinnerTitleLabel:)];
}

- (void)setSpinnerTitleLabel:(UILabel *)spinnerTitleLabel {
  [self setRetainNonatomicObject:spinnerTitleLabel
                         withKey:@selector(setSpinnerTitleLabel:)];
}

@end
