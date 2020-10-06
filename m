Content-Type: multipart/mixed; boundary="===============1505226610284867982=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] net: mptcp: make DACK4/DACK8 usage consistent
 among all subflows
Date: Tue, 06 Oct 2020 14:22:08 +0200
Message-ID: <bf93c52f5b3e93ad3ba851dd8d76b80adda95e98.1601986828.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6215

--===============1505226610284867982==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

using packetdrill it's possible to observe the same MPTCP DSN being acked
by different subflows with DACK4 and DACK8. This is in contrast with what
specified in RFC8684 =C2=A73.3.2: if an MPTCP endpoint transmits a 64-bit w=
ide
DSN, it MUST be acknowledged with a 64-bit wide DACK. Fix 'use_64bit_ack'
variable to make it a property of MPTCP sockets, not TCP subflows.

Fixes: a0c1d0eafd1e ("mptcp: Use 32-bit DATA_ACK when possible")
Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---
 net/mptcp/options.c  | 2 +-
 net/mptcp/protocol.h | 2 +-
 net/mptcp/subflow.c  | 3 +--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index fc9e114ba1e3..d601dd1ebe5e 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -517,7 +517,7 @@ static bool mptcp_established_options_dss(struct sock *=
sk, struct sk_buff *skb,
 		return ret;
 	}
 =

-	if (subflow->use_64bit_ack) {
+	if (READ_ONCE(msk->use_64bit_ack)) {
 		ack_size =3D TCPOLEN_MPTCP_DSS_ACK64;
 		opts->ext_copy.data_ack =3D READ_ONCE(msk->ack_seq);
 		opts->ext_copy.ack64 =3D 1;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c131810adf42..746413ab4f18 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -222,6 +222,7 @@ struct mptcp_sock {
 	bool		fully_established;
 	bool		rcv_data_fin;
 	bool		snd_data_fin_enable;
+	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
 	spinlock_t	join_list_lock;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
@@ -352,7 +353,6 @@ struct mptcp_subflow_context {
 		mpc_map : 1,
 		backup : 1,
 		rx_eof : 1,
-		use_64bit_ack : 1, /* Set when we received a 64-bit DSN */
 		can_ack : 1,        /* only after processing the remote a key */
 		disposable : 1;	    /* ctx can be free at ulp release time */
 	enum mptcp_data_avail data_avail;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ae5fa5b3d42b..00040dee323e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -770,12 +770,11 @@ static enum mapping_status get_mapping_status(struct =
sock *ssk,
 	if (!mpext->dsn64) {
 		map_seq =3D expand_seq(subflow->map_seq, subflow->map_data_len,
 				     mpext->data_seq);
-		subflow->use_64bit_ack =3D 0;
 		pr_debug("expanded seq=3D%llu", subflow->map_seq);
 	} else {
 		map_seq =3D mpext->data_seq;
-		subflow->use_64bit_ack =3D 1;
 	}
+	WRITE_ONCE(mptcp_sk(subflow->conn)->use_64bit_ack, !!mpext->dsn64);
 =

 	if (subflow->map_valid) {
 		/* Allow replacing only with an identical map */
-- =

2.26.2

--===============1505226610284867982==--
