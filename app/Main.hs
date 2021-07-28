module Main where

import Lib
import qualified Data.HashMap.Strict as HashMap
import Prelude as P
import Data.Text as T
import Data.Aeson
import Data.Text.IO as TIO
import Data.ByteString.Lazy as B
import Data.ByteString.Lazy.Char8 as BC

main :: IO ()
main = do
  jsonData <- B.readFile "octopart.json"
  let Just partsMatchResponse = decode jsonData 
  P.putStrLn "BOM 1"
  P.putStrLn "-----"
  mapM_ print $ quoteBom partsMatchResponse
    [ ("GRM21BR71A106KE51K", 10) ]
  P.putStrLn ""
  P.putStrLn "BOM 2"
  P.putStrLn "-----"
  mapM_ print $ quoteBom partsMatchResponse
    [ ("MPR031EPR2", 1) ]
  P.putStrLn ""
  P.putStrLn "BOM 3"
  P.putStrLn "-----"
  mapM_ print $ quoteBom partsMatchResponse
    [ ("GRM21BR71A106KE51K", 98)
    , ("06035C220JAT2A", 49)
    , ("MBT3904DW1T1G", 49)
    , ("TPS62065DSGR", 98)
    , ("CRCW060310M0FKEBC", 49)
    , ("RC1206FR-07100RL", 196)
    ]

{--Results
dev$ stack exec ch-challenge-exe
BOM 1
-----
("GRM21BR71A106KE51K",Just ("Quest",5037.0,11.34))

BOM 2
-----
("MPR031EPR2",Just ("Win Source Electronics",900.0,53.849999999999994))

BOM 3
-----
("GRM21BR71A106KE51K",Just ("Quest",5037.0,178.875))
("06035C220JAT2A",Just ("Digi-Key",122832.0,2.1399999999999997))
("MBT3904DW1T1G",Just ("Future Electronics",3000.0,915.0))
("TPS62065DSGR",Nothing)
("CRCW060310M0FKEBC",Nothing)
("RC1206FR-07100RL",Nothing)
--Results--}