
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract SVG_NFT is ERC721 {
    uint256 private _nextTokenId;

    string private constant SVG_IMAGE = 'https://cdn.prod.website-files.com/6615636a03a6003b067c36dd/661ffd0dbe9673d914edca2d_6423fc9ca8b5e94da1681a70_Screenshot%25202023-03-29%2520at%252010.53.43.jpeg';

    constructor() ERC721("SVG NFT", "SVGNFT") {
        _nextTokenId = 1;
    }

    function mintNFT() public returns (uint256) {
        uint256 tokenId = _nextTokenId++;
        _safeMint(msg.sender, tokenId);
        return tokenId;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        if (ownerOf(tokenId) == address(0)) {
            revert("ERC721Metadata: URI query for nonexistent token");
        }

        string memory base64EncodedSVG = Base64.encode(bytes(SVG_IMAGE));

        return string(
            abi.encodePacked(
                'data:application/json;base64,',
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name":"SVG NFT #', Strings.toString(tokenId), '",',
                            '"description":"An NFT with on-chain SVG image",',
                            '"image":"data:image/svg+xml;base64,', base64EncodedSVG, '",',
                            '"attributes":[]}'
                        )
                    )
                )
            )
        );
    }
}
