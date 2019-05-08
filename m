Content-Type: multipart/mixed; boundary="===============2205515202981361188=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3] mptcp: mptcp option len must be skb independent
Date: Wed, 08 May 2019 17:23:04 +0200
Message-ID: <48a87bc31720fb0c305c22c520048b64047d1fb7.1557328856.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1128

--===============2205515202981361188==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Otherwise the TCP stack can't compute correctly the mss and
that will break segmentation.

Fix the issue reserving space for map if skb is NULL, too.
The map is effectively added according to skb extensions,
if available.
Overall we underestimate the MSS (always accounting for the map), but
we emit the map only if needed.

v2 -> v3:
 - reserve the map space if skb is NULL, as per Mat suggestion

v1 -> v2:
 - rebased on top of current git
 - use slightly different way to compute the opt len

Fixes: 9aaf99d52fc1 ("mptcp: Write MPTCP DSS headers to outgoing data packe=
ts")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
--
Notes:
- this can be squashed into the fixes commit
- the self-test still fails, there are more, unrelated, issues pending
---
 net/mptcp/options.c  | 35 +++++++++++++++++++----------------
 net/mptcp/protocol.h |  4 +++-
 net/mptcp/subflow.c  |  2 ++
 3 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b5f0914d01ba..c71e40f6f06a 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -260,39 +260,42 @@ bool mptcp_established_options(struct sock *sk, unsig=
ned int *size,
 }
 =

 bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
-			unsigned int *size, unsigned int remaining,
-			struct mptcp_out_options *opts)
+				   unsigned int *size, unsigned int remaining,
+				   struct mptcp_out_options *opts)
 {
 	unsigned int dss_size =3D 0;
 	struct mptcp_ext *mpext;
 	unsigned int ack_size;
 =

-	if (!subflow_ctx(sk)->mp_capable || !skb)
+	if (!subflow_ctx(sk)->mp_capable)
 		return false;
 =

-	mpext =3D mptcp_get_ext(skb);
+	mpext =3D skb ? mptcp_get_ext(skb) : NULL;
 =

-	if (mpext && mpext->use_map) {
+	if (!skb || (mpext && mpext->use_map)) {
 		unsigned int map_size;
-		map_size =3D TCPOLEN_MPTCP_DSS_BASE + TCPOLEN_MPTCP_DSS_MAP64;
+		bool use_csum;
 =

-		if (mpext->use_checksum)
+		map_size =3D TCPOLEN_MPTCP_DSS_BASE + TCPOLEN_MPTCP_DSS_MAP64;
+		use_csum =3D subflow_ctx(sk)->use_checksum;
+		if (use_csum)
 			map_size +=3D TCPOLEN_MPTCP_DSS_CHECKSUM;
 =

 		if (map_size <=3D remaining) {
 			remaining -=3D map_size;
 			dss_size =3D map_size;
-
-			opts->ext_copy.data_seq =3D mpext->data_seq;
-			opts->ext_copy.subflow_seq =3D mpext->subflow_seq;
-			opts->ext_copy.data_len =3D mpext->data_len;
-			opts->ext_copy.checksum =3D mpext->checksum;
-			opts->ext_copy.use_map =3D 1;
-			opts->ext_copy.dsn64 =3D mpext->dsn64;
-			opts->ext_copy.use_checksum =3D mpext->use_checksum;
+			if (mpext) {
+				opts->ext_copy.data_seq =3D mpext->data_seq;
+				opts->ext_copy.subflow_seq =3D mpext->subflow_seq;
+				opts->ext_copy.data_len =3D mpext->data_len;
+				opts->ext_copy.checksum =3D mpext->checksum;
+				opts->ext_copy.use_map =3D 1;
+				opts->ext_copy.dsn64 =3D mpext->dsn64;
+				opts->ext_copy.use_checksum =3D use_csum;
+			}
 		} else {
 			opts->ext_copy.use_map =3D 0;
-			WARN(1, "MPTCP: Map dropped");
+			WARN_ONCE(1, "MPTCP: Map dropped");
 		}
 	}
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 870249761c0e..d67c38a2198b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -87,7 +87,9 @@ struct subflow_context {
 		fourth_ack : 1,     /* send initial DSS */
 		version : 4,
 		conn_finished : 1,
-		map_valid : 1;
+		map_valid : 1,
+		use_checksum : 1;
+
 	struct  sock *sk;       /* underlying tcp_sock */
 	struct  sock *conn;     /* parent mptcp_sock */
 	void	(*tcp_sk_data_ready)(struct sock *sk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index b503e13faf96..f88bc48ca997 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -210,6 +210,7 @@ static int subflow_ulp_init(struct sock *sk)
 	tp->is_mptcp =3D 1;
 	icsk->icsk_af_ops =3D &subflow_specific;
 	ctx->tcp_sk_data_ready =3D sk->sk_data_ready;
+	ctx->use_checksum =3D 0;
 	sk->sk_data_ready =3D subflow_data_ready;
 out:
 	return err;
@@ -241,6 +242,7 @@ static void subflow_ulp_clone(const struct request_sock=
 *req,
 	new_ctx->conn =3D NULL;
 	new_ctx->conn_finished =3D 1;
 	new_ctx->tcp_sk_data_ready =3D old_ctx->tcp_sk_data_ready;
+	new_ctx->use_checksum =3D old_ctx->use_checksum;
 =

 	if (subflow_req->mp_capable) {
 		new_ctx->mp_capable =3D 1;
-- =

2.20.1


--===============2205515202981361188==--
