Content-Type: multipart/mixed; boundary="===============9107896556915585929=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH v5 15/17] mptcp: Write MPTCP DSS headers to
 outgoing data packets
Date: Fri, 14 Dec 2018 14:27:13 -0800
Message-ID: <20181214222715.23766-16-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20181214222715.23766-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 916

--===============9107896556915585929==
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
 include/net/mptcp.h   |  14 +++-
 net/ipv4/tcp_output.c | 153 +++++++++++++++++++++++++++++++++++++-----
 net/mptcp/protocol.c  | 116 ++++++++++++++++++++++++++++----
 net/mptcp/token.c     |  13 ++--
 4 files changed, 259 insertions(+), 37 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 3e6d9ddd5356..21c4d3c8ec1f 100644
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
@@ -71,8 +73,10 @@ struct subflow_sock {
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
@@ -94,8 +98,9 @@ struct subflow_request_sock {
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
@@ -106,6 +111,11 @@ struct subflow_request_sock *subflow_rsk(const struct =
request_sock *rsk)
 =

 #ifdef CONFIG_MPTCP
 =

+static inline struct mptcp_skb_cb *mptcp_skb_priv_cb(struct sk_buff *skb)
+{
+	return (struct mptcp_skb_cb *)skb_ext_find(skb, SKB_EXT_MPTCP);
+}
+
 void mptcp_parse_option(const unsigned char *ptr, int opsize,
 			struct tcp_options_received *opt_rx);
 unsigned int mptcp_syn_options(struct sock *sk, u64 *local_key);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 48b03106231d..1407bc142c92 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -418,6 +418,8 @@ static inline bool tcp_urg_mode(const struct tcp_sock *=
tp)
 #define OPTION_MPTCP_MPC_SYN	(1 << 0)
 #define OPTION_MPTCP_MPC_SYNACK	(1 << 1)
 #define OPTION_MPTCP_MPC_ACK	(1 << 2)
+#define OPTION_MPTCP_MPC_DSS_MAP	(1 << 6)
+#define OPTION_MPTCP_MPC_DSS_ACK	(1 << 7)
 =

 struct tcp_out_options {
 	u16 options;		/* bit field of OPTION_* */
@@ -433,9 +435,13 @@ struct tcp_out_options {
 	u64 rcvr_key;
 };
 =

-static void mptcp_options_write(__be32 *ptr, struct tcp_out_options *opts)
+static void mptcp_options_write(__be32 *ptr, struct sk_buff *skb,
+				struct tcp_sock *tp,
+				struct tcp_out_options *opts)
 {
 #if IS_ENABLED(CONFIG_MPTCP)
+	struct mptcp_skb_cb *mcb;
+
 	if (!(OPTION_MPTCP & opts->options))
 		return;
 =

@@ -466,6 +472,71 @@ static void mptcp_options_write(__be32 *ptr, struct tc=
p_out_options *opts)
 			ptr +=3D 2;
 		}
 	}
+
+	mcb =3D mptcp_skb_priv_cb(skb);
+
+	if (((OPTION_MPTCP_MPC_DSS_MAP | OPTION_MPTCP_MPC_DSS_ACK) &
+	     opts->suboptions) && mcb) {
+		bool write_ack =3D
+			(OPTION_MPTCP_MPC_DSS_ACK & opts->suboptions) &&
+			mcb && mcb->use_ack;
+		bool write_map =3D
+			(OPTION_MPTCP_MPC_DSS_MAP & opts->suboptions) &&
+			mcb && mcb->use_map;
+		u8 flags =3D 0;
+		u8 len =3D 4;
+		u8 *p =3D (u8 *)ptr;
+
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
+			if (mcb->use_checksum)
+				len +=3D 2;
+
+			/* Use only 64-bit mapping flags for now, add
+			 * support for optional 32-bit mappings later.
+			 */
+			flags |=3D 0x0c;
+			if (mcb->data_fin)
+				flags |=3D 0x10;
+		}
+
+		*p++ =3D 0x1e; // TCP option: Multipath TCP
+		*p++ =3D len;  // length
+		*p++ =3D 0x20; // subtype=3DDSS
+		*p++ =3D flags;
+
+		if (write_ack) {
+			*(__be64 *)p =3D cpu_to_be64(mcb->data_ack);
+			p +=3D 8;
+		}
+
+		if (write_map) {
+			*(__be64 *)p =3D cpu_to_be64(mcb->data_seq);
+			p +=3D 8;
+
+			*(__be32 *)p =3D htonl(mcb->subflow_seq);
+			p +=3D 4;
+
+			*(__be16 *)p =3D htons(mcb->dll);
+			p +=3D 2;
+
+			if (mcb->use_checksum) {
+				*(__be16 *)p =3D htons(mcb->checksum);
+				p +=3D 2;
+			} else {
+				*p++ =3D TCPOPT_NOP;
+				*p++ =3D TCPOPT_NOP;
+			}
+		}
+	}
 #endif
 }
 =

