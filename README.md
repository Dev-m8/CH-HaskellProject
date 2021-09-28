# ch-challenge
Personal Haskell project to learn JSON parsing in Haskell
Case Study objective:
1. Query API to fetch pricing data for different electronic parts 
2. Combine this pricing data to provide a total price based on the batch size a user requires
Requirements:
1. Implement the following function: quoteBom :: PartsMatchResponse -> [(String, Int)] -> [(String, Maybe (String, Int, Float))]
2. PartsMatchResponse: decoded json 
3. [(String, Int)]: List of part names and quantities 
4. For each given BOM line, quoteBom should return:
- The name of the part.
- The supplier to buy the parts from.
- The total number of parts to purchase.
- The total cost in USD for those parts.
When purchasing parts, you should consider:
Suppliers have an available stock. We can never purchase more stock than a supplier offers!
Suppliers offer price breaks. A price break offers parts at a particular unit price, with a minimum order quantity. As the minimum order quantity increases, the unit price decreases.
