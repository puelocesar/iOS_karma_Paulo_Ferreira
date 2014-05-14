//
//  KCBluetoothPeripheral.m
//  Karma Counter
//
//  Created by Paulo Cesar Ferreira on 14/05/14.
//
//

#import "KCBluetoothPeripheral.h"

@implementation KCBluetoothPeripheral

CBPeripheralManager *peripheralManager;
CBUUID* karma_service_id;
CBMutableCharacteristic *myCharacteristic;

-(id)init
{
    karma_service_id = [CBUUID UUIDWithString:UUID_SERVICE_STRING];
    peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
    
    return self;
}

bool already_added_service = false;

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    if (!already_added_service) {
        CBUUID *characteristicUUID = [CBUUID UUIDWithString:UUID_CHARAC_STRING];
        
        //defining the characteristic for publishing the karma
        myCharacteristic =
        [[CBMutableCharacteristic alloc] initWithType:characteristicUUID
                                           properties:CBCharacteristicPropertyWrite
                                                value:nil permissions:CBAttributePermissionsReadable|CBAttributePermissionsWriteable];
        
        //creating the service
        CBMutableService *myService = [[CBMutableService alloc] initWithType:karma_service_id primary:YES];
        myService.characteristics = @[myCharacteristic];
        
        //publishing the service
        [peripheral addService:myService];
        
        already_added_service = true;
    }
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral
            didAddService:(CBService *)service
                    error:(NSError *)error {
    
    [peripheral startAdvertising:@{CBAdvertisementDataServiceUUIDsKey: @[karma_service_id]}];
    
    if (error) {
        NSLog(@"Error publishing service: %@", [error localizedDescription]);
    }
}

- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral
                                       error:(NSError *)error {
    
    NSLog(@"is advertising");
    
    if (error) {
        NSLog(@"Error advertising: %@", [error localizedDescription]);
    }
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray *)requests {
    
    for (CBATTRequest *request in requests) {
        if ([request.characteristic.UUID isEqual:myCharacteristic.UUID]) {
            [peripheral respondToRequest:request withResult:CBATTErrorSuccess];
            [self.delegate didReceiveKarma];
        }
    }
}

@end
