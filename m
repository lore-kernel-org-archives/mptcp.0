Content-Type: multipart/mixed; boundary="===============3065098482592038500=="
MIME-Version: 1.0
From: Nicolas Rybowski <nicolas.rybowski at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 3/4] mptcp: moving struct definitions
Date: Tue, 04 Aug 2020 18:13:30 +0200
Message-ID: <20200804161331.1219161-4-nicolas.rybowski@tessares.net>
In-Reply-To: 20200804161331.1219161-1-nicolas.rybowski@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5469

--===============3065098482592038500==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In order to access 'struct mptcp_sock' in eBPF, it is required to be
publicly accessible in the 'include/net/mptcp.h' interface rather than
being privately defined in 'net/mptcp/protocol.h'.

The other structures are required to define 'struct mptcp_sock' and the
helper is used in a newly defined BPF helper.

The moved structures are not expected to be used elsewhere than in
net/mptcp and eBPF so there is maybe a better solution to expose them to
BPF other than just moving them here.

Acked-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Nicolas Rybowski <nicolas.rybowski(a)tessares.net>
---
 include/net/mptcp.h  | 132 +++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h | 123 ----------------------------------------
 2 files changed, 132 insertions(+), 123 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 3525d2822abe..61b720144592 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -57,6 +57,122 @@ struct mptcp_out_options {
 #endif
 };
 =

+struct mptcp_addr_info {
+	sa_family_t		family;
+	__be16			port;
+	u8			id;
+	union {
+		struct in_addr addr;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+		struct in6_addr addr6;
+#endif
+	};
+};
+
+struct mptcp_pm_data {
+	struct mptcp_addr_info local;
+	struct mptcp_addr_info remote;
+
+	spinlock_t	lock;		/*protects the whole PM data */
+
+	bool		addr_signal;
+	bool		server_side;
+	bool		work_pending;
+	bool		accept_addr;
+	bool		accept_subflow;
+	u8		add_addr_signaled;
+	u8		add_addr_accepted;
+	u8		local_addr_used;
+	u8		subflows;
+	u8		add_addr_signal_max;
+	u8		add_addr_accept_max;
+	u8		local_addr_max;
+	u8		subflows_max;
+	u8		status;
+};
+
+/* MPTCP connection sock */
+struct mptcp_sock {
+	/* inet_connection_sock must be the first member */
+	struct inet_connection_sock sk;
+	u64		local_key;
+	u64		remote_key;
+	u64		write_seq;
+	u64		ack_seq;
+	u64		rcv_data_fin_seq;
+	atomic64_t	snd_una;
+	unsigned long	timer_ival;
+	u32		token;
+	unsigned long	flags;
+	bool		can_ack;
+	bool		fully_established;
+	bool		rcv_data_fin;
+	bool		snd_data_fin_enable;
+	spinlock_t	join_list_lock;
+	struct work_struct work;
+	struct list_head conn_list;
+	struct list_head rtx_queue;
+	struct list_head join_list;
+	struct skb_ext	*cached_ext;	/* for the next sendmsg */
+	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
+	struct sock	*first;
+	struct mptcp_pm_data	pm;
+	struct {
+		u32	space;	/* bytes copied in last measurement window */
+		u32	copied; /* bytes copied in this measurement window */
+		u64	time;	/* start time of measurement window */
+		u64	rtt_us; /* last maximum rtt of subflows */
+	} rcvq_space;
+};
+
+#define MPTCPOPT_HMAC_LEN	20
+
+/* MPTCP subflow context */
+struct mptcp_subflow_context {
+	struct	list_head node;/* conn_list of subflows */
+	u64	local_key;
+	u64	remote_key;
+	u64	idsn;
+	u64	map_seq;
+	u32	snd_isn;
+	u32	token;
+	u32	rel_write_seq;
+	u32	map_subflow_seq;
+	u32	ssn_offset;
+	u32	map_data_len;
+	u32	request_mptcp : 1,  /* send MP_CAPABLE */
+		request_join : 1,   /* send MP_JOIN */
+		request_bkup : 1,
+		mp_capable : 1,	    /* remote is MPTCP capable */
+		mp_join : 1,	    /* remote is JOINing */
+		fully_established : 1,	    /* path validated */
+		pm_notified : 1,    /* PM hook called for established status */
+		conn_finished : 1,
+		map_valid : 1,
+		mpc_map : 1,
+		backup : 1,
+		data_avail : 1,
+		rx_eof : 1,
+		use_64bit_ack : 1, /* Set when we received a 64-bit DSN */
+		can_ack : 1;	    /* only after processing the remote a key */
+	u32	remote_nonce;
+	u64	thmac;
+	u32	local_nonce;
+	u32	remote_token;
+	u8	hmac[MPTCPOPT_HMAC_LEN];
+	u8	local_id;
+	u8	remote_id;
+
+	struct	sock *tcp_sock;	    /* tcp sk backpointer */
+	struct	sock *conn;	    /* parent mptcp_sock */
+	const	struct inet_connection_sock_af_ops *icsk_af_ops;
+	void	(*tcp_data_ready)(struct sock *sk);
+	void	(*tcp_state_change)(struct sock *sk);
+	void	(*tcp_write_space)(struct sock *sk);
+
+	struct	rcu_head rcu;
+};
+
 #ifdef CONFIG_MPTCP
 extern struct request_sock_ops mptcp_subflow_request_sock_ops;
 =

