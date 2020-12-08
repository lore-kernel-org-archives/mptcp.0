Content-Type: multipart/mixed; boundary="===============3465175824590236153=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 2/2] selftests: mptcp: add
 testcases for setting the address ID
Date: Tue, 08 Dec 2020 21:42:30 +0800
Message-ID: <241a4eb995362c6c2d81ab293648125ecd10b83f.1607434427.git.geliangtang@gmail.com>
In-Reply-To: 672af235a6ac38fef0ac1f3117ce888678480321.1607434427.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7076

--===============3465175824590236153==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since the address ID can be set from user-space, some of the tests in
pm_netlink.sh will fail. This patch fixed the failures, and add the
testcases for setting the address ID.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 .../testing/selftests/net/mptcp/pm_netlink.sh | 41 ++++++++++++++++++-
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testin=
g/selftests/net/mptcp/pm_netlink.sh
index 15f4f46ca3a9..a617e293734c 100755
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
@@ -102,9 +102,10 @@ check "ip netns exec $ns1 ./pm_nl_ctl get 10" "" "abov=
e hard addr limit"
 =

 for i in `seq 9 256`; do
 	ip netns exec $ns1 ./pm_nl_ctl del $i
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.9
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.9 id $((i+1))
 done
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags  10.0.1.1
+id 2 flags  10.0.0.9
 id 3 flags signal,backup 10.0.1.3
 id 4 flags signal 10.0.1.4
 id 5 flags signal 10.0.1.5
@@ -127,4 +128,40 @@ ip netns exec $ns1 ./pm_nl_ctl limits 8 8
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
+ip netns exec $ns1 ./pm_nl_ctl flush
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.1
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.2 id 254
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.3
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.4
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.5 id 253
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.6
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.7
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.8
+check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags  10.0.0.1
+id 2 flags  10.0.0.4
+id 3 flags  10.0.0.6
+id 4 flags  10.0.0.7
+id 5 flags  10.0.0.8
+id 253 flags  10.0.0.5
+id 254 flags  10.0.0.2
+id 255 flags  10.0.0.3" "wrap-around ids"
+
 exit $ret
-- =

2.26.2

--===============3465175824590236153==--
