#!/bin/sh

# Last update: Sat Apr 23 09:43:17 JST 2022

cat "$@" \
| egrep '^[^ ]*202[0-9]-[0-1][0-9]-[0-3][0-9]' \
| sed  \
  -e 's/^[-]//g' \
  -e 's/(うち死亡\([0-9][0-9]*\)))/QYQ\1Q(0)/' \
  -e 's/(うち死亡/QXQ/' \
  -e 's/^\(202[0-9]-[0-1][0-9]-[0-3][0-9]\)  */\1Q/' \
  -e 's/ (+\([0-9][0-9]*\))/Q\1/' \
  -e 's/ (治療中/Q/' \
  -e 's/ 退院等/Q/' \
  -e 's/(退院/Q/' \
  -e 's/,死亡/Q/' \
  -e 's/  *※/P-P※/' \
  -e 's/  *(※/P-P(※/' \
  -e 's/  *(注/P-P(注/' \
  -e 's/（石川県の発表/P-P（石川県の発表/' \
  -e 's/（※/P-P（※/' \
  -e 's/,その他\([0-9][0-9]*\))) */Q\1/' \
  -e 's/(他に取下げ等累計\([0-9][0-9]*\))/Q\1/' \
  -e 's/P/	/g' \
  -e 's/Q/	/g' \
| awk '{if (NF==8){printf "%s\t-\t-\n",$0} else if (NF==9){printf "%s\t-\n",$0} else {print $0}}'\
| awk -F'\t' '{
  if ($6~"X") {printf "%s\t%s\t%s\t%s\t%s\t(%d)\t%s\t%s\t%s\t%s\n",$1,$2,$3,$4,$5,$5-$7-$8,$7,$8,$9,$10}
  else if ($6~"Y") {printf "%s\t%s\t%s\t%s\t%s\t(%d)\t%s\t%s\t%s\t%s\n",$1,$2,$3,$4,$5,$5-$7-$8,$7,$8,$9,$10}
  else {print $0}
  }'

exit
