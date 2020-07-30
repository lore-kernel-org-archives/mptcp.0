Content-Type: multipart/mixed; boundary="===============6065447190365750076=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC v3 08/10] mptcp: enable JOIN requests even if
 cookies are in use
Date: Thu, 30 Jul 2020 02:12:39 +0200
Message-ID: <20200730001241.3037-9-fw@strlen.de>
In-Reply-To: 20200730001241.3037-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 5380

--===============6065447190365750076==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

JOIN requests do not work in syncookie mode -- for HMAC validation, the
peers nonce and the mptcp token (to obtain the desired connection socket
the join is for) are required, but this information is only present in the
initial syn.

So either we need to drop all JOIN requests once a listening socket enters
syncookie mode, or we need to store enough state to reconstruct the request
socket later.

This allows the subflow request initialisation function to store the
request socket even when syncookies are used, i.e. the listener
socket queue will grow past its upper limit.

Following restrictions apply:
1. The (32bit) token contained in the MP_JOIN SYN packet returns
   a valid parent connection.
2. The parent connection can accept one more subflow.
3. Only 1024 requests can be remembered at most.

An alternate approach would be to "cancel" syn-cookie mode and force
MP_JOIN to always use a syn queue entry.
However, doing so brings the backlog over the configured limit.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/ipv4/syncookies.c  |   6 +++
 net/mptcp/Makefile     |   1 +
 net/mptcp/protocol.h   |  18 +++++++
 net/mptcp/subflow.c    |  14 +++++
 net/mptcp/syncookies.c | 118 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 157 insertions(+)
 create mode 100644 net/mptcp/syncookies.c

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 54838ee2e8d4..11b20474be83 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -212,6 +212,12 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, stru=
ct sk_buff *skb,
 		refcount_set(&req->rsk_refcnt, 1);
 		tcp_sk(child)->tsoffset =3D tsoff;
 		sock_rps_save_rxhash(child, skb);
+
+		if (tcp_rsk(req)->drop_req) {
+			refcount_set(&req->rsk_refcnt, 2);
+			return child;
+		}
+
 		if (inet_csk_reqsk_queue_add(sk, req, child))
 			return child;
 =

diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index 2360cbd27d59..a611968be4d7 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_MPTCP) +=3D mptcp.o
 mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o ctrl.o pm.o d=
iag.o \
 	   mib.o pm_netlink.o
 =

+obj-$(CONFIG_SYN_COOKIES) +=3D syncookies.o
 obj-$(CONFIG_INET_MPTCP_DIAG) +=3D mptcp_diag.o
 =

 mptcp_crypto_test-objs :=3D crypto_test.o
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d76d3b40d69e..24c78a25c348 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -506,4 +506,22 @@ static inline bool subflow_simultaneous_connect(struct=
 sock *sk)
 	       !subflow->conn_finished;
 }
 =

+#ifdef CONFIG_SYN_COOKIES
+void subflow_init_req_cookie_join_save(const struct mptcp_subflow_request_=
sock *subflow_req,
+				       struct sk_buff *skb);
+bool mptcp_token_join_cookie_init_state(struct mptcp_subflow_request_sock =
*subflow_req,
+					struct sk_buff *skb);
+#else
+static inline void
+subflow_init_req_cookie_join_save(const struct mptcp_subflow_request_sock =
*subflow_req,
+				  struct sk_buff *skb) {}
+static inline bool
+mptcp_token_join_cookie_init_state(struct mptcp_subflow_request_sock *subf=
low_req,
+				   struct sk_buff *skb)
+{
+	return false;
+}
+
+#endif
+
 #endif /* __MPTCP_PROTOCOL_H */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e21dd19c617e..0bb0d66f0846 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -174,6 +174,12 @@ static void subflow_init_req(struct request_sock *req,
 		subflow_req->token =3D mp_opt.token;
 		subflow_req->remote_nonce =3D mp_opt.nonce;
 		subflow_req->msk =3D subflow_token_join_request(req, skb);
+
+		if (unlikely(want_cookie) && subflow_req->msk) {
+			if (mptcp_can_accept_new_subflow(subflow_req->msk))
+				subflow_init_req_cookie_join_save(subflow_req, skb);
+		}
+
 		pr_debug("token=3D%u, remote_nonce=3D%u msk=3D%p", subflow_req->token,
 			 subflow_req->remote_nonce, subflow_req->msk);
 	}
@@ -208,6 +214,14 @@ int mptcp_subflow_init_cookie_req(struct request_sock =
*req,
 =

 		subflow_req->mp_capable =3D 1;
 		subflow_req->ssn_offset =3D TCP_SKB_CB(skb)->seq - 1;
+	} else if (mp_opt.mp_join && listener->request_mptcp) {
+		if (!mptcp_token_join_cookie_init_state(subflow_req, skb))
+			return -EINVAL;
+
+		if (mptcp_can_accept_new_subflow(subflow_req->msk))
+			subflow_req->mp_join =3D 1;
+
+		subflow_req->ssn_offset =3D TCP_SKB_CB(skb)->seq - 1;
 	}
 =

 	return 0;
