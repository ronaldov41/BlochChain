

pragma solidity ^0.8.0;

contract SupplyChain {
    struct Product {
        uint256 productId;
        string productName;
        address sender;
        address receiver;
        bool isDelivered;
    }

    mapping(uint256 => Product) public products;
    uint256 public productCount;

    event ProductCreated(uint256 productId, string productName, address sender);
    event ProductDelivered(uint256 productId, address receiver);

    function createProduct(string memory _productName) public {
        uint256 _productId = productCount + 1;
        products[_productId] = Product(_productId, _productName, msg.sender, address(0), false);
        productCount++;

        emit ProductCreated(_productId, _productName, msg.sender);
    }

    function deliverProduct(uint256 _productId, address _receiver) public {
        require(products[_productId].sender == msg.sender, "Only the sender can deliver the product.");
        require(!products[_productId].isDelivered, "Product has already been delivered.");

        products[_productId].receiver = _receiver;
        products[_productId].isDelivered = true;

        emit ProductDelivered(_productId, _receiver);
    }
}
