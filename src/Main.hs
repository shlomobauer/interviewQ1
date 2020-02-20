-- copyright Robert T. Bauer 2020
-- 
-- 
module Main where
import System.Environment
import System.IO

import NodeType
import NodeOps
import Tree
import Util

--
-- main
--  sets up a line-by-line buffered read (fline0) 
--  calls buildtree which processes fline0 and returns two lists:
--      roots --- a list node names ([String]) that have no parent
--      nodes --- a list of nodes where each node has the type
--        (String,         -------- the name of the node
--         Nodetype,       -------- type of node (PERSON | COMPANY | ANY)
--         [String]        -------- a possibly empty list of child node names
--        )
--
--  calls either displayGraph or displayGraphFilter
--      displayGraph writes to stdout a text based tree 
--      displayGraphFilter writes to stdout a text based tree filtered by type
--
--  usage:
--    fc filename --- reads filename and displays graph
--    fc filename type --- reads filename and displays filtered graph

main = do 
 args <- getArgs

 let fname = args!!0

 hin0 <- openFile fname ReadMode
 inStr0 <- hGetContents hin0
 let fline0 = lines inStr0

 let (roots,nodes) = buildTree fline0

 if (length args) == 1
 then
  displayGraph (roots!!0) nodes
 else
  let ntype = mkType (args!!1) in displayGraphFilter ntype (roots!!0) nodes
 
 hClose hin0
