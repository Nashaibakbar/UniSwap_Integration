pragma solidity 0.7.0;

import "./Interfaces/IERC20.sol";
import "./Interfaces/UniswapV2Router.sol";
import "./Interfaces/UniswapFactory.sol";

contract MyProject {
    UniswapFactory factory =
        UniswapFactory(0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f);
    UniswapV2Router router =
        UniswapV2Router(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);

    function createPairs(address tokenA, address tokenB)
        external
        returns (address)
    {
        return factory.createPair(tokenA, tokenB);
    }

    function getPair(address tokenA, address tokenB)
        external
        view
        returns (address)
    {
        return factory.getPair(tokenA, tokenB);
    }

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    )
        external
        returns (
            uint256 _amountA,
            uint256 _amountB,
            uint256 _liquidity
        )
    {
        IERC20(tokenA).approve(address(router), amountADesired);
        IERC20(tokenB).approve(address(router), amountBDesired);
        return
            router.addLiquidity(
                tokenA,
                tokenB,
                amountADesired,
                amountBDesired,
                amountAMin,
                amountBMin,
                to,
                deadline
            );
    }

    function swapTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts) {
        address tokenAdd = 0xBDE8D29cd774BE62CA5FD06F05BB61D1ADee5193;
        IERC20(tokenAdd).approve(address(router), amountIn);
        address[] memory path = new address[](2);
        path[0] = 0xBDE8D29cd774BE62CA5FD06F05BB61D1ADee5193;
        path[1] = 0x48C1F686e7380F8664BDd9c3D3eC2ba14DE88545;
        return
            router.swapExactTokensForTokens(
                amountIn,
                amountOutMin,
                path,
                to,
                deadline
            );
    }

    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountA, uint256 amountB) {
        address UniswapV2Pair = 0x08eD9Ba94e94f6aeb4a5Fe7b61F09Da7f555afC3;
        address owner = 0xFB47999f6A2051ec45ce319E1FD7a1191aaa0FaE;
        IERC20(UniswapV2Pair).transferFrom(owner, address(this), liquidity);
        IERC20(UniswapV2Pair).approve(address(router), type(uint256).max);
        return
            router.removeLiquidity(
                tokenA,
                tokenB,
                liquidity,
                amountAMin,
                amountBMin,
                to,
                deadline
            );
    }
}
