Content-Type: multipart/mixed; boundary="===============9157352683758691547=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/7] mptcp: update per unacked sequence on pkt
 reception
Date: Fri, 30 Aug 2019 17:03:57 +0200
Message-ID: <f76a221454e358abb9fdb29f7396638b1ca8b149.1567177394.git.pabeni@redhat.com>
In-Reply-To: cover.1567177393.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1773

--===============9157352683758691547==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

So that we keep per unacked sequence number consistent; since
we update per msk data, use an atomic64 cmpxcgh() to protect
against concurrent updates from multiple subflows.

Initialize the snd_una at connect()/accept() time.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
rfc v2 -> v1:
 - do msk-level accounting, using atomic64_t

rfc v1 -> rfc v2:
 - initialize subflow snd_una on subflow connect()/accept()
---
 net/mptcp/options.c  | 39 +++++++++++++++++++++++++++++++++------
 net/mptcp/protocol.c |  2 ++
 net/mptcp/protocol.h |  1 +
 3 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index be7afa5aac6a..854dc050c1da 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -524,6 +524,26 @@ bool mptcp_synack_options(const struct request_sock *r=
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
+		return cur_ack + (1LL << 32);
+	return cur_ack;
+}
+
+void update_una(struct mptcp_sock *msk, u64 old_una, u64 new_una)
+{
+	atomic64_cmpxchg(&msk->snd_una, old_una, new_una);
+}
+
 void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb,
 			    struct tcp_options_received *opt_rx)
 {
@@ -547,6 +567,19 @@ void mptcp_incoming_options(struct sock *sk, struct sk=
_buff *skb,
 	if (!mp_opt->dss)
 		return;
 =

+	/* we can't wait for recvmsg() to update the ack_seq, otherwise
+	 * monodirectional flows will stuck
+	 */
+	if (msk && mp_opt->use_ack) {
+		u64 snd_una =3D atomic64_read(&msk->snd_una);
+		u64 new_snd_una;
+
+		new_snd_una =3D expand_ack(snd_una, mp_opt->data_ack,
+					 mp_opt->ack64);
+		if (after64(new_snd_una, snd_una))
+			update_una(msk, snd_una, new_snd_una);
+	}
+
 	mpext =3D skb_ext_add(skb, SKB_EXT_MPTCP);
 	if (!mpext)
 		return;
@@ -563,12 +596,6 @@ void mptcp_incoming_options(struct sock *sk, struct sk=
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
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 15bd54f43d4b..52e39fbb217d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -696,6 +696,7 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 =

 		crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
 		msk->write_seq =3D subflow->idsn + 1;
+		atomic64_set(&msk->snd_una, msk->write_seq);
 		ack_seq++;
 		msk->ack_seq =3D ack_seq;
 		subflow->map_seq =3D ack_seq;
@@ -833,6 +834,7 @@ void mptcp_finish_connect(struct sock *sk, int mp_capab=
le)
 =

 		crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
 		msk->write_seq =3D subflow->idsn + 1;
+		atomic64_set(&msk->snd_una, msk->write_seq);
 		ack_seq++;
 		msk->ack_seq =3D ack_seq;
 		subflow->map_seq =3D ack_seq;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8c36a379f67d..e7c29007f0fe 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -119,6 +119,7 @@ struct mptcp_sock {
 	u64		remote_key;
 	u64		write_seq;
 	u64		ack_seq;
+	atomic64_t	snd_una;
 	u32		token;
 	unsigned long	flags;
 	u16		dport;
-- =

2.21.0


--===============9157352683758691547==--
