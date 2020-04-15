Content-Type: multipart/mixed; boundary="===============4184050348271976239=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp 5/7] mptcp: use rcu helpers to fetch ulp subflow
 context
Date: Wed, 15 Apr 2020 19:19:52 +0200
Message-ID: <20200415171954.15321-6-fw@strlen.de>
In-Reply-To: 20200415171954.15321-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4184

--===============4184050348271976239==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

mptcp_sublow_ctx does:
    return (__force struct mptcp_subflow_context *)icsk->icsk_ulp_data;

One caller of the function is subflow_v4_conn_request.

In that case 'sk' is listener socket, but tcp does not hold the socket
lock.

Using rcu_dereference_check triggers a few warnings where don't hold the
socket lock, so fix up those places by adding either a rcu_read_lock or
the sk lock.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 18 +++++++++++++-----
 net/mptcp/protocol.h |  4 ++--
 net/mptcp/subflow.c  | 21 ++++++++-------------
 3 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 955b3d99bc21..761e258699b8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -117,8 +117,12 @@ static struct socket *__mptcp_socket_create(struct mpt=
cp_sock *msk, int state)
 		return ssock;
 =

 	ssock =3D __mptcp_nmpc_socket(msk);
-	if (ssock)
-		goto set_state;
+	if (ssock) {
+		if (state !=3D MPTCP_SAME_STATE)
+			inet_sk_state_store(sk, state);
+
+		return ssock;
+	}
 =

 	if (!__mptcp_can_create_subflow(msk))
 		return ERR_PTR(-EINVAL);
@@ -129,13 +133,15 @@ static struct socket *__mptcp_socket_create(struct mp=
tcp_sock *msk, int state)
 =

 	msk->first =3D ssock->sk;
 	msk->subflow =3D ssock;
+
+	lock_sock(ssock->sk);
 	subflow =3D mptcp_subflow_ctx(ssock->sk);
 	list_add(&subflow->node, &msk->conn_list);
 	subflow->request_mptcp =3D 1;
-
-set_state:
 	if (state !=3D MPTCP_SAME_STATE)
 		inet_sk_state_store(sk, state);
+	release_sock(ssock->sk);
+
 	return ssock;
 }
 =

@@ -1410,7 +1416,6 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
 		return NULL;
 	}
 =

-	pr_debug("msk=3D%p, listener=3D%p", msk, mptcp_subflow_ctx(listener->sk));
 	newsk =3D inet_csk_accept(listener->sk, flags, err, kern);
 	if (!newsk)
 		return NULL;
@@ -1422,6 +1427,7 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
 		struct sock *new_mptcp_sock;
 		struct sock *ssk =3D newsk;
 =

+		rcu_read_lock();
 		subflow =3D mptcp_subflow_ctx(newsk);
 		new_mptcp_sock =3D subflow->conn;
 =

@@ -1429,6 +1435,7 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
 		 * subflow_syn_recv_sock()
 		 */
 		if (WARN_ON_ONCE(!new_mptcp_sock)) {
+			rcu_read_unlock();
 			tcp_sk(newsk)->is_mptcp =3D 0;
 			return newsk;
 		}
@@ -1446,6 +1453,7 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
 		list_add(&subflow->node, &msk->conn_list);
 		inet_sk_state_store(newsk, TCP_ESTABLISHED);
 =

+		rcu_read_unlock();
 		bh_unlock_sock(new_mptcp_sock);
 =

 		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEPASSIVEACK);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 305e703e1fb3..a013f1c1045b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -278,8 +278,8 @@ mptcp_subflow_ctx(const struct sock *sk)
 {
 	struct inet_connection_sock *icsk =3D inet_csk(sk);
 =

-	/* Use RCU on icsk_ulp_data only for sock diag code */
-	return (__force struct mptcp_subflow_context *)icsk->icsk_ulp_data;
+	return rcu_dereference_check(icsk->icsk_ulp_data,
+				     lockdep_sock_is_held(sk));
 }
 =

 static inline struct sock *
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 0bc1f5dd9999..8b17f8ad8aeb 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -126,12 +126,10 @@ static void subflow_init_req(struct request_sock *req,
 			     const struct sock *sk_listener,
 			     struct sk_buff *skb)
 {
-	struct mptcp_subflow_context *listener =3D mptcp_subflow_ctx(sk_listener);
 	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);
+	const struct mptcp_subflow_context *listener;
 	struct tcp_options_received rx_opt;
 =

-	pr_debug("subflow_req=3D%p, listener=3D%p", subflow_req, listener);
-
 	memset(&rx_opt.mptcp, 0, sizeof(rx_opt.mptcp));
 	mptcp_get_options(skb, &rx_opt);
 =

@@ -156,6 +154,9 @@ static void subflow_init_req(struct request_sock *req,
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINSYNRX);
 	}
 =

+	rcu_read_lock();
+
+	listener =3D mptcp_subflow_ctx(sk_listener);
 	if (rx_opt.mptcp.mp_capable && listener->request_mptcp) {
 		int err;
 =

@@ -178,6 +179,7 @@ static void subflow_init_req(struct request_sock *req,
 			// @@ need to trigger RST
 		}
 	}
+	rcu_read_unlock();
 }
 =

 static void subflow_v4_init_req(struct request_sock *req,
@@ -306,10 +308,6 @@ static struct tcp_request_sock_ops subflow_request_soc=
k_ipv4_ops;
 =

 static int subflow_v4_conn_request(struct sock *sk, struct sk_buff *skb)
 {
-	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
-
-	pr_debug("subflow=3D%p", subflow);
-
 	/* Never answer to SYNs sent to broadcast or multicast */
 	if (skb_rtable(skb)->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
 		goto drop;
@@ -329,10 +327,6 @@ static struct inet_connection_sock_af_ops subflow_v6m_=
specific;
 =

 static int subflow_v6_conn_request(struct sock *sk, struct sk_buff *skb)
 {
-	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
-
-	pr_debug("subflow=3D%p", subflow);
-
 	if (skb->protocol =3D=3D htons(ETH_P_IP))
 		return subflow_v4_conn_request(sk, skb);
 =

@@ -940,7 +934,8 @@ int __mptcp_subflow_connect(struct sock *sk, int ifinde=
x,
 	if (err)
 		return err;
 =

-	subflow =3D mptcp_subflow_ctx(sf->sk);
+	/* socket is still private */
+	subflow =3D rcu_access_pointer(inet_csk(sf->sk)->icsk_ulp_data);
 	subflow->remote_key =3D msk->remote_key;
 	subflow->local_key =3D msk->local_key;
 	subflow->token =3D msk->token;
@@ -1002,12 +997,12 @@ int mptcp_subflow_create_socket(struct sock *sk, str=
uct socket **new_sock)
 	this_cpu_add(*net->core.sock_inuse, 1);
 #endif
 	err =3D tcp_set_ulp(sf->sk, "mptcp");
+	subflow =3D mptcp_subflow_ctx(sf->sk);
 	release_sock(sf->sk);
 =

 	if (err)
 		return err;
 =

-	subflow =3D mptcp_subflow_ctx(sf->sk);
 	pr_debug("subflow=3D%p", subflow);
 =

 	*new_sock =3D sf;
-- =

2.24.1

--===============4184050348271976239==--
