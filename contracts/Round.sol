pragma solidity ^0.8.17;
// SPDX-License-Identifier: UNLICENSED
// import "hardhat/console.sol";
import "./Registry.sol";

contract Round {
  Registry registry;

  mapping(uint256 => bool) public projectsAppliedStatus;

  constructor() {}

  function setRegistry(address _registry) public {
    registry = Registry(_registry);
  }

  function applyToRound(uint256 index, address _wallet) public {
    require(registry.isProjectOwner(index, _wallet), "not project owner");
    projectsAppliedStatus[index] = true;
  }

  function isProjectApplied(uint256 index) public view returns (bool) {
    return projectsAppliedStatus[index];
  }
}
