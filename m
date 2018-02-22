Content-Type: multipart/mixed; boundary="===============4977578403379084190=="
MIME-Version: 1.0
From: rao.shoaib at oracle.com
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 3/9] Introduce MPTCP specific elements that can be under
 #ifdef MPTCP_CONFIG
Date: Thu, 22 Feb 2018 15:49:55 -0800
Message-ID: <1519343401-19027-4-git-send-email-rao.shoaib@oracle.com>
In-Reply-To: 1519343401-19027-1-git-send-email-rao.shoaib@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 303

--===============4977578403379084190==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Rao Shoaib <rao.shoaib(a)oracle.com>

Signed-off-by: Rao Shoaib <rao.shoaib(a)oracle.com>
---
 include/linux/tcp.h      | 78 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 include/net/secure_seq.h |  9 +++++-
 include/net/tcp_states.h |  4 ++-
 include/uapi/linux/bpf.h |  4 ++-
 include/uapi/linux/if.h  |  5 ++++
 5 files changed, 97 insertions(+), 3 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 612360b..62c8e6c 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -92,6 +92,44 @@ struct tcp_out_options {
 	__u8 *hash_location;	/* temporary pointer, overloaded */
 	__u32 tsval, tsecr;	/* need to include OPTION_TS */
 	struct tcp_fastopen_cookie *fastopen_cookie;	/* Fast open cookie */
+#ifdef CONFIG_MPTCP
+	u16	mptcp_options;  /* bit field of MPTCP related OPTION_* */
+	u8	dss_csum:1,     /* dss-checksum required? */
+		add_addr_v4:1,
+		add_addr_v6:1,
+		mptcp_ver:4;
+
+	union {
+		struct {
+			__u64   sender_key;	/* sender's key for mptcp */
+			__u64   receiver_key;	/* receiver's key for mptcp */
+		} mp_capable;
+
+		struct {
+			__u64   sender_truncated_mac;
+			__u32   sender_nonce;
+					/* random number of the sender */
+			__u32   token;	/* token for mptcp */
+			u8      low_prio:1;
+		} mp_join_syns;
+	};
+
+	struct {
+		__u64 trunc_mac;
+		struct in_addr addr;
+		u16 port;
+		u8 addr_id;
+	} add_addr4;
+	struct {
+		__u64 trunc_mac;
+		struct in6_addr addr;
+		u16 port;
+		u8 addr_id;
+	} add_addr6;
+
+	u16     remove_addrs;   /* list of address id */
+	u8      addr_id;        /* address id (mp_join or add_address) */
+#endif /* CONFIG_MPTCP */
 };
 =

 /*These are used to set the sack_ok field in struct tcp_options_received */