diff --git a/net/mptcp/syncookies.c b/net/mptcp/syncookies.c
new file mode 100644
index 000000000000..9a5628acf9a5
--- /dev/null
+++ b/net/mptcp/syncookies.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/skbuff.h>
+
+#include "protocol.h"
+
+/* Syncookies do not work for JOIN requests.
+ *
+ * Unlike MP_CAPABLE, where the ACK cookie contains the needed MPTCP
+ * options to reconstruct the initial syn state, MP_JOIN does not contain
+ * the token to obtain the mptcp socket nor the server-generated nonce
+ * that was used in the cookie SYN/ACK response.
+ *
+ * Keep a small best effort state table to store the syn/synack data,
+ * indexed by skb hash.
+ *
+ * A MP_JOIN SYN packet handled by syn cookies is only stored if the 32bit
+ * token matches a known mptcp connection that can still accept more subfl=
ows.
+ *
+ * There is no timeout handling -- state is only re-constructed
+ * when the TCP ACK passed the cookie validation check.
+ */
+
+struct join_entry {
+	u32 token;
+	u32 remote_nonce;
+	u32 local_nonce;
+	u8 backup;
+	u8 join_id;
+	u8 local_id;
+	u8 valid;
+};
+
+#define COOKIE_JOIN_SLOTS	1024
+
+static struct join_entry join_entries[COOKIE_JOIN_SLOTS];
+static struct join_entry *__mptcp_join_entry_slot(struct sk_buff *skb, str=
uct net *net)
+{
+	u32 i =3D skb_get_hash(skb) ^ net_hash_mix(net);
+
+	return &join_entries[i % ARRAY_SIZE(join_entries)];
+}
+
+/* WRITE/READ_ONCE are used, as no locking exists for the state table.
+ * Locking would also be useless given there is no guarantee that
+ * the state is still valid once cookie comes back.
+ */
+static void mptcp_join_store_state(struct join_entry *entry,
+				   const struct mptcp_subflow_request_sock *subflow_req)
+{
+	WRITE_ONCE(entry->token, subflow_req->token);
+	WRITE_ONCE(entry->remote_nonce, subflow_req->remote_nonce);
+	WRITE_ONCE(entry->local_nonce, subflow_req->local_nonce);
+	WRITE_ONCE(entry->backup, subflow_req->backup);
+	WRITE_ONCE(entry->join_id, subflow_req->remote_id);
+	WRITE_ONCE(entry->local_id, subflow_req->local_id);
+	WRITE_ONCE(entry->valid, 1);
+}
+
+void subflow_init_req_cookie_join_save(const struct mptcp_subflow_request_=
sock *subflow_req,
+				       struct sk_buff *skb)
+{
+	struct net *net =3D read_pnet(&subflow_req->sk.req.ireq_net);
+	struct join_entry *e;
+
+	e =3D __mptcp_join_entry_slot(skb, net);
+
+	mptcp_join_store_state(e, subflow_req);
+}
+
+/* Called for a cookie-ack with MP_JOIN option present.
+ * Look up the saved state based on skb hash, check token
+ * refers to a existing connection.
+ *
+ * Caller will check msk can still accept another
+ * subflow.
+ */
+bool mptcp_token_join_cookie_init_state(struct mptcp_subflow_request_sock =
*subflow_req,
+					struct sk_buff *skb)
+{
+	struct net *net =3D read_pnet(&subflow_req->sk.req.ireq_net);
+	u32 token, remote_nonce, local_nonce;
+	struct mptcp_sock *msk;
+	struct join_entry *e;
+	u8 backup, join_id;
+
+	e =3D __mptcp_join_entry_slot(skb, net);
+	if (READ_ONCE(e->valid) =3D=3D 0)
+		return false;
+
+	token =3D READ_ONCE(e->token);
+	msk =3D mptcp_token_get_sock(token);
+	if (!msk)
+		return false;
+
+	remote_nonce =3D READ_ONCE(e->remote_nonce);
+	local_nonce =3D READ_ONCE(e->local_nonce);
+	backup =3D READ_ONCE(e->backup);
+	join_id =3D READ_ONCE(e->join_id);
+
+	if (unlikely(token !=3D READ_ONCE(e->token)))
+		goto err_put;
+
+	WRITE_ONCE(e->valid, 0);
+
+	if (!net_eq(sock_net((struct sock *)msk), net))
+		goto err_put;
+
+	subflow_req->remote_nonce =3D remote_nonce;
+	subflow_req->local_nonce =3D local_nonce;
+	subflow_req->backup =3D backup;
+	subflow_req->remote_id =3D join_id;
+	subflow_req->token =3D token;
+	subflow_req->msk =3D msk;
+	return true;
+err_put:
+	sock_put((struct sock *)msk);
+	return false;
+}
-- =

2.26.2

--===============6065447190365750076==--
