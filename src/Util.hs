-- copyright Robert T. Bauer 2020
--
--
module Util where
import System.IO
import System.Exit

import NodeType
import NodeOps

-- isCompatType only PERSON and COMPANY are incompatible

isCompatType :: Nodetype -> Nodetype -> Bool
isCompatType t1 t2 =
 if t1 == ANY  || t2 == ANY
 then True
 else
  t1 == t2

-- dumb terminal graph
--  display tree on terminal - indent one space to show child nodes
--   is depth first

displayGraph :: String -> [(String,Nodetype,[String])] -> IO()

displayGraph _ [] = do
 return ()

displayGraph n nl = do
 let (hn,ht,hl) = retrieve n nl -- graph head
 putStrLn(hn ++ ":" ++ (show ht))
 displayGraph1 1 hl nl

displayGraph1 :: Int -> [String] -> [(String,Nodetype,[String])] -> IO ()
displayGraph1 _ [] _ = do
 return ()

displayGraph1 i (h:hs) nl  = do
 let (hn, ht, hl) = retrieve h nl
 putStrLn((spaces i) ++ hn ++ ":" ++ (show ht))
 displayGraph1 (i+1) hl nl
 displayGraph1 i hs nl

-- dumb terminal "filtered" graph
--  display tree on terminal - indent one space to show child nodes
--   is depth first
--    stop plunge if encounter a node incompatible with the filter type

displayGraphFilter ::
 Nodetype -> String -> [(String,Nodetype,[String])] -> IO ()

displayGraphFilter _ _ [] = do
 return ()

displayGraphFilter t n nl = do
 let (hn,ht,hl) = retrieve n nl
 if (isCompatType t ht) == True
 then do
  putStrLn(hn ++ ":" ++ (show ht))
  displayGraphFilter1 1 t hl nl
 else do
  return ()

displayGraphFilter1
 ::
   Int
   -> Nodetype
   -> [String]
   -> [(String,Nodetype,[String])]
   -> IO ()
displayGraphFilter1 _ _ [] _ = do
 return ()

displayGraphFilter1 i t (h:hs) nl  = do
 let (hn, ht, hl) = retrieve h nl
 if (isCompatType t ht) == True
 then do
  putStrLn((spaces i) ++ hn ++ ":" ++ (show ht))
  displayGraphFilter1 (i+1) t hl nl
  displayGraphFilter1 i t hs nl
 else do
  return ()
 
-- so we can indent
spaces :: Int -> String
spaces i = let space = " " ++ space in take i space

