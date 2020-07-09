Content-Type: multipart/mixed; boundary="===============1000525870628176192=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 2/4] mptcp: add msk interations helper
Date: Thu, 09 Jul 2020 15:12:40 +0200
Message-ID: <8ba0e08df6dfc0d41ec19c11c47f0e66696d8f07.1594292774.git.pabeni@redhat.com>
In-Reply-To: cover.1594292774.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4957

--===============1000525870628176192==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

mptcp_token_iter_next() allow traversing all the MPTCP
sockets inside the token container belonging to the given
network namespace with a quite standard iterator semantic.

That will be used by the next patch, but keep the API generic,
as we plan to use this later for PM's sake.

Additionally export mptcp_token_get_sock(), as it also
will be used by the diag module.

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.h |  2 ++
 net/mptcp/token.c    | 61 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 1 deletion(-)

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
index 66a4990bd897..7d8106026081 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -238,6 +238,66 @@ struct mptcp_sock *mptcp_token_get_sock(u32 token)
 	rcu_read_unlock();
 	return msk;
 }
+EXPORT_SYMBOL_GPL(mptcp_token_get_sock);
+
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
 =

 /**
  * mptcp_token_destroy_request - remove mptcp connection/token
@@ -312,7 +372,6 @@ void __init mptcp_token_init(void)
 EXPORT_SYMBOL_GPL(mptcp_token_new_request);
 EXPORT_SYMBOL_GPL(mptcp_token_new_connect);
 EXPORT_SYMBOL_GPL(mptcp_token_accept);
-EXPORT_SYMBOL_GPL(mptcp_token_get_sock);
 EXPORT_SYMBOL_GPL(mptcp_token_destroy_request);
 EXPORT_SYMBOL_GPL(mptcp_token_destroy);
 #endif
-- =

2.26.2

--===============1000525870628176192==--
