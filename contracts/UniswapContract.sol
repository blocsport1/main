pragma solidity ^0.4.24;

/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
    address public owner;

    /**
      * @dev The Ownable constructor sets the original `owner` of the contract to the sender
      * account.
      */
    function Ownable() public {
        owner = msg.sender;
    }

    /**
      * @dev Throws if called by any account other than the owner.
      */
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    /**
    * @dev Allows the current owner to transfer control of the contract to a newOwner.
    * @param newOwner The address to transfer ownership to.
    */
    function transferOwnership(address newOwner) public onlyOwner {
        if (newOwner != address(0)) {
            owner = newOwner;
        }
    }

}

/**
 * @title Pausable
 * @dev Base contract which allows children to implement an emergency stop mechanism.
 */
contract Pausable is Ownable {
  event Pause();
  event Unpause();

  bool public paused = false;


  /**
   * @dev Modifier to make a function callable only when the contract is not paused.
   */
  modifier whenNotPaused() {
    require(!paused);
    _;
  }

  /**
   * @dev Modifier to make a function callable only when the contract is paused.
   */
  modifier whenPaused() {
    require(paused);
    _;
  }

  /**
   * @dev called by the owner to pause, triggers stopped state
   */
  function pause() onlyOwner whenNotPaused public {
    paused = true;
    Pause();
  }

  /**
   * @dev called by the owner to unpause, returns to normal state
   */
  function unpause() onlyOwner whenPaused public {
    paused = false;
    Unpause();
  }
}

/**
 * @title ERC20Basic
 * @dev Simpler version of ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/20
 */
contract ERC20Basic {
    uint public _totalSupply;
    function totalSupply() public constant returns (uint);
    function balanceOf(address who) public constant returns (uint);
    function transfer(address to, uint value) public;
    event Transfer(address indexed from, address indexed to, uint value);
}

/**
 * @title ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/20
 */
contract ERC20 is ERC20Basic {
    function allowance(address owner, address spender) public constant returns (uint);
    function transferFrom(address from, address to, uint value) public;
    function approve(address spender, uint value) public;
    event Approval(address indexed owner, address indexed spender, uint value);
}

/**
 * @title Basic token
 * @dev Basic version of StandardToken, with no allowances.
 */
contract BasicToken is Ownable, ERC20Basic {
    using SafeMath for uint;

    mapping(address => uint) public balances;

    // additional variables for use if transaction fees ever became necessary
    uint public basisPointsexchangeFee = 0;
    uint public maximumFee = 0;

    /**
    * @dev Fix for the ERC20 short address attack.
    */
    modifier onlyPayloadSize(uint size) {
        require(!(msg.data.length < size + 4));
        _;
    }

    /**
    * @dev transfer token for a specified address
    * @param _to The address to transfer to.
    * @param _value The amount to be transferred.
    */
    function transfer(address _to, uint _value) public onlyPayloadSize(2 * 32) {
        uint fee = (_value.mul(basisPointsexchangeFee)).div(10000);
        if (fee > maximumFee) {
            fee = maximumFee;
        }
        uint sendAmount = _value.sub(fee);
        balances[msg.sender] = balances[msg.sender].sub(_value);
        balances[_to] = balances[_to].add(sendAmount);
        if (fee > 0) {
            balances[owner] = balances[owner].add(fee);
            Transfer(msg.sender, owner, fee);
        }
        Transfer(msg.sender, _to, sendAmount);
    }

    /**
    * @dev Gets the balance of the specified address.
    * @param _owner The address to query the the balance of.
    * @return An uint representing the amount owned by the passed address.
    */
    function balanceOf(address _owner) public constant returns (uint balance) {
        return balances[_owner];
    }

}

/**
 * @title Standard ERC20 token
 *
 * @dev Implementation of the basic standard token.
 * @dev https://github.com/ethereum/EIPs/issues/20
 * @dev Based oncode by FirstBlood: https://github.com/Firstbloodio/token/blob/master/smart_contract/FirstBloodToken.sol
 */