@@ -134,6 +250,16 @@ void mptcp_seq_show(struct seq_file *seq);
 int mptcp_subflow_init_cookie_req(struct request_sock *req,
 				  const struct sock *sk_listener,
 				  struct sk_buff *skb);
+
+static inline struct mptcp_subflow_context *
+mptcp_subflow_ctx(const struct sock *sk)
+{
+	struct inet_connection_sock *icsk =3D inet_csk(sk);
+
+	/* Use RCU on icsk_ulp_data only for sock diag code */
+	return (__force struct mptcp_subflow_context *)icsk->icsk_ulp_data;
+}
+
 #else
 =

 static inline void mptcp_init(void)
@@ -210,6 +336,12 @@ static inline int mptcp_subflow_init_cookie_req(struct=
 request_sock *req,
 {
 	return 0; /* TCP fallback */
 }
+
+static inline struct mptcp_subflow_context *
+mptcp_subflow_ctx(const struct sock *sk)
+{
+	return NULL;
+}
 #endif /* CONFIG_MPTCP */
 =

 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 60b27d44c184..8ea421abd541 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -136,46 +136,12 @@ static inline __be32 mptcp_option(u8 subopt, u8 len, =
u8 nib, u8 field)
 		     ((nib & 0xF) << 8) | field);
 }
 =

-struct mptcp_addr_info {
-	sa_family_t		family;
-	__be16			port;
-	u8			id;
-	union {
-		struct in_addr addr;
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-		struct in6_addr addr6;
-#endif
-	};
-};
-
 enum mptcp_pm_status {
 	MPTCP_PM_ADD_ADDR_RECEIVED,
 	MPTCP_PM_ESTABLISHED,
 	MPTCP_PM_SUBFLOW_ESTABLISHED,
 };
 =