@@ -497,8 +568,8 @@ static void smc_options_write(__be32 *ptr, u16 *options)
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

@@ -593,7 +664,7 @@ static void tcp_options_write(__be32 *ptr, struct tcp_s=
ock *tp,
 =

 	smc_options_write(ptr, &options);
 =

-	mptcp_options_write(ptr, opts);
+	mptcp_options_write(ptr, skb, tp, opts);
 }
 =

 static void smc_set_option(const struct tcp_sock *tp,
@@ -819,17 +890,7 @@ static unsigned int tcp_established_options(struct soc=
k *sk, struct sk_buff *skb
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
+#ifdef CONFIG_MPTCP
 	if (tp->is_mptcp) {
 		unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
 		u64 local_key;
@@ -843,8 +904,65 @@ static unsigned int tcp_established_options(struct soc=
k *sk, struct sk_buff *skb
 				opts->rcvr_key =3D remote_key;
 				size +=3D TCPOLEN_MPTCP_MPC_ACK;
 			}
+		} else if (subflow_sk(sk)->mp_capable && skb) {
+			struct mptcp_skb_cb *cb;
+			unsigned int dss_size =3D 0;
+			u16 options =3D 0;
+
+			cb =3D mptcp_skb_priv_cb(skb);
+
+			if (cb && cb->use_map) {
+				unsigned int map_size =3D 18;
+
+				if (cb->use_checksum)
+					map_size +=3D 2;
+
+				if (map_size <=3D remaining) {
+					remaining -=3D map_size;
+					dss_size =3D map_size;
+					opts->options |=3D OPTION_MPTCP;
+					opts->suboptions =3D OPTION_MPTCP_MPC_DSS_MAP;
+				} else {
+					WARN(1, "MPTCP: Map dropped");
+				}
+			}
+
+			if (cb && cb->use_ack) {
+				unsigned int ack_size =3D 8;
+
+				/* Add kind/length/subtype/flag
+				 * overhead if mapping not populated
+				 */
+				if (dss_size =3D=3D 0)
+					ack_size +=3D 4;
+
+				if (ack_size <=3D remaining) {
+					dss_size +=3D ack_size;
+					opts->options |=3D OPTION_MPTCP;
+					opts->suboptions |=3D OPTION_MPTCP_MPC_DSS_ACK;
+				} else {
+					WARN(1, "MPTCP: Ack dropped");
+				}
+			}
+
+			if (dss_size) {
+				size +=3D ALIGN(dss_size, 4);
+				opts->options |=3D options;
+			}
 		}
 	}
+#endif
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
 =

 	return size;
 }
@@ -1146,6 +1264,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct=
 sk_buff *skb,
 	else
 		tcp_options_size =3D tcp_established_options(sk, skb, &opts,
 							   &md5);
