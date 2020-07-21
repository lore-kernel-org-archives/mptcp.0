Content-Type: multipart/mixed; boundary="===============7632776376732216752=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC v2 mptcp-next 11/12] mptcp: enable JOIN requests even if
 cookies are in use
Date: Tue, 21 Jul 2020 22:36:41 +0200
Message-ID: <20200721203642.32753-12-fw@strlen.de>
In-Reply-To: 20200721203642.32753-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 5157

--===============7632776376732216752==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

JOIN requests do not work in syncookie mode -- for HMAC validation, the
peers nonce is required, but this nonce is only present in the SYN.

So either we need to drop or reject all JOIN requests once a listening
socket enters syncookie mode, or we need to store enough state to
validate the ACKs HMAC later on.

This allows the subflow request initialisation function to store the
request socket even when syncookies are used, i.e. the listener
socket queue will grow past its upper limit.

Following restrictions apply:
1. The (32bit) token contained in the MP_JOIN SYN packet returns
   a valid parent connection.
2. The parent connection can accept one more subflow.

To ensure 2), all MP_JOIN requests (new incoming and existing)
are accounted in the mptcp parent socket.

If the token is invalid or the parent cannot accept a new subflow,
no information is stored and TCP fallback path is used.

The parent socket can't be used without further changes in TCP stack,
because socket creation after 3whs completion checks that the associated
socket is in LISTEN state.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 To ease review I think it would also be possible to
 defer the JOIN stuff for later and just focus on initial
 MP_CAPABLE request.  OTOH, doing so yields MPTCP-on-wire but with no
 Multipath capability so I'm not sure having MP_CAPABLE without
 MP_JOIN is useful.

 net/mptcp/pm_netlink.c |  2 +-
 net/mptcp/protocol.h   |  2 ++
 net/mptcp/subflow.c    | 60 +++++++++++++++++++++++++++++++++++++++---
 3 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c8820c4156e6..117f794ecc54 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -41,7 +41,7 @@ struct pm_nl_pernet {
 	unsigned int		next_id;
 };
 =

-#define MPTCP_PM_ADDR_MAX	8
+#define MPTCP_PM_ADDR_MAX	MPTCP_SUBFLOWS_MAX
 =

 static bool addresses_equal(const struct mptcp_addr_info *a,
 			    struct mptcp_addr_info *b, bool use_port)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0ed402cdb9fd..586601e889fc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -154,6 +154,8 @@ enum mptcp_pm_status {
 	MPTCP_PM_SUBFLOW_ESTABLISHED,
 };
 =

+#define MPTCP_SUBFLOWS_MAX	8
+
 struct mptcp_pm_data {
 	struct mptcp_addr_info local;
 	struct mptcp_addr_info remote;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 0761c35268ce..ab86010483fe 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -126,6 +126,49 @@ static int __subflow_check_options(const struct mptcp_=
options_received *mp_opt,
 	return 0;
 }
 =

+static bool mptcp_join_store(struct mptcp_subflow_request_sock *req,
+			     struct sock *sk_listener,
+			     bool want_cookie)
+{
+	struct mptcp_sock *msk =3D req->msk;
+	struct inet_connection_sock *icsk;
+	struct sock *sk;
+
+	icsk =3D &msk->sk;
+	sk =3D &icsk->icsk_inet.sk;
+
+	if (inet_csk_reqsk_queue_len(sk) >=3D MPTCP_SUBFLOWS_MAX ||
+	    !mptcp_can_accept_new_subflow(msk))
+		return false;
+
+	atomic_inc(&inet_csk(sk)->icsk_accept_queue.qlen);
+
+	if (likely(!want_cookie))
+		return true;
+
+	/* Syncookies are used.
+	 * We can't do this for JOIN requests because we need to store
+	 * the initiators nonce for HMAC validation.
+	 *
+	 * At this point we know:
+	 * 1. a valid parent connection that should be joined
+	 * 2. the parent socket has less than MPTCP_SUBFLOWS_MAX joined
+	 * connections (includes those in progress).
+	 *
+	 * We add the request to the accept queue backlog ourselves
+	 * in this case.
+	 */
+	if (unlikely(!refcount_inc_not_zero(&sk_listener->sk_refcnt))) {
+		atomic_dec(&inet_csk(sk)->icsk_accept_queue.qlen);
+		return false;
+	}
+
+	req->sk.req.req.rsk_listener =3D sk_listener;
+	inet_csk_reqsk_queue_hash_add(sk, &req->sk.req.req,
+				      tcp_timeout_init((struct sock *)req));
+	return true;
+}
+
 static void subflow_init_req(struct request_sock *req,
 			     const struct sock *sk_listener,
 			     struct sk_buff *skb,
@@ -177,12 +220,18 @@ static void subflow_init_req(struct request_sock *req,
 =

 	} else if (mp_opt.mp_join && listener->request_mptcp) {
 		subflow_req->ssn_offset =3D TCP_SKB_CB(skb)->seq;
-		subflow_req->mp_join =3D 1;
 		subflow_req->backup =3D mp_opt.backup;
 		subflow_req->remote_id =3D mp_opt.join_id;
 		subflow_req->token =3D mp_opt.token;
 		subflow_req->remote_nonce =3D mp_opt.nonce;
 		subflow_req->msk =3D subflow_token_join_request(req, skb);
+		if (!subflow_req->msk)
+			return;
+
+		if (!mptcp_join_store(subflow_req, (void *)sk_listener, want_cookie))
+			return;
+
+		subflow_req->mp_join =3D 1;
 		pr_debug("token=3D%u, remote_nonce=3D%u msk=3D%p", subflow_req->token,
 			 subflow_req->remote_nonce, subflow_req->msk);
 	}
@@ -1285,9 +1334,14 @@ static void subflow_ulp_release(struct sock *sk)
 	if (!ctx)
 		return;
 =

-	if (ctx->conn)
-		sock_put(ctx->conn);
+	if (ctx->conn) {
+		struct sock *msk =3D ctx->conn;
+
+		if (ctx->mp_join)
+			atomic_add_unless(&inet_csk(msk)->icsk_accept_queue.qlen, -1, 0);
 =

+		sock_put(msk);
+	}
 	kfree_rcu(ctx, rcu);
 }
 =

-- =

2.26.2

--===============7632776376732216752==--