-struct mptcp_pm_data {
-	struct mptcp_addr_info local;
-	struct mptcp_addr_info remote;
-
-	spinlock_t	lock;		/*protects the whole PM data */
-
-	bool		addr_signal;
-	bool		server_side;
-	bool		work_pending;
-	bool		accept_addr;
-	bool		accept_subflow;
-	u8		add_addr_signaled;
-	u8		add_addr_accepted;
-	u8		local_addr_used;
-	u8		subflows;
-	u8		add_addr_signal_max;
-	u8		add_addr_accept_max;
-	u8		local_addr_max;
-	u8		subflows_max;
-	u8		status;
-};
-
 struct mptcp_data_frag {
 	struct list_head list;
 	u64 data_seq;
@@ -185,40 +151,6 @@ struct mptcp_data_frag {
 	struct page *page;
 };
 =

-/* MPTCP connection sock */
-struct mptcp_sock {
-	/* inet_connection_sock must be the first member */
-	struct inet_connection_sock sk;
-	u64		local_key;
-	u64		remote_key;
-	u64		write_seq;
-	u64		ack_seq;
-	u64		rcv_data_fin_seq;
-	atomic64_t	snd_una;
-	unsigned long	timer_ival;
-	u32		token;
-	unsigned long	flags;
-	bool		can_ack;
-	bool		fully_established;
-	bool		rcv_data_fin;
-	bool		snd_data_fin_enable;
-	spinlock_t	join_list_lock;
-	struct work_struct work;
-	struct list_head conn_list;
-	struct list_head rtx_queue;
-	struct list_head join_list;
-	struct skb_ext	*cached_ext;	/* for the next sendmsg */
-	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
-	struct sock	*first;
-	struct mptcp_pm_data	pm;
-	struct {
-		u32	space;	/* bytes copied in last measurement window */
-		u32	copied; /* bytes copied in this measurement window */
-		u64	time;	/* start time of measurement window */
-		u64	rtt_us; /* last maximum rtt of subflows */
-	} rcvq_space;
-};
-
 #define mptcp_for_each_subflow(__msk, __subflow)			\
 	list_for_each_entry(__subflow, &((__msk)->conn_list), node)
 =

@@ -268,61 +200,6 @@ mptcp_subflow_rsk(const struct request_sock *rsk)
 	return (struct mptcp_subflow_request_sock *)rsk;
 }
 =

-/* MPTCP subflow context */
-struct mptcp_subflow_context {
-	struct	list_head node;/* conn_list of subflows */
-	u64	local_key;
-	u64	remote_key;
-	u64	idsn;
-	u64	map_seq;
-	u32	snd_isn;
-	u32	token;
-	u32	rel_write_seq;
-	u32	map_subflow_seq;
-	u32	ssn_offset;
-	u32	map_data_len;
-	u32	request_mptcp : 1,  /* send MP_CAPABLE */
-		request_join : 1,   /* send MP_JOIN */
-		request_bkup : 1,
-		mp_capable : 1,	    /* remote is MPTCP capable */
-		mp_join : 1,	    /* remote is JOINing */
-		fully_established : 1,	    /* path validated */
-		pm_notified : 1,    /* PM hook called for established status */
-		conn_finished : 1,
-		map_valid : 1,
-		mpc_map : 1,
-		backup : 1,
-		data_avail : 1,
-		rx_eof : 1,
-		use_64bit_ack : 1, /* Set when we received a 64-bit DSN */
-		can_ack : 1;	    /* only after processing the remote a key */
-	u32	remote_nonce;
-	u64	thmac;
-	u32	local_nonce;
-	u32	remote_token;
-	u8	hmac[MPTCPOPT_HMAC_LEN];
-	u8	local_id;
-	u8	remote_id;
-
-	struct	sock *tcp_sock;	    /* tcp sk backpointer */
-	struct	sock *conn;	    /* parent mptcp_sock */
-	const	struct inet_connection_sock_af_ops *icsk_af_ops;
-	void	(*tcp_data_ready)(struct sock *sk);
-	void	(*tcp_state_change)(struct sock *sk);
-	void	(*tcp_write_space)(struct sock *sk);
-
-	struct	rcu_head rcu;
-};
-
-static inline struct mptcp_subflow_context *
-mptcp_subflow_ctx(const struct sock *sk)
-{
-	struct inet_connection_sock *icsk =3D inet_csk(sk);
-
-	/* Use RCU on icsk_ulp_data only for sock diag code */
-	return (__force struct mptcp_subflow_context *)icsk->icsk_ulp_data;
-}
-
 static inline struct sock *
 mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 {
-- =

2.28.0

--===============3065098482592038500==--
