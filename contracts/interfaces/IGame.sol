// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

abstract contract ICardGame {
    error ICardGame__CannotBeZeroAddress();
    error ICardGame__CannotPlayMultipleGames();
    error ICardGame__CoinNotallowed(address coin);
    error ICardGame__InvalidProof();
    error ICardGame__CannotTransferTokens(address coin);

    enum State {
        Joined,
        NotStarted,
        Over,
        Started
    }

    struct Game {
        bytes32[2] commitments;
        uint256 pot; // The amount to bet
        address coin; // The coin to bet
        address[2] players;
        address winner;
        State gameState;
    }

    event CreatedGame(address indexed creator, uint256 indexed gameId, address indexed coin, uint256 pot);
    event JoinedGame(address indexed player, uint256 indexed gameId);
    event Reveal();
    event Winner(uint256 indexed gameId, address indexed winner);

    uint256 public gameIndex;
    mapping(uint256 => Game) internal games;
    mapping(address => uint256) internal playerToActiveGame;

    mapping(address => bool) internal allowedCoins;

    /**
     * @dev A modifier to restrict players joining more than one game at once.
     */
    modifier canPlay() {
        if (playerToActiveGame[msg.sender] != 0) {
            revert ICardGame__CannotPlayMultipleGames();
        }
        _;
    }

    /**
     * @dev A modifier to check for allowed ERC20 to pay the entrance.
     */
    modifier isAllowedCoin(address _coin) {
        if (!allowedCoins[_coin]) {
            revert ICardGame__CoinNotallowed(_coin);
        }

        _;
    }

    /**
     * @notice Creates a new game with the initial settings, cards commitment and pot for the winner.
     * @param _coin
     * @param _amount
     * @param _proof
     */
    function newGame(address _coin, uint256 _amount, bytes memory _proof) external virtual;
    function joinGame(uint256 _id) external virtual;
    function reveal() external virtual;
}
