// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract SVG_NFT is ERC721 {
    uint256 private _nextTokenId;

    string private constant SVG_IMAGE = 
        '<svg xmlns="http://www.w3.org/2000/svg" width="300" height="200">'
        '<rect width="100%" height="100%" fill="black"/>'
        '<text x="50%" y="50%" dominant-baseline="middle" text-anchor="middle" fill="white" font-size="20">'
        'On-Chain NFT'
        '</text>'
        '</svg>';

    constructor() ERC721("SVG NFT", "SVGNFT") {
        _nextTokenId = 1;
    }

    function mintNFT() public returns (uint256) {
        uint256 tokenId = _nextTokenId++;
        _safeMint(msg.sender, tokenId);
        return tokenId;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        if (ownerOf(tokenId) == address(0)) {
            revert("ERC721Metadata: URI query for nonexistent token");
        }

        // Base64-encode the SVG image
        string memory base64EncodedSVG = Base64.encode(bytes(SVG_IMAGE));

        // Construct metadata JSON and encode it
        string memory json = Base64.encode(
            bytes(
                abi.encodePacked(
                    '{"name":"SVG NFT #', Strings.toString(tokenId), '",',
                    '"description":"An on-chain SVG NFT",',
                    '"image":"data:image/svg+xml;base64,', base64EncodedSVG, '",',
                    '"attributes":[]}'
                )
            )
        );

        return string(abi.encodePacked("data:application/json;base64,", json));
    }
}
