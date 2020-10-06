Content-Type: multipart/mixed; boundary="===============2720718921790202350=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] net: mptcp: make DACK4/DACK8 usage consistent
 among all subflows
Date: Tue, 06 Oct 2020 18:26:17 +0200
Message-ID: <70c96303d6d9931aae1b1028aed016d807df0e20.1602001119.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6229

--===============2720718921790202350==
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
Acked-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---
 net/mptcp/options.c  | 2 +-
 net/mptcp/protocol.h | 2 +-
 net/mptcp/subflow.c  | 3 +--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 888bbbbb3e8a..9d7fa93fe0cf 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -516,7 +516,7 @@ static bool mptcp_established_options_dss(struct sock *=
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
index 20f04ac85409..285dd8b2b43a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -202,6 +202,7 @@ struct mptcp_sock {
 	bool		fully_established;
 	bool		rcv_data_fin;
 	bool		snd_data_fin_enable;
+	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
 	spinlock_t	join_list_lock;
 	struct work_struct work;
 	struct list_head conn_list;
@@ -294,7 +295,6 @@ struct mptcp_subflow_context {
 		backup : 1,
 		data_avail : 1,
 		rx_eof : 1,
-		use_64bit_ack : 1, /* Set when we received a 64-bit DSN */
 		can_ack : 1;	    /* only after processing the remote a key */
 	u32	remote_nonce;
 	u64	thmac;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6f035af1c9d2..91bef7bfffa6 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -769,12 +769,11 @@ static enum mapping_status get_mapping_status(struct =
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

--===============2720718921790202350==--