contract StandardToken is BasicToken, ERC20 {

    mapping (address => mapping (address => uint)) public allowed;

    uint public constant MAX_UINT = 2**256 - 1;

    /**
    * @dev Transfer tokens from one address to another
    * @param _from address The address which you want to send tokens from
    * @param _to address The address which you want to transfer to
    * @param _value uint the amount of tokens to be transferred
    */
    function transferFrom(address _from, address _to, uint _value) public onlyPayloadSize(3 * 32) {
        var _allowance = allowed[_from][msg.sender];

        // Check is not needed because sub(_allowance, _value) will already throw if this condition is not met
        // if (_value > _allowance) throw;

        uint fee = (_value.mul(basisPointsexchangeFee)).div(10000);
        if (fee > maximumFee) {
            fee = maximumFee;
        }
        if (_allowance < MAX_UINT) {
            allowed[_from][msg.sender] = _allowance.sub(_value);
        }
        uint sendAmount = _value.sub(fee);
        balances[_from] = balances[_from].sub(_value);
        balances[_to] = balances[_to].add(sendAmount);
        if (fee > 0) {
            balances[owner] = balances[owner].add(fee);
            Transfer(_from, owner, fee);
        }
        Transfer(_from, _to, sendAmount);
    }

    /**
    * @dev Approve the passed address to spend the specified amount of tokens on behalf of msg.sender.
    * @param _spender The address which will spend the funds.
    * @param _value The amount of tokens to be spent.
    */
    function approve(address _spender, uint _value) public onlyPayloadSize(2 * 32) {

        // To change the approve amount you first have to reduce the addresses`
        //  allowance to zero by calling `approve(_spender, 0)` if it is not
        //  already 0 to mitigate the race condition described here:
        //  https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
        require(!((_value != 0) && (allowed[msg.sender][_spender] != 0)));

        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
    }

    /**
    * @dev Function to check the amount of tokens than an owner allowed to a spender.
    * @param _owner address The address which owns the funds.
    * @param _spender address The address which will spend the funds.
    * @return A uint specifying the amount of tokens still available for the spender.
    */
    function allowance(address _owner, address _spender) public constant returns (uint remaining) {
        return allowed[_owner][_spender];
    }

}

contract BlackList is Ownable, BasicToken {

    /////// Getters to allow the same blacklist to be used also by other contracts (including upgraded Tether) ///////
    function getBlackListStatus(address _maker) external constant returns (bool) {
        return isBlackListed[_maker];
    }

    function getOwner() external constant returns (address) {
        return owner;
    }

    mapping (address => bool) public isBlackListed;

    function addBlackList (address _evilUser) public onlyOwner {
        isBlackListed[_evilUser] = true;
        AddedBlackList(_evilUser);
    }

    function removeBlackList (address _clearedUser) public onlyOwner {
        isBlackListed[_clearedUser] = false;
        RemovedBlackList(_clearedUser);
    }

    function destroyBlackFunds (address _blackListedUser) public onlyOwner {
        require(isBlackListed[_blackListedUser]);
        uint dirtyFunds = balanceOf(_blackListedUser);
        balances[_blackListedUser] = 0;
        _totalSupply -= dirtyFunds;
        DestroyedBlackFunds(_blackListedUser, dirtyFunds);
    }

    event DestroyedBlackFunds(address _blackListedUser, uint _balance);

    event AddedBlackList(address _user);

    event RemovedBlackList(address _user);

}

contract UpgradedStandardToken is StandardToken{
    // those methods are called by the legacy contract
    // and they must ensure msg.sender to be the contract address
    function transferByLegacy(address from, address to, uint value) public;
    function transferFromByLegacy(address sender, address from, address spender, uint value) public;
    function approveByLegacy(address from, address spender, uint value) public;
}

