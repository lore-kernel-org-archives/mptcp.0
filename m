Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33EF2C9C
	for <mptcp@lists.linux.dev>; Sun, 16 Jan 2022 00:13:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1642291982; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=PExaWF5gO3QIqZKjBS+6rA30XipDLNRTiwKL7v1i1UC2idPVGaG5zYWudsfc7MCN+bhs6kKq+dnFP1BzvCAQ27VlJnWwWaDtHBjpVxK7OVWWZyqlgX/T3Oa9OQJq0cIiodMuVJFRQS1XHmyzID4ihYHY8vMPolhOKqtIjbzPHRE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1642291982; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
	bh=0ET53qKKaZutSx6wVRwxFnbTzLwm420kyaKFvHN1dM8=; 
	b=NDZIz6kVUa0OI85GbLRFxmWT/NxK9R7KoSnucfM6reYuP8GhYIF1aepWTjjAHLxZzO/rqvzprS+Pgf0Y37hDk1y791k7VtsgqMeg83iQsFQERLcn+KRDK/TsnaqD7nxVonWSMjCy5fRUYQn/IQ3oWz6G6MoKK257ibomnP8Knfg=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1642291982;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=0ET53qKKaZutSx6wVRwxFnbTzLwm420kyaKFvHN1dM8=;
	b=A6/03jsIVYt33KQNwYYX+ctzWp/hTo38Mh5vLZ+APEwa0LP+haDBbrPGIuJ7kmY1
	U86EQRPjh2VAvHmj7sjsyhuoOnnHdFPVPrtxi9CKs7xPFcnKHRnGkYLbseBaPP6f62R
	8tLeYU2vOot4AjwB71aqwbxWwyXhS7kujYYVkwMM=
Received: from doris.lan (vps-f3afed4e.vps.ovh.net [198.244.151.99]) by mx.zoho.eu
	with SMTPS id 1642291981921111.24901383148847; Sun, 16 Jan 2022 01:13:01 +0100 (CET)
From: Dmytro SHYTYI <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro SHYTYI <dmytro@shytyi.net>
Message-ID: <20220116001259.203319-1-dmytro@shytyi.net>
Subject: [PATCH net-next v2] net: mptcp, Fast Open Mechanism
Date: Sun, 16 Jan 2022 00:12:59 +0000
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8

This set of patches will bring "Fast Open" Option support to MPTCP.
The aim of Fast Open Mechanism is to eliminate one round trip
time from a TCP conversation by allowing data to be included as
part of the SYN segment that initiates the connection.

IETF RFC 8684: Appendix B.  TCP Fast Open and MPTCP.

[PATCH v2] includes "client-server" partial support for :
1. MPTCP cookie request from client.
2. MPTCP cookie offering from server.
3. MPTCP SYN+DATA+COOKIE from client.
4. subsequent write + read on the opened socket.

This patch is Work In Progress and an early draft shared due community
request.

Signed-off-by: Dmytro SHYTYI <dmytro@shytyi.net>
---
 include/linux/tcp.h             |  7 ++++
 net/ipv4/inet_connection_sock.c |  3 +-
 net/ipv4/tcp_fastopen.c         | 42 +++++++++++++++++++----
 net/ipv4/tcp_input.c            | 16 +++++----
 net/mptcp/protocol.c            | 59 ++++++++++++++++++++++++++++++---
 net/mptcp/sockopt.c             | 40 ++++++++++++++++++++++
 net/mptcp/subflow.c             | 14 ++++++++
 7 files changed, 162 insertions(+), 19 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 48d8a363319e..d7092234d442 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -54,7 +54,14 @@ static inline unsigned int tcp_optlen(const struct sk_bu=
ff *skb)
 /* TCP Fast Open */
 #define TCP_FASTOPEN_COOKIE_MIN=094=09/* Min Fast Open Cookie size in byte=
s */
 #define TCP_FASTOPEN_COOKIE_MAX=0916=09/* Max Fast Open Cookie size in byt=
es */
+
+#if IS_ENABLED(CONFIG_MPTCP)
+#define TCP_FASTOPEN_COOKIE_SIZE 4=09/* the size employed by MPTCP impl. *=
/
+#else
 #define TCP_FASTOPEN_COOKIE_SIZE 8=09/* the size employed by this impl. */
