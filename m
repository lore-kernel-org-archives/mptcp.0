Content-Type: multipart/mixed; boundary="===============5548413395606877956=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 16/16] mptcp: Write MPTCP DSS headers to outgoing
 data packets
Date: Wed, 28 Mar 2018 16:18:40 -0700
Message-ID: <20180328231840.12410-17-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20180328231840.12410-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 458

--===============5548413395606877956==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Per-packet metadata required to write the MPTCP DSS option is written to
the skb shared control buffer. One write to the socket may contain more
than one packet of data, in which case the DSS option in the first
packet will have a mapping covering all of the data in that
write. Packets after the first do not have a DSS option. This is
complicated to handle under memory pressure, since the first packet
(with the DSS mapping) is pushed to the TCP core before the remaining
skbs are allocated.

The current implementation is limited. If a non-blocking write only
succeeds in sending part of the data, the mapping that was in the first
packet will cover data that was not sent and is not buffered within the
kernel. There's no guarantee that the socket user will write the same
(or any) data when the socket becomes writable again.

The MPTCP DSS checksum is not yet implemented.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 include/net/mptcp.h   |  30 +++++-
 net/ipv4/tcp_output.c | 144 +++++++++++++++++++++----
 net/mptcp/protocol.c  | 285 ++++++++++++++++++++++++++++++++++++++++++++++=
+---
 net/mptcp/token.c     |  13 +--
 4 files changed, 432 insertions(+), 40 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 06bf49844c86..bacfc0683ba9 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -39,6 +39,8 @@ struct mptcp_sock {
 	struct	inet_connection_sock sk;
 	u64	local_key;
 	u64	remote_key;
+	u64	write_seq;
+	u64	ack_seq;
 	u32	token;
 	struct	socket *connection_list; /* @@ needs to be a list */
 	struct	socket *subflow; /* outgoing connect, listener or !mp_capable */
@@ -49,13 +51,36 @@ static inline struct mptcp_sock *mptcp_sk(const struct =
sock *sk)
 	return (struct mptcp_sock *)sk;
 }
 =

