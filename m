Content-Type: multipart/mixed; boundary="===============4284446905934745258=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next v6 4/5] selftests: mptcp: add IPv4-mapped
 IPv6 testcases
Date: Thu, 14 Jan 2021 18:29:25 +0100
Message-ID: <20210114172926.2563610-5-matthieu.baerts@tessares.net>
In-Reply-To: 20210114172926.2563610-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7379

--===============4284446905934745258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

Here, we make sure we support IPv4-mapped in IPv6 addresses in different
contexts:

- a v4-mapped address is received by the PM and can be used as v4.
- a v4 address is received by the PM and can be used even with a v4
  mapped socket.

We also make sure we don't try to establish subflows between v4 and v6
addresses, e.g. if a real v6 address ends with a valid v4 address.

Co-developed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---

Notes:
    v4 -> v5:
    - shorter names to keep alignment
    - new test: existing v6 (in addition to non existing v6 with valid v4
      at the end)
    - @Geliang: I didn't use the "slow" mode because I don't need to wait
      for multiple subflows but also because I hit some timeout with kernel
      debug config, see the next commit.

 .../testing/selftests/net/mptcp/mptcp_join.sh | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index f74cd993b168..be34b9ccbd20 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -790,6 +790,81 @@ chk_join_nr "remove subflow and signal IPv6" 2 2 2
 chk_add_nr 1 1
 chk_rm_nr 1 1
 =

+# subflow IPv4-mapped to IPv4-mapped
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl add "::ffff:10.0.3.2" flags subflow
+run_tests $ns1 $ns2 "::ffff:10.0.1.1"
+chk_join_nr "single subflow IPv4-mapped" 1 1 1
+
+# signal address IPv4-mapped with IPv4-mapped sk
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+ip netns exec $ns1 ./pm_nl_ctl add "::ffff:10.0.2.1" flags signal
+run_tests $ns1 $ns2 "::ffff:10.0.1.1"
+chk_join_nr "signal address IPv4-mapped" 1 1 1
+chk_add_nr 1 1
+
+# subflow v4-map-v6
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+run_tests $ns1 $ns2 "::ffff:10.0.1.1"
+chk_join_nr "single subflow v4-map-v6" 1 1 1
+
+# signal address v4-map-v6
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+run_tests $ns1 $ns2 "::ffff:10.0.1.1"
+chk_join_nr "signal address v4-map-v6" 1 1 1
+chk_add_nr 1 1
+
+# subflow v6-map-v4
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl add "::ffff:10.0.3.2" flags subflow
+run_tests $ns1 $ns2 10.0.1.1
+chk_join_nr "single subflow v6-map-v4" 1 1 1
+
+# signal address v6-map-v4
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+ip netns exec $ns1 ./pm_nl_ctl add "::ffff:10.0.2.1" flags signal
+run_tests $ns1 $ns2 10.0.1.1
+chk_join_nr "signal address v6-map-v4" 1 1 1
+chk_add_nr 1 1
+
+# no subflow IPv6 to v4 address
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl add dead:beef:2::2 flags subflow
+run_tests $ns1 $ns2 10.0.1.1
+chk_join_nr "no JOIN with diff families v4-v6" 0 0 0
+
+# no subflow IPv6 to v4 address even if v6 has a valid v4 at the end
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl add dead:beef:2::10.0.3.2 flags subflow
+run_tests $ns1 $ns2 10.0.1.1
+chk_join_nr "no JOIN with diff families v4-v6-2" 0 0 0
+
+# no subflow IPv4 to v6 address, no need to slow down too then
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+run_tests $ns1 $ns2 dead:beef:1::1
+chk_join_nr "no JOIN with diff families v6-v4" 0 0 0
+
 # single subflow, backup
 reset
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-- =

2.29.2

--===============4284446905934745258==--
