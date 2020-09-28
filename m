Content-Type: multipart/mixed; boundary="===============8363481220761073184=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 2/2] selftests: mptcp: add
 subflow and ADD_ADDR IPv6 test cases
Date: Mon, 28 Sep 2020 15:46:14 +0800
Message-ID: <c9abf4713c8d05796621b1047cb7a1f88de4a4e4.1601278543.git.geliangtang@gmail.com>
In-Reply-To: cover.1601278543.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6070

--===============8363481220761073184==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added IPv6 support for do_transfer, and the test cases for
both subflow IPv6 and ADD_ADDR IPv6.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 32 ++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index ed03ed503655..678dce6fbf27 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -138,6 +138,12 @@ do_ping()
 	fi
 }
 =

+# $1: IP address
+is_v6()
+{
+	[ -z "${1##*:*}" ]
+}
+
 do_transfer()
 {
 	listener_ns=3D"$1"
@@ -178,7 +184,14 @@ do_transfer()
 		mptcp_connect=3D"./mptcp_connect -r"
 	fi
 =

-	ip netns exec ${listener_ns} $mptcp_connect -t $timeout -l -p $port -s ${=
srv_proto} 0.0.0.0 < "$sin" > "$sout" &
+	local local_addr
+	if is_v6 "${connect_addr}"; then
+		local_addr=3D"::"
+	else
+		local_addr=3D"0.0.0.0"
+	fi
+
+	ip netns exec ${listener_ns} $mptcp_connect -t $timeout -l -p $port -s ${=
srv_proto} ${local_addr} < "$sin" > "$sout" &
 	spid=3D$!
 =

 	sleep 1
@@ -528,6 +541,23 @@ run_tests_slow $ns1 $ns2 10.0.1.1
 chk_join_nr "signal address, ADD_ADDR timeout" 1 1 1
 chk_add_nr 4 0
 =

+# subflow IPv6
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
+run_tests_slow $ns1 $ns2 dead:beef:1::1
+chk_join_nr "single subflow IPv6" 1 1 1
+
+# signal address IPv6
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
+ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+run_tests_slow $ns1 $ns2 dead:beef:1::1
+chk_join_nr "single address IPv6" 1 1 1
+chk_add_nr 1 1
+
 # single subflow, remove
 reset
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-- =

2.17.1

--===============8363481220761073184==--
