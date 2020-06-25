Content-Type: multipart/mixed; boundary="===============5469150229685979046=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/3] mptcp: add msk interations helpers
Date: Thu, 25 Jun 2020 12:22:29 +0200
Message-ID: <6faf67ab1bf1642715060a46f69f16614235fdb8.1593080104.git.pabeni@redhat.com>
In-Reply-To: cover.1593080104.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4798

--===============5469150229685979046==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

mptcp_token_iter_start(), mptcp_token_iter_next() and
mptcp_token_iter_stop() allow traversing all the MPTCP
sockets inside the token container with a quite standard
iterator semantic.

Will be used by the next patch.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.h |  3 ++
 net/mptcp/token.c    | 83 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2c3deede2469..835d7781ecd7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -398,6 +398,9 @@ int mptcp_token_new_connect(struct sock *sk);
 void mptcp_token_accept(struct mptcp_subflow_request_sock *r,
 			struct mptcp_sock *msk);
 struct mptcp_sock *mptcp_token_get_sock(u32 token);
+struct mptcp_sock *mptcp_token_iter_start(long *s_slot, long *s_num);
+struct mptcp_sock *mptcp_token_iter_next(long *s_slot, long *s_num);
+void mptcp_token_iter_stop(long slot);
 void mptcp_token_destroy(struct mptcp_sock *msk);
 =

 void mptcp_crypto_key_sha(u64 key, u32 *token, u64 *idsn);
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 8acea188323c..4b82f87ee157 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -239,6 +239,89 @@ struct mptcp_sock *mptcp_token_get_sock(u32 token)
 	return msk;
 }
 =

+static struct mptcp_sock *__mptcp_token_iter_next(long *s_slot, long *s_nu=
m)
+{
+	struct hlist_nulls_node *pos;
+	int slot, num;
+
+	for (slot =3D *s_slot; slot <=3D token_mask; *s_num =3D 0, slot++) {
+		struct token_bucket *bucket =3D &token_hash[slot];
+		struct sock *sk;
+
+		num =3D 0;
+
+		/* do not acquire the lock if the bucket is empty */
+		if (hlist_nulls_empty(&bucket->msk_chain))
+			continue;
+
+		spin_lock_bh(&bucket->lock);
+		sk_nulls_for_each_rcu(sk, pos, &bucket->msk_chain) {
+			if (num++ !=3D *s_num)
+				continue;
+
+			*s_slot =3D slot;
+			*s_num =3D num;
+			return mptcp_sk(sk);
+		}
+		spin_unlock_bh(&bucket->lock);
+	}
+
+	*s_slot =3D slot;
+	*s_num =3D num;
+	return NULL;
+}
+
+/**
+ * mptcp_token_iter_start - start iterating over the token container
+ * @s_slot: start slot number
+ * @s_num: start number inside the given lock
+ *
+ * This function returns the first mptcp connection structure found inside=
 the
+ * token container starting from the specified position, or NULL.
+ *
+ * On successful iteration, the iterator is move to the next position and =
the
+ * bucket lock is held. Such lock will be released by the next
+ * mptcp_token_iter_next() or by an explict mptcp_token_iter_stop() invoca=
tion.
+ */
+struct mptcp_sock *mptcp_token_iter_start(long *s_slot, long *s_num)
+{
+	return __mptcp_token_iter_next(s_slot, s_num);
+}
+EXPORT_SYMBOL_GPL(mptcp_token_iter_start);
+
+/**
+ * mptcp_token_iter_next - continue iterating over the token container
+ * @s_slot: current slot number
+ * @s_num: current number inside the given lock
+ *
+ * This function releases the lock currently held and returns the next mpt=
cp
+ * connection structure found inside the token container from the specified
+ * position, or NULL when traversing is completed. Callers must use
+ * mptcp_token_iter_start() before invoking this one.
+ *
+ * On successful iteration, the iterator is move to the next position and =
the
+ * bucket lock is held. Such lock will be released by the next
+ * mptcp_token_iter_next() or by an explict mptcp_token_iter_stop() invoca=
tion.
+ */
+struct mptcp_sock *mptcp_token_iter_next(long *s_slot, long *s_num)
+{
+	mptcp_token_iter_stop(*s_slot);
+	return __mptcp_token_iter_next(s_slot, s_num);
+}
+EXPORT_SYMBOL_GPL(mptcp_token_iter_next);
+
+/**
+ * mptcp_token_iter_next - stop iterating over token container
+ * @slot: current slot number
+ */
+void mptcp_token_iter_stop(long slot)
+{
+	struct token_bucket *bucket =3D &token_hash[slot];
+
+	spin_unlock_bh(&bucket->lock);
+}
+EXPORT_SYMBOL_GPL(mptcp_token_iter_stop);
+
 /**
  * mptcp_token_destroy_request - remove mptcp connection/token
  * @req: mptcp request socket dropping the token
-- =

2.26.2

--===============5469150229685979046==--
