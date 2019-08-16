Content-Type: multipart/mixed; boundary="===============6013350656255716484=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PRE-RFC 2/6] mptcp: update per subflow unacked sequence on
 pkt reception
Date: Fri, 16 Aug 2019 18:48:00 +0200
Message-ID: <0b4ac904ea0ec6c23b3335fce9bcfb367e4b2bc5.1565970525.git.pabeni@redhat.com>
In-Reply-To: cover.1565970525.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1647

--===============6013350656255716484==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

So that we keep per subflow unacked sequence number consistent;
since we update only per socket data, no additional locking is
required.

Subflow and msk unacked seq are updated at different stages
to keep the locking schema simple.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c  | 31 +++++++++++++++++++++++++------
 net/mptcp/protocol.h |  1 +
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 0e7abcea5bae..e0895834ff82 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -524,6 +524,21 @@ bool mptcp_synack_options(const struct request_sock *r=
eq, unsigned int *size,
 	return false;
 }
 =

+static u64 expand_ack(u64 old_ack, u64 cur_ack, bool use_64bit)
+{
+	u32 old_ack32, cur_ack32;
+
+	if (use_64bit)
+		return cur_ack;
+
+	old_ack32 =3D (u32)old_ack;
+	cur_ack32 =3D (u32)cur_ack;
+	cur_ack =3D (old_ack & GENMASK_ULL(63, 32)) + cur_ack32;
+	if (unlikely(before(cur_ack32, old_ack32)))
+		return cur_ack + (1LL<<32);
+	return cur_ack;
+}
+
 void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb,
 			    struct tcp_options_received *opt_rx)
 {
@@ -537,6 +552,16 @@ void mptcp_incoming_options(struct sock *sk, struct sk=
_buff *skb,
 	if (!mp_opt->dss)
 		return;
 =

+	/* we can't wait for recvmsg() to update the ack_seq, otherwise
+	 * monodirectional flows will stuck
+	 */
+	if (mp_opt->use_ack) {
+		struct subflow_context *subflow =3D subflow_ctx(sk);
+
+		subflow->snd_una =3D expand_ack(subflow->snd_una,
+					      mp_opt->data_ack, mp_opt->ack64);
+	}
+
 	mpext =3D skb_ext_add(skb, SKB_EXT_MPTCP);
 	if (!mpext)
 		return;
@@ -553,12 +578,6 @@ void mptcp_incoming_options(struct sock *sk, struct sk=
_buff *skb,
 		mpext->use_checksum =3D mp_opt->use_checksum;
 	}
 =

-	if (mp_opt->use_ack) {
-		mpext->data_ack =3D mp_opt->data_ack;
-		mpext->use_ack =3D 1;
-		mpext->ack64 =3D mp_opt->ack64;
-	}
-
 	mpext->data_fin =3D mp_opt->data_fin;
 =

 	if (msk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9f261ee31917..e37fd4bcd904 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -165,6 +165,7 @@ struct subflow_context {
 	u32	token;
 	u32     rel_write_seq;
 	u64     idsn;
+	u64	snd_una;
 	u64	map_seq;
 	u32	map_subflow_seq;
 	u32	ssn_offset;
-- =

2.20.1


--===============6013350656255716484==--