@@ -397,6 +435,35 @@ struct tcp_sock {
 	u32	*saved_syn;
 	const struct tcp_operational_ops	*op_ops;
 	const struct tcp_state_ops		*state_ops;
+	void	*tcp_sock_private;
+#ifdef CONFIG_MPTCP
+	struct mptcp_cb         *mpcb;
+	struct sock             *meta_sk;
+	/* We keep these flags even if CONFIG_MPTCP is not checked, because
+	 * it allows checking MPTCP capability just by checking the mpc flag,
+	 * rather than adding ifdefs everywhere.
+	 */
+	u16     mpc:1,          /* Other end is multipath capable */
+		inside_tk_table:1, /* Is the tcp_sock inside the token-table? */
+		send_mp_fclose:1,
+		request_mptcp:1, /* Did we send out an MP_CAPABLE?
+				  * (this speeds up mptcp_doit() in tcp_recvmsg)
+				  */
+		pf:1, /* Potentially Failed state: when this flag is set, we
+		       * stop using the subflow
+		       */
+		mp_killed:1, /* Killed with a tcp_done in mptcp? */
+		was_meta_sk:1,  /* This was a meta sk (in case of reuse) */
+		is_master_sk:1,
+		close_it:1,     /* Must close socket in mptcp_data_ready? */
+		closing:1,
+		mptcp_ver:4;
+		struct mptcp_tcp_sock *mptcp;
+	struct hlist_nulls_node tk_table;
+	u32 mptcp_loc_token;
+	u64 mptcp_loc_key;
+#endif /* CONFIG_MPTCP */
+
 };
 =

 enum tsq_enum {
@@ -408,6 +475,10 @@ enum tsq_enum {
 	TCP_MTU_REDUCED_DEFERRED,  /* tcp_v{4|6}_err() could not call
 				    * tcp_v{4|6}_mtu_reduced()
 				    */
+#ifdef CONFIG_MPTCP
+	MPTCP_PATH_MANAGER,	/* MPTCP deferred creation of new subflows */
+	MPTCP_SUB_DEFERRED,	/* A subflow got deferred - process them */
+#endif
 };
 =

 enum tsq_flags {
@@ -417,6 +488,10 @@ enum tsq_flags {
 	TCPF_WRITE_TIMER_DEFERRED	=3D (1UL << TCP_WRITE_TIMER_DEFERRED),
 	TCPF_DELACK_TIMER_DEFERRED	=3D (1UL << TCP_DELACK_TIMER_DEFERRED),
 	TCPF_MTU_REDUCED_DEFERRED	=3D (1UL << TCP_MTU_REDUCED_DEFERRED),
+#ifdef CONFIG_MPTCP
+	MPTCPF_PATH_MANAGER		=3D (1UL << MPTCP_PATH_MANAGER),
+	MPTCPF_SUB_DEFERRED		=3D (1UL << MPTCP_SUB_DEFERRED),
+#endif
 };
 =

 static inline struct tcp_sock *tcp_sk(const struct sock *sk)
@@ -439,6 +514,9 @@ struct tcp_timewait_sock {
 #ifdef CONFIG_TCP_MD5SIG
 	struct tcp_md5sig_key	  *tw_md5_key;
 #endif
+#ifdef CONFIG_MPTCP
+	struct	mptcp_tw	  *mptcp_tw;
+#endif
 };
 =

 static inline struct tcp_timewait_sock *tcp_twsk(const struct sock *sk)
diff --git a/include/net/secure_seq.h b/include/net/secure_seq.h
index d7d2495f..102dc91 100644
--- a/include/net/secure_seq.h
+++ b/include/net/secure_seq.h
@@ -18,5 +18,12 @@ u64 secure_dccp_sequence_number(__be32 saddr, __be32 dad=
dr,
 				__be16 sport, __be16 dport);
 u64 secure_dccpv6_sequence_number(__be32 *saddr, __be32 *daddr,
 				  __be16 sport, __be16 dport);
-
+#ifdef CONFIG_MPTCP
+u32 mptcp_v4_get_nonce(__be32 saddr, __be32 daddr, __be16 sport, __be16 dp=
ort);
+u64 mptcp_v4_get_key(__be32 saddr, __be32 daddr, __be16 sport, __be16 dpor=
t);
+u32 mptcp_v6_get_nonce(const __be32 *saddr, const __be32 *daddr,
+		       __be16 sport, __be16 dport);
+u64 mptcp_v6_get_key(const __be32 *saddr, const __be32 *daddr,
+		     __be16 sport, __be16 dport);
+#endif
 #endif /* _NET_SECURE_SEQ */
diff --git a/include/net/tcp_states.h b/include/net/tcp_states.h
index 50e78a7..73eb518 100644
--- a/include/net/tcp_states.h
+++ b/include/net/tcp_states.h
@@ -26,7 +26,9 @@ enum {
 	TCP_LISTEN,
 	TCP_CLOSING,	/* Now a valid state */
 	TCP_NEW_SYN_RECV,
-
+#ifdef CONFIG_MPTCP
+	TCP_RST_WAIT,
+#endif
 	TCP_MAX_STATES	/* Leave at the end! */
 };
 =

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index db6bdc3..f837e91 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1079,7 +1079,9 @@ enum {
 	BPF_TCP_LISTEN,
 	BPF_TCP_CLOSING,	/* Now a valid state */
 	BPF_TCP_NEW_SYN_RECV,
-
+#ifdef CONFIG_MPTCP
+	BPF_TCP_RST_WAIT,
+#endif
 	BPF_TCP_MAX_STATES	/* Leave at the end! */
 };
 =

diff --git a/include/uapi/linux/if.h b/include/uapi/linux/if.h
index 7fea0fd..fa08d86 100644
--- a/include/uapi/linux/if.h
+++ b/include/uapi/linux/if.h
@@ -132,6 +132,11 @@ enum net_device_flags {
 #define IFF_ECHO			IFF_ECHO
 #endif /* __UAPI_DEF_IF_NET_DEVICE_FLAGS_LOWER_UP_DORMANT_ECHO */
 =

+#ifdef CONFIG_MPTCP
+#define IFF_NOMULTIPATH 0x80000         /* Disable for MPTCP            */
+#define IFF_MPBACKUP    0x100000        /* Use as backup path for MPTCP */
+#endif
+
 #define IFF_VOLATILE	(IFF_LOOPBACK|IFF_POINTOPOINT|IFF_BROADCAST|IFF_ECHO|\
 		IFF_MASTER|IFF_SLAVE|IFF_RUNNING|IFF_LOWER_UP|IFF_DORMANT)
 =

-- =

2.7.4


--===============4977578403379084190==--
