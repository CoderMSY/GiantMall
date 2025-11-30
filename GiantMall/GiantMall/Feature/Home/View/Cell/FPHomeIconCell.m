//
//  FPHomeIconCell.m
//  GiantMall
//
//  Created by Simon Miao on 2025/11/30.
//

#import "FPHomeIconCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import "FPColorConfig.h"
#import "FPTheme.h"

@interface FPHomeIconCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
//@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation FPHomeIconCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [FPColorConfig cardBackgroundColor];
//        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        [self.contentView addSubview:self.iconImageView];
//        [self.contentView addSubview:self.titleLabel];
        [self initConstraints];
    }
    return self;
}

- (void)setItemModel:(FPThemeIndex_iconenter *)itemModel {
    _itemModel = itemModel;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:itemModel.img]];
//    self.titleLabel.text = itemModel.
}

- (void)initConstraints {
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
//        make.top.mas_equalTo(self.contentView).offset(10);
//        make.centerX.mas_equalTo(self.contentView);
    }];
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.iconImageView.mas_bottom).offset(5);
//        make.left.right.mas_equalTo(self.contentView);
//        make.bottom.mas_lessThanOrEqualTo(self.contentView).offset(-5);
//    }];
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImageView;
}

//- (UILabel *)titleLabel {
//    if (!_titleLabel) {
//        _titleLabel = [[UILabel alloc] init];
//        _titleLabel.font = [UIFont systemFontOfSize:15];
//        _titleLabel.textColor = [FPColorConfig textPrimaryColor];
//        _titleLabel.textAlignment = NSTextAlignmentCenter;
//    }
//    return _titleLabel;
//}

@end