+#endif
+
+
=20
 /* TCP Fast Open Cookie as stored in memory */
 struct tcp_fastopen_cookie {
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_soc=
k.c
index f7fea3a7c5e6..4b4159c0258d 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -501,7 +501,8 @@ struct sock *inet_csk_accept(struct sock *sk, int flags=
, int *err, bool kern)
 =09req =3D reqsk_queue_remove(queue, sk);
 =09newsk =3D req->sk;
=20
-=09if (sk->sk_protocol =3D=3D IPPROTO_TCP &&
+=09if ((sk->sk_protocol =3D=3D IPPROTO_TCP ||
+=09     sk->sk_protocol =3D=3D IPPROTO_MPTCP) &&
 =09    tcp_rsk(req)->tfo_listener) {
 =09=09spin_lock_bh(&queue->fastopenq.lock);
 =09=09if (tcp_rsk(req)->tfo_listener) {
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index fdbcf2a6d08e..d26378983ed7 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -119,15 +119,26 @@ static bool __tcp_fastopen_cookie_gen_cipher(struct r=
equest_sock *req,
 =09=09=09=09=09     const siphash_key_t *key,
 =09=09=09=09=09     struct tcp_fastopen_cookie *foc)
 {
+#if IS_ENABLED(CONFIG_MPTCP)
+=09BUILD_BUG_ON(TCP_FASTOPEN_COOKIE_SIZE !=3D sizeof(u32));
+#else
 =09BUILD_BUG_ON(TCP_FASTOPEN_COOKIE_SIZE !=3D sizeof(u64));
+#endif
=20
 =09if (req->rsk_ops->family =3D=3D AF_INET) {
 =09=09const struct iphdr *iph =3D ip_hdr(syn);
=20
+#if IS_ENABLED(CONFIG_MPTCP)
+=09=09foc->val[0] =3D cpu_to_le32(siphash(&iph->saddr,
+=09=09=09=09=09=09  sizeof(iph->saddr) +
+=09=09=09=09=09=09  sizeof(iph->daddr),
+=09=09=09=09=09=09  key));
+#else
 =09=09foc->val[0] =3D cpu_to_le64(siphash(&iph->saddr,
 =09=09=09=09=09  sizeof(iph->saddr) +
 =09=09=09=09=09  sizeof(iph->daddr),
 =09=09=09=09=09  key));
+#endif
 =09=09foc->len =3D TCP_FASTOPEN_COOKIE_SIZE;
 =09=09return true;
 =09}
@@ -149,6 +160,7 @@ static bool __tcp_fastopen_cookie_gen_cipher(struct req=
uest_sock *req,
 /* Generate the fastopen cookie by applying SipHash to both the source and
  * destination addresses.
  */
+/*
 static void tcp_fastopen_cookie_gen(struct sock *sk,
 =09=09=09=09    struct request_sock *req,
 =09=09=09=09    struct sk_buff *syn,
@@ -162,6 +174,7 @@ static void tcp_fastopen_cookie_gen(struct sock *sk,
 =09=09__tcp_fastopen_cookie_gen_cipher(req, syn, &ctx->key[0], foc);
 =09rcu_read_unlock();
 }
+*/
=20
 /* If an incoming SYN or SYNACK frame contains a payload and/or FIN,
  * queue this additional data / FIN.
@@ -291,12 +304,12 @@ static struct sock *tcp_fastopen_create_child(struct =
sock *sk,
 =09 */
 =09return child;
 }
-
+/*
 static bool tcp_fastopen_queue_check(struct sock *sk)
 {
 =09struct fastopen_queue *fastopenq;
=20
-=09/* Make sure the listener has enabled fastopen, and we don't
+=09* Make sure the listener has enabled fastopen, and we don't
 =09 * exceed the max # of pending TFO requests allowed before trying
 =09 * to validating the cookie in order to avoid burning CPU cycles
 =09 * unnecessarily.
@@ -305,7 +318,7 @@ static bool tcp_fastopen_queue_check(struct sock *sk)
 =09 * processing a cookie request is that clients can't differentiate
 =09 * between qlen overflow causing Fast Open to be disabled
 =09 * temporarily vs a server not supporting Fast Open at all.
-=09 */
+=09 *
 =09fastopenq =3D &inet_csk(sk)->icsk_accept_queue.fastopenq;
 =09if (fastopenq->max_qlen =3D=3D 0)
 =09=09return false;
@@ -327,7 +340,7 @@ static bool tcp_fastopen_queue_check(struct sock *sk)
 =09}
 =09return true;
 }
-
+*/
 static bool tcp_fastopen_no_cookie(const struct sock *sk,
 =09=09=09=09   const struct dst_entry *dst,
 =09=09=09=09   int flag)
@@ -346,28 +359,43 @@ struct sock *tcp_try_fastopen(struct sock *sk, struct=
 sk_buff *skb,
 =09=09=09      struct tcp_fastopen_cookie *foc,
 =09=09=09      const struct dst_entry *dst)
 {
+=09/*
 =09bool syn_data =3D TCP_SKB_CB(skb)->end_seq !=3D TCP_SKB_CB(skb)->seq + =
1;
 =09int tcp_fastopen =3D sock_net(sk)->ipv4.sysctl_tcp_fastopen;
+=09*/
 =09struct tcp_fastopen_cookie valid_foc =3D { .len =3D -1 };
 =09struct sock *child;
 =09int ret =3D 0;
=20
 =09if (foc->len =3D=3D 0) /* Client requests a cookie */
 =09=09NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPFASTOPENCOOKIEREQD);
-
+/*
 =09if (!((tcp_fastopen & TFO_SERVER_ENABLE) &&
 =09      (syn_data || foc->len >=3D 0) &&
 =09      tcp_fastopen_queue_check(sk))) {
 =09=09foc->len =3D -1;
 =09=09return NULL;
 =09}
-
+*/
 =09if (tcp_fastopen_no_cookie(sk, dst, TFO_SERVER_COOKIE_NOT_REQD))
 =09=09goto fastopen;
=20
 =09if (foc->len =3D=3D 0) {
 =09=09/* Client requests a cookie. */
-=09=09tcp_fastopen_cookie_gen(sk, req, skb, &valid_foc);
+=09=09//tcp_fastopen_cookie_gen(sk, req, skb, &valid_foc);
+
+=09=09struct tcp_fastopen_context *ctx;
+=09=09struct iphdr *iph =3D ip_hdr(skb);
+
+=09=09tcp_fastopen_init_key_once(sock_net(sk));
+=09=09ctx =3D tcp_fastopen_get_ctx(sk);
+
+=09=09valid_foc.val[0] =3D cpu_to_le32(siphash(&iph->saddr,
+=09=09=09=09=09=09       sizeof(iph->saddr) +
+=09=09=09=09=09=09       sizeof(iph->daddr),
+=09=09=09=09=09=09       &ctx->key[0]));
+=09=09valid_foc.len =3D TCP_FASTOPEN_COOKIE_SIZE;
+
 =09} else if (foc->len > 0) {
 =09=09ret =3D tcp_fastopen_cookie_gen_check(sk, req, skb, foc,
 =09=09=09=09=09=09    &valid_foc);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 246ab7b5e857..915570132014 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5908,7 +5908,6 @@ void tcp_rcv_established(struct sock *sk, struct sk_b=
uff *skb)
 =09=09=09} else {
 =09=09=09=09tcp_update_wl(tp, TCP_SKB_CB(skb)->seq);
 =09=09=09}
-
 =09=09=09__tcp_ack_snd_check(sk, 0);
 no_ack:
 =09=09=09if (eaten)
@@ -6229,9 +6228,10 @@ static int tcp_rcv_synsent_state_process(struct sock=
 *sk, struct sk_buff *skb,
 =09=09}
 =09=09if (fastopen_fail)
 =09=09=09return -1;
-=09=09if (sk->sk_write_pending ||
-=09=09    icsk->icsk_accept_queue.rskq_defer_accept ||
-=09=09    inet_csk_in_pingpong_mode(sk)) {
+
+=09=09if ((sk->sk_write_pending ||
+=09=09     icsk->icsk_accept_queue.rskq_defer_accept ||
+=09=09     inet_csk_in_pingpong_mode(sk)) && !th->syn) {
 =09=09=09/* Save one ACK. Data will be ready after
 =09=09=09 * several ticks, if write_pending is set.
 =09=09=09 *
@@ -6243,9 +6243,10 @@ static int tcp_rcv_synsent_state_process(struct sock=
 *sk, struct sk_buff *skb,
 =09=09=09tcp_enter_quickack_mode(sk, TCP_MAX_QUICKACKS);
 =09=09=09inet_csk_reset_xmit_timer(sk, ICSK_TIME_DACK,
 =09=09=09=09=09=09  TCP_DELACK_MAX, TCP_RTO_MAX);
-
 discard:
 =09=09=09tcp_drop(sk, skb);
+=09=09=09tcp_send_ack(sk);
+
 =09=09=09return 0;
 =09=09} else {
 =09=09=09tcp_send_ack(sk);
@@ -6425,6 +6426,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_=
buff *skb)
 =09=09tcp_urg(sk, skb, th);
 =09=09__kfree_skb(skb);
 =09=09tcp_data_snd_check(sk);
+
 =09=09return 0;
 =09}
=20
@@ -6901,7 +6903,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops=
,
 =09=09=09 */
 =09=09=09pr_drop_req(req, ntohs(tcp_hdr(skb)->source),
 =09=09=09=09    rsk_ops->family);
-=09=09=09goto drop_and_release;
+=09=09=09//goto drop_and_release;
 =09=09}
=20
 =09=09isn =3D af_ops->init_seq(skb);
@@ -6954,7 +6956,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops=
,
 =09reqsk_put(req);
 =09return 0;
=20
-drop_and_release:
+//drop_and_release:
 =09dst_release(dst);
 drop_and_free:
 =09__reqsk_free(req);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cd6b11c9b54d..3020a9c95a31 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -52,6 +52,8 @@ static struct percpu_counter mptcp_sockets_allocated;
=20
 static void __mptcp_destroy_sock(struct sock *sk);
 static void __mptcp_check_send_data_fin(struct sock *sk);
+static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uadd=
r,
+=09=09=09=09int addr_len, int flags);
=20
 DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 static struct net_device mptcp_napi_dev;
@@ -1677,6 +1679,53 @@ static void __mptcp_subflow_push_pending(struct sock=
 *sk, struct sock *ssk)
 =09}
 }
=20
+static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
+=09=09=09=09  size_t len, struct mptcp_sock *msk, size_t copied)
+{
+=09const struct iphdr *iph;
+=09struct ubuf_info *uarg;
+=09struct sockaddr *uaddr;
+=09struct sk_buff *skb;
+=09struct tcp_sock *tp;
+=09struct socket *ssk;
+=09int ret;
+
+=09ssk =3D __mptcp_nmpc_socket(msk);
+=09if (unlikely(!ssk))
+=09=09goto out_EFAULT;
+=09skb =3D sk_stream_alloc_skb(ssk->sk, 0, ssk->sk->sk_allocation, true);
+=09if (unlikely(!skb))
+=09=09goto out_EFAULT;
+=09iph =3D ip_hdr(skb);
+=09if (unlikely(!iph))
+=09=09goto out_EFAULT;
+=09uarg =3D msg_zerocopy_realloc(sk, len, skb_zcopy(skb));
+=09if (unlikely(!uarg))
+=09=09goto out_EFAULT;
+=09uaddr =3D msg->msg_name;
+
+=09tp =3D tcp_sk(ssk->sk);
+=09if (unlikely(!tp))
+=09=09goto out_EFAULT;
+=09if (!tp->fastopen_req)
+=09=09tp->fastopen_req =3D kzalloc(sizeof(*tp->fastopen_req), ssk->sk->sk_=
allocation);
+
+=09if (unlikely(!tp->fastopen_req))
+=09=09goto out_EFAULT;
+=09tp->fastopen_req->data =3D msg;
+=09tp->fastopen_req->size =3D len;
+=09tp->fastopen_req->uarg =3D uarg;
+
+=09/* requests a cookie */
+=09ret =3D mptcp_stream_connect(sk->sk_socket, uaddr,
+=09=09=09=09   msg->msg_namelen, msg->msg_flags);
+
+=09return ret;
+out_EFAULT:
+=09ret =3D -EFAULT;
+=09return ret;
+}
+
 static void mptcp_set_nospace(struct sock *sk)
 {
 =09/* enable autotune */
@@ -1694,9 +1743,9 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 =09int ret =3D 0;
 =09long timeo;
=20
-=09/* we don't support FASTOPEN yet */
+=09/* we don't fully support FASTOPEN yet */
 =09if (msg->msg_flags & MSG_FASTOPEN)
-=09=09return -EOPNOTSUPP;
+=09=09ret =3D mptcp_sendmsg_fastopen(sk, msg, len, msk, copied);
=20
 =09/* silently ignore everything else */
 =09msg->msg_flags &=3D MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL;
@@ -2482,10 +2531,10 @@ static void mptcp_worker(struct work_struct *work)
=20
 =09if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
 =09=09__mptcp_close_subflow(msk);
-
+=09/*
 =09if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 =09=09__mptcp_retrans(sk);
-
+=09*/
 unlock:
 =09release_sock(sk);
 =09sock_put(sk);
@@ -2589,6 +2638,8 @@ void mptcp_subflow_shutdown(struct sock *sk, struct s=
ock *ssk, int how)
 =09case TCP_SYN_SENT:
 =09=09tcp_disconnect(ssk, O_NONBLOCK);
 =09=09break;
+=09case TCP_ESTABLISHED:
+=09=09break;
 =09default:
 =09=09if (__mptcp_check_fallback(mptcp_sk(sk))) {
 =09=09=09pr_debug("Fallback");
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 0f1e661c2032..0e471e31e72a 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -539,6 +539,7 @@ static bool mptcp_supported_sockopt(int level, int optn=
ame)
 =09=09case TCP_TIMESTAMP:
 =09=09case TCP_NOTSENT_LOWAT:
 =09=09case TCP_TX_DELAY:
+=09=09case TCP_FASTOPEN:
 =09=09=09return true;
 =09=09}
=20
@@ -598,6 +599,43 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct =
mptcp_sock *msk, sockptr_t
 =09return ret;
 }
