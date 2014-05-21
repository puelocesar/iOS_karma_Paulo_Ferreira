//
//  KCAvatarView.m
//  Karma Counter
//
//  Created by Paulo Cesar Ferreira on 14/05/14.
//
//

#import "KCAvatarView.h"

@implementation KCAvatarView

UILabel* label;

- (void)baseInit
{
    UIImageView* avatar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar01.png"]];
    avatar.frame = CGRectMake(0, 0, 50, 40);
    avatar.contentMode = UIViewContentModeScaleAspectFit;
    
    [self addSubview:avatar];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 50, 20)];
    label.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:label];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) [self baseInit];
    return self;
}

- (void)setData:(KCAvatarData *)data
{
    _data = data;
    label.text = data.name;
}

@end
