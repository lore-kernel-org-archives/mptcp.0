Content-Type: multipart/mixed; boundary="===============1435531479864954516=="
MIME-Version: 1.0
From: rao.shoaib at oracle.com
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 1/1] MPTCP changes that work with the modified network
 code
Date: Thu, 22 Mar 2018 16:21:28 -0700
Message-ID: <1521760888-19026-2-git-send-email-rao.shoaib@oracle.com>
In-Reply-To: 1521760888-19026-1-git-send-email-rao.shoaib@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 403

--===============1435531479864954516==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Rao Shoaib <rao.shoaib(a)oracle.com>

---
 include/net/mptcp.h         | 343 +++++++--------
 include/net/mptcp_v4.h      |  14 +-
 include/net/mptcp_v6.h      |  13 -
 net/mptcp/mptcp_ctrl.c      | 600 +++++++++++++++++++-------
 net/mptcp/mptcp_fullmesh.c  |  20 +-
 net/mptcp/mptcp_input.c     | 996 ++++++++++++++++++++++++++++++++--------=
----
 net/mptcp/mptcp_ipv4.c      | 232 ++---------
 net/mptcp/mptcp_ipv6.c      | 288 ++-----------
 net/mptcp/mptcp_ofo_queue.c | 306 +++++---------
 net/mptcp/mptcp_output.c    | 475 +++++++++++----------
 net/mptcp/mptcp_redundant.c |   6 +-
 net/mptcp/mptcp_rr.c        |   4 +-
 net/mptcp/mptcp_sched.c     |  55 ++-
 13 files changed, 1793 insertions(+), 1559 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 876f1e6..5234145 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -43,6 +43,7 @@
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
 #include <crypto/hash.h>
+#include <crypto/md5.h>
 #include <net/tcp.h>
 =

 #if defined(__LITTLE_ENDIAN_BITFIELD)
@@ -53,6 +54,8 @@
 	#define htonll(x) (x)
 #endif
 =

+extern const struct tcp_state_ops mptcp_state_ops;
+
 struct mptcp_loc4 {
 	u8		loc4_id;
 	u8		low_prio:1;
@@ -157,12 +160,14 @@ struct mptcp_options_received {
 	u32	mptcp_recv_nonce;
 	u64	mptcp_recv_tmac;
 	u8	mptcp_recv_mac[20];
+	u8	mptcp_dss_off;
 };
 =

 struct mptcp_tcp_sock {
 	struct tcp_sock	*next;		/* Next subflow socket */
 	struct hlist_node cb_list;
 	struct mptcp_options_received rx_opt;
+	struct sk_buff *meta_skb;
 =

 	 /* Those three fields record the current mapping */
 	u64	map_data_seq;
@@ -194,10 +199,6 @@ struct mptcp_tcp_sock {
 #define MPTCP_SCHED_SIZE 16
 	u8	mptcp_sched[MPTCP_SCHED_SIZE] __aligned(8);
 =

-	struct sk_buff  *shortcut_ofoqueue; /* Shortcut to the current modified
-					     * skb in the ofo-queue.
-					     */
-
 	int	init_rcv_wnd;
 	u32	infinite_cutoff_seq;
 	struct delayed_work work;
@@ -427,6 +428,7 @@ struct mptcp_cb {
 #define MPTCP_SUB_LEN_FCLOSE	12
 #define MPTCP_SUB_LEN_FCLOSE_ALIGN	12
 =

+#define	MPTCP_FLAG_DATA_ACKED		0x8000
 =

 #define OPTION_MPTCP		(1 << 5)
 =

@@ -695,7 +697,7 @@ extern struct workqueue_struct *mptcp_wq;
 	mptcp_for_each_bit_set(~b, i)
 =

 #define MPTCP_INC_STATS(net, field)	SNMP_INC_STATS((net)->mptcp.mptcp_stat=
istics, field)
-#define MPTCP_INC_STATS_BH(net, field)	SNMP_INC_STATS_BH((net)->mptcp.mptc=
p_statistics, field)
+#define MPTCP_INC_STATS_BH(net, field)	__SNMP_INC_STATS((net)->mptcp.mptcp=
_statistics, field)
 =

 enum
 {
@@ -784,12 +786,10 @@ extern spinlock_t mptcp_tk_hashlock;	/* hashtable pro=
tection */
  */
 #define MPTCP_REQSK_NULLS_BASE (1U << 29)
 =

-
 void mptcp_data_ready(struct sock *sk);
 void mptcp_write_space(struct sock *sk);
 =

-void mptcp_add_meta_ofo_queue(const struct sock *meta_sk, struct sk_buff *=
skb,
-			      struct sock *sk);
+void mptcp_add_meta_ofo_queue(struct sock *meta_sk, struct sk_buff *skb);
 void mptcp_ofo_queue(struct sock *meta_sk);
 void mptcp_purge_ofo_queue(struct tcp_sock *meta_tp);
 void mptcp_cleanup_rbuf(struct sock *meta_sk, int copied);
@@ -803,11 +803,11 @@ void mptcp_send_fin(struct sock *meta_sk);
 void mptcp_send_active_reset(struct sock *meta_sk, gfp_t priority);
 bool mptcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
 		      int push_one, gfp_t gfp);
-void tcp_parse_mptcp_options(const struct sk_buff *skb,
+void tcp_parse_mptcp_options(struct sk_buff *skb,
 			     struct mptcp_options_received *mopt);
 void mptcp_parse_options(const uint8_t *ptr, int opsize,
 			 struct mptcp_options_received *mopt,
-			 const struct sk_buff *skb,
+			 struct sk_buff *skb,
 			 struct tcp_sock *tp);
 void mptcp_syn_options(const struct sock *sk, struct tcp_out_options *opts,
 		       unsigned *remaining);
@@ -816,9 +816,8 @@ void mptcp_synack_options(struct request_sock *req,
 			  unsigned *remaining);
 void mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 			       struct tcp_out_options *opts, unsigned *size);
-void mptcp_options_write(__be32 *ptr, struct tcp_sock *tp,
-			 const struct tcp_out_options *opts,
-			 struct sk_buff *skb);
+void mptcp_options_write(__be32 **ptr, struct tcp_sock *tp,
+			 struct tcp_out_options *opts, struct sk_buff *skb);
 void mptcp_close(struct sock *meta_sk, long timeout);
 int mptcp_doit(struct sock *sk);
 int mptcp_create_master_sk(struct sock *meta_sk, __u64 remote_key,
@@ -830,34 +829,62 @@ struct sock *mptcp_check_req_child(struct sock *sk, s=
truct sock *child,
 				   struct request_sock *req,
 				   const struct mptcp_options_received *mopt);
 u32 __mptcp_select_window(struct sock *sk);
-void mptcp_select_initial_window(int __space, __u32 mss, __u32 *rcv_wnd,
-					__u32 *window_clamp, int wscale_ok,
-					__u8 *rcv_wscale, __u32 init_rcv_wnd,
-					const struct sock *sk);
+void mptcp_select_initial_window(const struct sock *sk, int __space, __u32=
 mss, =

+				 __u32 *rcv_wnd, __u32 *window_clamp,
+				 int wscale_ok, __u8 *rcv_wscale,
+				 __u32 init_rcv_wnd);
 unsigned int mptcp_current_mss(struct sock *meta_sk);
-int mptcp_select_size(const struct sock *meta_sk, bool sg);
+int mptcp_select_size(const struct sock *meta_sk, bool sg,
+		      bool first_skb, bool zc);
 void mptcp_key_sha1(u64 key, u32 *token, u64 *idsn);
 void mptcp_hmac_sha1(u8 *key_1, u8 *key_2, u32 *hash_out, int arg_num, ...=
);
 void mptcp_clean_rtx_infinite(const struct sk_buff *skb, struct sock *sk);
 void mptcp_fin(struct sock *meta_sk);
 void mptcp_meta_retransmit_timer(struct sock *meta_sk);
 void mptcp_sub_retransmit_timer(struct sock *sk);
-int mptcp_write_wakeup(struct sock *meta_sk);
+int mptcp_write_wakeup(struct sock *meta_sk, int mib);
+struct sk_buff *mptcp_shift_skb_data(struct sock *sk, struct sk_buff *skb,
+				     struct tcp_sacktag_state *state,
+				     u32 start_seq, u32 end_seq,
+				     bool dup_sack);
+bool mptcp_try_coalesce(struct sock *sk,
+			struct sk_buff *to,
+			struct sk_buff *from,
+			bool *fragstolen);
+int mptcp_try_rmem_schedule(struct sock *sk, struct sk_buff *skb,
+			    unsigned int size);
+struct sk_buff *mptcp_collapse_one(struct sock *sk, struct sk_buff *skb,
+				   struct sk_buff_head *list,
+				   struct rb_root *root);
+int mptcp_trim_head(struct sock *sk, struct sk_buff *skb, u32 len);
+void mptcp_urg(struct sock *sk, struct sk_buff *skb, const struct tcphdr *=
th);
+void mptcp_grow_window(struct sock *sk, const struct sk_buff *skb);
+void mptcp_rcv_ack_only(struct sock *sk, struct sk_buff *skb);
+bool mptcp_rcv_fastopen_synack(struct sock *sk, struct sk_buff *synack,
+			       struct tcp_fastopen_cookie *cookie);
+int mptcp_sendpage_locked(struct sock *sk, struct page *page, int offset,
+			  size_t size, int flags);
+struct request_sock *mptcp_cookie_req_alloc(struct sock *sk,
+			       		    struct sk_buff *skb,
+					    struct tcp_options_received *tcp_opts,
+					    __u32 cookie, int mss);
+struct sock *mptcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
+				   struct request_sock *req,
+				   struct dst_entry *dst, u32 tsoff);
+int mptcp_join_ack(struct request_sock *req, struct sk_buff *skb);
 void mptcp_sub_close_wq(struct work_struct *work);
 void mptcp_sub_close(struct sock *sk, unsigned long delay);
 struct sock *mptcp_select_ack_sock(const struct sock *meta_sk);
 void mptcp_fallback_meta_sk(struct sock *meta_sk);
 int mptcp_backlog_rcv(struct sock *meta_sk, struct sk_buff *skb);
-void mptcp_ack_handler(unsigned long);
-bool mptcp_check_rtt(const struct tcp_sock *tp, int time);
+void mptcp_ack_handler(struct timer_list *t);
+bool mptcp_check_rtt(struct sock *sk);
+void mptcp_sndbuf_expand(struct sock *sk);
 int mptcp_check_snd_buf(const struct tcp_sock *tp);
 bool mptcp_handle_options(struct sock *sk, const struct tcphdr *th,
 			  const struct sk_buff *skb);
 void __init mptcp_init(void);
 void mptcp_destroy_sock(struct sock *sk);
-int mptcp_rcv_synsent_state_process(struct sock *sk, struct sock **skptr,
-				    const struct sk_buff *skb,
-				    const struct mptcp_options_received *mopt);
 unsigned int mptcp_xmit_size_goal(const struct sock *meta_sk, u32 mss_now,
 				  int large_allowed);
 int mptcp_init_tw_sock(struct sock *sk, struct tcp_timewait_sock *tw);
@@ -881,14 +908,19 @@ int mptcp_check_req(struct sk_buff *skb, struct net *=
net);
 void mptcp_connect_init(struct sock *sk);
 void mptcp_sub_force_close(struct sock *sk);
 int mptcp_sub_len_remove_addr_align(u16 bitfield);
-void mptcp_remove_shortcuts(const struct mptcp_cb *mpcb,
-			    const struct sk_buff *skb);
 void mptcp_init_buffer_space(struct sock *sk);
-void mptcp_join_reqsk_init(struct mptcp_cb *mpcb, const struct request_soc=
k *req,
+void mptcp_join_reqsk_init(struct mptcp_cb *mpcb,
+			   const struct request_sock *req,
 			   struct sk_buff *skb);
-void mptcp_reqsk_init(struct request_sock *req, struct sock *sk,
-		      const struct sk_buff *skb, bool want_cookie);
+void mptcp_reqsk_init(struct request_sock *req, const struct sock *sk,
+		      struct sk_buff *skb,
+		      struct mptcp_options_received *mopt);
 int mptcp_conn_request(struct sock *sk, struct sk_buff *skb);
+struct sock *mptcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff =
*skb,
+				    struct request_sock *req,
+				    struct dst_entry *dst,
+				    struct request_sock *req_unhash,
+				    bool *own_req);
 void mptcp_enable_sock(struct sock *sk);
 void mptcp_disable_sock(struct sock *sk);
 void mptcp_enable_static_key(void);
@@ -897,6 +929,10 @@ void mptcp_cookies_reqsk_init(struct request_sock *req,
 			      struct mptcp_options_received *mopt,
 			      struct sk_buff *skb);
 void mptcp_sock_destruct(struct sock *sk);
+int mptcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
+			      const struct tcphdr *th);
+bool mptcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
+		   	     const struct tcphdr *th, int syn_inerr);
 =

 /* MPTCP-path-manager registration/initialization functions */
 int mptcp_register_path_manager(struct mptcp_pm_ops *pm);
@@ -922,8 +958,18 @@ bool subflow_is_active(const struct tcp_sock *tp);
 bool subflow_is_backup(const struct tcp_sock *tp);
 struct sock *get_available_subflow(struct sock *meta_sk, struct sk_buff *s=
kb,
 				   bool zero_wnd_test);
+void mptcp_v4_add_ack_opts(const struct sock *sk, struct sk_buff *skb,
+			   int *offset, struct ip_reply_arg *arg, __be32 *opt);
+void mptcp_v6_add_ack_opts(const struct sock *sk, struct sk_buff *skb,
+                           struct tcphdr *th, __be32 **toptr);
 extern struct mptcp_sched_ops mptcp_sched_default;
 =

+extern struct static_key mptcp_static_key;
+static inline bool mptcp(const struct tcp_sock *tp)
+{
+	return static_key_false(&mptcp_static_key) && tp->mpc;
+}
+
 /* Initializes function-pointers and MPTCP-flags */
 static inline void mptcp_init_tcp_sock(struct sock *sk)
 {
@@ -957,7 +1003,7 @@ static inline bool mptcp_can_sendpage(struct sock *sk)
 =

 	mptcp_for_each_sk(tcp_sk(sk)->mpcb, sk_it) {
 		if (!(sk_it->sk_route_caps & NETIF_F_SG) ||
-		    !(sk_it->sk_route_caps & NETIF_F_ALL_CSUM))
+		    !(sk_it->sk_route_caps & NETIF_F_HW_CSUM))
 			return false;
 	}
 =

@@ -983,7 +1029,7 @@ static inline void mptcp_push_pending_frames(struct so=
ck *meta_sk)
 static inline void mptcp_send_reset(struct sock *sk)
 {
 	if (tcp_need_reset(sk->sk_state))
-		tcp_sk(sk)->ops->send_active_reset(sk, GFP_ATOMIC);
+		tcp_sk(sk)->op_ops->send_active_reset(sk, GFP_ATOMIC);
 	mptcp_sub_force_close(sk);
 }
 =

@@ -998,6 +1044,7 @@ static inline void mptcp_sub_force_close_all(struct mp=
tcp_cb *mpcb,
 	}
 }
 =

