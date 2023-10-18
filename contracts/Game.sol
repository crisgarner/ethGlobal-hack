// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ICardGame} from "./interfaces/IGame.sol";
import {IGameVerifier} from "./interfaces/IGameVerifier.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract CardGame is ICardGame {
    IGameVerifier internal immutable i_verifier;

    constructor(address _verifier) {
        if (_verifier == address(0x0)) revert ICardGame__CannotBeZeroAddress();

        i_verifier = IGameVerifier(_verifier);
    }

    function newGame(address _coin, uint256 _amount, bytes memory _proof)
        external
        virtual
        override
        canPlay
        isAllowedCoin(_coin)
    {
        if (!i_verifier.verify(_proof)) {
            revert ICardGame__InvalidProof();
        }

        bool transfered = IERC20(_coin).transferFrom(msg.sender, address(this), _amount);

        if (!transfered) {
            revert ICardGame__CannotTransferTokens(_coin);
        }

        bytes32 commitment;
        assembly {
            commitment := mload(add(_proof, 32))
        }
        games[gameIndex].gameState = State.Started;
        games[gameIndex].commitments[0] = commitment;
        games[gameIndex].coin = _coin;
        games[gameIndex].pot = _amount;
        games[gameIndex].players[0] = msg.sender;

        emit CreatedGame(msg.sender, gameIndex, _coin, _amount);

        unchecked {
            ++gameIndex;
        }
    }

    function joinGame(uint256 _id) external virtual override canPlay {}

    function reveal() external virtual override {}
}
