Content-Type: multipart/mixed; boundary="===============5830741579462186493=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 4/4] Squash to "selftests: mptcp:
 add testcases for ADD_ADDR with port"
Date: Sun, 08 Nov 2020 22:43:47 +0800
Message-ID: <99aa6841f5fd378b65518716f23457f6b52aea0c.1604845519.git.geliangtang@gmail.com>
In-Reply-To: c4c3b3a3e29e34b67de137edb4b0783f730f190e.1604845519.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6584

--===============5830741579462186493==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here is the new commit message, please update it:
"""
This patch added a new argument for run_tests. When an address with a port
number has been added, the new port number will be passed to this with_port
argument, and then passed to do_transfer.

In do_transfer, if the with_port argument is set, we need to establish a
new connection to listen for the new port. To make sure the peer can
connect with it using the new port.

It checked the ADD_ADDR port related MIB counters in chk_add_nr, and added =
the
testcases for ADD_ADDR with port.

The output looks like this:

 24 signal address with port           syn[ ok ] - synack[ ok ] - ack[ ok ]
                                       add[ ok ] - echo  [ ok ] - pt [ ok ]
                                       syn[ ok ] - synack[ ok ] - ack[ ok ]
 25 subflow and signal with port       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                       add[ ok ] - echo  [ ok ] - pt [ ok ]
                                       syn[ ok ] - synack[ ok ] - ack[ ok ]
 26 remove single address with port    syn[ ok ] - synack[ ok ] - ack[ ok ]
                                       add[ ok ] - echo  [ ok ] - pt [ ok ]
                                       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                       rm [ ok ] - sf    [ ok ]
"""

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 56 ++++++++++++++++---
 1 file changed, 48 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index f224379ba254..8fe184a5ef25 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -437,6 +437,9 @@ chk_add_nr()
 	local add_nr=3D$1
 	local echo_nr=3D$2
 	local port_nr=3D${3:-0}
+	local syn_nr=3D$port_nr
+	local syn_ack_nr=3D$port_nr
+	local ack_nr=3D$port_nr
 	local count
 	local dump_stats
 =

@@ -462,15 +465,52 @@ chk_add_nr()
 		echo -n "[ ok ]"
 	fi
 =

-	echo -n " - pt "
-	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtPortAdd | awk '{prin=
t $2}'`
-	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D "$port_nr" ]; then
-		echo "[fail] got $count ADD_ADDR with port[s] expected $port_nr"
-		ret=3D1
-		dump_stats=3D1
+	if [ $port_nr -gt 0 ]; then
+		echo -n " - pt "
+		count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtPortAdd | awk '{pri=
nt $2}'`
+		[ -z "$count" ] && count=3D0
+		if [ "$count" !=3D "$port_nr" ]; then
+			echo "[fail] got $count ADD_ADDR[s] with port expected $port_nr"
+			ret=3D1
+			dump_stats=3D1
+		else
+			echo "[ ok ]"
+		fi
+
+		printf "%-39s %s" " " "syn"
+		count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtPortSynRx | awk '{p=
rint $2}'`
+		[ -z "$count" ] && count=3D0
+		if [ "$count" !=3D "$syn_nr" ]; then
+			echo "[fail] got $count JOIN[s] syn with port expected $syn_nr"
+			ret=3D1
+			dump_stats=3D1
+		else
+			echo -n "[ ok ]"
+		fi
+
+		echo -n " - synack"
+		count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtPortSynAckRx | awk =
'{print $2}'`
+		[ -z "$count" ] && count=3D0
+		if [ "$count" !=3D "$syn_ack_nr" ]; then
+			echo "[fail] got $count JOIN[s] synack with port expected $syn_ack_nr"
+			ret=3D1
+			dump_stats=3D1
+		else
+			echo -n "[ ok ]"
+		fi
+
+		echo -n " - ack"
+		count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtPortAckRx | awk '{p=
rint $2}'`
+		[ -z "$count" ] && count=3D0
+		if [ "$count" !=3D "$ack_nr" ]; then
+			echo "[fail] got $count JOIN[s] ack with port expected $ack_nr"
+			ret=3D1
+			dump_stats=3D1
+		else
+			echo "[ ok ]"
+		fi
 	else
-		echo "[ ok ]"
+		echo ""
 	fi
 =

 	if [ "${dump_stats}" =3D 1 ]; then
-- =

2.26.2

--===============5830741579462186493==--
