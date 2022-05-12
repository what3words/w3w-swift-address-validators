# <img valign='top' src="https://what3words.com/assets/images/w3w_square_red.png" width="32" height="32" alt="what3words">&nbsp;w3w-swift-w3w-swift-address-validators

Overview
--------

This package contains code for accessing various address validation services.  The services currently supported are:

* Swift Complete - [https://www.swiftcomplete.com](https://www.loqate.com/)
* Data 8 - [https://www.data-8.co.uk](https://www.loqate.com/)
* Loqate - [https://www.loqate.com/](https://www.loqate.com/)

The library here provides a unified interface for these services via a Swift protocol called `W3WAddressValidatorProtocol`.

#### Interface

`name`: the name of the service (ie: Loqate, Data8)

`supportsSubitemCounts`: indicates if the service will provide sub item counts

`search(near: completion:)`: returns address nodes near a three word address

`list(from: completion:)`: given a node returned from a previous call, get any child nodes

`info(for: completion:)`: get detailed info for a particular leaf node returned from a previous call

#### Address Tree

The three functions `search`, `list`, and `info` provide access to a hierarchical tree of address data.

The tree is made of up nodes derived from `W3WValidatorNode`.  These are: `W3WValidatorNodeLeaf`, `W3WValidatorNodeLeafInfo`, `W3WValidatorNodeList`, `W3WValidatorNodeSuggestion`.

Typically, you start with by calling `search` with a three word address and it returns a list of nodes near to that address.  You then use that list to present options to your user.  Once a user chooses one of those nodes, you take that node and call `list` to get sub nodes in the tree.  Present those to your user and so on.

The leaf nodes are `W3WValidatorNodeLeaf`, but these can be used to call `info(for: W3WStreetAddressNodeLeaf, completion: @escaping (W3WStreetAddressNodeLeafInfo?, W3WAddressFinderError?) -> ())` which will return to you a `W3WValidatorNodeLeafInfo`.

**Important**: This `info()` call is the call that most services count towards a quota.

#### Retrieving a street address

`W3WValidatorNodeLeafInfo` contain an address member variable that conforms to `W3WStreetAddressProtocol`, called `address`.

Right now there are two objects that conform: `W3WStreetAddressUK` and `W3WStreetAddressGeneric`.  As more countries are added to the systems more will be available.

You can check for the exact type of object it is and access the fields precisely, or just access data using the protocol's `values` array.

Services
--------

### Data 8

```
let data8 = W3WAddressValidatorData8(key: "YourData8Key")
```

### Loqate

```
let w3w = What3WordsV3(apiKey: "YourWhat3WordsApiKey")
let loqate = W3WAddressValidatorLoqate(w3w: w3w, key: "YouLoqateApiKey")
```

### Swift Complete

```
let swiftComplete = W3WAddressValidatorSwiftComplete(key: swiftCompleteApiKey)
```

Protocol definition
-------------------

All the services above conform to `W3WAddressValidatorProtocol` which is defined as follows:

#### W3WAddressValidatorProtocol

```Swift
public protocol W3WAddressValidatorProtocol {
  
  /// the name of the service
  var name: String { get }
  
  /// indicates if the service can provide sub item counts
  var supportsSubitemCounts: Bool { get }
  
  /// searches near a three word address
  /// - parameter near: the three word address to search near
  /// - parameter completion: called with new nodes when they are available from the call
  func search(near: String, completion: @escaping  ([W3WStreetAddressNode], W3WAddressFinderError?) -> ())
  
  /// given a node returned from a previous call, get any child nodes
  /// - parameter from: the node to search with
  /// - parameter completion: called with child tree nodes when they are retrieved
  func list(from: W3WStreetAddressNodeList, completion: @escaping  ([W3WStreetAddressNode], W3WAddressFinderError?) -> ())
  
  
  /// get detailed info for a particular leaf node returned from a previous call
  /// - parameter for: the node to get details for
  /// - parameter completion: called with a detailed address result
  func info(for: W3WStreetAddressNodeLeaf, completion: @escaping (W3WStreetAddressNodeLeafInfo?, W3WAddressFinderError?) -> ())
}
```

