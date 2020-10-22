Content-Type: multipart/mixed; boundary="===============7734476452207636791=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next] Squash to "selftests: mptcp: add
 link failure test case"
Date: Thu, 22 Oct 2020 11:47:25 +0800
Message-ID: <10330cb566261a70d0684856a9b468edcd8c4a05.1603337099.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6402

--===============7734476452207636791==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Change run_tests()'s test_linkfail as an optional argument, and set it's
default value to 0.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 34 +++++++++----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index b3fe9b4b0a16..6a4c8109ae49 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -308,7 +308,7 @@ run_tests()
 	listener_ns=3D"$1"
 	connector_ns=3D"$2"
 	connect_addr=3D"$3"
-	test_linkfail=3D"$4"
+	test_linkfail=3D"${4:-0}"
 	rm_nr_ns1=3D"${5:-0}"
 	rm_nr_ns2=3D"${6:-0}"
 	speed=3D"${7:-fast}"
@@ -473,20 +473,20 @@ make_file "$cin" "client" 1
 make_file "$sin" "server" 1
 trap cleanup EXIT
 =

-run_tests $ns1 $ns2 10.0.1.1 0
+run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "no JOIN" "0" "0" "0"
 =

 # subflow limted by client
 reset
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1 0
+run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "single subflow, limited by client" 0 0 0
 =

 # subflow limted by server
 reset
 ip netns exec $ns2 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1 0
+run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "single subflow, limited by server" 1 1 0
 =

 # subflow
@@ -494,7 +494,7 @@ reset
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1 0
+run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "single subflow" 1 1 1
 =

 # multiple subflows
@@ -503,7 +503,7 @@ ip netns exec $ns1 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1 0
+run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "multiple subflows" 2 2 2
 =

 # multiple subflows limited by serverf
@@ -512,13 +512,13 @@ ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1 0
+run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "multiple subflows, limited by server" 2 2 1
 =

 # add_address, unused
 reset
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-run_tests $ns1 $ns2 10.0.1.1 0
+run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "unused signal address" 0 0 0
 chk_add_nr 1 1
 =

@@ -527,7 +527,7 @@ reset
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl limits 1 1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-run_tests $ns1 $ns2 10.0.1.1 0
+run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "signal address" 1 1 1
 chk_add_nr 1 1
 =

@@ -540,7 +540,7 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 ip netns exec $ns1 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl limits 1 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1 0
+run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "subflow and signal" 2 2 2
 chk_add_nr 1 1
 =

@@ -551,7 +551,7 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 ip netns exec $ns2 ./pm_nl_ctl limits 1 3
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1 0
+run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "multiple subflows and signal" 3 3 3
 chk_add_nr 1 1
 =

@@ -632,7 +632,7 @@ reset_with_cookies
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1 0
+run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "single subflow with syn cookies" 1 1 1
 =

 # multiple subflows with syn cookies
@@ -641,7 +641,7 @@ ip netns exec $ns1 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1 0
+run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "multiple subflows with syn cookies" 2 2 2
 =

 # multiple subflows limited by server
@@ -650,7 +650,7 @@ ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1 0
+run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "subflows limited by server w cookies" 2 2 1
 =

 # test signal address with cookies
@@ -658,7 +658,7 @@ reset_with_cookies
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl limits 1 1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-run_tests $ns1 $ns2 10.0.1.1 0
+run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "signal address with syn cookies" 1 1 1
 chk_add_nr 1 1
 =

@@ -668,7 +668,7 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 ip netns exec $ns1 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl limits 1 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1 0
+run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "subflow and signal w cookies" 2 2 2
 chk_add_nr 1 1
 =

@@ -679,7 +679,7 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 ip netns exec $ns2 ./pm_nl_ctl limits 1 3
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1 0
+run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "subflows and signal w. cookies" 3 3 3
 chk_add_nr 1 1
 =

-- =

2.26.2

--===============7734476452207636791==--
