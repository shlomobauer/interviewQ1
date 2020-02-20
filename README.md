This project was created in response to an
interview question: Write a functional
program that reads a csv file that
stores a description of a graph.

The csv file
has three columns, parent node,
child node and child node type.

I am not complaining when I note
that the question
and the context of the question
were underspecified.

There's nothing particularily interesting
in the code.  I am not using hashtables
or anything to improve the performance.
On the other hand, lots of research
oriented engineering first focuses
on having the algorithm that achieves
some goal and then on having that algorithm
run at the appropriate scale.

What follows is the readme I delivered, so
please be forgiving with regard to grammar
as I didn't spend significant time reviewing
and rewriting it.

This is a haskell based project that uses stack.

To build and run this, you need to install stack.

Once you install stack, you run "stack build" from
the top level directory of the project (you don't really
need to be at the top level, but if I assume you
are the top level, I can use names relative to
the top level).

You may have to run "stack init" before you do
anything.  Luckly, stack will help you.

The stack "build" command will load the required
version of haskell and all the necessary modules
you need execute the program that is built.

I created a simple test driver "tdriver.sh"

I didn't make it a stand-alone executeable shell
script, so

sh tdriver.sh

will kick it off.

When you run it, expect to see two errors:

1) a tree test failed (tree2)
2) a PERSON test failed (tree2_PERSON)

I purposely mangled the "good" output and saved as
the "reference" output.

The test driver looks in the "tests" directory.  The tests
are located in a directory call trees (tests/trees).
The reference outputs are located in the control directory.

As you add features, etc., you add the csv file to the
trees directory and results in the control directory.
That way, you have a quick way to do regressions and
drive simple test driven development as you begin
experimenting with more useful algorithms.

I did not make a big loop in the testing so that every
test tree is tested for each node type.  That's easy
enough to add.  I set a time limit of a
few hours for the whole project and I am coming
up to that as I am
writing this.

The code itself is documented.  I don't use any
thing specific to haskell - it's all straight
forward functional programming.  Every function
is tail recursive with provable termination.

I wrote the code in a way that a node can be the child
of multiple parents.  The csv files have the type of
the child attached.  I didn't have time to pull an
already inserted child node (check methods
isMember and retrieve)
and do a semantic check that the type hasn't changed.

Also, the code supports multiple roots -- a node
with no parent.  As written, if there are
multiple roots, I only look at the first one.
I wrote in way that it only takes a few minutes
to wrap it -- but, as you know, many instaces of
a few minutes mean a long time!

Also, if I encounter a type other than ANY, PERSON
or COMPANY, I assume it is ANY.

stack build            --- builds your project
stack exec fc filename --- builds a tree and displays it
stack exec fc filename PERSON -- builds a tree and displays a filtered tree

stack install will place the executeable so that you can execute it without
stack exec.

Lastly, it's system agnostic; you can run stack on a pc and get an
executeable for a pc.  If you run it on a linux box, you
get an executeable that will work on an aws linux machine. And of
course, if you run it on a mac, you'll get a mac executeable.
