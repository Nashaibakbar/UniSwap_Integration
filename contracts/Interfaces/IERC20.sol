pragma solidity 0.7.0;

interface IERC20 {
    function approve(address spender, uint256 amount)
        external
        returns (bool success);

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);
}
