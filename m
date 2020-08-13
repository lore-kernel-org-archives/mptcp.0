Content-Type: multipart/mixed; boundary="===============2866192111407166894=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v7 mptcp-next 5/5] selftests: mptcp: add
 RM_ADDR mib check function
Date: Thu, 13 Aug 2020 18:37:19 +0800
Message-ID: <51332154000875f58ab2a6685765689c5e7f43ba.1597314634.git.geliangtang@gmail.com>
In-Reply-To: cover.1597314634.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5549

--===============2866192111407166894==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added the RM_ADDR mib counter check function chk_rm_nr(). This
function check this mib both on server side and client side.

The output looks like this:

 11 remove subflow and signal        syn[ ok ] - synack[ ok ] - ack[ ok ]
                                     rm [ ok ] - rm    [ ok ]

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 3c26f98f3cac..68c4243e2b22 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -281,6 +281,43 @@ chk_join_nr()
 	fi
 }
 =

+chk_rm_nr()
+{
+	local rm_nr_server=3D$1
+	local rm_nr_client=3D$2
+	local count
+	local dump_stats
+
+	printf "%-39s %s" " " "rm "
+	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtRmAddr | awk '{print=
 $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$rm_nr_server" ]; then
+		echo "[fail] got $count JOIN[s] ack expected $add_nr"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	echo -n " - rm "
+	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtRmAddr | awk '{print=
 $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$rm_nr_client" ]; then
+		echo "[fail] got $count JOIN[s] ack expected $echo_nr"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo "   [ ok ]"
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
@@ -391,6 +428,7 @@ do_remove_addr()
 }
 do_transfer $ns1 $ns2 MPTCP MPTCP 10.0.1.1 do_remove_addr
 chk_join_nr "remove subflow and signal" 2 2 1
+chk_rm_nr 1 1
 =

 # single subflow, syncookies
 reset_with_cookies
-- =

2.17.1

--===============2866192111407166894==--
