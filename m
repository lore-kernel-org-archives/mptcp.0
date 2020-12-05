Content-Type: multipart/mixed; boundary="===============4986273908599954264=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 2/2] selftests: mptcp: add
 testcase for setting the address ID
Date: Sat, 05 Dec 2020 21:37:12 +0800
Message-ID: <b8b773e6b7b8be4b85fdda20c50dc3b2f6c981b7.1607174930.git.geliangtang@gmail.com>
In-Reply-To: 0ba36019c2f3679be412fba62830237c2a40fa66.1607174930.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7061

--===============4986273908599954264==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since the address ID can be set from user-space, some of the tests in
pm_netlink.sh will fail. This patch fixed the failures, and add the testcase
for setting the address ID.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 .../testing/selftests/net/mptcp/pm_netlink.sh | 25 ++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testin=
g/selftests/net/mptcp/pm_netlink.sh
index 15f4f46ca3a9..b8f96d81f942 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -91,7 +91,7 @@ id 3 flags signal,backup 10.0.1.3" "dump addrs after del"
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3
 check "ip netns exec $ns1 ./pm_nl_ctl get 4" "" "duplicate addr"
 =

-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.4 id 10 flags signal
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.4 flags signal
 check "ip netns exec $ns1 ./pm_nl_ctl get 4" "id 4 flags signal 10.0.1.4" =
"id addr increment"
 =

 for i in `seq 5 9`; do
@@ -100,11 +100,12 @@ done
 check "ip netns exec $ns1 ./pm_nl_ctl get 9" "id 9 flags signal 10.0.1.9" =
"hard addr limit"
 check "ip netns exec $ns1 ./pm_nl_ctl get 10" "" "above hard addr limit"
 =

-for i in `seq 9 256`; do
+for i in `seq 9 255`; do
 	ip netns exec $ns1 ./pm_nl_ctl del $i
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.9
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.9 id $((i+1))
 done
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags  10.0.1.1
+id 2 flags  10.0.0.9
 id 3 flags signal,backup 10.0.1.3
 id 4 flags signal 10.0.1.4
 id 5 flags signal 10.0.1.5
@@ -127,4 +128,22 @@ ip netns exec $ns1 ./pm_nl_ctl limits 8 8
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 8
 subflows 8" "set limits"
 =

+ip netns exec $ns1 ./pm_nl_ctl flush
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.2
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 id 100
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.4
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.5 id 254
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.6
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.7
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.8
+check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags  10.0.1.1
+id 2 flags  10.0.1.2
+id 3 flags  10.0.1.7
+id 4 flags  10.0.1.8
+id 100 flags  10.0.1.3
+id 101 flags  10.0.1.4
+id 254 flags  10.0.1.5
+id 255 flags  10.0.1.6" "set ids"
+
 exit $ret
-- =

2.26.2

--===============4986273908599954264==--
