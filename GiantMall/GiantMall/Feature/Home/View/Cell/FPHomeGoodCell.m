//
//  FPHomeGoodCell.m
//  GiantMall
//
//  Created by Simon Miao on 2025/11/30.
//

#import "FPHomeGoodCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import "FPColorConfig.h"
#import "UIColor+FPAdd.h"
#import "FPGood.h"

@interface FPHomeGoodCell ()

@property (nonatomic, strong) UIImageView *iconImagView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *saleLabel;

@end

@implementation FPHomeGoodCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [FPColorConfig cardBackgroundColor];
//        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.iconImagView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.typeLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.saleLabel];
    
    [self.iconImagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(self.iconImagView.mas_width).multipliedBy(1);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImagView.mas_bottom).offset(15);
        make.left.right.mas_equalTo(self.contentView).inset(10);
    }];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
        make.left.right.mas_equalTo(self.contentView).inset(10);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.typeLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(self.contentView).inset(10);
        make.bottom.mas_lessThanOrEqualTo(self.contentView);
    }];
    [self.saleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.priceLabel);
        make.left.mas_greaterThanOrEqualTo(self.priceLabel.mas_right).offset(5);
        make.right.mas_equalTo(self.contentView).offset(-10);
    }];
}

- (void)setItemModel:(FPGood *)itemModel {
    _itemModel = itemModel;
    
    [self.iconImagView sd_setImageWithURL:[NSURL URLWithString:itemModel.img]];
    self.nameLabel.text = itemModel.name;
    self.typeLabel.text = itemModel.subtitle;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@", itemModel.price_min];
    self.saleLabel.text = [NSString stringWithFormat:@"已售%ld", itemModel.total_sales];
}

- (UIImageView *)iconImagView {
    if (!_iconImagView) {
        _iconImagView = [[UIImageView alloc] init];
        _iconImagView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImagView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont boldSystemFontOfSize:14];
        _nameLabel.textColor = [FPColorConfig textPrimaryColor];
        _nameLabel.numberOfLines = 2;
    }
    return _nameLabel;
}

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.font = [UIFont systemFontOfSize:12];
        _typeLabel.textColor = [FPColorConfig textSecondaryColor];
        _typeLabel.numberOfLines = 1;
    }
    return _typeLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont boldSystemFontOfSize:16];
        _priceLabel.textColor = [UIColor fp_colorWithHex:0xf4330d];
    }
    return _priceLabel;
}

- (UILabel *)saleLabel {
    if (!_saleLabel) {
        _saleLabel = [[UILabel alloc] init];
        _saleLabel.font = [UIFont systemFontOfSize:12];
        _saleLabel.textColor = [FPColorConfig textSecondaryColor];
    }
    return _saleLabel;
}

@end
