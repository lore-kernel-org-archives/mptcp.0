Content-Type: multipart/mixed; boundary="===============0050466180066812562=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: mptcp option len must be skb independent
Date: Fri, 19 Apr 2019 23:12:33 +0200
Message-ID: <2bf408db21be8e7c6a403c013b0f964855a3e215.1555708182.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1081

--===============0050466180066812562==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Otherwise the TCP stack can't compute correctly the mss and
that will break segmentation. Note that we can't observe the
issue with the self-test until we allow skb collapsing -
loopback default MTU is pretty big and we dont build big enogh
skb otherwise.

Fix the issue caching the use_map/use_checksum flags also at the
substream ctx level, and using them in tcp_established_options().
While at it, replace a bunch of magic numbers with the appropriate
constants.

Fixes: a0e41f8a56d6 ("mptcp: Write MPTCP DSS headers to outgoing data packe=
ts")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
--
Notes:
- I'm ok with swashing this commit into the referenced one
- this fixes the data corruption I was observing on the xmit path
  refactor patchset

---
 include/net/mptcp.h   |  2 ++
 net/ipv4/tcp_output.c | 18 ++++++++----------
 net/mptcp/subflow.c   |  4 ++++
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 0c0839d9ab38..5658b85da7ca 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -128,6 +128,8 @@ struct subflow_context {
 	bool	fourth_ack;	// send initial DSS
 	bool	conn_finished;
 	bool	map_valid;
+	bool	use_map;
+	bool	use_checksum;
 	struct  sock *sk;       /* underlying tcp_sock */
 	struct  sock *conn;     /* parent mptcp_sock */
 	void	(*tcp_sk_data_ready)(struct sock *sk);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 6798b1e91140..4e5dab801bed 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -822,19 +822,17 @@ static unsigned int tcp_established_options(struct so=
ck *sk, struct sk_buff *skb
 				opts->mptcp.rcvr_key =3D remote_key;
 				size +=3D TCPOLEN_MPTCP_MPC_ACK;
 			}
-		} else if (subflow_ctx(sk)->mp_capable && skb) {
+		} else if (subflow_ctx(sk)->mp_capable) {
+			unsigned int ack_size =3D TCPOLEN_MPTCP_DSS_ACK64;
 			unsigned int dss_size =3D 0;
-			unsigned int ack_size =3D 8;
-			struct mptcp_ext *mpext;
 			u16 suboptions =3D 0;
 =

-			mpext =3D mptcp_get_ext(skb);
+			if (subflow_ctx(sk)->use_map) {
+				unsigned int map_size =3D TCPOLEN_MPTCP_DSS_BASE +
+							TCPOLEN_MPTCP_DSS_MAP64;
 =

-			if (mpext && mpext->use_map) {
-				unsigned int map_size =3D 18;
-
-				if (mpext->use_checksum)
-					map_size +=3D 2;
+				if (subflow_ctx(sk)->use_checksum)
+					map_size +=3D TCPOLEN_MPTCP_DSS_CHECKSUM;
 =

 				if (map_size <=3D remaining) {
 					remaining -=3D map_size;
@@ -849,7 +847,7 @@ static unsigned int tcp_established_options(struct sock=
 *sk, struct sk_buff *skb
 			 * overhead if mapping not populated
 			 */
 			if (dss_size =3D=3D 0)
-				ack_size +=3D 4;
+				ack_size +=3D TCPOLEN_MPTCP_DSS_BASE;
 =

 			if (ack_size <=3D remaining) {
 				dss_size +=3D ack_size;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 077d5baae270..3c6988cb3126 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -130,6 +130,8 @@ static struct subflow_context *clone_ctx(const struct s=
ock *sk, struct sock *chi
 	child_ctx->sk =3D child;
 	child_ctx->conn =3D NULL;
 	child_ctx->tcp_sk_data_ready =3D ctx->tcp_sk_data_ready;
+	child_ctx->use_map =3D ctx->use_map;
+	child_ctx->use_checksum =3D ctx->use_checksum;
 =

 	return child_ctx;
 }
@@ -237,6 +239,8 @@ static int subflow_init(struct sock *sk)
 	tsk->is_mptcp =3D 1;
 	icsk->icsk_af_ops =3D &subflow_specific;
 	ctx->tcp_sk_data_ready =3D sk->sk_data_ready;
+	ctx->use_map =3D true;
+	ctx->use_checksum =3D false;
 	sk->sk_data_ready =3D subflow_data_ready;
 out:
 	return err;
-- =

2.20.1


--===============0050466180066812562==--
