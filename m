Content-Type: multipart/mixed; boundary="===============7581848098158175298=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 9/9] selftests: mptcp: add command line options to
 override netem/ethtool settings
Date: Fri, 25 Oct 2019 14:16:51 +0200
Message-ID: <20191025121651.25946-10-fw@strlen.de>
In-Reply-To: 20191025121651.25946-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2319

--===============7581848098158175298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows to run the tests with a more consistent/reproduceable setup,
e.g:
./mptcp_connect.sh -d 120 -l 0.2 -r "50% 1% gap 5"
./mptcp_connect.sh -d 250 -e tso -e gso -e gro -l 0.01

default is to randomize the settings.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 127 +++++++++++++-----
 1 file changed, 97 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index 499ef8d07dce..2cd62b041e70 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -1,6 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 =

+optstring=3D"d:e:l:r:h6"
 ret=3D0
 sin=3D""
 sout=3D""
@@ -10,6 +11,62 @@ ksft_skip=3D4
 capture=3D0
 timeout=3D30
 ipv6=3Dfalse
+ethtool_random_on=3Dtrue
+tc_delay=3D"$((RANDOM%400))"
+tc_loss=3D$((RANDOM%101))
+tc_reorder=3D""
+
+if [ $tc_loss -eq 100 ];then
+	tc_loss=3D1%
+elif [ $tc_loss -ge 10 ]; then
+	tc_loss=3D0.$tc_loss%
+elif [ $tc_loss -ge 1 ]; then
+	tc_loss=3D0.0$tc_loss%
+else
+	tc_loss=3D""
+fi
+
+usage() {
+	echo "Usage: $0 [ -a ]"
+	echo -e "\t-d: tc/netem delay in milliseconds, e.g. \"-d 10\" (default ra=
ndom)"
+	echo -e "\t-l: tc/netem loss percentage, e.g. \"-l 0.02\" (default random=
)"
+	echo -e "\t-r: tc/netem reorder mode, e.g. \"-r 25% 50% gap 5\", use "-r =
0" to disable reordering (default random)"
+	echo -e "\t-e: ethtool features to disable, e.g.: \"-e tso -e gso\" (defa=
ult: randomly disable any of tso/gso/gro)"
+}
+
+while getopts "$optstring" option;do
+	case "$option" in
+	"h")
+		usage $0
+		exit 0
+		;;
+	"d")
+		if [ $OPTARG -ge 0 ];then
+			tc_delay=3D"$OPTARG"
+		else
+			echo "-d requires numeric argument, got \"$OPTARG\"" 1>&2
+			exit 1
+		fi
+		;;
+	"e")
+		ethtool_args=3D"$ethtool_args $OPTARG off"
+		ethtool_random_on=3Dfalse
+		;;
+	"l")
+		tc_loss=3D"$OPTARG"
+		;;
+	"r")
+		tc_reorder=3D"$OPTARG"
+		;;
+	"6")
+		ipv6=3Dtrue
+		;;
+	"?")
+		usage $0
+		exit 1
+		;;
+	esac
+done
 =

 sec=3D$(date +%s)
 rndh=3D$(printf %x $sec)-$(mktemp -u XXXXXX)
@@ -108,28 +165,38 @@ ip -net "$ns4" route add default via 10.0.3.2
 $ipv6 && ip -net "$ns4" route add default via dead:beef:3::2
 =

 set_ethtool_flags() {
-	ns=3D$1
-	dev=3D$2
+	local ns=3D"$1"
+	local dev=3D"$2"
+	local flags=3D"$3"
+
+	ip netns exec $ns ethtool -K $dev $flags 2>/dev/null
+	[ $? -eq 0 ] && echo "INFO: set $ns dev $dev: ethtool -K $flags"
+}
 =