contract TetherToken is Pausable, StandardToken, BlackList {

    string public name;
    string public symbol;
    uint public decimals;
    address public upgradedAddress;
    bool public deprecated;

    //  The contract can be initialized with a number of tokens
    //  All the tokens are deposited to the owner address
    //
    // @param _balance Initial supply of the contract
    // @param _name Token Name
    // @param _symbol Token symbol
    // @param _decimals Token decimals
    function TetherToken(uint _initialSupply, string _name, string _symbol, uint _decimals) public {
        _totalSupply = _initialSupply;
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        balances[owner] = _initialSupply;
        deprecated = false;
    }

    // Forward ERC20 methods to upgraded contract if this one is deprecated
    function transfer(address _to, uint _value) public whenNotPaused {
        require(!isBlackListed[msg.sender]);
        if (deprecated) {
            return UpgradedStandardToken(upgradedAddress).transferByLegacy(msg.sender, _to, _value);
        } else {
            return super.transfer(_to, _value);
        }
    }

    // Forward ERC20 methods to upgraded contract if this one is deprecated
    function transferFrom(address _from, address _to, uint _value) public whenNotPaused {
        require(!isBlackListed[_from]);
        if (deprecated) {
            return UpgradedStandardToken(upgradedAddress).transferFromByLegacy(msg.sender, _from, _to, _value);
        } else {
            return super.transferFrom(_from, _to, _value);
        }
    }

    // Forward ERC20 methods to upgraded contract if this one is deprecated
    function balanceOf(address who) public constant returns (uint) {
        if (deprecated) {
            return UpgradedStandardToken(upgradedAddress).balanceOf(who);
        } else {
            return super.balanceOf(who);
        }
    }

    // Forward ERC20 methods to upgraded contract if this one is deprecated
    function approve(address _spender, uint _value) public onlyPayloadSize(2 * 32) {
        if (deprecated) {
            return UpgradedStandardToken(upgradedAddress).approveByLegacy(msg.sender, _spender, _value);
        } else {
            return super.approve(_spender, _value);
        }
    }

    // Forward ERC20 methods to upgraded contract if this one is deprecated
    function allowance(address _owner, address _spender) public constant returns (uint remaining) {
        if (deprecated) {
            return StandardToken(upgradedAddress).allowance(_owner, _spender);
        } else {
            return super.allowance(_owner, _spender);
        }
    }

    // deprecate current contract in favour of a new one
    function deprecate(address _upgradedAddress) public onlyOwner {
        deprecated = true;
        upgradedAddress = _upgradedAddress;
        Deprecate(_upgradedAddress);
    }

    // deprecate current contract if favour of a new one
    function totalSupply() public constant returns (uint) {
        if (deprecated) {
            return StandardToken(upgradedAddress).totalSupply();
        } else {
            return _totalSupply;
        }
    }

    // Issue a new amount of tokens
    // these tokens are deposited into the owner address
    //
    // @param _amount Number of tokens to be issued
    function issue(uint amount) public onlyOwner {
        require(_totalSupply + amount > _totalSupply);
        require(balances[owner] + amount > balances[owner]);

        balances[owner] += amount;
        _totalSupply += amount;
        Issue(amount);
    }

    // Redeem tokens.
    // These tokens are withdrawn from the owner address
    // if the balance must be enough to cover the redeem
    // or the call will fail.
    // @param _amount Number of tokens to be issued
    function redeem(uint amount) public onlyOwner {
        require(_totalSupply >= amount);
        require(balances[owner] >= amount);

        _totalSupply -= amount;
        balances[owner] -= amount;
        Redeem(amount);
    }

    function setParams(uint newBasisPoints, uint newMaxFee) public onlyOwner {
        // Ensure transparency by hardcoding limit beyond which fees can never be added
        require(newBasisPoints < 20);
        require(newMaxFee < 50);

        basisPointsexchangeFee = newBasisPoints;
        maximumFee = newMaxFee.mul(10**decimals);

        Params(basisPointsexchangeFee, maximumFee);
    }

    // Called when new token are issued
    event Issue(uint amount);

    // Called when tokens are redeemed
    event Redeem(uint amount);

    // Called when contract is deprecated
    event Deprecate(address newAddress);

    // Called if contract ever adds fees
    event Params(uint feeBasisPoints, uint maxFee);
}

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

/**
   * @title Uniswap Contract
   * @dev Uniswap is a base contract for managing a token Uniswap to Tether,
   * allowing investors to swap tokens with ether. This contract implements
   * such functionality in its most fundamental form and can be extended to provide additional
   * functionality and/or custom behavior.
   * The external interface represents the basic interface for purchasing tokens, and conform
   * the base architecture for Uniswaps. They are *not* intended to be modified / overriden.
   * The internal interface conforms the extensible and modifiable surface of Uniswaps. Override
   * the methods to add functionality. Consider using 'super' where appropiate to concatenate
   * behavior.
   */
