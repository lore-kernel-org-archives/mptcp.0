Content-Type: multipart/mixed; boundary="===============1116498943542233636=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC 2/3] mptcp: propagate mptcp-socket level ip
 options to the subflows
Date: Thu, 05 Mar 2020 14:22:30 +0100
Message-ID: <20200305132231.22953-3-fw@strlen.de>
In-Reply-To: 20200305132231.22953-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3871

--===============1116498943542233636==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Upper layers typically update inet_opts and icsk_ext_hdr_len, then
call the sync_mss callback.

We will need to propagate this to the individual subflows.

This is modeled after tcp semantics, i.e. if there are ip options
on incoming connection, these will be propagated to the mptcp
socket.  This is questionable, because ip options may be path
specific (e.g. source routing), so it might make sense to NOT
copy them to the mptcp socket.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 78 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a8445407d25a..0e3654ce77a0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -74,10 +74,41 @@ static bool __mptcp_can_create_subflow(const struct mpt=
cp_sock *msk)
 	return !msk->first;
 }
 =

+static void mptcp_copy_inet_opts(struct sock *nsk, const struct sock *sk,
+				 bool nsk_locked, bool sk_locked)
+{
+	struct ip_options_rcu *inet_opt;
+	unsigned int len;
+
+	inet_opt =3D rcu_dereference_check(inet_sk(sk)->inet_opt, sk_locked);
+	if (!inet_opt)
+		return;
+
+	len =3D sizeof(*inet_opt) + inet_opt->opt.optlen;
+	inet_opt =3D kmemdup(inet_opt, len, GFP_ATOMIC);
+	if (inet_opt) {
+		struct ip_options_rcu *old;
+
+		old =3D rcu_replace_pointer(inet_sk(nsk)->inet_opt,
+						  inet_opt, nsk_locked);
+		kfree_rcu(old, rcu);
+	}
+}
+
+static void mptcp_sync_mss_one(struct sock *ssk, const struct sock *sk)
+{
+	mptcp_copy_inet_opts(ssk, sk, lockdep_sock_is_held(ssk),
+				      lockdep_sock_is_held(sk));
+
+	/* don't use msk->icsk_pmtu_cookie; mtu is per-ssk */
+	tcp_sync_mss(ssk, inet_csk(ssk)->icsk_pmtu_cookie);
+}
+
 static struct socket *__mptcp_socket_create(struct mptcp_sock *msk, int st=
ate)
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk =3D (struct sock *)msk;
+	struct inet_connection_sock *icsk;
 	struct socket *ssock;
 	int err;
 =

@@ -95,6 +126,9 @@ static struct socket *__mptcp_socket_create(struct mptcp=
_sock *msk, int state)
 	msk->first =3D ssock->sk;
 	msk->subflow =3D ssock;
 	subflow =3D mptcp_subflow_ctx(ssock->sk);
+	icsk =3D inet_csk(ssock->sk);
+	icsk->icsk_ext_hdr_len =3D inet_csk(sk)->icsk_ext_hdr_len;
+	mptcp_copy_inet_opts(ssock->sk, sk, true, lockdep_sock_is_held(sk));
 	list_add(&subflow->node, &msk->conn_list);
 	subflow->request_mptcp =3D 1;
 =

@@ -668,6 +702,23 @@ static void __mptcp_close_ssk(struct sock *sk, struct =
sock *ssk,
 =

 static unsigned int mptcp_sync_mss(struct sock *sk, u32 pmtu)
 {
+	u16 ext_hdr_len =3D inet_csk(sk)->icsk_ext_hdr_len;
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+
+	sock_owned_by_me((const struct sock *)msk);
+
+	inet_csk(sk)->icsk_pmtu_cookie =3D pmtu;
+
+	list_for_each_entry(subflow, &msk->conn_list, node) {
+		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+
+		lock_sock(ssk);
+		inet_csk(ssk)->icsk_ext_hdr_len =3D ext_hdr_len;
+		mptcp_sync_mss_one(ssk, (struct sock *)msk);
+		release_sock(ssk);
+	}
+
 	return 0;
 }
 =

@@ -808,9 +859,17 @@ static struct sock *mptcp_sk_clone_lock(const struct s=
ock *sk)
 		inet_sk(nsk)->pinet6 =3D mptcp_inet6_sk(nsk);
 #endif
 =

+	RCU_INIT_POINTER(inet_sk(nsk)->inet_opt, NULL);
+	mptcp_copy_inet_opts(nsk, sk, lockdep_sock_is_held(nsk),
+			     lockdep_sock_is_held(sk));
 	return nsk;
 }
 =

+static bool mptcp_sk_has_ipopts(struct sock *sk)
+{
+	return rcu_access_pointer(inet_sk(sk)->inet_opt) !=3D NULL;
+}
+
 static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
 				 bool kern)
 {
@@ -835,6 +894,7 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 		struct mptcp_subflow_context *subflow;
 		struct sock *new_mptcp_sock;
 		struct sock *ssk =3D newsk;
+		bool sk_has_ip_opts;
 		u64 ack_seq;
 =

 		subflow =3D mptcp_subflow_ctx(newsk);
@@ -871,6 +931,17 @@ static struct sock *mptcp_accept(struct sock *sk, int =
flags, int *err,
 		}
 		newsk =3D new_mptcp_sock;
 		mptcp_copy_inaddrs(newsk, ssk);
+
+		sk_has_ip_opts =3D mptcp_sk_has_ipopts(newsk);
+
+		if (!sk_has_ip_opts && mptcp_sk_has_ipopts(ssk)) {
+			rcu_read_lock();
+			mptcp_copy_inet_opts(newsk, ssk,
+					     lockdep_sock_is_held(newsk),
+					     lockdep_sock_is_held(ssk));
+			rcu_read_unlock();
+		}
+
 		list_add(&subflow->node, &msk->conn_list);
 =

 		/* will be fully established at mptcp_stream_accept()
@@ -890,6 +961,13 @@ static struct sock *mptcp_accept(struct sock *sk, int =
flags, int *err,
 		subflow->conn =3D new_mptcp_sock;
 		if (unlikely(!skb_queue_empty(&ssk->sk_receive_queue)))
 			mptcp_subflow_data_available(ssk);
+
+		if (sk_has_ip_opts) {
+			rcu_read_lock();
+			mptcp_sync_mss_one(ssk, new_mptcp_sock);
+			rcu_read_unlock();
+		}
+
 		release_sock(ssk);
 	}
 =

-- =

2.24.1

--===============1116498943542233636==--
