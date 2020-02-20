-- copyright Robert T. Bauer 2020
-- 
-- 
module Tree where
import System.Environment
import System.IO
-- import System.Exit

import Data.List.Split

import NodeType
import NodeOps
import Util

-- mkType "PERSON" --> PERSON
mkType :: String -> Nodetype
mkType s
 | s == "PERSON"  = PERSON
 | s == "COMPANY" = COMPANY
 | s == "ANY"     = ANY
 | otherwise      = ANY -- @@TODO:fix to throw error 

-- buildTree
--  take a list of comma separated triples comprised
--   of a parent, child, childtype
--    and build the "tree"
--     returns a list of
--       roots -- list of names of nodes that have no parent
--       nodes --- a list of nodes where each node has the type
--         (String,         -------- the name of the node
--          Nodetype,       -------- type of node (PERSON | COMPANY | ANY)
--          [String]        -------- a possibly empty list of child node names
--         )

buildTree :: [String] -> ([String], [(String,Nodetype,[String])])
buildTree f =
 buildTree1 f (length f) 0 [] []

-- buildTree1 does the work of building the tree, nodelist and roots
-- it is tail recursive and is provably terminating since eventually
-- the line being processed is as large as the number of lines in
-- the file.  comments in the code below overview the build process.
buildTree1 ::
 [String] ->
  Int ->
   Int ->
    [String] ->
     [(String,Nodetype,[String])] ->
      ([String], [(String,Nodetype,[String])])
buildTree1 f l i roots nodes =
 if l == i
 then
  (roots, nodes)
 else
  let s = splitOn "," (f!!i) in -- processing line i of file
   let nkind = mkType (s!!2) in -- kind is s[2], third item
    if isMember (s!!0) nodes    -- have we seen parent?
    then -- yes, add child to parent, add child to nodelist
     let (p,pt,pl) = retrieve (s!!0) nodes in
      let pl' = (s!!1):pl in
       let nodes' = (remove nodes p) in
         let nodes'' = add (p,pt,pl') nodes' in
          let nodes''' = add ((s!!1),nkind,[]) nodes'' in
           buildTree1 f l (i+1) roots nodes'''
    else -- no, add parent to root, add child to parent add both to nodelist
     let p = (s!!0) in
      let pt = ANY in
       let pl = [(s!!1)] in
        let nodes'' = add (p,pt,pl) nodes in
         let roots' = (s!!0):roots in
          let nodes''' = add ((s!!1),nkind,[]) nodes'' in
           buildTree1 f l (i+1) roots' nodes'''

