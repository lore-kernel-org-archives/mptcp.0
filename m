Content-Type: multipart/mixed; boundary="===============7175711424856875560=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] net: mptcp: improve fallback to TCP
Date: Fri, 29 May 2020 10:21:47 +0200
Message-ID: <dda3f31d39426bd93b8d5ac26f132c6630fcb815.1590740223.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4549

--===============7175711424856875560==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

keep using MPTCP sockets and a "dummy mapping" in case of fallback to
regular TCP. Skip adding DSS option on send, if TCP fallback has been
done earlier.

Notes: I'm unsure on what to do in mptcp_clean_una() to do a one-time
flush of the retransmit queue, as per Mat's suggestion. Any advice?

Changes since RFC v2:
 - use a bit in msk->flags, rather than a dedicated boolean in struct
   msk. This bit is going to be used in combination with another one,
   TCP_FALLBACK_ALLOWED, that is 1 at the first subflow creation
   and gets cleared once TCP fallback is no more allowed.
 - separate code that adds support for "infinite mapping", and use
   the term "dummy" instead of "infinite". Suggested by Mat
 - remove inappropriate call to __mptcp_do_fallback() in
   mptcp_accept() (Paolo)

Changes since RFC v1:
 - use a dedicated member of struct msk to indicate that a fallback
   ha happened, use it in case of infinite mapping
 - don't delete skb_ext in case of infinite mapping (Mat)
 - test the value of pm.subflows on reception of an infinite map to
   ensure that no other subflow is currently opened (Mat)
 - in mptcp_established_options(), avoid adding TCP options in case
   of fallback indication; simplify sendmsg()/recvmsg()/poll() to
   keep using the MPTCP socket in case of TCP fallback. Set the
   fallback indication in case subflow is not mp_capable after
   successful 3-way handshake, instead of flipping 'is_mptcp'
   (Paolo/Mat)
 - remove deadcode in mptcp_finish_connect, and increment
   MPTCP_MIB_MPCAPABLEACTIVEFALLBACK in subflow_finish_connect
   (Paolo)

