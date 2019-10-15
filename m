Content-Type: multipart/mixed; boundary="===============5032927888910502734=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/3] mptcp: flush duplicate data at data_ready() time
Date: Tue, 15 Oct 2019 17:44:43 +0200
Message-ID: <a74fc5635866de2df193e8016ed2a0e6d83168d6.1571152990.git.pabeni@redhat.com>
In-Reply-To: cover.1571152990.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2154

--===============5032927888910502734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Move subflow mapping related function to subflow.c - I think
they belong there.

Refactor slightly get_mapping() to additionally validate the
current mapping, moving some code from mptcp_recvmsg().

mptcp_data_ready() drops any skb which does not match exactly
the current MPTCP seq number.

Old seqs are likely spurious retransmit we really want to ignore
"future" seq may really happen in case of active backup switch-over,
but we should converge to the current seq via 'correct' MPTCP-level
retransmissions.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
RFC -> v1:
 - stricter checking in validate_mapping(): the skb
   must be fully covered by the current mapping
 - always re-validate valid mapping on new skb
 - always drop skb ext on MAP_OK
 - explicitly handle possible map_len overflow on
   map coalescing
 - added a bunch of hopefully more descriptive comments
---
 net/mptcp/protocol.c | 187 +---------------------------
 net/mptcp/protocol.h |  10 +-
 net/mptcp/subflow.c  | 289 ++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 298 insertions(+), 188 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a69872baf038..af06fc8f05f0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -387,17 +387,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msghd=
r *msg, size_t len)
 	return ret;
 }
 =

-static u64 expand_seq(u64 old_seq, u16 old_data_len, u64 seq)
-{
-	if ((u32)seq =3D=3D (u32)old_seq)
-		return old_seq;
-
-	/* Assume map covers data not mapped yet. */
-	return seq | ((old_seq + old_data_len + 1) & GENMASK_ULL(63, 32));
-}
-
 int mptcp_read_actor(read_descriptor_t *desc, struct sk_buff *skb,
-			    unsigned int offset, size_t len)
+		     unsigned int offset, size_t len)
 {
 	struct mptcp_read_arg *arg =3D desc->arg.data;
 	size_t copy_len;
@@ -425,88 +416,6 @@ int mptcp_read_actor(read_descriptor_t *desc, struct s=
k_buff *skb,
 	return copy_len;
 }
 =

-enum mapping_status {
-	MAPPING_ADDED,
-	MAPPING_MISSING,
-	MAPPING_EMPTY,
-	MAPPING_DATA_FIN
-};
-
-static enum mapping_status mptcp_get_mapping(struct sock *ssk)
-{
-	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
-	struct mptcp_ext *mpext;
-	enum mapping_status ret;
-	struct sk_buff *skb;
-	u64 map_seq;
-
-	skb =3D skb_peek(&ssk->sk_receive_queue);
-	if (!skb) {
-		pr_debug("Empty queue");
-		return MAPPING_EMPTY;
-	}
-
-	mpext =3D mptcp_get_ext(skb);
-
-	if (!mpext) {
-		/* This is expected for non-DSS data packets */
-		return MAPPING_MISSING;
-	}
-
-	if (!mpext->use_map) {
-		ret =3D MAPPING_MISSING;
-		goto del_out;
-	}
-
-	pr_debug("seq=3D%llu is64=3D%d ssn=3D%u data_len=3D%u", mpext->data_seq,
-		 mpext->dsn64, mpext->subflow_seq, mpext->data_len);
-
-	if (mpext->data_len =3D=3D 0) {
-		pr_err("Infinite mapping not handled");
-		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
-		ret =3D MAPPING_MISSING;
-		goto del_out;
-	} else if (mpext->subflow_seq =3D=3D 0 &&
-		   mpext->data_fin =3D=3D 1) {
-		pr_debug("DATA_FIN with no payload");
-		ret =3D MAPPING_DATA_FIN;
-		goto del_out;
-	}
-
-	if (!mpext->dsn64) {
-		map_seq =3D expand_seq(subflow->map_seq, subflow->map_data_len,
-				     mpext->data_seq);
-		pr_debug("expanded seq=3D%llu", subflow->map_seq);
-	} else {
-		map_seq =3D mpext->data_seq;
-	}
-
-	if (subflow->map_valid) {
-		/* due to GSO/TSO we can receive the same mapping multiple
-		 * times, before it's expiration.
-		 */
-		if (subflow->map_seq !=3D map_seq ||
-		    subflow->map_subflow_seq !=3D mpext->subflow_seq ||
-		    subflow->map_data_len !=3D mpext->data_len) {
-			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSNOMATCH);
-			pr_warn("Replaced mapping before it was done");
-		}
-	}
-
-	subflow->map_seq =3D map_seq;
-	subflow->map_subflow_seq =3D mpext->subflow_seq;
-	subflow->map_data_len =3D mpext->data_len;
-	subflow->map_valid =3D 1;
-	ret =3D MAPPING_ADDED;
-	pr_debug("new map seq=3D%llu subflow_seq=3D%u data_len=3D%u",
-		 subflow->map_seq, subflow->map_subflow_seq,
-		 subflow->map_data_len);
-
-del_out:
-	__skb_ext_del(skb, SKB_EXT_MPTCP);
-	return ret;
-}
-
 static void mptcp_wait_data(struct sock *sk, long *timeo)
 {
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
@@ -532,12 +441,6 @@ static void mptcp_wait_data(struct sock *sk, long *tim=
eo)
 	remove_wait_queue(sk_sleep(sk), &wait);
 }
 =