contract UniswapContract is  Pausable {
    using SafeMath for uint256;
    //using SafeERC20 for IERC20;
    //BetaTickerERC20
    TetherToken public token;
    IERC20 public tokenToSwap;
    address public swapContract;
    uint256 public minSwap;
    address public admin;
    //BetaTickerERC20 private _acceptedToken;
    uint256 public tokenPrice;
    uint256 public ethPrice;
    //mapping(address => bool) public whitelist;
    mapping(address => uint256) public swappedEther;
    mapping(address => uint256) public ethInEscrow;
    mapping(address => uint256) public swappedTether;
    mapping(address => uint256) public tetherInEscrow;
    mapping(address => uint256) public escrowFundsEth;
    mapping(address => uint256) public escrowFundsTether;
    mapping(address => uint256) public tokensToRecieve;


    modifier onlySwapContract() {
    require(msg.sender == swapContract, "Only Swap Contract allowed to make the call");
    _;
  }

  modifier onlyAdmin() {
   require(msg.sender == admin, "Only Admin allowed to make the call");
   _;
 }
    // Address where funds are collected
    address private wallet;

    // The exchange fee charged for the swap
    uint256 private exchangeFee;

    // Amount of ERC20 token swapped
    uint256 private tokenSwapped;

    /**
     * Event for token swap logging
     * @param operator who called function
     * @param beneficiary who got the tokens
     * @param value ERC20 tokens paid for swap
     * @param amount amount of tokens swapd
     */
    event TokensSwapped(
        address indexed operator,
        address indexed beneficiary,
        uint256 value,
        uint256 amount
    );

    /**
     * @param _exchangeFee Number of token units a buyer gets per ERC20 token
     * @param _wallet Address where swapped funds will be forwarded to
     * @param _token Address of the token being sold
     * @param _tokenToSwap Address of the token being accepted
     */
    constructor(uint256 _exchangeFee, address _wallet, address _token, address _tokenToSwap , uint256 _minSwap) public { // solhint-disable-line max-line-length
        require(_exchangeFee > 0);
        require(_wallet != address(0));
        require(address(_token) != address(0));
        require(address(_tokenToSwap) != address(0));
        require(_minSwap > 0);
        exchangeFee = _exchangeFee;
        wallet = _wallet;
        token = TetherToken(_token);
        tokenToSwap =  IERC20(_tokenToSwap);
        swapContract = address(this);
        minSwap = _minSwap;
        admin = msg.sender;
    }


    /**
     * @return the address where funds are collected.
     */
    function _wallet() public view returns (address) {
        return wallet;
    }

    /**
     * @return the number of token units a buyer gets per ERC20 token.
     */
    function _exchangeFee() public view returns (uint256) {
        return exchangeFee;
    }

    /**
     * @return the amount of ERC20 token raised.
     */
    function _tokenSwapped() public view returns (uint256) {
        return tokenSwapped;
    }


    /**
     * @return the token being sold.
     */
    function _token() public view returns (StandardToken) {
        return token;
    }
    /**
     * @return the accepted Token.
     */
    function _tokenToSwap() public view returns (IERC20) {
        return tokenToSwap;
    }
    /**
     * @return the minSwap .
     */
    function _minSwap() public view returns (uint256) {
        return minSwap;
    }

    function recieveEth() public payable {
    uint256 ethToUsd =  uint256(msg.value.mul(ethPrice).div(10**18));
    uint256 ethCharged = msg.value.mul(exchangeFee).mul(ethPrice).div(100).div(10**18);
    ethToUsd = ethToUsd.sub(ethCharged);
    uint256 ethToSwap = msg.value.sub(msg.value.mul(exchangeFee).div(100));
    require(ethToUsd >= minSwap);

    uint256 tokenToRecieve = ethToUsd.div(tokenPrice);
    ethInEscrow[msg.sender] += ethToSwap;
    tokensToRecieve[msg.sender] += tokenToRecieve;
    swappedEther[msg.sender] = swappedEther[msg.sender] + ethToSwap;
    swapTokensEth(msg.sender, msg.value, 18);
    //return tokenToRecieve;
    }

    /**
     * @dev low level token swap ***DO NOT OVERRIDE***
     * This function has a non-reentrancy guard, so it shouldn't be called by
     * another `nonReentrant` function
     * @param _decimals number of decimals of the USDT token
     */
     // Never use the dep Swap it
     function swapTokensTether(address _beneficiary, uint256 _value, uint256 _decimals) public onlySwapContract {
        uint256 weiAmount = tokensToRecieve[_beneficiary];
        require(weiAmount > 0);
        //uint256 refundWeiAmt = 0;
        uint256 weiToSend = 0;
        //uint256 refundAmount = 0;
        //uint256 sentTokenAmount = 0;

        //refundAmount = weiAmount.mod(minSwap);
        //sentTokenAmount = weiAmount.sub(refundAmount);
        weiToSend = weiAmount.mul(10 ** _decimals);

        //acceptedToken.transferFrom(msg.sender, _beneficiary, refundAmount);
        _processSwap(_beneficiary,weiToSend);
        //token.transfer(wallet, weiToSend);
        _forwardTether(wallet,_value);
        tetherInEscrow[_beneficiary] = 0;
        tokensToRecieve[_beneficiary] = 0;
        escrowFundsTether[wallet] = escrowFundsTether[wallet] + _value;
        tokenSwapped = tokenSwapped.add(weiToSend);
    }


    function swapTokensEth(address _beneficiary, uint256 _value, uint256 _decimals) public onlySwapContract {
        uint256 fundedAmount = tokensToRecieve[_beneficiary];
        uint256 weiAmount = fundedAmount.mul(10**uint256(_decimals));

        _processSwap(_beneficiary,weiAmount);
        _forwardEth(wallet,_value);

        etherInEscrow[_beneficiary] = 0;
        tokensToRecieve[_beneficiary] = 0;
        escrowFundsEth[wallet] = escrowFundsEth[wallet] + _value;
        tokenSwapped = tokenSwapped.add(weiAmount);
    }

    /**
    * @dev updates token sent by each address address to investors .
    * @param _investor Address that sent tokens
    * @param _amount amount of tokens recieved
    * @param _decimals number of decimals of the USDT token
    */
      function tetherRecieved(address _investor, uint256 _amount, uint256 _decimals) public onlyAdmin {
           uint tokenTorecieve = 0;
           //uint tokenToSend = 0;
           uint feeCharged = 0;
           uint amount = _amount.mul(10 ** _decimals);
          feeCharged = amount.mul(exchangeFee).div(100);
          _amount = amount.sub(feeCharged);
          tokenToRecieve = _amount.div(tokenPrice).div(10**_decimals);
          require(tokenToRecieve >= minSwap);
          if (swappedTether[_investor] > 0){
            tetherInEscrow[_investor] =   tetherInEscrow[_investor] + _amount;
            tokensToRecieve[_investor] = tokenToRecieve;
            swappedTether[_investor] = swappedTether[_investor] + _amount;
          } else {
              tetherInEscrow[_investor] =  _amount;
              tokensToRecieve[_investor] = tokenToRecieve;
              swappedTether[_investor] = _amount;
          }
          swapTokensTether(_investor, _amount, 18);
    }

  /**
     * @dev Executed when a swap has been validated and is ready to be executed. Not necessarily emits/sends tokens.
     * @param _beneficiary Address receiving the tokens
     * @param _tokenAmount Number of tokens to be swapd
     */
    function _processSwap(address _beneficiary, uint256 _tokenAmount) internal isWhitelisted(_beneficiary) {
        _deliverTokens(_beneficiary, _tokenAmount);
    }

    /**
     * @dev Override for extensions that require an internal state to check for validity
     * @param beneficiary Address receiving the tokens
     * @param sentTokenAmount Value in B tokens involved in the swap
     */
    function _preValidateSwap(address beneficiary, uint256 sentTokenAmount) internal {
        // solhint-disable-previous-line no-empty-blocks

        // optional override
    }

    /**
     * @dev Determines how tokens are stored/forwarded on swaps.
     */
    function _forwardTether(address _recipient , uint256 _value) internal  {
     token.transfer(_recipient, _value);
    }

    function _forwardEth(address _recipient , uint256 _value) internal  {
     msg.sender.transfer(_recipient, _value);
    }
     /**
     * @dev Set the exchange Fee , fee charged for the swap */
    function setExchangeFee(uint256 _newexchangeFee) public onlyAdmin {
      require(_newexchangeFee > 0);
      exchangeFee = _newexchangeFee;
    }

    function setEthPrice(uint256 _ethPrice) public onlyAdmin {
      require(_ethPrice > 0);
      ethPrice = _ethPrice;
    }

    function setTokenPrice(uint256 _tokenPrice) public onlyAdmin {
      require(_tokenPrice > 0);
      tokenPrice = _tokenPrice;
    }

   /**
   * @dev Source of tokens. Override this method to modify the way in which the Uniswap ultimately gets and sends its tokens.
   * @param _beneficiary Address performing the token swap
   * @param _tokenAmount Number of tokens to be emitted
   */
  function _deliverTokens(address _beneficiary, uint256 _tokenAmount) internal {
    //uint256 allowance = acceptedToken.allowance(msg.sender, address(this));
    //require(allowance >= _tokenAmount, "Check the usdt allowance");
    tokenToSwap.transferFrom(msg.sender, _beneficiary, _tokenAmount);
    //acceptedToken.safeTransfer(_beneficiary, _tokenAmount);
  }

  /**
   * @dev Validation of an executed swap. Observe state and use revert statements to undo rollback when valid conditions are not met.
   * @param _beneficiary Address performing the token swap
   * @param _weiAmount Value in wei involved in the swap
   */
  function _postValidateSwap(address _beneficiary, uint256 _weiAmount) internal pure {
    require(_beneficiary != address(0), "address after execution");
    require(_weiAmount >= 0, "amount after execution");
    // optional override
  }

    function adjustMinSwap(uint256 _minSwap) public  {
     require(_minSwap > 0);
      minSwap = _minSwap;
    }
       function switchAdmin(address _admin) public onlyAdmin  returns (bool) {
           require(msg.sender != address(0));
           admin = _admin;
           return true;
       }

  }
