Content-Type: multipart/mixed; boundary="===============2971029251962395848=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 4/4] selftests: mptcp: timeout
 testcases for multi addresses
Date: Tue, 23 Feb 2021 12:29:58 +0800
Message-ID: <257134434a85e50d6166ded59dfeb515be270f88.1614053997.git.geliangtang@gmail.com>
In-Reply-To: d49a86c112c21d1ea98e0e9572cbda03fad6d8d0.1614053997.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7911

--===============2971029251962395848==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added the timeout testcases for multi addresses, valid and
invalid.

These testcases need to transmit 8 ADD_ADDRs, so add a new speed level
'least' to set 10 to mptcp_connect to slow down the transmitting process.
The original speed level 'slow' still uses 50.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 26 +++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 5d7f940bceac..62f4fb046645 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -239,8 +239,10 @@ do_transfer()
 =

 	if [ $speed =3D "fast" ]; then
 		mptcp_connect=3D"./mptcp_connect -j"
-	else
-		mptcp_connect=3D"./mptcp_connect -r"
+	elif [ $speed =3D "slow" ]; then
+		mptcp_connect=3D"./mptcp_connect -r 50"
+	elif [ $speed =3D "least" ]; then
+		mptcp_connect=3D"./mptcp_connect -r 10"
 	fi
 =

 	local local_addr
@@ -845,6 +847,26 @@ add_addr_timeout_tests()
 	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
 	chk_join_nr "signal address, ADD_ADDR6 timeout" 1 1 1
 	chk_add_nr 4 0
+
+	# signal addresses timeout
+	reset_with_add_addr_timeout
+	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 least
+	chk_join_nr "signal addresses, ADD_ADDR timeout" 2 2 2
+	chk_add_nr 8 0
+
+	# signal invalid addresses timeout
+	reset_with_add_addr_timeout
+	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 least
+	chk_join_nr "invalid address, ADD_ADDR timeout" 1 1 1
+	chk_add_nr 8 0
 }
 =

 remove_tests()
-- =

2.29.2

--===============2971029251962395848==--