-static void warn_bad_map(struct mptcp_subflow_context *subflow, u32 ssn)
-{
-	WARN_ONCE(1, "Bad mapping: ssn=3D%d map_seq=3D%d map_data_len=3D%d",
-		  ssn, subflow->map_subflow_seq, subflow->map_data_len);
-}
-
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			 int nonblock, int flags, int *addr_len)
 {
@@ -573,6 +476,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 =

 	lock_sock(ssk);
 =

+	arg.msg =3D msg;
 	desc.arg.data =3D &arg;
 	desc.error =3D 0;
 =

@@ -581,120 +485,41 @@ static int mptcp_recvmsg(struct sock *sk, struct msg=
hdr *msg, size_t len,
 	len =3D min_t(size_t, len, INT_MAX);
 =

 	while (copied < len) {
-		enum mapping_status status;
 		u32 map_remaining;
 		int bytes_read;
 		u64 ack_seq;
 		u64 old_ack;
-		u32 ssn;
 =

 		smp_mb__before_atomic();
 		clear_bit(MPTCP_DATA_READY, &msk->flags);
 		smp_mb__after_atomic();
 =

-		status =3D mptcp_get_mapping(ssk);
-
-		if (status =3D=3D MAPPING_ADDED) {
-			/* Common case, but nothing to do here */
-		} else if (status =3D=3D MAPPING_MISSING) {
-			struct sk_buff *skb =3D skb_peek(&ssk->sk_receive_queue);
-
-			if (!skb->len) {
-				/* the TCP stack deliver 0 len FIN pkt
-				 * to the receive queue, that is the only
-				 * 0len pkts ever expected here, and we can
-				 * admit no mapping only for 0 len pkts
-				 */
-				if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN))
-					WARN_ONCE(1, "0len seq %d:%d flags %x",
-						  TCP_SKB_CB(skb)->seq,
-						  TCP_SKB_CB(skb)->end_seq,
-						  TCP_SKB_CB(skb)->tcp_flags);
-				sk_eat_skb(sk, skb);
-				continue;
-			}
-			if (!subflow->map_valid) {
-				WARN_ONCE(1, "corrupted stream: missing mapping");
-				copied =3D -EBADFD;
-				break;
-			}
-		} else if (status =3D=3D MAPPING_EMPTY) {
+		if (!mptcp_subflow_data_available(ssk))
 			goto wait_for_data;
-		} else if (status =3D=3D MAPPING_DATA_FIN) {
-			/* TODO: Handle according to RFC 6824 */
-			if (!copied) {
-				pr_err("Can't read after DATA_FIN");
-				copied =3D -ENOTCONN;
-			}
-
-			break;
-		}
 =

-		ssn =3D tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
 		old_ack =3D msk->ack_seq;
-
-		if (unlikely(before(ssn, subflow->map_subflow_seq))) {
-			/* Mapping covers data later in the subflow stream,
-			 * currently unsupported.
-			 */
-			warn_bad_map(subflow, ssn);
-			copied =3D -EBADFD;
-			break;
-		} else if (unlikely(!before(ssn, (subflow->map_subflow_seq +
-						  subflow->map_data_len)))) {
-			/* Mapping ends earlier in the subflow stream.
-			 * Invalid
-			 */
-			warn_bad_map(subflow, ssn);
-			copied =3D -EBADFD;
-			break;
-		}
-
 		ack_seq =3D mptcp_subflow_get_mapped_dsn(subflow);
 		map_remaining =3D subflow->map_data_len -
 				mptcp_subflow_get_map_offset(subflow);
 =

-		if (before64(ack_seq, old_ack)) {
-			/* Mapping covers data already received, discard data
-			 * in the current mapping
-			 */
-			arg.msg =3D NULL;
-			desc.count =3D min_t(size_t, old_ack - ack_seq,
-					   map_remaining);
-			pr_debug("Dup data, map len=3D%d acked=3D%lld dropped=3D%zu",
-				 map_remaining, old_ack - ack_seq, desc.count);
-		} else {
-			arg.msg =3D msg;
-			desc.count =3D min_t(size_t, len - copied, map_remaining);
-		}
-
 		/* Read mapped data */
+		desc.count =3D min_t(size_t, len - copied, map_remaining);
 		bytes_read =3D tcp_read_sock(ssk, &desc, mptcp_read_actor);
 		if (bytes_read < 0)
 			break;
 =

 		/* Refresh current MPTCP sequence number based on subflow seq */
 		ack_seq =3D mptcp_subflow_get_mapped_dsn(subflow);
-
 		if (before64(old_ack, ack_seq))
 			msk->ack_seq =3D ack_seq;
 =

-		if (!before(tcp_sk(ssk)->copied_seq - subflow->ssn_offset,
-			    subflow->map_subflow_seq + subflow->map_data_len)) {
-			subflow->map_valid =3D 0;
-			pr_debug("Done with mapping: seq=3D%u data_len=3D%u",
-				 subflow->map_subflow_seq,
-				 subflow->map_data_len);
-		}
-
-		if (arg.msg)
-			copied +=3D bytes_read;
+		copied +=3D bytes_read;
 =

 		/* The 'wait_for_data' code path can terminate the receive loop
 		 * in a number of scenarios: check if more data is pending
 		 * before giving up.
 		 */
-		if (!skb_queue_empty(&ssk->sk_receive_queue))
+		if (mptcp_subflow_data_available(ssk))
 			continue;
 =

 wait_for_data:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d1978c27d557..6b11a908cca7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -204,8 +204,8 @@ struct mptcp_subflow_context {
 	u32     rel_write_seq;
 	u32	map_subflow_seq;
 	u32	ssn_offset;
-	u16	map_data_len;
-	u16	request_mptcp : 1,  /* send MP_CAPABLE */
+	u32	map_data_len;
+	u32	request_mptcp : 1,  /* send MP_CAPABLE */
 		request_join : 1,   /* send MP_JOIN */
 		request_bkup : 1,
 		request_version : 4,
@@ -214,7 +214,9 @@ struct mptcp_subflow_context {
 		fourth_ack : 1,     /* send initial DSS */
 		conn_finished : 1,
 		map_valid : 1,
-		backup : 1;
+		backup : 1,
+		data_avail : 1,
+		rx_eof : 1;
 	u32	remote_nonce;
 	u64	thmac;
 	u32	local_nonce;
@@ -260,7 +262,7 @@ mptcp_subflow_get_mapped_dsn(struct mptcp_subflow_conte=
xt *subflow)
 }
 =

 int mptcp_is_enabled(struct net *net);
-
+bool mptcp_subflow_data_available(struct sock *sk);
 void mptcp_subflow_init(void);
 int mptcp_subflow_connect(struct sock *sk, struct sockaddr_in *local,
 			  struct sockaddr_in *remote, u8 remote_id);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index b0cda95fbe20..b2fd57341889 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -311,17 +311,300 @@ static struct sock *subflow_syn_recv_sock(const stru=
ct sock *sk,
 =

 static struct inet_connection_sock_af_ops subflow_specific;
 =

+enum mapping_status {
+	MAPPING_OK,
+	MAPPING_INVALID,
+	MAPPING_EMPTY,
+	MAPPING_DATA_FIN
+};
+
+static u64 expand_seq(u64 old_seq, u16 old_data_len, u64 seq)
+{
+	if ((u32)seq =3D=3D (u32)old_seq)
+		return old_seq;
+
+	/* Assume map covers data not mapped yet. */
+	return seq | ((old_seq + old_data_len + 1) & GENMASK_ULL(63, 32));
+}
+
+static void warn_bad_map(struct mptcp_subflow_context *subflow, u32 ssn)
+{
+	WARN_ONCE(1, "Bad mapping: ssn=3D%d map_seq=3D%d map_data_len=3D%d",
+		  ssn, subflow->map_subflow_seq, subflow->map_data_len);
+}
+
+static bool validate_mapping(struct sock *ssk, struct sk_buff *skb)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
+	u32 ssn =3D tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
+
+	if (unlikely(before(ssn, subflow->map_subflow_seq))) {
+		/* Mapping covers data later in the subflow stream,
+		 * currently unsupported.
+		 */
+		warn_bad_map(subflow, ssn);
+		return false;
+	}
+	if (unlikely(after(ssn + skb->len, subflow->map_subflow_seq +
+					   subflow->map_data_len))) {
+		/* Mapping does not cover the full skb. Invalid */
+		warn_bad_map(subflow, ssn + skb->len);
+		return false;
+	}
+	return true;
+}
+
+static enum mapping_status get_mapping_status(struct sock *ssk)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
+	struct mptcp_ext *mpext;
+	struct sk_buff *skb;
+	u64 map_seq;
+
+	skb =3D skb_peek(&ssk->sk_receive_queue);
+	if (!skb)
+		return MAPPING_EMPTY;
+
+	mpext =3D mptcp_get_ext(skb);
+	if (!mpext || !mpext->use_map) {
+		if (!subflow->map_valid && !skb->len) {
+			/* the TCP stack deliver 0 len FIN pkt to the receive
+			* queue, that is the only 0len pkts ever expected here,
+			* and we can admit no mapping only for 0 len pkts
+			*/
+			if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN))
+				WARN_ONCE(1, "0len seq %d:%d flags %x",
+					  TCP_SKB_CB(skb)->seq,
+					  TCP_SKB_CB(skb)->end_seq,
+					  TCP_SKB_CB(skb)->tcp_flags);
+			sk_eat_skb(ssk, skb);
+			return MAPPING_EMPTY;
+		}
+
+		if (!subflow->map_valid)
+			return MAPPING_INVALID;
+		goto validate_seq;
+	}
+
+	pr_debug("seq=3D%llu is64=3D%d ssn=3D%u data_len=3D%u", mpext->data_seq,
+		 mpext->dsn64, mpext->subflow_seq, mpext->data_len);
+
+	if (mpext->data_len =3D=3D 0) {
+		pr_err("Infinite mapping not handled");
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
+		return MAPPING_INVALID;
+	} else if (mpext->subflow_seq =3D=3D 0 &&
+		   mpext->data_fin =3D=3D 1) {
+		if (WARN_ON_ONCE(mpext->data_len !=3D 1))
+			return false;
+
+		/* do not try hard to handle this any better, till we have
+		 * real data_fin support
+		 */
+		pr_debug("DATA_FIN with no payload");
+		return MAPPING_OK;
+	}
+
+	if (!mpext->dsn64) {
+		map_seq =3D expand_seq(subflow->map_seq, subflow->map_data_len,
+				     mpext->data_seq);
+		pr_debug("expanded seq=3D%llu", subflow->map_seq);
+	} else {
+		map_seq =3D mpext->data_seq;
+	}
+
+	if (subflow->map_valid) {
+		/* check for in-sequence new map; since the current mapping
+		 * still valid, we can't replace it yet; instead just
+		 * coalesce it
+		 */
+		if (subflow->map_seq + subflow->map_data_len =3D=3D
+		    mpext->data_seq) {
+			subflow->map_data_len +=3D mpext->data_len;
+			if (unlikely(subflow->map_data_len > 1 << 30)) {
+				unsigned delta =3D subflow->map_data_len >> 1;
+
+				/* to avoid len overflows, just drop old bits of
+				 * the current mapping when it becomes really
+				 * big. delta is larger then the max map len
+				 * carried by the MPTCP extension, so the map
+				 * start will still be lower then the SSN
+				 */
+				subflow->map_data_len -=3D delta;
+				subflow->map_subflow_seq +=3D delta;
+				subflow->map_seq +=3D delta;
+			}
+			goto validate_seq;
+		}
+
+		/* Allow replacing only with an identical map  */
+		if (subflow->map_seq !=3D mpext->data_seq ||
+		    subflow->map_subflow_seq !=3D mpext->subflow_seq ||
+		    subflow->map_data_len !=3D mpext->data_len) {
+			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSNOMATCH);
+			return MAPPING_INVALID;
+		}
+
+		goto validate_seq;
+	}
+
+	subflow->map_seq =3D map_seq;
+	subflow->map_subflow_seq =3D mpext->subflow_seq;
+	subflow->map_data_len =3D mpext->data_len;
+	subflow->map_valid =3D 1;
+	pr_debug("new map seq=3D%llu subflow_seq=3D%u data_len=3D%u",
+		 subflow->map_seq, subflow->map_subflow_seq,
+		 subflow->map_data_len);
+
+validate_seq:
+	/* we revalidate valid mapping on new skb, because we must ensure
+	 * the current skb is completely covered by the available mapping
+	 */
+	if (!validate_mapping(ssk, skb))
+		return MAPPING_INVALID;
+
+	skb_ext_del(skb, SKB_EXT_MPTCP);
+	return MAPPING_OK;
+}
+
+static bool subflow_check_data_avail(struct sock *ssk)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
+	enum mapping_status status;
+	struct mptcp_sock *msk;
+	struct sk_buff *skb;
+
+	pr_debug("msk=3D%p ssk=3D%p data_avail=3D%d skb=3D%p", subflow->conn, ssk,
+		 subflow->data_avail, skb_peek(&ssk->sk_receive_queue));
+	if (subflow->data_avail)
+		return true;
+
+	if (!subflow->conn)
+		return false;
+
+	msk =3D mptcp_sk(subflow->conn);
+	for (;;) {
+		u32 map_remaining;
+		size_t delta;
+		u64 ack_seq;
+		u64 old_ack;
+
+		status =3D get_mapping_status(ssk);
+		pr_debug("msk=3D%p ssk=3D%p status=3D%d", msk, ssk, status);
+		if (status =3D=3D MAPPING_INVALID) {
+			ssk->sk_err =3D EBADMSG;
+			goto fatal;
+		}
+
+		if (status !=3D MAPPING_OK)
+			return false;
+
+		skb =3D skb_peek(&ssk->sk_receive_queue);
+		if (WARN_ON_ONCE(!skb))
+			return false;
+
+		old_ack =3D READ_ONCE(msk->ack_seq);
+		ack_seq =3D mptcp_subflow_get_mapped_dsn(subflow);
+		pr_debug("msk ack_seq=3D%llx subflow ack_seq=3D%llx", old_ack,
+			 ack_seq);
+		if (ack_seq =3D=3D old_ack)
+			break;
+
+		/* only accept in-sequence mapping. Old values are spurious
+		 * retransmission; we can hit "future" values on active backup
+		 * subflow switch, we relay on retransmissions to get
+		 * in-sequence data.
+		 * Cuncurrent subflows support will require subflow data
+		 * reordering
+		 */
+		map_remaining =3D subflow->map_data_len -
+				mptcp_subflow_get_map_offset(subflow);
+		if (before64(ack_seq, old_ack))
+			delta =3D min_t(size_t, old_ack - ack_seq, map_remaining);
+		else
+			delta =3D min_t(size_t, ack_seq - old_ack, map_remaining);
+
+		/* discard mapped data */
+		pr_debug("discarding %ld bytes, current map len=3D%d", delta,
+			 map_remaining);
+		if (delta) {
+			struct mptcp_read_arg arg =3D {
+				.msg =3D NULL,
+			};
+			read_descriptor_t desc =3D {
+				.count =3D delta,
+				.arg.data =3D &arg,
+			};
+			int ret;
+
+			ret =3D tcp_read_sock(ssk, &desc, mptcp_read_actor);
+			if (ret < 0) {
+				ssk->sk_err =3D -ret;
+				goto fatal;
+			}
+			if (ret < delta)
+				return false;
+			if (delta =3D=3D map_remaining)
+				subflow->map_valid =3D 0;
+		}
+	}
+	return true;
+
+fatal:
+	/* fatal protocol error, close the socket */
+	/* This barrier is coupled with smp_rmb() in tcp_poll() */
+	smp_wmb();
+	ssk->sk_error_report(ssk);
+	tcp_set_state(ssk, TCP_CLOSE);
+	tcp_send_active_reset(ssk, GFP_ATOMIC);
+	return false;
+}
+
+bool mptcp_subflow_data_available(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+	struct sk_buff *skb;
+
+	/* check if current mapping is still valid */
+	if (subflow->map_valid &&
+	    mptcp_subflow_get_map_offset(subflow) >=3D subflow->map_data_len) {
+		subflow->map_valid =3D 0;
+		subflow->data_avail =3D 0;
+
+		pr_debug("Done with mapping: seq=3D%u data_len=3D%u",
+			 subflow->map_subflow_seq,
+			 subflow->map_data_len);
+	}
+
+	if (!subflow_check_data_avail(sk)) {
+		/* set EoF only there is no data available - we already spooled
+		 * all the pending skbs
+		 */
+		if (sk->sk_shutdown & RCV_SHUTDOWN || sk->sk_state =3D=3D TCP_CLOSE)
+			subflow->rx_eof =3D 1;
+		return false;
+	}
+
+	skb =3D skb_peek(&sk->sk_receive_queue);
+	if (!skb)
+		return false;
+
+	subflow->data_avail =3D tcp_sk(sk)->copied_seq < TCP_SKB_CB(skb)->end_seq;
+	return subflow->data_avail;
+}
+
 static void subflow_data_ready(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct sock *parent =3D subflow->conn;
 =

-	pr_debug("sk=3D%p", sk);
 	subflow->tcp_sk_data_ready(sk);
 =

-	if (parent) {
-		pr_debug("parent=3D%p", parent);
+	if (!parent || !(subflow->mp_capable || subflow->mp_join))
+		return;
 =

+	/* always propagate the EoF */
+	if (mptcp_subflow_data_available(sk) || subflow->rx_eof) {
 		smp_mb__before_atomic();
 		set_bit(MPTCP_DATA_READY, &mptcp_sk(parent)->flags);
 		smp_mb__after_atomic();
-- =

2.21.0

--===============5032927888910502734==--
