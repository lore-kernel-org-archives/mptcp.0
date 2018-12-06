Content-Type: multipart/mixed; boundary="===============7211572926167704877=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 08/12] mptcp: Remove support for TCP Fast Open
Date: Wed, 05 Dec 2018 17:00:19 -0800
Message-ID: <20181206010023.18819-9-cpaasch@apple.com>
In-Reply-To: 20181206010023.18819-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 881

--===============7211572926167704877==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 include/linux/tcp.h      |  2 +-
 include/net/mptcp.h      |  9 +-----
 net/ipv4/tcp.c           |  7 ++---
 net/ipv4/tcp_fastopen.c  | 16 +++--------
 net/ipv4/tcp_input.c     | 23 ++--------------
 net/mptcp/mptcp_ctrl.c   | 53 ------------------------------------
 net/mptcp/mptcp_input.c  | 71 --------------------------------------------=
----
 net/mptcp/mptcp_output.c |  5 +---
 8 files changed, 13 insertions(+), 173 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 6dd9c45c52d6..01321044047c 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -58,7 +58,7 @@ static inline unsigned int tcp_optlen(const struct sk_buf=
f *skb)
 /* TCP Fast Open */
 #define TCP_FASTOPEN_COOKIE_MIN	4	/* Min Fast Open Cookie size in bytes */
 #define TCP_FASTOPEN_COOKIE_MAX	16	/* Max Fast Open Cookie size in bytes */
