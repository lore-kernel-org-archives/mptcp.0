Content-Type: multipart/mixed; boundary="===============4237114929514758465=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 11/25] tcp_extra_options: Make extra-option list
 per-socket
Date: Mon, 27 Nov 2017 21:57:12 -0800
Message-ID: <20171128055726.430-12-cpaasch@apple.com>
In-Reply-To: 20171128055726.430-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 186

--===============4237114929514758465==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Each TCP-socket, TCP request-socket and TCP time-wait socket has its own
list. That way we can send the proper options in each state.

The list is copied across the different socket-types when needed.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 include/linux/tcp.h      |   5 ++
 include/net/tcp.h        |  49 +++++++++--
 net/ipv4/tcp.c           | 214 ++++++++++++++++++++++++++++++-------------=
----
 net/ipv4/tcp_input.c     |   5 ++
 net/ipv4/tcp_ipv4.c      |  14 +++-
 net/ipv4/tcp_minisocks.c |  10 +++
 net/ipv6/tcp_ipv6.c      |   9 ++
 7 files changed, 219 insertions(+), 87 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index a2a1676dfc52..4f653e3bd33f 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -156,6 +156,7 @@ struct tcp_request_sock {
 						  * FastOpen it's the seq#
 						  * after data-in-SYN.
 						  */
+	struct list_head		tcp_option_list;
 };
 =

 static inline struct tcp_request_sock *tcp_rsk(const struct request_sock *=
req)
@@ -391,6 +392,8 @@ struct tcp_sock {
 	 */
 	struct request_sock *fastopen_rsk;
 	u32	*saved_syn;
+
+	struct list_head tcp_option_list;
 };
 =

 enum tsq_enum {
@@ -435,6 +438,8 @@ struct tcp_timewait_sock {
 	u32			  tw_last_oow_ack_time;
 =

 	long			  tw_ts_recent_stamp;
+
+	struct list_head	  tcp_option_list;
 #ifdef CONFIG_TCP_MD5SIG
 	struct tcp_md5sig_key	  *tw_md5_key;
 #endif
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 0981a1b429ca..1f34b1708990 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2066,31 +2066,56 @@ extern struct static_key_false tcp_have_smc;
 #endif
 =

 extern struct static_key_false tcp_extra_options_enabled;
+struct tcp_extra_option_store;
 =

 struct tcp_extra_option_ops {
-	struct list_head	list;
 	unsigned char		option_kind;
 	unsigned char		priority;
 	void (*parse)(int opsize, const unsigned char *opptr,
 		      const struct sk_buff *skb,
 		      struct tcp_options_received *opt_rx,
-		      struct sock *sk);
+		      struct sock *sk,
+		      struct tcp_extra_option_store *store);
 	/* Return the number of bytes consumed */
 	unsigned int (*prepare)(struct sk_buff *skb, u8 flags,
 				unsigned int remaining,
 				struct tcp_out_options *opts,
-				const struct sock *sk);
+				const struct sock *sk,
+				struct tcp_extra_option_store *store);
 	void (*write)(__be32 *ptr, struct sk_buff *skb,
-		      struct tcp_out_options *opts, struct sock *sk);
+		      struct tcp_out_options *opts, struct sock *sk,
+		      struct tcp_extra_option_store *store);
 	void (*response_write)(__be32 *ptr, struct sk_buff *orig,
 			       struct tcphdr *th,
 			       struct tcp_out_options *opts,
-			       const struct sock *sk);
+			       const struct sock *sk,
+			       struct tcp_extra_option_store *store);
 	int (*add_header_len)(const struct sock *listener,
-			      const struct sock *sk);
+			      const struct sock *sk,
+			      struct tcp_extra_option_store *store);
+	struct tcp_extra_option_store *(*copy)(struct sock *listener,
+					       struct request_sock *req,
+					       struct tcp_options_received *opt,
+					       struct tcp_extra_option_store *from);
+	struct tcp_extra_option_store *(*move)(struct tcp_extra_option_store *fro=
m);
+	void (*destroy)(struct tcp_extra_option_store *store);
 	struct module		*owner;
 };
 =

