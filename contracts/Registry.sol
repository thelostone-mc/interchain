pragma solidity ^0.8.17;
// SPDX-License-Identifier: UNLICENSED
// import "hardhat/console.sol";

contract Registry {

  mapping(uint256 => address) public projectIdsToOwner;

  constructor() {
    // auto populate the mapping with some data
    projectIdsToOwner[0] = msg.sender;
    projectIdsToOwner[1] = 0xB8cEF765721A6da910f14Be93e7684e9a3714123;
  }

  function isProjectOwner(uint256 _index, address _address) view public returns (bool) {
    return projectIdsToOwner[_index] == _address;
  }

  function setProjectOwner(uint256 _index, address _address) public {
    projectIdsToOwner[_index] = _address;
  }


}