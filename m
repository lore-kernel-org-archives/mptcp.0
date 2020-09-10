Content-Type: multipart/mixed; boundary="===============7950489478005173239=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] selftests/mptcp: Better delay & reordering
 configuration
Date: Wed, 09 Sep 2020 22:07:36 -0700
Message-ID: <20200910050736.377-1-cpaasch@apple.com>
X-Status: 
X-Keywords:                  
X-UID: 5781

--===============7950489478005173239==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The delay was intended to be configured to "simulate" a high(er) BDP
link. As such, it needs to be set as part of the loss-configuration and
not as part of the netem reordering configuration.

The reordering-config also requires a delay but that delay is the
reordering-extend. So, a good approach is to set the reordering-extend
as a function of the configured latency. E.g., 25% of the overall
latency.

To speed up the selftests, we limit the delay to 50ms maximum to avoid
having the selftests run for too long.

Finally, the intention of tc_reorder was that when it is unset, the test
picks a random configuration. However, currently it is always initialized
and thus the random config won't be picked up.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/6
Reported-and-reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 .../selftests/net/mptcp/mptcp_connect.sh        | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index 57d75b7f6220..e4df9ba64824 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -14,9 +14,8 @@ capture=3Dfalse
 timeout=3D30
 ipv6=3Dtrue
 ethtool_random_on=3Dtrue
-tc_delay=3D"$((RANDOM%400))"
+tc_delay=3D"$((RANDOM%50))"
 tc_loss=3D$((RANDOM%101))
-tc_reorder=3D""
 testmode=3D""
 sndbuf=3D0
 rcvbuf=3D0
@@ -628,30 +627,32 @@ for sender in "$ns1" "$ns2" "$ns3" "$ns4";do
 	do_ping "$ns4" $sender dead:beef:3::1
 done
 =

-[ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem loss =
random $tc_loss
+[ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem loss =
random $tc_loss delay ${tc_delay}ms
 echo -n "INFO: Using loss of $tc_loss "
 test "$tc_delay" -gt 0 && echo -n "delay $tc_delay ms "
 =

+reorder_delay=3D$(($tc_delay / 4))
+
 if [ -z "${tc_reorder}" ]; then
 	reorder1=3D$((RANDOM%10))
 	reorder1=3D$((100 - reorder1))
 	reorder2=3D$((RANDOM%100))
 =

-	if [ $tc_delay -gt 0 ] && [ $reorder1 -lt 100 ] && [ $reorder2 -gt 0 ]; t=
hen
+	if [ $reorder_delay -gt 0 ] && [ $reorder1 -lt 100 ] && [ $reorder2 -gt 0=
 ]; then
 		tc_reorder=3D"reorder ${reorder1}% ${reorder2}%"
-		echo -n "$tc_reorder "
+		echo -n "$tc_reorder with delay ${reorder_delay}ms "
 	fi
 elif [ "$tc_reorder" =3D "0" ];then
 	tc_reorder=3D""
-elif [ "$tc_delay" -gt 0 ];then
+elif [ "$reorder_delay" -gt 0 ];then
 	# reordering requires some delay
 	tc_reorder=3D"reorder $tc_reorder"
-	echo -n "$tc_reorder "
+	echo -n "$tc_reorder with delay ${reorder_delay}ms "
 fi
 =

 echo "on ns3eth4"
 =

-tc -net "$ns3" qdisc add dev ns3eth4 root netem delay ${tc_delay}ms $tc_re=
order
+tc -net "$ns3" qdisc add dev ns3eth4 root netem delay ${reorder_delay}ms $=
tc_reorder
 =

 for sender in $ns1 $ns2 $ns3 $ns4;do
 	run_tests_lo "$ns1" "$sender" 10.0.1.1 1
-- =

2.23.0

--===============7950489478005173239==--
