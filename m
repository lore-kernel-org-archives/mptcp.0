Content-Type: multipart/mixed; boundary="===============2247070914952611103=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v1 3/3] Squash-to: "selftests: add test-cases for
 MPTCP MP_JOIN"
Date: Mon, 16 Mar 2020 16:09:45 +0100
Message-ID: <78a193c9d8dcc2f27ec3022c4527effadefcda9c.1584370791.git.pabeni@redhat.com>
In-Reply-To: cover.1584370791.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3952

--===============2247070914952611103==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ADD_ADDR opt may be delayed till the very end of [short] MPTCP
connection, so ADD_ADDR related self-tests can sometimes fail.

Leave some additional time before closing the connection,
to catch this late messages

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 11 +++++++++--
 tools/testing/selftests/net/mptcp/mptcp_join.sh   |  8 ++++++--
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/test=
ing/selftests/net/mptcp/mptcp_connect.c
index da991a78db6b..cedee5b952ba 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -268,7 +268,7 @@ static size_t do_rnd_write(const int fd, char *buf, con=
st size_t len)
 =

 	/* let the join handshake complete, before going on */
 	if (cfg_join && first) {
-		sleep(1);
+		usleep(200000);
 		first =3D false;
 	}
 =

@@ -396,8 +396,11 @@ static int copyfd_io_poll(int infd, int peerfd, int ou=
tfd)
 					break;
 =

 				/* ... but we still receive.
-				 * Close our write side.
+				 * Close our write side, ev. give some time
+				 * for address notification
 				 */
+				if (cfg_join)
+					usleep(400000);
 				shutdown(peerfd, SHUT_WR);
 			} else {
 				if (errno =3D=3D EINTR)
@@ -414,6 +417,10 @@ static int copyfd_io_poll(int infd, int peerfd, int ou=
tfd)
 		}
 	}
 =

+	/* leave some time for late join/announce */
+	if (cfg_join)
+		usleep(400000);
+
 	close(peerfd);
 	return 0;
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 6c0c1a4a86ab..dd42c2f692d0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -33,8 +33,9 @@ init()
 	# ns1eth1    ns2eth1
 	# ns1eth2    ns2eth2
 	# ns1eth3    ns2eth3
+	# ns1eth4    ns2eth4
 =

-	for i in `seq 1 3`; do
+	for i in `seq 1 4`; do
 		ip link add ns1eth$i netns "$ns1" type veth peer name ns2eth$i netns "$n=
s2"
 		ip -net "$ns1" addr add 10.0.$i.1/24 dev ns1eth$i
 		ip -net "$ns1" addr add dead:beef:$i::1/64 dev ns1eth$i nodad
@@ -332,6 +333,9 @@ run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "signal address" 1 1 1
 =

 # accept and use add_addr with an additional subflow
+# note: signal address in server ns and local addresses in client ns must
+# belong to different subnets or one of the listed local address could be
+# used for 'add_addr' subflow
 reset
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 ip netns exec $ns1 ./pm_nl_ctl limits 0 2
@@ -345,8 +349,8 @@ reset
 ip netns exec $ns1 ./pm_nl_ctl limits 0 3
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 ip netns exec $ns2 ./pm_nl_ctl limits 1 3
-ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
 run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "multiple subflows and signal" 3 3 3
 =

-- =

2.21.1

--===============2247070914952611103==--
