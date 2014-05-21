//
// Created by Paulo Cesar Ferreira on 21/05/14.
//

#import "KCCircularView.h"


@implementation KCCircularView

- (void)addAvatar:(KCAvatarData *)avatar
{
    KCAvatarView* avatar_view = [[KCAvatarView alloc] initWithFrame:CGRectMake(135, 0, 50, 60)];
    avatar_view.data = avatar;
    [self addSubview:avatar_view];

    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendKarma:)];
    [avatar_view addGestureRecognizer:tap];

    [UIView animateWithDuration:0.25 animations:^{
        [self rearrangeViews];
    }];
}

//future version should show a button to confirm sending the karma
- (void)sendKarma:(UITapGestureRecognizer*)recognizer
{
    KCAvatarView* view = (KCAvatarView*) recognizer.view;
    [self.delegate karmaSentTo:view.data];
}

//rearrange the avatars in a circular way around the user icon
- (void)rearrangeViews
{
    float start_x = self.frame.size.width/2;
    float start_y = (self.frame.size.height/2) - 10;

    double interval = (2* M_PI)/self.subviews.count;

    double i=0;
    for (KCAvatarView *view in self.subviews) {
        view.center = CGPointMake((float) (start_x + sin(i)*120), (float) (start_y + cos(i)*110));
        i += interval;
    }
}

@end