+/* MPTCP sk_buff extended control buffer */
+struct mptcp_skb_ext_cb {
+	u64	data_ack;
+	u64	data_seq;
+	u32	subflow_seq;
+	u16	data_level_len;
+	u16	checksum;
+	u8	use_ack:1,
+		ack64:1,
+		use_map:1,
+		dsn64:1,
+		use_checksum:1,
+		data_fin:1,
+		__unused:2;
+};
+
+static inline struct mptcp_skb_ext_cb *mptcp_skb_ecb(struct sk_buff *skb)
+{
+	return (struct mptcp_skb_ext_cb *)skb_shinfo_ext(skb)->shcb;
+}
+
 /* MPTCP subflow sock structure */
 struct subflow_sock {
 	/* tcp_sock must be the first member */
 	struct	tcp_sock sk;
 	u64	local_key;
-	u64	remote_key;
 	u32	token;
+	u64	idsn;
+	u64	remote_key;
+	u32	rel_write_seq;
 	bool	request_mptcp;	// send MP_CAPABLE
 	bool	checksum;
 	bool	version;
@@ -77,8 +102,9 @@ struct subflow_request_sock {
 		backup : 1,
 		version : 4;
 	u64	local_key;
-	u64	remote_key;
 	u32	token;
+	u64	idsn;
+	u64	remote_key;
 };
 =

 static inline
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 2c28e8d60a4a..d753442417fe 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -407,6 +407,8 @@ static inline bool tcp_urg_mode(const struct tcp_sock *=
tp)
 #define OPTION_SMC		(1 << 9)
 #define OPTION_MPTCP		(1 << 10)
 #define OPTION_MPTCP_ACK	(1 << 11)
+#define OPTION_MPTCP_DSS_MAP	(1 << 12)
+#define OPTION_MPTCP_DSS_ACK	(1 << 13)
 =

 static void smc_options_write(__be32 *ptr, u16 *options)
 {
@@ -449,8 +451,8 @@ struct tcp_out_options {
  * At least SACK_PERM as the first option is known to lead to a disaster
  * (but it may well be that other scenarios fail similarly).
  */
-static void tcp_options_write(__be32 *ptr, struct tcp_sock *tp,
-			      struct tcp_out_options *opts)
+static void tcp_options_write(__be32 *ptr, struct sk_buff *skb,
+			      struct tcp_sock *tp, struct tcp_out_options *opts)
 {
 	u16 options =3D opts->options;	/* mungable copy */
 =

@@ -567,6 +569,66 @@ static void tcp_options_write(__be32 *ptr, struct tcp_=
sock *tp,
 		memcpy(p, &opts->rcvr_key, 8);
 		pr_debug("tcp_options_write: opts->rcvr_key=3D%llu", opts->rcvr_key);
 	}
+
+	if ((OPTION_MPTCP_DSS_MAP | OPTION_MPTCP_DSS_ACK) & options) {
+		struct mptcp_skb_ext_cb *ecb =3D mptcp_skb_ecb(skb);
+		bool write_ack =3D (OPTION_MPTCP_DSS_ACK & options) && ecb->use_ack;
+		bool write_map =3D (OPTION_MPTCP_DSS_MAP & options) && ecb->use_map;
+		u8 flags =3D 0;
+		u8 len =3D 4;
+		u8 *p =3D (u8 *)ptr;
+
+		BUG_ON(!skb_shinfo(skb)->is_ext);
+		BUG_ON(!write_ack && !write_map);
+
+		if (write_ack) {
+			len +=3D 8;
+			flags =3D 0x03;
+		}
+
+		if (write_map) {
+			len +=3D 14;
+
+			if (ecb->use_checksum)
+				len +=3D 2;
+
+			/* Use only 64-bit mapping flags for now, add
+			 * support for optional 32-bit mappings later.
+			 */
+			flags |=3D 0x0c;
+			if (ecb->data_fin)
+				flags |=3D 0x10;
+		}
+
+		*p++ =3D 0x1e; // TCP option: Multipath TCP
+		*p++ =3D len;  // length
+		*p++ =3D 0x20; // subtype=3DDSS
+		*p++ =3D flags;
+
+		if (write_ack) {
+			*(__be64 *)p =3D cpu_to_be64(ecb->data_ack);
+			p +=3D 8;
+		}
+
+		if (write_map) {
+			*(__be64 *)p =3D cpu_to_be64(ecb->data_seq);
+			p +=3D 8;
+
+			*(__be32 *)p =3D htonl(ecb->subflow_seq);
+			p +=3D 4;
+
+			*(__be16 *)p =3D htons(ecb->data_level_len);
+			p +=3D 2;
+
+			if (ecb->use_checksum) {
+				*(__be16 *)p =3D htons(ecb->checksum);
+				p +=3D 2;
+			} else {
+				*p++ =3D TCPOPT_NOP;
+				*p++ =3D TCPOPT_NOP;
+			}
+		}
+	}
 }
 =

 static void smc_set_option(const struct tcp_sock *tp,
@@ -786,22 +848,11 @@ static unsigned int tcp_established_options(struct so=
ck *sk, struct sk_buff *skb
 		size +=3D TCPOLEN_TSTAMP_ALIGNED;
 	}
 =

-	eff_sacks =3D tp->rx_opt.num_sacks + tp->rx_opt.dsack;
-	if (unlikely(eff_sacks)) {
-		const unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
-		opts->num_sack_blocks =3D
-			min_t(unsigned int, eff_sacks,
-			      (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
-			      TCPOLEN_SACK_PERBLOCK);
-		size +=3D TCPOLEN_SACK_BASE_ALIGNED +
-			opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
-	}
-
 	if (tp->is_mptcp) {
 		struct subflow_sock *subflow =3D subflow_sk(sk);
 		pr_debug("tcp_established_options: subflow=3D%p", subflow);
 		if (subflow->mp_capable) {
-			const unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
+			unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
 			pr_debug("tcp_established_options: remaining=3D%d", remaining);
 			if (!subflow->fourth_ack) {
 				pr_debug("tcp_established_options: OPTION_MPTCP_ACK");
@@ -813,13 +864,65 @@ static unsigned int tcp_established_options(struct so=
ck *sk, struct sk_buff *skb
 				}
 				subflow->fourth_ack =3D 1;
 				// @@ also this is where first DSS goes in?
-			}
-			else {
-				pr_debug("tcp_established_options: OPTION_MPTCP_DSS");
-				// @@ send DSS based on remaining
+			} else if (skb && skb_shinfo(skb)->is_ext) {
+				struct mptcp_skb_ext_cb *ecb;
+				unsigned int dss_size =3D 0;
+				u16 options =3D 0;
+
+				ecb =3D mptcp_skb_ecb(skb);
+
+				if (ecb->use_map) {
+					unsigned int map_size =3D 18;
+
+					if (ecb->use_checksum)
+						map_size +=3D 2;
+
+					if (map_size <=3D remaining) {
+						remaining -=3D map_size;
+						dss_size =3D map_size;
+						options =3D OPTION_MPTCP_DSS_MAP;
+					} else {
+						WARN(1, "MPTCP: Map dropped");
+					}
+				}
+
+				if (ecb->use_ack) {
+					unsigned int ack_size =3D 8;
+
+					/* Add kind/length/subtype/flag
+					 * overhead if mapping not populated
+					 */
+					if (dss_size =3D=3D 0)
+						ack_size +=3D 4;
+
+					if (ack_size <=3D remaining) {
+						dss_size +=3D ack_size;
+						options |=3D OPTION_MPTCP_DSS_ACK;
+					} else {
+						WARN(1, "MPTCP: Ack dropped");
+					}
+				}
+
+				if (dss_size) {
+					size +=3D ALIGN(dss_size, 4);
+					opts->options |=3D options;
+					pr_debug("dss_size=3D%u size=3D%u", dss_size, size);
+				}
 			}
 		}
 	}
+
+	eff_sacks =3D tp->rx_opt.num_sacks + tp->rx_opt.dsack;
+	if (unlikely(eff_sacks)) {
+		const unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
+		opts->num_sack_blocks =3D
+			min_t(unsigned int, eff_sacks,
+			      (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
+			      TCPOLEN_SACK_PERBLOCK);
+		size +=3D TCPOLEN_SACK_BASE_ALIGNED +
+			opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
+	}
+
 	return size;
 }
 =

@@ -1146,6 +1249,7 @@ static int tcp_transmit_skb(struct sock *sk, struct s=
k_buff *skb, int clone_it,
 	else
 		tcp_options_size =3D tcp_established_options(sk, skb, &opts,
 							   &md5);
+
 	tcp_header_size =3D tcp_options_size + sizeof(struct tcphdr);
 =

 	/* if no packet is in qdisc/device queue, then allow XPS to select
@@ -1198,7 +1302,7 @@ static int tcp_transmit_skb(struct sock *sk, struct s=
k_buff *skb, int clone_it,
 		}
 	}
 =

-	tcp_options_write((__be32 *)(th + 1), tp, &opts);
+	tcp_options_write((__be32 *)(th + 1), skb, tp, &opts);
 	skb_shinfo(skb)->gso_type =3D sk->sk_gso_type;
 	if (likely(!(tcb->tcp_flags & TCPHDR_SYN))) {
 		th->window      =3D htons(tcp_select_window(sk));
@@ -3318,7 +3422,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk=
, struct dst_entry *dst,
 =

 	/* RFC1323: The window in SYN & SYN/ACK segments is never scaled. */
 	th->window =3D htons(min(req->rsk_rcv_wnd, 65535U));
-	tcp_options_write((__be32 *)(th + 1), NULL, &opts);
+	tcp_options_write((__be32 *)(th + 1), skb, NULL, &opts);
 	th->doff =3D (tcp_header_size >> 2);
 	__TCP_INC_STATS(sock_net(sk), TCP_MIB_OUTSEGS);
 =

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3d517d6645fe..6125d8bbca63 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -46,20 +46,272 @@ static int mptcp_connect(struct sock *sk, struct socka=
ddr *saddr, int len)
 	return err;
 }
 =

+static struct sk_buff *mptcp_alloc_skb(struct sock *sk, unsigned int size,
+				       gfp_t gfp)
+{
+	struct sk_buff *skb;
+	bool mem_scheduled;
+
+	/* TODO: borrowed from sk_stream_alloc_skb */
+
+	size =3D ALIGN(size, 4);
+
+	if (unlikely(tcp_under_memory_pressure(sk)))
+		sk_mem_reclaim_partial(sk);
+
+	skb =3D __alloc_skb(size + sk->sk_prot->max_header, gfp,
+			  SKB_ALLOC_FCLONE | SKB_ALLOC_SHINFO_EXT,
+			  NUMA_NO_NODE);
+	if (unlikely(!skb)) {
+		sk->sk_prot->enter_memory_pressure(sk);
+		sk_stream_moderate_sndbuf(sk);
+
+		return NULL;
+	}
+
+	/* Force scheduling like do_tcp_sendpages() does */
+	if (tcp_rtx_and_write_queues_empty(sk)) {
+		mem_scheduled =3D true;
+		sk_forced_mem_schedule(sk, skb->truesize);
+	} else {
+		mem_scheduled =3D sk_wmem_schedule(sk, skb->truesize);
+	}
+	if (likely(mem_scheduled)) {
+		skb_reserve(skb, sk->sk_prot->max_header);
+
+		/* Only make the requested size available to the caller */
+		skb->reserved_tailroom =3D skb->end - skb->tail - size;
+		INIT_LIST_HEAD(&skb->tcp_tsorted_anchor);
+		return skb;
+	}
+	__kfree_skb(skb);
+	return NULL;
+}
+
+static ssize_t do_mptcp_sendpage_dss(struct sock *sk, struct page *page,
+				     int offset, size_t size, int flags,
+				     struct mptcp_skb_ext_cb *ecb)
+{
+	long timeo =3D sock_sndtimeo(sk, flags & MSG_DONTWAIT);
+	int mss_now, size_goal, err;
+	struct sk_buff *skb;
+	ssize_t ret;
+
+	/* Try to avoid entailing an skb when do_tcp_sendpages() would
+	 * fail first.  */
+
+	/* Wait for a connection to finish. One exception is TCP Fast Open
+	 * (passive side) where data is allowed to be sent before a connection
+	 * is fully established.
+	 */
+	if (((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) &&
+	    !tcp_passive_fastopen(sk)) {
+		err =3D sk_stream_wait_connect(sk, &timeo);
+		if (err !=3D 0)
+			goto out_err;
+	}
+
+	sk_clear_bit(SOCKWQ_ASYNC_NOSPACE, sk);
+
+	mss_now =3D tcp_send_mss(sk, &size_goal, flags);
+
+	err =3D -EPIPE;
+	if (sk->sk_err || (sk->sk_shutdown & SEND_SHUTDOWN))
+		goto out_err;
+
+	/* Mark the end of the previous write so the beginning of the
+	 * next write (with its own extended shared info) is not
+	 * collapsed.
+	 */
+	skb =3D tcp_write_queue_tail(sk);
+	if (skb)
+		TCP_SKB_CB(skb)->eor =3D 1;
+
+	while (1) {
+		if (!sk_stream_memory_free(sk))
+			goto wait_for_sndbuf;
+
+		/* TODO: This requires that we know that there's room
+		 * for all the data in the full mapping before proceeding.
+		 *
+		 * It's especially a problem for a nonblocking send, which may
+		 * only send part of the data. It would be incorrect to send
+		 * the full mapping in the first packet because the application
+		 * may provide different data on the next attempt. Maybe it's
+		 * an issue for a blocking send that gets interrupted too.
+		 *
+		 * Alternative: determine what there is room for, and =

+		 * compose a mapping for that much data.
+		 * Alternative 2: one mapping per page?
+		 */
+		if (!sk_wmem_schedule(sk, ecb->data_level_len))
+			goto wait_for_memory;
+
+		skb =3D mptcp_alloc_skb(sk, size, sk->sk_allocation);
+		if (!skb)
+			goto wait_for_memory;
+
+		skb_get(skb);
+		*mptcp_skb_ecb(skb) =3D *ecb;
+
+		tcp_skb_entail(sk, skb);
+
+	        ret =3D do_tcp_sendpages(sk, page, offset, size, flags);
+		if (skb_unref(skb) && ret < 0 && !skb->len) {
+			/* If skb was not populated, take it back and free it */
+			tcp_unlink_write_queue(skb, sk);
+			sk_wmem_free_skb(sk, skb);
+		}
+
+		return ret;
+
+wait_for_sndbuf:
+		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+wait_for_memory:
+		/* FUTURE: push on all subflows */
+		tcp_push(sk, flags & ~MSG_MORE, mss_now,
+			 TCP_NAGLE_PUSH, size_goal);
+
+		err =3D sk_stream_wait_memory(sk, &timeo);
+		if (err !=3D 0)
+			goto out_err;
+
+		mss_now =3D tcp_send_mss(sk, &size_goal, flags);
+	}
+
+out_err:
+	/* make sure we wake any epoll edge trigger waiter */
+	if (unlikely(skb_queue_len(&sk->sk_write_queue) =3D=3D 0 &&
+		     err =3D=3D -EAGAIN)) {
+		sk->sk_write_space(sk);
+		tcp_chrono_stop(sk, TCP_CHRONO_SNDBUF_LIMITED);
+	}
+	return sk_stream_error(sk, flags, err);
+
+}
+
 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	struct socket *subflow;
+	struct mptcp_skb_ext_cb ecb;
+	size_t psize, msgsize;
+	struct page *page;
+	struct sock *ssk;
+	ssize_t sent;
+	int poffset;
+	int flags;
 =

-	if (msk->connection_list) {
-		subflow =3D msk->connection_list;
-		pr_debug("conn_list->subflow=3D%p", subflow->sk);
-	} else {
-		subflow =3D msk->subflow;
-		pr_debug("subflow=3D%p", subflow->sk);
+	pr_debug("msk=3D%p", msk);
+	if (!msk->connection_list && msk->subflow) {
+		pr_debug("fallback passthrough");
+		return sock_sendmsg(msk->subflow, msg);
+	}
+
+	if (!msg_data_left(msg)) {
+		pr_debug("empty send");
+		return sock_sendmsg(msk->connection_list, msg);
 	}
 =

-	return sock_sendmsg(subflow, msg);
+	ssk =3D msk->connection_list->sk;
+	msgsize =3D msg_data_left(msg);
+
+	/* TODO TEMPORARY - need to handle large writes.
+	 * For now, can only handle one DSS mapping at a time
+	 */
+	if (msgsize > U16_MAX) {
+		pr_debug("max mapping exceeded");
+		return -EFBIG;
+	}
+
+	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL))
+		return -ENOTSUPP;
+
+	/* Initial experiment: new page per send.  Real code will
+	 * maintain list of active pages and DSS mappings, append to the
+	 * end and honor zerocopy
+	 */
+	page =3D alloc_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+
+	/* Copy to page */
+	poffset =3D 0;
+	pr_debug("left=3D%ld", msg_data_left(msg));
+	// TODO: handle failure
+	psize =3D copy_page_from_iter(page, poffset,
+				    min(msg_data_left(msg), PAGE_SIZE),
+				    &msg->msg_iter);
+	pr_debug("left=3D%ld", msg_data_left(msg));
+
+	flags =3D msg->msg_flags;
+	if (msg_data_left(msg))
+		flags |=3D MSG_SENDPAGE_NOTLAST;
+
+	memset(&ecb, 0, sizeof(ecb));
+
+	lock_sock(sk);
+	lock_sock(ssk);
+
+	ecb.data_seq =3D msk->write_seq;
+	ecb.subflow_seq =3D subflow_sk(ssk)->rel_write_seq;
+	ecb.data_level_len =3D msgsize;
+	ecb.checksum =3D 0xbeef;
+	ecb.use_map =3D 1;
+	ecb.dsn64 =3D 1;
+	ecb.data_ack =3D msk->ack_seq;
+	ecb.ack64 =3D 1;
+	ecb.use_ack =3D 1;
+
+	if (ecb.use_ack)
+		pr_debug("data_ack=3D%llu ack64=3D%d", ecb.data_ack,
+			 ecb.ack64);
+	if (ecb.use_map)
+		pr_debug("data_seq=3D%llu subflow_seq=3D%u "
+			 "data_level_len=3D%u checksum=3D%u, dsn64=3D%d",
+			 ecb.data_seq, ecb.subflow_seq,
+			 ecb.data_level_len, ecb.checksum,
+			 ecb.dsn64);
+
+	msk->write_seq +=3D msgsize;
+	subflow_sk(ssk)->rel_write_seq +=3D msgsize;
+
+	sent =3D do_mptcp_sendpage_dss(ssk, page, poffset, psize, flags, &ecb);
+	put_page(page);
+	if (sent < 0)
+		goto error_out;
+
+	/* Send any remaining data */
+	while (msg_data_left(msg)) {
+		ssize_t next_sent;
+
+		page =3D alloc_page(GFP_KERNEL);
+		if (!page)
+			break;
+
+		/* Copy to page */
+		poffset =3D 0;
+		pr_debug("left=3D%ld", msg_data_left(msg));
+		psize =3D copy_page_from_iter(page, poffset,
+					    min(msg_data_left(msg), PAGE_SIZE),
+					    &msg->msg_iter);
+		pr_debug("left=3D%ld", msg_data_left(msg));
+
+		if (!msg_data_left(msg))
+			flags =3D msg->msg_flags;
+
+		next_sent =3D do_tcp_sendpages(ssk, page, poffset, psize, flags);
+		put_page(page);
+		if (next_sent < 0)
+			break;
+
+		sent +=3D next_sent;
+	}
+
+error_out:
+	release_sock(ssk);
+	release_sock(sk);
+
+	return sent;
 }
 =

 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
@@ -146,10 +398,13 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
 	pr_debug("msk=3D%p", msk);
 =

 	if (subflow->mp_capable) {
-		msk->remote_key =3D subflow->remote_key;
 		msk->local_key =3D subflow->local_key;
 		msk->token =3D subflow->token;
-		pr_debug("token=3D%u", msk->token);
+		msk->write_seq =3D subflow->idsn + 1;
+		subflow->rel_write_seq =3D 1;
+		msk->remote_key =3D subflow->remote_key;
+		crypto_key_sha1(msk->remote_key, NULL, &msk->ack_seq);
+		msk->ack_seq++;
 		msk->connection_list =3D new_sock;
 	} else {
 		msk->subflow =3D new_sock;
@@ -241,10 +496,13 @@ void mptcp_finish_connect(struct sock *sk, int mp_cap=
able)
 	pr_debug("msk=3D%p", msk);
 =

 	if (mp_capable) {
-		msk->remote_key =3D subflow->remote_key;
 		msk->local_key =3D subflow->local_key;
 		msk->token =3D subflow->token;
-		pr_debug("token=3D%u", msk->token);
+		msk->write_seq =3D subflow->idsn + 1;
+		subflow->rel_write_seq =3D 1;
+		msk->remote_key =3D subflow->remote_key;
+		crypto_key_sha1(msk->remote_key, NULL, &msk->ack_seq);
+		msk->ack_seq++;
 		msk->connection_list =3D msk->subflow;
 		msk->subflow =3D NULL;
 	}
@@ -371,6 +629,9 @@ static int __init mptcp_init(void)
 {
 	int err;
 =

+	BUILD_BUG_ON(sizeof(struct mptcp_skb_ext_cb) >
+		     FIELD_SIZEOF(struct skb_shared_info_ext, shcb));
+
 	mptcp_prot.h.hashinfo =3D tcp_prot.h.hashinfo;
 =

 	token_init();
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 241cc0eb5729..6fb4fa222aaf 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -81,10 +81,11 @@ static void new_req_token(struct request_sock *req,
 					      ireq->ir_rmt_port);
 #endif
 	}
-	pr_debug("local_key=3D%llu:%llx", local_key, local_key);
 	subflow_req->local_key =3D local_key;
-	crypto_key_sha1(subflow_req->local_key, &subflow_req->token, NULL);
-	pr_debug("token=3D%u", subflow_req->token);
+	crypto_key_sha1(subflow_req->local_key, &subflow_req->token,
+			&subflow_req->idsn);
+	pr_debug("local_key=3D%llu, token=3D%u, idsn=3D%llu", subflow_req->local_=
key,
+		 subflow_req->token, subflow_req->idsn);
 }
 =

 static void new_token(const struct sock *sk)
@@ -105,9 +106,9 @@ static void new_token(const struct sock *sk)
 						       isk->inet_dport);
 #endif
 	}
-	pr_debug("local_key=3D%llu:%llx", subflow->local_key, subflow->local_key);
-	crypto_key_sha1(subflow->local_key, &subflow->token, NULL);
-	pr_debug("token=3D%u", subflow->token);
+	crypto_key_sha1(subflow->local_key, &subflow->token, &subflow->idsn);
+	pr_debug("local_key=3D%llu, token=3D%u, idsn=3D%llu", subflow->local_key,
+		 subflow->token, subflow->idsn);
 }
 =

 static int insert_req_token(u32 token)
-- =

2.16.3


--===============5548413395606877956==--
