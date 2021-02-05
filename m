Content-Type: multipart/mixed; boundary="===============7323583191531504801=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 2/2] selftests: mptcp: skip
 MAX_ADDR_ID in IDs assignment testcases
Date: Sat, 06 Feb 2021 00:32:12 +0800
Message-ID: <f7dc4c4c3872449071d34ea92e4c93d66980e81d.1612542562.git.geliangtang@gmail.com>
In-Reply-To: f53c88ba2f0661b7af4fac6e0b6f5b70a686a650.1612542562.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7649

--===============7323583191531504801==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since the MAX_ADDR_ID assignment had been reserved in the address IDs
bitmap, skip it in the pm_netlink.sh testcases.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 .../testing/selftests/net/mptcp/pm_netlink.sh | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testin=
g/selftests/net/mptcp/pm_netlink.sh
index a617e293734c..e3b9a0ddc248 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -105,13 +105,13 @@ for i in `seq 9 256`; do
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.9 id $((i+1))
 done
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags  10.0.1.1
-id 2 flags  10.0.0.9
 id 3 flags signal,backup 10.0.1.3
 id 4 flags signal 10.0.1.4
 id 5 flags signal 10.0.1.5
 id 6 flags signal 10.0.1.6
 id 7 flags signal 10.0.1.7
-id 8 flags signal 10.0.1.8" "id limit"
+id 8 flags signal 10.0.1.8
+id 254 flags  10.0.0.9" "id limit"
 =

 ip netns exec $ns1 ./pm_nl_ctl flush
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
@@ -139,12 +139,12 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.7
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.8
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags  10.0.1.1
 id 2 flags  10.0.1.2
-id 3 flags  10.0.1.7
-id 4 flags  10.0.1.8
+id 3 flags  10.0.1.6
+id 4 flags  10.0.1.7
+id 5 flags  10.0.1.8
 id 100 flags  10.0.1.3
 id 101 flags  10.0.1.4
-id 254 flags  10.0.1.5
-id 255 flags  10.0.1.6" "set ids"
+id 254 flags  10.0.1.5" "set ids"
 =

 ip netns exec $ns1 ./pm_nl_ctl flush
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.1
@@ -156,12 +156,12 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.6
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.7
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.8
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags  10.0.0.1
-id 2 flags  10.0.0.4
-id 3 flags  10.0.0.6
-id 4 flags  10.0.0.7
-id 5 flags  10.0.0.8
+id 2 flags  10.0.0.3
+id 3 flags  10.0.0.4
+id 4 flags  10.0.0.6
+id 5 flags  10.0.0.7
+id 6 flags  10.0.0.8
 id 253 flags  10.0.0.5
-id 254 flags  10.0.0.2
-id 255 flags  10.0.0.3" "wrap-around ids"
+id 254 flags  10.0.0.2" "wrap-around ids"
 =

 exit $ret
-- =

2.29.2

--===============7323583191531504801==--
