//
//  KCBluetoothPeripheral.h
//  Karma Counter
//
//  Created by Paulo Cesar Ferreira on 14/05/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@protocol KCBluetoothPeripheralDelegate <NSObject>
- (void)didReceiveKarma;
@end

@interface KCBluetoothPeripheral : NSObject <CBPeripheralManagerDelegate>

#define UUID_SERVICE_STRING @"11C1226B-281D-4666-8798-A7F7A54972BF"

#define UUID_CHARAC_STRING @"F711ECAD-C397-426B-A28B-3B068AD7D10C"

@property (nonatomic, weak) id <KCBluetoothPeripheralDelegate> delegate;

@end