-	r=3D$RANDOM
+set_random_ethtool_flags() {
+	local flags=3D""
+	local r=3D$RANDOM
 =

 	pick1=3D$((r & 1))
 	pick2=3D$((r & 2))
 	pick3=3D$((r & 4))
 =

-	flags=3D""
 	[ $pick1 -ne 0 ] && flags=3D"tso off"
 	[ $pick2 -ne 0 ] && flags=3D"$flags gso off"
 	[ $pick3 -ne 0 ] && flags=3D"$flags gro off"
 =

 	[ -z "$flags" ] && return
 =

-	ip netns exec $ns ethtool -K $dev $flags 2>/dev/null
-	[ $? -eq 0 ] && echo "INFO: set $ns dev $dev: ethtool -K $flags"
+	set_ethtool_flags "$1" "$2" "$flags"
 }
 =

-set_ethtool_flags "$ns3" ns3eth2
-set_ethtool_flags "$ns4" ns4eth3
+if $ethtool_random_on;then
+	set_random_ethtool_flags "$ns3" ns3eth2
+	set_random_ethtool_flags "$ns4" ns4eth3
+else
+	set_ethtool_flags "$ns3" ns3eth2 "$ethtool_args"
+	set_ethtool_flags "$ns4" ns4eth3 "$ethtool_args"
+fi
 =

 print_file_err()
 {
@@ -402,31 +469,31 @@ for sender in "$ns1" "$ns2" "$ns3" "$ns4";do
 	$ipv6 && do_ping "$ns4" $sender dead:beef:3::1
 done
 =

-loss=3D$((RANDOM%101))
-if [ $loss -eq 100 ] ;then
-	loss=3D1%
-	tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $loss
-elif [ $loss -ge 10 ]; then
-	loss=3D0.$loss%
-	tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $loss
-elif [ $loss -ge 1 ]; then
-	loss=3D0.0$loss%
-	tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $loss
-fi
+[ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem loss =
random $tc_loss
+echo -n "INFO: Using loss of $tc_loss "
+test "$tc_delay" -gt 0 && echo -n "delay $tc_delay ms "
 =

-delay=3D$((RANDOM%400))
-reorder1=3D$((RANDOM%10))
-reorder1=3D$((100 - reorder1))
-reorder2=3D$((RANDOM%100))
-
-if [ $reorder1 -lt 100 ] && [ $reorder2 -gt 0 ]; then
-  tc -net "$ns3" qdisc add dev ns3eth4 root netem delay ${delay}ms reorder=
 ${reorder1}% ${reorder2}%
-  echo "INFO: Using loss of $loss, delay $delay ms, reorder: $reorder1, $r=
eorder2 on ns3eth4"
-elif [ $delay -gt 0 ]; then
-  tc -net "$ns3" qdisc add dev ns3eth4 root netem delay ${delay}ms
-  echo "INFO: Using loss of $loss, delay $delay ms on ns3eth4"
+if [ -z "${tc_reorder}" ]; then
+	reorder1=3D$((RANDOM%10))
+	reorder1=3D$((100 - reorder1))
+	reorder2=3D$((RANDOM%100))
+
+	if [ $tc_delay -gt 0 ] && [ $reorder1 -lt 100 ] && [ $reorder2 -gt 0 ]; t=
hen
+		tc_reorder=3D"reorder ${reorder1}% ${reorder2}%"
+		echo -n "$tc_reorder "
+	fi
+elif [ "$tc_reorder" =3D "0" ];then
+	tc_reorder=3D""
+elif [ "$tc_delay" -gt 0 ];then
+	# reordering requires some delay
+	tc_reorder=3D"reorder $tc_reorder"
+	echo -n "$tc_reorder "
 fi
 =

+echo "on ns3eth4"
+
+tc -net "$ns3" qdisc add dev ns3eth4 root netem delay ${tc_delay}ms $tc_re=
order
+
 for sender in $ns1 $ns2 $ns3 $ns4;do
 	run_tests_lo "$ns1" "$sender" 10.0.1.1 0.0.0.0 1
 	if [ $ret -ne 0 ] ;then
-- =

2.23.0

--===============7581848098158175298==--
