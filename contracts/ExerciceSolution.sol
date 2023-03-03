pragma solidity ^0.6.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./IExerciceSolution.sol";
import "./IPool.sol";
import "./ERC20TD.sol";

contract ExerciceSolution is IExerciceSolution
{
    address DAIaddress = 0xBa8DCeD3512925e52FE67b1b5329187589072A55;
    address USDCaddress = 0x65aFADD39029741B3b8f0756952C74678c9cEC93;
    address Pooladdress= 0x7b5C526B7F8dfdff278b4a3e045083FBA4028790;

    uint amount_Dai = 100 * 1e18;
    uint amount_Usdc = 10 * 1e6;
    constructor () public 
    {
        
    }

    function depositSomeTokens() external override 
    {
        require(ERC20(DAIaddress).approve(Pooladdress, amount_Dai));
        IPool(Pooladdress).supply(DAIaddress, amount_Dai, address(this), 0);
    }

	function withdrawSomeTokens() external override 
    {
        uint withdrawAmount = 10 * 10**18;
        IPool(Pooladdress).withdraw(DAIaddress, withdrawAmount, address(this));
    }

	function borrowSomeTokens() external override 
    {
        IPool(Pooladdress).borrow(USDCaddress, amount_Usdc, 2, 0, address(this));
    }

	function repaySomeTokens() external override 
    {
        require(ERC20(USDCaddress).approve(Pooladdress, amount_Usdc));

        IPool(Pooladdress).repay(USDCaddress, amount_Usdc, 2, address(this));
    }

	function doAFlashLoan() external override
    {
        // uint amount_Flashloan = 1000000 * 1e6;
        // IPool(Pooladdress).flashLoanSimple( address(this), USDCaddress, amount_Flashloan, 0 ,0);
    }

	// function repayFlashLoan(uint amount) external override
    // {
        
    // }

    	function repayFlashLoan() external
    {
        uint amount = 1000000;
        ERC20(USDCaddress).transfer(msg.sender, amount * 1e6);
    }
}

