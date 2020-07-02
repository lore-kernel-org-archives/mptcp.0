Content-Type: multipart/mixed; boundary="===============0217219763915846728=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 2/4] mptcp: add msk interations helper
Date: Thu, 02 Jul 2020 13:32:31 +0200
Message-ID: <22884eb6e9e772c004f37d4d90d89f3efe1be1d0.1593689328.git.pabeni@redhat.com>
In-Reply-To: cover.1593689328.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4897

--===============0217219763915846728==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

mptcp_token_iter_next() allow traversing all the MPTCP
sockets inside the token container belonging to the given
network namespace with a quite standard iterator semantic.

It will be used by the next patch, but keep the API generic,
as we plan to use this later for PM's sake.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
v2 -> v3:
 - use a single iterator
 - use rcu protection for traversing the hash
 - acquire a reference to the returned socket
 - use a netns argument
---
 net/mptcp/protocol.h |  2 ++
 net/mptcp/token.c    | 59 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 39bfec3f1586..e5baaef5ec89 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -391,6 +391,8 @@ int mptcp_token_new_connect(struct sock *sk);
 void mptcp_token_accept(struct mptcp_subflow_request_sock *r,
 			struct mptcp_sock *msk);
 struct mptcp_sock *mptcp_token_get_sock(u32 token);
+struct mptcp_sock *mptcp_token_iter_next(const struct net *net, long *s_sl=
ot,
+					 long *s_num);
 void mptcp_token_destroy(struct mptcp_sock *msk);
 =

 void mptcp_crypto_key_sha(u64 key, u32 *token, u64 *idsn);
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 66a4990bd897..6d4fe70f7d30 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -239,6 +239,65 @@ struct mptcp_sock *mptcp_token_get_sock(u32 token)
 	return msk;
 }
 =

+/**
+ * mptcp_token_iter_next - iterate over the token container from given pos
+ * @net: namespace to be iterated
+ * @s_slot: start slot number
+ * @s_num: start number inside the given lock
+ *
+ * This function returns the first mptcp connection structure found inside=
 the
+ * token container starting from the specified position, or NULL.
+ *
+ * On successful iteration, the iterator is move to the next position and =
the
+ * the acquires a reference to the returned socket.
+ */
+struct mptcp_sock *mptcp_token_iter_next(const struct net *net, long *s_sl=
ot,
+					 long *s_num)
+{
+	struct mptcp_sock *ret =3D NULL;
+	struct hlist_nulls_node *pos;
+	int slot, num;
+
+	for (slot =3D *s_slot; slot <=3D token_mask; *s_num =3D 0, slot++) {
+		struct token_bucket *bucket =3D &token_hash[slot];
+		struct sock *sk;
+
+		num =3D 0;
+
+		if (hlist_nulls_empty(&bucket->msk_chain))
+			continue;
+
+		rcu_read_lock();
+		sk_nulls_for_each_rcu(sk, pos, &bucket->msk_chain) {
+			++num;
+			if (!net_eq(sock_net(sk), net))
+				continue;
+
+			if (num <=3D *s_num)
+				continue;
+
+			if (!refcount_inc_not_zero(&sk->sk_refcnt))
+				continue;
+
+			if (!net_eq(sock_net(sk), net)) {
+				sock_put(sk);
+				continue;
+			}
+
+			ret =3D mptcp_sk(sk);
+			rcu_read_unlock();
+			goto out;
+		}
+		rcu_read_unlock();
+	}
+
+out:
+	*s_slot =3D slot;
+	*s_num =3D num;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mptcp_token_iter_next);
+
 /**
  * mptcp_token_destroy_request - remove mptcp connection/token
  * @req: mptcp request socket dropping the token
-- =

2.26.2

--===============0217219763915846728==--
