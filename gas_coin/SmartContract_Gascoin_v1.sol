
pragma solidity ^0.4.8;
//contract tokenRecipient { 
//    function receiveApproval(address _from, uint256 _value, address _token, bytes _extraData); 
//    
//}

contract MyToken {
    /* Public variables of the token */
    string public standard = 'Gascoin';
    string public name;
    uint256 public priceGas;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    address public owner;
    int256 public value256;
    uint[] public myArray;
    address[] User_addresses;
    address[] GSnetwork_addresses;
    
    
    
    modifier onlyOwner{
        if (msg.sender !=owner) throw;
        _;
    }

    /* This creates an array with all balances */
    mapping (address => uint256) public balanceOfCoin;
    mapping (address => uint256) public GasSold;
    mapping (address => int256) public CreditIssued;
    mapping (address => uint256) public GasCoins;

    
    //mapping (address => mapping (address => uint256)) public allowance;

    /* This generates a public event on the blockchain that will notify clients */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /* This notifies clients about the amount burnt */
    event Burn(address indexed from, uint256 value);

    /* Initializes contract with initial supply tokens to the creator of the contract */
    function MyToken(
        uint256 initialSupply,
        string tokenName,
        uint8 decimalUnits,
        string tokenSymbol
        ) {
        balanceOfCoin[msg.sender] = initialSupply;              // Give the creator all initial tokens
        totalSupply = initialSupply;                        // Update total supply
        name = tokenName;                                   // Set the name for display purposes
        symbol = tokenSymbol;                               // Set the symbol for display purposes
        decimals = decimalUnits;                            // Amount of decimals for display purposes
        //GSnetwork_addresses=[0x4b0897b0513fdc7c541b6d9d7e929c4e5364d2db,0x583031d1113ad414f02576bd6afabfb302140225];
            
        }

    /* Registration of new GS*/
    function new_GS(address newGSAddress_) {
            GSnetwork_addresses.push(newGSAddress_);
        
    }

    //function AddressArray(address[] addresses_) {
    //    for (uint i = 0; i < addresses_.length; i++) {
    //        User_addresses.push(addresses_[i]);
    //    }
    //}

    /* Gives the number of users with an active card */
    function numberOfUsers() constant returns (uint) {
        return User_addresses.length;
    }
    
    function userAddress(uint i) constant returns (address) {
        return User_addresses[i];
    }
    
    function GSAddress(uint i) constant returns (address) {
        return GSnetwork_addresses[i];
    }

    /* Gives the number of gas stations in our network */
    function numberOfGS() constant returns (uint) {
        return GSnetwork_addresses.length;
    }
    

    /* Issue a new card */
    function IssueCard(address _to, uint256 _value){
        value256=int256(_value);
        if (_to == 0x0) throw;                               // Prevent transfer to 0x0 address. Use burn() instead
       // if (balanceOfCoin[msg.sender] < _value) throw;           // Check if the sender has enough
        if (balanceOfCoin[_to] + _value < balanceOfCoin[_to]) throw; // Check for overflows
        CreditIssued[msg.sender] += value256;                     // Mint new coins
        balanceOfCoin[_to] += _value;                            // Add the same to the recipient
        Transfer(msg.sender, _to, _value);                   // Notify anyone listening that this transfer took place
        User_addresses.push(_to);
    }
    
    /* Buy gas in a gas station*/
    function buyGas(uint256 _value, uint256 _priceGas, address _fromGS ) {
       
       
       
       value256=int256(_value);
        if (_fromGS == 0x0) throw;                               // Prevent transfer to 0x0 address. Use burn() instead
       if (balanceOfCoin[msg.sender] < _value) throw;           // Check if the sender has enough
       // if (balanceOfCoin[_to] + _value < balanceOfCoin[_to]) throw; // Check for overflows
        GasSold[_fromGS] += (_value)/_priceGas;
        balanceOfCoin[msg.sender] -= _value;                     // Subtract from the sender
        CreditIssued[_fromGS] -= value256;                     // Subtract from gasstation
        
    }

 /* Settlement (after one month period)*/
    function Settlement(uint256 _value, address _toSettle ) {
       value256=int256(_value);
       if ( _toSettle == 0x0) throw;                               // Prevent transfer to 0x0 address. Use burn() instead
       if (GasCoins[msg.sender] < _value) throw;           // Check if the sender has enough
        if (GasCoins[_toSettle] + _value < GasCoins[_toSettle]) throw; // Check for overflows
       // GasSold[_fromGS] += (_value)/_priceGas;
        GasCoins[msg.sender] -= _value;                     // Subtract from the sender gascoin balance
        CreditIssued[_toSettle] += value256;                     // Add from gasstation
        CreditIssued[msg.sender] -= value256;               // Subtract from the sender credit balance
        
    }
    
    /* Buy Gascoin (necessary for settlement)*/
    
     // Dummie function representing the user buys gascoin from our exchange    
     function BuyGascoin(uint256 _value) {
       //if ( _toSettle == 0x0) throw;                               // Prevent transfer to 0x0 address. Use burn() instead
       //if (GasCoins[msg.sender] < _value) throw;           // Check if the sender has enough
       // if (GasCoins[_toSettle] + _value < GasCoins[_toSettle]) throw; // Check for overflows
       // GasSold[_fromGS] += (_value)/_priceGas;
        GasCoins[msg.sender] += _value;                     // Subtract from the sender gascoin balance
        //CreditIssued[_toSettle] += value256;                     // Add from gasstation
        //CreditIssued[msg.sender] += value256;               // Subtract from the sender credit balance
        
    }

}
