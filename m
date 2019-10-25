Content-Type: multipart/mixed; boundary="===============3104230147501081024=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 8/9] selftests: mptcp: remove the redundant test cases
Date: Fri, 25 Oct 2019 14:16:50 +0200
Message-ID: <20191025121651.25946-9-fw@strlen.de>
In-Reply-To: 20191025121651.25946-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2318

--===============3104230147501081024==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Before this change we test all combinations, i.e.
ns1 -> ns{1,2,3,4}
ns2 -> ns{1,2,3,4}
ns3 -> ns{1,2,3,4}
ns4 -> ns{1,2,3,4}

and for each we test all of tcp -> mptcp, mptcp -> tcp and mptcp -> mptcp.

This means we have several redundant cases.
So only do ns1 -> ns1, but not ns2 -> ns2 and so on.

Also, the fallback test case is supposed to verify that we can still
connect, but there is no point in testing this any further.

This change makes it so that we *only* run mptcp -> mptcp tests,
and never repeat the loopback case (sender and receiver in same
netns).  Only exception: ns1->ns1, which also checks that mptcp sender
can connect to tcp receiver, and vice versa.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 49 ++++++++++++++-----
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index 880cefe40c72..499ef8d07dce 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -319,22 +319,39 @@ make_file()
 	echo "Created $name (size $TSIZE) containing data sent by $who"
 }
 =

-run_tests()
+run_tests_lo()
 {
 	listener_ns=3D"$1"
 	connector_ns=3D"$2"
 	connect_addr=3D"$3"
 	local_addr=3D"$4"
+	loopback=3D"$5"
 	lret=3D0
 =

-	for proto in MPTCP TCP;do
-		do_transfer ${listener_ns} ${connector_ns} MPTCP "$proto" ${connect_addr=
} ${local_addr}
-		lret=3D$?
-		if [ $lret -ne 0 ]; then
-			ret=3D$lret
-			return 1
-		fi
-	done
+	# skip if test programs are running inside same netns for subsequent runs.
+	if [ $loopback -eq 0 ] && [ ${listener_ns} =3D ${connector_ns} ]; then
+		ret=3D$lret
+		return 1
+	fi
+
+	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} ${=
local_addr}
+	lret=3D$?
+	if [ $lret -ne 0 ]; then
+		ret=3D$lret
+		return 1
+	fi
+
+	# don't bother testing fallback tcp except for loopback case.
+	if [ ${listener_ns} !=3D ${connector_ns} ]; then
+		return 0
+	fi
+
+	do_transfer ${listener_ns} ${connector_ns} MPTCP TCP ${connect_addr} ${lo=
cal_addr}
+	lret=3D$?
+	if [ $lret -ne 0 ]; then
+		ret=3D$lret
+		return 1
+	fi
 =

 	do_transfer ${listener_ns} ${connector_ns} TCP MPTCP ${connect_addr} ${lo=
cal_addr}
 	lret=3D$?
@@ -346,6 +363,11 @@ run_tests()
 	return 0
 }
 =

+run_tests()
+{
+	run_tests_lo $1 $2 $3 $4 0
+}
+
 make_file "$cin" "client"
 make_file "$sin" "server"
 =

@@ -406,11 +428,16 @@ elif [ $delay -gt 0 ]; then
 fi
 =

 for sender in $ns1 $ns2 $ns3 $ns4;do
-	run_tests "$ns1" $sender 10.0.1.1 0.0.0.0
+	run_tests_lo "$ns1" "$sender" 10.0.1.1 0.0.0.0 1
+	if [ $ret -ne 0 ] ;then
+		echo "FAIL: Could not even run loopback test" 1>&2
+		exit $ret
+	fi
 	if $ipv6;then
-		run_tests "$ns1" $sender dead:beef:1::1 ::
+		run_tests_lo "$ns1" $sender dead:beef:1::1 :: 1
 		if [ $? -ne 0 ] ;then
 			echo "SKIP: IPv6 tests" 2>&1
+			ret=3D0
 			ipv6=3Dfalse
 		fi
 	fi
-- =

2.23.0

--===============3104230147501081024==--