=20
+static int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock *msk, sockp=
tr_t optval,
+=09=09=09=09=09     unsigned int optlen)
+{
+=09struct mptcp_subflow_context *subflow;
+=09struct sock *sk =3D (struct sock *)msk;
+=09struct net *net =3D sock_net(sk);
+=09int val;
+=09int ret;
+
+=09ret =3D 0;
+
+=09if (copy_from_sockptr(&val, optval, sizeof(val)))
+=09=09return -EFAULT;
+
+=09lock_sock(sk);
+
+=09mptcp_for_each_subflow(msk, subflow) {
+=09=09struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+
+=09=09lock_sock(ssk);
+
+=09=09if (val >=3D 0 && ((1 << sk->sk_state) & (TCPF_CLOSE |
+=09=09    TCPF_LISTEN))) {
+=09=09=09tcp_fastopen_init_key_once(net);
+=09=09=09fastopen_queue_tune(sk, val);
+=09=09} else {
+=09=09=09ret =3D -EINVAL;
+=09=09}
+
+=09=09release_sock(ssk);
+=09}
+
+=09release_sock(sk);
+
+=09return ret;
+}
+
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 =09=09=09=09    sockptr_t optval, unsigned int optlen)
 {
@@ -606,6 +644,8 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *=
msk, int optname,
 =09=09return -EOPNOTSUPP;
 =09case TCP_CONGESTION:
 =09=09return mptcp_setsockopt_sol_tcp_congestion(msk, optval, optlen);
+=09case TCP_FASTOPEN:
+=09=09return mptcp_setsockopt_sol_tcp_fastopen(msk, optval, optlen);
 =09}