-#define TCP_FASTOPEN_COOKIE_SIZE 4	/* the size employed by this impl. */
+#define TCP_FASTOPEN_COOKIE_SIZE 8	/* the size employed by this impl. */
 =

 /* TCP Fast Open Cookie as stored in memory */
 struct tcp_fastopen_cookie {
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 721515ddb252..e1e7619a85ca 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -738,7 +738,6 @@ void mptcp_close(struct sock *meta_sk, long timeout);
 bool mptcp_doit(struct sock *sk);
 int mptcp_create_master_sk(struct sock *meta_sk, __u64 remote_key,
 			   __u8 mptcp_ver, u32 window);
-int mptcp_check_req_fastopen(struct sock *child, struct request_sock *req);
 int mptcp_check_req_master(struct sock *sk, struct sock *child,
 			   struct request_sock *req, const struct sk_buff *skb,
 			   int drop);
@@ -1054,8 +1053,7 @@ static inline void mptcp_check_rcvseq_wrap(struct tcp=
_sock *meta_tp,
 =

 static inline int mptcp_sk_can_send(const struct sock *sk)
 {
-	return tcp_passive_fastopen(sk) ||
-	       ((1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT) &&
+	return ((1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT) &&
 		!tcp_sk(sk)->mptcp->pre_established);
 }
 =

@@ -1278,11 +1276,6 @@ static inline bool mptcp_doit(struct sock *sk)
 {
 	return false;
 }
-static inline int mptcp_check_req_fastopen(struct sock *child,
-					   struct request_sock *req)
-{
-	return 1;
-}
 static inline int mptcp_check_req_master(const struct sock *sk,
 					 const struct sock *child,
 					 const struct request_sock *req,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 87f7616aaf93..b2dac73903be 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1233,7 +1233,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr=
 *msg, size_t size)
 	}
 =

 	if (unlikely(flags & MSG_FASTOPEN || inet_sk(sk)->defer_connect) &&
-	    !tp->repair) {
+	    !tp->repair && !sock_flag(sk, SOCK_MPTCP)) {
 		err =3D tcp_sendmsg_fastopen(sk, msg, &copied_syn, size);
 		if (err =3D=3D -EINPROGRESS && copied_syn > 0)
 			goto out;
@@ -1250,8 +1250,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr=
 *msg, size_t size)
 	 * is fully established.
 	 */
 	if (((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) &&
-	    !tcp_passive_fastopen(mptcp(tp) && tp->mpcb->master_sk ?
-				  tp->mpcb->master_sk : sk)) {
+	    !tcp_passive_fastopen(sk)) {
 		err =3D sk_stream_wait_connect(sk, &timeo);
 		if (err !=3D 0)
 			goto do_error;
@@ -3098,7 +3097,7 @@ static int do_tcp_setsockopt(struct sock *sk, int lev=
el,
 =

 	case TCP_FASTOPEN:
 		if (val >=3D 0 && ((1 << sk->sk_state) & (TCPF_CLOSE |
-		    TCPF_LISTEN))) {
+		    TCPF_LISTEN)) && !sock_flag(sk, SOCK_MPTCP)) {
 			tcp_fastopen_init_key_once(net);
 =

 			fastopen_queue_tune(sk, val);
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 370fe7d4b579..018a48477355 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -9,7 +9,6 @@
 #include <linux/rculist.h>
 #include <net/inetpeer.h>
 #include <net/tcp.h>
-#include <net/mptcp.h>
 =

 void tcp_fastopen_init_key_once(struct net *net)
 {
@@ -219,7 +218,7 @@ static struct sock *tcp_fastopen_create_child(struct so=
ck *sk,
 {
 	struct tcp_sock *tp;
 	struct request_sock_queue *queue =3D &inet_csk(sk)->icsk_accept_queue;
-	struct sock *child, *meta_sk;
+	struct sock *child;
 	bool own_req;
 =

 	req->num_retrans =3D 0;
@@ -259,22 +258,15 @@ static struct sock *tcp_fastopen_create_child(struct =
sock *sk,
 =

 	refcount_set(&req->rsk_refcnt, 2);
 =

+	/* Now finish processing the fastopen child socket. */
+	tcp_init_transfer(child, BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB);
+
 	tp->rcv_nxt =3D TCP_SKB_CB(skb)->seq + 1;
 =

 	tcp_fastopen_add_skb(child, skb);
 =

 	tcp_rsk(req)->rcv_nxt =3D tp->rcv_nxt;
 	tp->rcv_wup =3D tp->rcv_nxt;
-
-	meta_sk =3D child;
-	if (!mptcp_check_req_fastopen(meta_sk, req)) {
-		child =3D tcp_sk(meta_sk)->mpcb->master_sk;
-		tp =3D tcp_sk(child);
-	}
-
-	/* Now finish processing the fastopen child socket. */
-	tcp_init_transfer(child, BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB);
-
 	/* tcp_conn_request() is sending the SYNACK,
 	 * and queues the child into listener accept queue.
 	 */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index ea36a23267cf..49ac1b821ac1 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5784,17 +5784,10 @@ static bool tcp_rcv_fastopen_synack(struct sock *sk=
, struct sk_buff *synack,
 				    struct tcp_fastopen_cookie *cookie)
 {
 	struct tcp_sock *tp =3D tcp_sk(sk);
-	struct sk_buff *data =3D NULL;
+	struct sk_buff *data =3D tp->syn_data ? tcp_rtx_queue_head(sk) : NULL;
 	u16 mss =3D tp->rx_opt.mss_clamp, try_exp =3D 0;
 	bool syn_drop =3D false;
 =

-	if (tp->syn_data) {
-		if (mptcp(tp))
-			data =3D tcp_write_queue_head(mptcp_meta_sk(sk));
-		else
-			data =3D tcp_rtx_queue_head(sk);
-	}
-
 	if (mss =3D=3D tp->rx_opt.user_mss) {
 		struct tcp_options_received opt;
 =

@@ -5825,11 +5818,7 @@ static bool tcp_rcv_fastopen_synack(struct sock *sk,=
 struct sk_buff *synack,
 =

 	tcp_fastopen_cache_set(sk, mss, cookie, syn_drop, try_exp);
 =

-	/* In mptcp case, we do not rely on "retransmit", but instead on
-	 * "transmit", because if fastopen data is not acked, the retransmission
-	 * becomes the first MPTCP data (see mptcp_rcv_synsent_fastopen).
-	 */
-	if (data && !mptcp(tp)) { /* Retransmit unacked data in SYN */
+	if (data) { /* Retransmit unacked data in SYN */
 		skb_rbtree_walk_from(data) {
 			if (__tcp_retransmit_skb(sk, data, 1))
 				break;
@@ -6689,18 +6678,12 @@ int tcp_conn_request(struct request_sock_ops *rsk_o=
ps,
 		fastopen_sk =3D tcp_try_fastopen(sk, skb, req, &foc, dst);
 	}
 	if (fastopen_sk) {
-		struct sock *meta_sk =3D fastopen_sk;
-
-		if (mptcp(tcp_sk(fastopen_sk)))
-			meta_sk =3D mptcp_meta_sk(fastopen_sk);
 		af_ops->send_synack(fastopen_sk, dst, &fl, req,
 				    &foc, TCP_SYNACK_FASTOPEN);
 		/* Add the child socket directly into the accept queue */
-		inet_csk_reqsk_queue_add(sk, req, meta_sk);
+		inet_csk_reqsk_queue_add(sk, req, fastopen_sk);
 		sk->sk_data_ready(sk);
 		bh_unlock_sock(fastopen_sk);
-		if (meta_sk !=3D fastopen_sk)
-			bh_unlock_sock(meta_sk);
 		sock_put(fastopen_sk);
 	} else {
 		tcp_rsk(req)->tfo_listener =3D false;
diff --git a/net/mptcp/mptcp_ctrl.c b/net/mptcp/mptcp_ctrl.c
index 910268a8ee8e..eee86f84ba31 100644
--- a/net/mptcp/mptcp_ctrl.c
+++ b/net/mptcp/mptcp_ctrl.c
@@ -2075,59 +2075,6 @@ static int __mptcp_check_req_master(struct sock *chi=
ld,
 	return 0;
 }
 =

-int mptcp_check_req_fastopen(struct sock *child, struct request_sock *req)
-{
-	struct sock *meta_sk =3D child, *master_sk;
-	struct sk_buff *skb;
-	u32 new_mapping;
-	int ret;
-
-	ret =3D __mptcp_check_req_master(child, req);
-	if (ret)
-		return ret;
-
-	master_sk =3D tcp_sk(meta_sk)->mpcb->master_sk;
-
-	/* We need to rewind copied_seq as it is set to IDSN + 1 and as we have
-	 * pre-MPTCP data in the receive queue.
-	 */
-	tcp_sk(meta_sk)->copied_seq -=3D tcp_sk(master_sk)->rcv_nxt -
-				       tcp_rsk(req)->rcv_isn - 1;
-
-	/* Map subflow sequence number to data sequence numbers. We need to map
-	 * these data to [IDSN - len - 1, IDSN[.
-	 */
-	new_mapping =3D tcp_sk(meta_sk)->copied_seq - tcp_rsk(req)->rcv_isn - 1;
-
-	/* There should be only one skb: the SYN + data. */
-	skb_queue_walk(&meta_sk->sk_receive_queue, skb) {
-		TCP_SKB_CB(skb)->seq +=3D new_mapping;
-		TCP_SKB_CB(skb)->end_seq +=3D new_mapping;
-	}
-
-	/* With fastopen we change the semantics of the relative subflow
-	 * sequence numbers to deal with middleboxes that could add/remove
-	 * multiple bytes in the SYN. We chose to start counting at rcv_nxt - 1
-	 * instead of the regular TCP ISN.
-	 */
-	tcp_sk(master_sk)->mptcp->rcv_isn =3D tcp_sk(master_sk)->rcv_nxt - 1;
-
-	/* We need to update copied_seq of the master_sk to account for the
-	 * already moved data to the meta receive queue.
-	 */
-	tcp_sk(master_sk)->copied_seq =3D tcp_sk(master_sk)->rcv_nxt;
-
-	/* Handled by the master_sk */
-	tcp_sk(meta_sk)->fastopen_rsk =3D NULL;
-
-	/* Subflow establishment is now lockless, drop the lock here it will
-	 * be taken again in tcp_child_process().
-	 */
-	bh_unlock_sock(meta_sk);
-
-	return 0;
-}
-
 int mptcp_check_req_master(struct sock *sk, struct sock *child,
 			   struct request_sock *req, const struct sk_buff *skb,
 			   int drop)
diff --git a/net/mptcp/mptcp_input.c b/net/mptcp/mptcp_input.c
index f247e9ef2853..88c7a64ef26c 100644
--- a/net/mptcp/mptcp_input.c
+++ b/net/mptcp/mptcp_input.c
@@ -1934,63 +1934,6 @@ bool mptcp_handle_options(struct sock *sk, const str=
uct tcphdr *th,
 	return false;
 }
 =

-/* In case of fastopen, some data can already be in the write queue.
- * We need to update the sequence number of the segments as they
- * were initially TCP sequence numbers.
- */
-static void mptcp_rcv_synsent_fastopen(struct sock *meta_sk)
-{
-	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
-	struct tcp_sock *master_tp =3D tcp_sk(meta_tp->mpcb->master_sk);
-	struct sk_buff *skb, *tmp;
-	u32 new_mapping =3D meta_tp->write_seq - master_tp->snd_una;
-
-	/* There should only be one skb in write queue: the data not
-	 * acknowledged in the SYN+ACK. In this case, we need to map
-	 * this data to data sequence numbers.
-	 */
-	skb_rbtree_walk_safe(skb, &meta_sk->tcp_rtx_queue, tmp) {
-		/* If the server only acknowledges partially the data sent in
-		 * the SYN, we need to trim the acknowledged part because
-		 * we don't want to retransmit this already received data.
-		 * When we reach this point, tcp_ack() has already cleaned up
-		 * fully acked segments. However, tcp trims partially acked
-		 * segments only when retransmitting. Since MPTCP comes into
-		 * play only now, we will fake an initial transmit, and
-		 * retransmit_skb() will not be called. The following fragment
-		 * comes from __tcp_retransmit_skb().
-		 */
-		if (before(TCP_SKB_CB(skb)->seq, master_tp->snd_una)) {
-			BUG_ON(before(TCP_SKB_CB(skb)->end_seq,
-				      master_tp->snd_una));
-			/* tcp_trim_head can only returns ENOMEM if skb is
-			 * cloned. It is not the case here (see
-			 * tcp_send_syn_data).
-			 */
-			BUG_ON(tcp_trim_head(meta_sk, skb, master_tp->snd_una -
-					     TCP_SKB_CB(skb)->seq));
-		}
-
-		TCP_SKB_CB(skb)->seq +=3D new_mapping;
-		TCP_SKB_CB(skb)->end_seq +=3D new_mapping;
-
-		tcp_rtx_queue_unlink(skb, meta_sk);
-		tcp_add_write_queue_tail(meta_sk, skb);
-	}
-
-	/* We can advance write_seq by the number of bytes unacknowledged
-	 * and that were mapped in the previous loop.
-	 */
-	meta_tp->write_seq +=3D master_tp->write_seq - master_tp->snd_una;
-
-	/* The packets from the master_sk will be entailed to it later
-	 * Until that time, its write queue is empty, and
-	 * write_seq must align with snd_una
-	 */
-	master_tp->snd_nxt =3D master_tp->write_seq =3D master_tp->snd_una;
-	master_tp->packets_out =3D 0;
-}
-
 /* The skptr is needed, because if we become MPTCP-capable, we have to swi=
tch
  * from meta-socket to master-socket.
  *
@@ -2049,17 +1992,6 @@ int mptcp_rcv_synsent_state_process(struct sock *sk,=
 struct sock **skptr,
 		*skptr =3D sk;
 		tp =3D tcp_sk(sk);
 =

-		/* If fastopen was used data might be in the send queue. We
-		 * need to update their sequence number to MPTCP-level seqno.
-		 * Note that it can happen in rare cases that fastopen_req is
-		 * NULL and syn_data is 0 but fastopen indeed occurred and
-		 * data has been queued in the write queue (but not sent).
-		 * Example of such rare cases: connect is non-blocking and
-		 * TFO is configured to work without cookies.
-		 */
-		if (tcp_rtx_queue_head(meta_sk))
-			mptcp_rcv_synsent_fastopen(meta_sk);
-
 		/* -1, because the SYN consumed 1 byte. In case of TFO, we
 		 * start the subflow-sequence number as if the data of the SYN
 		 * is not part of any mapping.
@@ -2068,9 +2000,6 @@ int mptcp_rcv_synsent_state_process(struct sock *sk, =
struct sock **skptr,
 =

 		tp->mptcp->include_mpc =3D 1;
 =

-		/* Ensure that fastopen is handled at the meta-level. */
-		tp->fastopen_req =3D NULL;
-
 		sk_set_socket(sk, meta_sk->sk_socket);
 		sk->sk_wq =3D meta_sk->sk_wq;
 =

diff --git a/net/mptcp/mptcp_output.c b/net/mptcp/mptcp_output.c
index 26cf41f75922..2d84eb2edd97 100644
--- a/net/mptcp/mptcp_output.c
+++ b/net/mptcp/mptcp_output.c
@@ -1292,12 +1292,9 @@ void mptcp_meta_retransmit_timer(struct sock *meta_s=
k)
 =

 void mptcp_sub_retransmit_timer(struct sock *sk)
 {
-	struct tcp_sock *tp =3D tcp_sk(sk);
-
 	tcp_retransmit_timer(sk);
 =

-	if (!tp->fastopen_rsk)
-		mptcp_set_rto(sk);
+	mptcp_set_rto(sk);
 }
 =

 /* Modify values to an mptcp-level for the initial window of new subflows =
*/
-- =

2.16.2


--===============7211572926167704877==--
