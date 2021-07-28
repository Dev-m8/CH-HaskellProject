{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( PartsMatchResponse (..)
    , Request (..)
    , Queries (..)
    , Results (..)
    , Item (..)
    , Brand (..)
    , Offer (..)
    , Custom (..)
    , Manufacturer (..)
    , Price (..)
    , Seller (..)
    , quoteBom
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)
import qualified Data.HashMap.Strict as HashMap
import Prelude as P

----Data types to model & parse json---

data PartsMatchResponse = PartsMatchResponse
    { classPartsMatchResponse :: Text
    , msecPartsMatchResponse :: Int
    , requestPartsMatchResponse :: Request
    , resultsPartsMatchResponse :: [Results]
    } deriving (Show)

data Request = Request
    { classRequest :: Text
    , exactOnlyRequest :: Bool
    , queriesRequest :: [Queries]
    } deriving (Show)

data Queries = Queries
    { classQueries :: Text
    , brandQueries :: Maybe Text
    , limitQueries :: Int
    , mpnQueries :: Maybe Text
    , mpnOrSkuQueries :: Maybe Text
    , qQueries :: Text
    , referenceQueries :: Maybe Text
    , sellerQueries :: Maybe Text
    , skuQueries :: Maybe Text
    , startQueries :: Int
    } deriving (Show)

data Results = Results
    { classResults :: Text
    , errorResults :: Maybe Text
    , hitsResults :: Int
    , itemsResults :: [Item]
    , referenceResults :: Maybe Text
    } deriving (Show)

data Item = Item
    { classItem :: Text
    , brandItem :: Brand
    , manufacturerItem :: Manufacturer
    , mpnItem :: Text
    , octopartURLItem :: Text
    , offersItem :: [Offer]
    , redirectedUidsItem :: [Text]
    , uidItem :: Text
    } deriving (Show)

data Brand = Brand
    { classBrand:: Text
    , homepageURLBrand :: Text
    , nameBrand :: Text
    , uidBrand :: Text
    } deriving (Show)

data Manufacturer = Manufacturer
    { classManufacturer:: Text
    , homepageURLManufacturer :: Text
    , nameManufacturer :: Text
    , uidManufacturer :: Text
    } deriving (Show)

data Offer = Offer
    { classOffer :: Text
    , customOffer :: Custom
    , naiveIDOffer :: Text
    , eligibleRegionOffer :: Maybe Text
    , factoryLeadDaysOffer :: Maybe Int
    , factoryOrderMultipleOffer :: Maybe Int
    , inStockQuantityOffer :: Double
    , isAuthorizedOffer :: Bool
    , isRealtimeOffer :: Bool
    , lastUpdatedOffer :: Text
    , moqOffer :: Maybe Int
    , multipackQuantityOffer :: Maybe Text
    , octopartRfqURLOffer :: Maybe Text
    , onOrderEtaOffer :: Maybe Text
    , onOrderQuantityOffer :: Maybe Text
    , orderMultipleOffer :: Maybe Int
    , packagingOffer :: Maybe Text
    , pricesOffer :: HashMap Text [[Price]]
    , productURLOffer :: Text
    , sellerOffer :: Seller
    , skuOffer :: Text
    } deriving (Show)

data Custom = Custom
    { itemIDCustom :: Maybe Text
    , sourceCodeCustom :: Maybe Text
    } deriving (Show)

data Price
    = Quantity Double
    | UnitPrice String
    deriving (Show)

data Seller = Seller
    { classSeller :: Text
    , displayFlagSeller :: Text
    , hasEcommerceSeller :: Bool
    , homepageURLSeller :: Text
    , sellerIDSeller :: Text
    , nameSeller :: String
    , uidSeller :: Text
    } deriving (Show)

instance FromJSON PartsMatchResponse where
    parseJSON (Object v) = PartsMatchResponse
        <$> v .: "__class__"
        <*> v .: "msec"
        <*> v .: "request"
        <*> v .: "results"

instance FromJSON Request where
    parseJSON (Object v) = Request
        <$> v .: "__class__"
        <*> v .: "exact_only"
        <*> v .: "queries"

instance FromJSON Queries where
    parseJSON (Object v) = Queries
        <$> v .: "__class__"
        <*> v .: "brand"
        <*> v .: "limit"
        <*> v .: "mpn"
        <*> v .: "mpn_or_sku"
        <*> v .: "q"
        <*> v .: "reference"
        <*> v .: "seller"
        <*> v .: "sku"
        <*> v .: "start"

instance FromJSON Results where
    parseJSON (Object v) = Results
        <$> v .: "__class__"
        <*> v .: "error"
        <*> v .: "hits"
        <*> v .: "items"
        <*> v .: "reference"

instance FromJSON Item where
    parseJSON (Object v) = Item
        <$> v .: "__class__"
        <*> v .: "brand"
        <*> v .: "manufacturer"
        <*> v .: "mpn"
        <*> v .: "octopart_url"
        <*> v .: "offers"
        <*> v .: "redirected_uids"
        <*> v .: "uid"

instance FromJSON Brand where
    parseJSON (Object v) = Brand
        <$> v .: "__class__"
        <*> v .: "homepage_url"
        <*> v .: "name"
        <*> v .: "uid"

instance FromJSON Manufacturer where
    parseJSON (Object v) = Manufacturer
        <$> v .: "__class__"
        <*> v .: "homepage_url"
        <*> v .: "name"
        <*> v .: "uid"

instance FromJSON Offer where
    parseJSON (Object v) = Offer
        <$> v .: "__class__"
        <*> v .: "_custom"
        <*> v .: "_naive_id"
        <*> v .: "eligible_region"
        <*> v .: "factory_lead_days"
        <*> v .: "factory_order_multiple"
        <*> v .: "in_stock_quantity"
        <*> v .: "is_authorized"
        <*> v .: "is_realtime"
        <*> v .: "last_updated"
        <*> v .: "moq"
        <*> v .: "multipack_quantity"
        <*> v .: "octopart_rfq_url"
        <*> v .: "on_order_eta"
        <*> v .: "on_order_quantity"
        <*> v .: "order_multiple"
        <*> v .: "packaging"
        <*> v .: "prices"
        <*> v .: "product_url"
        <*> v .: "seller"
        <*> v .: "sku"

instance FromJSON Custom where
    parseJSON (Object v) = Custom
        <$> v .:? "item_id"
        <*> v .:? "source_code"

instance FromJSON Seller where
    parseJSON (Object v) = Seller
        <$> v .: "__class__"
        <*> v .: "display_flag"
        <*> v .: "has_ecommerce"
        <*> v .: "homepage_url"
        <*> v .: "id"
        <*> v .: "name"
        <*> v .: "uid"

instance FromJSON Price where
    parseJSON xs@(Number _) = (fmap Quantity . parseJSON) xs
    parseJSON xs@(String _) = (fmap UnitPrice . parseJSON) xs

type QuoteBomResponse = Maybe (String,Double,Double)

----quoteBom will return [(String, Maybe(supplier,quantity,totalcost))] for list of parts & corresponding quantities----

quoteBom partsMatchResponse xs = map (\(x,y) -> (x , (quoteBomSingle (x,y) $ partsMatchResponse))) xs

----quoteBomSingle returns Maybe (supplier,quantity,totalcost) for a single partname & quantity ----

quoteBomSingle :: (Text,Double) -> PartsMatchResponse -> QuoteBomResponse
quoteBomSingle (partname, quantity) partsMatchResponse 
  | P.length supplierlist == 0 = Nothing
  | P.length quantitylist == 0 = Nothing
  | P.length partslist == 0 = Nothing
  | quantity > maxquantity = Nothing
  | otherwise = Just (supplier,maxquantity,totalcost)
    where
      itemslist = (P.map (\x -> itemsResults x) . resultsPartsMatchResponse) $ partsMatchResponse
      partslist =  (P.filter (\x -> mpnItem x == partname) . mconcat) $ itemslist 
      offerslist = (mconcat . fmap (\x -> offersItem x)) $ partslist
      usdoffer = P.filter(\x -> HashMap.member "USD" $ pricesOffer x) $ offerslist
      supplierlist = fmap ( \x -> nameSeller $ sellerOffer x) $ usdoffer  
      quantitylist = fmap (\x -> inStockQuantityOffer x) $ usdoffer
      usdcostlist = (HashMap.toList . pricesOffer . P.head) $ usdoffer
      totalcostlist = fmap (\x -> costOfParts quantity $ snd x) $ usdcostlist
      supplier = P.head $ supplierlist
      totalcost = P.head $ totalcostlist
      maxquantity = P.head $ quantitylist

---getPriceVal extracts double val from Price data type---
getPriceVal :: Price -> Double
getPriceVal (Quantity x) = x
getPriceVal (UnitPrice x) = read x :: Double

---costOfParts computes total cost for given quantity---

costOfParts :: Double -> [[Price]] -> Double
costOfParts  q [] = 0
costOfParts  q pricelist
  | q < 1 = 0
  | otherwise = (quantity * unitPrice)
   where     
       applicableUnitPrices = P.head $ P.filter(\x -> (getPriceVal $ P.head x) >= q) pricelist
       quantity = getPriceVal $ P.head applicableUnitPrices
       unitPrice = getPriceVal $ P.last applicableUnitPrices


{-|---costOfParts computes total cost for given quantity. this was my initial solution based on understanding of the case study 
i.e. incrementing price brackets based on quantity but the function resulted in exception, hence updated it to a more 
straight forward solution where price is chosen based on min quantity

costOfParts :: Double -> [[Price]] -> Double
costOfParts  q [] = 0
costOfParts  q pricelist
  | q < 1 = 0
  | otherwise = (quantity * unitPrice) + costOfParts(q - quantity) pricelist
   where     
       applicableUnitPrices = P.last $ P.filter(\x -> (getPriceVal $ P.head x) <= q) pricelist
       quantity = getPriceVal $ P.head applicableUnitPrices
       unitPrice = getPriceVal $ P.last applicableUnitPrices
-}