+/* Every extra-option in a TCP-socket gets stored in a _store structure wh=
ich
+ * has to have tcp_extra_option_store as the first element.
+ *
+ * That way, an extra option registers passes this to tcp_register_extra_o=
ption,
+ * and the surrounding structure can contain per-option state.
+ */
+struct tcp_extra_option_store {
+	struct list_head		list;
+	const struct tcp_extra_option_ops	*ops;
+};
+
+struct tcp_extra_option_store *tcp_extra_options_find_kind(unsigned char k=
ind,
+							   const struct sock *sk);
+
 void tcp_extra_options_parse(int opcode, int opsize, const unsigned char *=
opptr,
 			     const struct sk_buff *skb,
 			     struct tcp_options_received *opt_rx,
@@ -2113,7 +2138,15 @@ void tcp_extra_options_response_write(__be32 *ptr, s=
truct sk_buff *orig,
 int tcp_extra_options_add_header(const struct sock *listener,
 				 const struct sock *sk);
 =

-int tcp_register_extra_option(struct tcp_extra_option_ops *ops);
-void tcp_unregister_extra_option(struct tcp_extra_option_ops *ops);
+int tcp_register_extra_option(struct tcp_extra_option_store *store,
+			      struct sock *sk);
+
+void tcp_extra_options_copy(struct sock *listener,
+			    struct request_sock *req,
+			    struct tcp_options_received *opt);
+
+void tcp_extra_options_move(struct list_head *from, struct list_head *to);
+
+void tcp_extra_options_destroy(struct sock *sk);
 =

 #endif	/* _TCP_H */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 487f28222d3c..01e646873613 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -308,8 +308,6 @@ EXPORT_SYMBOL(tcp_sockets_allocated);
 /*
  * Optional TCP option handlers
  */
-static DEFINE_SPINLOCK(tcp_option_list_lock);
-static LIST_HEAD(tcp_option_list);
 DEFINE_STATIC_KEY_FALSE(tcp_extra_options_enabled);
 =

 /*
@@ -423,6 +421,7 @@ void tcp_init_sock(struct sock *sk)
 	tcp_init_xmit_timers(sk);
 	INIT_LIST_HEAD(&tp->tsq_node);
 	INIT_LIST_HEAD(&tp->tsorted_sent_queue);
+	INIT_LIST_HEAD(&tp->tcp_option_list);
 =

 	icsk->icsk_rto =3D TCP_TIMEOUT_INIT;
 	tp->mdev_us =3D jiffies_to_usecs(TCP_TIMEOUT_INIT);
@@ -3479,19 +3478,32 @@ EXPORT_SYMBOL(tcp_md5_hash_key);
 =

 #endif
 =

-/* Linear search, few entries are expected. The RCU read lock must
- * be held before calling.
- */
-static struct tcp_extra_option_ops *tcp_extra_options_find_kind(unsigned c=
har kind)
+static struct list_head *tcp_extra_options_get_list(const struct sock *sk)
 {
-	struct tcp_extra_option_ops *entry;
+	if (sk_fullsock(sk))
+		return &tcp_sk(sk)->tcp_option_list;
+	else if (sk->sk_state =3D=3D TCP_NEW_SYN_RECV)
+		return &tcp_rsk(inet_reqsk(sk))->tcp_option_list;
+	else if (sk->sk_state =3D=3D TCP_TIME_WAIT)
+		return &tcp_twsk(sk)->tcp_option_list;
+
+	return NULL;
+}
+
+struct tcp_extra_option_store *tcp_extra_options_find_kind(unsigned char k=
ind,
+							   const struct sock *sk)
+{
+	struct tcp_extra_option_store *entry;
+	struct list_head *lhead;
+
+	lhead =3D tcp_extra_options_get_list(sk);
 =

-	list_for_each_entry_rcu(entry, &tcp_option_list, list) {
-		if (entry->option_kind =3D=3D kind)
-			return entry;
+	list_for_each_entry(entry, lhead, list) {
+		if (entry->ops->option_kind =3D=3D kind)
+			break;
 	}
 =

-	return NULL;
+	return entry;
 }
 =

 void tcp_extra_options_parse(int opcode, int opsize, const unsigned char *=
opptr,
@@ -3499,75 +3511,79 @@ void tcp_extra_options_parse(int opcode, int opsize=
, const unsigned char *opptr,
 			     struct tcp_options_received *opt_rx,
 			     struct sock *sk)
 {
-	struct tcp_extra_option_ops *entry;
+	struct tcp_extra_option_store *entry;
+
+	entry =3D tcp_extra_options_find_kind(opcode, sk);
 =

-	rcu_read_lock();
-	entry =3D tcp_extra_options_find_kind(opcode);
-	if (entry && entry->parse)
-		entry->parse(opsize, opptr, skb, opt_rx, sk);
-	rcu_read_unlock();
+	if (entry && entry->ops->parse)
+		entry->ops->parse(opsize, opptr, skb, opt_rx, sk, entry);
 }
 EXPORT_SYMBOL_GPL(tcp_extra_options_parse);
 =

-/* The RCU read lock must be held before calling, and should span both
- * the call to this function and tcp_extra_options_write to ensure that
- * tcp_option_list does not change between the two calls. To preserve
- * expected option alignment, always returns a multiple of 4 bytes.
- */
 unsigned int tcp_extra_options_prepare(struct sk_buff *skb, u8 flags,
 				       unsigned int remaining,
 				       struct tcp_out_options *opts,
 				       const struct sock *sk)
 {
-	struct tcp_extra_option_ops *entry;
+	struct tcp_extra_option_store *entry;
+	struct list_head *lhead;
 	unsigned int used =3D 0;
 =

-	list_for_each_entry_rcu(entry, &tcp_option_list, list) {
-		if (unlikely(!entry->prepare))
+	if (!sk)
+		return 0;
+
+	lhead =3D tcp_extra_options_get_list(sk);
+
+	list_for_each_entry(entry, lhead, list) {
+		if (unlikely(!entry->ops->prepare))
 			continue;
 =

-		used +=3D entry->prepare(skb, flags, remaining - used, opts, sk);
+		used +=3D entry->ops->prepare(skb, flags, remaining - used, opts,
+					    sk, entry);
 	}
 =

 	return roundup(used, 4);
 }
 EXPORT_SYMBOL_GPL(tcp_extra_options_prepare);
 =

-/* The RCU read lock must be held before calling, and should span both
- * the call to tcp_extra_options_write and this function to ensure that
- * tcp_option_list does not change between the two calls.
- */
 void tcp_extra_options_write(__be32 *ptr, struct sk_buff *skb,
 			     struct tcp_out_options *opts,
 			     struct sock *sk)
 {
-	struct tcp_extra_option_ops *entry;
+	struct tcp_extra_option_store *entry;
+	struct list_head *lhead;
+
+	if (!sk)
+		return;
 =

-	list_for_each_entry_rcu(entry, &tcp_option_list, list) {
-		if (unlikely(!entry->write))
+	lhead =3D tcp_extra_options_get_list(sk);
+
+	list_for_each_entry_rcu(entry, lhead, list) {
+		if (unlikely(!entry->ops->write))
 			continue;
 =

-		entry->write(ptr, skb, opts, sk);
+		entry->ops->write(ptr, skb, opts, sk, entry);
 	}
 }
 EXPORT_SYMBOL_GPL(tcp_extra_options_write);
 =

-/* The RCU read lock must be held before calling, and should span both
- * the call to tcp_extra_options_write and this function to ensure that
- * tcp_option_list does not change between the two calls.
- */
 void tcp_extra_options_response_write(__be32 *ptr, struct sk_buff *orig,
 				      struct tcphdr *th,
 				      struct tcp_out_options *opts,
 				      const struct sock *sk)
 {
-	struct tcp_extra_option_ops *entry;
+	struct tcp_extra_option_store *entry;
 =

-	list_for_each_entry_rcu(entry, &tcp_option_list, list) {
-		if (unlikely(!entry->write))
+	if (!sk)
+		return;
+
+	BUG_ON(!sk_fullsock(sk));
+
+	list_for_each_entry_rcu(entry, &tcp_sk(sk)->tcp_option_list, list) {
+		if (unlikely(!entry->ops->response_write))
 			continue;
 =

-		entry->response_write(ptr, orig, th, opts, sk);
+		entry->ops->response_write(ptr, orig, th, opts, sk, entry);
 	}
 }
 EXPORT_SYMBOL_GPL(tcp_extra_options_response_write);
@@ -3575,52 +3591,49 @@ EXPORT_SYMBOL_GPL(tcp_extra_options_response_write);
 int tcp_extra_options_add_header(const struct sock *listener,
 				 const struct sock *sk)
 {
-	struct tcp_extra_option_ops *entry;
+	struct tcp_extra_option_store *entry;
 	int tcp_header_len =3D 0;
 =

-	rcu_read_lock();
-	list_for_each_entry_rcu(entry, &tcp_option_list, list) {
-		if (unlikely(!entry->add_header_len))
+	list_for_each_entry(entry, &tcp_sk(sk)->tcp_option_list, list) {
+		if (unlikely(!entry->ops->add_header_len))
 			continue;
 =

-		tcp_header_len +=3D entry->add_header_len(listener, sk);
+		tcp_header_len +=3D entry->ops->add_header_len(listener, sk, entry);
 	}
-	rcu_read_unlock();
 =

 	return tcp_header_len;
 }
 =

-int tcp_register_extra_option(struct tcp_extra_option_ops *ops)
+int tcp_register_extra_option(struct tcp_extra_option_store *store,
+			      struct sock *sk)
 {
-	struct tcp_extra_option_ops *entry;
-	struct list_head *add_before =3D &tcp_option_list;
+	struct list_head *lhead, *add_before;
+	struct tcp_extra_option_store *entry;
 	int ret =3D 0;
 =

-	if (!ops->option_kind)
+	lhead =3D tcp_extra_options_get_list(sk);
+	add_before =3D lhead;
+
+	if (!store->ops->option_kind)
 		return -EINVAL;
 =

-	if (!try_module_get(ops->owner))
+	if (!try_module_get(store->ops->owner))
 		return -ENOENT;
 =

-	spin_lock(&tcp_option_list_lock);
-
-	list_for_each_entry_rcu(entry, &tcp_option_list, list) {
-		if (entry->option_kind =3D=3D ops->option_kind) {
+	list_for_each_entry(entry, lhead, list) {
+		if (entry->ops->option_kind =3D=3D store->ops->option_kind) {
 			pr_notice("Option kind %u already registered\n",
-				  ops->option_kind);
-			spin_unlock(&tcp_option_list_lock);
-			module_put(ops->owner);
+				  store->ops->option_kind);
+			module_put(store->ops->owner);
 			return -EEXIST;
 		}
 =

-		if (entry->priority <=3D ops->priority)
+		if (entry->ops->priority <=3D store->ops->priority)
 			add_before =3D &entry->list;
 	}
 =

-	list_add_tail_rcu(&ops->list, add_before);
-	pr_debug("Option kind %u registered\n", ops->option_kind);
-
-	spin_unlock(&tcp_option_list_lock);
+	list_add_tail(&store->list, add_before);
+	pr_debug("Option kind %u registered\n", store->ops->option_kind);
 =

 	static_branch_inc(&tcp_extra_options_enabled);
 =

@@ -3628,19 +3641,72 @@ int tcp_register_extra_option(struct tcp_extra_opti=
on_ops *ops)
 }
 EXPORT_SYMBOL_GPL(tcp_register_extra_option);
 =

-void tcp_unregister_extra_option(struct tcp_extra_option_ops *ops)
+void tcp_extra_options_copy(struct sock *listener,
+			    struct request_sock *req,
+			    struct tcp_options_received *opt)
+{
+	struct tcp_extra_option_store *entry;
+	struct list_head *from, *to;
+
+	from =3D tcp_extra_options_get_list(listener);
+	to =3D tcp_extra_options_get_list(req_to_sk(req));
+
+	list_for_each_entry(entry, from, list) {
+		struct tcp_extra_option_store *new;
+
+		if (!try_module_get(entry->ops->owner)) {
+			pr_err("%s Module get failed while copying\n", __func__);
+			continue;
+		}
+
+		new =3D entry->ops->copy(listener, req, opt, entry);
+		if (!new) {
+			module_put(entry->ops->owner);
+			continue;
+		}
+
+		list_add_tail(&new->list, to);
+
+		static_branch_inc(&tcp_extra_options_enabled);
+	}
+}
+
+void tcp_extra_options_move(struct list_head *from, struct list_head *to)
 {
-	spin_lock(&tcp_option_list_lock);
-	list_del_rcu(&ops->list);
-	spin_unlock(&tcp_option_list_lock);
+	struct tcp_extra_option_store *entry, *tmp;
 =

-	synchronize_net();
+	list_for_each_entry_safe(entry, tmp, from, list) {
+		list_del(&entry->list);
 =

-	static_branch_dec(&tcp_extra_options_enabled);
+		if (entry->ops->move) {
+			if (entry->ops->move(entry))
+				continue;
+		}
 =

-	module_put(ops->owner);
+		list_add_tail(&entry->list, to);
+	}
 }
-EXPORT_SYMBOL_GPL(tcp_unregister_extra_option);
+EXPORT_SYMBOL_GPL(tcp_extra_options_move);
+
+void tcp_extra_options_destroy(struct sock *sk)
+{
+	struct tcp_extra_option_store *entry, *tmp;
+	struct list_head *lhead;
+
+	lhead =3D tcp_extra_options_get_list(sk);
+
+	list_for_each_entry_safe(entry, tmp, lhead, list) {
+		struct module *owner =3D entry->ops->owner;
+		list_del(&entry->list);
+
+		entry->ops->destroy(entry);
+
+		static_branch_dec(&tcp_extra_options_enabled);
+
+		module_put(owner);
+	}
+}
+EXPORT_SYMBOL_GPL(tcp_extra_options_destroy);
 =

 void tcp_done(struct sock *sk)
 {
@@ -3788,8 +3854,6 @@ void __init tcp_init(void)
 		INIT_HLIST_HEAD(&tcp_hashinfo.bhash[i].chain);
 	}
 =

-	INIT_LIST_HEAD(&tcp_option_list);
-
 	cnt =3D tcp_hashinfo.ehash_mask + 1;
 	sysctl_tcp_max_orphans =3D cnt / 2;
 =

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 028da0a4eff5..4e84f299c96f 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6133,6 +6133,7 @@ static void tcp_openreq_init(struct request_sock *req,
 #if IS_ENABLED(CONFIG_SMC)
 	ireq->smc_ok =3D rx_opt->smc_ok;
 #endif
+	INIT_LIST_HEAD(&tcp_rsk(req)->tcp_option_list);
 }
 =

 struct request_sock *inet_reqsk_alloc(const struct request_sock_ops *ops,
@@ -6309,6 +6310,10 @@ int tcp_conn_request(struct request_sock_ops *rsk_op=
s,
 		tcp_reqsk_record_syn(sk, req, skb);
 		fastopen_sk =3D tcp_try_fastopen(sk, skb, req, &foc, dst);
 	}
+
+	if (static_branch_unlikely(&tcp_extra_options_enabled))
+		tcp_extra_options_copy(sk, req, &tmp_opt);
+
 	if (fastopen_sk) {
 		af_ops->send_synack(fastopen_sk, dst, &fl, req,
 				    &foc, TCP_SYNACK_FASTOPEN);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index f717069ad778..4a47bfd12662 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -692,12 +692,10 @@ static void tcp_v4_send_reset(const struct sock *sk, =
struct sk_buff *skb)
 =

 		memset(&opts, 0, sizeof(opts));
 =

-		rcu_read_lock();
 		used =3D tcp_extra_options_prepare(NULL, TCPHDR_RST, remaining,
 						 &opts, sk);
 =

 		tcp_extra_options_response_write(&rep.opt[0], skb, &rep.th, &opts, sk);
-		rcu_read_unlock();
 =

 		arg.iov[0].iov_len +=3D used;
 		offset +=3D used / 4;
@@ -825,12 +823,10 @@ static void tcp_v4_send_ack(const struct sock *sk,
 #endif
 =

 		memset(&opts, 0, sizeof(opts));
-		rcu_read_lock();
 		used =3D tcp_extra_options_prepare(NULL, TCPHDR_ACK, remaining,
 						 &opts, sk);
 =

 		tcp_extra_options_response_write(&rep.opt[offset], skb, &rep.th, &opts, =
sk);
-		rcu_read_unlock();
 =

 		arg.iov[0].iov_len +=3D used;
 		offset +=3D used / 4;
@@ -952,6 +948,9 @@ static int tcp_v4_send_synack(const struct sock *sk, st=
ruct dst_entry *dst,
  */
 static void tcp_v4_reqsk_destructor(struct request_sock *req)
 {
+	if (static_branch_unlikely(&tcp_extra_options_enabled))
+		tcp_extra_options_destroy(req_to_sk(req));
+
 	kfree(rcu_dereference_protected(inet_rsk(req)->ireq_opt, 1));
 }
 =

@@ -1446,6 +1445,11 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock =
*sk, struct sk_buff *skb,
 =

 	tcp_initialize_rcv_mss(newsk);
 =

+	if (static_branch_unlikely(&tcp_extra_options_enabled)) {
+		tcp_extra_options_move(&tcp_rsk(req)->tcp_option_list,
+				       &newtp->tcp_option_list);
+		INIT_LIST_HEAD(&tcp_rsk(req)->tcp_option_list);
+	}
 #ifdef CONFIG_TCP_MD5SIG
 	/* Copy over the MD5 key from the original socket */
 	key =3D tcp_md5_do_lookup(sk, (union tcp_md5_addr *)&newinet->inet_daddr,
@@ -1945,6 +1949,8 @@ void tcp_v4_destroy_sock(struct sock *sk)
 	/* Cleans up our, hopefully empty, out_of_order_queue. */
 	skb_rbtree_purge(&tp->out_of_order_queue);
 =

+	if (static_branch_unlikely(&tcp_extra_options_enabled))
+		tcp_extra_options_destroy(sk);
 #ifdef CONFIG_TCP_MD5SIG
 	/* Clean up the MD5 key list, if any */
 	if (tp->md5sig_info) {
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 7f9403d3272c..fb50d3d0d158 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -271,6 +271,7 @@ void tcp_time_wait(struct sock *sk, int state, int time=
o)
 		tcptw->tw_ts_recent_stamp =3D tp->rx_opt.ts_recent_stamp;
 		tcptw->tw_ts_offset	=3D tp->tsoffset;
 		tcptw->tw_last_oow_ack_time =3D 0;
+		INIT_LIST_HEAD(&tcptw->tcp_option_list);
 =

 #if IS_ENABLED(CONFIG_IPV6)
 		if (tw->tw_family =3D=3D PF_INET6) {
@@ -284,6 +285,11 @@ void tcp_time_wait(struct sock *sk, int state, int tim=
eo)
 		}
 #endif
 =

+		if (static_branch_unlikely(&tcp_extra_options_enabled)) {
+			tcp_extra_options_move(&tcp_sk(sk)->tcp_option_list,
+					       &tcptw->tcp_option_list);
+			INIT_LIST_HEAD(&tcp_sk(sk)->tcp_option_list);
+		}
 #ifdef CONFIG_TCP_MD5SIG
 		/*
 		 * The timewait bucket does not have the key DB from the
@@ -334,6 +340,9 @@ void tcp_twsk_destructor(struct sock *sk)
 	if (twsk->tw_md5_key)
 		kfree_rcu(twsk->tw_md5_key, rcu);
 #endif
+
+	if (static_branch_unlikely(&tcp_extra_options_enabled))
+		tcp_extra_options_destroy(sk);
 }
 EXPORT_SYMBOL_GPL(tcp_twsk_destructor);
 =

@@ -463,6 +472,7 @@ struct sock *tcp_create_openreq_child(const struct sock=
 *sk,
 =

 		INIT_LIST_HEAD(&newtp->tsq_node);
 		INIT_LIST_HEAD(&newtp->tsorted_sent_queue);
+		INIT_LIST_HEAD(&newtp->tcp_option_list);
 =

 		tcp_init_wl(newtp, treq->rcv_isn);
 =

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index ef037990ea5e..0a29ef82db35 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -500,6 +500,9 @@ static int tcp_v6_send_synack(const struct sock *sk, st=
ruct dst_entry *dst,
 =

 static void tcp_v6_reqsk_destructor(struct request_sock *req)
 {
+	if (static_branch_unlikely(&tcp_extra_options_enabled))
+		tcp_extra_options_destroy(req_to_sk(req));
+
 	kfree(inet_rsk(req)->ipv6_opt);
 	kfree_skb(inet_rsk(req)->pktopts);
 }
@@ -1215,6 +1218,12 @@ static struct sock *tcp_v6_syn_recv_sock(const struc=
t sock *sk, struct sk_buff *
 	newinet->inet_daddr =3D newinet->inet_saddr =3D LOOPBACK4_IPV6;
 	newinet->inet_rcv_saddr =3D LOOPBACK4_IPV6;
 =

+	if (static_branch_unlikely(&tcp_extra_options_enabled)) {
+		tcp_extra_options_move(&tcp_rsk(req)->tcp_option_list,
+				       &newtp->tcp_option_list);
+		INIT_LIST_HEAD(&tcp_rsk(req)->tcp_option_list);
+	}
+
 #ifdef CONFIG_TCP_MD5SIG
 	/* Copy over the MD5 key from the original socket */
 	key =3D tcp_v6_md5_do_lookup(sk, &newsk->sk_v6_daddr);
-- =

2.15.0


--===============4237114929514758465==--
