// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract myNFT is ERC721, Ownable {

    uint256 public mintPrice = 0.5 ether;
    uint256 public totalSupply;
    uint256 public maxSupply;
    bool public isMintEnabled;

    mapping( address => uint256) public mintedWallets;

    constructor() payable ERC721('myNFT', 'NF') {
        maxSupply = 3;
    }

    // function to enable mint by only owner
    function toggleIsMintEnabled() external onlyOwner {
        isMintEnabled = !isMintEnabled;
    }

    function setMaxSupply (uint256 _maxSupply) external onlyOwner {
        maxSupply = _maxSupply;

    }

    function mint() external payable {
        require(isMintEnabled,"minting not enabled");
        require(mintedWallets[msg.sender] < 1, "Exceeds max per wallet");
        require(msg.value == mintPrice, "Wrong value");
        require(maxSupply > totalSupply, "Sold Out");

        mintedWallets[msg.sender]++;
        totalSupply++;
        uint256 tokenId = totalSupply;
        _safeMint(msg.sender, tokenId);




    }

}