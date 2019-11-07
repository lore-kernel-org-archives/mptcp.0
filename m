Content-Type: multipart/mixed; boundary="===============4394872465751257571=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/2] mptcp: process MP_CAPABLE data option.
Date: Thu, 07 Nov 2019 07:28:27 -0800
Message-ID: <20191107152827.54549-3-cpaasch@apple.com>
In-Reply-To: 20191107152827.54549-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 2437

--===============4394872465751257571==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On the server side we can receive the remote key after that the connection
is established. We need to explicitly track the 'missing remote key'
status and avoid emtting mptcp ack till we get such info.

When a late/retransmitted/OoO pkt carrying MP_CAPABLE[+data] option
is received, we have to propagate the mptcp seq number info to
the msk socket. To avoid ABBA locking issue, explicitly check for
that in recvmsg(), where we own msk and subflow sock locks.

The above also means that an established mp_capable subflow - still
waiting for the remote key - can be 'downgraded' to plain TCP.

Such change could potentially block forever reader waiting for new
data - as they hook to msk, while later wake-up after the downgrade
will be on subflow only.

The above issue is not handled here, we likely have to get rid of
msk->fallback to handle that cleanly.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/mptcp/options.c  | 60 +++++++++++++++++++++++++++++++++++---------
 net/mptcp/protocol.c | 22 ++++++++++------
 net/mptcp/protocol.h |  8 ++++--
 net/mptcp/subflow.c  | 38 ++++++++++++++++++++++++----
 4 files changed, 102 insertions(+), 26 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 9cdbd617c49a..ea7e96c96342 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -375,11 +375,13 @@ void mptcp_rcv_synsent(struct sock *sk)
 =

 	if (subflow->request_mptcp && tp->rx_opt.mptcp.mp_capable) {
 		subflow->mp_capable =3D 1;
+		subflow->can_ack =3D 1;
 		subflow->remote_key =3D tp->rx_opt.mptcp.sndr_key;
 		pr_debug("subflow=3D%p, remote_key=3D%llu", subflow,
 			 subflow->remote_key);
 	} else if (subflow->request_join && tp->rx_opt.mptcp.mp_join) {
 		subflow->mp_join =3D 1;
+		subflow->can_ack =3D 1;
 		subflow->thmac =3D tp->rx_opt.mptcp.thmac;
 		subflow->remote_nonce =3D tp->rx_opt.mptcp.nonce;
 		pr_debug("subflow=3D%p, thmac=3D%llu, remote_nonce=3D%u", subflow,
@@ -458,8 +460,10 @@ static bool mptcp_established_options_dss(struct sock =
*sk, struct sk_buff *skb,
 					  unsigned int remaining,
 					  struct mptcp_out_options *opts)
 {
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	unsigned int dss_size =3D 0;
 	struct mptcp_ext *mpext;
+	struct mptcp_sock *msk;
 	unsigned int ack_size;
 =

 	mpext =3D skb ? mptcp_get_ext(skb) : NULL;
@@ -480,6 +484,11 @@ static bool mptcp_established_options_dss(struct sock =
*sk, struct sk_buff *skb,
 		}
 	}
 =

+	opts->ext_copy.use_ack =3D 0;
+	msk =3D mptcp_sk(subflow->conn);
+	if (!msk || !READ_ONCE(msk->can_ack))
+		goto no_ack;
+
 	ack_size =3D TCPOLEN_MPTCP_DSS_ACK64;
 =

 	/* Add kind/length/subtype/flag overhead if mapping is not populated */
@@ -487,26 +496,16 @@ static bool mptcp_established_options_dss(struct sock=
 *sk, struct sk_buff *skb,
 		ack_size +=3D TCPOLEN_MPTCP_DSS_BASE;
 =

 	if (ack_size <=3D remaining) {
-		struct mptcp_sock *msk;
-
 		dss_size +=3D ack_size;
 =

-		msk =3D mptcp_sk(mptcp_subflow_ctx(sk)->conn);
-		if (msk) {
-			opts->ext_copy.data_ack =3D msk->ack_seq;
-		} else {
-			mptcp_crypto_key_sha1(mptcp_subflow_ctx(sk)->remote_key,
-					      NULL, &opts->ext_copy.data_ack);
-			opts->ext_copy.data_ack++;
-		}
-
+		opts->ext_copy.data_ack =3D msk->ack_seq;
 		opts->ext_copy.ack64 =3D 1;
 		opts->ext_copy.use_ack =3D 1;
 	} else {
-		opts->ext_copy.use_ack =3D 0;
 		WARN(1, "MPTCP: Ack dropped");
 	}
 =

+no_ack:
 	if (!dss_size)
 		return false;
 =

@@ -650,6 +649,41 @@ static void update_una(struct mptcp_sock *msk,
 	}
 }
 =

+static bool check_fourth_ack(struct mptcp_subflow_context *subflow,
+			     struct sk_buff *skb,
+			     struct mptcp_options_received *mp_opt)
+{
+	/* here we can process OoO, in-window pkts, only in-sequence 4th ack
+	 * are relevant
+	 */
+	if (likely(subflow->fourth_ack ||
+		   TCP_SKB_CB(skb)->seq !=3D subflow->ssn_offset + 1))
+		return true;
+
+	/* mp join is easier: any tcp ack will do for it */
+	if (subflow->mp_join) {
+		subflow->fourth_ack =3D 1;
+		return true;
+	}
+
+	if (mp_opt->use_ack)
+		subflow->fourth_ack =3D 1;
+
+	if (subflow->can_ack)
+		return true;
+
+	/* if still waiting for remote/client key, we exepct an
+	 * MP_CAPABLE + data as first establish packet
+	 */
+	if (!mp_opt->mp_capable) {
+		subflow->mp_capable =3D 0;
+		return false;
+	}
+	subflow->remote_key =3D mp_opt->sndr_key;
+	subflow->can_ack =3D 1;
+	return true;
+}
+
 void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb,
 			    struct tcp_options_received *opt_rx)
 {
@@ -662,6 +696,8 @@ void mptcp_incoming_options(struct sock *sk, struct sk_=
buff *skb,
 		return;
 =

 	mp_opt =3D &opt_rx->mptcp;
+	if (!check_fourth_ack(subflow, skb, mp_opt))
+		return;
 =

 	if (msk && mp_opt->add_addr) {
 		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9ad735a62330..8159d74947a9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -517,6 +517,12 @@ static int mptcp_recvmsg(struct sock *sk, struct msghd=
r *msg, size_t len,
 =

 		lock_sock(ssk);
 		while (mptcp_subflow_data_available(ssk) && !done) {
+			if (unlikely(!msk->can_ack)) {
+				msk->remote_key =3D subflow->remote_key;
+				msk->ack_seq =3D subflow->map_seq;
+				msk->can_ack =3D true;
+			}
+
 			/* try to read as much data as available */
 			map_remaining =3D subflow->map_data_len -
 					mptcp_subflow_get_map_offset(subflow);
@@ -823,7 +829,6 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 		__mptcp_init_sock(new_mptcp_sock);
 =

 		msk =3D mptcp_sk(new_mptcp_sock);
-		msk->remote_key =3D subflow->remote_key;
 		msk->local_key =3D subflow->local_key;
 		msk->token =3D subflow->token;
 =

@@ -832,11 +837,15 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
 =

 		mptcp_pm_new_connection(msk, 1);
 =

-		mptcp_crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
 		msk->write_seq =3D subflow->idsn + 1;
 		atomic64_set(&msk->snd_una, msk->write_seq);
-		ack_seq++;
-		msk->ack_seq =3D ack_seq;
+		if (subflow->can_ack) {
+			msk->can_ack =3D true;
+			msk->remote_key =3D subflow->remote_key;
+			mptcp_crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
+			ack_seq++;
+			msk->ack_seq =3D ack_seq;
+		}
 		newsk =3D new_mptcp_sock;
 		list_add(&subflow->node, &msk->conn_list);
 		bh_unlock_sock(new_mptcp_sock);
@@ -850,8 +859,6 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 		 * the receive path and process the pending ones
 		 */
 		lock_sock(new_sock->sk);
-		subflow->map_seq =3D ack_seq;
-		subflow->map_subflow_seq =3D 1;
 		subflow->rel_write_seq =3D 1;
 		subflow->tcp_sock =3D new_sock;
 		subflow->conn =3D new_mptcp_sock;
@@ -1005,11 +1012,12 @@ void mptcp_finish_connect(struct sock *sk, int mp_c=
apable)
 =

 		mptcp_pm_new_connection(msk, 0);
 =

-		mptcp_crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
 		msk->write_seq =3D subflow->idsn + 1;
 		atomic64_set(&msk->snd_una, msk->write_seq);
+		mptcp_crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
 		ack_seq++;
 		msk->ack_seq =3D ack_seq;
+		msk->can_ack =3D 1;
 		subflow->map_seq =3D ack_seq;
 		subflow->map_subflow_seq =3D 1;
 		subflow->rel_write_seq =3D 1;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5c96777f9b3c..896e6acd0370 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -134,6 +134,7 @@ struct mptcp_sock {
 	u32		token;
 	unsigned long	flags;
 	u16		dport;
+	bool		can_ack;
 	struct work_struct rtx_work;
 	struct list_head conn_list;
 	struct list_head rtx_queue;
@@ -172,9 +173,10 @@ static inline struct mptcp_data_frag *mptcp_rtx_head(c=
onst struct sock *sk)
 =

 struct mptcp_subflow_request_sock {
 	struct	tcp_request_sock sk;
-	u8	mp_capable : 1,
+	u16	mp_capable : 1,
 		mp_join : 1,
 		backup : 1,
+		remote_key_valid : 1,
 		version : 4;
 	u8	local_id;
 	u8	remote_id;
@@ -216,9 +218,11 @@ struct mptcp_subflow_context {
 		fourth_ack : 1,	    /* send initial DSS */
 		conn_finished : 1,
 		map_valid : 1,
+		mp_capable_map : 1,
 		backup : 1,
 		data_avail : 1,
-		rx_eof : 1;
+		rx_eof : 1,
+		can_ack : 1;	    /* only after processing the remote a key */
 	u32	remote_nonce;
 	u64	thmac;
 	u32	local_nonce;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index dce5bf137eea..e9a499508363 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -108,6 +108,7 @@ static void subflow_v4_init_req(struct request_sock *re=
q,
 =

 	subflow_req->mp_capable =3D 0;
 	subflow_req->mp_join =3D 0;
+	subflow_req->remote_key_valid =3D 0;
 =

 	if (rx_opt.mptcp.mp_capable) {
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPCAPABLEPASSIVE);
@@ -265,15 +266,25 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
 =

 	pr_debug("listener=3D%p, req=3D%p, conn=3D%p", listener, req, listener->c=
onn);
 =

-	/* if the sk is MP_CAPABLE, we need to fetch the client key */
+	/* if the sk is MP_CAPABLE, we try to fetch the client key */
 	subflow_req =3D mptcp_subflow_rsk(req);
 	if (subflow_req->mp_capable) {
+		if (TCP_SKB_CB(skb)->seq !=3D subflow_req->ssn_offset + 1) {
+			/* here we can receive and accept an in-window,
+			 * out-of-order pkt, which will not carry the MP_CAPABLE
+			 * opt even on mptcp enabled paths
+			 */
+			goto create_child;
+		}
+
 		opt_rx.mptcp.mp_capable =3D 0;
 		mptcp_get_options(skb, &opt_rx);
-		if (!opt_rx.mptcp.mp_capable)
-			subflow_req->mp_capable =3D 0;
-		else
+		if (opt_rx.mptcp.mp_capable) {
 			subflow_req->remote_key =3D opt_rx.mptcp.sndr_key;
+			subflow_req->remote_key_valid =3D 1;
+		} else {
+			subflow_req->mp_capable =3D 0;
+		}
 	} else if (subflow_req->mp_join) {
 		opt_rx.mptcp.mp_join =3D 0;
 		mptcp_get_options(skb, &opt_rx);
@@ -282,6 +293,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 			return NULL;
 	}
 =

+create_child:
 	child =3D tcp_v4_syn_recv_sock(sk, skb, req, dst, req_unhash, own_req);
 =

 	if (child && *own_req) {
@@ -457,6 +469,7 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk)
 	subflow->map_subflow_seq =3D mpext->subflow_seq;
 	subflow->map_data_len =3D mpext->data_len;
 	subflow->map_valid =3D 1;
+	subflow->mp_capable_map =3D mpext->mp_capable_map;
 	pr_debug("new map seq=3D%llu subflow_seq=3D%u data_len=3D%u",
 		 subflow->map_seq, subflow->map_subflow_seq,
 		 subflow->map_data_len);
@@ -508,6 +521,16 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		if (WARN_ON_ONCE(!skb))
 			return false;
 =

+		/* if msk lacks the remote key, this subflow must provide an
+		 * MP_CAPABLE-based mapping
+		 */
+		if (unlikely(!READ_ONCE(msk->ack_seq))) {
+			if (subflow->mp_capable_map)
+				break;
+			ssk->sk_err =3D EBADMSG;
+			goto fatal;
+		}
+
 		old_ack =3D READ_ONCE(msk->ack_seq);
 		ack_seq =3D mptcp_subflow_get_mapped_dsn(subflow);
 		pr_debug("msk ack_seq=3D%llx subflow ack_seq=3D%llx", old_ack,
@@ -815,14 +838,19 @@ static void subflow_ulp_clone(const struct request_so=
ck *req,
 	new_ctx->tcp_sk_data_ready =3D old_ctx->tcp_sk_data_ready;
 =

 	if (subflow_req->mp_capable) {
+		/* see comments in subflow_syn_recv_sock(), MPTCP connection
+		 * is fully establishged only after we receive the remote key
+		 */
 		new_ctx->mp_capable =3D 1;
-		new_ctx->fourth_ack =3D 1;
+		new_ctx->fourth_ack =3D subflow_req->remote_key_valid;
+		new_ctx->can_ack =3D subflow_req->remote_key_valid;
 		new_ctx->remote_key =3D subflow_req->remote_key;
 		new_ctx->local_key =3D subflow_req->local_key;
 		new_ctx->token =3D subflow_req->token;
 		new_ctx->ssn_offset =3D subflow_req->ssn_offset;
 		new_ctx->idsn =3D subflow_req->idsn;
 	} else if (subflow_req->mp_join) {
+		new_ctx->can_ack =3D 1;
 		new_ctx->mp_join =3D 1;
 		new_ctx->fourth_ack =3D 1;
 		new_ctx->backup =3D subflow_req->backup;
-- =

2.23.0

--===============4394872465751257571==--
