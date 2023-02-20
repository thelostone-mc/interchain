pragma solidity ^0.8.17;
// SPDX-License-Identifier: UNLICENSED

import "hardhat/console.sol";
import { AxelarExecutable } from '@axelar-network/axelar-gmp-sdk-solidity/contracts/executable/AxelarExecutable.sol';
import { IAxelarGateway } from '@axelar-network/axelar-gmp-sdk-solidity/contracts/interfaces/IAxelarGateway.sol';
import { IAxelarGasService } from '@axelar-network/axelar-gmp-sdk-solidity/contracts/interfaces/IAxelarGasService.sol';

contract ChainARegistry is AxelarExecutable {

  /// Axelar
  IAxelarGasService public immutable gasReceiver;
  
  uint256 public lastInvokedIndex;
  address public lastInvokedWallet;
  

  /// Data
  mapping(uint256 => address) public projectIdsToOwner;
  string public test;

  constructor(address gateway_, address gasReceiver_) AxelarExecutable(gateway_) {
    // Axelar
    gasReceiver = IAxelarGasService(gasReceiver_);
    
    // auto populate the mapping with some data
    projectIdsToOwner[0] = msg.sender;
    projectIdsToOwner[1] = 0xB8cEF765721A6da910f14Be93e7684e9a3714123;
  }

  // Axelar

  // how do we know which gateway.callContract this is responding to?
  function _execute(
    string calldata sourceChain_,
    string calldata sourceAddress_,
    bytes calldata payload_
  ) internal override {
    console.log("CONTRACT: ChainARegistry || METHOD : _execute");
    console.log("sourceChain_: %s", sourceChain_);
    console.log("sourceAddress_: %s", sourceAddress_);

    // update last variables
    (
      lastInvokedIndex,
      lastInvokedWallet
    ) = abi.decode(payload_, (uint256, address));

    console.log("lastInvokedIndex: %s", lastInvokedIndex);
    console.log("lastInvokedWallet: %s", lastInvokedWallet);

    // Send Response to source chain and address

    bool isOwner = isProjectOwner(lastInvokedIndex, lastInvokedWallet);
    console.log("isOwner: %s", isOwner); // TODO: return this to ChainBRound
  }


  // Core Functions
  function isProjectOwner(uint256 _index, address _address) view public returns (bool) {
    return projectIdsToOwner[_index] == _address;
  }

  function setProjectOwner(uint256 _index, address _address) public {
    projectIdsToOwner[_index] = _address;
  }

}