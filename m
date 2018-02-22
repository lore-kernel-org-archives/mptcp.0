Content-Type: multipart/mixed; boundary="===============7414845349632128397=="
MIME-Version: 1.0
From: rao.shoaib at oracle.com
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 2/9] Introduce MPTCP specific elements that will
 co-exist with TCP even when MPTCP is not compiled
Date: Thu, 22 Feb 2018 15:49:54 -0800
Message-ID: <1519343401-19027-3-git-send-email-rao.shoaib@oracle.com>
In-Reply-To: 1519343401-19027-1-git-send-email-rao.shoaib@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 302

--===============7414845349632128397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Rao Shoaib <rao.shoaib(a)oracle.com>

Signed-off-by: Rao Shoaib <rao.shoaib(a)oracle.com>
---
 include/net/inet_sock.h  |  6 ++++--
 include/net/sock.h       |  1 +
 include/net/tcp.h        | 19 ++++++++++++++++---
 include/uapi/linux/tcp.h |  1 +
 4 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 0a671c3..8961273 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -83,7 +83,7 @@ struct inet_request_sock {
 #define ireq_state		req.__req_common.skc_state
 #define ireq_family		req.__req_common.skc_family
 =

-	u16			snd_wscale : 4,
+	u32			snd_wscale : 4,
 				rcv_wscale : 4,
 				tstamp_ok  : 1,
 				sack_ok	   : 1,
@@ -91,7 +91,9 @@ struct inet_request_sock {
 				ecn_ok	   : 1,
 				acked	   : 1,
 				no_srccheck: 1,
-				smc_ok	   : 1;
+				smc_ok	   : 1,
+				mptcp_rqsk : 1, /* set if the syn had MP_CAP */
+				saw_mpc	   : 1;
 	u32                     ir_mark;
 	union {
 		struct ip_options_rcu __rcu	*ireq_opt;
diff --git a/include/net/sock.h b/include/net/sock.h
index 3aa7b7d..10e00d7 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -777,6 +777,7 @@ enum sock_flags {
 	SOCK_FILTER_LOCKED, /* Filter cannot be changed anymore */
 	SOCK_SELECT_ERR_QUEUE, /* Wake select on error queue */
 	SOCK_RCU_FREE, /* wait rcu grace period in sk_destruct() */
+	SOCK_MPTCP, /* MPTCP set on this socket */
 };
 =

 #define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL << SOCK_TIMESTA=
MPING_RX_SOFTWARE))
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 8bc724f..e9f7582 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -52,6 +52,9 @@ extern struct inet_hashinfo tcp_hashinfo;
 extern struct percpu_counter tcp_orphan_count;
 void tcp_time_wait(struct sock *sk, int state, int timeo);
 =

+typedef int (*process_unclaimed)(const struct sock *sk, struct sk_buff *sk=
b);
+extern process_unclaimed tcp_process_unclaimed;
+
 #define MAX_TCP_HEADER	(128 + MAX_HEADER)
 #define MAX_TCP_OPTION_SPACE 40
 =

@@ -182,6 +185,7 @@ void tcp_time_wait(struct sock *sk, int state, int time=
o);
 #define TCPOPT_SACK             5       /* SACK Block */
 #define TCPOPT_TIMESTAMP	8	/* Better RTT estimations/PAWS */
 #define TCPOPT_MD5SIG		19	/* MD5 Signature (RFC2385) */
+#define TCPOPT_MPTCP		30	/* MPTCP (RFC6824) */
 #define TCPOPT_FASTOPEN		34	/* Fast open (RFC7413) */
 #define TCPOPT_EXP		254	/* Experimental */
 /* Magic number to be after the option value for sharing TCP
@@ -312,7 +316,6 @@ static inline bool tcp_too_many_orphans(struct sock *sk=
, int shift)
 =

 bool tcp_check_oom(struct sock *sk, int shift);
 =

-
 extern struct proto tcp_prot;
 =

 #define TCP_INC_STATS(net, field)	SNMP_INC_STATS((net)->mib.tcp_statistics=
, field)
@@ -800,12 +803,22 @@ struct tcp_skb_cb {
 #define TCPCB_RETRANS		(TCPCB_SACKED_RETRANS|TCPCB_EVER_RETRANS| \
 				TCPCB_REPAIRED)
 =

-	__u8		ip_dsfield;	/* IPv4 tos or IPv6 dsfield	*/
+	union {
+		__u8		ip_dsfield;	/* IPv4 tos or IPv6 dsfield */
+		/* ip_dstfield is only used on the Rx side. It's value
+		 * is consumed by the time MPTCP starts processing.
+		 */
+		__u8		mptcp_flags;
+	};
 	__u8		txstamp_ack:1,	/* Record TX timestamp for ack? */
 			eor:1,		/* Is skb MSG_EOR marked? */
 			has_rxtstamp:1,	/* SKB has a RX timestamp	*/
 			unused:5;
-	__u32		ack_seq;	/* Sequence number ACK'd	*/
+	union {
+			__u32	ack_seq;	/* Sequence number ACK'd */
+			__u32	mptcp_data_seq; /* Used on Tx subskb */
+			__u32	mptcp_path_mask; /* Used on orig skb */
+	};
 	union {
 		struct {
 			/* There is space for up to 24 bytes */
diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index b4a4f64..c1a5e5d 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -122,6 +122,7 @@ enum {
 #define TCP_MD5SIG_EXT		32	/* TCP MD5 Signature with extensions */
 #define TCP_FASTOPEN_KEY	33	/* Set the key for Fast Open (cookie) */
 #define TCP_FASTOPEN_NO_COOKIE	34	/* Enable TFO without a TFO cookie */
+#define	MPTCP_ENABLED		42
 =

 struct tcp_repair_opt {
 	__u32	opt_code;
-- =

2.7.4


--===============7414845349632128397==--
