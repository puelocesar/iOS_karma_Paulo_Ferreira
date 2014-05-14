//
//  KCChooseNickController.h
//  Karma Counter
//
//  Created by Paulo Cesar Ferreira on 13/05/14.
//
//

#import <UIKit/UIKit.h>

@class KCChooseNickController;

@protocol KCChooseNickControllerDelegate <NSObject>
- (void)didSaveNick:(KCChooseNickController *)controller;
@end

@interface KCChooseNickController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) id <KCChooseNickControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *nick_field;

@end
