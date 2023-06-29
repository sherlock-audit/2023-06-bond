require('@nomicfoundation/hardhat-foundry');
require('@primitivefi/hardhat-dodoc');
require('hardhat-preprocessor');
const fs = require('fs');

function getRemappings() {
    return fs
      .readFileSync("remappings.txt", "utf8")
      .split("\n")
      .filter(Boolean) // remove empty lines
      .map((line) => line.trim().split("="));
  }

module.exports = {
    solidity: {
        version: "0.8.15",
        settings: {
            optimizer: {
                enabled: true,
                runs: 100000
            }
        }
    },
    dodoc: {
        include: ['src'],
        exclude: ['src/test','src/scripts','src/lib'],
    },
    preprocess: {
        eachLine: (hre) => ({
            transform: (line) => {
            if (line.match(/^\s*import /i)) {
                getRemappings().forEach(([find, replace]) => {
                if (line.match(find)) {
                    line = line.replace(find, replace);
                }
                });
            }
            return line;
            },
        }),
    },
    paths: {
        sources: "src",
        cache: "out",
    },
};