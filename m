Content-Type: multipart/mixed; boundary="===============3522744375475697752=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 3/3] selftests: mptcp: add
 ADD_ADDR mibs check function
Date: Thu, 13 Aug 2020 18:59:39 +0800
Message-ID: <32bd04c956950391ad5f6238789a109aa6a1df4c.1597316052.git.geliangtang@gmail.com>
In-Reply-To: cover.1597316052.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5553

--===============3522744375475697752==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added the ADD_ADDR related mibs counter check function
chk_add_nr(). This function check both ADD_ADDR and ADD_ADDR with
echo flag.

The output looks like this:

 07 unused signal address             syn[ ok ] - synack[ ok ] - ack[ ok ]
                                      add[ ok ] - echo  [ ok ]
 08 signal address                    syn[ ok ] - synack[ ok ] - ack[ ok ]
                                      add[ ok ] - echo  [ ok ]
 09 subflow and signal                syn[ ok ] - synack[ ok ] - ack[ ok ]
                                      add[ ok ] - echo  [ ok ]
 10 multiple subflows and signal      syn[ ok ] - synack[ ok ] - ack[ ok ]
                                      add[ ok ] - echo  [ ok ]
 11 remove subflow and signal         syn[ ok ] - synack[ ok ] - ack[ ok ]
                                      add[ ok ] - echo  [ ok ]

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 68c4243e2b22..4c46307c607b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -281,6 +281,43 @@ chk_join_nr()
 	fi
 }
 =

+chk_add_nr()
+{
+	local add_nr=3D$1
+	local echo_nr=3D$2
+	local count
+	local dump_stats
+
+	printf "%-39s %s" " " "add"
+	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtAddAddr | awk '{prin=
t $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$add_nr" ]; then
+		echo "[fail] got $count JOIN[s] ack expected $add_nr"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	echo -n " - echo "
+	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtEchoAdd | awk '{prin=
t $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$echo_nr" ]; then
+		echo "[fail] got $count JOIN[s] ack expected $echo_nr"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo " [ ok ]"
+	fi
+
+	if [ "${dump_stats}" =3D 1 ]; then
+		echo Server ns stats
+		ip netns exec $ns1 nstat -as | grep MPTcp
+		echo Client ns stats
+		ip netns exec $ns2 nstat -as | grep MPTcp
+	fi
+}
+
 chk_rm_nr()
 {
 	local rm_nr_server=3D$1
@@ -374,6 +411,7 @@ reset
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "unused signal address" 0 0 0
+chk_add_nr 1 1
 =

 # accept and use add_addr
 reset
@@ -382,6 +420,7 @@ ip netns exec $ns2 ./pm_nl_ctl limits 1 1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "signal address" 1 1 1
+chk_add_nr 1 1
 =

 # accept and use add_addr with an additional subflow
 # note: signal address in server ns and local addresses in client ns must
@@ -394,6 +433,7 @@ ip netns exec $ns2 ./pm_nl_ctl limits 1 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "subflow and signal" 2 2 2
+chk_add_nr 1 1
 =

 # accept and use add_addr with additional subflows
 reset
@@ -404,6 +444,7 @@ ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subfl=
ow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
 run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "multiple subflows and signal" 3 3 3
+chk_add_nr 1 1
 =

 # remove subflow and signal
 reset
@@ -428,6 +469,7 @@ do_remove_addr()
 }
 do_transfer $ns1 $ns2 MPTCP MPTCP 10.0.1.1 do_remove_addr
 chk_join_nr "remove subflow and signal" 2 2 1
+chk_add_nr 1 1
 chk_rm_nr 1 1
 =

 # single subflow, syncookies
@@ -463,6 +505,7 @@ ip netns exec $ns2 ./pm_nl_ctl limits 1 1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "signal address with syn cookies" 1 1 1
+chk_add_nr 1 1
 =

 # test cookie with subflow and signal
 reset_with_cookies
@@ -472,6 +515,7 @@ ip netns exec $ns2 ./pm_nl_ctl limits 1 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "subflow and signal w cookies" 2 2 2
+chk_add_nr 1 1
 =

 # accept and use add_addr with additional subflows
 reset_with_cookies
@@ -482,5 +526,6 @@ ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subfl=
ow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
 run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "subflows and signal w. cookies" 3 3 3
+chk_add_nr 1 1
 =

 exit $ret
-- =

2.17.1

--===============3522744375475697752==--
