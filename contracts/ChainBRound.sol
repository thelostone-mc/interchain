pragma solidity ^0.8.17;
// SPDX-License-Identifier: UNLICENSED
// import "hardhat/console.sol";
import { AxelarExecutable } from '@axelar-network/axelar-gmp-sdk-solidity/contracts/executable/AxelarExecutable.sol';
import { IAxelarGateway } from '@axelar-network/axelar-gmp-sdk-solidity/contracts/interfaces/IAxelarGateway.sol';
import { IAxelarGasService } from '@axelar-network/axelar-gmp-sdk-solidity/contracts/interfaces/IAxelarGasService.sol';


contract ChainBRound is AxelarExecutable {

  /// Axelar
  IAxelarGasService public immutable gasReceiver;
  string public registryChain;
  string public registryAddress;

  mapping(uint256 => bool) public projectsAppliedStatus;

  constructor(address gateway_, address gasReceiver_) AxelarExecutable(gateway_) {
    gasReceiver = IAxelarGasService(gasReceiver_);
  }

  function testInterChain(uint _index, address _wallet) external payable {

    // construct payload 
    bytes memory payload = abi.encode(_index, _wallet);

     if (msg.value > 0) {
      // gas fees 
      gasReceiver.payNativeGasForContractCall{ value: msg.value }(
        address(this),
        registryChain,
        registryAddress,
        payload,
        msg.sender
      );
    }

    gateway.callContract(registryChain, registryAddress, payload);

  }

  function isProjectApplied(uint256 index) public view returns (bool) {
    return projectsAppliedStatus[index];
  }

  // set registry address + chain
  function setRegistry(string calldata _registryChain, string calldata _registryAddress) public {
    registryChain = _registryChain;
    registryAddress = _registryAddress;
  }

}
