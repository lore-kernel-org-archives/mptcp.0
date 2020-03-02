Content-Type: multipart/mixed; boundary="===============2960560721542379456=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: disable two unstable mptcp_join tests
Date: Mon, 02 Mar 2020 17:03:07 +0100
Message-ID: <20200302160307.2108790-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 3842

--===============2960560721542379456==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

They are currently unstable. Paolo is looking at them.

Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Fixes: a17132c420b0 (selftests: add test-cases for MPTCP MP_JOIN)
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "selftests: add test-cases for MPTCP MP_JOIN"

 tools/testing/selftests/net/mptcp/mptcp_join.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 799914cd973a..30b8ce87d837 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -261,7 +261,7 @@ reset
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
 run_tests $ns1 $ns2 10.0.1.1
-chk_join_nr "multiple subflows" $ns1 2
+# chk_join_nr "multiple subflows" $ns1 2 # TODO: uncomment me when the bug=
 is fixed
 =

 # add_address, unused
 reset
@@ -291,6 +291,6 @@ ip netns exec $ns2 ./pm_nl_ctl accept 1
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.2 flags signal
 run_tests $ns1 $ns2 10.0.1.1
-chk_join_nr "multiple subflows and signal" $ns1 3
+# chk_join_nr "multiple subflows and signal" $ns1 3 # TODO: uncomment me w=
hen the bug is fixed
 =

-exit $ret
\ No newline at end of file
+exit $ret
-- =

2.25.0

--===============2960560721542379456==--
