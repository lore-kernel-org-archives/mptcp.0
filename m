Content-Type: multipart/mixed; boundary="===============4109342337336818335=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 3/3] selftests: mptcp: add
 ADD_ADDR mibs check function
Date: Wed, 19 Aug 2020 14:19:36 +0800
Message-ID: <6a2a98ba3836bfb162cb4f6ef7f251fabd9613b4.1597817375.git.geliangtang@gmail.com>
In-Reply-To: cover.1597817375.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5576

--===============4109342337336818335==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added the ADD_ADDR related mibs counter check function
chk_add_nr(). This function check both ADD_ADDR and ADD_ADDR with
echo flag.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index f39c1129ce5f..a36896b90f52 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -276,6 +276,43 @@ chk_join_nr()
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
 sin=3D$(mktemp)
 sout=3D$(mktemp)
 cin=3D$(mktemp)
@@ -332,6 +369,7 @@ reset
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "unused signal address" 0 0 0
+chk_add_nr 0 0
 =

 # accept and use add_addr
 reset
@@ -340,6 +378,7 @@ ip netns exec $ns2 ./pm_nl_ctl limits 1 1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "signal address" 1 1 1
+chk_add_nr 1 1
 =

 # accept and use add_addr with an additional subflow
 # note: signal address in server ns and local addresses in client ns must
@@ -352,6 +391,7 @@ ip netns exec $ns2 ./pm_nl_ctl limits 1 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "subflow and signal" 2 2 2
+chk_add_nr 1 1
 =

 # accept and use add_addr with additional subflows
 reset
@@ -362,6 +402,7 @@ ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subfl=
ow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
 run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "multiple subflows and signal" 3 3 3
+chk_add_nr 1 1
 =

 # single subflow, syncookies
 reset_with_cookies
@@ -396,6 +437,7 @@ ip netns exec $ns2 ./pm_nl_ctl limits 1 1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "signal address with syn cookies" 1 1 1
+chk_add_nr 1 1
 =

 # test cookie with subflow and signal
 reset_with_cookies
@@ -405,6 +447,7 @@ ip netns exec $ns2 ./pm_nl_ctl limits 1 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "subflow and signal w cookies" 2 2 2
+chk_add_nr 1 1
 =

 # accept and use add_addr with additional subflows
 reset_with_cookies
@@ -415,5 +458,6 @@ ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subfl=
ow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
 run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "subflows and signal w. cookies" 3 3 3
+chk_add_nr 1 1
 =

 exit $ret
-- =

2.17.1

--===============4109342337336818335==--
