//
// Created by Paulo Cesar Ferreira on 21/05/14.
//

#import <Foundation/Foundation.h>
#import "KCAvatarView.h"

@protocol KCCircularViewProtocol

- (void) karmaSentTo:(KCAvatarData *)avatar;

@end

@interface KCCircularView : UIView

@property (weak, nonatomic) id <KCCircularViewProtocol> delegate;

- (void) addAvatar: (KCAvatarData *) avatar;
- (void)rearrangeViews;

@end