=20
 =09return -EOPNOTSUPP;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6172f380dfb7..82976b31f2f2 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -966,6 +966,7 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk,
 =09trace_get_mapping_status(mpext);
=20
 =09data_len =3D mpext->data_len;
+
 =09if (data_len =3D=3D 0) {
 =09=09MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
 =09=09return MAPPING_INVALID;
@@ -1024,6 +1025,7 @@ static enum mapping_status get_mapping_status(struct =
sock *ssk,
 =09=09/* If this skb data are fully covered by the current mapping,
 =09=09 * the new map would need caching, which is not supported
 =09=09 */
+
 =09=09if (skb_is_fully_mapped(ssk, skb)) {
 =09=09=09MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSNOMATCH);
 =09=09=09return MAPPING_INVALID;
@@ -1044,6 +1046,7 @@ static enum mapping_status get_mapping_status(struct =
sock *ssk,
 =09subflow->map_data_csum =3D csum_unfold(mpext->csum);
=20
 =09/* Cfr RFC 8684 Section 3.3.0 */
+
 =09if (unlikely(subflow->map_csum_reqd !=3D csum_reqd))
 =09=09return MAPPING_INVALID;
=20
@@ -1180,9 +1183,19 @@ static bool subflow_check_data_avail(struct sock *ss=
k)
 =09}
=20
 =09if (subflow->mp_join || subflow->fully_established) {
+=09=09skb =3D skb_peek(&ssk->sk_receive_queue);
+=09=09subflow->map_valid =3D 1;
+=09=09subflow->map_seq =3D READ_ONCE(msk->ack_seq);
+=09=09subflow->map_data_len =3D skb->len;
+=09=09subflow->map_subflow_seq =3D tcp_sk(ssk)->copied_seq - subflow->ssn_=
offset;
+
+=09=09WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_DATA_AVAIL);
+=09=09return true;
+
 =09=09/* fatal protocol error, close the socket.
 =09=09 * subflow_error_report() will introduce the appropriate barriers
 =09=09 */
+=09=09/*
 =09=09ssk->sk_err =3D EBADMSG;
 =09=09tcp_set_state(ssk, TCP_CLOSE);
 =09=09subflow->reset_transient =3D 0;
@@ -1190,6 +1203,7 @@ static bool subflow_check_data_avail(struct sock *ssk=
)
 =09=09tcp_send_active_reset(ssk, GFP_ATOMIC);
 =09=09WRITE_ONCE(subflow->data_avail, 0);
 =09=09return false;
+=09=09*/
 =09}
=20
 =09__mptcp_do_fallback(msk);
--=20
2.25.1


