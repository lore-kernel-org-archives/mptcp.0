Content-Type: multipart/mixed; boundary="===============8961924741708694262=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next] selftests/mptcp: Better delay & reordering
 configuration
Date: Mon, 27 Jul 2020 16:47:59 -0700
Message-ID: <20200727234759.25705-1-cpaasch@apple.com>
X-Status: 
X-Keywords:                  
X-UID: 5335

--===============8961924741708694262==
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

Finally, the intention of tc_reorder was that when it is unset, the test
picks a random configuration. However, currently it is always initialized
and thus the random config won't be picked up.

Github-issue: https://github.com/multipath-tcp/mptcp_net-next/issues/6

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---

Notes:
    Admittedly, two changes here in this patch (delay-fix and unitializing
    tc_reorder). If you want, I can split them but I thought that's overkil=
l for
    a selftest-patch.

 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index 6260520674d0..d29d189d1ae5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -16,7 +16,6 @@ ipv6=3Dtrue
 ethtool_random_on=3Dtrue
 tc_delay=3D"$((RANDOM%400))"
 tc_loss=3D$((RANDOM%101))
-tc_reorder=3D""
 testmode=3D""
 sndbuf=3D0
 rcvbuf=3D0
@@ -631,22 +630,24 @@ for sender in "$ns1" "$ns2" "$ns3" "$ns4";do
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

+reorder_delay=3D`expr $tc_delay / 4`
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
 		echo -n "$tc_reorder "
 	fi
 elif [ "$tc_reorder" =3D "0" ];then
 	tc_reorder=3D""
-elif [ "$tc_delay" -gt 0 ];then
+elif [ "$reorder_delay" -gt 0 ];then
 	# reordering requires some delay
 	tc_reorder=3D"reorder $tc_reorder"
 	echo -n "$tc_reorder "
@@ -654,7 +655,7 @@ fi
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

--===============8961924741708694262==--
