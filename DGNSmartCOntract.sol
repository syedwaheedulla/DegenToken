// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol"; 

contract DegenToken is ERC20, Ownable {
    event PrizeRedeemed(address indexed user, uint256 prizeSelection, uint256 prizeCost);

    constructor() ERC20("Degen", "DGN") {}

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    function calculatePrizeCost(uint256 prizeSelection) internal pure returns (uint256) {
       
        return prizeSelection * 100;
    }

    function redeemTokens(uint256 amount, uint256 prizeSelection) external {
        require(amount > 0, "Amount must be greater than zero");
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");

        uint256 prizeCost = calculatePrizeCost(prizeSelection);
        require(amount >= prizeCost, "Insufficient tokens for selected prize");

        _burn(msg.sender, prizeCost);



        console.log("Redemption successful for user %s. Prize selection: %s, Prize cost: %s", msg.sender, prizeSelection, prizeCost);
    }
}
