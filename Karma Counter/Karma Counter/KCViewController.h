//
//  KCViewController.h
//  Karma Counter
//
//  Created by Paulo Cesar Ferreira on 13/05/14.
//
//

#import <UIKit/UIKit.h>
#import "KCChooseNickController.h"
#import "KCBluetoothManager.h"

@interface KCViewController : UIViewController <KCChooseNickControllerDelegate, KCBluetoothPeripheralDelegate>

@property (strong, nonatomic) NSString* nickname;
@property (nonatomic) int karma;

@property (weak, nonatomic) IBOutlet UILabel *nickname_label;
@property (weak, nonatomic) IBOutlet UILabel *karma_value;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;

- (IBAction)sendKarma:(id)sender;

@end