+
 	tcp_header_size =3D tcp_options_size + sizeof(struct tcphdr);
 =

 	/* if no packet is in qdisc/device queue, then allow XPS to select
@@ -1198,7 +1317,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct=
 sk_buff *skb,
 		}
 	}
 =

-	tcp_options_write((__be32 *)(th + 1), tp, &opts);
+	tcp_options_write((__be32 *)(th + 1), skb, tp, &opts);
 	skb_shinfo(skb)->gso_type =3D sk->sk_gso_type;
 	if (likely(!(tcb->tcp_flags & TCPHDR_SYN))) {
 		th->window      =3D htons(tcp_select_window(sk));
@@ -3367,7 +3486,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk=
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
index cbc93dd36588..48a3155c99a9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -26,17 +26,103 @@
 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	struct socket *subflow;
+	int mss_now, size_goal, poffset, ret;
+	struct mptcp_skb_cb *mcb =3D NULL;
+	struct page *page =3D NULL;
+	struct sk_buff *skb;
+	struct sock *ssk;
+	size_t psize;
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
 	}
 =

-	return sock_sendmsg(subflow, msg);
+	if (!msg_data_left(msg)) {
+		pr_debug("empty send");
+		return sock_sendmsg(msk->connection_list, msg);
+	}
+
+	ssk =3D msk->connection_list->sk;
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
+	pr_debug("left=3D%zu", msg_data_left(msg));
+	psize =3D copy_page_from_iter(page, poffset,
+				    min_t(size_t, msg_data_left(msg), PAGE_SIZE),
+				    &msg->msg_iter);
+	pr_debug("left=3D%zu", msg_data_left(msg));
+
+	if (!psize) {
+		put_page(page);
+		return -EINVAL;
+	}
+
+	lock_sock(sk);
+	lock_sock(ssk);
+
+	/* Mark the end of the previous write so the beginning of the
+	 * next write (with its own mptcp cb) is not collapsed.
+	 */
+	skb =3D tcp_write_queue_tail(ssk);
+	if (skb)
+		TCP_SKB_CB(skb)->eor =3D 1;
+
+	mss_now =3D tcp_send_mss(ssk, &size_goal, msg->msg_flags);
+
+	ret =3D do_tcp_sendpages(ssk, page, poffset, min_t(int, size_goal, psize),
+			       msg->msg_flags | MSG_SENDPAGE_NOTLAST);
+	put_page(page);
+	if (ret <=3D 0)
+		goto error_out;
+
+	if (skb =3D=3D tcp_write_queue_tail(ssk))
+		pr_err("no new skb %p/%p", sk, ssk);
+
+	skb =3D tcp_write_queue_tail(ssk);
+
+	mcb =3D (struct mptcp_skb_cb *)skb_ext_add(skb, SKB_EXT_MPTCP);
+
+	if (mcb) {
+		memset(mcb, 0, sizeof(*mcb));
+		mcb->data_ack =3D msk->ack_seq;
+		mcb->data_seq =3D msk->write_seq;
+		mcb->subflow_seq =3D subflow_sk(ssk)->rel_write_seq;
+		mcb->dll =3D ret;
+		mcb->checksum =3D 0xbeef;
+		mcb->use_map =3D 1;
+		mcb->dsn64 =3D 1;
+		mcb->use_ack =3D 1;
+		mcb->ack64 =3D 1;
+
+		pr_debug("data_seq=3D%llu subflow_seq=3D%u "
+			 "dll=3D%u checksum=3D%u, dsn64=3D%d",
+			 mcb->data_seq, mcb->subflow_seq, mcb->dll,
+			 mcb->checksum, mcb->dsn64);
+	} /* TODO: else fallback */
+
+	msk->write_seq +=3D ret;
+	subflow_sk(ssk)->rel_write_seq +=3D ret;
+
+	tcp_push(ssk, msg->msg_flags, mss_now, tcp_sk(ssk)->nonagle, size_goal);
+
+error_out:
+	release_sock(ssk);
+	release_sock(sk);
+
+	return ret;
 }
 =

 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
@@ -109,11 +195,14 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
 	subflow->conn =3D mp->sk;
 =

 	if (subflow->mp_capable) {
-		msk->remote_key =3D subflow->remote_key;
 		msk->local_key =3D subflow->local_key;
 		msk->token =3D subflow->token;
-		pr_debug("token=3D%u", msk->token);
 		token_update_accept(new_sock->sk, mp->sk);
+		msk->write_seq =3D subflow->idsn + 1;
+		subflow->rel_write_seq =3D 1;
+		msk->remote_key =3D subflow->remote_key;
+		crypto_key_sha1(msk->remote_key, NULL, &msk->ack_seq);
+		msk->ack_seq++;
 		msk->connection_list =3D new_sock;
 	} else {
 		msk->subflow =3D new_sock;
@@ -195,10 +284,13 @@ void mptcp_finish_connect(struct sock *sk, int mp_cap=
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
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 473d5d15bad2..d0135bab9fc8 100644
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

2.20.0


--===============9107896556915585929==--
