import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("DeploySVG_NFT", (m) => {
    const svgNft = m.contract("SVG_NFT");

    return { svgNft };
});

