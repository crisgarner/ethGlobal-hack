// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGameVerifier {
    function verify(bytes calldata) external view returns (bool r);
}