BugLink: https://github.com/multipath-tcp/mptcp_net-next/issues/11
BugLink: https://github.com/multipath-tcp/mptcp_net-next/issues/22
Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---
 net/mptcp/options.c  |  9 +++++-
 net/mptcp/protocol.c | 77 +++++++++++---------------------------------
 net/mptcp/protocol.h | 34 +++++++++++++++++++
 net/mptcp/subflow.c  | 46 +++++++++++++++++---------
 4 files changed, 90 insertions(+), 76 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 01f1f4cf4902a..cf0b59ead1e43 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -624,6 +624,9 @@ bool mptcp_established_options(struct sock *sk, struct =
sk_buff *skb,
 =

 	opts->suboptions =3D 0;
 =

+	if (unlikely(mptcp_check_fallback(sk)))
+		return false;
+
 	if (mptcp_established_options_mp(sk, skb, &opt_size, remaining, opts))
 		ret =3D true;
 	else if (mptcp_established_options_dss(sk, skb, &opt_size, remaining,
@@ -714,7 +717,8 @@ static bool check_fully_established(struct mptcp_sock *=
msk, struct sock *sk,
 	 */
 	if (!mp_opt->mp_capable) {
 		subflow->mp_capable =3D 0;
-		tcp_sk(sk)->is_mptcp =3D 0;
+		pr_fallback(msk);
+		__mptcp_do_fallback(msk);
 		return false;
 	}
 =

@@ -814,6 +818,9 @@ void mptcp_incoming_options(struct sock *sk, struct sk_=
buff *skb,
 	struct mptcp_options_received mp_opt;
 	struct mptcp_ext *mpext;
 =

+	if (__mptcp_check_fallback(msk))
+		return;
+
 	mptcp_get_options(skb, &mp_opt);
 	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
 		return;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b2c8b57e7942a..c2786c661f2fb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -52,11 +52,6 @@ static struct socket *__mptcp_nmpc_socket(const struct m=
ptcp_sock *msk)
 	return msk->subflow;
 }
 =

-static bool __mptcp_needs_tcp_fallback(const struct mptcp_sock *msk)
-{
-	return msk->first && !sk_is_mptcp(msk->first);
-}
-
 static struct socket *mptcp_is_tcpsk(struct sock *sk)
 {
 	struct socket *sock =3D sk->sk_socket;
@@ -94,7 +89,7 @@ static struct socket *__mptcp_tcp_fallback(struct mptcp_s=
ock *msk)
 	if (unlikely(sock))
 		return sock;
 =

-	if (likely(!__mptcp_needs_tcp_fallback(msk)))
+	if (likely(!__mptcp_check_fallback(msk)))
 		return NULL;
 =

 	return msk->subflow;
@@ -229,6 +224,15 @@ static bool __mptcp_move_skbs_from_subflow(struct mptc=
p_sock *msk,
 		if (!skb)
 			break;
 =

+		if (__mptcp_check_fallback(msk)) {
+			/* if we are running under the workqueue, TCP could have
+			 * collapsed skbs between dummy map creation and now
+			 * be sure to adjust the size
+			 */
+			map_remaining =3D skb->len;
+			subflow->map_data_len =3D skb->len;
+		}
+
 		offset =3D seq - TCP_SKB_CB(skb)->seq;
 		fin =3D TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN;
 		if (fin) {
@@ -445,8 +449,15 @@ static void mptcp_clean_una(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct mptcp_data_frag *dtmp, *dfrag;
-	u64 snd_una =3D atomic64_read(&msk->snd_una);
 	bool cleaned =3D false;
+	u64 snd_una;
+
+	/* on fallback we just need to ignore snd_una, as this is really
+	 * plain TCP
+	 */
+	if (__mptcp_check_fallback(msk))
+		atomic64_set(&msk->snd_una, msk->write_seq);
+	snd_una =3D atomic64_read(&msk->snd_una);
 =

 	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list) {
 		if (after64(dfrag->data_seq + dfrag->data_len, snd_una))
@@ -719,7 +730,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 	int mss_now =3D 0, size_goal =3D 0, ret =3D 0;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct page_frag *pfrag;
-	struct socket *ssock;
 	size_t copied =3D 0;
 	struct sock *ssk;
 	bool tx_ok;
@@ -738,15 +748,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghd=
r *msg, size_t len)
 			goto out;
 	}
 =

-fallback:
-	ssock =3D __mptcp_tcp_fallback(msk);
-	if (unlikely(ssock)) {
-		release_sock(sk);
-		pr_debug("fallback passthrough");
-		ret =3D sock_sendmsg(ssock, msg);
-		return ret >=3D 0 ? ret + copied : (copied ? copied : ret);
-	}
-
 	pfrag =3D sk_page_frag(sk);
 restart:
 	mptcp_clean_una(sk);
@@ -798,17 +799,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghd=
r *msg, size_t len)
 			}
 			break;
 		}
-		if (ret =3D=3D 0 && unlikely(__mptcp_needs_tcp_fallback(msk))) {
-			/* Can happen for passive sockets:
-			 * 3WHS negotiated MPTCP, but first packet after is
-			 * plain TCP (e.g. due to middlebox filtering unknown
-			 * options).
-			 *
-			 * Fall back to TCP.
-			 */
-			release_sock(ssk);
-			goto fallback;
-		}
 =

 		copied +=3D ret;
 =

@@ -951,7 +941,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 			 int nonblock, int flags, int *addr_len)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	struct socket *ssock;
 	int copied =3D 0;
 	int target;
 	long timeo;
@@ -960,16 +949,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghd=
r *msg, size_t len,
 		return -EOPNOTSUPP;
 =

 	lock_sock(sk);
-	ssock =3D __mptcp_tcp_fallback(msk);
-	if (unlikely(ssock)) {
-fallback:
-		release_sock(sk);
-		pr_debug("fallback-read subflow=3D%p",
-			 mptcp_subflow_ctx(ssock->sk));
-		copied =3D sock_recvmsg(ssock, msg, flags);
-		return copied;
-	}
-
 	timeo =3D sock_rcvtimeo(sk, nonblock);
 =

 	len =3D min_t(size_t, len, INT_MAX);
@@ -1032,8 +1011,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
 =

 		pr_debug("block timeout %ld", timeo);
 		mptcp_wait_data(sk, &timeo);
-		if (unlikely(__mptcp_tcp_fallback(msk)))
-			goto fallback;
 	}
 =

 	if (skb_queue_empty(&sk->sk_receive_queue)) {
@@ -1652,12 +1629,6 @@ void mptcp_finish_connect(struct sock *ssk)
 	sk =3D subflow->conn;
 	msk =3D mptcp_sk(sk);
 =

-	if (!subflow->mp_capable) {
-		MPTCP_INC_STATS(sock_net(sk),
-				MPTCP_MIB_MPCAPABLEACTIVEFALLBACK);
-		return;
-	}
-
 	pr_debug("msk=3D%p, token=3D%u", sk, subflow->token);
 =

 	mptcp_crypto_key_sha(subflow->remote_key, NULL, &ack_seq);
@@ -1933,21 +1904,9 @@ static __poll_t mptcp_poll(struct file *file, struct=
 socket *sock,
 {
 	struct sock *sk =3D sock->sk;
 	struct mptcp_sock *msk;
-	struct socket *ssock;
 	__poll_t mask =3D 0;
 =

 	msk =3D mptcp_sk(sk);
-	lock_sock(sk);
-	ssock =3D __mptcp_tcp_fallback(msk);
-	if (!ssock)
-		ssock =3D __mptcp_nmpc_socket(msk);
-	if (ssock) {
-		mask =3D ssock->ops->poll(file, ssock, wait);
-		release_sock(sk);
-		return mask;
-	}
-
-	release_sock(sk);
 	sock_poll_wait(file, sock, wait);
 	lock_sock(sk);
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 809687d3f4100..efc6436052e2d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -89,6 +89,7 @@
 #define MPTCP_SEND_SPACE	1
 #define MPTCP_WORK_RTX		2
 #define MPTCP_WORK_EOF		3
+#define MPTCP_FALLBACK_DONE	4
 =

 struct mptcp_options_received {
 	u64	sndr_key;
@@ -458,4 +459,37 @@ static inline bool before64(__u64 seq1, __u64 seq2)
 =

 void mptcp_diag_subflow_init(struct tcp_ulp_ops *ops);
 =

+static inline bool __mptcp_check_fallback(struct mptcp_sock *msk)
+{
+	return test_bit(MPTCP_FALLBACK_DONE, &msk->flags);
+}
+
+static inline bool mptcp_check_fallback(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
+
+	return __mptcp_check_fallback(msk);
+}
+
+static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
+{
+	if (test_bit(MPTCP_FALLBACK_DONE, &msk->flags)) {
+		pr_debug("TCP fallback already done (msk=3D%p)", msk);
+		return;
+	}
+	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
+}
+
+static inline void mptcp_do_fallback(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
+
+	__mptcp_do_fallback(msk);
+}
+
+#define pr_fallback(a) do { pr_debug("%s:fallback to TCP (msk=3D%p)",\
+				      __FUNCTION__, a); } while (0)
+
 #endif /* __MPTCP_PROTOCOL_H */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f3c06b8af92de..59c6de6fac3fb 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -223,7 +223,6 @@ static void subflow_finish_connect(struct sock *sk, con=
st struct sk_buff *skb)
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct mptcp_options_received mp_opt;
 	struct sock *parent =3D subflow->conn;
-	struct tcp_sock *tp =3D tcp_sk(sk);
 =

 	subflow->icsk_af_ops->sk_rx_dst_set(sk, skb);
 =

@@ -237,6 +236,8 @@ static void subflow_finish_connect(struct sock *sk, con=
st struct sk_buff *skb)
 		return;
 =

 	subflow->conn_finished =3D 1;
+	subflow->ssn_offset =3D TCP_SKB_CB(skb)->seq;
+	pr_debug("subflow=3D%p synack seq=3D%x", subflow, subflow->ssn_offset);
 =

 	mptcp_get_options(skb, &mp_opt);
 	if (subflow->request_mptcp && mp_opt.mp_capable) {
@@ -252,21 +253,19 @@ static void subflow_finish_connect(struct sock *sk, c=
onst struct sk_buff *skb)
 		pr_debug("subflow=3D%p, thmac=3D%llu, remote_nonce=3D%u", subflow,
 			 subflow->thmac, subflow->remote_nonce);
 	} else if (subflow->request_mptcp) {
-		tp->is_mptcp =3D 0;
+		mptcp_do_fallback(sk);
+		pr_fallback(mptcp_sk(subflow->conn));
+		MPTCP_INC_STATS(sock_net(sk),
+				MPTCP_MIB_MPCAPABLEACTIVEFALLBACK);
 	}
 =

-	if (!tp->is_mptcp)
+	if (mptcp_check_fallback(sk))
 		return;
 =

 	if (subflow->mp_capable) {
 		pr_debug("subflow=3D%p, remote_key=3D%llu", mptcp_subflow_ctx(sk),
 			 subflow->remote_key);
 		mptcp_finish_connect(sk);
-
-		if (skb) {
-			pr_debug("synack seq=3D%u", TCP_SKB_CB(skb)->seq);
-			subflow->ssn_offset =3D TCP_SKB_CB(skb)->seq;
-		}
 	} else if (subflow->mp_join) {
 		u8 hmac[SHA256_DIGEST_SIZE];
 =

@@ -286,9 +285,6 @@ static void subflow_finish_connect(struct sock *sk, con=
st struct sk_buff *skb)
 =

 		memcpy(subflow->hmac, hmac, MPTCPOPT_HMAC_LEN);
 =

-		if (skb)
-			subflow->ssn_offset =3D TCP_SKB_CB(skb)->seq;
-
 		if (!mptcp_finish_join(sk))
 			goto do_reset;
 =

@@ -552,7 +548,8 @@ enum mapping_status {
 	MAPPING_OK,
 	MAPPING_INVALID,
 	MAPPING_EMPTY,
-	MAPPING_DATA_FIN
+	MAPPING_DATA_FIN,
+	MAPPING_DUMMY
 };
 =

 static u64 expand_seq(u64 old_seq, u16 old_data_len, u64 seq)
@@ -616,6 +613,9 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk)
 	if (!skb)
 		return MAPPING_EMPTY;
 =

+	if (mptcp_check_fallback(ssk))
+		return MAPPING_DUMMY;
+
 	mpext =3D mptcp_get_ext(skb);
 	if (!mpext || !mpext->use_map) {
 		if (!subflow->map_valid && !skb->len) {
@@ -757,6 +757,16 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			ssk->sk_err =3D EBADMSG;
 			goto fatal;
 		}
+		if (status =3D=3D MAPPING_DUMMY) {
+			__mptcp_do_fallback(msk);
+			skb =3D skb_peek(&ssk->sk_receive_queue);
+			subflow->map_valid =3D 1;
+			subflow->map_seq =3D READ_ONCE(msk->ack_seq);
+			subflow->map_data_len =3D skb->len;
+			subflow->map_subflow_seq =3D tcp_sk(ssk)->copied_seq -
+						   subflow->ssn_offset;
+			return true;
+		}
 =

 		if (status !=3D MAPPING_OK)
 			return false;
@@ -880,14 +890,18 @@ static void subflow_data_ready(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct sock *parent =3D subflow->conn;
+	struct mptcp_sock *msk;
 =

-	if (!subflow->mp_capable && !subflow->mp_join) {
-		subflow->tcp_data_ready(sk);
-
+	msk =3D mptcp_sk(parent);
+	if (inet_sk_state_load(sk) =3D=3D TCP_LISTEN) {
+		set_bit(MPTCP_DATA_READY, &msk->flags);
 		parent->sk_data_ready(parent);
 		return;
 	}
 =

+	WARN_ON_ONCE(!__mptcp_check_fallback(msk) && !subflow->mp_capable &&
+		     !subflow->mp_join);
+
 	if (mptcp_subflow_data_available(sk))
 		mptcp_data_ready(parent, sk);
 }
@@ -1110,7 +1124,7 @@ static void subflow_state_change(struct sock *sk)
 	 * a fin packet carrying a DSS can be unnoticed if we don't trigger
 	 * the data available machinery here.
 	 */
-	if (subflow->mp_capable && mptcp_subflow_data_available(sk))
+	if (mptcp_subflow_data_available(sk))
 		mptcp_data_ready(parent, sk);
 =

 	if (!(parent->sk_shutdown & RCV_SHUTDOWN) &&
-- =

2.26.2

--===============7175711424856875560==--
