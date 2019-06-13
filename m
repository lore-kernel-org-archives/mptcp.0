Content-Type: multipart/mixed; boundary="===============1679663862398335446=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] squash-to: mptcp: Implement MPTCP receive path
Date: Thu, 13 Jun 2019 17:25:46 +0200
Message-ID: <3e99fc39ff57c97d9596c627c85a15f14b86560f.1560439435.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1362

--===============1679663862398335446==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The usage of an atomic type for such field does not really protect
vs concurrent read/modify/update cycles, and makes the code less
readable, move to plain u64.

We already held the required lock in the relevant context

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c  | 2 +-
 net/mptcp/protocol.c | 8 ++++----
 net/mptcp/protocol.h | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index d285a33cd480..92cb0cb48f0c 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -319,7 +319,7 @@ static bool mptcp_established_options_dss(struct sock *=
sk, struct sk_buff *skb,
 =

 		msk =3D mptcp_sk(subflow_ctx(sk)->conn);
 		if (msk) {
-			opts->ext_copy.data_ack =3D atomic64_read(&msk->ack_seq);
+			opts->ext_copy.data_ack =3D msk->ack_seq;
 		} else {
 			crypto_key_sha1(subflow_ctx(sk)->remote_key, NULL,
 					&opts->ext_copy.data_ack);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 941988387ea0..91e913636c45 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -435,7 +435,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 		}
 =

 		ssn =3D tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
-		old_ack =3D atomic64_read(&msk->ack_seq);
+		old_ack =3D msk->ack_seq;
 =

 		if (unlikely(before(ssn, subflow->map_subflow_seq))) {
 			/* Mapping covers data later in the subflow stream,
@@ -501,7 +501,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 		ack_seq =3D get_mapped_dsn(subflow);
 =

 		if (before64(old_ack, ack_seq))
-			atomic64_set(&msk->ack_seq, ack_seq);
+			msk->ack_seq =3D ack_seq;
 =

 		if (!before(tcp_sk(ssk)->copied_seq - subflow->ssn_offset,
 			    subflow->map_subflow_seq + subflow->map_data_len)) {
@@ -635,7 +635,7 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 		crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
 		msk->write_seq =3D subflow->idsn + 1;
 		ack_seq++;
-		atomic64_set(&msk->ack_seq, ack_seq);
+		msk->ack_seq =3D ack_seq;
 		subflow->map_seq =3D ack_seq;
 		subflow->map_subflow_seq =3D 1;
 		subflow->rel_write_seq =3D 1;
@@ -760,7 +760,7 @@ void mptcp_finish_connect(struct sock *sk, int mp_capab=
le)
 		crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
 		msk->write_seq =3D subflow->idsn + 1;
 		ack_seq++;
-		atomic64_set(&msk->ack_seq, ack_seq);
+		msk->ack_seq =3D ack_seq;
 		subflow->map_seq =3D ack_seq;
 		subflow->map_subflow_seq =3D 1;
 		subflow->rel_write_seq =3D 1;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a4f0e7d3bd62..4bc1a094aad6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -43,7 +43,7 @@ struct mptcp_sock {
 	u64		local_key;
 	u64		remote_key;
 	u64		write_seq;
-	atomic64_t	ack_seq;
+	u64		ack_seq;
 	u32		token;
 	struct list_head conn_list;
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
-- =

2.20.1


--===============1679663862398335446==--
