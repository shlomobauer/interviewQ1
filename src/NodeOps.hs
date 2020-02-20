-- copyright Robert T. Bauer 2020
--
--
module NodeOps where
import System.IO
import System.Exit

import NodeType

-- I am consistent in notation below.
-- I did not want to spend time on creating names (see README.md)
-- So, whenever you see a triple (n,t,l) 
--   (n,t,l) is
--     (String, -- node name
--      Nodetype, -- node type
--       [String]) -- list of child node names

-- is nodeName in nodelist
isMember :: Eq n => n -> [(n,t,l)] -> Bool

isMember name [] = False
isMember name ((n,t,l):ns) =
 if name == n then True else isMember name ns

-- retrieve a node in nodelist
retrieve :: Eq n => n -> [(n,t,l)] -> (n,t,l)

retrieve n ((n',t,l):nl) =
 if n == n' then (n',t,l) else retrieve n nl

-- replace a node in nodelist
replace ::
 [(String,Nodetype,[String])] ->
  (String,Nodetype,[String]) ->
   [(String,Nodetype,[String])]

replace nl (n, t, l) =
 (n,t,l):[(n',t',l') | (n',t',l') <- nl, n' /= n]

-- remove a node in nodelist
remove ::
 [(String, Nodetype, [String])] ->
  String ->
   [(String, Nodetype, [String])]

remove nl n =
 [(n',t',l') | (n',t',l') <- nl, n' /= n]

-- insert a node in nodelist
add ::
 (String, Nodetype, [String]) ->
  [(String,Nodetype,[String])] ->
   [(String,Nodetype,[String])]

add n nl  = n:nl