+/* currently tp is being used for Rx packets */
 static inline bool mptcp_is_data_seq(const struct sk_buff *skb)
 {
 	return TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_SEQ;
@@ -1034,17 +1081,19 @@ static inline u8 mptcp_get_64_bit(u64 data_seq, str=
uct mptcp_cb *mpcb)
 /* Sets the data_seq and returns pointer to the in-skb field of the data_s=
eq.
  * If the packet has a 64-bit dseq, the pointer points to the last 32 bits.
  */
-static inline __u32 *mptcp_skb_set_data_seq(const struct sk_buff *skb,
+static inline __u32 *mptcp_skb_set_data_seq(struct tcp_sock *tp,
+					    struct sk_buff *skb,
 					    u32 *data_seq,
 					    struct mptcp_cb *mpcb)
 {
-	__u32 *ptr =3D (__u32 *)(skb_transport_header(skb) + TCP_SKB_CB(skb)->dss=
_off);
+	__u32 *ptr =3D (__u32 *)(skb_transport_header(skb) + tp->mptcp->rx_opt.mp=
tcp_dss_off);
 =

 	if (TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_SEQ64_SET) {
 		u64 data_seq64 =3D get_unaligned_be64(ptr);
 =

 		if (mpcb)
-			TCP_SKB_CB(skb)->mptcp_flags |=3D mptcp_get_64_bit(data_seq64, mpcb);
+			TCP_SKB_CB(skb)->mptcp_flags |=3D
+				mptcp_get_64_bit(data_seq64, mpcb);
 =

 		*data_seq =3D (u32)data_seq64;
 		ptr++;
@@ -1123,6 +1172,8 @@ static inline void mptcp_init_mp_opt(struct mptcp_opt=
ions_received *mopt)
 =

 	mopt->mp_fail =3D 0;
 	mopt->mp_fclose =3D 0;
+
+	mopt->mptcp_dss_off =3D 0;
 }
 =

 static inline void mptcp_reset_mopt(struct tcp_sock *tp)
@@ -1344,6 +1395,66 @@ static inline bool mptcp_v6_is_v4_mapped(const struc=
t sock *sk)
 	       ipv6_addr_type(&inet6_sk(sk)->saddr) =3D=3D IPV6_ADDR_MAPPED;
 }
 =

+static inline void mptcp_set_skb_tso_segs(const struct sock *sk,
+					   struct sk_buff *skb,
+					   unsigned int mss_now) {
+	if ((is_meta_sk(sk) && !mptcp_sk_can_gso(sk)) ||
+	    (!is_meta_sk(sk) && !sk_can_gso(sk))) {
+		tcp_skb_pcount_set(skb, 1);
+		TCP_SKB_CB(skb)->tcp_gso_size =3D 0;
+	} else {
+		=

+		tcp_set_skb_tso_segs(skb, mss_now);
+	}
+}
+
+static inline int __mptcp_join_ack(struct request_sock *req, struct sk_buf=
f *skb)
+{
+	struct sock *meta_sk =3D req->rsk_listener;
+	const struct tcphdr *th;
+	struct sock *syn_sk =3D NULL;
+	bool req_stolen;
+	int ret;
+
+	th =3D (const struct tcphdr *)skb->data;
+	if (meta_sk->sk_family =3D=3D AF_INET) {
+		const struct iphdr *iph;
+		iph =3D ip_hdr(skb);
+		tcp_v4_fill_cb(skb, iph, th);
+	} else {
+		const struct ipv6hdr *ip6h;
+		ip6h =3D ipv6_hdr(skb);
+		tcp_v6_fill_cb(skb, ip6h, th);
+	}
+
+	syn_sk =3D tcp_check_req(meta_sk, skb, req, false, &req_stolen);
+
+	if (syn_sk && syn_sk !=3D meta_sk) {
+
+		ret =3D tcp_rcv_state_process(syn_sk, skb);
+
+		bh_unlock_sock(syn_sk);
+		sock_put(syn_sk);
+
+		if (ret) {
+			goto reset_and_discard;
+		}
+
+		tcp_send_ack(syn_sk);
+		return(0);
+	}
+
+reset_and_discard:
+	if (meta_sk->sk_family =3D=3D AF_INET)
+		tcp_v4_send_reset(syn_sk, skb);
+	else
+		tcp_v6_send_reset(syn_sk, skb);
+	reqsk_put(req);
+	sk_drops_add(meta_sk, skb);
+	kfree_skb(skb);
+	return (0);
+}
+
 /* TCP and MPTCP mpc flag-depending functions */
 u16 mptcp_select_window(struct sock *sk);
 void mptcp_init_buffer_space(struct sock *sk);
@@ -1352,168 +1463,12 @@ void mptcp_tcp_set_rto(struct sock *sk);
 /* TCP and MPTCP flag-depending functions */
 bool mptcp_prune_ofo_queue(struct sock *sk);
 =

-#else /* CONFIG_MPTCP */
-#define mptcp_debug(fmt, args...)	\
-	do {				\
-	} while (0)
-
-/* Without MPTCP, we just do one iteration
- * over the only socket available. This assumes that
- * the sk/tp arg is the socket in that case.
- */
-#define mptcp_for_each_sk(mpcb, sk)
-#define mptcp_for_each_sk_safe(__mpcb, __sk, __temp)
+int mptcp_mtu_probe(struct sock *sk);
+void mptcp_retrans_try_collapse(struct sock *sk, struct sk_buff *to, int s=
pace);
 =

-#define MPTCP_INC_STATS(net, field)	\
-	do {				\
-	} while(0)
+int mptcp_process_join_req(struct sock *meta_sk, struct sk_buff *skb);
+int mptcp_do_rcv(const struct sock *meta_sk, struct sk_buff *skb);
 =

-static inline bool mptcp_is_data_fin(const struct sk_buff *skb)
-{
-	return false;
-}
-static inline bool mptcp_is_data_seq(const struct sk_buff *skb)
-{
-	return false;
-}
-static inline struct sock *mptcp_meta_sk(const struct sock *sk)
-{
-	return NULL;
-}
-static inline struct tcp_sock *mptcp_meta_tp(const struct tcp_sock *tp)
-{
-	return NULL;
-}
-static inline int is_meta_sk(const struct sock *sk)
-{
-	return 0;
-}
-static inline int is_master_tp(const struct tcp_sock *tp)
-{
-	return 0;
-}
-static inline void mptcp_purge_ofo_queue(struct tcp_sock *meta_tp) {}
-static inline void mptcp_del_sock(const struct sock *sk) {}
-static inline void mptcp_update_metasocket(struct sock *sock, const struct=
 sock *meta_sk) {}
-static inline void mptcp_reinject_data(struct sock *orig_sk, int clone_it)=
 {}
-static inline void mptcp_update_sndbuf(const struct tcp_sock *tp) {}
-static inline void mptcp_clean_rtx_infinite(const struct sk_buff *skb,
-					    const struct sock *sk) {}
-static inline void mptcp_sub_close(struct sock *sk, unsigned long delay) {}
-static inline void mptcp_set_rto(const struct sock *sk) {}
-static inline void mptcp_send_fin(const struct sock *meta_sk) {}
-static inline void mptcp_parse_options(const uint8_t *ptr, const int opsiz=
e,
-				       struct mptcp_options_received *mopt,
-				       const struct sk_buff *skb,
-				       const struct tcp_sock *tp) {}
-static inline void mptcp_syn_options(const struct sock *sk,
-				     struct tcp_out_options *opts,
-				     unsigned *remaining) {}
-static inline void mptcp_synack_options(struct request_sock *req,
-					struct tcp_out_options *opts,
-					unsigned *remaining) {}
-
-static inline void mptcp_established_options(struct sock *sk,
-					     struct sk_buff *skb,
-					     struct tcp_out_options *opts,
-					     unsigned *size) {}
-static inline void mptcp_options_write(__be32 *ptr, struct tcp_sock *tp,
-				       const struct tcp_out_options *opts,
-				       struct sk_buff *skb) {}
-static inline void mptcp_close(struct sock *meta_sk, long timeout) {}
-static inline int mptcp_doit(struct sock *sk)
-{
-	return 0;
-}
-static inline int mptcp_check_req_fastopen(struct sock *child,
-					   struct request_sock *req)
-{
-	return 1;
-}
-static inline int mptcp_check_req_master(const struct sock *sk,
-					 const struct sock *child,
-					 struct request_sock *req,
-					 int drop)
-{
-	return 1;
-}
-static inline struct sock *mptcp_check_req_child(struct sock *sk,
-						 struct sock *child,
-						 struct request_sock *req,
-						 const struct mptcp_options_received *mopt)
-{
-	return NULL;
-}
-static inline unsigned int mptcp_current_mss(struct sock *meta_sk)
-{
-	return 0;
-}
-static inline void mptcp_sub_close_passive(struct sock *sk) {}
-static inline bool mptcp_fallback_infinite(const struct sock *sk, int flag)
-{
-	return false;
-}
-static inline void mptcp_init_mp_opt(const struct mptcp_options_received *=
mopt) {}
-static inline bool mptcp_check_rtt(const struct tcp_sock *tp, int time)
-{
-	return false;
-}
-static inline int mptcp_check_snd_buf(const struct tcp_sock *tp)
-{
-	return 0;
-}
-static inline void mptcp_send_reset(const struct sock *sk) {}
-static inline bool mptcp_handle_options(struct sock *sk,
-					const struct tcphdr *th,
-					struct sk_buff *skb)
-{
-	return false;
-}
-static inline void mptcp_reset_mopt(struct tcp_sock *tp) {}
-static inline void  __init mptcp_init(void) {}
-static inline bool mptcp_sk_can_gso(const struct sock *sk)
-{
-	return false;
-}
-static inline bool mptcp_can_sg(const struct sock *meta_sk)
-{
-	return false;
-}
-static inline unsigned int mptcp_xmit_size_goal(const struct sock *meta_sk,
-						u32 mss_now, int large_allowed)
-{
-	return 0;
-}
-static inline void mptcp_destroy_sock(struct sock *sk) {}
-static inline int mptcp_rcv_synsent_state_process(struct sock *sk,
-						  struct sock **skptr,
-						  struct sk_buff *skb,
-						  const struct mptcp_options_received *mopt)
-{
-	return 0;
-}
-static inline bool mptcp_can_sendpage(struct sock *sk)
-{
-	return false;
-}
-static inline int mptcp_init_tw_sock(struct sock *sk,
-				     struct tcp_timewait_sock *tw)
-{
-	return 0;
-}
-static inline void mptcp_twsk_destructor(struct tcp_timewait_sock *tw) {}
-static inline void mptcp_disconnect(struct sock *sk) {}
-static inline void mptcp_tsq_flags(struct sock *sk) {}
-static inline void mptcp_tsq_sub_deferred(struct sock *meta_sk) {}
-static inline void mptcp_hash_remove_bh(struct tcp_sock *meta_tp) {}
-static inline void mptcp_hash_remove(struct tcp_sock *meta_tp) {}
-static inline void mptcp_remove_shortcuts(const struct mptcp_cb *mpcb,
-					  const struct sk_buff *skb) {}
-static inline void mptcp_init_tcp_sock(struct sock *sk) {}
-static inline void mptcp_disable_static_key(void) {}
-static inline void mptcp_cookies_reqsk_init(struct request_sock *req,
-					    struct mptcp_options_received *mopt,
-					    struct sk_buff *skb) {}
 #endif /* CONFIG_MPTCP */
 =

 #endif /* _MPTCP_H */
diff --git a/include/net/mptcp_v4.h b/include/net/mptcp_v4.h
index c83dca0..143523e 100644
--- a/include/net/mptcp_v4.h
+++ b/include/net/mptcp_v4.h
@@ -44,24 +44,12 @@ extern struct tcp_request_sock_ops mptcp_join_request_s=
ock_ipv4_ops;
 =

 #ifdef CONFIG_MPTCP
 =

-int mptcp_v4_do_rcv(struct sock *meta_sk, struct sk_buff *skb);
-struct sock *mptcp_v4_search_req(const __be16 rport, const __be32 raddr,
-				 const __be32 laddr, const struct net *net);
 int mptcp_init4_subsockets(struct sock *meta_sk, const struct mptcp_loc4 *=
loc,
 			   struct mptcp_rem4 *rem);
 int mptcp_pm_v4_init(void);
 void mptcp_pm_v4_undo(void);
-u32 mptcp_v4_get_nonce(__be32 saddr, __be32 daddr, __be16 sport, __be16 dp=
ort);
-u64 mptcp_v4_get_key(__be32 saddr, __be32 daddr, __be16 sport, __be16 dpor=
t,
-		     u32 seed);
 =

-#else
-
-static inline int mptcp_v4_do_rcv(const struct sock *meta_sk,
-				  const struct sk_buff *skb)
-{
-	return 0;
-}
+int mptcp_v6_join_request(struct sock *meta_sk, struct sk_buff *skb);
 =

 #endif /* CONFIG_MPTCP */
 =

diff --git a/include/net/mptcp_v6.h b/include/net/mptcp_v6.h
index a6257fb..e75615b 100644
--- a/include/net/mptcp_v6.h
+++ b/include/net/mptcp_v6.h
@@ -50,19 +50,6 @@ int mptcp_init6_subsockets(struct sock *meta_sk, const s=
truct mptcp_loc6 *loc,
 			   struct mptcp_rem6 *rem);
 int mptcp_pm_v6_init(void);
 void mptcp_pm_v6_undo(void);
-__u32 mptcp_v6_get_nonce(const __be32 *saddr, const __be32 *daddr,
-			 __be16 sport, __be16 dport);
-u64 mptcp_v6_get_key(const __be32 *saddr, const __be32 *daddr,
-		     __be16 sport, __be16 dport, u32 seed);
-
-#else /* CONFIG_MPTCP */
-
-#define mptcp_v6_mapped ipv6_mapped
-
-static inline int mptcp_v6_do_rcv(struct sock *meta_sk, struct sk_buff *sk=
b)
-{
-	return 0;
-}
 =

 #endif /* CONFIG_MPTCP */
 =

diff --git a/net/mptcp/mptcp_ctrl.c b/net/mptcp/mptcp_ctrl.c
index 28f348f..db5ff52 100644
--- a/net/mptcp/mptcp_ctrl.c
+++ b/net/mptcp/mptcp_ctrl.c
@@ -27,10 +27,13 @@
  *      2 of the License, or (at your option) any later version.
  */
 =

+#include <net/sock.h>
 #include <net/inet_common.h>
 #include <net/inet6_hashtables.h>
+#include <net/ip.h>
 #include <net/ipv6.h>
 #include <net/ip6_checksum.h>
+#include <net/secure_seq.h>
 #include <net/mptcp.h>
 #include <net/mptcp_v4.h>
 #if IS_ENABLED(CONFIG_IPV6)
@@ -57,13 +60,14 @@
 #include <linux/workqueue.h>
 #include <linux/atomic.h>
 #include <linux/sysctl.h>
+#include <linux/proc_fs.h>
 =

 static struct kmem_cache *mptcp_sock_cache __read_mostly;
 static struct kmem_cache *mptcp_cb_cache __read_mostly;
 static struct kmem_cache *mptcp_tw_cache __read_mostly;
 =

 int sysctl_mptcp_enabled __read_mostly =3D 1;
-int sysctl_mptcp_version __read_mostly =3D 0;
+int sysctl_mptcp_version __read_mostly;
 static int min_mptcp_version;
 static int max_mptcp_version =3D 1;
 int sysctl_mptcp_checksum __read_mostly =3D 1;
@@ -72,6 +76,7 @@ EXPORT_SYMBOL(sysctl_mptcp_debug);
 int sysctl_mptcp_syn_retries __read_mostly =3D 3;
 =

 bool mptcp_init_failed __read_mostly;
+static struct tcp_operational_ops mptcp_default_op_ops;
 =

 struct static_key mptcp_static_key =3D STATIC_KEY_INIT_FALSE;
 EXPORT_SYMBOL(mptcp_static_key);
@@ -247,6 +252,7 @@ void mptcp_reqsk_destructor(struct request_sock *req)
 static void __mptcp_hash_insert(struct tcp_sock *meta_tp, const u32 token)
 {
 	u32 hash =3D mptcp_hash_tk(token);
+
 	hlist_nulls_add_head_rcu(&meta_tp->tk_table, &tk_hashtable[hash]);
 	meta_tp->inside_tk_table =3D 1;
 }
@@ -258,7 +264,8 @@ static bool mptcp_find_token(u32 token)
 	const struct hlist_nulls_node *node;
 =

 begin:
-	hlist_nulls_for_each_entry_rcu(meta_tp, node, &tk_hashtable[hash], tk_tab=
le) {
+	hlist_nulls_for_each_entry_rcu(meta_tp, node,
+				       &tk_hashtable[hash], tk_table) {
 		if (token =3D=3D meta_tp->mptcp_loc_token)
 			return true;
 	}
@@ -284,15 +291,14 @@ static void mptcp_set_key_reqsk(struct request_sock *=
req,
 		mtreq->mptcp_loc_key =3D mptcp_v4_get_key(ip_hdr(skb)->saddr,
 							ip_hdr(skb)->daddr,
 							htons(ireq->ir_num),
-							ireq->ir_rmt_port,
-							seed);
+							ireq->ir_rmt_port);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else {
-		mtreq->mptcp_loc_key =3D mptcp_v6_get_key(ipv6_hdr(skb)->saddr.s6_addr32,
-							ipv6_hdr(skb)->daddr.s6_addr32,
-							htons(ireq->ir_num),
-							ireq->ir_rmt_port,
-							seed);
+		mtreq->mptcp_loc_key =3D
+			mptcp_v6_get_key(ipv6_hdr(skb)->saddr.s6_addr32,
+					 ipv6_hdr(skb)->daddr.s6_addr32,
+					 htons(ireq->ir_num),
+					 ireq->ir_rmt_port);
 #endif
 	}
 =

@@ -303,7 +309,7 @@ static void mptcp_set_key_reqsk(struct request_sock *re=
q,
  * will be created in mptcp_check_req_master(), and store the received tok=
en.
  */
 static void mptcp_reqsk_new_mptcp(struct request_sock *req,
-				  struct sock *sk,
+				  const struct sock *sk,
 				  const struct mptcp_options_received *mopt,
 				  const struct sk_buff *skb)
 {
@@ -329,34 +335,6 @@ static void mptcp_reqsk_new_mptcp(struct request_sock =
*req,
 	mtreq->mptcp_rem_key =3D mopt->mptcp_sender_key;
 }
 =

-static int mptcp_reqsk_new_cookie(struct request_sock *req,
-				  const struct mptcp_options_received *mopt,
-				  const struct sk_buff *skb)
-{
-	struct mptcp_request_sock *mtreq =3D mptcp_rsk(req);
-
-	rcu_read_lock();
-	spin_lock(&mptcp_tk_hashlock);
-
-	mptcp_set_key_reqsk(req, skb, tcp_rsk(req)->snt_isn);
-
-	if (mptcp_reqsk_find_tk(mtreq->mptcp_loc_token) ||
-	    mptcp_find_token(mtreq->mptcp_loc_token)) {
-		spin_unlock(&mptcp_tk_hashlock);
-		rcu_read_unlock();
-		return false;
-	}
-
-	inet_rsk(req)->saw_mpc =3D 1;
-
-	spin_unlock(&mptcp_tk_hashlock);
-	rcu_read_unlock();
-
-	mtreq->mptcp_rem_key =3D mopt->mptcp_sender_key;
-
-	return true;
-}
-
 static void mptcp_set_key_sk(const struct sock *sk)
 {
 	struct tcp_sock *tp =3D tcp_sk(sk);
@@ -366,15 +344,14 @@ static void mptcp_set_key_sk(const struct sock *sk)
 		tp->mptcp_loc_key =3D mptcp_v4_get_key(isk->inet_saddr,
 						     isk->inet_daddr,
 						     isk->inet_sport,
-						     isk->inet_dport,
-						     mptcp_seed++);
+						     isk->inet_dport);
 #if IS_ENABLED(CONFIG_IPV6)
 	else
-		tp->mptcp_loc_key =3D mptcp_v6_get_key(inet6_sk(sk)->saddr.s6_addr32,
-						     sk->sk_v6_daddr.s6_addr32,
-						     isk->inet_sport,
-						     isk->inet_dport,
-						     mptcp_seed++);
+		tp->mptcp_loc_key =3D
+			mptcp_v6_get_key(inet6_sk(sk)->saddr.s6_addr32,
+					 sk->sk_v6_daddr.s6_addr32,
+					 isk->inet_sport,
+					 isk->inet_dport);
 #endif
 =

 	mptcp_key_sha1(tp->mptcp_loc_key,
@@ -443,9 +420,14 @@ void mptcp_disable_static_key(void)
 void mptcp_enable_sock(struct sock *sk)
 {
 	if (!sock_flag(sk, SOCK_MPTCP)) {
+		struct tcp_sock *tp =3D tcp_sk(sk);
+
 		sock_set_flag(sk, SOCK_MPTCP);
 		tcp_sk(sk)->mptcp_ver =3D sysctl_mptcp_version;
 =

+		/* setup MPTCP specific ops */
+		tp->op_ops =3D &mptcp_default_op_ops;
+		tp->state_ops =3D &mptcp_state_ops;
 		/* Necessary here, because MPTCP can be enabled/disabled through
 		 * a setsockopt.
 		 */
@@ -465,11 +447,17 @@ void mptcp_enable_sock(struct sock *sk)
 void mptcp_disable_sock(struct sock *sk)
 {
 	if (sock_flag(sk, SOCK_MPTCP)) {
+		struct tcp_sock *tp =3D tcp_sk(sk);
+
 		sock_reset_flag(sk, SOCK_MPTCP);
 =

 		/* Necessary here, because MPTCP can be enabled/disabled through
 		 * a setsockopt.
 		 */
+
+		tp->op_ops =3D READ_ONCE(tcp_default_op_ops);
+		tp->state_ops =3D tcp_default_state_ops;
+
 		if (sk->sk_family =3D=3D AF_INET)
 			inet_csk(sk)->icsk_af_ops =3D &ipv4_specific;
 #if IS_ENABLED(CONFIG_IPV6)
@@ -483,7 +471,7 @@ void mptcp_disable_sock(struct sock *sk)
 	}
 }
 =

-void mptcp_connect_init(struct sock *sk)
+void __mptcp_connect_init(struct sock *sk)
 {
 	struct tcp_sock *tp =3D tcp_sk(sk);
 =

@@ -520,7 +508,7 @@ begin:
 		meta_sk =3D (struct sock *)meta_tp;
 		if (token =3D=3D meta_tp->mptcp_loc_token &&
 		    net_eq(net, sock_net(meta_sk))) {
-			if (unlikely(!atomic_inc_not_zero(&meta_sk->sk_refcnt)))
+			if (unlikely(!refcount_inc_not_zero(&meta_sk->sk_refcnt)))
 				goto out;
 			if (unlikely(token !=3D meta_tp->mptcp_loc_token ||
 				     !net_eq(net, sock_net(meta_sk)))) {
@@ -633,7 +621,6 @@ static void mptcp_sock_def_error_report(struct sock *sk)
 	}
 =

 	sk->sk_err =3D 0;
-	return;
 }
 =

 static void mptcp_mpcb_put(struct mptcp_cb *mpcb)
@@ -652,6 +639,8 @@ void mptcp_sock_destruct(struct sock *sk)
 	if (!is_meta_sk(sk) && !tp->was_meta_sk) {
 		BUG_ON(!hlist_unhashed(&tp->mptcp->cb_list));
 =

+		if (tp->mptcp->meta_skb)
+			kfree_skb(tp->mptcp->meta_skb);
 		kmem_cache_free(mptcp_sock_cache, tp->mptcp);
 		tp->mptcp =3D NULL;
 =

@@ -692,6 +681,7 @@ void mptcp_destroy_sock(struct sock *sk)
 		struct sock *sk_it, *tmpsk;
 =

 		__skb_queue_purge(&tcp_sk(sk)->mpcb->reinject_queue);
+		/* RCHK: Do we need to do anything about the hints ? */
 		mptcp_purge_ofo_queue(tcp_sk(sk));
 =

 		/* We have to close all remaining subflows. Normally, they
@@ -710,7 +700,9 @@ void mptcp_destroy_sock(struct sock *sk)
 			    tcp_sk(sk_it)->send_mp_fclose)
 				continue;
 =

-			/* Allow the delayed work first to prevent time-wait state */
+			/* Allow the delayed work first
+			 * to prevent time-wait state
+			 */
 			if (delayed_work_pending(&tcp_sk(sk_it)->mptcp->work))
 				continue;
 =

@@ -735,7 +727,7 @@ static void mptcp_set_state(struct sock *sk)
 			sk_wake_async(meta_sk, SOCK_WAKE_IO, POLL_OUT);
 		}
 =

-		tcp_sk(meta_sk)->lsndtime =3D tcp_time_stamp;
+		tcp_sk(meta_sk)->lsndtime =3D tcp_time_stamp(tcp_sk(meta_sk));
 	}
 =

 	if (sk->sk_state =3D=3D TCP_ESTABLISHED) {
@@ -772,12 +764,10 @@ static void mptcp_assign_congestion_control(struct so=
ck *sk)
 	 */
 	if (ca->get_info)
 		memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
-
-	return;
 }
 =

 u32 mptcp_secret[MD5_MESSAGE_BYTES / 4] ____cacheline_aligned;
-u32 mptcp_seed =3D 0;
+u32 mptcp_seed;
 =

 void mptcp_key_sha1(u64 key, u32 *token, u64 *idsn)
 {
@@ -881,7 +871,8 @@ void mptcp_hmac_sha1(u8 *key_1, u8 *key_2, u32 *hash_ou=
t, int arg_num, ...)
 }
 EXPORT_SYMBOL(mptcp_hmac_sha1);
 =

-static void mptcp_mpcb_inherit_sockopts(struct sock *meta_sk, struct sock =
*master_sk)
+static void mptcp_mpcb_inherit_sockopts(struct sock *meta_sk,
+					struct sock *master_sk)
 {
 	/* Socket-options handled by sk_clone_lock while creating the meta-sk.
 	 * =3D=3D=3D=3D=3D=3D
@@ -916,7 +907,8 @@ static void mptcp_mpcb_inherit_sockopts(struct sock *me=
ta_sk, struct sock *maste
 	 * TCP_USER_TIMEOUT
 	 * TCP_MD5SIG
 	 *
-	 * Socket-options of no concern for the meta-socket (but for the subsocke=
t)
+	 * Socket-options of no concern for the meta-socket
+	 * (but for the subsocket)
 	 * =3D=3D=3D=3D=3D=3D
 	 * SO_PRIORITY
 	 * SO_MARK
@@ -925,7 +917,9 @@ static void mptcp_mpcb_inherit_sockopts(struct sock *me=
ta_sk, struct sock *maste
 	 * TCP_QUICKACK
 	 */
 =

-	/* DEFER_ACCEPT should not be set on the meta, as we want to accept new s=
ubflows directly */
+	/* DEFER_ACCEPT should not be set on the meta, as we want to accept
+	 * new subflows directly
+	 */
 	inet_csk(meta_sk)->icsk_accept_queue.rskq_defer_accept =3D 0;
 =

 	/* Keepalives are handled entirely at the MPTCP-layer */
@@ -940,7 +934,8 @@ static void mptcp_mpcb_inherit_sockopts(struct sock *me=
ta_sk, struct sock *maste
 	inet_sk(master_sk)->recverr =3D 0;
 }
 =

-static void mptcp_sub_inherit_sockopts(const struct sock *meta_sk, struct =
sock *sub_sk)
+static void mptcp_sub_inherit_sockopts(const struct sock *meta_sk,
+				       struct sock *sub_sk)
 {
 	/* IP_TOS also goes to the subflow. */
 	if (inet_sk(sub_sk)->tos !=3D inet_sk(meta_sk)->tos) {
@@ -955,8 +950,10 @@ static void mptcp_sub_inherit_sockopts(const struct so=
ck *meta_sk, struct sock *
 	/* Inherit snd/rcv-buffer locks */
 	sub_sk->sk_userlocks =3D meta_sk->sk_userlocks & ~SOCK_BINDPORT_LOCK;
 =

-	/* Nagle/Cork is forced off on the subflows. It is handled at the meta-la=
yer */
-	tcp_sk(sub_sk)->nonagle =3D TCP_NAGLE_OFF|TCP_NAGLE_PUSH;
+	/* Nagle/Cork is forced off on the subflows.
+	 * It is handled at the meta-layer
+	 */
+	tcp_sk(sub_sk)->nonagle =3D TCP_NAGLE_OFF | TCP_NAGLE_PUSH;
 =

 	/* Keepalives are handled entirely at the MPTCP-layer */
 	if (sock_flag(sub_sk, SOCK_KEEPOPEN)) {
@@ -968,9 +965,10 @@ static void mptcp_sub_inherit_sockopts(const struct so=
ck *meta_sk, struct sock *
 	inet_sk(sub_sk)->recverr =3D 0;
 }
 =

+extern int mptcp_process_backlog(struct sock *sk, struct sk_buff *skb);
 int mptcp_backlog_rcv(struct sock *meta_sk, struct sk_buff *skb)
 {
-	/* skb-sk may be NULL if we receive a packet immediatly after the
+	/* skb-sk may be NULL if we receive a packet immediately after the
 	 * SYN/ACK + MP_CAPABLE.
 	 */
 	struct sock *sk =3D skb->sk ? skb->sk : meta_sk;
@@ -978,7 +976,15 @@ int mptcp_backlog_rcv(struct sock *meta_sk, struct sk_=
buff *skb)
 =

 	skb->sk =3D NULL;
 =

-	if (unlikely(!atomic_inc_not_zero(&sk->sk_refcnt))) {
+	if (sk->sk_state =3D=3D TCP_NEW_SYN_RECV) {
+		struct request_sock *req =3D inet_reqsk(sk);
+
+		__mptcp_join_ack(req, skb);
+
+		return 0;
+	}
+
+	if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt))) {
 		kfree_skb(skb);
 		return 0;
 	}
@@ -989,17 +995,190 @@ int mptcp_backlog_rcv(struct sock *meta_sk, struct s=
k_buff *skb)
 	else
 		ret =3D tcp_v6_do_rcv(sk, skb);
 #endif
-
 	sock_put(sk);
 	return ret;
 }
 =

+static bool mptcp_can_send(struct sock *sk)
+{
+	bool ret =3D true;
+	struct tcp_sock *tp =3D tcp_sk(sk);
+
+	if (((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) &&
+	   !tcp_passive_fastopen(mptcp(tp) && tp->mpcb->master_sk ?
+				 tp->mpcb->master_sk : sk)) {
+		ret =3D false;
+	}
+
+	mptcp_for_each_sk(tp->mpcb, sk)
+		sock_rps_record_flow(sk);
+	return ret;
+}
+
+static int mptcp_rx(struct sock *sk, struct sk_buff *skb, int refcounted)
+{
+	struct sock *meta_sk =3D mptcp_meta_sk(sk);
+	int ret =3D 0;
+
+	WARN_ON(sk->sk_state =3D=3D TCP_NEW_SYN_RECV);
+
+	bh_lock_sock_nested(meta_sk);
+	if (!sock_owned_by_user(meta_sk)) {
+		if (meta_sk->sk_family =3D=3D AF_INET)
+			ret =3D tcp_v4_do_rcv(sk, skb);
+		else
+			ret =3D tcp_v6_do_rcv(sk, skb);
+	} else {
+		skb->sk =3D sk;
+		if (tcp_add_backlog(meta_sk, skb))
+			goto discard_and_relse;
+	}
+	bh_unlock_sock(meta_sk);
+	if (refcounted)
+		sock_put(sk);
+	return ret;
+
+discard_and_relse:
+	sk_drops_add(sk, skb);
+	if (refcounted)
+		sock_put(sk);
+	kfree_skb(skb);
+	return 0;
+}
+
+unsigned int mptcp_synack_options_size(const struct sock *sk,
+				       struct request_sock *req,
+				       unsigned int mss, struct sk_buff *skb,
+				       struct tcp_out_options *opts,
+				       const struct tcp_md5sig_key *md5,
+				       struct tcp_fastopen_cookie *foc)
+{
+	unsigned int size;
+
+	size =3D tcp_default_op_ops->synack_options_size(sk, req, mss, skb,
+						       opts, md5, foc);
+	mptcp_synack_options(req, opts, &size);
+	return size;
+}
+
+int mptcp_options_size(struct sock *sk, struct sk_buff *skb,
+		       struct tcp_out_options *opts,
+		       struct tcp_md5sig_key **md5)
+{
+	unsigned int size;
+
+	/* Add checks for size */
+	size =3D tcp_default_op_ops->options_size(sk, skb, opts, md5);
+	if (unlikely(skb && (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN)))
+		mptcp_syn_options(sk, opts, &size);
+	else if (tcp_sk(sk)->mptcp)
+		mptcp_established_options(sk, skb, opts, &size);
+	return size;
+}
+
+void mptcp_connect_init(struct sock *sk)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+
+	tcp_connect_init(sk);
+
+	if (sock_flag(sk, SOCK_MPTCP) && mptcp_doit(sk)) {
+		if (is_master_tp(tp)) {
+			tp->request_mptcp =3D 1;
+			__mptcp_connect_init(sk);
+		} else if (tp->mptcp) {
+			struct inet_sock *inet  =3D inet_sk(sk);
+
+			tp->mptcp->snt_isn      =3D tp->write_seq;
+			tp->mptcp->init_rcv_wnd =3D tp->rcv_wnd;
+
+			/* Set nonce for new subflows */
+			if (sk->sk_family =3D=3D AF_INET)
+				tp->mptcp->mptcp_loc_nonce =3D
+					mptcp_v4_get_nonce(
+							inet->inet_saddr,
+							inet->inet_daddr,
+							inet->inet_sport,
+							inet->inet_dport);
+#if IS_ENABLED(CONFIG_IPV6)
+			else
+				tp->mptcp->mptcp_loc_nonce =3D
+				mptcp_v6_get_nonce(
+						inet6_sk(sk)->saddr.s6_addr32,
+						sk->sk_v6_daddr.s6_addr32,
+						inet->inet_sport,
+						inet->inet_dport);
+#endif
+		}
+	}
+}
+
+int mptcp_send_mss(struct sock *sk, int *size_goal, int flags)
+{
+	int mss_now;
+
+	mss_now =3D mptcp_current_mss(sk);
+	*size_goal =3D mptcp_xmit_size_goal(sk, mss_now, !(flags & MSG_OOB));
+	return mss_now;
+}
+
+void mptcp_v4_add_ack_opts(const struct sock *sk, struct sk_buff *skb,
+			   int *offset, struct ip_reply_arg *arg, __be32 *opt)
+{
+	/* Only state where we add MPTCP options to the ACK */
+	if (sk->sk_state =3D=3D TCP_TIME_WAIT) {
+		struct tcp_timewait_sock *tcptw =3D tcp_twsk(sk);
+		u32 data_ack =3D 0;
+
+		if (tcptw->mptcp_tw && tcptw->mptcp_tw->meta_tw) {
+			data_ack =3D (u32)tcptw->mptcp_tw->rcv_nxt;
+			opt[(*offset)++] =3D htonl((TCPOPT_MPTCP << 24) |
+						 (MPTCP_SUB_LEN_DSS +
+						 MPTCP_SUB_LEN_ACK) << 16 |
+						 (0x20 << 8) | (0x01));
+			opt[(*offset)++] =3D htonl(data_ack);
+			arg->iov[0].iov_len +=3D MPTCP_SUB_LEN_DSS +
+					       MPTCP_SUB_LEN_ACK;
+		}
+	}
+}
+
+void mptcp_v6_add_ack_opts(const struct sock *sk, struct sk_buff *skb,
+			   struct tcphdr *th, __be32 **toptr)
+{
+	if (sk && sk->sk_state =3D=3D TCP_TIME_WAIT) {
+		struct tcp_timewait_sock *tcptw =3D tcp_twsk(sk);
+		u32 data_ack =3D 0;
+		__be32 *topt =3D *toptr;
+
+		if (tcptw->mptcp_tw && tcptw->mptcp_tw->meta_tw) {
+			data_ack =3D (u32)tcptw->mptcp_tw->rcv_nxt;
+			*topt++ =3D htonl((TCPOPT_MPTCP << 24) |
+					((MPTCP_SUB_LEN_DSS +
+					MPTCP_SUB_LEN_ACK) << 16) |
+					(0x20 << 8) |
+					(0x01));
+			*topt++ =3D htonl(data_ack);
+			*toptr =3D topt;
+		} else {
+			goto adjust;
+		}
+	} else {
+adjust:
+		/* Adjust for the space that was allocated */
+		skb->data +=3D MPTCP_SUB_LEN_DSS + MPTCP_SUB_LEN_ACK;
+		skb->len -=3D MPTCP_SUB_LEN_DSS + MPTCP_SUB_LEN_ACK;
+		th->doff -=3D (MPTCP_SUB_LEN_DSS + MPTCP_SUB_LEN_ACK)/4;
+		skb_reset_transport_header(skb);
+	}
+}
+
 struct lock_class_key meta_key;
 char *meta_key_name =3D "sk_lock-AF_INET-MPTCP";
 struct lock_class_key meta_slock_key;
 char *meta_slock_key_name =3D "slock-AF_INET-MPTCP";
 =

-static const struct tcp_sock_ops mptcp_meta_specific =3D {
+static const struct tcp_operational_ops mptcp_meta_specific =3D {
 	.__select_window		=3D __mptcp_select_window,
 	.select_window			=3D mptcp_select_window,
 	.select_initial_window		=3D mptcp_select_initial_window,
@@ -1015,9 +1194,21 @@ static const struct tcp_sock_ops mptcp_meta_specific=
 =3D {
 	.retransmit_timer		=3D mptcp_meta_retransmit_timer,
 	.time_wait			=3D mptcp_time_wait,
 	.cleanup_rbuf			=3D mptcp_cleanup_rbuf,
+	.check_rtt			=3D mptcp_check_rtt,
+	.can_send			=3D mptcp_can_send,
+	.synack_options_size		=3D mptcp_synack_options_size,
+	.options_size			=3D mptcp_options_size,
+	.options_write			=3D mptcp_options_write,
+	.connect_init			=3D mptcp_connect_init,
+	.sock_init			=3D mptcp_init_tcp_sock,
+	.send_mss			=3D mptcp_send_mss,
+	.fastopen_synack		=3D mptcp_rcv_fastopen_synack,
+	.sendpage_locked		=3D mptcp_sendpage_locked,
+	.cookie_req_alloc		=3D mptcp_cookie_req_alloc,
+	.get_cookie_sock		=3D mptcp_get_cookie_sock,
 };
 =

-static const struct tcp_sock_ops mptcp_sub_specific =3D {
+static const struct tcp_operational_ops mptcp_sub_specific =3D {
 	.__select_window		=3D __mptcp_select_window,
 	.select_window			=3D mptcp_select_window,
 	.select_initial_window		=3D mptcp_select_initial_window,
@@ -1029,10 +1220,37 @@ static const struct tcp_sock_ops mptcp_sub_specific=
 =3D {
 	.write_xmit			=3D tcp_write_xmit,
 	.send_active_reset		=3D tcp_send_active_reset,
 	.write_wakeup			=3D tcp_write_wakeup,
-	.prune_ofo_queue		=3D tcp_prune_ofo_queue,
+	.prune_ofo_queue		=3D mptcp_prune_ofo_queue,
 	.retransmit_timer		=3D mptcp_sub_retransmit_timer,
 	.time_wait			=3D tcp_time_wait,
 	.cleanup_rbuf			=3D tcp_cleanup_rbuf,
+	.sndbuf_expand			=3D mptcp_sndbuf_expand,
+	.shift_skb_data			=3D mptcp_shift_skb_data,
+	.grow_window			=3D mptcp_grow_window,
+	.check_rtt			=3D mptcp_check_rtt,
+	.try_coalesce			=3D mptcp_try_coalesce,
+	.try_rmem_schedule		=3D mptcp_try_rmem_schedule,
+	.collapse_one			=3D mptcp_collapse_one,
+	.trim_head			=3D mptcp_trim_head,
+	.urg				=3D mptcp_urg,
+	.ack_only			=3D mptcp_rcv_ack_only,
+	.rx				=3D mptcp_rx,
+	.synack_options_size		=3D mptcp_synack_options_size,
+	.options_size			=3D mptcp_options_size,
+	.options_write			=3D mptcp_options_write,
+	.connect_init			=3D mptcp_connect_init,
+	.sock_init			=3D mptcp_init_tcp_sock,
+	.mtu_probe			=3D mptcp_mtu_probe,
+	.retrans_try_collapse		=3D mptcp_retrans_try_collapse,
+	.fastopen_synack		=3D mptcp_rcv_fastopen_synack,
+	.sendpage_locked		=3D mptcp_sendpage_locked,
+	.cookie_req_alloc		=3D mptcp_cookie_req_alloc,
+	.get_cookie_sock		=3D mptcp_get_cookie_sock,
+};
+
+const struct tcp_state_ops mptcp_state_ops =3D {
+	.rcv_state_process =3D tcp_rcv_state_process,
+	.synsent 	   =3D mptcp_rcv_synsent_state_process,
 };
 =

 static int mptcp_alloc_mpcb(struct sock *meta_sk, __u64 remote_key,
@@ -1062,7 +1280,7 @@ static int mptcp_alloc_mpcb(struct sock *meta_sk, __u=
64 remote_key,
 		/* sk_free (and __sk_free) requirese wmem_alloc to be 1.
 		 * All the rest is set to 0 thanks to __GFP_ZERO above.
 		 */
-		atomic_set(&master_sk->sk_wmem_alloc, 1);
+		refcount_set(&master_sk->sk_wmem_alloc, 1);
 		sk_free(master_sk);
 		return -ENOBUFS;
 	}
@@ -1071,7 +1289,8 @@ static int mptcp_alloc_mpcb(struct sock *meta_sk, __u=
64 remote_key,
 	if (meta_icsk->icsk_af_ops =3D=3D &mptcp_v6_mapped) {
 		struct ipv6_pinfo *newnp, *np =3D inet6_sk(meta_sk);
 =

-		inet_sk(master_sk)->pinet6 =3D &((struct tcp6_sock *)master_sk)->inet6;
+		inet_sk(master_sk)->pinet6 =3D
+			&((struct tcp6_sock *)master_sk)->inet6;
 =

 		newnp =3D inet6_sk(master_sk);
 		memcpy(newnp, np, sizeof(struct ipv6_pinfo));
@@ -1085,7 +1304,8 @@ static int mptcp_alloc_mpcb(struct sock *meta_sk, __u=
64 remote_key,
 	} else if (meta_sk->sk_family =3D=3D AF_INET6) {
 		struct ipv6_pinfo *newnp, *np =3D inet6_sk(meta_sk);
 =

-		inet_sk(master_sk)->pinet6 =3D &((struct tcp6_sock *)master_sk)->inet6;
+		inet_sk(master_sk)->pinet6 =3D
+			&((struct tcp6_sock *)master_sk)->inet6;
 =

 		newnp =3D inet6_sk(master_sk);
 		memcpy(newnp, np, sizeof(struct ipv6_pinfo));
@@ -1094,7 +1314,10 @@ static int mptcp_alloc_mpcb(struct sock *meta_sk, __=
u64 remote_key,
 		newnp->mcast_hops	=3D IPV6_DEFAULT_MCASTHOPS;
 		newnp->mc_loop	=3D 1;
 		newnp->pmtudisc	=3D IPV6_PMTUDISC_WANT;
-		master_sk->sk_ipv6only =3D sock_net(master_sk)->ipv6.sysctl.bindv6only;
+		newnp->repflow     =3D
+			sock_net(master_sk)->ipv6.sysctl.flowlabel_reflect;
+		master_sk->sk_ipv6only =3D
+			sock_net(master_sk)->ipv6.sysctl.bindv6only;
 	}
 #endif
 =

@@ -1148,24 +1371,17 @@ static int mptcp_alloc_mpcb(struct sock *meta_sk, _=
_u64 remote_key,
 =

 	/* Initialize the queues */
 	skb_queue_head_init(&mpcb->reinject_queue);
-	skb_queue_head_init(&master_tp->out_of_order_queue);
-	tcp_prequeue_init(master_tp);
+	INIT_LIST_HEAD(&master_tp->tsorted_sent_queue);
 	INIT_LIST_HEAD(&master_tp->tsq_node);
 =

-	master_tp->tsq_flags =3D 0;
-
 	mutex_init(&mpcb->mpcb_mutex);
 =

 	/* Init the accept_queue structure, we support a queue of 32 pending
 	 * connections, it does not need to be huge, since we only store  here
 	 * pending subflow creations.
 	 */
-	if (reqsk_queue_alloc(&meta_icsk->icsk_accept_queue, 32, GFP_ATOMIC)) {
-		inet_put_port(master_sk);
-		kmem_cache_free(mptcp_cb_cache, mpcb);
-		sk_free(master_sk);
-		return -ENOMEM;
-	}
+	/* Init the accept_queue structure */
+	reqsk_queue_alloc(&meta_icsk->icsk_accept_queue);
 =

 	if (!sock_flag(meta_sk, SOCK_MPTCP)) {
 		mptcp_enable_static_key();
@@ -1174,7 +1390,7 @@ static int mptcp_alloc_mpcb(struct sock *meta_sk, __u=
64 remote_key,
 =

 	/* Redefine function-pointers as the meta-sk is now fully ready */
 	meta_tp->mpc =3D 1;
-	meta_tp->ops =3D &mptcp_meta_specific;
+	meta_tp->op_ops =3D &mptcp_meta_specific;
 =

 	meta_sk->sk_backlog_rcv =3D mptcp_backlog_rcv;
 	meta_sk->sk_destruct =3D mptcp_sock_destruct;
@@ -1219,7 +1435,6 @@ static int mptcp_alloc_mpcb(struct sock *meta_sk, __u=
64 remote_key,
 	if (!try_module_get(inet_csk(master_sk)->icsk_ca_ops->owner))
 		tcp_assign_congestion_control(master_sk);
 =

-
 	mptcp_debug("%s: created mpcb with token %#x\n",
 		    __func__, mpcb->mptcp_loc_token);
 =

@@ -1228,7 +1443,6 @@ static int mptcp_alloc_mpcb(struct sock *meta_sk, __u=
64 remote_key,
 =

 void mptcp_fallback_meta_sk(struct sock *meta_sk)
 {
-	kfree(inet_csk(meta_sk)->icsk_accept_queue.listen_opt);
 	kmem_cache_free(mptcp_cb_cache, tcp_sk(meta_sk)->mpcb);
 }
 =

@@ -1261,7 +1475,7 @@ int mptcp_add_sock(struct sock *meta_sk, struct sock =
*sk, u8 loc_id, u8 rem_id,
 	}
 =

 	tp->mpc =3D 1;
-	tp->ops =3D &mptcp_sub_specific;
+	tp->op_ops =3D &mptcp_sub_specific;
 =

 	tp->mptcp->loc_id =3D loc_id;
 	tp->mptcp->rem_id =3D rem_id;
@@ -1297,10 +1511,11 @@ int mptcp_add_sock(struct sock *meta_sk, struct soc=
k *sk, u8 loc_id, u8 rem_id,
 	sk->sk_write_space =3D mptcp_write_space;
 	sk->sk_state_change =3D mptcp_set_state;
 	sk->sk_destruct =3D mptcp_sock_destruct;
+	sk->sk_backlog_rcv =3D tcp_v4_do_rcv;
 =

 	if (sk->sk_family =3D=3D AF_INET)
 		mptcp_debug("%s: token %#x pi %d, src_addr:%pI4:%d dst_addr:%pI4:%d, cnt=
_subflows now %d\n",
-			    __func__ , mpcb->mptcp_loc_token,
+			    __func__, mpcb->mptcp_loc_token,
 			    tp->mptcp->path_index,
 			    &((struct inet_sock *)tp)->inet_saddr,
 			    ntohs(((struct inet_sock *)tp)->inet_sport),
@@ -1310,7 +1525,7 @@ int mptcp_add_sock(struct sock *meta_sk, struct sock =
*sk, u8 loc_id, u8 rem_id,
 #if IS_ENABLED(CONFIG_IPV6)
 	else
 		mptcp_debug("%s: token %#x pi %d, src_addr:%pI6:%d dst_addr:%pI6:%d, cnt=
_subflows now %d\n",
-			    __func__ , mpcb->mptcp_loc_token,
+			    __func__, mpcb->mptcp_loc_token,
 			    tp->mptcp->path_index, &inet6_sk(sk)->saddr,
 			    ntohs(((struct inet_sock *)tp)->inet_sport),
 			    &sk->sk_v6_daddr,
@@ -1342,7 +1557,8 @@ void mptcp_del_sock(struct sock *sk)
 	if (tp_prev =3D=3D tp) {
 		mpcb->connection_list =3D tp->mptcp->next;
 	} else {
-		for (; tp_prev && tp_prev->mptcp->next; tp_prev =3D tp_prev->mptcp->next=
) {
+		for (; tp_prev && tp_prev->mptcp->next;
+			tp_prev =3D tp_prev->mptcp->next) {
 			if (tp_prev->mptcp->next =3D=3D tp) {
 				tp_prev->mptcp->next =3D tp->mptcp->next;
 				break;
@@ -1428,7 +1644,7 @@ void mptcp_cleanup_rbuf(struct sock *meta_sk, int cop=
ied)
 second_part:
 		/* This here is the second part of tcp_cleanup_rbuf */
 		if (rcv_window_now) {
-			__u32 new_window =3D tp->ops->__select_window(sk);
+			__u32 new_window =3D tp->op_ops->__select_window(sk);
 =

 			/* Send ACK now, if this read freed lots of space
 			 * in our buffer. Certainly, new_window is new window.
@@ -1454,7 +1670,7 @@ static int mptcp_sub_send_fin(struct sock *sk)
 	 */
 	mss_now =3D tcp_current_mss(sk);
 =

-	if (tcp_send_head(sk) !=3D NULL) {
+	if (tcp_send_head(sk)) {
 		TCP_SKB_CB(skb)->tcp_flags |=3D TCPHDR_FIN;
 		TCP_SKB_CB(skb)->end_seq++;
 		tp->write_seq++;
@@ -1463,6 +1679,7 @@ static int mptcp_sub_send_fin(struct sock *sk)
 		if (!skb)
 			return 1;
 =

+		INIT_LIST_HEAD(&skb->tcp_tsorted_anchor);
 		/* Reserve space for headers and prepare control bits. */
 		skb_reserve(skb, MAX_TCP_HEADER);
 		/* FIN eats a sequence byte, write_seq advanced by tcp_queue_skb(). */
@@ -1610,12 +1827,15 @@ void mptcp_update_sndbuf(const struct tcp_sock *tp)
 =

 		new_sndbuf +=3D sk->sk_sndbuf;
 =

-		if (new_sndbuf > sysctl_tcp_wmem[2] || new_sndbuf < 0) {
-			new_sndbuf =3D sysctl_tcp_wmem[2];
+		if (new_sndbuf > sock_net(meta_sk)->ipv4.sysctl_tcp_wmem[2] ||
+		    new_sndbuf < 0) {
+			new_sndbuf =3D sock_net(meta_sk)->ipv4.sysctl_tcp_wmem[2];
 			break;
 		}
 	}
-	meta_sk->sk_sndbuf =3D max(min(new_sndbuf, sysctl_tcp_wmem[2]), meta_sk->=
sk_sndbuf);
+	meta_sk->sk_sndbuf =3D max(min(new_sndbuf,
+				     sock_net(meta_sk)->ipv4.sysctl_tcp_wmem[2]),
+				 meta_sk->sk_sndbuf);
 =

 	/* The subflow's call to sk_write_space in tcp_new_space ends up in
 	 * mptcp_write_space.
@@ -1644,7 +1864,10 @@ void mptcp_close(struct sock *meta_sk, long timeout)
 	if (meta_tp->inside_tk_table) {
 		/* Detach the mpcb from the token hashtable */
 		mptcp_hash_remove_bh(meta_tp);
-		reqsk_queue_destroy(&inet_csk(meta_sk)->icsk_accept_queue);
+		/* RCHK -- Do we need to cleanup the accept queue ?
+		 * or will it get cleaned up as part of tcp_close of the
+		 * meta socket
+		 */
 	}
 =

 	meta_sk->sk_shutdown =3D SHUTDOWN_MASK;
@@ -1675,14 +1898,14 @@ void mptcp_close(struct sock *meta_sk, long timeout)
 =

 	if (data_was_unread) {
 		/* Unread data was tossed, zap the connection. */
-		NET_INC_STATS_USER(sock_net(meta_sk), LINUX_MIB_TCPABORTONCLOSE);
+		NET_INC_STATS(sock_net(meta_sk), LINUX_MIB_TCPABORTONCLOSE);
 		tcp_set_state(meta_sk, TCP_CLOSE);
-		tcp_sk(meta_sk)->ops->send_active_reset(meta_sk,
+		tcp_sk(meta_sk)->op_ops->send_active_reset(meta_sk,
 							meta_sk->sk_allocation);
 	} else if (sock_flag(meta_sk, SOCK_LINGER) && !meta_sk->sk_lingertime) {
 		/* Check zero linger _after_ checking for unread data. */
 		meta_sk->sk_prot->disconnect(meta_sk, 0);
-		NET_INC_STATS_USER(sock_net(meta_sk), LINUX_MIB_TCPABORTONDATA);
+		NET_INC_STATS(sock_net(meta_sk), LINUX_MIB_TCPABORTONDATA);
 	} else if (tcp_close_state(meta_sk)) {
 		mptcp_send_fin(meta_sk);
 	} else if (meta_tp->snd_una =3D=3D meta_tp->write_seq) {
@@ -1756,9 +1979,9 @@ adjudge_to_death:
 	if (meta_sk->sk_state =3D=3D TCP_FIN_WAIT2) {
 		if (meta_tp->linger2 < 0) {
 			tcp_set_state(meta_sk, TCP_CLOSE);
-			meta_tp->ops->send_active_reset(meta_sk, GFP_ATOMIC);
-			NET_INC_STATS_BH(sock_net(meta_sk),
-					 LINUX_MIB_TCPABORTONLINGER);
+			meta_tp->op_ops->send_active_reset(meta_sk, GFP_ATOMIC);
+			__NET_INC_STATS(sock_net(meta_sk),
+					LINUX_MIB_TCPABORTONLINGER);
 		} else {
 			const int tmo =3D tcp_fin_time(meta_sk);
 =

@@ -1766,8 +1989,8 @@ adjudge_to_death:
 				inet_csk_reset_keepalive_timer(meta_sk,
 							       tmo - TCP_TIMEWAIT_LEN);
 			} else {
-				meta_tp->ops->time_wait(meta_sk, TCP_FIN_WAIT2,
-							tmo);
+				meta_tp->op_ops->time_wait(meta_sk,
+							   TCP_FIN_WAIT2, tmo);
 				goto out;
 			}
 		}
@@ -1778,13 +2001,12 @@ adjudge_to_death:
 			if (net_ratelimit())
 				pr_info("MPTCP: out of memory: force closing socket\n");
 			tcp_set_state(meta_sk, TCP_CLOSE);
-			meta_tp->ops->send_active_reset(meta_sk, GFP_ATOMIC);
-			NET_INC_STATS_BH(sock_net(meta_sk),
-					 LINUX_MIB_TCPABORTONMEMORY);
+			meta_tp->op_ops->send_active_reset(meta_sk, GFP_ATOMIC);
+			__NET_INC_STATS(sock_net(meta_sk),
+					LINUX_MIB_TCPABORTONMEMORY);
 		}
 	}
 =

-
 	if (meta_sk->sk_state =3D=3D TCP_CLOSE)
 		inet_csk_destroy_sock(meta_sk);
 	/* Otherwise, socket is reprieved until protocol close. */
@@ -1805,7 +2027,10 @@ void mptcp_disconnect(struct sock *sk)
 =

 	if (tp->inside_tk_table) {
 		mptcp_hash_remove_bh(tp);
-		reqsk_queue_destroy(&inet_csk(tp->meta_sk)->icsk_accept_queue);
+		/* RCHK -- Do we need to cleanup the accept queue ?
+		 * or will it get cleaned up as part of tcp_close of the
+		 * meta socket
+		 */
 	}
 =

 	local_bh_disable();
@@ -1818,7 +2043,7 @@ void mptcp_disconnect(struct sock *sk)
 		 * and made non-mptcp by setting mpc to 0.
 		 *
 		 * This is necessary, because tcp_disconnect assumes
-		 * that the connection is completly dead afterwards.
+		 * that the connection is completely dead afterwards.
 		 * Thus we need to do a mptcp_del_sock. Due to this call
 		 * we have to make it non-mptcp.
 		 *
@@ -1831,7 +2056,7 @@ void mptcp_disconnect(struct sock *sk)
 		bh_lock_sock(subsk);
 		mptcp_del_sock(subsk);
 		tcp_sk(subsk)->mpc =3D 0;
-		tcp_sk(subsk)->ops =3D &tcp_specific;
+		tcp_sk(subsk)->op_ops =3D READ_ONCE(tcp_default_op_ops);
 		mptcp_sub_force_close(subsk);
 		bh_unlock_sock(subsk);
 	}
@@ -1839,10 +2064,9 @@ void mptcp_disconnect(struct sock *sk)
 =

 	tp->was_meta_sk =3D 1;
 	tp->mpc =3D 0;
-	tp->ops =3D &tcp_specific;
+	tp->op_ops =3D READ_ONCE(tcp_default_op_ops);
 }
 =

-
 /* Returns 1 if we should enable MPTCP for that socket. */
 int mptcp_doit(struct sock *sk)
 {
@@ -1862,7 +2086,7 @@ int mptcp_doit(struct sock *sk)
 		return 0;
 =

 #ifdef CONFIG_TCP_MD5SIG
-	/* If TCP_MD5SIG is enabled, do not do MPTCP - there is no Option-Space */
+	/* If TCP_MD5SIG is enabled, NO MPTCP as there is no Option-Space */
 	if (tcp_sk(sk)->af_specific->md5_lookup(sk, sk))
 		return 0;
 #endif
@@ -1875,12 +2099,19 @@ int mptcp_create_master_sk(struct sock *meta_sk, __=
u64 remote_key,
 {
 	struct tcp_sock *master_tp;
 	struct sock *master_sk;
+	struct inet_connection_sock *master_icsk;
 =

 	if (mptcp_alloc_mpcb(meta_sk, remote_key, mptcp_ver, window))
 		goto err_alloc_mpcb;
 =

 	master_sk =3D tcp_sk(meta_sk)->mpcb->master_sk;
+
 	master_tp =3D tcp_sk(master_sk);
+	master_icsk =3D inet_csk(master_sk);
+
+	master_sk->sk_write_pending =3D 0;
+	master_icsk->icsk_accept_queue.rskq_defer_accept =3D 0;
+	master_icsk->icsk_ack.pingpong =3D 0;
 =

 	if (mptcp_add_sock(meta_sk, master_sk, 0, 0, GFP_ATOMIC))
 		goto err_add_sock;
@@ -1891,7 +2122,7 @@ int mptcp_create_master_sk(struct sock *meta_sk, __u6=
4 remote_key,
 	meta_sk->sk_prot->unhash(meta_sk);
 =

 	if (master_sk->sk_family =3D=3D AF_INET || mptcp_v6_is_v4_mapped(master_s=
k))
-		__inet_hash_nolisten(master_sk, NULL);
+		inet_ehash_nolisten(master_sk, NULL);
 #if IS_ENABLED(CONFIG_IPV6)
 	else
 		__inet_hash(master_sk, NULL);
@@ -1931,7 +2162,8 @@ static int __mptcp_check_req_master(struct sock *chil=
d,
 		 * But, the socket has been added to the reqsk_tk_htb, so we
 		 * must still remove it.
 		 */
-		MPTCP_INC_STATS_BH(sock_net(meta_sk), MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK=
);
+		MPTCP_INC_STATS_BH(sock_net(meta_sk),
+				   MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
 		mptcp_reqsk_remove_tk(req);
 		return 1;
 	}
@@ -1965,7 +2197,7 @@ static int __mptcp_check_req_master(struct sock *chil=
d,
 	 */
 	mptcp_reqsk_remove_tk(req);
 =

-	/* Hold when creating the meta-sk in tcp_vX_syn_recv_sock. */
+	/* Held when creating the meta-sk in tcp_vX_syn_recv_sock. */
 	sock_put(meta_sk);
 =

 	return 0;
@@ -2037,7 +2269,7 @@ int mptcp_check_req_master(struct sock *sk, struct so=
ck *child,
 		inet_csk_reqsk_queue_drop(sk, req);
 	} else {
 		/* Thus, we come from syn-cookies */
-		atomic_set(&req->rsk_refcnt, 1);
+		refcount_set(&req->rsk_refcnt, 1);
 	}
 	inet_csk_reqsk_queue_add(sk, req, meta_sk);
 =

@@ -2075,10 +2307,11 @@ struct sock *mptcp_check_req_child(struct sock *met=
a_sk, struct sock *child,
 	sk_set_socket(child, meta_sk->sk_socket);
 	child->sk_wq =3D meta_sk->sk_wq;
 =

-	if (mptcp_add_sock(meta_sk, child, mtreq->loc_id, mtreq->rem_id, GFP_ATOM=
IC)) {
+	if (mptcp_add_sock(meta_sk, child, mtreq->loc_id,
+			   mtreq->rem_id, GFP_ATOMIC)) {
 		/* Has been inherited, but now child_tp->mptcp is NULL */
 		child_tp->mpc =3D 0;
-		child_tp->ops =3D &tcp_specific;
+		child_tp->op_ops =3D READ_ONCE(tcp_default_op_ops);
 =

 		/* TODO when we support acking the third ack for new subflows,
 		 * we should silently discard this third ack, by returning NULL.
@@ -2104,9 +2337,6 @@ struct sock *mptcp_check_req_child(struct sock *meta_=
sk, struct sock *child,
 	child_tp->mptcp->slave_sk =3D 1;
 	child_tp->mptcp->snt_isn =3D tcp_rsk(req)->snt_isn;
 	child_tp->mptcp->rcv_isn =3D tcp_rsk(req)->rcv_isn;
-	child_tp->mptcp->init_rcv_wnd =3D req->rcv_wnd;
-
-	child_tp->tsq_flags =3D 0;
 =

 	/* Subflows do not use the accept queue, as they
 	 * are attached immediately to the mpcb.
@@ -2114,8 +2344,9 @@ struct sock *mptcp_check_req_child(struct sock *meta_=
sk, struct sock *child,
 	inet_csk_reqsk_queue_drop(meta_sk, req);
 =

 	/* The refcnt is initialized to 2, because regular TCP will put him
-	 * in the socket's listener queue. However, we do not have a listener-que=
ue.
-	 * So, we need to make sure that this request-sock indeed gets destroyed.
+	 * in the socket's listener queue. However, we do not have a
+	 * listener-queue. So, we need to make sure that this request-sock
+	 * indeed gets destroyed.
 	 */
 	reqsk_put(req);
 =

@@ -2255,7 +2486,7 @@ void mptcp_tsq_flags(struct sock *sk)
 		sock_hold(sk);
 	}
 =

-	if (!test_and_set_bit(MPTCP_SUB_DEFERRED, &tcp_sk(meta_sk)->tsq_flags))
+	if (!test_and_set_bit(MPTCP_SUB_DEFERRED, &meta_sk->sk_tsq_flags))
 		sock_hold(meta_sk);
 }
 =

@@ -2268,7 +2499,8 @@ void mptcp_tsq_sub_deferred(struct sock *meta_sk)
 	BUG_ON(!is_meta_sk(meta_sk) && !meta_tp->was_meta_sk);
 =

 	__sock_put(meta_sk);
-	hlist_for_each_entry_safe(mptcp, tmp, &meta_tp->mpcb->callback_list, cb_l=
ist) {
+	hlist_for_each_entry_safe(mptcp, tmp, &meta_tp->mpcb->callback_list,
+				  cb_list) {
 		struct tcp_sock *tp =3D mptcp->tp;
 		struct sock *sk =3D (struct sock *)tp;
 =

@@ -2279,8 +2511,8 @@ void mptcp_tsq_sub_deferred(struct sock *meta_sk)
 	}
 }
 =

-void mptcp_join_reqsk_init(struct mptcp_cb *mpcb, const struct request_soc=
k *req,
-			   struct sk_buff *skb)
+void mptcp_join_reqsk_init(struct mptcp_cb *mpcb,
+			   const struct request_sock *req, struct sk_buff *skb)
 {
 	struct mptcp_request_sock *mtreq =3D mptcp_rsk(req);
 	struct mptcp_options_received mopt;
@@ -2309,25 +2541,15 @@ void mptcp_join_reqsk_init(struct mptcp_cb *mpcb, c=
onst struct request_sock *req
 	MPTCP_INC_STATS_BH(sock_net(mpcb->meta_sk), MPTCP_MIB_JOINSYNRX);
 }
 =

-void mptcp_reqsk_init(struct request_sock *req, struct sock *sk,
-		      const struct sk_buff *skb, bool want_cookie)
+void mptcp_reqsk_init(struct request_sock *req, const struct sock *sk,
+		      struct sk_buff *skb, struct mptcp_options_received *mopt)
 {
-	struct mptcp_options_received mopt;
 	struct mptcp_request_sock *mtreq =3D mptcp_rsk(req);
 =

-	mptcp_init_mp_opt(&mopt);
-	tcp_parse_mptcp_options(skb, &mopt);
-
-	mtreq->dss_csum =3D mopt.dss_csum;
-
-	if (want_cookie) {
-		if (!mptcp_reqsk_new_cookie(req, &mopt, skb))
-			/* No key available - back to regular TCP */
-			inet_rsk(req)->mptcp_rqsk =3D 0;
-		return;
-	}
-
-	mptcp_reqsk_new_mptcp(req, sk, &mopt, skb);
+	mptcp_rsk(req)->hash_entry.pprev =3D NULL;
+	mptcp_rsk(req)->is_sub =3D 0;
+	mtreq->dss_csum =3D mopt->dss_csum;
+	mptcp_reqsk_new_mptcp(req, sk, mopt, skb);
 }
 =

 void mptcp_cookies_reqsk_init(struct request_sock *req,
@@ -2384,7 +2606,8 @@ int mptcp_conn_request(struct sock *sk, struct sk_buf=
f *skb)
 			    (RTCF_BROADCAST | RTCF_MULTICAST))
 				goto drop;
 =

-			MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_MPCAPABLEPASSIVE);
+			MPTCP_INC_STATS_BH(sock_net(sk),
+					   MPTCP_MIB_MPCAPABLEPASSIVE);
 			return tcp_conn_request(&mptcp_request_sock_ops,
 						&mptcp_request_sock_ipv4_ops,
 						sk, skb);
@@ -2397,7 +2620,8 @@ int mptcp_conn_request(struct sock *sk, struct sk_buf=
f *skb)
 			if (!ipv6_unicast_destination(skb))
 				goto drop;
 =

-			MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_MPCAPABLEPASSIVE);
+			MPTCP_INC_STATS_BH(sock_net(sk),
+					   MPTCP_MIB_MPCAPABLEPASSIVE);
 			return tcp_conn_request(&mptcp6_request_sock_ops,
 						&mptcp_request_sock_ipv6_ops,
 						sk, skb);
@@ -2407,18 +2631,59 @@ int mptcp_conn_request(struct sock *sk, struct sk_b=
uff *skb)
 #endif
 	}
 drop:
-	NET_INC_STATS_BH(sock_net(sk), LINUX_MIB_LISTENDROPS);
+	__NET_INC_STATS(sock_net(sk), LINUX_MIB_LISTENDROPS);
 	return 0;
 }
 =

+struct sock *mptcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff =
*skb,
+				    struct request_sock *req,
+				    struct dst_entry *dst,
+				    struct request_sock *req_unhash,
+				    bool *own_req)
+{
+	struct sock *child;
+	struct mptcp_options_received mopt;
+
+	mptcp_init_mp_opt(&mopt);
+	tcp_parse_mptcp_options(skb, &mopt);
+
+	if (sk->sk_family =3D=3D AF_INET)
+		child =3D tcp_v4_syn_recv_sock(sk, skb, req, dst,
+					     req_unhash, own_req);
+	else
+		child =3D tcp_v6_syn_recv_sock(sk, skb, req, dst,
+					     req_unhash, own_req);
+	if (!child)
+		return child;
+
+	if (!is_meta_sk(sk)) {
+		int ret;
+
+		ret =3D __mptcp_check_req_master(child, req);
+		if (ret < 0) {
+			child =3D NULL;
+		} else if (!ret) {
+			child =3D tcp_sk(child)->mpcb->master_sk;
+			sk_set_socket(child, mptcp_meta_sk(child)->sk_socket);
+		}
+	} else {
+		child =3D mptcp_check_req_child((struct sock *)sk, child,
+					      req, &mopt);
+	}
+	return child;
+}
+
 static const struct snmp_mib mptcp_snmp_list[] =3D {
 	SNMP_MIB_ITEM("MPCapableSYNRX", MPTCP_MIB_MPCAPABLEPASSIVE),
 	SNMP_MIB_ITEM("MPCapableSYNTX", MPTCP_MIB_MPCAPABLEACTIVE),
 	SNMP_MIB_ITEM("MPCapableSYNACKRX", MPTCP_MIB_MPCAPABLEACTIVEACK),
 	SNMP_MIB_ITEM("MPCapableACKRX", MPTCP_MIB_MPCAPABLEPASSIVEACK),
-	SNMP_MIB_ITEM("MPCapableFallbackACK", MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK),
-	SNMP_MIB_ITEM("MPCapableFallbackSYNACK", MPTCP_MIB_MPCAPABLEACTIVEFALLBAC=
K),
-	SNMP_MIB_ITEM("MPCapableRetransFallback", MPTCP_MIB_MPCAPABLERETRANSFALLB=
ACK),
+	SNMP_MIB_ITEM("MPCapableFallbackACK",
+		      MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK),
+	SNMP_MIB_ITEM("MPCapableFallbackSYNACK",
+		      MPTCP_MIB_MPCAPABLEACTIVEFALLBACK),
+	SNMP_MIB_ITEM("MPCapableRetransFallback",
+		      MPTCP_MIB_MPCAPABLERETRANSFALLBACK),
 	SNMP_MIB_ITEM("MPTCPCsumEnabled", MPTCP_MIB_CSUMENABLED),
 	SNMP_MIB_ITEM("MPTCPRetrans", MPTCP_MIB_RETRANSSEGS),
 	SNMP_MIB_ITEM("MPFailRX", MPTCP_MIB_MPFAILRX),
@@ -2470,6 +2735,7 @@ static int mptcp_pm_seq_show(struct seq_file *seq, vo=
id *v)
 =

 	for (i =3D 0; i < MPTCP_HASH_SIZE; i++) {
 		struct hlist_nulls_node *node;
+
 		rcu_read_lock_bh();
 		hlist_nulls_for_each_entry_rcu(meta_tp, node,
 					       &tk_hashtable[i], tk_table) {
@@ -2482,8 +2748,8 @@ static int mptcp_pm_seq_show(struct seq_file *seq, vo=
id *v)
 =

 			if (capable(CAP_NET_ADMIN)) {
 				seq_printf(seq, "%4d: %04X %04X ", n++,
-						mpcb->mptcp_loc_token,
-						mpcb->mptcp_rem_token);
+					   mpcb->mptcp_loc_token,
+					   mpcb->mptcp_rem_token);
 			} else {
 				seq_printf(seq, "%4d: %04X %04X ", n++, -1, -1);
 			}
@@ -2496,8 +2762,10 @@ static int mptcp_pm_seq_show(struct seq_file *seq, v=
oid *v)
 					   ntohs(isk->inet_dport));
 #if IS_ENABLED(CONFIG_IPV6)
 			} else if (meta_sk->sk_family =3D=3D AF_INET6) {
-				struct in6_addr *src =3D &meta_sk->sk_v6_rcv_saddr;
+				struct in6_addr *src =3D
+					&meta_sk->sk_v6_rcv_saddr;
 				struct in6_addr *dst =3D &meta_sk->sk_v6_daddr;
+
 				seq_printf(seq, " 1 %08X%08X%08X%08X:%04X %08X%08X%08X%08X:%04X",
 					   src->s6_addr32[0], src->s6_addr32[1],
 					   src->s6_addr32[2], src->s6_addr32[3],
@@ -2540,10 +2808,10 @@ static int mptcp_snmp_seq_show(struct seq_file *seq=
, void *v)
 	struct net *net =3D seq->private;
 	int i;
 =

-	for (i =3D 0; mptcp_snmp_list[i].name !=3D NULL; i++)
+	for (i =3D 0; mptcp_snmp_list[i].name; i++)
 		seq_printf(seq, "%-32s\t%ld\n", mptcp_snmp_list[i].name,
 			   snmp_fold_field(net->mptcp.mptcp_statistics,
-				      mptcp_snmp_list[i].entry));
+					   mptcp_snmp_list[i].entry));
 =

 	return 0;
 }
@@ -2568,7 +2836,8 @@ static int mptcp_pm_init_net(struct net *net)
 		goto out_mptcp_mibs;
 =

 #ifdef CONFIG_PROC_FS
-	net->mptcp.proc_net_mptcp =3D proc_net_mkdir(net, "mptcp_net", net->proc_=
net);
+	net->mptcp.proc_net_mptcp =3D proc_net_mkdir(net, "mptcp_net",
+						   net->proc_net);
 	if (!net->mptcp.proc_net_mptcp)
 		goto out_proc_net_mptcp;
 	if (!proc_create("mptcp", S_IRUGO, net->mptcp.proc_net_mptcp,
@@ -2620,18 +2889,23 @@ void __init mptcp_init(void)
 	if (!mptcp_sock_cache)
 		goto mptcp_sock_cache_failed;
 =

-	mptcp_cb_cache =3D kmem_cache_create("mptcp_cb", sizeof(struct mptcp_cb),
-					   0, SLAB_DESTROY_BY_RCU|SLAB_HWCACHE_ALIGN,
-					   NULL);
+	mptcp_cb_cache =3D
+		kmem_cache_create("mptcp_cb", sizeof(struct mptcp_cb), 0,
+				  SLAB_TYPESAFE_BY_RCU | SLAB_HWCACHE_ALIGN,
+				  NULL);
 	if (!mptcp_cb_cache)
 		goto mptcp_cb_cache_failed;
 =

-	mptcp_tw_cache =3D kmem_cache_create("mptcp_tw", sizeof(struct mptcp_tw),
-					   0, SLAB_DESTROY_BY_RCU|SLAB_HWCACHE_ALIGN,
-					   NULL);
+	mptcp_tw_cache =3D
+		kmem_cache_create("mptcp_tw", sizeof(struct mptcp_tw), 0,
+				  SLAB_TYPESAFE_BY_RCU | SLAB_HWCACHE_ALIGN,
+				  NULL);
 	if (!mptcp_tw_cache)
 		goto mptcp_tw_cache_failed;
 =

+	if (cmpxchg(&tcp_process_unclaimed, NULL, mptcp_do_rcv))
+		goto mptcp_tw_cache_failed;
+
 	get_random_bytes(mptcp_secret, sizeof(mptcp_secret));
 =

 	mptcp_wq =3D alloc_workqueue("mptcp_wq", WQ_UNBOUND | WQ_MEM_RECLAIM, 8);
@@ -2672,6 +2946,13 @@ void __init mptcp_init(void)
 =

 	mptcp_init_failed =3D false;
 =

+	tcp_default_op_ops->sock_init =3D mptcp_init_tcp_sock;
+	mptcp_default_op_ops =3D *tcp_default_op_ops;
+	mptcp_default_op_ops.synack_options_size =3D mptcp_synack_options_size;
+	mptcp_default_op_ops.options_size =3D mptcp_options_size;
+	mptcp_default_op_ops.options_write =3D mptcp_options_write;
+	mptcp_default_op_ops.connect_init =3D mptcp_connect_init;
+
 	return;
 =

 register_sched_failed:
@@ -2690,6 +2971,7 @@ pernet_failed:
 	destroy_workqueue(mptcp_wq);
 alloc_workqueue_failed:
 	kmem_cache_destroy(mptcp_tw_cache);
+	tcp_process_unclaimed =3D NULL;
 mptcp_tw_cache_failed:
 	kmem_cache_destroy(mptcp_cb_cache);
 mptcp_cb_cache_failed:
diff --git a/net/mptcp/mptcp_fullmesh.c b/net/mptcp/mptcp_fullmesh.c
index 1e5b753..a16fb14 100644
--- a/net/mptcp/mptcp_fullmesh.c
+++ b/net/mptcp/mptcp_fullmesh.c
@@ -7,6 +7,7 @@
 #include <net/mptcp_v6.h>
 #include <net/addrconf.h>
 #endif
+#include <linux/proc_fs.h>
 =

 enum {
 	MPTCP_EVENT_ADD =3D 1,
@@ -818,7 +819,7 @@ duno:
 			else if (event->family =3D=3D AF_INET && meta_sk->sk_ipv6only)
 				continue;
 =

-			if (unlikely(!atomic_inc_not_zero(&meta_sk->sk_refcnt)))
+			if (unlikely(!refcount_inc_not_zero(&meta_sk->sk_refcnt)))
 				continue;
 =

 			bh_lock_sock(meta_sk);
@@ -835,7 +836,7 @@ duno:
 =

 			if (sock_owned_by_user(meta_sk)) {
 				if (!test_and_set_bit(MPTCP_PATH_MANAGER,
-						      &meta_tp->tsq_flags))
+						      &meta_sk->sk_tsq_flags))
 					sock_hold(meta_sk);
 =

 				goto next;
@@ -1069,7 +1070,7 @@ struct mptcp_dad_data {
 	struct inet6_ifaddr *ifa;
 };
 =

-static void dad_callback(unsigned long arg);
+static void dad_callback(struct timer_list *t);
 static int inet6_addr_event(struct notifier_block *this,
 				     unsigned long event, void *ptr);
 =

@@ -1083,7 +1084,6 @@ static void dad_init_timer(struct mptcp_dad_data *dat=
a,
 				 struct inet6_ifaddr *ifa)
 {
 	data->ifa =3D ifa;
-	data->timer.data =3D (unsigned long)data;
 	data->timer.function =3D dad_callback;
 	if (ifa->idev->cnf.rtr_solicit_delay)
 		data->timer.expires =3D jiffies + ifa->idev->cnf.rtr_solicit_delay;
@@ -1091,10 +1091,12 @@ static void dad_init_timer(struct mptcp_dad_data *d=
ata,
 		data->timer.expires =3D jiffies + (HZ/10);
 }
 =

-static void dad_callback(unsigned long arg)
+static void dad_callback(struct timer_list *t)
 {
-	struct mptcp_dad_data *data =3D (struct mptcp_dad_data *)arg;
+	struct mptcp_dad_data *data =3D from_timer(data, t, timer);
 =

+	return;
+#ifdef RAO
 	/* DAD failed or IP brought down? */
 	if (data->ifa->state =3D=3D INET6_IFADDR_STATE_ERRDAD ||
 	    data->ifa->state =3D=3D INET6_IFADDR_STATE_DEAD)
@@ -1111,21 +1113,25 @@ static void dad_callback(unsigned long arg)
 exit:
 	in6_ifa_put(data->ifa);
 	kfree(data);
+#endif
 }
 =

 static inline void dad_setup_timer(struct inet6_ifaddr *ifa)
 {
 	struct mptcp_dad_data *data;
 =

+	return;
+#ifdef RAO
 	data =3D kmalloc(sizeof(*data), GFP_ATOMIC);
 =

 	if (!data)
 		return;
 =

-	init_timer(&data->timer);
 	dad_init_timer(data, ifa);
+	timer_setup(&data->timer, data->timer.function, 0);
 	add_timer(&data->timer);
 	in6_ifa_hold(ifa);
+#endif
 }
 =

 static void addr6_event_handler(const struct inet6_ifaddr *ifa, unsigned l=
ong event,
diff --git a/net/mptcp/mptcp_input.c b/net/mptcp/mptcp_input.c
index 51cbb06..68c7680 100644
--- a/net/mptcp/mptcp_input.c
+++ b/net/mptcp/mptcp_input.c
@@ -68,7 +68,7 @@ static inline int mptcp_tso_acked_reinject(const struct s=
ock *meta_sk,
 		return 0;
 =

 	len =3D meta_tp->snd_una - TCP_SKB_CB(skb)->seq;
-	__pskb_trim_head(skb, len);
+	pskb_trim_head(skb, len);
 =

 	TCP_SKB_CB(skb)->seq +=3D len;
 	skb->ip_summed =3D CHECKSUM_PARTIAL;
@@ -76,7 +76,7 @@ static inline int mptcp_tso_acked_reinject(const struct s=
ock *meta_sk,
 =

 	/* Any change of skb->len requires recalculation of tso factor. */
 	if (tcp_skb_pcount(skb) > 1)
-		tcp_set_skb_tso_segs(meta_sk, skb, tcp_skb_mss(skb));
+		mptcp_set_skb_tso_segs(meta_sk, skb, tcp_skb_mss(skb));
 	packets_acked -=3D tcp_skb_pcount(skb);
 =

 	if (packets_acked) {
@@ -98,9 +98,9 @@ static void mptcp_clean_rtx_queue(struct sock *meta_sk, u=
32 prior_snd_una)
 	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
 	bool acked =3D false;
 	u32 acked_pcount;
+	struct sk_buff *next;
 =

-	while ((skb =3D tcp_write_queue_head(meta_sk)) &&
-	       skb !=3D tcp_send_head(meta_sk)) {
+	for (skb =3D skb_rb_first(&meta_sk->tcp_rtx_queue); skb; skb =3D next) {
 		bool fully_acked =3D true;
 =

 		if (before(meta_tp->snd_una, TCP_SKB_CB(skb)->end_seq)) {
@@ -124,8 +124,8 @@ static void mptcp_clean_rtx_queue(struct sock *meta_sk,=
 u32 prior_snd_una)
 		if (!fully_acked)
 			break;
 =

-		tcp_unlink_write_queue(skb, meta_sk);
-
+		next =3D skb_rb_next(skb);
+		tcp_rtx_queue_unlink(skb, meta_sk);
 		if (mptcp_is_data_fin(skb)) {
 			struct sock *sk_it;
 =

@@ -211,18 +211,22 @@ static int mptcp_rcv_state_process(struct sock *meta_=
sk, struct sock *sk,
 =

 		if (meta_tp->linger2 < 0 ||
 		    (data_len &&
-		     after(data_seq + data_len - (mptcp_is_data_fin2(skb, tp) ? 1 : 0),
+		     after(data_seq + data_len -
+			   (mptcp_is_data_fin2(skb, tp) ? 1 : 0),
 			   meta_tp->rcv_nxt))) {
 			mptcp_send_active_reset(meta_sk, GFP_ATOMIC);
 			tcp_done(meta_sk);
-			NET_INC_STATS_BH(sock_net(meta_sk), LINUX_MIB_TCPABORTONDATA);
+			__NET_INC_STATS(sock_net(meta_sk),
+					LINUX_MIB_TCPABORTONDATA);
 			return 1;
 		}
 =

 		tmo =3D tcp_fin_time(meta_sk);
 		if (tmo > TCP_TIMEWAIT_LEN) {
-			inet_csk_reset_keepalive_timer(meta_sk, tmo - TCP_TIMEWAIT_LEN);
-		} else if (mptcp_is_data_fin2(skb, tp) || sock_owned_by_user(meta_sk)) {
+			inet_csk_reset_keepalive_timer(meta_sk,
+						       tmo - TCP_TIMEWAIT_LEN);
+		} else if (mptcp_is_data_fin2(skb, tp) ||
+			   sock_owned_by_user(meta_sk)) {
 			/* Bad case. We could lose such FIN otherwise.
 			 * It is not a big problem, but it looks confusing
 			 * and not so rare event. We still can lose it now,
@@ -231,7 +235,7 @@ static int mptcp_rcv_state_process(struct sock *meta_sk=
, struct sock *sk,
 			 */
 			inet_csk_reset_keepalive_timer(meta_sk, tmo);
 		} else {
-			meta_tp->ops->time_wait(meta_sk, TCP_FIN_WAIT2, tmo);
+			meta_tp->op_ops->time_wait(meta_sk, TCP_FIN_WAIT2, tmo);
 		}
 		break;
 	}
@@ -254,9 +258,11 @@ static int mptcp_rcv_state_process(struct sock *meta_s=
k, struct sock *sk,
 		 */
 		if (meta_sk->sk_shutdown & RCV_SHUTDOWN) {
 			if (TCP_SKB_CB(skb)->end_seq !=3D TCP_SKB_CB(skb)->seq &&
-			    after(TCP_SKB_CB(skb)->end_seq - th->fin, tp->rcv_nxt) &&
+			    after(TCP_SKB_CB(skb)->end_seq - th->fin,
+				  tp->rcv_nxt) &&
 			    !mptcp_is_data_fin2(skb, tp)) {
-				NET_INC_STATS_BH(sock_net(meta_sk), LINUX_MIB_TCPABORTONDATA);
+				__NET_INC_STATS(sock_net(meta_sk),
+						LINUX_MIB_TCPABORTONDATA);
 				mptcp_send_active_reset(meta_sk, GFP_ATOMIC);
 				tcp_reset(meta_sk);
 				return 1;
@@ -287,17 +293,21 @@ static int mptcp_verif_dss_csum(struct sock *sk)
 	skb_queue_walk_safe(&sk->sk_receive_queue, tmp, tmp1) {
 		unsigned int csum_len;
 =

-		if (before(tp->mptcp->map_subseq + tp->mptcp->map_data_len, TCP_SKB_CB(t=
mp)->end_seq))
+		if (before(tp->mptcp->map_subseq + tp->mptcp->map_data_len,
+			   TCP_SKB_CB(tmp)->end_seq))
 			/* Mapping ends in the middle of the packet -
 			 * csum only these bytes
 			 */
-			csum_len =3D tp->mptcp->map_subseq + tp->mptcp->map_data_len - TCP_SKB_=
CB(tmp)->seq;
+			csum_len =3D tp->mptcp->map_subseq +
+				   tp->mptcp->map_data_len -
+				   TCP_SKB_CB(tmp)->seq;
 		else
 			csum_len =3D tmp->len;
 =

 		offset =3D 0;
 		if (overflowed) {
 			char first_word[4];
+
 			first_word[0] =3D 0;
 			first_word[1] =3D 0;
 			first_word[2] =3D 0;
@@ -324,7 +334,7 @@ static int mptcp_verif_dss_csum(struct sock *sk)
 			 * in the final csum_partial-call.
 			 */
 			u32 offset =3D skb_transport_offset(tmp) +
-				     TCP_SKB_CB(tmp)->dss_off;
+					tp->mptcp->rx_opt.mptcp_dss_off;
 			if (TCP_SKB_CB(tmp)->mptcp_flags & MPTCPHDR_SEQ64_SET)
 				offset +=3D 4;
 =

@@ -412,34 +422,11 @@ static inline void mptcp_prepare_skb(struct sk_buff *=
skb,
 	 * correctly handle overlapping mappings coming from different
 	 * subflows. Otherwise it would be a complete mess.
 	 */
-	tcb->seq =3D ((u32)tp->mptcp->map_data_seq) + tcb->seq - tp->mptcp->map_s=
ubseq;
+	tcb->seq =3D ((u32)tp->mptcp->map_data_seq) + tcb->seq -
+			 tp->mptcp->map_subseq;
 	tcb->end_seq =3D tcb->seq + skb->len + inc;
 }
 =

-/**
- * @return: 1 if the segment has been eaten and can be suppressed,
- *          otherwise 0.
- */
-static inline int mptcp_direct_copy(const struct sk_buff *skb,
-				    struct sock *meta_sk)
-{
-	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
-	int chunk =3D min_t(unsigned int, skb->len, meta_tp->ucopy.len);
-	int eaten =3D 0;
-
-	__set_current_state(TASK_RUNNING);
-
-	local_bh_enable();
-	if (!skb_copy_datagram_msg(skb, 0, meta_tp->ucopy.msg, chunk)) {
-		meta_tp->ucopy.len -=3D chunk;
-		meta_tp->copied_seq +=3D chunk;
-		eaten =3D (chunk =3D=3D skb->len);
-		tcp_rcv_space_adjust(meta_sk);
-	}
-	local_bh_disable();
-	return eaten;
-}
-
 static inline void mptcp_reset_mapping(struct tcp_sock *tp, u32 old_copied=
_seq)
 {
 	tp->mptcp->map_data_len =3D 0;
@@ -466,7 +453,7 @@ static void mptcp_skb_trim_head(struct sk_buff *skb, st=
ruct sock *sk, u32 seq)
 	int len =3D seq - TCP_SKB_CB(skb)->seq;
 	u32 new_seq =3D TCP_SKB_CB(skb)->seq + len;
 =

-	__pskb_trim_head(skb, len);
+	pskb_trim_head(skb, len);
 =

 	TCP_SKB_CB(skb)->seq =3D new_seq;
 =

@@ -495,7 +482,7 @@ static int mptcp_skb_split_tail(struct sk_buff *skb, st=
ruct sock *sk, u32 seq)
 =

 	/* Get a new skb... force flag on. */
 	buff =3D alloc_skb(nsize, GFP_ATOMIC);
-	if (buff =3D=3D NULL)
+	if (!buff)
 		return -ENOMEM;
 =

 	skb_reserve(buff, tcp_sk(sk)->tcp_header_len);
@@ -570,7 +557,9 @@ static int mptcp_prevalidate_skb(struct sock *sk, struc=
t sk_buff *skb)
 =

 		mptcp_sub_force_close_all(mpcb, sk);
 =

-		/* We do a seamless fallback and should not send a inf.mapping. */
+		/* We do a seamless fallback and
+		 * should not send a inf.mapping.
+		 */
 		mpcb->send_infinite_mapping =3D 0;
 		tp->mptcp->fully_established =3D 1;
 	}
@@ -607,21 +596,27 @@ static int mptcp_detect_mapping(struct sock *sk, stru=
ct sk_buff *skb)
 	 */
 	if (mpcb->infinite_mapping_rcv) {
 		/* copied_seq may be bigger than tcb->seq (e.g., when the peer
-		 * retransmits data that actually has already been acknowledged with
-		 * newer data, if he did not receive our acks). Thus, we need
-		 * to account for this overlap as well.
+		 * retransmits data that actually has already been acknowledged
+		 * with newer data, if he did not receive our acks). Thus, we
+		 * need to account for this overlap as well.
 		 */
-		tp->mptcp->map_data_seq =3D mpcb->infinite_rcv_seq - (tp->copied_seq - t=
cb->seq);
+		tp->mptcp->map_data_seq =3D mpcb->infinite_rcv_seq -
+					  (tp->copied_seq - tcb->seq);
 		tp->mptcp->map_subseq =3D tcb->seq;
 		tp->mptcp->map_data_len =3D skb->len;
-		tp->mptcp->map_data_fin =3D !!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN);
+		tp->mptcp->map_data_fin =3D
+				!!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN);
 		tp->mptcp->mapping_present =3D 1;
 		return 0;
 	}
 =

-	/* No mapping here? Exit - it is either already set or still on its way */
+	/* No mapping here? Exit -
+	 * it is either already set or still on its way
+	 */
 	if (!mptcp_is_data_seq(skb)) {
-		/* Too many packets without a mapping - this subflow is broken */
+		/* Too many packets without a mapping -
+		 * this subflow is broken
+		 */
 		if (!tp->mptcp->mapping_present &&
 		    tp->rcv_nxt - tp->copied_seq > 65536) {
 			MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_NODSSWINDOW);
@@ -632,7 +627,7 @@ static int mptcp_detect_mapping(struct sock *sk, struct=
 sk_buff *skb)
 		return 0;
 	}
 =

-	ptr =3D mptcp_skb_set_data_seq(skb, &data_seq, mpcb);
+	ptr =3D mptcp_skb_set_data_seq(tp, skb, &data_seq, mpcb);
 	ptr++;
 	sub_seq =3D get_unaligned_be32(ptr) + tp->mptcp->rcv_isn;
 	ptr++;
@@ -648,25 +643,41 @@ static int mptcp_detect_mapping(struct sock *sk, stru=
ct sk_buff *skb)
 =

 	/* If there is already a mapping - we check if it maps with the current
 	 * one. If not - we reset.
+	 * We can get few different mappings
+	 * 1. Mapping that is exactly same as the existing mapping
+	 * 2. (Sub) Mapping that fits within the current mapping and does not
+	 *    violate it.
+	 * 3. (Extended) mapping that covers the current
+	 *    mapping but extends it. We currently do not support that.
+	 * The code below does not validate sub_seq numbers -- It should.
 	 */
-	if (tp->mptcp->mapping_present &&
-	    (data_seq !=3D (u32)tp->mptcp->map_data_seq ||
-	     sub_seq !=3D tp->mptcp->map_subseq ||
-	     data_len !=3D tp->mptcp->map_data_len + tp->mptcp->map_data_fin ||
-	     mptcp_is_data_fin(skb) !=3D tp->mptcp->map_data_fin)) {
-		/* Mapping in packet is different from what we want */
-		pr_err("%s Mappings do not match!\n", __func__);
-		pr_err("%s dseq %u mdseq %u, sseq %u msseq %u dlen %u mdlen %u dfin %d m=
dfin %d\n",
-		       __func__, data_seq, (u32)tp->mptcp->map_data_seq,
-		       sub_seq, tp->mptcp->map_subseq, data_len,
-		       tp->mptcp->map_data_len, mptcp_is_data_fin(skb),
-		       tp->mptcp->map_data_fin);
-		MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_DSSNOMATCH);
-		mptcp_send_reset(sk);
-		return 1;
+	if (tp->mptcp->mapping_present) {
+		int cur_end_seq =3D (u32)tp->mptcp->map_data_seq +
+					  tp->mptcp->map_data_len;
+		int new_end_seq  =3D data_seq + data_len;
+
+		if (data_seq < (u32)tp->mptcp->map_data_seq ||
+		    new_end_seq > cur_end_seq ||
+		    (mptcp_is_data_fin(skb) !=3D tp->mptcp->map_data_fin) ||
+		    sub_seq < tp->mptcp->map_subseq ||
+		    ((sub_seq + data_len) > ((u32)tp->mptcp->map_subseq +
+		     tp->mptcp->map_data_len))) {
+			/* Mapping in packet is different from what we want */
+			pr_err("%s Mappings do not match!\n", __func__);
+			pr_err("%s dseq %u mdseq %u, sseq %u msseq %u dlen %u mdlen %u dfin %d =
mdfin %d\n",
+			       __func__, data_seq, (u32)tp->mptcp->map_data_seq,
+			sub_seq, tp->mptcp->map_subseq, data_len,
+			tp->mptcp->map_data_len, mptcp_is_data_fin(skb),
+			tp->mptcp->map_data_fin);
+			MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_DSSNOMATCH);
+			mptcp_send_reset(sk);
+			return 1;
+		}
 	}
 =

-	/* If the previous check was good, the current mapping is valid and we ex=
it. */
+	/* If the previous check was good,
+	 * the current mapping is valid and we exit.
+	 */
 	if (tp->mptcp->mapping_present)
 		return 0;
 =

@@ -681,7 +692,7 @@ static int mptcp_detect_mapping(struct sock *sk, struct=
 sk_buff *skb)
 		 */
 		tp->mptcp->send_mp_fail =3D 0;
 =

-		/* We have to fixup data_len - it must be the same as skb->len */
+		/* We have to fixup data_len - it must be same as skb->len */
 		data_len =3D skb->len + (mptcp_is_data_fin(skb) ? 1 : 0);
 		sub_seq =3D tcb->seq;
 =

@@ -710,10 +721,6 @@ static int mptcp_detect_mapping(struct sock *sk, struc=
t sk_buff *skb)
 		return -1;
 	}
 =

-	/* FIN increased the mapping-length by 1 */
-	if (mptcp_is_data_fin(skb))
-		data_len--;
-
 	/* Subflow-sequences of packet must be
 	 * (at least partially) be part of the DSS-mapping's
 	 * subflow-sequence-space.
@@ -743,33 +750,43 @@ static int mptcp_detect_mapping(struct sock *sk, stru=
ct sk_buff *skb)
 	if (tcb->tcp_flags & TCPHDR_FIN)
 		tcp_end_seq--;
 	if ((!before(sub_seq, tcb->end_seq) && after(tcp_end_seq, tcb->seq)) ||
-	    (mptcp_is_data_fin(skb) && skb->len =3D=3D 0 && after(sub_seq, tcb->e=
nd_seq)) ||
-	    (!after(sub_seq + data_len, tcb->seq) && after(tcp_end_seq, tcb->seq)=
)) {
+	    (mptcp_is_data_fin(skb) && skb->len =3D=3D 0 &&
+	    after(sub_seq, tcb->end_seq)) ||
+	    (!after(sub_seq + data_len, tcb->seq) &&
+	    after(tcp_end_seq, tcb->seq))) {
 		/* Subflow-sequences of packet is different from what is in the
 		 * packet's dss-mapping. The peer is misbehaving - reset
 		 */
-		pr_err("%s Packet's mapping does not map to the DSS sub_seq %u "
-		       "end_seq %u, tcp_end_seq %u seq %u dfin %u len %u data_len %u"
-		       "copied_seq %u\n", __func__, sub_seq, tcb->end_seq, tcp_end_seq, =
tcb->seq, mptcp_is_data_fin(skb),
-		       skb->len, data_len, tp->copied_seq);
+		pr_err("%s Packet's mapping does not map to the DSS sub_seq %u end_seq %=
u, tcp_end_seq %u seq %u dfin %u len %u data_len %u copied_seq %u\n",
+			__func__, sub_seq, tcb->end_seq, tcp_end_seq, tcb->seq,
+			mptcp_is_data_fin(skb), skb->len, data_len,
+			tp->copied_seq);
 		MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_DSSTCPMISMATCH);
 		mptcp_send_reset(sk);
 		return 1;
 	}
 =

 	/* Does the DSS had 64-bit seqnum's ? */
-	if (!(tcb->mptcp_flags & MPTCPHDR_SEQ64_SET)) {
+	if (!(TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_SEQ64_SET)) {
 		/* Wrapped around? */
-		if (unlikely(after(data_seq, meta_tp->rcv_nxt) && data_seq < meta_tp->rc=
v_nxt)) {
-			tp->mptcp->map_data_seq =3D mptcp_get_data_seq_64(mpcb, !mpcb->rcv_hise=
q_index, data_seq);
+		if (unlikely(after(data_seq, meta_tp->rcv_nxt) &&
+				   data_seq < meta_tp->rcv_nxt)) {
+			tp->mptcp->map_data_seq =3D
+				mptcp_get_data_seq_64(mpcb,
+						      !mpcb->rcv_hiseq_index,
+						      data_seq);
 		} else {
 			/* Else, access the default high-order bits */
-			tp->mptcp->map_data_seq =3D mptcp_get_data_seq_64(mpcb, mpcb->rcv_hiseq=
_index, data_seq);
+			tp->mptcp->map_data_seq =3D mptcp_get_data_seq_64(mpcb,
+						  mpcb->rcv_hiseq_index,
+						  data_seq);
 		}
 	} else {
-		tp->mptcp->map_data_seq =3D mptcp_get_data_seq_64(mpcb, (tcb->mptcp_flag=
s & MPTCPHDR_SEQ64_INDEX) ? 1 : 0, data_seq);
+		tp->mptcp->map_data_seq =3D mptcp_get_data_seq_64(mpcb,
+		    (TCP_SKB_CB(skb)->mptcp_flags &
+		    MPTCPHDR_SEQ64_INDEX) ? 1 : 0, data_seq);
 =

-		if (unlikely(tcb->mptcp_flags & MPTCPHDR_SEQ64_OFO)) {
+		if (unlikely(TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_SEQ64_OFO)) {
 			/* We make sure that the data_seq is invalid.
 			 * It will be dropped later.
 			 */
@@ -806,7 +823,8 @@ static inline bool mptcp_sequence(const struct tcp_sock=
 *meta_tp,
 	}
 =

 	return	!before64(end_data_seq, rcv_wup64) &&
-		!after64(data_seq, mptcp_get_rcv_nxt_64(meta_tp) + tcp_receive_window(me=
ta_tp));
+		!after64(data_seq, mptcp_get_rcv_nxt_64(meta_tp) +
+			 tcp_receive_window(meta_tp));
 }
 =

 /* @return: 0  everything is fine. Just continue processing
@@ -837,8 +855,10 @@ static int mptcp_validate_mapping(struct sock *sk, str=
uct sk_buff *skb)
 		tcp_end_seq--;
 	if (after(tcp_end_seq, tp->mptcp->map_subseq + tp->mptcp->map_data_len)) {
 		u32 seq =3D tp->mptcp->map_subseq + tp->mptcp->map_data_len;
+
 		MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_DSSSPLITTAIL);
-		if (mptcp_skb_split_tail(skb, sk, seq)) { /* Allocation failed */
+		if (mptcp_skb_split_tail(skb, sk, seq)) {
+			/* Allocation failed */
 			/* TODO : maybe handle this here better.
 			 * We now just force meta-retransmission.
 			 */
@@ -853,9 +873,11 @@ static int mptcp_validate_mapping(struct sock *sk, str=
uct sk_buff *skb)
 	 * This may happen if the mapping has been lost for these segments and
 	 * the next mapping has already been received.
 	 */
-	if (before(TCP_SKB_CB(skb_peek(&sk->sk_receive_queue))->seq, tp->mptcp->m=
ap_subseq)) {
+	if (before(TCP_SKB_CB(skb_peek(&sk->sk_receive_queue))->seq,
+				       tp->mptcp->map_subseq)) {
 		skb_queue_walk_safe(&sk->sk_receive_queue, tmp1, tmp) {
-			if (!before(TCP_SKB_CB(tmp1)->seq, tp->mptcp->map_subseq))
+			if (!before(TCP_SKB_CB(tmp1)->seq,
+				    tp->mptcp->map_subseq))
 				break;
 =

 			tp->copied_seq =3D TCP_SKB_CB(tmp1)->end_seq;
@@ -889,7 +911,8 @@ static int mptcp_queue_skb(struct sock *sk)
 =

 	/* Have we not yet received the full mapping? */
 	if (!tp->mptcp->mapping_present ||
-	    before(tp->rcv_nxt, tp->mptcp->map_subseq + tp->mptcp->map_data_len))
+	    before(tp->rcv_nxt, tp->mptcp->map_subseq +
+		   tp->mptcp->map_data_len))
 		return 0;
 =

 	/* Is this an overlapping mapping? rcv_nxt >=3D end_data_seq
@@ -943,7 +966,7 @@ static int mptcp_queue_skb(struct sock *sk)
 			skb_orphan(tmp1);
 =

 			if (!mpcb->in_time_wait) /* In time-wait, do not receive data */
-				mptcp_add_meta_ofo_queue(meta_sk, tmp1, sk);
+				mptcp_add_meta_ofo_queue(meta_sk, tmp1);
 			else
 				__kfree_skb(tmp1);
 =

@@ -979,18 +1002,14 @@ static int mptcp_queue_skb(struct sock *sk)
 				goto next;
 			}
 =

-			/* Is direct copy possible ? */
-			if (TCP_SKB_CB(tmp1)->seq =3D=3D meta_tp->rcv_nxt &&
-			    meta_tp->ucopy.task =3D=3D current &&
-			    meta_tp->copied_seq =3D=3D meta_tp->rcv_nxt &&
-			    meta_tp->ucopy.len && sock_owned_by_user(meta_sk))
-				eaten =3D mptcp_direct_copy(tmp1, meta_sk);
-
-			if (mpcb->in_time_wait) /* In time-wait, do not receive data */
+			/* In time-wait, do not receive data */
+			if (mpcb->in_time_wait)
 				eaten =3D 1;
 =

-			if (!eaten)
-				eaten =3D tcp_queue_rcv(meta_sk, tmp1, 0, &fragstolen);
+			if (!eaten) {
+				eaten =3D tcp_queue_rcv(meta_sk, tmp1, 0,
+						      &fragstolen);
+			}
 =

 			meta_tp->rcv_nxt =3D TCP_SKB_CB(tmp1)->end_seq;
 			mptcp_check_rcvseq_wrap(meta_tp, old_rcv_nxt);
@@ -999,7 +1018,7 @@ static int mptcp_queue_skb(struct sock *sk)
 				mptcp_fin(meta_sk);
 =

 			/* Check if this fills a gap in the ofo queue */
-			if (!skb_queue_empty(&meta_tp->out_of_order_queue))
+			if (!RB_EMPTY_ROOT(&meta_tp->out_of_order_queue))
 				mptcp_ofo_queue(meta_sk);
 =

 			if (eaten)
@@ -1014,12 +1033,74 @@ next:
 		}
 	}
 =

-	inet_csk(meta_sk)->icsk_ack.lrcvtime =3D tcp_time_stamp;
+	inet_csk(meta_sk)->icsk_ack.lrcvtime =3D tcp_jiffies32;
 	mptcp_reset_mapping(tp, old_copied_seq);
 =

 	return data_queued ? -1 : -2;
 }
 =

+static struct sk_buff *
+mptcp_process_ack(struct sock *sk, struct sk_buff *skb)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	int flag =3D 0;
+
+	/*
+	 * TCP takes care of invalid ack's
+	 * they will never show up here.
+	 */
+
+	 /* Is this skb acknowleding any data */
+
+	if (tp->mptcp->snt_isn + 1 !=3D TCP_SKB_CB(skb)->ack_seq)
+		flag =3D MPTCP_FLAG_DATA_ACKED;
+
+	if (mptcp_fallback_infinite(sk, flag)) {
+		pr_err("%s resetting flow\n", __func__);
+		mptcp_send_reset(sk);
+		goto invalid_ack;
+	}
+
+	mptcp_clean_rtx_infinite(skb, sk);
+
+	return skb;
+invalid_ack:
+	__skb_unlink(skb, &sk->sk_receive_queue);
+	__kfree_skb(skb);
+	return NULL;
+}
+
+static struct sk_buff *
+mptcp_process_options_ack(struct sock *sk, struct sk_buff *skb)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	const struct tcphdr *th =3D tcp_hdr(skb);
+
+	TCP_SKB_CB(skb)->mptcp_flags =3D 0;
+	mptcp_init_mp_opt(&tp->mptcp->rx_opt);
+
+	tcp_parse_mptcp_options(skb, &tp->mptcp->rx_opt);
+	if (mptcp_handle_options(sk, th, skb)) {
+		mptcp_reset_mopt(tp);
+		if (skb->next && skb->prev)
+			__skb_unlink(skb, &sk->sk_receive_queue);
+		__kfree_skb(skb);
+		skb =3D NULL;
+		goto done;
+	}
+	skb =3D mptcp_process_ack(sk, skb);
+	if (skb !=3D NULL && (skb->len =3D=3D 0 ||
+	    TCP_SKB_CB(skb)->seq =3D=3D TCP_SKB_CB(skb)->end_seq)) {
+		/* Pure ack */
+		if (skb->next && skb->prev)
+			__skb_unlink(skb, &sk->sk_receive_queue);
+		__kfree_skb(skb);
+		skb =3D NULL;
+	}
+done:
+	return skb;
+}
+
 void mptcp_data_ready(struct sock *sk)
 {
 	struct sock *meta_sk =3D mptcp_meta_sk(sk);
@@ -1045,6 +1126,10 @@ restart:
 	 */
 	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
 		int ret;
+
+		skb =3D mptcp_process_options_ack(sk, skb);
+		if (skb =3D=3D NULL)
+			continue;
 		/* Pre-validation - e.g., early fallback */
 		ret =3D mptcp_prevalidate_skb(sk, skb);
 		if (ret < 0)
@@ -1063,6 +1148,64 @@ restart:
 		if (mptcp_validate_mapping(sk, skb) < 0)
 			goto restart;
 =

+#ifdef RCHK
+		u64 rcv_nxt64 =3D mptcp_get_rcv_nxt_64(meta_tp);
+		/* Have we not yet received the full mapping? */
+		if (!tp->mptcp->mapping_present ||
+		    before(tp->rcv_nxt, tp->mptcp->map_subseq +
+			   tp->mptcp->map_data_len));
+			continue;
+
+		/* Verify the checksum */
+		if (mpcb->dss_csum && !mpcb->infinite_mapping_rcv) {
+			int ret =3D mptcp_verif_dss_csum(sk);
+
+			if (ret <=3D 0) {
+				mptcp_reset_mapping(tp, old_copied_seq);
+				break;
+			}
+		}
+
+		rcv_nxt64 =3D mptcp_get_rcv_nxt_64(meta_tp);
+		/* If the next byte expected is beyond the current mapping
+		 * rcv_nxt >=3D end_data_seq
+		 * OR The mapping is out of window, reset the mapping
+		 * rcv_nxt64 is retrieved without holding any lock
+		 * that should be ok as we will re-test under lock
+		 */
+		if (!before64(rcv_nxt64, tp->mptcp->map_data_seq +
+		    tp->mptcp->map_data_len + tp->mptcp->map_data_fin) ||
+		    !mptcp_sequence(meta_tp, tp->mptcp->map_data_seq,
+		    tp->mptcp->map_data_seq + tp->mptcp->map_data_len +
+		    tp->mptcp->map_data_fin)) {
+			skb_queue_walk_safe(&sk->sk_receive_queue, tmp1, tmp) {
+				__skb_unlink(tmp1, &sk->sk_receive_queue);
+				tp->copied_seq =3D TCP_SKB_CB(tmp1)->end_seq;
+				__kfree_skb(tmp1);
+
+				/* Are we past the current (old) mapping ?
+				 * Is yes, reset mapping and restart
+				 */
+				if (!skb_queue_empty(&sk->sk_receive_queue) &&
+				    !before(TCP_SKB_CB(tmp)->seq,
+					    tp->mptcp->map_subseq +
+					    tp->mptcp->map_data_len))
+					break;
+			}
+			mptcp_reset_mapping(tp, old_copied_seq);
+			goto restart;
+		}
+
+		/* Record it, because we want to send our
+		 * data_fin on the same path
+		 */
+		if (tp->mptcp->map_data_fin) {
+			mpcb->dfin_path_index =3D tp->mptcp->path_index;
+			mpcb->dfin_combined =3D
+			    !!(sk->sk_shutdown & RCV_SHUTDOWN);
+		}
+#endif /* RCHK */
+
 		/* Push a level higher */
 		ret =3D mptcp_queue_skb(sk);
 		if (ret < 0) {
@@ -1079,60 +1222,13 @@ restart:
 exit:
 	if (tcp_sk(sk)->close_it && sk->sk_state =3D=3D TCP_FIN_WAIT2) {
 		tcp_send_ack(sk);
-		tcp_sk(sk)->ops->time_wait(sk, TCP_TIME_WAIT, 0);
+		tcp_sk(sk)->op_ops->time_wait(sk, TCP_TIME_WAIT, 0);
 	}
 =

 	if (queued =3D=3D -1 && !sock_flag(meta_sk, SOCK_DEAD))
 		meta_sk->sk_data_ready(meta_sk);
 }
 =

-
-int mptcp_check_req(struct sk_buff *skb, struct net *net)
-{
-	const struct tcphdr *th =3D tcp_hdr(skb);
-	struct sock *meta_sk =3D NULL;
-
-	/* MPTCP structures not initialized */
-	if (mptcp_init_failed)
-		return 0;
-
-	if (skb->protocol =3D=3D htons(ETH_P_IP))
-		meta_sk =3D mptcp_v4_search_req(th->source, ip_hdr(skb)->saddr,
-					      ip_hdr(skb)->daddr, net);
-#if IS_ENABLED(CONFIG_IPV6)
-	else /* IPv6 */
-		meta_sk =3D mptcp_v6_search_req(th->source, &ipv6_hdr(skb)->saddr,
-					      &ipv6_hdr(skb)->daddr, net);
-#endif /* CONFIG_IPV6 */
-
-	if (!meta_sk)
-		return 0;
-
-	TCP_SKB_CB(skb)->mptcp_flags |=3D MPTCPHDR_JOIN;
-
-	bh_lock_sock_nested(meta_sk);
-	if (sock_owned_by_user(meta_sk)) {
-		skb->sk =3D meta_sk;
-		if (unlikely(sk_add_backlog(meta_sk, skb,
-					    meta_sk->sk_rcvbuf + meta_sk->sk_sndbuf))) {
-			bh_unlock_sock(meta_sk);
-			NET_INC_STATS_BH(net, LINUX_MIB_TCPBACKLOGDROP);
-			sock_put(meta_sk); /* Taken by mptcp_search_req */
-			kfree_skb(skb);
-			return 1;
-		}
-	} else if (skb->protocol =3D=3D htons(ETH_P_IP)) {
-		tcp_v4_do_rcv(meta_sk, skb);
-#if IS_ENABLED(CONFIG_IPV6)
-	} else { /* IPv6 */
-		tcp_v6_do_rcv(meta_sk, skb);
-#endif /* CONFIG_IPV6 */
-	}
-	bh_unlock_sock(meta_sk);
-	sock_put(meta_sk); /* Taken by mptcp_vX_search_req */
-	return 1;
-}
-
 struct mp_join *mptcp_find_join(const struct sk_buff *skb)
 {
 	const struct tcphdr *th =3D tcp_hdr(skb);
@@ -1158,9 +1254,8 @@ struct mp_join *mptcp_find_join(const struct sk_buff =
*skb)
 			if (opsize > length)
 				return NULL;  /* don't parse partial options */
 			if (opcode =3D=3D TCPOPT_MPTCP &&
-			    ((struct mptcp_option *)(ptr - 2))->sub =3D=3D MPTCP_SUB_JOIN) {
+			    ((struct mptcp_option *)(ptr - 2))->sub =3D=3D MPTCP_SUB_JOIN)
 				return (struct mp_join *)(ptr - 2);
-			}
 			ptr +=3D opsize - 2;
 			length -=3D opsize;
 		}
@@ -1168,6 +1263,8 @@ struct mp_join *mptcp_find_join(const struct sk_buff =
*skb)
 	return NULL;
 }
 =

+/* Shoaib: With the recent changes this is most likely not needed
+ */
 int mptcp_lookup_join(struct sk_buff *skb, struct inet_timewait_sock *tw)
 {
 	const struct mptcp_cb *mpcb;
@@ -1175,32 +1272,36 @@ int mptcp_lookup_join(struct sk_buff *skb, struct i=
net_timewait_sock *tw)
 	u32 token;
 	bool meta_v4;
 	struct mp_join *join_opt =3D mptcp_find_join(skb);
+
 	if (!join_opt)
 		return 0;
 =

 	/* MPTCP structures were not initialized, so return error */
 	if (mptcp_init_failed)
-		return -1;
+		return 0;
 =

 	token =3D join_opt->u.syn.token;
 	meta_sk =3D mptcp_hash_find(dev_net(skb_dst(skb)->dev), token);
+
 	if (!meta_sk) {
-		MPTCP_INC_STATS_BH(dev_net(skb_dst(skb)->dev), MPTCP_MIB_JOINNOTOKEN);
+		MPTCP_INC_STATS_BH(dev_net(skb_dst(skb)->dev),
+				   MPTCP_MIB_JOINNOTOKEN);
 		mptcp_debug("%s:mpcb not found:%x\n", __func__, token);
-		return -1;
+		return 0;
 	}
 =

 	meta_v4 =3D meta_sk->sk_family =3D=3D AF_INET;
+
 	if (meta_v4) {
 		if (skb->protocol =3D=3D htons(ETH_P_IPV6)) {
 			mptcp_debug("SYN+MP_JOIN with IPV6 address on pure IPV4 meta\n");
 			sock_put(meta_sk); /* Taken by mptcp_hash_find */
-			return -1;
+			return 0;
 		}
 	} else if (skb->protocol =3D=3D htons(ETH_P_IP) && meta_sk->sk_ipv6only) {
 		mptcp_debug("SYN+MP_JOIN with IPV4 address on IPV6_V6ONLY meta\n");
 		sock_put(meta_sk); /* Taken by mptcp_hash_find */
-		return -1;
+		return 0;
 	}
 =

 	mpcb =3D tcp_sk(meta_sk)->mpcb;
@@ -1210,17 +1311,15 @@ int mptcp_lookup_join(struct sk_buff *skb, struct i=
net_timewait_sock *tw)
 		 */
 		sock_put(meta_sk); /* Taken by mptcp_hash_find */
 		MPTCP_INC_STATS_BH(sock_net(meta_sk), MPTCP_MIB_JOINFALLBACK);
-		return -1;
+		return 0;
 	}
 =

 	/* Coming from time-wait-sock processing in tcp_v4_rcv.
 	 * We have to deschedule it before continuing, because otherwise
 	 * mptcp_v4_do_rcv will hit again on it inside tcp_v4_hnd_req.
 	 */
-	if (tw) {
-		inet_twsk_deschedule(tw);
-		inet_twsk_put(tw);
-	}
+	if (tw)
+		inet_twsk_deschedule_put(tw);
 =

 	TCP_SKB_CB(skb)->mptcp_flags |=3D MPTCPHDR_JOIN;
 	/* OK, this is a new syn/join, let's create a new open request and
@@ -1230,21 +1329,19 @@ int mptcp_lookup_join(struct sk_buff *skb, struct i=
net_timewait_sock *tw)
 	if (sock_owned_by_user(meta_sk)) {
 		skb->sk =3D meta_sk;
 		if (unlikely(sk_add_backlog(meta_sk, skb,
-					    meta_sk->sk_rcvbuf + meta_sk->sk_sndbuf))) {
+					    meta_sk->sk_rcvbuf +
+					    meta_sk->sk_sndbuf))) {
 			bh_unlock_sock(meta_sk);
-			NET_INC_STATS_BH(sock_net(meta_sk),
+			__NET_INC_STATS(sock_net(meta_sk),
 					 LINUX_MIB_TCPBACKLOGDROP);
 			sock_put(meta_sk); /* Taken by mptcp_hash_find */
 			kfree_skb(skb);
 			return 1;
 		}
-	} else if (skb->protocol =3D=3D htons(ETH_P_IP)) {
-		tcp_v4_do_rcv(meta_sk, skb);
-#if IS_ENABLED(CONFIG_IPV6)
 	} else {
-		tcp_v6_do_rcv(meta_sk, skb);
-#endif /* CONFIG_IPV6 */
+		mptcp_process_join_req(meta_sk, skb);
 	}
+
 	bh_unlock_sock(meta_sk);
 	sock_put(meta_sk); /* Taken by mptcp_hash_find */
 	return 1;
@@ -1261,7 +1358,8 @@ int mptcp_do_join_short(struct sk_buff *skb,
 	token =3D mopt->mptcp_rem_token;
 	meta_sk =3D mptcp_hash_find(net, token);
 	if (!meta_sk) {
-		MPTCP_INC_STATS_BH(dev_net(skb_dst(skb)->dev), MPTCP_MIB_JOINNOTOKEN);
+		MPTCP_INC_STATS_BH(dev_net(skb_dst(skb)->dev),
+				   MPTCP_MIB_JOINNOTOKEN);
 		mptcp_debug("%s:mpcb not found:%x\n", __func__, token);
 		return -1;
 	}
@@ -1279,8 +1377,6 @@ int mptcp_do_join_short(struct sk_buff *skb,
 		return -1;
 	}
 =

-	TCP_SKB_CB(skb)->mptcp_flags |=3D MPTCPHDR_JOIN;
-
 	/* OK, this is a new syn/join, let's create a new open request and
 	 * send syn+ack
 	 */
@@ -1306,7 +1402,7 @@ int mptcp_do_join_short(struct sk_buff *skb,
 		skb->sk =3D meta_sk;
 		if (unlikely(sk_add_backlog(meta_sk, skb,
 					    meta_sk->sk_rcvbuf + meta_sk->sk_sndbuf)))
-			NET_INC_STATS_BH(net, LINUX_MIB_TCPBACKLOGDROP);
+			__NET_INC_STATS(net, LINUX_MIB_TCPBACKLOGDROP);
 		else
 			/* Must make sure that upper layers won't free the
 			 * skb if it is added to the backlog-queue.
@@ -1318,13 +1414,7 @@ int mptcp_do_join_short(struct sk_buff *skb,
 		 * coming from)
 		 */
 		skb_get(skb);
-		if (skb->protocol =3D=3D htons(ETH_P_IP)) {
-			tcp_v4_do_rcv(meta_sk, skb);
-#if IS_ENABLED(CONFIG_IPV6)
-		} else { /* IPv6 */
-			tcp_v6_do_rcv(meta_sk, skb);
-#endif /* CONFIG_IPV6 */
-		}
+		mptcp_process_join_req(meta_sk, skb);
 	}
 =

 	bh_unlock_sock(meta_sk);
@@ -1393,7 +1483,7 @@ void mptcp_fin(struct sock *meta_sk)
 	case TCP_FIN_WAIT2:
 		/* Received a FIN -- send ACK and enter TIME_WAIT. */
 		tcp_send_ack(sk);
-		meta_tp->ops->time_wait(meta_sk, TCP_TIME_WAIT, 0);
+		meta_tp->op_ops->time_wait(meta_sk, TCP_TIME_WAIT, 0);
 		break;
 	default:
 		/* Only TCP_LISTEN and TCP_CLOSE are left, in these
@@ -1426,23 +1516,25 @@ void mptcp_fin(struct sock *meta_sk)
 =

 static void mptcp_xmit_retransmit_queue(struct sock *meta_sk)
 {
+	const struct inet_connection_sock *icsk =3D inet_csk(meta_sk);
 	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
-	struct sk_buff *skb;
+	struct sk_buff *rtx_head, *skb;
 =

 	if (!meta_tp->packets_out)
 		return;
 =

-	tcp_for_write_queue(skb, meta_sk) {
-		if (skb =3D=3D tcp_send_head(meta_sk))
+	rtx_head =3D skb =3D tcp_rtx_queue_head(meta_sk);
+	skb_rbtree_walk_from(skb) {
+#ifdef RCHK
+		if (tcp_pacing_check(meta_sk))
 			break;
-
+#endif
 		if (mptcp_retransmit_skb(meta_sk, skb))
 			return;
-
-		if (skb =3D=3D tcp_write_queue_head(meta_sk))
+		if (skb =3D=3D rtx_head &&
+		    icsk->icsk_pending !=3D ICSK_TIME_REO_TIMEOUT)
 			inet_csk_reset_xmit_timer(meta_sk, ICSK_TIME_RETRANS,
-						  inet_csk(meta_sk)->icsk_rto,
-						  TCP_RTO_MAX);
+			    inet_csk(meta_sk)->icsk_rto, TCP_RTO_MAX);
 	}
 }
 =

@@ -1450,9 +1542,8 @@ static void mptcp_snd_una_update(struct tcp_sock *met=
a_tp, u32 data_ack)
 {
 	u32 delta =3D data_ack - meta_tp->snd_una;
 =

-	u64_stats_update_begin(&meta_tp->syncp);
+	sock_owned_by_me((struct sock *)meta_tp);
 	meta_tp->bytes_acked +=3D delta;
-	u64_stats_update_end(&meta_tp->syncp);
 	meta_tp->snd_una =3D data_ack;
 }
 =

@@ -1461,7 +1552,6 @@ static void mptcp_data_ack(struct sock *sk, const str=
uct sk_buff *skb)
 {
 	struct sock *meta_sk =3D mptcp_meta_sk(sk);
 	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk), *tp =3D tcp_sk(sk);
-	struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
 	u32 prior_snd_una =3D meta_tp->snd_una;
 	int prior_packets;
 	u32 nwin, data_ack, data_seq;
@@ -1481,7 +1571,8 @@ static void mptcp_data_ack(struct sock *sk, const str=
uct sk_buff *skb)
 	/* If we are in infinite mapping mode, rx_opt.data_ack has been
 	 * set by mptcp_clean_rtx_infinite.
 	 */
-	if (!(tcb->mptcp_flags & MPTCPHDR_ACK) && !tp->mpcb->infinite_mapping_snd)
+	if (!(TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_ACK) &&
+		!tp->mpcb->infinite_mapping_snd)
 		goto exit;
 =

 	data_ack =3D tp->mptcp->rx_opt.data_ack;
@@ -1542,7 +1633,7 @@ static void mptcp_data_ack(struct sock *sk, const str=
uct sk_buff *skb)
 	 */
 	sk->sk_err_soft =3D 0;
 	inet_csk(meta_sk)->icsk_probes_out =3D 0;
-	meta_tp->rcv_tstamp =3D tcp_time_stamp;
+	meta_tp->rcv_tstamp =3D tcp_jiffies32;
 	prior_packets =3D meta_tp->packets_out;
 	if (!prior_packets)
 		goto no_queue;
@@ -1647,7 +1738,7 @@ static inline bool is_valid_addropt_opsize(u8 mptcp_v=
er,
 =

 void mptcp_parse_options(const uint8_t *ptr, int opsize,
 			 struct mptcp_options_received *mopt,
-			 const struct sk_buff *skb,
+			 struct sk_buff *skb,
 			 struct tcp_sock *tp)
 {
 	const struct mptcp_option *mp_opt =3D (struct mptcp_option *)ptr;
@@ -1738,7 +1829,6 @@ void mptcp_parse_options(const uint8_t *ptr, int opsi=
ze,
 	case MPTCP_SUB_DSS:
 	{
 		const struct mp_dss *mdss =3D (struct mp_dss *)ptr;
-		struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
 =

 		/* We check opsize for the csum and non-csum case. We do this,
 		 * because the draft says that the csum SHOULD be ignored if
@@ -1757,7 +1847,7 @@ void mptcp_parse_options(const uint8_t *ptr, int opsi=
ze,
 		ptr +=3D 4;
 =

 		if (mdss->A) {
-			tcb->mptcp_flags |=3D MPTCPHDR_ACK;
+			TCP_SKB_CB(skb)->mptcp_flags |=3D MPTCPHDR_ACK;
 =

 			if (mdss->a) {
 				mopt->data_ack =3D (u32) get_unaligned_be64(ptr);
@@ -1768,13 +1858,14 @@ void mptcp_parse_options(const uint8_t *ptr, int op=
size,
 			}
 		}
 =

-		tcb->dss_off =3D (ptr - skb_transport_header(skb));
+		mopt->mptcp_dss_off =3D (ptr - skb_transport_header(skb));
 =

 		if (mdss->M) {
 			if (mdss->m) {
 				u64 data_seq64 =3D get_unaligned_be64(ptr);
 =

-				tcb->mptcp_flags |=3D MPTCPHDR_SEQ64_SET;
+				TCP_SKB_CB(skb)->mptcp_flags |=3D
+				    MPTCPHDR_SEQ64_SET;
 				mopt->data_seq =3D (u32) data_seq64;
 =

 				ptr +=3D 12; /* 64-bit dseq + subseq */
@@ -1784,15 +1875,17 @@ void mptcp_parse_options(const uint8_t *ptr, int op=
size,
 			}
 			mopt->data_len =3D get_unaligned_be16(ptr);
 =

-			tcb->mptcp_flags |=3D MPTCPHDR_SEQ;
+			TCP_SKB_CB(skb)->mptcp_flags |=3D MPTCPHDR_SEQ;
 =

 			/* Is a check-sum present? */
-			if (opsize =3D=3D mptcp_sub_len_dss(mdss, 1))
-				tcb->mptcp_flags |=3D MPTCPHDR_DSS_CSUM;
+			if (opsize =3D=3D mptcp_sub_len_dss(mdss, 1)) {
+				TCP_SKB_CB(skb)->mptcp_flags |=3D
+					MPTCPHDR_DSS_CSUM;
+			}
 =

 			/* DATA_FIN only possible with DSS-mapping */
 			if (mdss->F)
-				tcb->mptcp_flags |=3D MPTCPHDR_FIN;
+				TCP_SKB_CB(skb)->mptcp_flags |=3D MPTCPHDR_FIN;
 		}
 =

 		break;
@@ -1884,7 +1977,7 @@ void mptcp_parse_options(const uint8_t *ptr, int opsi=
ze,
 }
 =

 /** Parse only MPTCP options */
-void tcp_parse_mptcp_options(const struct sk_buff *skb,
+void tcp_parse_mptcp_options(struct sk_buff *skb,
 			     struct mptcp_options_received *mopt)
 {
 	const struct tcphdr *th =3D tcp_hdr(skb);
@@ -1907,30 +2000,37 @@ void tcp_parse_mptcp_options(const struct sk_buff *=
skb,
 				return;
 			if (opsize > length)
 				return;	/* don't parse partial options */
-			if (opcode =3D=3D TCPOPT_MPTCP)
-				mptcp_parse_options(ptr - 2, opsize, mopt, skb, NULL);
+			if (opcode =3D=3D TCPOPT_MPTCP) {
+				mptcp_parse_options(ptr - 2, opsize,
+						    mopt, skb, NULL);
+			}
 		}
 		ptr +=3D opsize - 2;
 		length -=3D opsize;
 	}
 }
 =

-bool mptcp_check_rtt(const struct tcp_sock *tp, int time)
+bool mptcp_check_rtt(struct sock *sk)
 {
+	struct tcp_sock *tp =3D tcp_sk(sk);
 	struct mptcp_cb *mpcb =3D tp->mpcb;
-	struct sock *sk;
+	struct sock *__sk;
+	int time;
 	u32 rtt_max =3D 0;
 =

+	time =3D tcp_stamp_us_delta(tp->tcp_mstamp, tp->rcvq_space.time);
+
 	/* In MPTCP, we take the max delay across all flows,
 	 * in order to take into account meta-reordering buffers.
 	 */
-	mptcp_for_each_sk(mpcb, sk) {
-		if (!mptcp_sk_can_recv(sk))
+	mptcp_for_each_sk(mpcb, __sk) {
+		if (!mptcp_sk_can_recv(__sk))
 			continue;
 =

-		if (rtt_max < tcp_sk(sk)->rcv_rtt_est.rtt)
-			rtt_max =3D tcp_sk(sk)->rcv_rtt_est.rtt;
+		if (rtt_max < tcp_sk(__sk)->rcv_rtt_est.rtt_us)
+			rtt_max =3D tcp_sk(__sk)->rcv_rtt_est.rtt_us;
 	}
+
 	if (time < (rtt_max >> 3) || !rtt_max)
 		return true;
 =

@@ -1968,9 +2068,10 @@ static void mptcp_handle_add_addr(const unsigned cha=
r *ptr, struct sock *sk)
 				1, (u8 *)&mpadd->addr_id,
 				4, (u8 *)&mpadd->u.v4.addr.s_addr,
 				2, (u8 *)&mpadd->u.v4.port);
-		if (memcmp(hash_mac_check, recv_hmac, 8) !=3D 0)
+		if (memcmp(hash_mac_check, recv_hmac, 8) !=3D 0) {
 			/* ADD_ADDR2 discarded */
 			return;
+		}
 skip_hmac_v4:
 		if ((mpcb->mptcp_ver =3D=3D MPTCP_VERSION_0 &&
 		     mpadd->len =3D=3D MPTCP_SUB_LEN_ADD_ADDR4 + 2) ||
@@ -2020,7 +2121,8 @@ skip_hmac_v6:
 	}
 =

 	if (mpcb->pm_ops->add_raddr)
-		mpcb->pm_ops->add_raddr(mpcb, &addr, family, port, mpadd->addr_id);
+		mpcb->pm_ops->add_raddr(mpcb, &addr, family,
+					port, mpadd->addr_id);
 =

 	MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_ADDADDRRX);
 }
@@ -2168,6 +2270,8 @@ bool mptcp_handle_options(struct sock *sk, const stru=
ct tcphdr *th,
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	struct mptcp_options_received *mopt =3D &tp->mptcp->rx_opt;
 =

+	BUG_ON(sk =3D=3D mptcp_meta_sk(sk));
+
 	if (tp->mpcb->infinite_mapping_rcv || tp->mpcb->infinite_mapping_snd)
 		return false;
 =

@@ -2182,7 +2286,8 @@ bool mptcp_handle_options(struct sock *sk, const stru=
ct tcphdr *th,
 =

 	/* RFC 6824, Section 3.3:
 	 * If a checksum is not present when its use has been negotiated, the
-	 * receiver MUST close the subflow with a RST as it is considered broken.
+	 * receiver MUST close the subflow with a RST as it is considered
+	 * broken.
 	 */
 	if (mptcp_is_data_seq(skb) && tp->mpcb->dss_csum &&
 	    !(TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_DSS_CSUM)) {
@@ -2218,8 +2323,10 @@ bool mptcp_handle_options(struct sock *sk, const str=
uct tcphdr *th,
 			tp->mptcp->rcv_low_prio =3D mopt->low_prio;
 		} else {
 			struct sock *sk_it;
+
 			mptcp_for_each_sk(tp->mpcb, sk_it) {
-				struct mptcp_tcp_sock *mptcp =3D tcp_sk(sk_it)->mptcp;
+				struct mptcp_tcp_sock *mptcp =3D
+							tcp_sk(sk_it)->mptcp;
 				if (mptcp->rem_id =3D=3D mopt->prio_addr_id)
 					mptcp->rcv_low_prio =3D mopt->low_prio;
 			}
@@ -2270,8 +2377,9 @@ static void mptcp_rcv_synsent_fastopen(struct sock *m=
eta_sk)
 			 * cloned. It is not the case here (see
 			 * tcp_send_syn_data).
 			 */
-			BUG_ON(tcp_trim_head(meta_sk, skb, master_tp->snd_una -
-					     TCP_SKB_CB(skb)->seq));
+			BUG_ON(meta_tp->op_ops->trim_head(meta_sk, skb,
+							  master_tp->snd_una -
+							  TCP_SKB_CB(skb)->seq));
 		}
 =

 		TCP_SKB_CB(skb)->seq +=3D new_mapping;
@@ -2305,12 +2413,17 @@ static void mptcp_rcv_synsent_fastopen(struct sock =
*meta_sk)
  *	    2 - we want to discard the received syn/ack
  *	    0 - everything is fine - continue
  */
-int mptcp_rcv_synsent_state_process(struct sock *sk, struct sock **skptr,
-				    const struct sk_buff *skb,
-				    const struct mptcp_options_received *mopt)
+static int __mptcp_rcv_synsent_state_process(struct sock *sk,
+					     struct sock **skptr,
+					     struct sk_buff *skb)
 {
 	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct mptcp_options_received mopt;
 =

+	mptcp_init_mp_opt(&mopt);
+	tcp_parse_mptcp_options(skb, &mopt);
+
+	/* This is the case of a join ? */
 	if (mptcp(tp)) {
 		u8 hash_mac_check[20];
 		struct mptcp_cb *mpcb =3D tp->mpcb;
@@ -2318,10 +2431,10 @@ int mptcp_rcv_synsent_state_process(struct sock *sk=
, struct sock **skptr,
 		mptcp_hmac_sha1((u8 *)&mpcb->mptcp_rem_key,
 				(u8 *)&mpcb->mptcp_loc_key,
 				(u32 *)hash_mac_check, 2,
-				4, (u8 *)&tp->mptcp->rx_opt.mptcp_recv_nonce,
+				4, (u8 *)&mopt.mptcp_recv_nonce,
 				4, (u8 *)&tp->mptcp->mptcp_loc_nonce);
 		if (memcmp(hash_mac_check,
-			   (char *)&tp->mptcp->rx_opt.mptcp_recv_tmac, 8)) {
+			   (char *)&mopt.mptcp_recv_tmac, 8)) {
 			MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_JOINSYNACKMAC);
 			mptcp_sub_force_close(sk);
 			return 1;
@@ -2331,76 +2444,148 @@ int mptcp_rcv_synsent_state_process(struct sock *s=
k, struct sock **skptr,
 		 * until the 4th ack arrives.
 		 */
 		tp->mptcp->pre_established =3D 1;
-		tp->mptcp->rcv_low_prio =3D tp->mptcp->rx_opt.low_prio;
+		tp->mptcp->rcv_low_prio =3D mopt.low_prio;
 =

 		mptcp_hmac_sha1((u8 *)&mpcb->mptcp_loc_key,
 				(u8 *)&mpcb->mptcp_rem_key,
 				(u32 *)&tp->mptcp->sender_mac[0], 2,
 				4, (u8 *)&tp->mptcp->mptcp_loc_nonce,
-				4, (u8 *)&tp->mptcp->rx_opt.mptcp_recv_nonce);
+				4, (u8 *)&mopt.mptcp_recv_nonce);
 =

 		MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_JOINSYNACKRX);
-	} else if (mopt->saw_mpc) {
-		struct sock *meta_sk =3D sk;
+	} else {
+		/* Active connect sent on meta_socket */
+		if (mopt.saw_mpc) {
+			/* Peer supports MPTCP, create master socket */
+			struct sock *meta_sk =3D sk;
+
+			MPTCP_INC_STATS_BH(sock_net(sk),
+					   MPTCP_MIB_MPCAPABLEACTIVEACK);
+			if (mopt.mptcp_ver > tcp_sk(sk)->mptcp_ver)
+				/* TODO Consider adding a new
+				 * MPTCP_INC_STATS entry
+				 */
+				goto fallback;
+
+			if (mptcp_create_master_sk(sk, mopt.mptcp_sender_key,
+						   mopt.mptcp_ver,
+						   ntohs(tcp_hdr(skb)->window)))
+				return 2;
+
+			sk =3D tcp_sk(sk)->mpcb->master_sk;
+			tp =3D tcp_sk(sk);
+
+			sk->sk_bound_dev_if =3D skb->skb_iif;
+
+			/* If fastopen was used data might be in the send queue.
+			 * We need to update their sequence number to
+			 * MPTCP-level seqno.
+			 * Note that it can happen in rare cases that
+			 * fastopen_req is NULL and syn_data is 0 but fastopen
+			 * indeed occurred and data has been queued in the
+			 * write queue (but not sent).
+			 * Example of such rare cases: connect is non-blocking
+			 * and TFO is configured to work without cookies.
+			 */
+			if (!skb_queue_empty(&meta_sk->sk_write_queue))
+				mptcp_rcv_synsent_fastopen(meta_sk);
 =

-		MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVEACK);
-		if (mopt->mptcp_ver > tcp_sk(sk)->mptcp_ver)
-			/* TODO Consider adding new MPTCP_INC_STATS entry */
-			goto fallback;
+			/* -1, because the SYN consumed 1 byte. In case of TFO,
+			 * we start the subflow-sequence number as if the data
+			 * of the SYN is not part of any mapping.
+			 */
+			tp->mptcp->snt_isn =3D tp->snd_una;
+			tp->mpcb->dss_csum =3D mopt.dss_csum;
+			if (tp->mpcb->dss_csum)
+				MPTCP_INC_STATS_BH(sock_net(sk),
+						   MPTCP_MIB_CSUMENABLED);
 =

-		if (mptcp_create_master_sk(sk, mopt->mptcp_sender_key,
-					   mopt->mptcp_ver,
-					   ntohs(tcp_hdr(skb)->window)))
-			return 2;
+			tp->mptcp->include_mpc =3D 1;
 =

-		sk =3D tcp_sk(sk)->mpcb->master_sk;
-		*skptr =3D sk;
-		tp =3D tcp_sk(sk);
+			/* Ensure that fastopen is handled at the meta-level. */
+			tp->fastopen_req =3D NULL;
 =

-		sk->sk_bound_dev_if =3D skb->skb_iif;
+			sk_set_socket(sk, mptcp_meta_sk(sk)->sk_socket);
+			sk->sk_wq =3D mptcp_meta_sk(sk)->sk_wq;
 =

-		/* If fastopen was used data might be in the send queue. We
-		 * need to update their sequence number to MPTCP-level seqno.
-		 * Note that it can happen in rare cases that fastopen_req is
-		 * NULL and syn_data is 0 but fastopen indeed occurred and
-		 * data has been queued in the write queue (but not sent).
-		 * Example of such rare cases: connect is non-blocking and
-		 * TFO is configured to work without cookies.
-		 */
-		if (!skb_queue_empty(&meta_sk->sk_write_queue))
-			mptcp_rcv_synsent_fastopen(meta_sk);
+			 /* hold in sk_clone_lock due to initialization to 2 */
+			sock_put(sk);
+		} else {
+			/* Other side did not reply with an MPCTP option
+			 * fallback to regular tcp
+			 */
+			MPTCP_INC_STATS_BH(sock_net(sk),
+					   MPTCP_MIB_MPCAPABLEACTIVEFALLBACK);
+fallback:
+			tp->request_mptcp =3D 0;
 =

-		/* -1, because the SYN consumed 1 byte. In case of TFO, we
-		 * start the subflow-sequence number as if the data of the SYN
-		 * is not part of any mapping.
-		 */
-		tp->mptcp->snt_isn =3D tp->snd_una - 1;
-		tp->mpcb->dss_csum =3D mopt->dss_csum;
-		if (tp->mpcb->dss_csum)
-			MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_CSUMENABLED);
+			if (tp->inside_tk_table)
+				mptcp_hash_remove(tp);
+		}
+	}
 =

-		tp->mptcp->include_mpc =3D 1;
+	if (mptcp(tp))
+		tp->mptcp->rcv_isn =3D TCP_SKB_CB(skb)->seq;
 =

-		/* Ensure that fastopen is handled at the meta-level. */
-		tp->fastopen_req =3D NULL;
+	*skptr =3D sk;
+	return 0;
+}
 =

-		sk_set_socket(sk, mptcp_meta_sk(sk)->sk_socket);
-		sk->sk_wq =3D mptcp_meta_sk(sk)->sk_wq;
+int mptcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
+				    const struct tcphdr *th)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct tcp_sock *new_tp =3D tcp_sk(sk);
+	struct sock *new_sk;
+	struct inet_connection_sock *icsk;
+	int queued =3D 0;
+	int ret =3D 0;
+
+	new_sk =3D sk;
+	if (th->ack) {
+		ret =3D __mptcp_rcv_synsent_state_process(sk, &new_sk, skb);
+		if (ret =3D=3D 1 || ret =3D=3D 2) {
+			tcp_drop(sk, skb);
+			return 0;
+		}
+	}
 =

-		 /* hold in sk_clone_lock due to initialization to 2 */
-		sock_put(sk);
-	} else {
-		MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVEFALLBACK);
-fallback:
-		tp->request_mptcp =3D 0;
+	new_tp =3D tcp_sk(new_sk);
+	icsk =3D inet_csk(new_sk);
+	if (mptcp(new_tp) && !is_master_tp(new_tp))
+		sk_reset_timer(new_sk, &tp->mptcp->mptcp_ack_timer,
+			       jiffies + icsk->icsk_rto);
+	queued =3D tcp_rcv_synsent_state_process(new_sk, skb, th);
+
+	if (mptcp(new_tp)) {
+		new_tp->tcp_header_len +=3D MPTCP_SUB_LEN_DSM_ALIGN;
+		new_tp->advmss -=3D MPTCP_SUB_LEN_DSM_ALIGN;
+	}
 =

-		if (tp->inside_tk_table)
-			mptcp_hash_remove(tp);
+	if (is_meta_sk(sk)) {
+		sk =3D tcp_sk(sk)->mpcb->master_sk;
+		tp =3D tcp_sk(sk);
+		/* Need to call it here, because it will announce new
+		 * addresses, which can only be done after the third ack
+		 * of the 3-way handshake.
+		 */
+		mptcp_update_metasocket(sk, tp->meta_sk);
 	}
 =

+	if (queued >=3D 0)
+		return queued;
+
+	/* Do step6 onward by hand. */
+	tp->op_ops->urg(sk, skb, th);
+	__kfree_skb(skb);
+
 	if (mptcp(tp))
-		tp->mptcp->rcv_isn =3D TCP_SKB_CB(skb)->seq;
+		mptcp_push_pending_frames(mptcp_meta_sk(sk));
+	else
+		tcp_data_snd_check(sk);
 =

+	if (mptcp(tp) && is_master_tp(tp))
+		bh_unlock_sock(sk);
 	return 0;
 }
 =

@@ -2450,7 +2635,8 @@ bool mptcp_should_expand_sndbuf(const struct sock *sk)
 			cnt_backups++;
 =

 		if (tcp_packets_in_flight(tp_it) < tp_it->snd_cwnd) {
-			if (tp_it->mptcp->rcv_low_prio || tp_it->mptcp->low_prio) {
+			if (tp_it->mptcp->rcv_low_prio ||
+			    tp_it->mptcp->low_prio) {
 				backup_available =3D 1;
 				continue;
 			}
@@ -2469,13 +2655,14 @@ void mptcp_init_buffer_space(struct sock *sk)
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	struct sock *meta_sk =3D mptcp_meta_sk(sk);
 	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
+	struct net *net =3D sock_net(meta_sk);
 	int space;
 =

 	tcp_init_buffer_space(sk);
 =

 	if (is_master_tp(tp)) {
 		meta_tp->rcvq_space.space =3D meta_tp->rcv_wnd;
-		meta_tp->rcvq_space.time =3D tcp_time_stamp;
+		meta_tp->rcvq_space.time =3D tcp_jiffies32;
 		meta_tp->rcvq_space.seq =3D meta_tp->copied_seq;
 =

 		/* If there is only one subflow, we just use regular TCP
@@ -2497,7 +2684,8 @@ void mptcp_init_buffer_space(struct sock *sk)
 	 * addition, to give some space to allow traffic on the new subflow.
 	 * Autotuning will increase it further later on.
 	 */
-	space =3D min(meta_sk->sk_rcvbuf + sk->sk_rcvbuf, sysctl_tcp_rmem[2]);
+	space =3D min(meta_sk->sk_rcvbuf + sk->sk_rcvbuf,
+		    net->ipv4.sysctl_tcp_rmem[2]);
 	if (space > meta_sk->sk_rcvbuf) {
 		meta_tp->window_clamp +=3D tp->window_clamp;
 		meta_tp->rcv_ssthresh +=3D tp->rcv_ssthresh;
@@ -2512,7 +2700,8 @@ snd_buf:
 	 * addition, to give some space to allow traffic on the new subflow.
 	 * Autotuning will increase it further later on.
 	 */
-	space =3D min(meta_sk->sk_sndbuf + sk->sk_sndbuf, sysctl_tcp_wmem[2]);
+	space =3D min(meta_sk->sk_sndbuf + sk->sk_sndbuf,
+		    net->ipv4.sysctl_tcp_wmem[2]);
 	if (space > meta_sk->sk_sndbuf) {
 		meta_sk->sk_sndbuf =3D space;
 		meta_sk->sk_write_space(meta_sk);
@@ -2524,3 +2713,258 @@ void mptcp_tcp_set_rto(struct sock *sk)
 	tcp_set_rto(sk);
 	mptcp_set_rto(sk);
 }
+
+void mptcp_sndbuf_expand(struct sock *sk)
+{
+	const struct tcp_sock *tp =3D tcp_sk(sk);
+	int old_sndbuf =3D sk->sk_sndbuf;
+	u32 nr_segs;
+
+	if (!mptcp(tp))
+		return tcp_default_op_ops->sndbuf_expand(sk);
+
+	nr_segs =3D mptcp_check_snd_buf(tp);
+	tcp_sndbuf_expand_impl(sk, nr_segs);
+	/* The subflow sndbuf has changes, reflect
+	 * this in the aggregate buffer.
+	 */
+	if (old_sndbuf !=3D sk->sk_sndbuf)
+		mptcp_update_sndbuf(tp);
+}
+
+struct sk_buff *mptcp_shift_skb_data(struct sock *sk,
+				     struct sk_buff *skb,
+				     struct tcp_sacktag_state *state,
+				     u32 start_seq, u32 end_seq,
+				     bool dup_sack)
+{
+	/* For MPTCP we cannot shift skb-data and remove one skb from the
+	 * send-queue, because this will make us loose the DSS-option (which
+	 * is stored in TCP_SKB_CB(skb)->dss) of the skb we are removing.
+	 */
+	__NET_INC_STATS(sock_net(sk), LINUX_MIB_SACKSHIFTFALLBACK);
+
+	return NULL;
+}
+
+void mptcp_grow_window(struct sock *sk, const struct sk_buff *skb)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct sock *meta_sk =3D mptcp(tp) ? mptcp_meta_sk(sk) : sk;
+
+	tcp_grow_window(meta_sk, skb);
+}
+
+bool mptcp_try_coalesce(struct sock *sk,
+			struct sk_buff *to,
+			struct sk_buff *from,
+			bool *fragstolen)
+{
+	if (mptcp(tcp_sk(sk)) && !is_meta_sk(sk))
+		return false;
+	return tcp_try_coalesce(sk, to, from, fragstolen);
+}
+
+int mptcp_try_rmem_schedule(struct sock *sk, struct sk_buff *skb,
+			    unsigned int size)
+{
+	struct sock *meta_sk =3D mptcp_meta_sk(sk);
+
+	return tcp_try_rmem_schedule(meta_sk, skb, size);
+}
+
+struct sk_buff *mptcp_collapse_one(struct sock *sk, struct sk_buff *skb,
+				   struct sk_buff_head *list,
+				   struct rb_root *root)
+{
+#ifdef RCHK
+	if (mptcp(tcp_sk(sk)))
+		mptcp_remove_shortcuts(tcp_sk(sk)->mpcb, skb);
+#endif
+	return tcp_collapse_one(sk, skb, list, root);
+}
+
+int mptcp_trim_head(struct sock *sk, struct sk_buff *skb, u32 len)
+{
+	int ret;
+
+	ret =3D tcp_trim_head(sk, skb, len);
+	if (ret =3D=3D 0)
+		TCP_SKB_CB(skb)->mptcp_data_seq +=3D len;
+	return ret;
+}
+
+void mptcp_urg(struct sock *sk, struct sk_buff *skb,
+	       const struct tcphdr *th)
+{
+	const struct tcp_sock *tp =3D tcp_sk(sk);
+
+	/* MPTCP does not support urgent data just yet */
+	if (!mptcp(tp))
+		tcp_default_op_ops->urg(sk, skb, th);
+}
+
+void mptcp_rcv_ack_only(struct sock *sk, struct sk_buff *skb)
+{
+	mptcp_process_options_ack(sk, skb);
+}
+
+bool mptcp_rcv_fastopen_synack(struct sock *sk, struct sk_buff *synack,
+			       struct tcp_fastopen_cookie *cookie)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	bool retrans =3D mptcp(tp) ? false : true;
+
+	/* In mptcp case, we do not rely on "retransmit", but instead on
+	 * "transmit", because if fastopen data is not acked, the retransmission
+	 * becomes the first MPTCP data (see mptcp_rcv_synsent_fastopen).
+	 */
+	return tcp_rcv_fastopen_synack_impl(sk, synack, cookie, retrans);
+}
+
+int mptcp_sendpage_locked(struct sock *sk, struct page *page, int offset,
+			  size_t size, int flags)
+{
+	struct sock *sk_it =3D sk;
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	long timeo =3D sock_sndtimeo(sk, flags & MSG_DONTWAIT);
+	int err;
+
+	if (!mptcp(tp))
+		return(tcp_sendpage_locked(sk, page, offset, size, flags));
+
+	if (((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) &&
+	    !tcp_passive_fastopen(tp->mpcb->master_sk ?
+				  tp->mpcb->master_sk : sk)) {
+		err =3D sk_stream_wait_connect(sk, &timeo);
+		if (err !=3D 0)
+			goto out_err;
+	}
+
+	if (sk->sk_err || (sk->sk_shutdown & SEND_SHUTDOWN))
+		goto out_err;
+
+	if (!mptcp_can_sendpage(sk)) {
+		ssize_t ret;
+
+		release_sock(sk);
+		ret =3D sock_no_sendpage(sk->sk_socket, page, offset,
+				       size, flags);
+		lock_sock(sk);
+		return ret;
+	}
+
+	mptcp_for_each_sk(tp->mpcb, sk_it)
+		sock_rps_record_flow(sk_it);
+
+	return tcp_sendpages_xmit(sk, page, offset, size, flags);
+out_err:
+	/* make sure we wake any epoll edge trigger waiter */
+	if (unlikely(skb_queue_len(&sk->sk_write_queue) =3D=3D 0 &&
+		     err =3D=3D -EAGAIN)) {
+		sk->sk_write_space(sk);
+		tcp_chrono_stop(sk, TCP_CHRONO_SNDBUF_LIMITED);
+	}
+	return sk_stream_error(sk, flags, err);
+}
+
+struct request_sock *mptcp_cookie_req_alloc(struct sock *sk,
+					    struct sk_buff *skb,
+					    struct tcp_options_received *tcp_opts,
+					    __u32 cookie, int mss)
+{
+	struct request_sock *req;
+	struct mptcp_options_received mopt;
+
+	mptcp_init_mp_opt(&mopt);
+	tcp_parse_mptcp_options(skb, &mopt);
+
+	if (!mopt.saw_mpc)
+		return tcp_cookie_req_alloc(sk, skb, tcp_opts, cookie, mss);
+
+	if (sk->sk_family =3D=3D AF_INET)
+		req =3D inet_reqsk_alloc(&mptcp_request_sock_ops, sk, false);
+#if IS_ENABLED(CONFIG_IPV6)
+	else
+		req =3D inet_reqsk_alloc(&mptcp6_request_sock_ops, sk, false);
+#endif
+	if (req) {
+		tcp_cookie_req_init(sk, skb, req, tcp_opts, cookie, mss);
+		mptcp_cookies_reqsk_init(req, &mopt, skb);
+	}
+
+	return req;
+}
+EXPORT_SYMBOL(mptcp_cookie_req_alloc);
+
+struct sock *mptcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
+				   struct request_sock *req,
+				   struct dst_entry *dst, u32 tsoff)
+{
+	struct sock *child;
+	int ret;
+	bool own_req;
+
+	child =3D tcp_v4_syn_recv_sock(sk, skb, req, dst, NULL, &own_req);
+	if (!child)
+		goto listen_overflow;
+
+	ret =3D mptcp_check_req_master(sk, child, req, 0);
+	if (ret < 0)
+		return NULL;
+
+	if (!ret)
+		return tcp_sk(child)->mpcb->master_sk;
+listen_overflow:
+
+	if (child) {
+		refcount_set(&req->rsk_refcnt, 1);
+		tcp_sk(child)->tsoffset =3D tsoff;
+		sock_rps_save_rxhash(child, skb);
+		inet_csk_reqsk_queue_add(sk, req, child);
+	} else {
+		reqsk_free(req);
+	}
+	return child;
+}
+EXPORT_SYMBOL(mptcp_get_cookie_sock);
+
+int mptcp_join_ack(struct request_sock *req, struct sk_buff *skb)
+{
+	struct sock *meta_sk =3D req->rsk_listener;
+
+	bh_lock_sock_nested(meta_sk);
+	sock_hold(meta_sk);
+	if (sock_owned_by_user(meta_sk)) {
+		skb->sk =3D req_to_sk(req);
+		if (unlikely(sk_add_backlog(meta_sk, skb,
+					    meta_sk->sk_rcvbuf +
+					    meta_sk->sk_sndbuf))) {
+			goto discard;
+		}
+	} else {
+		__mptcp_join_ack(req, skb);
+	}
+done:
+	sock_put(meta_sk);
+	bh_unlock_sock(meta_sk);
+	return 0;
+discard:
+	sk_drops_add(meta_sk, skb);
+	reqsk_put(req);
+	kfree_skb(skb);
+	goto done;
+}
+EXPORT_SYMBOL(mptcp_join_ack);
+
+/* Shoaib: With the recent changes this is most likely not needed
+ */
+int mptcp_do_rcv(const struct sock *meta_sk, struct sk_buff *skb)
+{
+	const struct tcphdr *th =3D tcp_hdr(skb);
+
+	if (th->syn && !th->ack)
+		return mptcp_lookup_join(skb, NULL);
+	return 0;
+}
+EXPORT_SYMBOL(mptcp_do_rcv);
diff --git a/net/mptcp/mptcp_ipv4.c b/net/mptcp/mptcp_ipv4.c
index a147b20..a0cded5 100644
--- a/net/mptcp/mptcp_ipv4.c
+++ b/net/mptcp/mptcp_ipv4.c
@@ -28,6 +28,7 @@
  */
 =

 #include <linux/export.h>
+#include <linux/siphash.h>
 #include <linux/ip.h>
 #include <linux/list.h>
 #include <linux/skbuff.h>
@@ -40,78 +41,35 @@
 #include <net/mptcp_v4.h>
 #include <net/request_sock.h>
 #include <net/tcp.h>
+#include <net/secure_seq.h>
 =

-u32 mptcp_v4_get_nonce(__be32 saddr, __be32 daddr, __be16 sport, __be16 dp=
ort)
+static void mptcp_v4_init_req(struct request_sock *req,
+			      const struct sock *sk_listener,
+			      struct sk_buff *skb)
 {
-	u32 hash[MD5_DIGEST_WORDS];
+	struct mptcp_options_received mopt;
 =

-	hash[0] =3D (__force u32)saddr;
-	hash[1] =3D (__force u32)daddr;
-	hash[2] =3D ((__force u16)sport << 16) + (__force u16)dport;
-	hash[3] =3D mptcp_seed++;
+	tcp_request_sock_ipv4_ops.init_req(req, sk_listener, skb);
 =

-	md5_transform(hash, mptcp_secret);
-
-	return hash[0];
-}
-
-u64 mptcp_v4_get_key(__be32 saddr, __be32 daddr, __be16 sport, __be16 dpor=
t,
-		     u32 seed)
-{
-	u32 hash[MD5_DIGEST_WORDS];
-
-	hash[0] =3D (__force u32)saddr;
-	hash[1] =3D (__force u32)daddr;
-	hash[2] =3D ((__force u16)sport << 16) + (__force u16)dport;
-	hash[3] =3D seed;
-
-	md5_transform(hash, mptcp_secret);
-
-	return *((u64 *)hash);
-}
-
-
-static void mptcp_v4_reqsk_destructor(struct request_sock *req)
-{
-	mptcp_reqsk_destructor(req);
-
-	tcp_v4_reqsk_destructor(req);
-}
-
-static int mptcp_v4_init_req(struct request_sock *req, struct sock *sk,
-			     struct sk_buff *skb, bool want_cookie)
-{
-	tcp_request_sock_ipv4_ops.init_req(req, sk, skb, want_cookie);
-
-	mptcp_rsk(req)->hash_entry.pprev =3D NULL;
-	mptcp_rsk(req)->is_sub =3D 0;
 	inet_rsk(req)->mptcp_rqsk =3D 1;
-
-	/* In case of SYN-cookies, we wait for the isn to be generated - it is
-	 * input to the key-generation.
+	mptcp_init_mp_opt(&mopt);
+	tcp_parse_mptcp_options(skb, &mopt);
+	/* In case of SYN-cookies, the entry in the hash will be deleted
+	 * when the request socket is freed.
 	 */
-	if (!want_cookie)
-		mptcp_reqsk_init(req, sk, skb, false);
-
-	return 0;
+	mptcp_reqsk_init(req, sk_listener, skb, &mopt);
 }
 =

 #ifdef CONFIG_SYN_COOKIES
-static u32 mptcp_v4_cookie_init_seq(struct request_sock *req, struct sock =
*sk,
-				    const struct sk_buff *skb, __u16 *mssp)
+static u32 mptcp_v4_cookie_init_seq(const struct sk_buff *skb, __u16 *mssp)
 {
-	__u32 isn =3D cookie_v4_init_sequence(req, sk, skb, mssp);
-
-	tcp_rsk(req)->snt_isn =3D isn;
-
-	mptcp_reqsk_init(req, sk, skb, true);
-
-	return isn;
+	return cookie_v4_init_sequence(skb, mssp);
 }
 #endif
 =

-static int mptcp_v4_join_init_req(struct request_sock *req, struct sock *s=
k,
-				  struct sk_buff *skb, bool want_cookie)
+static void mptcp_v4_join_init_req(struct request_sock *req,
+				   const struct sock *sk,
+				   struct sk_buff *skb)
 {
 	struct mptcp_request_sock *mtreq =3D mptcp_rsk(req);
 	struct mptcp_cb *mpcb =3D tcp_sk(sk)->mpcb;
@@ -126,22 +84,19 @@ static int mptcp_v4_join_init_req(struct request_sock =
*req, struct sock *sk,
 	 */
 	mtreq->hash_entry.pprev =3D NULL;
 =

-	tcp_request_sock_ipv4_ops.init_req(req, sk, skb, want_cookie);
+	tcp_request_sock_ipv4_ops.init_req(req, sk, skb);
 =

 	mtreq->mptcp_loc_nonce =3D mptcp_v4_get_nonce(ip_hdr(skb)->saddr,
 						    ip_hdr(skb)->daddr,
 						    tcp_hdr(skb)->source,
 						    tcp_hdr(skb)->dest);
 	addr.ip =3D inet_rsk(req)->ir_loc_addr;
-	loc_id =3D mpcb->pm_ops->get_local_id(AF_INET, &addr, sock_net(sk), &low_=
prio);
-	if (loc_id =3D=3D -1)
-		return -1;
-	mtreq->loc_id =3D loc_id;
+	loc_id =3D mpcb->pm_ops->get_local_id(AF_INET, &addr,
+					    sock_net(sk), &low_prio);
+	mtreq->loc_id =3D loc_id =3D=3D -1 ? 0 : loc_id;
 	mtreq->low_prio =3D low_prio;
 =

 	mptcp_join_reqsk_init(mpcb, req, skb);
-
-	return 0;
 }
 =

 /* Similar to tcp_request_sock_ops */
@@ -150,27 +105,11 @@ struct request_sock_ops mptcp_request_sock_ops __read=
_mostly =3D {
 	.obj_size	=3D	sizeof(struct mptcp_request_sock),
 	.rtx_syn_ack	=3D	tcp_rtx_synack,
 	.send_ack	=3D	tcp_v4_reqsk_send_ack,
-	.destructor	=3D	mptcp_v4_reqsk_destructor,
+	.destructor	=3D	tcp_v4_reqsk_destructor,
 	.send_reset	=3D	tcp_v4_send_reset,
 	.syn_ack_timeout =3D	tcp_syn_ack_timeout,
 };
 =

-static void mptcp_v4_reqsk_queue_hash_add(struct sock *meta_sk,
-					  struct request_sock *req,
-					  const unsigned long timeout)
-{
-	const u32 h1 =3D inet_synq_hash(inet_rsk(req)->ir_rmt_addr,
-				     inet_rsk(req)->ir_rmt_port,
-				     0, MPTCP_HASH_SIZE);
-	inet_csk_reqsk_queue_hash_add(meta_sk, req, timeout);
-
-	rcu_read_lock();
-	spin_lock(&mptcp_reqsk_hlock);
-	hlist_nulls_add_head_rcu(&mptcp_rsk(req)->hash_entry, &mptcp_reqsk_htb[h1=
]);
-	spin_unlock(&mptcp_reqsk_hlock);
-	rcu_read_unlock();
-}
-
 /* Similar to tcp_v4_conn_request */
 static int mptcp_v4_join_request(struct sock *meta_sk, struct sk_buff *skb)
 {
@@ -180,45 +119,12 @@ static int mptcp_v4_join_request(struct sock *meta_sk=
, struct sk_buff *skb)
 }
 =

 /* We only process join requests here. (either the SYN or the final ACK) */
-int mptcp_v4_do_rcv(struct sock *meta_sk, struct sk_buff *skb)
+int mptcp_process_join_req(struct sock *meta_sk, struct sk_buff *skb)
 {
 	const struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
 	struct sock *child, *rsk =3D NULL;
 	int ret;
 =

-	if (!(TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_JOIN)) {
-		struct tcphdr *th =3D tcp_hdr(skb);
-		const struct iphdr *iph =3D ip_hdr(skb);
-		struct sock *sk;
-
-		sk =3D inet_lookup_established(sock_net(meta_sk), &tcp_hashinfo,
-					     iph->saddr, th->source, iph->daddr,
-					     th->dest, inet_iif(skb));
-
-		if (!sk) {
-			kfree_skb(skb);
-			return 0;
-		}
-		if (is_meta_sk(sk)) {
-			WARN("%s Did not find a sub-sk - did found the meta!\n", __func__);
-			kfree_skb(skb);
-			sock_put(sk);
-			return 0;
-		}
-
-		if (sk->sk_state =3D=3D TCP_TIME_WAIT) {
-			inet_twsk_put(inet_twsk(sk));
-			kfree_skb(skb);
-			return 0;
-		}
-
-		ret =3D tcp_v4_do_rcv(sk, skb);
-		sock_put(sk);
-
-		return ret;
-	}
-	TCP_SKB_CB(skb)->mptcp_flags =3D 0;
-
 	/* Has been removed from the tk-table. Thus, no new subflows.
 	 *
 	 * Check for close-state is necessary, because we may have been closed
@@ -226,11 +132,15 @@ int mptcp_v4_do_rcv(struct sock *meta_sk, struct sk_b=
uff *skb)
 	 *
 	 * When falling back, no new subflows are allowed either.
 	 */
-	if (meta_sk->sk_state =3D=3D TCP_CLOSE || !tcp_sk(meta_sk)->inside_tk_tab=
le ||
+	if (meta_sk->sk_state =3D=3D TCP_CLOSE ||
+	    !tcp_sk(meta_sk)->inside_tk_table ||
 	    mpcb->infinite_mapping_rcv || mpcb->send_infinite_mapping)
 		goto reset_and_discard;
 =

-	child =3D tcp_v4_hnd_req(meta_sk, skb);
+	if (meta_sk->sk_family =3D=3D AF_INET)
+		child =3D tcp_v4_cookie_check(meta_sk, skb);
+	else
+		child =3D tcp_v6_cookie_check(meta_sk, skb);
 =

 	if (!child)
 		goto discard;
@@ -241,7 +151,7 @@ int mptcp_v4_do_rcv(struct sock *meta_sk, struct sk_buf=
f *skb)
 		 * already the meta-sk-lock and are sure that it is not owned
 		 * by the user.
 		 */
-		ret =3D tcp_rcv_state_process(child, skb, tcp_hdr(skb), skb->len);
+		ret =3D tcp_rcv_state_process(child, skb);
 		bh_unlock_sock(child);
 		sock_put(child);
 		if (ret) {
@@ -250,7 +160,10 @@ int mptcp_v4_do_rcv(struct sock *meta_sk, struct sk_bu=
ff *skb)
 		}
 	} else {
 		if (tcp_hdr(skb)->syn) {
-			mptcp_v4_join_request(meta_sk, skb);
+			if (meta_sk->sk_family =3D=3D AF_INET)
+				mptcp_v4_join_request(meta_sk, skb);
+			else
+				mptcp_v6_join_request(meta_sk, skb);
 			goto discard;
 		}
 		goto reset_and_discard;
@@ -258,74 +171,12 @@ int mptcp_v4_do_rcv(struct sock *meta_sk, struct sk_b=
uff *skb)
 	return 0;
 =

 reset_and_discard:
-	if (reqsk_queue_len(&inet_csk(meta_sk)->icsk_accept_queue)) {
-		const struct tcphdr *th =3D tcp_hdr(skb);
-		const struct iphdr *iph =3D ip_hdr(skb);
-		struct request_sock *req;
-		/* If we end up here, it means we should not have matched on the
-		 * request-socket. But, because the request-sock queue is only
-		 * destroyed in mptcp_close, the socket may actually already be
-		 * in close-state (e.g., through shutdown()) while still having
-		 * pending request sockets.
-		 */
-		req =3D inet_csk_search_req(meta_sk, th->source, iph->saddr, iph->daddr);
-
-		if (req) {
-			inet_csk_reqsk_queue_drop(meta_sk, req);
-			reqsk_put(req);
-		}
-	}
-
 	tcp_v4_send_reset(rsk, skb);
 discard:
 	kfree_skb(skb);
 	return 0;
 }
 =

-/* After this, the ref count of the meta_sk associated with the request_so=
ck
- * is incremented. Thus it is the responsibility of the caller
- * to call sock_put() when the reference is not needed anymore.
- */
-struct sock *mptcp_v4_search_req(const __be16 rport, const __be32 raddr,
-				 const __be32 laddr, const struct net *net)
-{
-	const struct mptcp_request_sock *mtreq;
-	struct sock *meta_sk =3D NULL;
-	const struct hlist_nulls_node *node;
-	const u32 hash =3D inet_synq_hash(raddr, rport, 0, MPTCP_HASH_SIZE);
-
-	rcu_read_lock();
-begin:
-	hlist_nulls_for_each_entry_rcu(mtreq, node, &mptcp_reqsk_htb[hash],
-				       hash_entry) {
-		struct inet_request_sock *ireq =3D inet_rsk(rev_mptcp_rsk(mtreq));
-		meta_sk =3D mtreq->mptcp_mpcb->meta_sk;
-
-		if (ireq->ir_rmt_port =3D=3D rport &&
-		    ireq->ir_rmt_addr =3D=3D raddr &&
-		    ireq->ir_loc_addr =3D=3D laddr &&
-		    rev_mptcp_rsk(mtreq)->rsk_ops->family =3D=3D AF_INET &&
-		    net_eq(net, sock_net(meta_sk)))
-			goto found;
-		meta_sk =3D NULL;
-	}
-	/* A request-socket is destroyed by RCU. So, it might have been recycled
-	 * and put into another hash-table list. So, after the lookup we may
-	 * end up in a different list. So, we may need to restart.
-	 *
-	 * See also the comment in __inet_lookup_established.
-	 */
-	if (get_nulls_value(node) !=3D hash + MPTCP_REQSK_NULLS_BASE)
-		goto begin;
-
-found:
-	if (meta_sk && unlikely(!atomic_inc_not_zero(&meta_sk->sk_refcnt)))
-		meta_sk =3D NULL;
-	rcu_read_unlock();
-
-	return meta_sk;
-}
-
 /* Create a new IPv4 subflow.
  *
  * We are in user-context and meta-sock-lock is hold.
@@ -355,7 +206,8 @@ int mptcp_init4_subsockets(struct sock *meta_sk, const =
struct mptcp_loc4 *loc,
 	tp =3D tcp_sk(sk);
 =

 	/* All subsockets need the MPTCP-lock-class */
-	lockdep_set_class_and_name(&(sk)->sk_lock.slock, &meta_slock_key, meta_sl=
ock_key_name);
+	lockdep_set_class_and_name(&(sk)->sk_lock.slock,
+				   &meta_slock_key, meta_slock_key_name);
 	lockdep_init_map(&(sk)->sk_lock.dep_map, meta_key_name, &meta_key, 0);
 =

 	if (mptcp_add_sock(meta_sk, sk, loc->loc4_id, rem->rem4_id, GFP_KERNEL))
@@ -365,7 +217,7 @@ int mptcp_init4_subsockets(struct sock *meta_sk, const =
struct mptcp_loc4 *loc,
 	tp->mptcp->low_prio =3D loc->low_prio;
 =

 	/* Initializing the timer for an MPTCP subflow */
-	setup_timer(&tp->mptcp->mptcp_ack_timer, mptcp_ack_handler, (unsigned lon=
g)sk);
+	timer_setup(&tp->mptcp->mptcp_ack_timer, mptcp_ack_handler, 0);
 =

 	/** Then, connect the socket to the peer */
 	loc_in.sin_family =3D AF_INET;
@@ -432,13 +284,12 @@ const struct inet_connection_sock_af_ops mptcp_v4_spe=
cific =3D {
 	.rebuild_header	   =3D inet_sk_rebuild_header,
 	.sk_rx_dst_set	   =3D inet_sk_rx_dst_set,
 	.conn_request	   =3D mptcp_conn_request,
-	.syn_recv_sock	   =3D tcp_v4_syn_recv_sock,
+	.syn_recv_sock	   =3D mptcp_v4_syn_recv_sock,
 	.net_header_len	   =3D sizeof(struct iphdr),
 	.setsockopt	   =3D ip_setsockopt,
 	.getsockopt	   =3D ip_getsockopt,
 	.addr2sockaddr	   =3D inet_csk_addr2sockaddr,
 	.sockaddr_len	   =3D sizeof(struct sockaddr_in),
-	.bind_conflict	   =3D inet_csk_bind_conflict,
 #ifdef CONFIG_COMPAT
 	.compat_setsockopt =3D compat_ip_setsockopt,
 	.compat_getsockopt =3D compat_ip_getsockopt,
@@ -462,19 +313,18 @@ int mptcp_pm_v4_init(void)
 #endif
 	mptcp_join_request_sock_ipv4_ops =3D tcp_request_sock_ipv4_ops;
 	mptcp_join_request_sock_ipv4_ops.init_req =3D mptcp_v4_join_init_req;
-	mptcp_join_request_sock_ipv4_ops.queue_hash_add =3D mptcp_v4_reqsk_queue_=
hash_add;
 =

 	ops->slab_name =3D kasprintf(GFP_KERNEL, "request_sock_%s", "MPTCP");
-	if (ops->slab_name =3D=3D NULL) {
+	if (!ops->slab_name) {
 		ret =3D -ENOMEM;
 		goto out;
 	}
 =

 	ops->slab =3D kmem_cache_create(ops->slab_name, ops->obj_size, 0,
-				      SLAB_DESTROY_BY_RCU|SLAB_HWCACHE_ALIGN,
+				      SLAB_TYPESAFE_BY_RCU | SLAB_HWCACHE_ALIGN,
 				      NULL);
 =

-	if (ops->slab =3D=3D NULL) {
+	if (!ops->slab) {
 		ret =3D  -ENOMEM;
 		goto err_reqsk_create;
 	}
diff --git a/net/mptcp/mptcp_ipv6.c b/net/mptcp/mptcp_ipv6.c
index 0de953d..e88b5b9 100644
--- a/net/mptcp/mptcp_ipv6.c
+++ b/net/mptcp/mptcp_ipv6.c
@@ -43,48 +43,7 @@
 #include <net/mptcp_v6.h>
 #include <net/tcp.h>
 #include <net/transp_v6.h>
-
-__u32 mptcp_v6_get_nonce(const __be32 *saddr, const __be32 *daddr,
-			 __be16 sport, __be16 dport)
-{
-	u32 secret[MD5_MESSAGE_BYTES / 4];
-	u32 hash[MD5_DIGEST_WORDS];
-	u32 i;
-
-	memcpy(hash, saddr, 16);
-	for (i =3D 0; i < 4; i++)
-		secret[i] =3D mptcp_secret[i] + (__force u32)daddr[i];
-	secret[4] =3D mptcp_secret[4] +
-		    (((__force u16)sport << 16) + (__force u16)dport);
-	secret[5] =3D mptcp_seed++;
-	for (i =3D 6; i < MD5_MESSAGE_BYTES / 4; i++)
-		secret[i] =3D mptcp_secret[i];
-
-	md5_transform(hash, secret);
-
-	return hash[0];
-}
-
-u64 mptcp_v6_get_key(const __be32 *saddr, const __be32 *daddr,
-		     __be16 sport, __be16 dport, u32 seed)
-{
-	u32 secret[MD5_MESSAGE_BYTES / 4];
-	u32 hash[MD5_DIGEST_WORDS];
-	u32 i;
-
-	memcpy(hash, saddr, 16);
-	for (i =3D 0; i < 4; i++)
-		secret[i] =3D mptcp_secret[i] + (__force u32)daddr[i];
-	secret[4] =3D mptcp_secret[4] +
-		    (((__force u16)sport << 16) + (__force u16)dport);
-	secret[5] =3D seed;
-	for (i =3D 6; i < MD5_MESSAGE_BYTES / 4; i++)
-		secret[i] =3D mptcp_secret[i];
-
-	md5_transform(hash, secret);
-
-	return *((u64 *)hash);
-}
+#include <net/secure_seq.h>
 =

 static void mptcp_v6_reqsk_destructor(struct request_sock *req)
 {
@@ -93,40 +52,34 @@ static void mptcp_v6_reqsk_destructor(struct request_so=
ck *req)
 	tcp_v6_reqsk_destructor(req);
 }
 =

-static int mptcp_v6_init_req(struct request_sock *req, struct sock *sk,
-			     struct sk_buff *skb, bool want_cookie)
+static void mptcp_v6_init_req(struct request_sock *req,
+			      const struct sock *sk_listener,
+			      struct sk_buff *skb)
 {
-	tcp_request_sock_ipv6_ops.init_req(req, sk, skb, want_cookie);
+	struct mptcp_options_received mopt;
 =

-	mptcp_rsk(req)->hash_entry.pprev =3D NULL;
-	mptcp_rsk(req)->is_sub =3D 0;
-	inet_rsk(req)->mptcp_rqsk =3D 1;
+	tcp_request_sock_ipv6_ops.init_req(req, sk_listener, skb);
 =

-	/* In case of SYN-cookies, we wait for the isn to be generated - it is
-	 * input to the key-generation.
-	 */
-	if (!want_cookie)
-		mptcp_reqsk_init(req, sk, skb, false);
-
-	return 0;
+	mptcp_init_mp_opt(&mopt);
+	inet_rsk(req)->mptcp_rqsk =3D 1;
+	tcp_parse_mptcp_options(skb, &mopt);
+	if (mopt.saw_mpc) {
+		/* In case of SYN-cookies, the entry in the hash will be deleted
+		 * when the request socket is freed.
+		 */
+		mptcp_reqsk_init(req, sk_listener, skb, &mopt);
+	}
 }
 =

 #ifdef CONFIG_SYN_COOKIES
-static u32 mptcp_v6_cookie_init_seq(struct request_sock *req, struct sock =
*sk,
-				    const struct sk_buff *skb, __u16 *mssp)
+static u32 mptcp_v6_cookie_init_seq(const struct sk_buff *skb, __u16 *mssp)
 {
-	__u32 isn =3D cookie_v6_init_sequence(req, sk, skb, mssp);
-
-	tcp_rsk(req)->snt_isn =3D isn;
-
-	mptcp_reqsk_init(req, sk, skb, true);
-
-	return isn;
+	return cookie_v6_init_sequence(skb, mssp);
 }
 #endif
 =

-static int mptcp_v6_join_init_req(struct request_sock *req, struct sock *s=
k,
-				  struct sk_buff *skb, bool want_cookie)
+static void mptcp_v6_join_init_req(struct request_sock *req,
+				   const struct sock *sk, struct sk_buff *skb)
 {
 	struct mptcp_request_sock *mtreq =3D mptcp_rsk(req);
 	struct mptcp_cb *mpcb =3D tcp_sk(sk)->mpcb;
@@ -141,22 +94,21 @@ static int mptcp_v6_join_init_req(struct request_sock =
*req, struct sock *sk,
 	 */
 	mtreq->hash_entry.pprev =3D NULL;
 =

-	tcp_request_sock_ipv6_ops.init_req(req, sk, skb, want_cookie);
+	tcp_request_sock_ipv6_ops.init_req(req, sk, skb);
 =

-	mtreq->mptcp_loc_nonce =3D mptcp_v6_get_nonce(ipv6_hdr(skb)->saddr.s6_add=
r32,
-						    ipv6_hdr(skb)->daddr.s6_addr32,
-						    tcp_hdr(skb)->source,
-						    tcp_hdr(skb)->dest);
+	mtreq->mptcp_loc_nonce =3D
+		mptcp_v6_get_nonce(ipv6_hdr(skb)->saddr.s6_addr32,
+				   ipv6_hdr(skb)->daddr.s6_addr32,
+				   tcp_hdr(skb)->source, tcp_hdr(skb)->dest);
 	addr.in6 =3D inet_rsk(req)->ir_v6_loc_addr;
-	loc_id =3D mpcb->pm_ops->get_local_id(AF_INET6, &addr, sock_net(sk), &low=
_prio);
+	loc_id =3D mpcb->pm_ops->get_local_id(AF_INET6, &addr, sock_net(sk),
+					    &low_prio);
 	if (loc_id =3D=3D -1)
-		return -1;
+		return;
 	mtreq->loc_id =3D loc_id;
 	mtreq->low_prio =3D low_prio;
 =

 	mptcp_join_reqsk_init(mpcb, req, skb);
-
-	return 0;
 }
 =

 /* Similar to tcp6_request_sock_ops */
@@ -170,178 +122,13 @@ struct request_sock_ops mptcp6_request_sock_ops __re=
ad_mostly =3D {
 	.syn_ack_timeout =3D	tcp_syn_ack_timeout,
 };
 =

-static void mptcp_v6_reqsk_queue_hash_add(struct sock *meta_sk,
-					  struct request_sock *req,
-					  const unsigned long timeout)
-{
-	const u32 h1 =3D inet6_synq_hash(&inet_rsk(req)->ir_v6_rmt_addr,
-				      inet_rsk(req)->ir_rmt_port,
-				      0, MPTCP_HASH_SIZE);
-	inet6_csk_reqsk_queue_hash_add(meta_sk, req, timeout);
-
-	rcu_read_lock();
-	spin_lock(&mptcp_reqsk_hlock);
-	hlist_nulls_add_head_rcu(&mptcp_rsk(req)->hash_entry, &mptcp_reqsk_htb[h1=
]);
-	spin_unlock(&mptcp_reqsk_hlock);
-	rcu_read_unlock();
-}
-
-static int mptcp_v6_join_request(struct sock *meta_sk, struct sk_buff *skb)
+int mptcp_v6_join_request(struct sock *meta_sk, struct sk_buff *skb)
 {
 	return tcp_conn_request(&mptcp6_request_sock_ops,
 				&mptcp_join_request_sock_ipv6_ops,
 				meta_sk, skb);
 }
 =

-int mptcp_v6_do_rcv(struct sock *meta_sk, struct sk_buff *skb)
-{
-	const struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
-	struct sock *child, *rsk =3D NULL;
-	int ret;
-
-	if (!(TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_JOIN)) {
-		struct tcphdr *th =3D tcp_hdr(skb);
-		const struct ipv6hdr *ip6h =3D ipv6_hdr(skb);
-		struct sock *sk;
-
-		sk =3D __inet6_lookup_established(sock_net(meta_sk),
-						&tcp_hashinfo,
-						&ip6h->saddr, th->source,
-						&ip6h->daddr, ntohs(th->dest),
-						tcp_v6_iif(skb));
-
-		if (!sk) {
-			kfree_skb(skb);
-			return 0;
-		}
-		if (is_meta_sk(sk)) {
-			WARN("%s Did not find a sub-sk!\n", __func__);
-			kfree_skb(skb);
-			sock_put(sk);
-			return 0;
-		}
-
-		if (sk->sk_state =3D=3D TCP_TIME_WAIT) {
-			inet_twsk_put(inet_twsk(sk));
-			kfree_skb(skb);
-			return 0;
-		}
-
-		ret =3D tcp_v6_do_rcv(sk, skb);
-		sock_put(sk);
-
-		return ret;
-	}
-	TCP_SKB_CB(skb)->mptcp_flags =3D 0;
-
-	/* Has been removed from the tk-table. Thus, no new subflows.
-	 *
-	 * Check for close-state is necessary, because we may have been closed
-	 * without passing by mptcp_close().
-	 *
-	 * When falling back, no new subflows are allowed either.
-	 */
-	if (meta_sk->sk_state =3D=3D TCP_CLOSE || !tcp_sk(meta_sk)->inside_tk_tab=
le ||
-	    mpcb->infinite_mapping_rcv || mpcb->send_infinite_mapping)
-		goto reset_and_discard;
-
-	child =3D tcp_v6_hnd_req(meta_sk, skb);
-
-	if (!child)
-		goto discard;
-
-	if (child !=3D meta_sk) {
-		sock_rps_save_rxhash(child, skb);
-		/* We don't call tcp_child_process here, because we hold
-		 * already the meta-sk-lock and are sure that it is not owned
-		 * by the user.
-		 */
-		ret =3D tcp_rcv_state_process(child, skb, tcp_hdr(skb), skb->len);
-		bh_unlock_sock(child);
-		sock_put(child);
-		if (ret) {
-			rsk =3D child;
-			goto reset_and_discard;
-		}
-	} else {
-		if (tcp_hdr(skb)->syn) {
-			mptcp_v6_join_request(meta_sk, skb);
-			goto discard;
-		}
-		goto reset_and_discard;
-	}
-	return 0;
-
-reset_and_discard:
-	if (reqsk_queue_len(&inet_csk(meta_sk)->icsk_accept_queue)) {
-		const struct tcphdr *th =3D tcp_hdr(skb);
-		struct request_sock *req;
-		/* If we end up here, it means we should not have matched on the
-		 * request-socket. But, because the request-sock queue is only
-		 * destroyed in mptcp_close, the socket may actually already be
-		 * in close-state (e.g., through shutdown()) while still having
-		 * pending request sockets.
-		 */
-		req =3D inet6_csk_search_req(meta_sk, th->source,
-					   &ipv6_hdr(skb)->saddr,
-					   &ipv6_hdr(skb)->daddr, tcp_v6_iif(skb));
-
-		if (req) {
-			inet_csk_reqsk_queue_drop(meta_sk, req);
-			reqsk_put(req);
-		}
-	}
-
-	tcp_v6_send_reset(rsk, skb);
-discard:
-	kfree_skb(skb);
-	return 0;
-}
-
-/* After this, the ref count of the meta_sk associated with the request_so=
ck
- * is incremented. Thus it is the responsibility of the caller
- * to call sock_put() when the reference is not needed anymore.
- */
-struct sock *mptcp_v6_search_req(const __be16 rport, const struct in6_addr=
 *raddr,
-				 const struct in6_addr *laddr, const struct net *net)
-{
-	const struct mptcp_request_sock *mtreq;
-	struct sock *meta_sk =3D NULL;
-	const struct hlist_nulls_node *node;
-	const u32 hash =3D inet6_synq_hash(raddr, rport, 0, MPTCP_HASH_SIZE);
-
-	rcu_read_lock();
-begin:
-	hlist_nulls_for_each_entry_rcu(mtreq, node, &mptcp_reqsk_htb[hash],
-				       hash_entry) {
-		struct inet_request_sock *treq =3D inet_rsk(rev_mptcp_rsk(mtreq));
-		meta_sk =3D mtreq->mptcp_mpcb->meta_sk;
-
-		if (inet_rsk(rev_mptcp_rsk(mtreq))->ir_rmt_port =3D=3D rport &&
-		    rev_mptcp_rsk(mtreq)->rsk_ops->family =3D=3D AF_INET6 &&
-		    ipv6_addr_equal(&treq->ir_v6_rmt_addr, raddr) &&
-		    ipv6_addr_equal(&treq->ir_v6_loc_addr, laddr) &&
-		    net_eq(net, sock_net(meta_sk)))
-			goto found;
-		meta_sk =3D NULL;
-	}
-	/* A request-socket is destroyed by RCU. So, it might have been recycled
-	 * and put into another hash-table list. So, after the lookup we may
-	 * end up in a different list. So, we may need to restart.
-	 *
-	 * See also the comment in __inet_lookup_established.
-	 */
-	if (get_nulls_value(node) !=3D hash + MPTCP_REQSK_NULLS_BASE)
-		goto begin;
-
-found:
-	if (meta_sk && unlikely(!atomic_inc_not_zero(&meta_sk->sk_refcnt)))
-		meta_sk =3D NULL;
-	rcu_read_unlock();
-
-	return meta_sk;
-}
-
 /* Create a new IPv6 subflow.
  *
  * We are in user-context and meta-sock-lock is hold.
@@ -371,7 +158,8 @@ int mptcp_init6_subsockets(struct sock *meta_sk, const =
struct mptcp_loc6 *loc,
 	tp =3D tcp_sk(sk);
 =

 	/* All subsockets need the MPTCP-lock-class */
-	lockdep_set_class_and_name(&(sk)->sk_lock.slock, &meta_slock_key, meta_sl=
ock_key_name);
+	lockdep_set_class_and_name(&(sk)->sk_lock.slock, &meta_slock_key,
+				   meta_slock_key_name);
 	lockdep_init_map(&(sk)->sk_lock.dep_map, meta_key_name, &meta_key, 0);
 =

 	if (mptcp_add_sock(meta_sk, sk, loc->loc6_id, rem->rem6_id, GFP_KERNEL))
@@ -381,7 +169,7 @@ int mptcp_init6_subsockets(struct sock *meta_sk, const =
struct mptcp_loc6 *loc,
 	tp->mptcp->low_prio =3D loc->low_prio;
 =

 	/* Initializing the timer for an MPTCP subflow */
-	setup_timer(&tp->mptcp->mptcp_ack_timer, mptcp_ack_handler, (unsigned lon=
g)sk);
+	timer_setup(&tp->mptcp->mptcp_ack_timer, mptcp_ack_handler, 0);
 =

 	/** Then, connect the socket to the peer */
 	loc_in.sin6_family =3D AF_INET6;
@@ -448,14 +236,13 @@ const struct inet_connection_sock_af_ops mptcp_v6_spe=
cific =3D {
 	.rebuild_header	   =3D inet6_sk_rebuild_header,
 	.sk_rx_dst_set	   =3D inet6_sk_rx_dst_set,
 	.conn_request	   =3D mptcp_conn_request,
-	.syn_recv_sock	   =3D tcp_v6_syn_recv_sock,
+	.syn_recv_sock	   =3D mptcp_v4_syn_recv_sock,
 	.net_header_len	   =3D sizeof(struct ipv6hdr),
 	.net_frag_header_len =3D sizeof(struct frag_hdr),
 	.setsockopt	   =3D ipv6_setsockopt,
 	.getsockopt	   =3D ipv6_getsockopt,
 	.addr2sockaddr	   =3D inet6_csk_addr2sockaddr,
 	.sockaddr_len	   =3D sizeof(struct sockaddr_in6),
-	.bind_conflict	   =3D inet6_csk_bind_conflict,
 #ifdef CONFIG_COMPAT
 	.compat_setsockopt =3D compat_ipv6_setsockopt,
 	.compat_getsockopt =3D compat_ipv6_getsockopt,
@@ -469,13 +256,12 @@ const struct inet_connection_sock_af_ops mptcp_v6_map=
ped =3D {
 	.rebuild_header	   =3D inet_sk_rebuild_header,
 	.sk_rx_dst_set	   =3D inet_sk_rx_dst_set,
 	.conn_request	   =3D mptcp_conn_request,
-	.syn_recv_sock	   =3D tcp_v6_syn_recv_sock,
+	.syn_recv_sock	   =3D mptcp_v4_syn_recv_sock,
 	.net_header_len	   =3D sizeof(struct iphdr),
 	.setsockopt	   =3D ipv6_setsockopt,
 	.getsockopt	   =3D ipv6_getsockopt,
 	.addr2sockaddr	   =3D inet6_csk_addr2sockaddr,
 	.sockaddr_len	   =3D sizeof(struct sockaddr_in6),
-	.bind_conflict	   =3D inet6_csk_bind_conflict,
 #ifdef CONFIG_COMPAT
 	.compat_setsockopt =3D compat_ipv6_setsockopt,
 	.compat_getsockopt =3D compat_ipv6_getsockopt,
@@ -499,19 +285,17 @@ int mptcp_pm_v6_init(void)
 =

 	mptcp_join_request_sock_ipv6_ops =3D tcp_request_sock_ipv6_ops;
 	mptcp_join_request_sock_ipv6_ops.init_req =3D mptcp_v6_join_init_req;
-	mptcp_join_request_sock_ipv6_ops.queue_hash_add =3D mptcp_v6_reqsk_queue_=
hash_add;
 =

 	ops->slab_name =3D kasprintf(GFP_KERNEL, "request_sock_%s", "MPTCP6");
-	if (ops->slab_name =3D=3D NULL) {
+	if (!ops->slab_name) {
 		ret =3D -ENOMEM;
 		goto out;
 	}
 =

 	ops->slab =3D kmem_cache_create(ops->slab_name, ops->obj_size, 0,
-				      SLAB_DESTROY_BY_RCU|SLAB_HWCACHE_ALIGN,
+				      SLAB_TYPESAFE_BY_RCU | SLAB_HWCACHE_ALIGN,
 				      NULL);
-
-	if (ops->slab =3D=3D NULL) {
+	if (!ops->slab) {
 		ret =3D  -ENOMEM;
 		goto err_reqsk_create;
 	}
diff --git a/net/mptcp/mptcp_ofo_queue.c b/net/mptcp/mptcp_ofo_queue.c
index ac94e1c..d795f33 100644
--- a/net/mptcp/mptcp_ofo_queue.c
+++ b/net/mptcp/mptcp_ofo_queue.c
@@ -31,248 +31,130 @@
 #include <net/tcp.h>
 #include <net/mptcp.h>
 =

-void mptcp_remove_shortcuts(const struct mptcp_cb *mpcb,
-			    const struct sk_buff *skb)
+void mptcp_add_meta_ofo_queue(struct sock *meta_sk, struct sk_buff *skb)
 {
-	struct tcp_sock *tp;
-
-	mptcp_for_each_tp(mpcb, tp) {
-		if (tp->mptcp->shortcut_ofoqueue =3D=3D skb) {
-			tp->mptcp->shortcut_ofoqueue =3D NULL;
-			return;
-		}
-	}
-}
-
-/* Does 'skb' fits after 'here' in the queue 'head' ?
- * If yes, we queue it and return 1
- */
-static int mptcp_ofo_queue_after(struct sk_buff_head *head,
-				 struct sk_buff *skb, struct sk_buff *here,
-				 const struct tcp_sock *tp)
-{
-	struct sock *meta_sk =3D tp->meta_sk;
 	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
-	u32 seq =3D TCP_SKB_CB(skb)->seq;
-	u32 end_seq =3D TCP_SKB_CB(skb)->end_seq;
-
-	/* We want to queue skb after here, thus seq >=3D end_seq */
-	if (before(seq, TCP_SKB_CB(here)->end_seq))
-		return 0;
-
-	if (seq =3D=3D TCP_SKB_CB(here)->end_seq) {
-		bool fragstolen =3D false;
-
-		if (!tcp_try_coalesce(meta_sk, here, skb, &fragstolen)) {
-			__skb_queue_after(&meta_tp->out_of_order_queue, here, skb);
-			return 1;
-		} else {
-			kfree_skb_partial(skb, fragstolen);
-			return -1;
-		}
+	struct rb_node **p, *q, *parent;
+	struct sk_buff *skb1;
+	u32 seq, end_seq;
+	bool fragstolen;
+
+	seq =3D TCP_SKB_CB(skb)->seq;
+	end_seq =3D TCP_SKB_CB(skb)->end_seq;
+
+	p =3D &meta_tp->out_of_order_queue.rb_node;
+	if (RB_EMPTY_ROOT(&meta_tp->out_of_order_queue)) {
+		rb_link_node(&skb->rbnode, NULL, p);
+		rb_insert_color(&skb->rbnode, &meta_tp->out_of_order_queue);
+		meta_tp->ooo_last_skb =3D skb;
+		goto done;
 	}
 =

-	/* If here is the last one, we can always queue it */
-	if (skb_queue_is_last(head, here)) {
-		__skb_queue_after(head, here, skb);
-		return 1;
-	} else {
-		struct sk_buff *skb1 =3D skb_queue_next(head, here);
-		/* It's not the last one, but does it fits between 'here' and
-		 * the one after 'here' ? Thus, does end_seq <=3D after_here->seq
-		 */
-		if (!after(end_seq, TCP_SKB_CB(skb1)->seq)) {
-			__skb_queue_after(head, here, skb);
-			return 1;
-		}
+	/* In the typical case, we are adding an skb to the end of the list.
+	 * Use of ooo_last_skb avoids the O(Log(N)) rbtree lookup.
+	 */
+	if (tcp_try_coalesce(meta_sk, meta_tp->ooo_last_skb,
+			     skb, &fragstolen)) {
+coalesce_done:
+		kfree_skb_partial(skb, fragstolen);
+		skb =3D NULL;
+		goto done;
 	}
 =

-	return 0;
-}
-
-static void try_shortcut(struct sk_buff *shortcut, struct sk_buff *skb,
-			 struct sk_buff_head *head, struct tcp_sock *tp)
-{
-	struct sock *meta_sk =3D tp->meta_sk;
-	struct tcp_sock *tp_it, *meta_tp =3D tcp_sk(meta_sk);
-	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
-	struct sk_buff *skb1, *best_shortcut =3D NULL;
-	u32 seq =3D TCP_SKB_CB(skb)->seq;
-	u32 end_seq =3D TCP_SKB_CB(skb)->end_seq;
-	u32 distance =3D 0xffffffff;
-
-	/* First, check the tp's shortcut */
-	if (!shortcut) {
-		if (skb_queue_empty(head)) {
-			__skb_queue_head(head, skb);
-			goto end;
-		}
-	} else {
-		int ret =3D mptcp_ofo_queue_after(head, skb, shortcut, tp);
-		/* Does the tp's shortcut is a hit? If yes, we insert. */
-
-		if (ret) {
-			skb =3D (ret > 0) ? skb : NULL;
-			goto end;
-		}
+	/* Can avoid an rbtree lookup if we are adding skb after ooo_last_skb */
+	if (!before(seq, TCP_SKB_CB(meta_tp->ooo_last_skb)->end_seq)) {
+		parent =3D &meta_tp->ooo_last_skb->rbnode;
+		p =3D &parent->rb_right;
+		goto insert;
 	}
 =

-	/* Check the shortcuts of the other subsockets. */
-	mptcp_for_each_tp(mpcb, tp_it) {
-		shortcut =3D tp_it->mptcp->shortcut_ofoqueue;
-		/* Can we queue it here? If yes, do so! */
-		if (shortcut) {
-			int ret =3D mptcp_ofo_queue_after(head, skb, shortcut, tp);
-
-			if (ret) {
-				skb =3D (ret > 0) ? skb : NULL;
-				goto end;
-			}
+	/* Find place to insert this segment. Handle overlaps on the way. */
+	parent =3D NULL;
+	while (*p) {
+		parent =3D *p;
+		skb1 =3D rb_entry(parent, struct sk_buff, rbnode);
+		if (before(seq, TCP_SKB_CB(skb1)->seq)) {
+			p =3D &parent->rb_left;
+			continue;
 		}
-
-		/* Could not queue it, check if we are close.
-		 * We are looking for a shortcut, close enough to seq to
-		 * set skb1 prematurely and thus improve the subsequent lookup,
-		 * which tries to find a skb1 so that skb1->seq <=3D seq.
-		 *
-		 * So, here we only take shortcuts, whose shortcut->seq > seq,
-		 * and minimize the distance between shortcut->seq and seq and
-		 * set best_shortcut to this one with the minimal distance.
-		 *
-		 * That way, the subsequent while-loop is shortest.
-		 */
-		if (shortcut && after(TCP_SKB_CB(shortcut)->seq, seq)) {
-			/* Are we closer than the current best shortcut? */
-			if ((u32)(TCP_SKB_CB(shortcut)->seq - seq) < distance) {
-				distance =3D (u32)(TCP_SKB_CB(shortcut)->seq - seq);
-				best_shortcut =3D shortcut;
+		if (before(seq, TCP_SKB_CB(skb1)->end_seq)) {
+			if (!after(end_seq, TCP_SKB_CB(skb1)->end_seq)) {
+				/* All the bits are present. Drop. */
+				__kfree_skb(skb);
+				goto done;
+			}
+			if (!after(seq, TCP_SKB_CB(skb1)->seq)) {
+				/* skb's seq =3D=3D skb1's seq and skb covers skb1.
+				 * Replace skb1 with skb.
+				 */
+				rb_replace_node(&skb1->rbnode, &skb->rbnode,
+						&meta_tp->out_of_order_queue);
+				__kfree_skb(skb1);
+				goto merge_right;
 			}
+		} else if (tcp_try_coalesce(meta_sk, skb1, skb, &fragstolen)) {
+			goto coalesce_done;
 		}
+		p =3D &parent->rb_right;
 	}
+insert:
+	/* Insert segment into RB tree. */
+	rb_link_node(&skb->rbnode, parent, p);
+	rb_insert_color(&skb->rbnode, &meta_tp->out_of_order_queue);
 =

-	if (best_shortcut)
-		skb1 =3D best_shortcut;
-	else
-		skb1 =3D skb_peek_tail(head);
+merge_right:
+	/* Remove other segments covered by skb. */
+	while ((q =3D rb_next(&skb->rbnode)) !=3D NULL) {
+		skb1 =3D rb_entry(q, struct sk_buff, rbnode);
 =

-	if (seq =3D=3D TCP_SKB_CB(skb1)->end_seq) {
-		bool fragstolen =3D false;
-
-		if (!tcp_try_coalesce(meta_sk, skb1, skb, &fragstolen)) {
-			__skb_queue_after(&meta_tp->out_of_order_queue, skb1, skb);
-		} else {
-			kfree_skb_partial(skb, fragstolen);
-			skb =3D NULL;
-		}
-
-		goto end;
-	}
-
-	/* Find the insertion point, starting from best_shortcut if available.
-	 *
-	 * Inspired from tcp_data_queue_ofo.
-	 */
-	while (1) {
-		/* skb1->seq <=3D seq */
-		if (!after(TCP_SKB_CB(skb1)->seq, seq))
+		if (!after(end_seq, TCP_SKB_CB(skb1)->seq))
 			break;
-		if (skb_queue_is_first(head, skb1)) {
-			skb1 =3D NULL;
+		if (before(end_seq, TCP_SKB_CB(skb1)->end_seq)) {
 			break;
 		}
-		skb1 =3D skb_queue_prev(head, skb1);
-	}
-
-	/* Do skb overlap to previous one? */
-	if (skb1 && before(seq, TCP_SKB_CB(skb1)->end_seq)) {
-		if (!after(end_seq, TCP_SKB_CB(skb1)->end_seq)) {
-			/* All the bits are present. */
-			__kfree_skb(skb);
-			skb =3D NULL;
-			goto end;
-		}
-		if (seq =3D=3D TCP_SKB_CB(skb1)->seq) {
-			if (skb_queue_is_first(head, skb1))
-				skb1 =3D NULL;
-			else
-				skb1 =3D skb_queue_prev(head, skb1);
-		}
-	}
-	if (!skb1)
-		__skb_queue_head(head, skb);
-	else
-		__skb_queue_after(head, skb1, skb);
-
-end:
-	/* And clean segments covered by new one as whole. */
-	while (skb && !skb_queue_is_last(head, skb)) {
-		skb1 =3D skb_queue_next(head, skb);
-
-		if (!after(end_seq, TCP_SKB_CB(skb1)->seq))
-			break;
-
-		__skb_unlink(skb1, head);
-		mptcp_remove_shortcuts(mpcb, skb1);
+		rb_erase(&skb1->rbnode, &meta_tp->out_of_order_queue);
 		__kfree_skb(skb1);
 	}
-
-	if (skb) {
-		skb_set_owner_r(skb, meta_sk);
-		tp->mptcp->shortcut_ofoqueue =3D skb;
-	}
-
+	/* If there is no skb after us, we are the last_skb ! */
+	if (!q)
+		meta_tp->ooo_last_skb =3D skb;
+done:
 	return;
 }
 =

-/**
- * @sk: the subflow that received this skb.
+/*
+ * This one checks to see if we can put data from the
+ * out_of_order queue into the receive_queue.
  */
-void mptcp_add_meta_ofo_queue(const struct sock *meta_sk, struct sk_buff *=
skb,
-			      struct sock *sk)
-{
-	struct tcp_sock *tp =3D tcp_sk(sk);
-
-	try_shortcut(tp->mptcp->shortcut_ofoqueue, skb,
-		     &tcp_sk(meta_sk)->out_of_order_queue, tp);
-}
-
-bool mptcp_prune_ofo_queue(struct sock *sk)
-{
-	struct tcp_sock *tp	=3D tcp_sk(sk);
-	bool res		=3D false;
-
-	if (!skb_queue_empty(&tp->out_of_order_queue)) {
-		NET_INC_STATS_BH(sock_net(sk), LINUX_MIB_OFOPRUNED);
-		mptcp_purge_ofo_queue(tp);
-
-		/* No sack at the mptcp-level */
-		sk_mem_reclaim(sk);
-		res =3D true;
-	}
-
-	return res;
-}
-
 void mptcp_ofo_queue(struct sock *meta_sk)
 {
 	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
 	struct sk_buff *skb;
+	struct rb_node *p;
 =

-	while ((skb =3D skb_peek(&meta_tp->out_of_order_queue)) !=3D NULL) {
-		u32 old_rcv_nxt =3D meta_tp->rcv_nxt;
+	p =3D rb_first(&meta_tp->out_of_order_queue);
+	while (p) {
+		u32 old_rcv_nxt;
+
+		skb =3D rb_entry(p, struct sk_buff, rbnode);
+		old_rcv_nxt =3D meta_tp->rcv_nxt;
 		if (after(TCP_SKB_CB(skb)->seq, meta_tp->rcv_nxt))
 			break;
 =

 		if (!after(TCP_SKB_CB(skb)->end_seq, meta_tp->rcv_nxt)) {
-			__skb_unlink(skb, &meta_tp->out_of_order_queue);
+			p =3D rb_next(p);
+			rb_erase(&skb->rbnode, &meta_tp->out_of_order_queue);
+#ifdef RCHK
 			mptcp_remove_shortcuts(meta_tp->mpcb, skb);
+#endif
 			__kfree_skb(skb);
 			continue;
 		}
-
-		__skb_unlink(skb, &meta_tp->out_of_order_queue);
+		p =3D rb_next(p);
+		rb_erase(&skb->rbnode, &meta_tp->out_of_order_queue);
+#ifdef RCHK
 		mptcp_remove_shortcuts(meta_tp->mpcb, skb);
-
+#endif
 		__skb_queue_tail(&meta_sk->sk_receive_queue, skb);
 		meta_tp->rcv_nxt =3D TCP_SKB_CB(skb)->end_seq;
 		mptcp_check_rcvseq_wrap(meta_tp, old_rcv_nxt);
@@ -282,14 +164,14 @@ void mptcp_ofo_queue(struct sock *meta_sk)
 	}
 }
 =

+/* call to mptcp_remove_shortcuts prohibits use from using tcp_prune_ofo_q=
ueue */
 void mptcp_purge_ofo_queue(struct tcp_sock *meta_tp)
 {
-	struct sk_buff_head *head =3D &meta_tp->out_of_order_queue;
-	struct sk_buff *skb, *tmp;
 =

-	skb_queue_walk_safe(head, skb, tmp) {
-		__skb_unlink(skb, head);
-		mptcp_remove_shortcuts(meta_tp->mpcb, skb);
-		kfree_skb(skb);
-	}
+	skb_rbtree_purge(&meta_tp->out_of_order_queue);
+}
+
+bool mptcp_prune_ofo_queue(struct sock *meta_sk)
+{
+	return tcp_prune_ofo_queue(meta_sk);
 }
diff --git a/net/mptcp/mptcp_output.c b/net/mptcp/mptcp_output.c
index 691ef6f..ca241ee 100644
--- a/net/mptcp/mptcp_output.c
+++ b/net/mptcp/mptcp_output.c
@@ -43,6 +43,7 @@ static const int mptcp_dss_len =3D MPTCP_SUB_LEN_DSS_ALIG=
N +
 static inline int mptcp_sub_len_remove_addr(u16 bitfield)
 {
 	unsigned int c;
+
 	for (c =3D 0; bitfield; c++)
 		bitfield &=3D bitfield - 1;
 	return MPTCP_SUB_LEN_REMOVE_ADDR + c - 1;
@@ -59,32 +60,14 @@ EXPORT_SYMBOL(mptcp_sub_len_remove_addr_align);
  */
 static bool mptcp_reconstruct_mapping(struct sk_buff *skb)
 {
-	const struct mp_dss *mpdss =3D (struct mp_dss *)TCP_SKB_CB(skb)->dss;
-	u32 *p32;
-	u16 *p16;
+	int len;
 =

 	if (!mptcp_is_data_seq(skb))
 		return false;
 =

-	if (!mpdss->M)
-		return false;
-
-	/* Move the pointer to the data-seq */
-	p32 =3D (u32 *)mpdss;
-	p32++;
-	if (mpdss->A) {
-		p32++;
-		if (mpdss->a)
-			p32++;
-	}
-
-	TCP_SKB_CB(skb)->seq =3D ntohl(*p32);
-
-	/* Get the data_len to calculate the end_data_seq */
-	p32++;
-	p32++;
-	p16 =3D (u16 *)p32;
-	TCP_SKB_CB(skb)->end_seq =3D ntohs(*p16) + TCP_SKB_CB(skb)->seq;
+	len =3D TCP_SKB_CB(skb)->end_seq - TCP_SKB_CB(skb)->seq;
+	TCP_SKB_CB(skb)->seq =3D TCP_SKB_CB(skb)->mptcp_data_seq;
+	TCP_SKB_CB(skb)->end_seq =3D TCP_SKB_CB(skb)->mptcp_data_seq + len;
 =

 	return true;
 }
@@ -94,18 +77,20 @@ static bool mptcp_is_reinjected(const struct sk_buff *s=
kb)
 	return TCP_SKB_CB(skb)->mptcp_flags & MPTCP_REINJECT;
 }
 =

-static void mptcp_find_and_set_pathmask(const struct sock *meta_sk, struct=
 sk_buff *skb)
+static void mptcp_find_and_set_pathmask(const struct sock *meta_sk,
+					struct sk_buff *skb)
 {
 	struct sk_buff *skb_it;
 =

 	skb_it =3D tcp_write_queue_head(meta_sk);
 =

-	tcp_for_write_queue_from(skb_it, meta_sk) {
+	skb_queue_walk_from(&(meta_sk)->sk_write_queue, skb_it) {
 		if (skb_it =3D=3D tcp_send_head(meta_sk))
 			break;
 =

 		if (TCP_SKB_CB(skb_it)->seq =3D=3D TCP_SKB_CB(skb)->seq) {
-			TCP_SKB_CB(skb)->path_mask =3D TCP_SKB_CB(skb_it)->path_mask;
+			TCP_SKB_CB(skb)->mptcp_path_mask =3D
+				TCP_SKB_CB(skb_it)->mptcp_path_mask;
 			break;
 		}
 	}
@@ -114,7 +99,8 @@ static void mptcp_find_and_set_pathmask(const struct soc=
k *meta_sk, struct sk_bu
 /* Reinject data from one TCP subflow to the meta_sk. If sk =3D=3D NULL, w=
e are
  * coming from the meta-retransmit-timer
  */
-static void __mptcp_reinject_data(struct sk_buff *orig_skb, struct sock *m=
eta_sk,
+static void __mptcp_reinject_data(struct sk_buff *orig_skb,
+				  struct sock *meta_sk,
 				  struct sock *sk, int clone_it)
 {
 	struct sk_buff *skb, *skb1;
@@ -127,9 +113,12 @@ static void __mptcp_reinject_data(struct sk_buff *orig=
_skb, struct sock *meta_sk
 		 * will be changed when it's going to be reinjected on another
 		 * subflow.
 		 */
-		skb =3D pskb_copy_for_clone(orig_skb, GFP_ATOMIC);
+		tcp_skb_tsorted_save(orig_skb) {
+			skb =3D pskb_copy_for_clone(orig_skb, GFP_ATOMIC);
+		} tcp_skb_tsorted_restore(orig_skb);
 	} else {
-		__skb_unlink(orig_skb, &sk->sk_write_queue);
+		list_del(&orig_skb->tcp_tsorted_anchor);
+		tcp_rtx_queue_unlink(orig_skb, sk);
 		sock_set_flag(sk, SOCK_QUEUE_SHRUNK);
 		sk->sk_wmem_queued -=3D orig_skb->truesize;
 		sk_mem_uncharge(sk, orig_skb->truesize);
@@ -149,7 +138,9 @@ static void __mptcp_reinject_data(struct sk_buff *orig_=
skb, struct sock *meta_sk
 	TCP_SKB_CB(skb)->sacked =3D 0;
 	TCP_SKB_CB(skb)->tcp_flags &=3D (TCPHDR_ACK | TCPHDR_PSH);
 =

-	/* If it reached already the destination, we don't have to reinject it */
+	/* If it reached already the destination,
+	 * we don't have to reinject it
+	 */
 	if (!after(TCP_SKB_CB(skb)->end_seq, meta_tp->snd_una)) {
 		__kfree_skb(skb);
 		return;
@@ -166,7 +157,9 @@ static void __mptcp_reinject_data(struct sk_buff *orig_=
skb, struct sock *meta_sk
 		/* Ok, now we have to look for the full mapping in the meta
 		 * send-queue :S
 		 */
-		tcp_for_write_queue(skb, meta_sk) {
+		for (skb =3D skb_rb_first(&meta_sk->tcp_rtx_queue); skb;
+		     skb =3D skb1) {
+			skb1 =3D skb_rb_next(skb);
 			/* Not yet at the mapping? */
 			if (before(TCP_SKB_CB(skb)->seq, seq))
 				continue;
@@ -180,9 +173,9 @@ static void __mptcp_reinject_data(struct sk_buff *orig_=
skb, struct sock *meta_sk
 	}
 =

 	/* Segment goes back to the MPTCP-layer. So, we need to zero the
-	 * path_mask/dss.
+	 * path_mask.
 	 */
-	memset(TCP_SKB_CB(skb)->dss, 0 , mptcp_dss_len);
+	TCP_SKB_CB(skb)->mptcp_path_mask =3D 0;
 =

 	/* We need to find out the path-mask from the meta-write-queue
 	 * to properly select a subflow.
@@ -225,7 +218,8 @@ static void __mptcp_reinject_data(struct sk_buff *orig_=
skb, struct sock *meta_sk
 			if (skb_queue_is_first(&mpcb->reinject_queue, skb1))
 				skb1 =3D NULL;
 			else
-				skb1 =3D skb_queue_prev(&mpcb->reinject_queue, skb1);
+				skb1 =3D skb_queue_prev(&mpcb->reinject_queue,
+						      skb1);
 		}
 	}
 	if (!skb1)
@@ -243,43 +237,49 @@ static void __mptcp_reinject_data(struct sk_buff *ori=
g_skb, struct sock *meta_sk
 		__skb_unlink(skb1, &mpcb->reinject_queue);
 		__kfree_skb(skb1);
 	}
-	return;
 }
 =

 /* Inserts data into the reinject queue */
 void mptcp_reinject_data(struct sock *sk, int clone_it)
 {
-	struct sk_buff *skb_it, *tmp;
+	struct sk_buff *skb_it, *next;
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	struct sock *meta_sk =3D tp->meta_sk;
 =

-	/* It has already been closed - there is really no point in reinjecting */
+	/* It has already been closed -
+	 * there is really no point in reinjecting
+	 */
 	if (meta_sk->sk_state =3D=3D TCP_CLOSE)
 		return;
 =

-	skb_queue_walk_safe(&sk->sk_write_queue, skb_it, tmp) {
+	for (skb_it =3D skb_rb_first(&sk->tcp_rtx_queue); skb_it; skb_it =3D next=
) {
 		struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb_it);
+
+		next =3D skb_rb_next(skb_it);
+
 		/* Subflow syn's and fin's are not reinjected.
 		 *
 		 * As well as empty subflow-fins with a data-fin.
 		 * They are reinjected below (without the subflow-fin-flag)
 		 */
 		if (tcb->tcp_flags & TCPHDR_SYN ||
-		    (tcb->tcp_flags & TCPHDR_FIN && !mptcp_is_data_fin(skb_it)) ||
-		    (tcb->tcp_flags & TCPHDR_FIN && mptcp_is_data_fin(skb_it) && !skb_it=
->len))
+		    (tcb->tcp_flags & TCPHDR_FIN &&
+		    !mptcp_is_data_fin(skb_it)) ||
+		    (tcb->tcp_flags & TCPHDR_FIN &&
+		    mptcp_is_data_fin(skb_it) && !skb_it->len))
 			continue;
-
 		if (mptcp_is_reinjected(skb_it))
 			continue;
 =

-		tcb->mptcp_flags |=3D MPTCP_REINJECT;
+		TCP_SKB_CB(skb_it)->mptcp_flags |=3D MPTCP_REINJECT;
 		__mptcp_reinject_data(skb_it, meta_sk, sk, clone_it);
 	}
 =

-	skb_it =3D tcp_write_queue_tail(meta_sk);
+	skb_it =3D skb_rb_last(&meta_sk->tcp_rtx_queue);
 	/* If sk has sent the empty data-fin, we have to reinject it too. */
 	if (skb_it && mptcp_is_data_fin(skb_it) && skb_it->len =3D=3D 0 &&
-	    TCP_SKB_CB(skb_it)->path_mask & mptcp_pi_to_flag(tp->mptcp->path_inde=
x)) {
+	    TCP_SKB_CB(skb_it)->mptcp_path_mask &
+	    mptcp_pi_to_flag(tp->mptcp->path_index)) {
 		__mptcp_reinject_data(skb_it, meta_sk, NULL, 1);
 	}
 =

@@ -319,25 +319,43 @@ combine:
 	}
 }
 =

-static int mptcp_write_dss_mapping(const struct tcp_sock *tp, const struct=
 sk_buff *skb,
-				   __be32 *ptr)
+/* RFC6824 states that once a particular subflow mapping has been sent
+ * out it must never be changed. However, packets may be split while
+ * they are in the retransmission queue (due to SACK or ACKs) and that
+ * arguably means that we would change the mapping (e.g. it splits it,
+ * our sends out a subset of the initial mapping).
+ *
+ * Furthermore, the skb checksum is not always preserved across splits
+ * (e.g. mptcp_fragment) which would mean that we need to recompute
+ * the DSS checksum in this case.
+ *
+ * To avoid this we save the initial DSS mapping which allows us to
+ * send the same DSS mapping even for fragmented retransmits.
+ */
+
+static int mptcp_write_dss_mapping(const struct tcp_sock *tp,
+				   const struct sk_buff *skb, __be32 *ptr)
 {
 	const struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
-	__be32 *start =3D ptr;
 	__u16 data_len;
+	__be32 *start =3D ptr;
 =

-	*ptr++ =3D htonl(tcb->seq); /* data_seq */
+	*ptr++ =3D htonl(tcb->mptcp_data_seq); /* data_seq */
 =

 	/* If it's a non-data DATA_FIN, we set subseq to 0 (draft v7) */
 	if (mptcp_is_data_fin(skb) && skb->len =3D=3D 0)
 		*ptr++ =3D 0; /* subseq */
 	else
-		*ptr++ =3D htonl(tp->write_seq - tp->mptcp->snt_isn); /* subseq */
+		*ptr++ =3D htonl(tcb->seq - tp->mptcp->snt_isn); /* subseq */
 =

-	if (tcb->mptcp_flags & MPTCPHDR_INF)
+	if (TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_INF) {
 		data_len =3D 0;
-	else
+	} else {
 		data_len =3D tcb->end_seq - tcb->seq;
+		/* mptcp_entail_skb adds one for FIN */
+		if (tcb->tcp_flags & TCPHDR_FIN)
+			data_len -=3D 1;
+	}
 =

 	if (tp->mpcb->dss_csum && data_len) {
 		__be16 *p16 =3D (__be16 *)ptr;
@@ -349,18 +367,19 @@ static int mptcp_write_dss_mapping(const struct tcp_s=
ock *tp, const struct sk_bu
 			     (TCPOPT_EOL));
 		csum =3D csum_partial(ptr - 2, 12, skb->csum);
 		p16++;
-		*p16++ =3D csum_fold(csum_partial(&hdseq, sizeof(hdseq), csum));
+		*p16 =3D csum_fold(csum_partial(&hdseq, sizeof(hdseq), csum));
+		ptr++;
 	} else {
 		*ptr++ =3D htonl(((data_len) << 16) |
 			       (TCPOPT_NOP << 8) |
 			       (TCPOPT_NOP));
 	}
 =

-	return ptr - start;
+	return (ptr - start);
 }
 =

-static int mptcp_write_dss_data_ack(const struct tcp_sock *tp, const struc=
t sk_buff *skb,
-				    __be32 *ptr)
+static int mptcp_write_dss_data_ack(const struct tcp_sock *tp,
+				    const struct sk_buff *skb, __be32 *ptr)
 {
 	struct mp_dss *mdss =3D (struct mp_dss *)ptr;
 	__be32 *start =3D ptr;
@@ -377,52 +396,10 @@ static int mptcp_write_dss_data_ack(const struct tcp_=
sock *tp, const struct sk_b
 	mdss->len =3D mptcp_sub_len_dss(mdss, tp->mpcb->dss_csum);
 	ptr++;
 =

+	/* data_ack */
 	*ptr++ =3D htonl(mptcp_meta_tp(tp)->rcv_nxt);
 =

-	return ptr - start;
-}
-
-/* RFC6824 states that once a particular subflow mapping has been sent
- * out it must never be changed. However, packets may be split while
- * they are in the retransmission queue (due to SACK or ACKs) and that
- * arguably means that we would change the mapping (e.g. it splits it,
- * our sends out a subset of the initial mapping).
- *
- * Furthermore, the skb checksum is not always preserved across splits
- * (e.g. mptcp_fragment) which would mean that we need to recompute
- * the DSS checksum in this case.
- *
- * To avoid this we save the initial DSS mapping which allows us to
- * send the same DSS mapping even for fragmented retransmits.
- */
-static void mptcp_save_dss_data_seq(const struct tcp_sock *tp, struct sk_b=
uff *skb)
-{
-	struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
-	__be32 *ptr =3D (__be32 *)tcb->dss;
-
-	tcb->mptcp_flags |=3D MPTCPHDR_SEQ;
-
-	ptr +=3D mptcp_write_dss_data_ack(tp, skb, ptr);
-	ptr +=3D mptcp_write_dss_mapping(tp, skb, ptr);
-}
-
-/* Write the saved DSS mapping to the header */
-static int mptcp_write_dss_data_seq(const struct tcp_sock *tp, struct sk_b=
uff *skb,
-				    __be32 *ptr)
-{
-	__be32 *start =3D ptr;
-
-	memcpy(ptr, TCP_SKB_CB(skb)->dss, mptcp_dss_len);
-
-	/* update the data_ack */
-	start[1] =3D htonl(mptcp_meta_tp(tp)->rcv_nxt);
-
-	/* dss is in a union with inet_skb_parm and
-	 * the IP layer expects zeroed IPCB fields.
-	 */
-	memset(TCP_SKB_CB(skb)->dss, 0 , mptcp_dss_len);
-
-	return mptcp_dss_len/sizeof(*ptr);
+	return (ptr - start);
 }
 =

 static bool mptcp_skb_entail(struct sock *sk, struct sk_buff *skb, int rei=
nject)
@@ -435,24 +412,34 @@ static bool mptcp_skb_entail(struct sock *sk, struct =
sk_buff *skb, int reinject)
 =

 	if (!reinject)
 		TCP_SKB_CB(skb)->mptcp_flags |=3D (mpcb->snd_hiseq_index ?
-						  MPTCPHDR_SEQ64_INDEX : 0);
+					MPTCPHDR_SEQ64_INDEX : 0);
+
+	tcp_skb_tsorted_save(skb) {
+		subskb =3D pskb_copy_for_clone(skb, GFP_ATOMIC);
+	} tcp_skb_tsorted_restore(skb);
 =

-	subskb =3D pskb_copy_for_clone(skb, GFP_ATOMIC);
 	if (!subskb)
 		return false;
 =

+	INIT_LIST_HEAD(&subskb->tcp_tsorted_anchor);
+
 	/* At the subflow-level we need to call again tcp_init_tso_segs. We
 	 * force this, by setting pcount to 0. It has been set to 1 prior to
 	 * the call to mptcp_skb_entail.
 	 */
 	tcp_skb_pcount_set(subskb, 0);
 =

-	TCP_SKB_CB(skb)->path_mask |=3D mptcp_pi_to_flag(tp->mptcp->path_index);
+	TCP_SKB_CB(skb)->mptcp_path_mask |=3D
+		mptcp_pi_to_flag(tp->mptcp->path_index);
 =

-	if (!(sk->sk_route_caps & NETIF_F_ALL_CSUM) &&
-	    skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
-		subskb->csum =3D skb->csum =3D skb_checksum(skb, 0, skb->len, 0);
-		subskb->ip_summed =3D skb->ip_summed =3D CHECKSUM_NONE;
+	subskb->csum =3D 0;
+
+	/* If dss-csum is enabled, we do not do hw-csum. */
+	if (tp->mpcb->dss_csum || !sk_check_csum_caps(sk)) {
+		skb->csum =3D skb_checksum(skb, 0, skb->len, 0);
+		subskb->csum =3D skb->csum;
+		subskb->ip_summed =3D CHECKSUM_NONE;
+		skb->ip_summed =3D CHECKSUM_NONE;
 	}
 =

 	tcb =3D TCP_SKB_CB(subskb);
@@ -469,7 +456,9 @@ static bool mptcp_skb_entail(struct sock *sk, struct sk=
_buff *skb, int reinject)
 	if (mptcp_is_data_fin(subskb))
 		mptcp_combine_dfin(subskb, meta_sk, sk);
 =

-	mptcp_save_dss_data_seq(tp, subskb);
+	tcb->mptcp_flags |=3D MPTCPHDR_SEQ;
+
+	tcb->mptcp_data_seq =3D tcb->seq;
 =

 	tcb->seq =3D tp->write_seq;
 =

@@ -490,8 +479,8 @@ static bool mptcp_skb_entail(struct sock *sk, struct sk=
_buff *skb, int reinject)
 		/* Necessary to initialize for tcp_transmit_skb. mss of 1, as
 		 * skb->len =3D 0 will force tso_segs to 1.
 		 */
-		tcp_init_tso_segs(sk, subskb, 1);
-		/* Empty data-fins are sent immediatly on the subflow */
+		tcp_init_tso_segs(subskb, 1);
+		/* Empty data-fins are sent immediately on the subflow */
 		err =3D tcp_transmit_skb(sk, subskb, 1, GFP_ATOMIC);
 =

 		/* It has not been queued, we can free it now. */
@@ -512,7 +501,8 @@ static bool mptcp_skb_entail(struct sock *sk, struct sk=
_buff *skb, int reinject)
 /* Fragment an skb and update the mptcp meta-data. Due to reinject, we
  * might need to undo some operations done by tcp_fragment.
  */
-static int mptcp_fragment(struct sock *meta_sk, struct sk_buff *skb, u32 l=
en,
+static int mptcp_fragment(struct sock *meta_sk, enum tcp_queue tcp_queue,
+			  struct sk_buff *skb, u32 len,
 			  gfp_t gfp, int reinject)
 {
 	int ret, diff, old_factor;
@@ -530,7 +520,7 @@ static int mptcp_fragment(struct sock *meta_sk, struct =
sk_buff *skb, u32 len,
 	 * care about is that it is set to 1 for accurate packets_out
 	 * accounting.
 	 */
-	ret =3D tcp_fragment(meta_sk, skb, len, UINT_MAX, gfp);
+	ret =3D tcp_fragment(meta_sk, tcp_queue, skb, len, UINT_MAX, gfp);
 	if (ret)
 		return ret;
 =

@@ -539,7 +529,7 @@ static int mptcp_fragment(struct sock *meta_sk, struct =
sk_buff *skb, u32 len,
 	flags =3D TCP_SKB_CB(skb)->mptcp_flags;
 	TCP_SKB_CB(skb)->mptcp_flags =3D flags & ~(MPTCPHDR_FIN);
 	TCP_SKB_CB(buff)->mptcp_flags =3D flags;
-	TCP_SKB_CB(buff)->path_mask =3D TCP_SKB_CB(skb)->path_mask;
+	TCP_SKB_CB(buff)->mptcp_path_mask =3D TCP_SKB_CB(skb)->mptcp_path_mask;
 =

 	/* If reinject =3D=3D 1, the buff will be added to the reinject
 	 * queue, which is currently not part of memory accounting. So
@@ -548,13 +538,15 @@ static int mptcp_fragment(struct sock *meta_sk, struc=
t sk_buff *skb, u32 len,
 	 */
 	if (reinject =3D=3D 1) {
 		int undo =3D buff->truesize - diff;
+
 		meta_sk->sk_wmem_queued -=3D undo;
 		sk_mem_uncharge(meta_sk, undo);
 =

 		tcp_sk(meta_sk)->mpcb->reinject_queue.qlen++;
 		meta_sk->sk_write_queue.qlen--;
 =

-		if (!before(tcp_sk(meta_sk)->snd_nxt, TCP_SKB_CB(buff)->end_seq)) {
+		if (!before(tcp_sk(meta_sk)->snd_nxt,
+			    TCP_SKB_CB(buff)->end_seq)) {
 			undo =3D old_factor - tcp_skb_pcount(skb) -
 				tcp_skb_pcount(buff);
 			if (undo)
@@ -566,7 +558,7 @@ static int mptcp_fragment(struct sock *meta_sk, struct =
sk_buff *skb, u32 len,
 }
 =

 /* Inspired by tcp_write_wakeup */
-int mptcp_write_wakeup(struct sock *meta_sk)
+int mptcp_write_wakeup(struct sock *meta_sk, int mib)
 {
 	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
 	struct sk_buff *skb;
@@ -580,8 +572,11 @@ int mptcp_write_wakeup(struct sock *meta_sk)
 	if (skb &&
 	    before(TCP_SKB_CB(skb)->seq, tcp_wnd_end(meta_tp))) {
 		unsigned int mss;
-		unsigned int seg_size =3D tcp_wnd_end(meta_tp) - TCP_SKB_CB(skb)->seq;
-		struct sock *subsk =3D meta_tp->mpcb->sched_ops->get_subflow(meta_sk, sk=
b, true);
+		unsigned int seg_size =3D
+			tcp_wnd_end(meta_tp) - TCP_SKB_CB(skb)->seq;
+		struct sock *subsk =3D
+			meta_tp->mpcb->sched_ops->get_subflow(meta_sk, skb,
+							      true);
 		struct tcp_sock *subtp;
 =

 		WARN_ON(TCP_SKB_CB(skb)->sacked);
@@ -601,58 +596,59 @@ int mptcp_write_wakeup(struct sock *meta_sk)
 		 * but the window size is !=3D 0
 		 * must have been a result SWS avoidance ( sender )
 		 */
-		if (seg_size < TCP_SKB_CB(skb)->end_seq - TCP_SKB_CB(skb)->seq ||
-		    skb->len > mss) {
+		if (seg_size < TCP_SKB_CB(skb)->end_seq -
+			TCP_SKB_CB(skb)->seq || skb->len > mss) {
 			seg_size =3D min(seg_size, mss);
 			TCP_SKB_CB(skb)->tcp_flags |=3D TCPHDR_PSH;
-			if (mptcp_fragment(meta_sk, skb, seg_size,
+			if (mptcp_fragment(meta_sk, TCP_FRAG_IN_WRITE_QUEUE,
+					   skb, seg_size,
 					   GFP_ATOMIC, 0))
 				return -1;
 		} else if (!tcp_skb_pcount(skb)) {
 			/* see mptcp_write_xmit on why we use UINT_MAX */
-			tcp_set_skb_tso_segs(meta_sk, skb, UINT_MAX);
+			mptcp_set_skb_tso_segs(meta_sk, skb, UINT_MAX);
 		}
 =

 		TCP_SKB_CB(skb)->tcp_flags |=3D TCPHDR_PSH;
 		if (!mptcp_skb_entail(subsk, skb, 0))
 			return -1;
-		skb_mstamp_get(&skb->skb_mstamp);
+		/* RCHK Check this is correct */
+		skb->skb_mstamp =3D meta_tp->tcp_mstamp;
 =

 		mptcp_check_sndseq_wrap(meta_tp, TCP_SKB_CB(skb)->end_seq -
 						 TCP_SKB_CB(skb)->seq);
 		tcp_event_new_data_sent(meta_sk, skb);
 =

 		__tcp_push_pending_frames(subsk, mss, TCP_NAGLE_PUSH);
-		meta_tp->lsndtime =3D tcp_time_stamp;
+		meta_tp->lsndtime =3D tcp_jiffies32;
 =

 		return 0;
-	} else {
+	}
 window_probe:
-		if (between(meta_tp->snd_up, meta_tp->snd_una + 1,
-			    meta_tp->snd_una + 0xFFFF)) {
-			mptcp_for_each_sk(meta_tp->mpcb, sk_it) {
-				if (mptcp_sk_can_send_ack(sk_it))
-					tcp_xmit_probe_skb(sk_it, 1);
-			}
+	if (between(meta_tp->snd_up, meta_tp->snd_una + 1,
+		    meta_tp->snd_una + 0xFFFF)) {
+		mptcp_for_each_sk(meta_tp->mpcb, sk_it) {
+			if (mptcp_sk_can_send_ack(sk_it))
+				tcp_xmit_probe_skb(sk_it, 1, mib);
 		}
+	}
 =

-		/* At least one of the tcp_xmit_probe_skb's has to succeed */
-		mptcp_for_each_sk(meta_tp->mpcb, sk_it) {
-			int ret;
+	/* At least one of the tcp_xmit_probe_skb's has to succeed */
+	mptcp_for_each_sk(meta_tp->mpcb, sk_it) {
+		int ret;
 =

-			if (!mptcp_sk_can_send_ack(sk_it))
-				continue;
+		if (!mptcp_sk_can_send_ack(sk_it))
+			continue;
 =

-			ret =3D tcp_xmit_probe_skb(sk_it, 0);
-			if (unlikely(ret > 0))
-				ans =3D ret;
-		}
-		return ans;
+		ret =3D tcp_xmit_probe_skb(sk_it, 0, mib);
+		if (unlikely(ret > 0))
+			ans =3D ret;
 	}
+	return ans;
 }
 =

 bool mptcp_write_xmit(struct sock *meta_sk, unsigned int mss_now, int nona=
gle,
-		     int push_one, gfp_t gfp)
+		      int push_one, gfp_t gfp)
 {
 	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk), *subtp;
 	struct sock *subsk =3D NULL;
@@ -673,8 +669,11 @@ bool mptcp_write_xmit(struct sock *meta_sk, unsigned i=
nt mss_now, int nonagle,
 		mss_now =3D tcp_current_mss(subsk);
 =

 		if (reinject =3D=3D 1) {
-			if (!after(TCP_SKB_CB(skb)->end_seq, meta_tp->snd_una)) {
-				/* Segment already reached the peer, take the next one */
+			if (!after(TCP_SKB_CB(skb)->end_seq,
+				   meta_tp->snd_una)) {
+				/* Segment already reached the peer,
+				 * take the next one
+				 */
 				__skb_unlink(skb, &mpcb->reinject_queue);
 				__kfree_skb(skb);
 				continue;
@@ -697,7 +696,7 @@ bool mptcp_write_xmit(struct sock *meta_sk, unsigned in=
t mss_now, int nonagle,
 		 * we still need an accurate packets_out count in
 		 * tcp_event_new_data_sent.
 		 */
-		tcp_set_skb_tso_segs(meta_sk, skb, UINT_MAX);
+		mptcp_set_skb_tso_segs(meta_sk, skb, UINT_MAX);
 =

 		/* Check for nagle, irregardless of tso_segs. If the segment is
 		 * actually larger than mss_now (TSO segment), then
@@ -735,7 +734,8 @@ bool mptcp_write_xmit(struct sock *meta_sk, unsigned in=
t mss_now, int nonagle,
 			limit =3D min(limit, sublimit);
 =

 		if (skb->len > limit &&
-		    unlikely(mptcp_fragment(meta_sk, skb, limit, gfp, reinject)))
+		    unlikely(mptcp_fragment(meta_sk, TCP_FRAG_IN_WRITE_QUEUE,
+					    skb, limit, gfp, reinject)))
 			break;
 =

 		if (!mptcp_skb_entail(subsk, skb, reinject))
@@ -744,10 +744,11 @@ bool mptcp_write_xmit(struct sock *meta_sk, unsigned =
int mss_now, int nonagle,
 		 * always push on the subflow
 		 */
 		__tcp_push_pending_frames(subsk, mss_now, TCP_NAGLE_PUSH);
-		meta_tp->lsndtime =3D tcp_time_stamp;
+		meta_tp->lsndtime =3D tcp_jiffies32;
 =

 		path_mask |=3D mptcp_pi_to_flag(subtp->mptcp->path_index);
-		skb_mstamp_get(&skb->skb_mstamp);
+		/* RCHK Check this is correct */
+		skb->skb_mstamp =3D meta_tp->tcp_mstamp;
 =

 		if (!reinject) {
 			mptcp_check_sndseq_wrap(meta_tp,
@@ -806,8 +807,7 @@ u32 __mptcp_select_window(struct sock *sk)
 	 */
 	mss =3D icsk->icsk_ack.rcv_mss;
 	free_space =3D tcp_space(meta_sk);
-	full_space =3D min_t(int, meta_tp->window_clamp,
-			tcp_full_space(meta_sk));
+	full_space =3D min_t(int, meta_tp->window_clamp, tcp_full_space(meta_sk));
 =

 	if (mss > full_space)
 		mss =3D full_space;
@@ -816,7 +816,8 @@ u32 __mptcp_select_window(struct sock *sk)
 		/* If free_space is decreasing due to mostly meta-level
 		 * out-of-order packets, don't turn off the quick-ack mode.
 		 */
-		if (meta_tp->rcv_nxt - meta_tp->copied_seq > ((full_space - free_space) =
>> 1))
+		if (meta_tp->rcv_nxt - meta_tp->copied_seq >
+		    ((full_space - free_space) >> 1))
 			icsk->icsk_ack.quick =3D 0;
 =

 		if (tcp_memory_pressure)
@@ -844,8 +845,8 @@ u32 __mptcp_select_window(struct sock *sk)
 		 * Import case: prevent zero window announcement if
 		 * 1<<rcv_wscale > mss.
 		 */
-		if (((window >> tp->rx_opt.rcv_wscale) << tp->
-		     rx_opt.rcv_wscale) !=3D window)
+		if (((window >> tp->rx_opt.rcv_wscale) <<
+		    tp->rx_opt.rcv_wscale) !=3D window)
 			window =3D (((window >> tp->rx_opt.rcv_wscale) + 1)
 				  << tp->rx_opt.rcv_wscale);
 	} else {
@@ -868,7 +869,7 @@ u32 __mptcp_select_window(struct sock *sk)
 }
 =

 void mptcp_syn_options(const struct sock *sk, struct tcp_out_options *opts,
-		       unsigned *remaining)
+		       unsigned int *size)
 {
 	const struct tcp_sock *tp =3D tcp_sk(sk);
 =

@@ -876,14 +877,14 @@ void mptcp_syn_options(const struct sock *sk, struct =
tcp_out_options *opts,
 	if (is_master_tp(tp)) {
 		opts->mptcp_options |=3D OPTION_MP_CAPABLE | OPTION_TYPE_SYN;
 		opts->mptcp_ver =3D tcp_sk(sk)->mptcp_ver;
-		*remaining -=3D MPTCP_SUB_LEN_CAPABLE_SYN_ALIGN;
+		*size +=3D MPTCP_SUB_LEN_CAPABLE_SYN_ALIGN;
 		opts->mp_capable.sender_key =3D tp->mptcp_loc_key;
 		opts->dss_csum =3D !!sysctl_mptcp_checksum;
 	} else {
 		const struct mptcp_cb *mpcb =3D tp->mpcb;
 =

 		opts->mptcp_options |=3D OPTION_MP_JOIN | OPTION_TYPE_SYN;
-		*remaining -=3D MPTCP_SUB_LEN_JOIN_SYN_ALIGN;
+		*size +=3D MPTCP_SUB_LEN_JOIN_SYN_ALIGN;
 		opts->mp_join_syns.token =3D mpcb->mptcp_rem_token;
 		opts->mp_join_syns.low_prio  =3D tp->mptcp->low_prio;
 		opts->addr_id =3D tp->mptcp->loc_id;
@@ -892,9 +893,10 @@ void mptcp_syn_options(const struct sock *sk, struct t=
cp_out_options *opts,
 }
 =

 void mptcp_synack_options(struct request_sock *req,
-			  struct tcp_out_options *opts, unsigned *remaining)
+			  struct tcp_out_options *opts, unsigned int *size)
 {
 	struct mptcp_request_sock *mtreq;
+
 	mtreq =3D mptcp_rsk(req);
 =

 	opts->options |=3D OPTION_MPTCP;
@@ -904,7 +906,7 @@ void mptcp_synack_options(struct request_sock *req,
 		opts->mptcp_ver =3D mtreq->mptcp_ver;
 		opts->mp_capable.sender_key =3D mtreq->mptcp_loc_key;
 		opts->dss_csum =3D !!sysctl_mptcp_checksum || mtreq->dss_csum;
-		*remaining -=3D MPTCP_SUB_LEN_CAPABLE_SYN_ALIGN;
+		*size +=3D MPTCP_SUB_LEN_CAPABLE_SYN_ALIGN;
 	} else {
 		opts->mptcp_options |=3D OPTION_MP_JOIN | OPTION_TYPE_SYNACK;
 		opts->mp_join_syns.sender_truncated_mac =3D
@@ -912,12 +914,12 @@ void mptcp_synack_options(struct request_sock *req,
 		opts->mp_join_syns.sender_nonce =3D mtreq->mptcp_loc_nonce;
 		opts->mp_join_syns.low_prio =3D mtreq->low_prio;
 		opts->addr_id =3D mtreq->loc_id;
-		*remaining -=3D MPTCP_SUB_LEN_JOIN_SYNACK_ALIGN;
+		*size +=3D MPTCP_SUB_LEN_JOIN_SYNACK_ALIGN;
 	}
 }
 =

 void mptcp_established_options(struct sock *sk, struct sk_buff *skb,
-			       struct tcp_out_options *opts, unsigned *size)
+			       struct tcp_out_options *opts, unsigned int *size)
 {
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	struct mptcp_cb *mpcb =3D tp->mpcb;
@@ -927,6 +929,7 @@ void mptcp_established_options(struct sock *sk, struct =
sk_buff *skb,
 	 * It does not make sense to check for the options, because when the
 	 * segment gets sent, another subflow will be chosen.
 	 */
+	/* tp->mptcp gets set in mptcp_add_sock() */
 	if (!skb && is_meta_sk(sk))
 		return;
 =

@@ -965,12 +968,13 @@ void mptcp_established_options(struct sock *sk, struc=
t sk_buff *skb,
 	 *       (even if it's very unlikely)
 	 */
 	if (unlikely(mpcb->infinite_mapping_snd) &&
-	    ((mpcb->send_infinite_mapping && tcb &&
+	    ((mpcb->send_infinite_mapping && tcb && skb &&
 	      mptcp_is_data_seq(skb) &&
-	      !(tcb->mptcp_flags & MPTCPHDR_INF) &&
+	      !(TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_INF) &&
 	      !before(tcb->seq, tp->mptcp->infinite_cutoff_seq)) ||
-	     !mpcb->send_infinite_mapping))
+	     !mpcb->send_infinite_mapping)) {
 		return;
+	}
 =

 	if (unlikely(tp->mptcp->include_mpc)) {
 		opts->options |=3D OPTION_MPTCP;
@@ -992,12 +996,14 @@ void mptcp_established_options(struct sock *sk, struc=
t sk_buff *skb,
 	}
 =

 	if (unlikely(mpcb->addr_signal) && mpcb->pm_ops->addr_signal &&
-	    mpcb->mptcp_ver >=3D MPTCP_VERSION_1 && skb && !mptcp_is_data_seq(skb=
)) {
+	    mpcb->mptcp_ver >=3D MPTCP_VERSION_1 && skb &&
+	    !mptcp_is_data_seq(skb)) {
 		mpcb->pm_ops->addr_signal(sk, size, opts, skb);
 =

-		if (opts->add_addr_v6)
+		if (opts->add_addr_v6) {
 			/* Skip subsequent options */
 			return;
+		}
 	}
 =

 	if (!tp->mptcp->include_mpc && !tp->mptcp->pre_established) {
@@ -1031,8 +1037,6 @@ void mptcp_established_options(struct sock *sk, struc=
t sk_buff *skb,
 			tp->mptcp->send_mp_prio =3D 0;
 		*size +=3D MPTCP_SUB_LEN_PRIO_ALIGN;
 	}
-
-	return;
 }
 =

 u16 mptcp_select_window(struct sock *sk)
@@ -1047,10 +1051,19 @@ u16 mptcp_select_window(struct sock *sk)
 	return new_win;
 }
 =

-void mptcp_options_write(__be32 *ptr, struct tcp_sock *tp,
-			 const struct tcp_out_options *opts,
+void mptcp_options_write(__be32 **ptr_ptr, struct tcp_sock *tp,
+			 struct tcp_out_options *opts,
 			 struct sk_buff *skb)
 {
+	__be32 *ptr;
+	__be32 *orig;
+
+	orig =3D *ptr_ptr;
+
+	tcp_options_write(ptr_ptr, tp, opts, skb);
+	if (!(OPTION_MPTCP & opts->options))
+		return;
+	ptr =3D *ptr_ptr;
 	if (unlikely(OPTION_MP_CAPABLE & opts->mptcp_options)) {
 		struct mp_capable *mpc =3D (struct mp_capable *)ptr;
 =

@@ -1141,7 +1154,8 @@ void mptcp_options_write(__be32 *ptr, struct tcp_sock=
 *tp,
 			}
 		}
 =

-		MPTCP_INC_STATS_BH(sock_net((struct sock *)tp), MPTCP_MIB_ADDADDRTX);
+		MPTCP_INC_STATS_BH(sock_net((struct sock *)tp),
+				   MPTCP_MIB_ADDADDRTX);
 	}
 	if (unlikely(OPTION_REMOVE_ADDR & opts->mptcp_options)) {
 		struct mp_remove_addr *mprem =3D (struct mp_remove_addr *)ptr;
@@ -1163,13 +1177,15 @@ void mptcp_options_write(__be32 *ptr, struct tcp_so=
ck *tp,
 		/* Fill the rest with NOP's */
 		if (len_align > len) {
 			int i;
+
 			for (i =3D 0; i < len_align - len; i++)
 				*(addrs_id++) =3D TCPOPT_NOP;
 		}
 =

 		ptr +=3D len_align >> 2;
 =

-		MPTCP_INC_STATS_BH(sock_net((struct sock *)tp), MPTCP_MIB_REMADDRTX);
+		MPTCP_INC_STATS_BH(sock_net((struct sock *)tp),
+				   MPTCP_MIB_REMADDRTX);
 	}
 	if (unlikely(OPTION_MP_FAIL & opts->mptcp_options)) {
 		struct mp_fail *mpfail =3D (struct mp_fail *)ptr;
@@ -1197,11 +1213,11 @@ void mptcp_options_write(__be32 *ptr, struct tcp_so=
ck *tp,
 	}
 =

 	if (OPTION_DATA_ACK & opts->mptcp_options) {
-		if (!mptcp_is_data_seq(skb))
-			ptr +=3D mptcp_write_dss_data_ack(tp, skb, ptr);
-		else
-			ptr +=3D mptcp_write_dss_data_seq(tp, skb, ptr);
+		ptr +=3D mptcp_write_dss_data_ack(tp, skb, ptr);
+		if (mptcp_is_data_seq(skb))
+			ptr +=3D mptcp_write_dss_mapping(tp, skb, ptr);
 	}
+
 	if (unlikely(OPTION_MP_PRIO & opts->mptcp_options)) {
 		struct mp_prio *mpprio =3D (struct mp_prio *)ptr;
 =

@@ -1214,6 +1230,7 @@ void mptcp_options_write(__be32 *ptr, struct tcp_sock=
 *tp,
 =

 		ptr +=3D MPTCP_SUB_LEN_PRIO_ALIGN >> 2;
 	}
+	*ptr_ptr =3D ptr;
 }
 =

 /* Sends the datafin */
@@ -1232,7 +1249,7 @@ void mptcp_send_fin(struct sock *meta_sk)
 	 */
 	mss_now =3D mptcp_current_mss(meta_sk);
 =

-	if (tcp_send_head(meta_sk) !=3D NULL) {
+	if (tcp_send_head(meta_sk)) {
 		TCP_SKB_CB(skb)->mptcp_flags |=3D MPTCPHDR_FIN;
 		TCP_SKB_CB(skb)->end_seq++;
 		meta_tp->write_seq++;
@@ -1245,6 +1262,7 @@ void mptcp_send_fin(struct sock *meta_sk)
 				break;
 			yield();
 		}
+		INIT_LIST_HEAD(&skb->tcp_tsorted_anchor);
 		/* Reserve space for headers and prepare control bits. */
 		skb_reserve(skb, MAX_TCP_HEADER);
 =

@@ -1275,7 +1293,6 @@ void mptcp_send_active_reset(struct sock *meta_sk, gf=
p_t priority)
 	 */
 	if (!sk || mpcb->infinite_mapping_snd || mpcb->send_infinite_mapping ||
 	    mpcb->infinite_mapping_rcv) {
-
 		/* tcp_done must be handled with bh disabled */
 		if (!in_serving_softirq())
 			local_bh_disable();
@@ -1287,7 +1304,6 @@ void mptcp_send_active_reset(struct sock *meta_sk, gf=
p_t priority)
 		return;
 	}
 =

-
 	tcp_sk(sk)->send_mp_fclose =3D 1;
 	/** Reset all other subflows */
 =

@@ -1295,7 +1311,9 @@ void mptcp_send_active_reset(struct sock *meta_sk, gf=
p_t priority)
 	if (!in_serving_softirq())
 		local_bh_disable();
 =

-	mptcp_sub_force_close_all(mpcb, sk);
+	/* RCHK Fix me ?
+	 *	mptcp_sub_force_close_all(mpcb, sk);
+	 */
 =

 	tcp_set_state(sk, TCP_RST_WAIT);
 =

@@ -1316,23 +1334,24 @@ static void mptcp_ack_retransmit_timer(struct sock =
*sk)
 	struct sk_buff *skb;
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	struct inet_connection_sock *icsk =3D inet_csk(sk);
+	struct net *net =3D sock_net(sk);
 =

 	if (inet_csk(sk)->icsk_af_ops->rebuild_header(sk))
 		goto out; /* Routing failure or similar */
 =

 	if (!tp->retrans_stamp)
-		tp->retrans_stamp =3D tcp_time_stamp ? : 1;
+		tp->retrans_stamp =3D tcp_jiffies32 ? : 1;
 =

 	if (tcp_write_timeout(sk)) {
 		MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_JOINACKRTO);
 		tp->mptcp->pre_established =3D 0;
 		sk_stop_timer(sk, &tp->mptcp->mptcp_ack_timer);
-		tp->ops->send_active_reset(sk, GFP_ATOMIC);
+		tp->op_ops->send_active_reset(sk, GFP_ATOMIC);
 		goto out;
 	}
 =

 	skb =3D alloc_skb(MAX_TCP_HEADER, GFP_ATOMIC);
-	if (skb =3D=3D NULL) {
+	if (!skb) {
 		sk_reset_timer(sk, &tp->mptcp->mptcp_ack_timer,
 			       jiffies + icsk->icsk_rto);
 		return;
@@ -1355,21 +1374,22 @@ static void mptcp_ack_retransmit_timer(struct sock =
*sk)
 		return;
 	}
 =

-
 	icsk->icsk_retransmits++;
 	icsk->icsk_rto =3D min(icsk->icsk_rto << 1, TCP_RTO_MAX);
 	sk_reset_timer(sk, &tp->mptcp->mptcp_ack_timer,
 		       jiffies + icsk->icsk_rto);
-	if (retransmits_timed_out(sk, sysctl_tcp_retries1 + 1, 0, 0))
+	if (retransmits_timed_out(sk, net->ipv4.sysctl_tcp_retries1 + 1, 0))
 		__sk_dst_reset(sk);
 =

 out:;
 }
 =

-void mptcp_ack_handler(unsigned long data)
+void mptcp_ack_handler(struct timer_list *t)
 {
-	struct sock *sk =3D (struct sock *)data;
-	struct sock *meta_sk =3D mptcp_meta_sk(sk);
+	struct mptcp_tcp_sock *mptcp =3D from_timer(mptcp, t, mptcp_ack_timer);
+	struct tcp_sock *tp =3D mptcp->tp;
+	struct sock *sk =3D (struct sock *)tp;
+	struct sock *meta_sk =3D tp->meta_sk;
 =

 	bh_lock_sock(meta_sk);
 	if (sock_owned_by_user(meta_sk)) {
@@ -1412,8 +1432,9 @@ int mptcp_retransmit_skb(struct sock *meta_sk, struct=
 sk_buff *skb)
 	 *
 	 * This is a meta-retransmission thus we check on the meta-socket.
 	 */
-	if (atomic_read(&meta_sk->sk_wmem_alloc) >
-	    min(meta_sk->sk_wmem_queued + (meta_sk->sk_wmem_queued >> 2), meta_sk=
->sk_sndbuf)) {
+	if (refcount_read(&meta_sk->sk_wmem_alloc) >
+	    min(meta_sk->sk_wmem_queued + (meta_sk->sk_wmem_queued >> 2),
+		meta_sk->sk_sndbuf)) {
 		return -EAGAIN;
 	}
 =

@@ -1452,13 +1473,14 @@ int mptcp_retransmit_skb(struct sock *meta_sk, stru=
ct sk_buff *skb)
 					    TCP_NAGLE_OFF);
 =

 	if (skb->len > limit &&
-	    unlikely(mptcp_fragment(meta_sk, skb, limit,
+	    unlikely(mptcp_fragment(meta_sk, TCP_FRAG_IN_RTX_QUEUE, skb, limit,
 				    GFP_ATOMIC, 0)))
 		goto failed;
 =

 	if (!mptcp_skb_entail(subsk, skb, -1))
 		goto failed;
-	skb_mstamp_get(&skb->skb_mstamp);
+	/* RCHK Check this is correct */
+	skb->skb_mstamp =3D meta_tp->tcp_mstamp;
 =

 	/* Update global TCP statistics. */
 	MPTCP_INC_STATS_BH(sock_net(meta_sk), MPTCP_MIB_RETRANSSEGS);
@@ -1470,12 +1492,12 @@ int mptcp_retransmit_skb(struct sock *meta_sk, stru=
ct sk_buff *skb)
 		meta_tp->retrans_stamp =3D tcp_skb_timestamp(skb);
 =

 	__tcp_push_pending_frames(subsk, mss_now, TCP_NAGLE_PUSH);
-	meta_tp->lsndtime =3D tcp_time_stamp;
+	meta_tp->lsndtime =3D tcp_jiffies32;
 =

 	return 0;
 =

 failed:
-	NET_INC_STATS_BH(sock_net(meta_sk), LINUX_MIB_TCPRETRANSFAIL);
+	__NET_INC_STATS(sock_net(meta_sk), LINUX_MIB_TCPRETRANSFAIL);
 	return err;
 }
 =

@@ -1488,15 +1510,15 @@ void mptcp_meta_retransmit_timer(struct sock *meta_=
sk)
 {
 	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
 	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
+	struct net *net =3D sock_net(meta_sk);
 	struct inet_connection_sock *meta_icsk =3D inet_csk(meta_sk);
 	int err;
 =

 	/* In fallback, retransmission is handled at the subflow-level */
-	if (!meta_tp->packets_out || mpcb->infinite_mapping_snd)
+	if (!meta_tp->packets_out || mpcb->infinite_mapping_snd ||
+	    tcp_rtx_queue_empty(meta_sk))
 		return;
 =

-	WARN_ON(tcp_write_queue_empty(meta_sk));
-
 	if (!meta_tp->snd_wnd && !sock_flag(meta_sk, SOCK_DEAD) &&
 	    !((1 << meta_sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))) {
 		/* Receiver dastardly shrinks window. Our retransmits
@@ -1505,11 +1527,13 @@ void mptcp_meta_retransmit_timer(struct sock *meta_=
sk)
 		 * we cannot allow such beasts to hang infinitely.
 		 */
 		struct inet_sock *meta_inet =3D inet_sk(meta_sk);
+
 		if (meta_sk->sk_family =3D=3D AF_INET) {
 			net_dbg_ratelimited("MPTCP: Peer %pI4:%u/%u unexpectedly shrunk window =
%u:%u (repaired)\n",
 					    &meta_inet->inet_daddr,
 					    ntohs(meta_inet->inet_dport),
-					    meta_inet->inet_num, meta_tp->snd_una,
+					    meta_inet->inet_num,
+					    meta_tp->snd_una,
 					    meta_tp->snd_nxt);
 		}
 #if IS_ENABLED(CONFIG_IPV6)
@@ -1517,16 +1541,17 @@ void mptcp_meta_retransmit_timer(struct sock *meta_=
sk)
 			net_dbg_ratelimited("MPTCP: Peer %pI6:%u/%u unexpectedly shrunk window =
%u:%u (repaired)\n",
 					    &meta_sk->sk_v6_daddr,
 					    ntohs(meta_inet->inet_dport),
-					    meta_inet->inet_num, meta_tp->snd_una,
+					    meta_inet->inet_num,
+					    meta_tp->snd_una,
 					    meta_tp->snd_nxt);
 		}
 #endif
-		if (tcp_time_stamp - meta_tp->rcv_tstamp > TCP_RTO_MAX) {
+		if (tcp_jiffies32 - meta_tp->rcv_tstamp > TCP_RTO_MAX) {
 			tcp_write_err(meta_sk);
 			return;
 		}
 =

-		mptcp_retransmit_skb(meta_sk, tcp_write_queue_head(meta_sk));
+		mptcp_retransmit_skb(meta_sk, tcp_rtx_queue_head(meta_sk));
 		goto out_reset_timer;
 	}
 =

@@ -1534,11 +1559,11 @@ void mptcp_meta_retransmit_timer(struct sock *meta_=
sk)
 		return;
 =

 	if (meta_icsk->icsk_retransmits =3D=3D 0)
-		NET_INC_STATS_BH(sock_net(meta_sk), LINUX_MIB_TCPTIMEOUTS);
+		__NET_INC_STATS(net, LINUX_MIB_TCPTIMEOUTS);
 =

 	meta_icsk->icsk_ca_state =3D TCP_CA_Loss;
 =

-	err =3D mptcp_retransmit_skb(meta_sk, tcp_write_queue_head(meta_sk));
+	err =3D mptcp_retransmit_skb(meta_sk, tcp_rtx_queue_head(meta_sk));
 	if (err > 0) {
 		/* Retransmission failed because of local congestion,
 		 * do not backoff.
@@ -1546,8 +1571,9 @@ void mptcp_meta_retransmit_timer(struct sock *meta_sk)
 		if (!meta_icsk->icsk_retransmits)
 			meta_icsk->icsk_retransmits =3D 1;
 		inet_csk_reset_xmit_timer(meta_sk, ICSK_TIME_RETRANS,
-					  min(meta_icsk->icsk_rto, TCP_RESOURCE_PROBE_INTERVAL),
-					  TCP_RTO_MAX);
+					  min(meta_icsk->icsk_rto,
+					      TCP_RESOURCE_PROBE_INTERVAL),
+					      TCP_RTO_MAX);
 		return;
 	}
 =

@@ -1580,7 +1606,7 @@ out_reset_timer:
 	 * linear-timeout retransmissions into a black hole
 	 */
 	if (meta_sk->sk_state =3D=3D TCP_ESTABLISHED &&
-	    (meta_tp->thin_lto || sysctl_tcp_thin_linear_timeouts) &&
+	    (meta_tp->thin_lto || net->ipv4.sysctl_tcp_thin_linear_timeouts) &&
 	    tcp_stream_is_thin(meta_tp) &&
 	    meta_icsk->icsk_retransmits <=3D TCP_THIN_LINEAR_RETRIES) {
 		meta_icsk->icsk_backoff =3D 0;
@@ -1590,17 +1616,23 @@ out_reset_timer:
 		mptcp_set_rto(meta_sk);
 	} else {
 		/* Use normal (exponential) backoff */
-		meta_icsk->icsk_rto =3D min(meta_icsk->icsk_rto << 1, TCP_RTO_MAX);
+		meta_icsk->icsk_rto =3D
+			min(meta_icsk->icsk_rto << 1, TCP_RTO_MAX);
 	}
-	inet_csk_reset_xmit_timer(meta_sk, ICSK_TIME_RETRANS, meta_icsk->icsk_rto=
, TCP_RTO_MAX);
-
-	return;
+	inet_csk_reset_xmit_timer(meta_sk, ICSK_TIME_RETRANS,
+				  meta_icsk->icsk_rto, TCP_RTO_MAX);
 }
 =

 void mptcp_sub_retransmit_timer(struct sock *sk)
 {
 	struct tcp_sock *tp =3D tcp_sk(sk);
 =

+	/* RCHK Fixme -- I should not be here */
+	if (tcp_rtx_queue_empty(sk)) {
+		WARN_ON(printk("%s: tcp_rtx_queue_empty\n", __func__));
+		return;
+	}
+
 	tcp_retransmit_timer(sk);
 =

 	if (!tp->fastopen_rsk) {
@@ -1610,18 +1642,18 @@ void mptcp_sub_retransmit_timer(struct sock *sk)
 }
 =

 /* Modify values to an mptcp-level for the initial window of new subflows =
*/
-void mptcp_select_initial_window(int __space, __u32 mss, __u32 *rcv_wnd,
-				__u32 *window_clamp, int wscale_ok,
-				__u8 *rcv_wscale, __u32 init_rcv_wnd,
-				 const struct sock *sk)
+void mptcp_select_initial_window(const struct sock *sk, int __space,
+				 __u32 mss, __u32 *rcv_wnd,
+				 __u32 *window_clamp, int wscale_ok,
+				 __u8 *rcv_wscale, __u32 init_rcv_wnd)
 {
 	struct mptcp_cb *mpcb =3D tcp_sk(sk)->mpcb;
 =

 	*window_clamp =3D mpcb->orig_window_clamp;
-	__space =3D tcp_win_from_space(mpcb->orig_sk_rcvbuf);
+	__space =3D tcp_win_from_space(sk, mpcb->orig_sk_rcvbuf);
 =

-	tcp_select_initial_window(__space, mss, rcv_wnd, window_clamp,
-				  wscale_ok, rcv_wscale, init_rcv_wnd, sk);
+	tcp_select_initial_window(sk, __space, mss, rcv_wnd, window_clamp,
+				  wscale_ok, rcv_wscale, init_rcv_wnd);
 }
 =

 static inline u64 mptcp_calc_rate(const struct sock *meta_sk, unsigned int=
 mss,
@@ -1647,7 +1679,7 @@ static inline u64 mptcp_calc_rate(const struct sock *=
meta_sk, unsigned int mss,
 		this_mss =3D mss_cb(sk);
 =

 		/* If this_mss is smaller than mss, it means that a segment will
-		 * be splitted in two (or more) when pushed on this subflow. If
+		 * be split in two (or more) when pushed on this subflow. If
 		 * you consider that mss =3D 1428 and this_mss =3D 1420 then two
 		 * segments will be generated: a 1420-byte and 8-byte segment.
 		 * The latter will introduce a large overhead as for a single
@@ -1727,8 +1759,10 @@ static unsigned int mptcp_select_size_mss(struct soc=
k *sk)
 	return tcp_sk(sk)->mss_cache;
 }
 =

-int mptcp_select_size(const struct sock *meta_sk, bool sg)
+int mptcp_select_size(const struct sock *meta_sk, bool sg,
+		      bool first_skb, bool zc)
 {
+	/* RCHK This has changed -- fix it */
 	unsigned int mss =3D __mptcp_current_mss(meta_sk, mptcp_select_size_mss);
 =

 	if (sg) {
@@ -1764,7 +1798,7 @@ int mptcp_check_snd_buf(const struct tcp_sock *tp)
 	}
 =

 	bw_est =3D div64_u64(((u64)tp->snd_cwnd * rtt_max) << 16,
-				(u64)tp->srtt_us);
+			   (u64)tp->srtt_us);
 =

 	return max_t(unsigned int, (u32)(bw_est >> 16),
 			tp->reordering + 1);
@@ -1792,3 +1826,12 @@ unsigned int mptcp_xmit_size_goal(const struct sock =
*meta_sk, u32 mss_now,
 	return max(xmit_size_goal, mss_now);
 }
 =

+void mptcp_retrans_try_collapse(struct sock *sk, struct sk_buff *to, int s=
pace)
+{
+}
+
+int mptcp_mtu_probe(struct sock *sk)
+{
+	/* Probing not supported */
+	return -1;
+}
diff --git a/net/mptcp/mptcp_redundant.c b/net/mptcp/mptcp_redundant.c
index 8fa2dba..37a13f4 100644
--- a/net/mptcp/mptcp_redundant.c
+++ b/net/mptcp/mptcp_redundant.c
@@ -72,10 +72,10 @@ static bool redsched_use_subflow(struct sock *meta_sk,
 	if (!skb || !mptcp_is_available((struct sock *)tp, skb, false))
 		return false;
 =

-	if (TCP_SKB_CB(skb)->path_mask !=3D 0)
+	if (TCP_SKB_CB(skb)->mptcp_path_mask !=3D 0)
 		return subflow_is_active(tp);
 =

-	if (TCP_SKB_CB(skb)->path_mask =3D=3D 0) {
+	if (TCP_SKB_CB(skb)->mptcp_path_mask =3D=3D 0) {
 		if (active_valid_sks =3D=3D -1)
 			active_valid_sks =3D redsched_get_active_valid_sks(meta_sk);
 =

@@ -209,7 +209,7 @@ static struct sk_buff *redundant_next_segment(struct so=
ck *meta_sk,
 			cb_data->next_subflow =3D tp->mptcp->next;
 			*subsk =3D (struct sock *)tp;
 =

-			if (TCP_SKB_CB(skb)->path_mask)
+			if (TCP_SKB_CB(skb)->mptcp_path_mask)
 				*reinject =3D -1;
 			return skb;
 		}
diff --git a/net/mptcp/mptcp_rr.c b/net/mptcp/mptcp_rr.c
index 8910ba9..83837f2 100644
--- a/net/mptcp/mptcp_rr.c
+++ b/net/mptcp/mptcp_rr.c
@@ -93,7 +93,7 @@ static int mptcp_rr_dont_reinject_skb(const struct tcp_so=
ck *tp, const struct sk
 	 */
 	return skb &&
 		/* Has the skb already been enqueued into this subsocket? */
-		mptcp_pi_to_flag(tp->mptcp->path_index) & TCP_SKB_CB(skb)->path_mask;
+		mptcp_pi_to_flag(tp->mptcp->path_index) & TCP_SKB_CB(skb)->mptcp_path_ma=
sk;
 }
 =

 /* We just look for any subflow that is available */
@@ -136,7 +136,7 @@ static struct sock *rr_get_available_subflow(struct soc=
k *meta_sk,
 		 * chance again by restarting its pathmask.
 		 */
 		if (skb)
-			TCP_SKB_CB(skb)->path_mask =3D 0;
+			TCP_SKB_CB(skb)->mptcp_path_mask =3D 0;
 		sk =3D backupsk;
 	}
 =

diff --git a/net/mptcp/mptcp_sched.c b/net/mptcp/mptcp_sched.c
index 54408ff..0d45296 100644
--- a/net/mptcp/mptcp_sched.c
+++ b/net/mptcp/mptcp_sched.c
@@ -53,7 +53,7 @@ static bool mptcp_is_temp_unavailable(struct sock *sk,
 		 * Thus, snd_una can never go beyond high_seq.
 		 */
 		if (!tcp_is_reno(tp))
-			return true;
+			return(true);
 		else if (tp->snd_una !=3D tp->high_seq)
 			return true;
 	}
@@ -68,7 +68,7 @@ static bool mptcp_is_temp_unavailable(struct sock *sk,
 	/* If TSQ is already throttling us, do not send on this subflow. When
 	 * TSQ gets cleared the subflow becomes eligible again.
 	 */
-	if (test_bit(TSQ_THROTTLED, &tp->tsq_flags))
+	if (test_bit(TSQF_THROTTLED, &sk->sk_tsq_flags))
 		return true;
 =

 	in_flight =3D tcp_packets_in_flight(tp);
@@ -111,14 +111,16 @@ bool mptcp_is_available(struct sock *sk, const struct=
 sk_buff *skb,
 EXPORT_SYMBOL_GPL(mptcp_is_available);
 =

 /* Are we not allowed to reinject this skb on tp? */
-static int mptcp_dont_reinject_skb(const struct tcp_sock *tp, const struct=
 sk_buff *skb)
+static int mptcp_dont_reinject_skb(const struct tcp_sock *tp,
+				   const struct sk_buff *skb)
 {
 	/* If the skb has already been enqueued in this sk, try to find
 	 * another one.
 	 */
 	return skb &&
 		/* Has the skb already been enqueued into this subsocket? */
-		mptcp_pi_to_flag(tp->mptcp->path_index) & TCP_SKB_CB(skb)->path_mask;
+		mptcp_pi_to_flag(tp->mptcp->path_index) &
+		TCP_SKB_CB(skb)->mptcp_path_mask;
 }
 =

 bool subflow_is_backup(const struct tcp_sock *tp)
@@ -237,7 +239,8 @@ struct sock *get_available_subflow(struct sock *meta_sk=
, struct sk_buff *skb,
 	if (meta_sk->sk_shutdown & RCV_SHUTDOWN &&
 	    skb && mptcp_is_data_fin(skb)) {
 		mptcp_for_each_sk(mpcb, sk) {
-			if (tcp_sk(sk)->mptcp->path_index =3D=3D mpcb->dfin_path_index &&
+			if (tcp_sk(sk)->mptcp->path_index =3D=3D
+			    mpcb->dfin_path_index &&
 			    mptcp_is_available(sk, skb, zero_wnd_test))
 				return sk;
 		}
@@ -261,7 +264,7 @@ struct sock *get_available_subflow(struct sock *meta_sk=
, struct sk_buff *skb,
 		 * the skb passed through all the available active and backups
 		 * sks, so clean the path mask
 		 */
-		TCP_SKB_CB(skb)->path_mask =3D 0;
+		TCP_SKB_CB(skb)->mptcp_path_mask =3D 0;
 	return sk;
 }
 EXPORT_SYMBOL_GPL(get_available_subflow);
@@ -292,23 +295,29 @@ static struct sk_buff *mptcp_rcv_buf_optimization(str=
uct sock *sk, int penal)
 		goto retrans;
 =

 	/* Only penalize again after an RTT has elapsed */
-	if (tcp_time_stamp - dsp->last_rbuf_opti < usecs_to_jiffies(tp->srtt_us >=
> 3))
+	if (tcp_time_stamp(tp) - dsp->last_rbuf_opti <
+	    usecs_to_jiffies(tp->srtt_us >> 3))
 		goto retrans;
 =

 	/* Half the cwnd of the slow flow */
 	mptcp_for_each_tp(tp->mpcb, tp_it) {
 		if (tp_it !=3D tp &&
-		    TCP_SKB_CB(skb_head)->path_mask & mptcp_pi_to_flag(tp_it->mptcp->pat=
h_index)) {
-			if (tp->srtt_us < tp_it->srtt_us && inet_csk((struct sock *)tp_it)->ics=
k_ca_state =3D=3D TCP_CA_Open) {
+		    TCP_SKB_CB(skb_head)->mptcp_path_mask &
+		    mptcp_pi_to_flag(tp_it->mptcp->path_index)) {
+			if (tp->srtt_us < tp_it->srtt_us &&
+			    inet_csk((struct sock *)tp_it)->icsk_ca_state =3D=3D
+				     TCP_CA_Open) {
 				u32 prior_cwnd =3D tp_it->snd_cwnd;
 =

-				tp_it->snd_cwnd =3D max(tp_it->snd_cwnd >> 1U, 1U);
+				tp_it->snd_cwnd =3D
+				    max(tp_it->snd_cwnd >> 1U, 1U);
 =

-				/* If in slow start, do not reduce the ssthresh */
+				/* If in slow start, do not reduce ssthresh */
 				if (prior_cwnd >=3D tp_it->snd_ssthresh)
-					tp_it->snd_ssthresh =3D max(tp_it->snd_ssthresh >> 1U, 2U);
+					tp_it->snd_ssthresh =3D
+					max(tp_it->snd_ssthresh >> 1U, 2U);
 =

-				dsp->last_rbuf_opti =3D tcp_time_stamp;
+				dsp->last_rbuf_opti =3D tcp_time_stamp(tp_it);
 			}
 			break;
 		}
@@ -317,11 +326,14 @@ static struct sk_buff *mptcp_rcv_buf_optimization(str=
uct sock *sk, int penal)
 retrans:
 =

 	/* Segment not yet injected into this path? Take it!!! */
-	if (!(TCP_SKB_CB(skb_head)->path_mask & mptcp_pi_to_flag(tp->mptcp->path_=
index))) {
+	if (!(TCP_SKB_CB(skb_head)->mptcp_path_mask &
+	    mptcp_pi_to_flag(tp->mptcp->path_index))) {
 		bool do_retrans =3D false;
+
 		mptcp_for_each_tp(tp->mpcb, tp_it) {
 			if (tp_it !=3D tp &&
-			    TCP_SKB_CB(skb_head)->path_mask & mptcp_pi_to_flag(tp_it->mptcp->pa=
th_index)) {
+			    TCP_SKB_CB(skb_head)->mptcp_path_mask &
+			    mptcp_pi_to_flag(tp_it->mptcp->path_index)) {
 				if (tp_it->snd_cwnd <=3D 4) {
 					do_retrans =3D true;
 					break;
@@ -330,9 +342,8 @@ retrans:
 				if (4 * tp->srtt_us >=3D tp_it->srtt_us) {
 					do_retrans =3D false;
 					break;
-				} else {
-					do_retrans =3D true;
 				}
+				do_retrans =3D true;
 			}
 		}
 =

@@ -371,8 +382,9 @@ static struct sk_buff *__mptcp_next_segment(struct sock=
 *meta_sk, int *reinject)
 		if (!skb && meta_sk->sk_socket &&
 		    test_bit(SOCK_NOSPACE, &meta_sk->sk_socket->flags) &&
 		    sk_stream_wspace(meta_sk) < sk_stream_min_wspace(meta_sk)) {
-			struct sock *subsk =3D get_available_subflow(meta_sk, NULL,
-								   false);
+			struct sock *subsk;
+
+			subsk =3D get_available_subflow(meta_sk, NULL, false);
 			if (!subsk)
 				return NULL;
 =

@@ -408,7 +420,8 @@ static struct sk_buff *mptcp_next_segment(struct sock *=
meta_sk,
 	subtp =3D tcp_sk(*subsk);
 	mss_now =3D tcp_current_mss(*subsk);
 =

-	if (!*reinject && unlikely(!tcp_snd_wnd_test(tcp_sk(meta_sk), skb, mss_no=
w))) {
+	if (!*reinject && unlikely(!tcp_snd_wnd_test(tcp_sk(meta_sk),
+						     skb, mss_now))) {
 		skb =3D mptcp_rcv_buf_optimization(*subsk, 1);
 		if (skb)
 			*reinject =3D -1;
@@ -453,7 +466,7 @@ static void defsched_init(struct sock *sk)
 {
 	struct defsched_priv *dsp =3D defsched_get_priv(tcp_sk(sk));
 =

-	dsp->last_rbuf_opti =3D tcp_time_stamp;
+	dsp->last_rbuf_opti =3D tcp_time_stamp(tcp_sk(sk));
 }
 =

 struct mptcp_sched_ops mptcp_sched_default =3D {
-- =

2.7.4


--===============1435531479864954516==--
