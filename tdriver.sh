echo "test driver - build and filter trees"

echo "start, `date`"
echo

rm -rf tests/output
rm -f tests/results
mkdir tests/output

echo "begin trees, `date`"
for i in `ls -1 tests/trees | sort -n -k1.5`
do
 ii=${i%.*} # remove extension if any

 stack exec fc tests/trees/$i > tests/output/$ii

 diff tests/output/$ii tests/control/$ii > /dev/null 2>&1
 retc=$?

 anyfail=0
 if [ "$retc" = "1" ]; then
  anyfail=1
  echo "failed: tests/output/$ii" >> tests/results
 else
  echo "passed: tests/output/$ii" >> tests/results
 fi
done

if [ "$anyfail" = "1" ]; then
 echo "A tree test failed. Check tests/results"
else
 echo "All tree tests passed."
fi

echo "end trees, `date`"
echo

echo "begin PERSON filter, `date`"
for i in `ls -1 tests/trees | sort -n -k1.5`
do
 ii=${i%.*} # remove extension if any

 stack exec fc tests/trees/$i PERSON > tests/output/${ii}_PERSON

 diff tests/output/${ii}_PERSON tests/control/${ii}_PERSON > /dev/null 2>&1
 retc=$?

 anyfail=0
 if [ "$retc" = "1" ]; then
  anyfail=1
  echo "failed: tests/output/${ii}_PERSON" >> tests/results
 else
  echo "passed: tests/output/${ii}_PERSON" >> tests/results
 fi
done

if [ "$anyfail" = "1" ]; then
 echo "A PERSON test failed. Check tests/results"
else
 echo "All PERSON tests passed."
fi

echo "end PERSON filter, `date`"
echo

echo "done, `date`"

exit 0
