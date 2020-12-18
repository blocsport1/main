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

contract BlockSportOne is IERC20 {
    using SafeMath for uint256;

    mapping (address => uint256) private _balances;

    mapping (address => mapping (address => uint256)) private _allowances;

    uint256 private _totalSupply;

    /**
     * @dev See `IERC20.totalSupply`.
     */
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See `IERC20.balanceOf`.
     */
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See `IERC20.transfer`.
     *
     * Requirements:
     *
     * - `recipient` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address recipient, uint256 amount) public returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    /**
     * @dev See `IERC20.allowance`.
     */
    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See `IERC20.approve`.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 value) public returns (bool) {
        _approve(msg.sender, spender, value);
        return true;
    }

    /**
     * @dev See `IERC20.transferFrom`.
     *
     * Emits an `Approval` event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of `ERC20`;
     *
     * Requirements:
     * - `sender` and `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `value`.
     * - the caller must have allowance for `sender`'s tokens of at least
     * `amount`.
     */
    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, msg.sender, _allowances[sender][msg.sender].sub(amount));
        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to `approve` that can be used as a mitigation for
     * problems described in `IERC20.approve`.
     *
     * Emits an `Approval` event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
        _approve(msg.sender, spender, _allowances[msg.sender][spender].add(addedValue));
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to `approve` that can be used as a mitigation for
     * problems described in `IERC20.approve`.
     *
     * Emits an `Approval` event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
        _approve(msg.sender, spender, _allowances[msg.sender][spender].sub(subtractedValue));
        return true;
    }

    /**
     * @dev Moves tokens `amount` from `sender` to `recipient`.
     *
     * This is internal function is equivalent to `transfer`, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a `Transfer` event.
     *
     * Requirements:
     *
     * - `sender` cannot be the zero address.
     * - `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     */
    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _balances[sender] = _balances[sender].sub(amount);
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a `Transfer` event with `from` set to the zero address.
     *
     * Requirements
     *
     * - `to` cannot be the zero address.
     */
    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: mint to the zero address");

        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);
        emit Transfer(address(0), account, amount);
    }

     /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a `Transfer` event with `to` set to the zero address.
     *
     * Requirements
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(address account, uint256 value) internal {
        require(account != address(0), "ERC20: burn from the zero address");

        _totalSupply = _totalSupply.sub(value);
        _balances[account] = _balances[account].sub(value);
        emit Transfer(account, address(0), value);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner`s tokens.
     *
     * This is internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an `Approval` event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(address owner, address spender, uint256 value) internal {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = value;
        emit Approval(owner, spender, value);
    }

    /**
     * @dev Destoys `amount` tokens from `account`.`amount` is then deducted
     * from the caller's allowance.
     *
     * See `_burn` and `_approve`.
     */
    function _burnFrom(address account, uint256 amount) internal {
        _burn(account, amount);
        _approve(account, msg.sender, _allowances[account][msg.sender].sub(amount));
    }
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
    BlockSportOne public tokenToSwap;
    //address public swapContract;
    uint256 public minSwap;
    address public admin;
    //address public tokenHolder;
    //BetaTickerERC20 private _acceptedToken;
    uint256 public tokenPrice;
    uint256 public ethPrice;
    uint256 public tetherPrice;
    //mapping(address => bool) public whitelist;
    mapping(address => uint256) public swappedWei;
    mapping(address => uint256) public weiInEscrow;
    mapping(address => uint256) public swappedTether;
    mapping(address => uint256) public tetherInEscrow;
    mapping(address => uint256) public swappedFundsWei;
    mapping(address => uint256) public swappedFundsTether;
    mapping(address => uint256) public tokensToRecieve;



  modifier onlyAdmin() {
   require(msg.sender == admin, "Only Admin allowed to make the call");
   _;
 }
    // Address where funds are collected
    address public wallet;

    // The exchange fee charged for the swap
    uint256 public exchangeFee;

    // Amount of ERC20 token swapped
    uint256 public tokenSwapped;

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

    event EthRecieved(
        address indexed sender,
        uint256 value
        );

      event UsdtRecieved(
        address indexed investor,
        uint256 amount
        );

    /**
     * @param _exchangeFee Number of token units a buyer gets per ERC20 token
     * @param _wallet Address where swapped funds will be forwarded to
     * @param _token Address of the token being sold
     * @param _tokenToSwap Address of the token being accepted
     * @param _minSwap minimum value allowed for swap in USD
     */
    constructor(uint256 _exchangeFee, address _wallet, TetherToken _token, BlockSportOne _tokenToSwap , uint256 _minSwap) public { // solhint-disable-line max-line-length
        require(_exchangeFee > 0);
        require(_wallet != address(0));
        require(address(_token) != address(0));
        require(address(_tokenToSwap) != address(0));
        //require(address(_tokenHolder) != address(0));
        require(_minSwap > 0);
        exchangeFee = _exchangeFee;
        wallet = _wallet;
        token = _token;
        tokenToSwap =  _tokenToSwap;
        //swapContract = address(this);
        minSwap = _minSwap;
        admin = msg.sender;
        //tokenHolder = address(this);
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
    function _tokenToSwap() public view returns (BlockSportOne) {
        return tokenToSwap;
    }
    /**
     * @return the minSwap .
     */
    function _minSwap() public view returns (uint256) {
        return minSwap;
    }

      /**
     * @return the minSwap .
     */
    function _tetherPrice() public view returns (uint256) {
        return tetherPrice;
    }

     /**
   * @dev fallback function ***DO NOT OVERRIDE***
   */
  function () external payable {
    recieveEth(msg.sender);
  }

function recieveEth(address _investor) public payable {
 uint256 _value = msg.value;
 uint256 _divisor = 10 ** 18;
 //uint256 weiToUsd = 0;
 uint256 decimals = 0;
// uint256 weiCharged = 0;
 //uint256 weiToSwap = 0;
// uint256 tokenToRecieve = 0;
 uint256 _minSwapWei = minSwap.mul(_divisor).mul(100).div(ethPrice);
 uint256 weiCharged = _value.mul(exchangeFee).div(100);
 uint256 weiToSwap = _value - weiCharged;
 //weiToSwap = weiToSwap.mul(_divisor);
  _preValidateSwap(_investor, weiToSwap, _minSwapWei);
 // weiToSwap = weiToSwap.div(_divisor);
 uint256 weiToUsd =  weiToSwap.mul(ethPrice).mul(10**4).div(_divisor);
 decimals = 12;
 uint256 tokenToRecieve = weiToUsd.mul(10).div(tokenPrice);
 if (swappedWei[_investor] > 0){
         weiInEscrow[_investor] = weiInEscrow[_investor] + weiToSwap;
         tokensToRecieve[_investor] = tokensToRecieve[_investor] + tokenToRecieve;
         swappedWei[_investor] = swappedWei[_investor] + weiToSwap;
       }
 else {
           weiInEscrow[_investor] =  weiToSwap;
           tokensToRecieve[_investor] = tokenToRecieve;
           swappedWei[_investor] = weiToSwap;
       }
 //swapTokensEth(_investor, _value, tokenToRecieve , decimals);
     require(tokensToRecieve[_investor] > 0);
     require(tokenToSwap.balanceOf(address(this)) >= tokenToRecieve, "The contract has not been funded with BlockSportOne Tokens");
     uint256 fundedAmount = tokensToRecieve[_investor];
     if (fundedAmount <= 0){ fundedAmount = tokenToRecieve; }
     uint256 weiAmount = fundedAmount.mul(10 ** decimals);

     tokenToSwap.transfer(_investor, weiAmount);
     wallet.transfer(_value);
     weiInEscrow[_investor] = 0;
     tokensToRecieve[_investor] = 0;
     swappedFundsWei[wallet] = swappedFundsWei[wallet].add(_value);
     tokenSwapped = tokenSwapped.add(weiAmount);
     emit EthRecieved(wallet, _value);

     uint256 _tokenToRecieve = tokensToRecieve[_investor];
     uint256 _remain = weiInEscrow[_investor];
     _postValidateSwap(_investor, _tokenToRecieve, _remain);

 //return tokenToRecieve;
 }


    /**
    /**
     * @dev low level token swap ***DO NOT OVERRIDE***
     * This function has a non-reentrancy guard, so it shouldn't be called by
     * another `nonReentrant` function
     * @param _beneficiary the customer who initited the swap
     * @param _value of Ether sent in
     * @param _tokenValue total number of tokens to send
     * @param _decimals number of decimals in one Ether
     */
     // Never use the dep Swap it
   /**
    function swapTokensEth(address _beneficiary, uint256 _value, uint256 _tokenValue, uint256 _decimals) public  {
        require(tokensToRecieve[_beneficiary] > 0);
        require(tokenToSwap.balanceOf(address(this)) >= _tokenValue, "The contract has not been funded with BlockSportOne Tokens");
        uint256 fundedAmount = tokensToRecieve[_beneficiary];
        if (fundedAmount <= 0){ fundedAmount = _tokenValue; }
        uint256 weiAmount = fundedAmount.mul(10 ** uint256(_decimals));

        tokenToSwap.transfer(_beneficiary, weiAmount);
        _forwardEth(_value);
        weiInEscrow[_beneficiary] = 0;
        tokensToRecieve[_beneficiary] = 0;
        swappedFundsWei[wallet] = swappedFundsWei[wallet].add(_value);
        tokenSwapped = tokenSwapped.add(weiAmount);
        emit EthRecieved(wallet, _value);
    }
   **/

    /**
    * @dev updates token sent by each address address to investors .
    * @param _investor Address that sent tokens
    * @param _amount amount of tokens recieved
    * @param _decimals number of decimals of the USDT token
    */
      function tetherRecieved(address _investor, uint256 _amount, uint256 _decimals) public onlyAdmin {
          require(token.balanceOf(address(this)) >= _amount, "The contract has not been funded with USDT");
           //uint256 _recieved = _amount;

           uint256 multiplier = 10 ** _decimals;
           uint256 minSwapTether = minSwap.mul(multiplier);
           uint256 amount = _amount.mul(multiplier);
           uint256 amountUsd = amount.mul(97).div(100);
           _preValidateSwap(_investor, amountUsd, minSwapTether);
          uint256 _tokenToRec = amountUsd.mul(10).div(multiplier);
          if (swappedTether[_investor] > 0){
            tetherInEscrow[_investor] = tetherInEscrow[_investor] + amountUsd;
            tokensToRecieve[_investor] = tokensToRecieve[_investor] + _tokenToRec;
            swappedTether[_investor] = swappedTether[_investor] + amountUsd;
          } else {
              tetherInEscrow[_investor] =  amountUsd;
              tokensToRecieve[_investor] = _tokenToRec;
              swappedTether[_investor] = amountUsd;
          }
         uint256 decimals = 18;
         require(tokensToRecieve[_investor] > 0);
        uint256 weiAmount = tokensToRecieve[_investor];
        if (weiAmount <= 0){ weiAmount = _tokenToRec; }
        require(weiAmount > 0);
        //uint256 refundWeiAmt = 0;
        //uint256 weiToSend = 0;

        uint256 weiToSend = weiAmount.mul(10 ** decimals);
        tokenToSwap.transferFrom(msg.sender, _investor, weiToSend);
        token.transfer(wallet, amount);

        tetherInEscrow[_investor] = 0;
        tokensToRecieve[_investor] = 0;
        swappedFundsTether[wallet] = swappedFundsTether[wallet].add(amount);
        tokenSwapped = tokenSwapped.add(weiToSend);
         emit UsdtRecieved(wallet, _amount);


          uint256 _tokenTorecieve = tokensToRecieve[_investor];
           uint256 _remain = tetherInEscrow[_investor];
          _postValidateSwap(_investor, _tokenTorecieve, _remain);
    }



    /**
     * @dev Override for extensions that require an internal state to check for validity
     * @param beneficiary Address receiving the tokens
     * @param sentTokenAmount Value in tokens involved in the swap
     * @param minToSwap Minimum Value in USD allowed in the swap
     */
    function _preValidateSwap(address beneficiary, uint256 sentTokenAmount, uint256 minToSwap) internal pure {
        // solhint-disable-previous-line no-empty-blocks
        require(beneficiary != address(0), "Address must not be zero");
        require(sentTokenAmount != 0, "wei must be greator than zero");
        require(sentTokenAmount > minToSwap, "sent ether amount must be greater than minimum allowed");
        //require(tokenToSwap.balanceOf(address(this)) > 0, "The contract must have sawpping tokens deposited");
        // optional override
    }


     /**
     * @dev Set the exchange Fee , fee charged for the swap */
    function setExchangeFee(uint256 _newExchangeFee) public onlyAdmin {
      require(_newExchangeFee > 0);
      exchangeFee = _newExchangeFee;
    }
     /**
     * @dev Set the exchange Fee , fee charged for the swap */
    function setEthPrice(uint256 _ethPrice) public onlyAdmin {
      require(_ethPrice > 0);
      ethPrice = _ethPrice;
    }
     /**
     * @dev Set the exchange Fee , fee charged for the swap */
    function setTokenPrice(uint256 _tokenPrice) public onlyAdmin {
      require(_tokenPrice > 0);
      tokenPrice = _tokenPrice;
    }
     /**
     * @dev Set the exchange Fee , fee charged for the swap */
     function setTetherPrice(uint256 _tethPrice) public onlyAdmin {
      require(_tethPrice > 0);
      tetherPrice = _tethPrice;
    }




       /**
     * @dev Admin refunds escrowed Ether to the buyer incase they didn't recieve their swapped tokens
     * @param _beneficiary the buyer address
     */
  function _refundEth(address _beneficiary) public onlyAdmin{
      require(weiInEscrow[_beneficiary] > 0);
      uint refundValue = weiInEscrow[_beneficiary];
      _beneficiary.transfer(refundValue);
      weiInEscrow[_beneficiary] = 0;
  }
      /**
     * @dev Admin refunds escrowed USDT to the buyer incase they didn't recieve their swapped tokens
     * @param _beneficiary the buyer address
     */

  function _refundTether(address _beneficiary) public onlyAdmin{
      require(tetherInEscrow[_beneficiary] > 0);
      uint refundValue = tetherInEscrow[_beneficiary];
      token.transfer(_beneficiary, refundValue);
      tetherInEscrow[_beneficiary] = 0;
  }
  /**
   * @dev Validation of an executed swap. Observe state and use revert statements to undo rollback when valid conditions are not met.
   * @param _beneficiary Address performing the token swap
   * @param _tokenToRecieve Value in token wei outstanding in the swap
   * @param _weiInEscrow Value in Ether wei outstanding in the swap
   */
  function _postValidateSwap(address _beneficiary, uint _tokenToRecieve, uint256 _weiInEscrow) internal view  {
    require(_beneficiary != address(0), "address after execution");
    require(_tokenToRecieve == 0, "outstanding token amount after execution must be zero");
    require(_weiInEscrow == 0, "outstanding wei amount in the escrow must be zero");
    require(tokenToSwap.balanceOf(_beneficiary) > 0, "The swapped tokens must be deposited to customer wallet");
    // optional override
  }
    /**
     * @dev Admin adjusts the minimum USD swap amount with a new higher value
     * @param _newMinSwap the new minimum swap value to set
     */
    function adjustMinSwap(uint256 _newMinSwap) public  onlyAdmin{
     require(_newMinSwap > minSwap);
      minSwap = _newMinSwap;
    }
     /**
     * @dev Admin switches the uniswap  admin address with a new admin address
     * @param _admin the new admin address to set
     */
       function switchAdmin(address _admin) public onlyAdmin  returns (bool) {
           require(msg.sender != address(0));
           admin = _admin;
           return true;
       }

  }
