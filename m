Content-Type: multipart/mixed; boundary="===============8237830235527844850=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 2/7] mptcp: update per unacked sequence on pkt
 reception
Date: Wed, 11 Sep 2019 14:55:36 +0200
Message-ID: <0a11e7e0b1d043b43d08a1d4b80c547f3ce5a491.1568206133.git.pabeni@redhat.com>
In-Reply-To: cover.1568206133.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1820

--===============8237830235527844850==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

So that we keep per unacked sequence number consistent; since
we update per msk data, use an atomic64 cmpxcgh() to protect
against concurrent updates from multiple subflows.

Initialize the snd_una at connect()/accept() time.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
v1 -> v2:
 - handle snd_una update conflict

rfc v2 -> v1:
 - do msk-level accounting, using atomic64_t

rfc v1 -> rfc v2:
 - initialize subflow snd_una on subflow connect()/accept()
---
 net/mptcp/options.c  | 45 ++++++++++++++++++++++++++++++++++++++------
 net/mptcp/protocol.c |  2 ++
 net/mptcp/protocol.h |  1 +
 3 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b82557af3fae..c0a74819655d 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -540,6 +540,39 @@ bool mptcp_synack_options(const struct request_sock *r=
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
+void update_una(struct mptcp_sock *msk, struct mptcp_options_received *mp_=
opt)
+{
+	u64 new_snd_una, snd_una, old_snd_una =3D atomic64_read(&msk->snd_una);
+
+	/* avoid ack expansion on update conflict, to reduce the risk of
+	 * wrongly expanding to a future ack sequence number, which is way
+	 * more dangerous than missing an ack
+	 */
+	new_snd_una =3D expand_ack(old_snd_una, mp_opt->data_ack, mp_opt->ack64);
+	while (after64(new_snd_una, old_snd_una)) {
+		snd_una =3D old_snd_una;
+		old_snd_una =3D atomic64_cmpxchg(&msk->snd_una, snd_una,
+					       new_snd_una);
+		if (old_snd_una =3D=3D snd_una)
+			break;
+	}
+}
+
 void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb,
 			    struct tcp_options_received *opt_rx)
 {
@@ -563,6 +596,12 @@ void mptcp_incoming_options(struct sock *sk, struct sk=
_buff *skb,
 	if (!mp_opt->dss)
 		return;
 =

+	/* we can't wait for recvmsg() to update the ack_seq, otherwise
+	 * monodirectional flows will stuck
+	 */
+	if (msk && mp_opt->use_ack)
+		update_una(msk, mp_opt);
+
 	mpext =3D skb_ext_add(skb, SKB_EXT_MPTCP);
 	if (!mpext)
 		return;
@@ -579,12 +618,6 @@ void mptcp_incoming_options(struct sock *sk, struct sk=
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
index 8b0573f1e027..645e19b2936c 100644
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
@@ -828,6 +829,7 @@ void mptcp_finish_connect(struct sock *sk, int mp_capab=
le)
 =

 		crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
 		msk->write_seq =3D subflow->idsn + 1;
+		atomic64_set(&msk->snd_una, msk->write_seq);
 		ack_seq++;
 		msk->ack_seq =3D ack_seq;
 		subflow->map_seq =3D ack_seq;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c0196e4a300e..7a99b49d0224 100644
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


--===============8237830235527844850==--
