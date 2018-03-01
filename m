Content-Type: multipart/mixed; boundary="===============2208300193116022014=="
MIME-Version: 1.0
From: rao.shoaib at oracle.com
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 1/1] Add MPTCP code to work with the modified TCP code
Date: Wed, 28 Feb 2018 16:49:52 -0800
Message-ID: <1519865392-10321-2-git-send-email-rao.shoaib@oracle.com>
In-Reply-To: 1519865392-10321-1-git-send-email-rao.shoaib@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 330

--===============2208300193116022014==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Rao Shoaib <rao.shoaib(a)oracle.com>

Signed-off-by: Rao Shoaib <rao.shoaib(a)oracle.com>
---
 include/net/mptcp.h          | 1474 +++++++++++++++++++++
 include/net/mptcp_v4.h       |   56 +
 include/net/mptcp_v6.h       |   56 +
 include/net/netns/mptcp.h    |   52 +
 net/Kconfig                  |    1 +
 net/Makefile                 |    1 +
 net/mptcp/Kconfig            |  129 ++
 net/mptcp/Makefile           |   22 +
 net/mptcp/mptcp_balia.c      |  267 ++++
 net/mptcp/mptcp_binder.c     |  487 +++++++
 net/mptcp/mptcp_coupled.c    |  270 ++++
 net/mptcp/mptcp_ctrl.c       | 2981 ++++++++++++++++++++++++++++++++++++++=
++++
 net/mptcp/mptcp_fullmesh.c   | 1877 ++++++++++++++++++++++++++
 net/mptcp/mptcp_input.c      | 2970 ++++++++++++++++++++++++++++++++++++++=
+++
 net/mptcp/mptcp_ipv4.c       |  345 +++++
 net/mptcp/mptcp_ipv6.c       |  316 +++++
 net/mptcp/mptcp_ndiffports.c |  169 +++
 net/mptcp/mptcp_ofo_queue.c  |  177 +++
 net/mptcp/mptcp_olia.c       |  309 +++++
 net/mptcp/mptcp_output.c     | 1837 ++++++++++++++++++++++++++
 net/mptcp/mptcp_pm.c         |  178 +++
 net/mptcp/mptcp_redundant.c  |  268 ++++
 net/mptcp/mptcp_rr.c         |  301 +++++
 net/mptcp/mptcp_sched.c      |  597 +++++++++
 net/mptcp/mptcp_wvegas.c     |  268 ++++
 25 files changed, 15408 insertions(+)
 create mode 100644 include/net/mptcp.h
 create mode 100644 include/net/mptcp_v4.h
 create mode 100644 include/net/mptcp_v6.h
 create mode 100644 include/net/netns/mptcp.h
 create mode 100644 net/mptcp/Kconfig
 create mode 100644 net/mptcp/Makefile
 create mode 100644 net/mptcp/mptcp_balia.c
 create mode 100644 net/mptcp/mptcp_binder.c
 create mode 100644 net/mptcp/mptcp_coupled.c
 create mode 100644 net/mptcp/mptcp_ctrl.c
 create mode 100644 net/mptcp/mptcp_fullmesh.c
 create mode 100644 net/mptcp/mptcp_input.c
 create mode 100644 net/mptcp/mptcp_ipv4.c
 create mode 100644 net/mptcp/mptcp_ipv6.c
 create mode 100644 net/mptcp/mptcp_ndiffports.c
 create mode 100644 net/mptcp/mptcp_ofo_queue.c
 create mode 100644 net/mptcp/mptcp_olia.c
 create mode 100644 net/mptcp/mptcp_output.c
 create mode 100644 net/mptcp/mptcp_pm.c
 create mode 100644 net/mptcp/mptcp_redundant.c
 create mode 100644 net/mptcp/mptcp_rr.c
 create mode 100644 net/mptcp/mptcp_sched.c
 create mode 100644 net/mptcp/mptcp_wvegas.c

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
new file mode 100644
index 0000000..5234145
--- /dev/null
+++ b/include/net/mptcp.h
@@ -0,0 +1,1474 @@
+/*
+ *	MPTCP implementation
+ *
+ *	Initial Design & Implementation:
+ *	S=C3=A9bastien Barr=C3=A9 <sebastien.barre(a)uclouvain.be>
+ *
+ *	Current Maintainer & Author:
+ *	Christoph Paasch <christoph.paasch(a)uclouvain.be>
+ *
+ *	Additional authors:
+ *	Jaakko Korkeaniemi <jaakko.korkeaniemi(a)aalto.fi>
+ *	Gregory Detal <gregory.detal(a)uclouvain.be>
+ *	Fabien Duch=C3=AAne <fabien.duchene(a)uclouvain.be>
+ *	Andreas Seelinger <Andreas.Seelinger(a)rwth-aachen.de>
+ *	Lavkesh Lahngir <lavkesh51(a)gmail.com>
+ *	Andreas Ripke <ripke(a)neclab.eu>
+ *	Vlad Dogaru <vlad.dogaru(a)intel.com>
+ *	Octavian Purdila <octavian.purdila(a)intel.com>
+ *	John Ronan <jronan(a)tssg.org>
+ *	Catalin Nicutar <catalin.nicutar(a)gmail.com>
+ *	Brandon Heller <brandonh(a)stanford.edu>
+ *
+ *
+ *	This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _MPTCP_H
+#define _MPTCP_H
+
+#include <linux/inetdevice.h>
+#include <linux/ipv6.h>
+#include <linux/list.h>
+#include <linux/net.h>
+#include <linux/netpoll.h>
+#include <linux/skbuff.h>
+#include <linux/socket.h>
+#include <linux/tcp.h>
+#include <linux/kernel.h>
+
+#include <asm/byteorder.h>
+#include <asm/unaligned.h>
+#include <crypto/hash.h>
+#include <crypto/md5.h>
+#include <net/tcp.h>
+
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	#define ntohll(x)  be64_to_cpu(x)
+	#define htonll(x)  cpu_to_be64(x)
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	#define ntohll(x) (x)
+	#define htonll(x) (x)
+#endif
+
+extern const struct tcp_state_ops mptcp_state_ops;
+
+struct mptcp_loc4 {
+	u8		loc4_id;
+	u8		low_prio:1;
+	int		if_idx;
+	struct in_addr	addr;
+};
+
+struct mptcp_rem4 {
+	u8		rem4_id;
+	__be16		port;
+	struct in_addr	addr;
+};
+
+struct mptcp_loc6 {
+	u8		loc6_id;
+	u8		low_prio:1;
+	int		if_idx;
+	struct in6_addr	addr;
+};
+
+struct mptcp_rem6 {
+	u8		rem6_id;
+	__be16		port;
+	struct in6_addr	addr;
+};
+
+struct mptcp_request_sock {
+	struct tcp_request_sock		req;
+	/* hlist-nulls entry to the hash-table. Depending on whether this is a
+	 * a new MPTCP connection or an additional subflow, the request-socket
+	 * is either in the mptcp_reqsk_tk_htb or mptcp_reqsk_htb.
+	 */
+	struct hlist_nulls_node		hash_entry;
+
+	union {
+		struct {
+			/* Only on initial subflows */
+			u64		mptcp_loc_key;
+			u64		mptcp_rem_key;
+			u32		mptcp_loc_token;
+		};
+
+		struct {
+			/* Only on additional subflows */
+			struct mptcp_cb	*mptcp_mpcb;
+			u32		mptcp_rem_nonce;
+			u32		mptcp_loc_nonce;
+			u64		mptcp_hash_tmac;
+		};
+	};
+
+	u8				loc_id;
+	u8				rem_id; /* Address-id in the MP_JOIN */
+	u8				dss_csum:1,
+					is_sub:1, /* Is this a new subflow? */
+					low_prio:1, /* Interface set to low-prio? */
+					rcv_low_prio:1,
+					mptcp_ver:4;
+};
+
+struct mptcp_options_received {
+	u16	saw_mpc:1,
+		dss_csum:1,
+		drop_me:1,
+
+		is_mp_join:1,
+		join_ack:1,
+
+		saw_low_prio:2, /* 0x1 - low-prio set for this subflow
+				 * 0x2 - low-prio set for another subflow
+				 */
+		low_prio:1,
+
+		saw_add_addr:2, /* Saw at least one add_addr option:
+				 * 0x1: IPv4 - 0x2: IPv6
+				 */
+		more_add_addr:1, /* Saw one more add-addr. */
+
+		saw_rem_addr:1, /* Saw at least one rem_addr option */
+		more_rem_addr:1, /* Saw one more rem-addr. */
+
+		mp_fail:1,
+		mp_fclose:1;
+	u8	rem_id;		/* Address-id in the MP_JOIN */
+	u8	prio_addr_id;	/* Address-id in the MP_PRIO */
+
+	const unsigned char *add_addr_ptr; /* Pointer to add-address option */
+	const unsigned char *rem_addr_ptr; /* Pointer to rem-address option */
+
+	u32	data_ack;
+	u32	data_seq;
+	u16	data_len;
+
+	u8	mptcp_ver; /* MPTCP version */
+
+	/* Key inside the option (from mp_capable or fast_close) */
+	u64	mptcp_sender_key;
+	u64	mptcp_receiver_key;
+
+	u32	mptcp_rem_token; /* Remote token */
+
+	u32	mptcp_recv_nonce;
+	u64	mptcp_recv_tmac;
+	u8	mptcp_recv_mac[20];
+	u8	mptcp_dss_off;
+};
+
+struct mptcp_tcp_sock {
+	struct tcp_sock	*next;		/* Next subflow socket */
+	struct hlist_node cb_list;
+	struct mptcp_options_received rx_opt;
+	struct sk_buff *meta_skb;
+
+	 /* Those three fields record the current mapping */
+	u64	map_data_seq;
+	u32	map_subseq;
+	u16	map_data_len;
+	u16	slave_sk:1,
+		fully_established:1,
+		establish_increased:1,
+		second_packet:1,
+		attached:1,
+		send_mp_fail:1,
+		include_mpc:1,
+		mapping_present:1,
+		map_data_fin:1,
+		low_prio:1, /* use this socket as backup */
+		rcv_low_prio:1, /* Peer sent low-prio option to us */
+		send_mp_prio:1, /* Trigger to send mp_prio on this socket */
+		pre_established:1; /* State between sending 3rd ACK and
+				    * receiving the fourth ack of new subflows.
+				    */
+
+	/* isn: needed to translate abs to relative subflow seqnums */
+	u32	snt_isn;
+	u32	rcv_isn;
+	u8	path_index;
+	u8	loc_id;
+	u8	rem_id;
+
+#define MPTCP_SCHED_SIZE 16
+	u8	mptcp_sched[MPTCP_SCHED_SIZE] __aligned(8);
+
+	int	init_rcv_wnd;
+	u32	infinite_cutoff_seq;
+	struct delayed_work work;
+	u32	mptcp_loc_nonce;
+	struct tcp_sock *tp; /* Where is my daddy? */
+	u32	last_end_data_seq;
+
+	/* MP_JOIN subflow: timer for retransmitting the 3rd ack */
+	struct timer_list mptcp_ack_timer;
+
+	/* HMAC of the third ack */
+	char sender_mac[20];
+};
+
+struct mptcp_tw {
+	struct list_head list;
+	u64 loc_key;
+	u64 rcv_nxt;
+	struct mptcp_cb __rcu *mpcb;
+	u8 meta_tw:1,
+	   in_list:1;
+};
+
+#define MPTCP_PM_NAME_MAX 16
+struct mptcp_pm_ops {
+	struct list_head list;
+
+	/* Signal the creation of a new MPTCP-session. */
+	void (*new_session)(const struct sock *meta_sk);
+	void (*release_sock)(struct sock *meta_sk);
+	void (*fully_established)(struct sock *meta_sk);
+	void (*new_remote_address)(struct sock *meta_sk);
+	int  (*get_local_id)(sa_family_t family, union inet_addr *addr,
+			     struct net *net, bool *low_prio);
+	void (*addr_signal)(struct sock *sk, unsigned *size,
+			    struct tcp_out_options *opts, struct sk_buff *skb);
+	void (*add_raddr)(struct mptcp_cb *mpcb, const union inet_addr *addr,
+			  sa_family_t family, __be16 port, u8 id);
+	void (*rem_raddr)(struct mptcp_cb *mpcb, u8 rem_id);
+	void (*init_subsocket_v4)(struct sock *sk, struct in_addr addr);
+	void (*init_subsocket_v6)(struct sock *sk, struct in6_addr addr);
+
+	char		name[MPTCP_PM_NAME_MAX];
+	struct module	*owner;
+};
+
+#define MPTCP_SCHED_NAME_MAX 16
+struct mptcp_sched_ops {
+	struct list_head list;
+
+	struct sock *		(*get_subflow)(struct sock *meta_sk,
+					       struct sk_buff *skb,
+					       bool zero_wnd_test);
+	struct sk_buff *	(*next_segment)(struct sock *meta_sk,
+						int *reinject,
+						struct sock **subsk,
+						unsigned int *limit);
+	void			(*init)(struct sock *sk);
+	void			(*release)(struct sock *sk);
+
+	char			name[MPTCP_SCHED_NAME_MAX];
+	struct module		*owner;
+};
+
+struct mptcp_cb {
+	/* list of sockets in this multipath connection */
+	struct tcp_sock *connection_list;
+	/* list of sockets that need a call to release_cb */
+	struct hlist_head callback_list;
+
+	/* High-order bits of 64-bit sequence numbers */
+	u32 snd_high_order[2];
+	u32 rcv_high_order[2];
+
+	u16	send_infinite_mapping:1,
+		in_time_wait:1,
+		list_rcvd:1, /* XXX TO REMOVE */
+		addr_signal:1, /* Path-manager wants us to call addr_signal */
+		dss_csum:1,
+		server_side:1,
+		infinite_mapping_rcv:1,
+		infinite_mapping_snd:1,
+		dfin_combined:1,   /* Was the DFIN combined with subflow-fin? */
+		passive_close:1,
+		snd_hiseq_index:1, /* Index in snd_high_order of snd_nxt */
+		rcv_hiseq_index:1; /* Index in rcv_high_order of rcv_nxt */
+
+	/* socket count in this connection */
+	u8 cnt_subflows;
+	u8 cnt_established;
+
+#define MPTCP_SCHED_DATA_SIZE 8
+	u8 mptcp_sched[MPTCP_SCHED_DATA_SIZE] __aligned(8);
+	struct mptcp_sched_ops *sched_ops;
+
+	struct sk_buff_head reinject_queue;
+	/* First cache-line boundary is here minus 8 bytes. But from the
+	 * reinject-queue only the next and prev pointers are regularly
+	 * accessed. Thus, the whole data-path is on a single cache-line.
+	 */
+
+	u64	csum_cutoff_seq;
+	u64	infinite_rcv_seq;
+
+	/***** Start of fields, used for connection closure */
+	spinlock_t	 tw_lock;
+	unsigned char	 mptw_state;
+	u8		 dfin_path_index;
+
+	struct list_head tw_list;
+
+	/***** Start of fields, used for subflow establishment and closure */
+	atomic_t	mpcb_refcnt;
+
+	/* Mutex needed, because otherwise mptcp_close will complain that the
+	 * socket is owned by the user.
+	 * E.g., mptcp_sub_close_wq is taking the meta-lock.
+	 */
+	struct mutex	mpcb_mutex;
+
+	/***** Start of fields, used for subflow establishment */
+	struct sock *meta_sk;
+
+	/* Master socket, also part of the connection_list, this
+	 * socket is the one that the application sees.
+	 */
+	struct sock *master_sk;
+
+	__u64	mptcp_loc_key;
+	__u64	mptcp_rem_key;
+	__u32	mptcp_loc_token;
+	__u32	mptcp_rem_token;
+
+#define MPTCP_PM_SIZE 608
+	u8 mptcp_pm[MPTCP_PM_SIZE] __aligned(8);
+	struct mptcp_pm_ops *pm_ops;
+
+	u32 path_index_bits;
+	/* Next pi to pick up in case a new path becomes available */
+	u8 next_path_index;
+
+	__u8	mptcp_ver;
+
+	/* Original snd/rcvbuf of the initial subflow.
+	 * Used for the new subflows on the server-side to allow correct
+	 * autotuning
+	 */
+	int orig_sk_rcvbuf;
+	int orig_sk_sndbuf;
+	u32 orig_window_clamp;
+};
+
+#define MPTCP_VERSION_0 0
+#define MPTCP_VERSION_1 1
+
+#define MPTCP_SUB_CAPABLE			0
+#define MPTCP_SUB_LEN_CAPABLE_SYN		12
+#define MPTCP_SUB_LEN_CAPABLE_SYN_ALIGN		12
+#define MPTCP_SUB_LEN_CAPABLE_ACK		20
+#define MPTCP_SUB_LEN_CAPABLE_ACK_ALIGN		20
+
+#define MPTCP_SUB_JOIN			1
+#define MPTCP_SUB_LEN_JOIN_SYN		12
+#define MPTCP_SUB_LEN_JOIN_SYN_ALIGN	12
+#define MPTCP_SUB_LEN_JOIN_SYNACK	16
+#define MPTCP_SUB_LEN_JOIN_SYNACK_ALIGN	16
+#define MPTCP_SUB_LEN_JOIN_ACK		24
+#define MPTCP_SUB_LEN_JOIN_ACK_ALIGN	24
+
+#define MPTCP_SUB_DSS		2
+#define MPTCP_SUB_LEN_DSS	4
+#define MPTCP_SUB_LEN_DSS_ALIGN	4
+
+/* Lengths for seq and ack are the ones without the generic MPTCP-option h=
eader,
+ * as they are part of the DSS-option.
+ * To get the total length, just add the different options together.
+ */
+#define MPTCP_SUB_LEN_SEQ	10
+#define MPTCP_SUB_LEN_SEQ_CSUM	12
+#define MPTCP_SUB_LEN_SEQ_ALIGN	12
+
+#define MPTCP_SUB_LEN_SEQ_64		14
+#define MPTCP_SUB_LEN_SEQ_CSUM_64	16
+#define MPTCP_SUB_LEN_SEQ_64_ALIGN	16
+
+#define MPTCP_SUB_LEN_ACK	4
+#define MPTCP_SUB_LEN_ACK_ALIGN	4
+
+#define MPTCP_SUB_LEN_ACK_64		8
+#define MPTCP_SUB_LEN_ACK_64_ALIGN	8
+
+/* This is the "default" option-length we will send out most often.
+ * MPTCP DSS-header
+ * 32-bit data sequence number
+ * 32-bit data ack
+ *
+ * It is necessary to calculate the effective MSS we will be using when
+ * sending data.
+ */
+#define MPTCP_SUB_LEN_DSM_ALIGN  (MPTCP_SUB_LEN_DSS_ALIGN +		\
+				  MPTCP_SUB_LEN_SEQ_ALIGN +		\
+				  MPTCP_SUB_LEN_ACK_ALIGN)
+
+#define MPTCP_SUB_ADD_ADDR		3
+#define MPTCP_SUB_LEN_ADD_ADDR4		8
+#define MPTCP_SUB_LEN_ADD_ADDR4_VER1	16
+#define MPTCP_SUB_LEN_ADD_ADDR6		20
+#define MPTCP_SUB_LEN_ADD_ADDR6_VER1	28
+#define MPTCP_SUB_LEN_ADD_ADDR4_ALIGN	8
+#define MPTCP_SUB_LEN_ADD_ADDR4_ALIGN_VER1	16
+#define MPTCP_SUB_LEN_ADD_ADDR6_ALIGN	20
+#define MPTCP_SUB_LEN_ADD_ADDR6_ALIGN_VER1	28
+
+#define MPTCP_SUB_REMOVE_ADDR	4
+#define MPTCP_SUB_LEN_REMOVE_ADDR	4
+
+#define MPTCP_SUB_PRIO		5
+#define MPTCP_SUB_LEN_PRIO	3
+#define MPTCP_SUB_LEN_PRIO_ADDR	4
+#define MPTCP_SUB_LEN_PRIO_ALIGN	4
+
+#define MPTCP_SUB_FAIL		6
+#define MPTCP_SUB_LEN_FAIL	12
+#define MPTCP_SUB_LEN_FAIL_ALIGN	12
+
+#define MPTCP_SUB_FCLOSE	7
+#define MPTCP_SUB_LEN_FCLOSE	12
+#define MPTCP_SUB_LEN_FCLOSE_ALIGN	12
+
+#define	MPTCP_FLAG_DATA_ACKED		0x8000
+
+#define OPTION_MPTCP		(1 << 5)
+
+#ifdef CONFIG_MPTCP
+
+/* Used for checking if the mptcp initialization has been successful */
+extern bool mptcp_init_failed;
+
+/* MPTCP options */
+#define OPTION_TYPE_SYN		(1 << 0)
+#define OPTION_TYPE_SYNACK	(1 << 1)
+#define OPTION_TYPE_ACK		(1 << 2)
+#define OPTION_MP_CAPABLE	(1 << 3)
+#define OPTION_DATA_ACK		(1 << 4)
+#define OPTION_ADD_ADDR		(1 << 5)
+#define OPTION_MP_JOIN		(1 << 6)
+#define OPTION_MP_FAIL		(1 << 7)
+#define OPTION_MP_FCLOSE	(1 << 8)
+#define OPTION_REMOVE_ADDR	(1 << 9)
+#define OPTION_MP_PRIO		(1 << 10)
+
+/* MPTCP flags: both TX and RX */
+#define MPTCPHDR_SEQ		0x01 /* DSS.M option is present */
+#define MPTCPHDR_FIN		0x02 /* DSS.F option is present */
+#define MPTCPHDR_SEQ64_INDEX	0x04 /* index of seq in mpcb->snd_high_order =
*/
+/* MPTCP flags: RX only */
+#define MPTCPHDR_ACK		0x08
+#define MPTCPHDR_SEQ64_SET	0x10 /* Did we received a 64-bit seq number?  */
+#define MPTCPHDR_SEQ64_OFO	0x20 /* Is it not in our circular array? */
+#define MPTCPHDR_DSS_CSUM	0x40
+#define MPTCPHDR_JOIN		0x80
+/* MPTCP flags: TX only */
+#define MPTCPHDR_INF		0x08
+#define MPTCP_REINJECT		0x10 /* Did we reinject this segment? */
+
+struct mptcp_option {
+	__u8	kind;
+	__u8	len;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	__u8	ver:4,
+		sub:4;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	__u8	sub:4,
+		ver:4;
+#else
+#error	"Adjust your <asm/byteorder.h> defines"
+#endif
+};
+
+struct mp_capable {
+	__u8	kind;
+	__u8	len;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	__u8	ver:4,
+		sub:4;
+	__u8	h:1,
+		rsv:5,
+		b:1,
+		a:1;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	__u8	sub:4,
+		ver:4;
+	__u8	a:1,
+		b:1,
+		rsv:5,
+		h:1;
+#else
+#error	"Adjust your <asm/byteorder.h> defines"
+#endif
+	__u64	sender_key;
+	__u64	receiver_key;
+} __attribute__((__packed__));
+
+struct mp_join {
+	__u8	kind;
+	__u8	len;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	__u8	b:1,
+		rsv:3,
+		sub:4;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	__u8	sub:4,
+		rsv:3,
+		b:1;
+#else
+#error	"Adjust your <asm/byteorder.h> defines"
+#endif
+	__u8	addr_id;
+	union {
+		struct {
+			u32	token;
+			u32	nonce;
+		} syn;
+		struct {
+			__u64	mac;
+			u32	nonce;
+		} synack;
+		struct {
+			__u8	mac[20];
+		} ack;
+	} u;
+} __attribute__((__packed__));
+
+struct mp_dss {
+	__u8	kind;
+	__u8	len;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	__u16	rsv1:4,
+		sub:4,
+		A:1,
+		a:1,
+		M:1,
+		m:1,
+		F:1,
+		rsv2:3;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	__u16	sub:4,
+		rsv1:4,
+		rsv2:3,
+		F:1,
+		m:1,
+		M:1,
+		a:1,
+		A:1;
+#else
+#error	"Adjust your <asm/byteorder.h> defines"
+#endif
+};
+
+struct mp_add_addr {
+	__u8	kind;
+	__u8	len;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	__u8	ipver:4,
+		sub:4;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	__u8	sub:4,
+		ipver:4;
+#else
+#error	"Adjust your <asm/byteorder.h> defines"
+#endif
+	__u8	addr_id;
+	union {
+		struct {
+			struct in_addr	addr;
+			__be16		port;
+			__u8		mac[8];
+		} v4;
+		struct {
+			struct in6_addr	addr;
+			__be16		port;
+			__u8		mac[8];
+		} v6;
+	} u;
+} __attribute__((__packed__));
+
+struct mp_remove_addr {
+	__u8	kind;
+	__u8	len;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	__u8	rsv:4,
+		sub:4;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	__u8	sub:4,
+		rsv:4;
+#else
+#error "Adjust your <asm/byteorder.h> defines"
+#endif
+	/* list of addr_id */
+	__u8	addrs_id;
+};
+
+struct mp_fail {
+	__u8	kind;
+	__u8	len;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	__u16	rsv1:4,
+		sub:4,
+		rsv2:8;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	__u16	sub:4,
+		rsv1:4,
+		rsv2:8;
+#else
+#error	"Adjust your <asm/byteorder.h> defines"
+#endif
+	__be64	data_seq;
+} __attribute__((__packed__));
+
+struct mp_fclose {
+	__u8	kind;
+	__u8	len;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	__u16	rsv1:4,
+		sub:4,
+		rsv2:8;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	__u16	sub:4,
+		rsv1:4,
+		rsv2:8;
+#else
+#error	"Adjust your <asm/byteorder.h> defines"
+#endif
+	__u64	key;
+} __attribute__((__packed__));
+
+struct mp_prio {
+	__u8	kind;
+	__u8	len;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	__u8	b:1,
+		rsv:3,
+		sub:4;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	__u8	sub:4,
+		rsv:3,
+		b:1;
+#else
+#error	"Adjust your <asm/byteorder.h> defines"
+#endif
+	__u8	addr_id;
+} __attribute__((__packed__));
+
+static inline int mptcp_sub_len_dss(const struct mp_dss *m, const int csum)
+{
+	return 4 + m->A * (4 + m->a * 4) + m->M * (10 + m->m * 4 + csum * 2);
+}
+
+#define MPTCP_SYSCTL	1
+
+extern int sysctl_mptcp_enabled;
+extern int sysctl_mptcp_version;
+extern int sysctl_mptcp_checksum;
+extern int sysctl_mptcp_debug;
+extern int sysctl_mptcp_syn_retries;
+
+extern struct workqueue_struct *mptcp_wq;
+
+#define mptcp_debug(fmt, args...)					\
+	do {								\
+		if (unlikely(sysctl_mptcp_debug))			\
+			pr_err(__FILE__ ": " fmt, ##args);	\
+	} while (0)
+
+/* Iterates over all subflows */
+#define mptcp_for_each_tp(mpcb, tp)					\
+	for ((tp) =3D (mpcb)->connection_list; (tp); (tp) =3D (tp)->mptcp->next)
+
+#define mptcp_for_each_sk(mpcb, sk)					\
+	for ((sk) =3D (struct sock *)(mpcb)->connection_list;		\
+	     sk;							\
+	     sk =3D (struct sock *)tcp_sk(sk)->mptcp->next)
+
+#define mptcp_for_each_sk_safe(__mpcb, __sk, __temp)			\
+	for (__sk =3D (struct sock *)(__mpcb)->connection_list,		\
+	     __temp =3D __sk ? (struct sock *)tcp_sk(__sk)->mptcp->next : NULL; \
+	     __sk;							\
+	     __sk =3D __temp,						\
+	     __temp =3D __sk ? (struct sock *)tcp_sk(__sk)->mptcp->next : NULL)
+
+/* Iterates over all bit set to 1 in a bitset */
+#define mptcp_for_each_bit_set(b, i)					\
+	for (i =3D ffs(b) - 1; i >=3D 0; i =3D ffs(b >> (i + 1) << (i + 1)) - 1)
+
+#define mptcp_for_each_bit_unset(b, i)					\
+	mptcp_for_each_bit_set(~b, i)
+
+#define MPTCP_INC_STATS(net, field)	SNMP_INC_STATS((net)->mptcp.mptcp_stat=
istics, field)
+#define MPTCP_INC_STATS_BH(net, field)	__SNMP_INC_STATS((net)->mptcp.mptcp=
_statistics, field)
+
+enum
+{
+	MPTCP_MIB_NUM =3D 0,
+	MPTCP_MIB_MPCAPABLEPASSIVE,	/* Received SYN with MP_CAPABLE */
+	MPTCP_MIB_MPCAPABLEACTIVE,	/* Sent SYN with MP_CAPABLE */
+	MPTCP_MIB_MPCAPABLEACTIVEACK,	/* Received SYN/ACK with MP_CAPABLE */
+	MPTCP_MIB_MPCAPABLEPASSIVEACK,	/* Received third ACK with MP_CAPABLE */
+	MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK,/* Server-side fallback during 3-way h=
andshake */
+	MPTCP_MIB_MPCAPABLEACTIVEFALLBACK, /* Client-side fallback during 3-way h=
andshake */
+	MPTCP_MIB_MPCAPABLERETRANSFALLBACK,/* Client-side stopped sending MP_CAPA=
BLE after too many SYN-retransmissions */
+	MPTCP_MIB_CSUMENABLED,		/* Created MPTCP-connection with DSS-checksum ena=
bled */
+	MPTCP_MIB_RETRANSSEGS,		/* Segments retransmitted at the MPTCP-level */
+	MPTCP_MIB_MPFAILRX,		/* Received an MP_FAIL */
+	MPTCP_MIB_CSUMFAIL,		/* Received segment with invalid checksum */
+	MPTCP_MIB_FASTCLOSERX,		/* Recevied a FAST_CLOSE */
+	MPTCP_MIB_FASTCLOSETX,		/* Sent a FAST_CLOSE */
+	MPTCP_MIB_FBACKSUB,		/* Fallback upon ack without data-ack on new subflow=
 */
+	MPTCP_MIB_FBACKINIT,		/* Fallback upon ack without data-ack on initial su=
bflow */
+	MPTCP_MIB_FBDATASUB,		/* Fallback upon data without DSS at the beginning =
on new subflow */
+	MPTCP_MIB_FBDATAINIT,		/* Fallback upon data without DSS at the beginning=
 on initial subflow */
+	MPTCP_MIB_REMADDRSUB,		/* Remove subflow due to REMOVE_ADDR */
+	MPTCP_MIB_JOINNOTOKEN,		/* Received MP_JOIN but the token was not found */
+	MPTCP_MIB_JOINFALLBACK,		/* Received MP_JOIN on session that has fallen b=
ack to reg. TCP */
+	MPTCP_MIB_JOINSYNTX,		/* Sent a SYN + MP_JOIN */
+	MPTCP_MIB_JOINSYNRX,		/* Received a SYN + MP_JOIN */
+	MPTCP_MIB_JOINSYNACKRX,		/* Received a SYN/ACK + MP_JOIN */
+	MPTCP_MIB_JOINSYNACKMAC,	/* HMAC was wrong on SYN/ACK + MP_JOIN */
+	MPTCP_MIB_JOINACKRX,		/* Received an ACK + MP_JOIN */
+	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
+	MPTCP_MIB_JOINACKFAIL,		/* Third ACK on new subflow did not contain an MP=
_JOIN */
+	MPTCP_MIB_JOINACKRTO,		/* Retransmission timer for third ACK + MP_JOIN ti=
med out */
+	MPTCP_MIB_JOINACKRXMIT,		/* Retransmitted an ACK + MP_JOIN */
+	MPTCP_MIB_NODSSWINDOW,		/* Received too many packets without a DSS-option=
 */
+	MPTCP_MIB_DSSNOMATCH,		/* Received a new mapping that did not match the p=
revious one */
+	MPTCP_MIB_INFINITEMAPRX,	/* Received an infinite mapping */
+	MPTCP_MIB_DSSTCPMISMATCH,	/* DSS-mapping did not map with TCP's sequence =
numbers */
+	MPTCP_MIB_DSSTRIMHEAD,		/* Trimmed segment at the head (coalescing middle=
box) */
+	MPTCP_MIB_DSSSPLITTAIL,		/* Trimmed segment at the tail (coalescing middl=
ebox) */
+	MPTCP_MIB_PURGEOLD,		/* Removed old skb from the rcv-queue due to missing=
 DSS-mapping */
+	MPTCP_MIB_ADDADDRRX,		/* Received an ADD_ADDR */
+	MPTCP_MIB_ADDADDRTX,		/* Sent an ADD_ADDR */
+	MPTCP_MIB_REMADDRRX,		/* Received a REMOVE_ADDR */
+	MPTCP_MIB_REMADDRTX,		/* Sent a REMOVE_ADDR */
+	__MPTCP_MIB_MAX
+};
+
+#define MPTCP_MIB_MAX __MPTCP_MIB_MAX
+struct mptcp_mib {
+	unsigned long	mibs[MPTCP_MIB_MAX];
+};
+
+extern struct lock_class_key meta_key;
+extern char *meta_key_name;
+extern struct lock_class_key meta_slock_key;
+extern char *meta_slock_key_name;
+
+extern u32 mptcp_secret[MD5_MESSAGE_BYTES / 4];
+
+/* This is needed to ensure that two subsequent key/nonce-generation resul=
t in
+ * different keys/nonces if the IPs and ports are the same.
+ */
+extern u32 mptcp_seed;
+
+#define MPTCP_HASH_SIZE                1024
+
+extern struct hlist_nulls_head tk_hashtable[MPTCP_HASH_SIZE];
+
+/* This second hashtable is needed to retrieve request socks
+ * created as a result of a join request. While the SYN contains
+ * the token, the final ack does not, so we need a separate hashtable
+ * to retrieve the mpcb.
+ */
+extern struct hlist_nulls_head mptcp_reqsk_htb[MPTCP_HASH_SIZE];
+extern spinlock_t mptcp_reqsk_hlock;	/* hashtable protection */
+
+/* Lock, protecting the two hash-tables that hold the token. Namely,
+ * mptcp_reqsk_tk_htb and tk_hashtable
+ */
+extern spinlock_t mptcp_tk_hashlock;	/* hashtable protection */
+
+/* Request-sockets can be hashed in the tk_htb for collision-detection or =
in
+ * the regular htb for join-connections. We need to define different NULLS
+ * values so that we can correctly detect a request-socket that has been
+ * recycled. See also c25eb3bfb9729.
+ */
+#define MPTCP_REQSK_NULLS_BASE (1U << 29)
+
+void mptcp_data_ready(struct sock *sk);
+void mptcp_write_space(struct sock *sk);
+
+void mptcp_add_meta_ofo_queue(struct sock *meta_sk, struct sk_buff *skb);
+void mptcp_ofo_queue(struct sock *meta_sk);
+void mptcp_purge_ofo_queue(struct tcp_sock *meta_tp);
+void mptcp_cleanup_rbuf(struct sock *meta_sk, int copied);
+int mptcp_add_sock(struct sock *meta_sk, struct sock *sk, u8 loc_id, u8 re=
m_id,
+		   gfp_t flags);
+void mptcp_del_sock(struct sock *sk);
+void mptcp_update_metasocket(struct sock *sock, const struct sock *meta_sk=
);
+void mptcp_reinject_data(struct sock *orig_sk, int clone_it);
+void mptcp_update_sndbuf(const struct tcp_sock *tp);
+void mptcp_send_fin(struct sock *meta_sk);
+void mptcp_send_active_reset(struct sock *meta_sk, gfp_t priority);
+bool mptcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
+		      int push_one, gfp_t gfp);
+void tcp_parse_mptcp_options(struct sk_buff *skb,
+			     struct mptcp_options_received *mopt);
+void mptcp_parse_options(const uint8_t *ptr, int opsize,
+			 struct mptcp_options_received *mopt,
+			 struct sk_buff *skb,
+			 struct tcp_sock *tp);
+void mptcp_syn_options(const struct sock *sk, struct tcp_out_options *opts,
+		       unsigned *remaining);
+void mptcp_synack_options(struct request_sock *req,
+			  struct tcp_out_options *opts,
+			  unsigned *remaining);
+void mptcp_established_options(struct sock *sk, struct sk_buff *skb,
+			       struct tcp_out_options *opts, unsigned *size);
+void mptcp_options_write(__be32 **ptr, struct tcp_sock *tp,
+			 struct tcp_out_options *opts, struct sk_buff *skb);
+void mptcp_close(struct sock *meta_sk, long timeout);
+int mptcp_doit(struct sock *sk);
+int mptcp_create_master_sk(struct sock *meta_sk, __u64 remote_key,
+			   __u8 mptcp_ver, u32 window);
+int mptcp_check_req_fastopen(struct sock *child, struct request_sock *req);
+int mptcp_check_req_master(struct sock *sk, struct sock *child,
+			   struct request_sock *req, int drop);
+struct sock *mptcp_check_req_child(struct sock *sk, struct sock *child,
+				   struct request_sock *req,
+				   const struct mptcp_options_received *mopt);
+u32 __mptcp_select_window(struct sock *sk);
+void mptcp_select_initial_window(const struct sock *sk, int __space, __u32=
 mss, =

+				 __u32 *rcv_wnd, __u32 *window_clamp,
+				 int wscale_ok, __u8 *rcv_wscale,
+				 __u32 init_rcv_wnd);
+unsigned int mptcp_current_mss(struct sock *meta_sk);
+int mptcp_select_size(const struct sock *meta_sk, bool sg,
+		      bool first_skb, bool zc);
+void mptcp_key_sha1(u64 key, u32 *token, u64 *idsn);
+void mptcp_hmac_sha1(u8 *key_1, u8 *key_2, u32 *hash_out, int arg_num, ...=
);
+void mptcp_clean_rtx_infinite(const struct sk_buff *skb, struct sock *sk);
+void mptcp_fin(struct sock *meta_sk);
+void mptcp_meta_retransmit_timer(struct sock *meta_sk);
+void mptcp_sub_retransmit_timer(struct sock *sk);
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
+void mptcp_sub_close_wq(struct work_struct *work);
+void mptcp_sub_close(struct sock *sk, unsigned long delay);
+struct sock *mptcp_select_ack_sock(const struct sock *meta_sk);
+void mptcp_fallback_meta_sk(struct sock *meta_sk);
+int mptcp_backlog_rcv(struct sock *meta_sk, struct sk_buff *skb);
+void mptcp_ack_handler(struct timer_list *t);
+bool mptcp_check_rtt(struct sock *sk);
+void mptcp_sndbuf_expand(struct sock *sk);
+int mptcp_check_snd_buf(const struct tcp_sock *tp);
+bool mptcp_handle_options(struct sock *sk, const struct tcphdr *th,
+			  const struct sk_buff *skb);
+void __init mptcp_init(void);
+void mptcp_destroy_sock(struct sock *sk);
+unsigned int mptcp_xmit_size_goal(const struct sock *meta_sk, u32 mss_now,
+				  int large_allowed);
+int mptcp_init_tw_sock(struct sock *sk, struct tcp_timewait_sock *tw);
+void mptcp_twsk_destructor(struct tcp_timewait_sock *tw);
+void mptcp_time_wait(struct sock *sk, int state, int timeo);
+void mptcp_disconnect(struct sock *sk);
+bool mptcp_should_expand_sndbuf(const struct sock *sk);
+int mptcp_retransmit_skb(struct sock *meta_sk, struct sk_buff *skb);
+void mptcp_tsq_flags(struct sock *sk);
+void mptcp_tsq_sub_deferred(struct sock *meta_sk);
+struct mp_join *mptcp_find_join(const struct sk_buff *skb);
+void mptcp_hash_remove_bh(struct tcp_sock *meta_tp);
+void mptcp_hash_remove(struct tcp_sock *meta_tp);
+struct sock *mptcp_hash_find(const struct net *net, const u32 token);
+int mptcp_lookup_join(struct sk_buff *skb, struct inet_timewait_sock *tw);
+int mptcp_do_join_short(struct sk_buff *skb,
+			const struct mptcp_options_received *mopt,
+			struct net *net);
+void mptcp_reqsk_destructor(struct request_sock *req);
+int mptcp_check_req(struct sk_buff *skb, struct net *net);
+void mptcp_connect_init(struct sock *sk);
+void mptcp_sub_force_close(struct sock *sk);
+int mptcp_sub_len_remove_addr_align(u16 bitfield);
+void mptcp_init_buffer_space(struct sock *sk);
+void mptcp_join_reqsk_init(struct mptcp_cb *mpcb,
+			   const struct request_sock *req,
+			   struct sk_buff *skb);
+void mptcp_reqsk_init(struct request_sock *req, const struct sock *sk,
+		      struct sk_buff *skb,
+		      struct mptcp_options_received *mopt);
+int mptcp_conn_request(struct sock *sk, struct sk_buff *skb);
+struct sock *mptcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff =
*skb,
+				    struct request_sock *req,
+				    struct dst_entry *dst,
+				    struct request_sock *req_unhash,
+				    bool *own_req);
+void mptcp_enable_sock(struct sock *sk);
+void mptcp_disable_sock(struct sock *sk);
+void mptcp_enable_static_key(void);
+void mptcp_disable_static_key(void);
+void mptcp_cookies_reqsk_init(struct request_sock *req,
+			      struct mptcp_options_received *mopt,
+			      struct sk_buff *skb);
+void mptcp_sock_destruct(struct sock *sk);
+int mptcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
+			      const struct tcphdr *th);
+bool mptcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
+		   	     const struct tcphdr *th, int syn_inerr);
+
+/* MPTCP-path-manager registration/initialization functions */
+int mptcp_register_path_manager(struct mptcp_pm_ops *pm);
+void mptcp_unregister_path_manager(struct mptcp_pm_ops *pm);
+void mptcp_init_path_manager(struct mptcp_cb *mpcb);
+void mptcp_cleanup_path_manager(struct mptcp_cb *mpcb);
+void mptcp_fallback_default(struct mptcp_cb *mpcb);
+void mptcp_get_default_path_manager(char *name);
+int mptcp_set_default_path_manager(const char *name);
+extern struct mptcp_pm_ops mptcp_pm_default;
+
+/* MPTCP-scheduler registration/initialization functions */
+int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
+void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
+void mptcp_init_scheduler(struct mptcp_cb *mpcb);
+void mptcp_cleanup_scheduler(struct mptcp_cb *mpcb);
+void mptcp_get_default_scheduler(char *name);
+int mptcp_set_default_scheduler(const char *name);
+bool mptcp_is_available(struct sock *sk, const struct sk_buff *skb,
+			bool zero_wnd_test);
+bool mptcp_is_def_unavailable(struct sock *sk);
+bool subflow_is_active(const struct tcp_sock *tp);
+bool subflow_is_backup(const struct tcp_sock *tp);
+struct sock *get_available_subflow(struct sock *meta_sk, struct sk_buff *s=
kb,
+				   bool zero_wnd_test);
+void mptcp_v4_add_ack_opts(const struct sock *sk, struct sk_buff *skb,
+			   int *offset, struct ip_reply_arg *arg, __be32 *opt);
+void mptcp_v6_add_ack_opts(const struct sock *sk, struct sk_buff *skb,
+                           struct tcphdr *th, __be32 **toptr);
+extern struct mptcp_sched_ops mptcp_sched_default;
+
+extern struct static_key mptcp_static_key;
+static inline bool mptcp(const struct tcp_sock *tp)
+{
+	return static_key_false(&mptcp_static_key) && tp->mpc;
+}
+
+/* Initializes function-pointers and MPTCP-flags */
+static inline void mptcp_init_tcp_sock(struct sock *sk)
+{
+	if (!mptcp_init_failed && sysctl_mptcp_enabled =3D=3D MPTCP_SYSCTL)
+		mptcp_enable_sock(sk);
+}
+
+static inline int mptcp_pi_to_flag(int pi)
+{
+	return 1 << (pi - 1);
+}
+
+static inline
+struct mptcp_request_sock *mptcp_rsk(const struct request_sock *req)
+{
+	return (struct mptcp_request_sock *)req;
+}
+
+static inline
+struct request_sock *rev_mptcp_rsk(const struct mptcp_request_sock *req)
+{
+	return (struct request_sock *)req;
+}
+
+static inline bool mptcp_can_sendpage(struct sock *sk)
+{
+	struct sock *sk_it;
+
+	if (tcp_sk(sk)->mpcb->dss_csum)
+		return false;
+
+	mptcp_for_each_sk(tcp_sk(sk)->mpcb, sk_it) {
+		if (!(sk_it->sk_route_caps & NETIF_F_SG) ||
+		    !(sk_it->sk_route_caps & NETIF_F_HW_CSUM))
+			return false;
+	}
+
+	return true;
+}
+
+static inline void mptcp_push_pending_frames(struct sock *meta_sk)
+{
+	/* We check packets out and send-head here. TCP only checks the
+	 * send-head. But, MPTCP also checks packets_out, as this is an
+	 * indication that we might want to do opportunistic reinjection.
+	 */
+	if (tcp_sk(meta_sk)->packets_out || tcp_send_head(meta_sk)) {
+		struct tcp_sock *tp =3D tcp_sk(meta_sk);
+
+		/* We don't care about the MSS, because it will be set in
+		 * mptcp_write_xmit.
+		 */
+		__tcp_push_pending_frames(meta_sk, 0, tp->nonagle);
+	}
+}
+
+static inline void mptcp_send_reset(struct sock *sk)
+{
+	if (tcp_need_reset(sk->sk_state))
+		tcp_sk(sk)->op_ops->send_active_reset(sk, GFP_ATOMIC);
+	mptcp_sub_force_close(sk);
+}
+
+static inline void mptcp_sub_force_close_all(struct mptcp_cb *mpcb,
+					     struct sock *except)
+{
+	struct sock *sk_it, *tmp;
+
+	mptcp_for_each_sk_safe(mpcb, sk_it, tmp) {
+		if (sk_it !=3D except)
+			mptcp_send_reset(sk_it);
+	}
+}
+
+/* currently tp is being used for Rx packets */
+static inline bool mptcp_is_data_seq(const struct sk_buff *skb)
+{
+	return TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_SEQ;
+}
+
+static inline bool mptcp_is_data_fin(const struct sk_buff *skb)
+{
+	return TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_FIN;
+}
+
+/* Is it a data-fin while in infinite mapping mode?
+ * In infinite mode, a subflow-fin is in fact a data-fin.
+ */
+static inline bool mptcp_is_data_fin2(const struct sk_buff *skb,
+				     const struct tcp_sock *tp)
+{
+	return mptcp_is_data_fin(skb) ||
+	       (tp->mpcb->infinite_mapping_rcv &&
+	        (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN));
+}
+
+static inline u8 mptcp_get_64_bit(u64 data_seq, struct mptcp_cb *mpcb)
+{
+	u64 data_seq_high =3D (u32)(data_seq >> 32);
+
+	if (mpcb->rcv_high_order[0] =3D=3D data_seq_high)
+		return 0;
+	else if (mpcb->rcv_high_order[1] =3D=3D data_seq_high)
+		return MPTCPHDR_SEQ64_INDEX;
+	else
+		return MPTCPHDR_SEQ64_OFO;
+}
+
+/* Sets the data_seq and returns pointer to the in-skb field of the data_s=
eq.
+ * If the packet has a 64-bit dseq, the pointer points to the last 32 bits.
+ */
+static inline __u32 *mptcp_skb_set_data_seq(struct tcp_sock *tp,
+					    struct sk_buff *skb,
+					    u32 *data_seq,
+					    struct mptcp_cb *mpcb)
+{
+	__u32 *ptr =3D (__u32 *)(skb_transport_header(skb) + tp->mptcp->rx_opt.mp=
tcp_dss_off);
+
+	if (TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_SEQ64_SET) {
+		u64 data_seq64 =3D get_unaligned_be64(ptr);
+
+		if (mpcb)
+			TCP_SKB_CB(skb)->mptcp_flags |=3D
+				mptcp_get_64_bit(data_seq64, mpcb);
+
+		*data_seq =3D (u32)data_seq64;
+		ptr++;
+	} else {
+		*data_seq =3D get_unaligned_be32(ptr);
+	}
+
+	return ptr;
+}
+
+static inline struct sock *mptcp_meta_sk(const struct sock *sk)
+{
+	return tcp_sk(sk)->meta_sk;
+}
+
+static inline struct tcp_sock *mptcp_meta_tp(const struct tcp_sock *tp)
+{
+	return tcp_sk(tp->meta_sk);
+}
+
+static inline int is_meta_tp(const struct tcp_sock *tp)
+{
+	return tp->mpcb && mptcp_meta_tp(tp) =3D=3D tp;
+}
+
+static inline int is_meta_sk(const struct sock *sk)
+{
+	return sk->sk_type =3D=3D SOCK_STREAM  && sk->sk_protocol =3D=3D IPPROTO_=
TCP &&
+	       mptcp(tcp_sk(sk)) && mptcp_meta_sk(sk) =3D=3D sk;
+}
+
+static inline int is_master_tp(const struct tcp_sock *tp)
+{
+	return !mptcp(tp) || (!tp->mptcp->slave_sk && !is_meta_tp(tp));
+}
+
+static inline void mptcp_hash_request_remove(struct request_sock *req)
+{
+	int in_softirq =3D 0;
+
+	if (hlist_nulls_unhashed(&mptcp_rsk(req)->hash_entry))
+		return;
+
+	if (in_softirq()) {
+		spin_lock(&mptcp_reqsk_hlock);
+		in_softirq =3D 1;
+	} else {
+		spin_lock_bh(&mptcp_reqsk_hlock);
+	}
+
+	hlist_nulls_del_init_rcu(&mptcp_rsk(req)->hash_entry);
+
+	if (in_softirq)
+		spin_unlock(&mptcp_reqsk_hlock);
+	else
+		spin_unlock_bh(&mptcp_reqsk_hlock);
+}
+
+static inline void mptcp_init_mp_opt(struct mptcp_options_received *mopt)
+{
+	mopt->saw_mpc =3D 0;
+	mopt->dss_csum =3D 0;
+	mopt->drop_me =3D 0;
+
+	mopt->is_mp_join =3D 0;
+	mopt->join_ack =3D 0;
+
+	mopt->saw_low_prio =3D 0;
+	mopt->low_prio =3D 0;
+
+	mopt->saw_add_addr =3D 0;
+	mopt->more_add_addr =3D 0;
+
+	mopt->saw_rem_addr =3D 0;
+	mopt->more_rem_addr =3D 0;
+
+	mopt->mp_fail =3D 0;
+	mopt->mp_fclose =3D 0;
+
+	mopt->mptcp_dss_off =3D 0;
+}
+
+static inline void mptcp_reset_mopt(struct tcp_sock *tp)
+{
+	struct mptcp_options_received *mopt =3D &tp->mptcp->rx_opt;
+
+	mopt->saw_low_prio =3D 0;
+	mopt->saw_add_addr =3D 0;
+	mopt->more_add_addr =3D 0;
+	mopt->saw_rem_addr =3D 0;
+	mopt->more_rem_addr =3D 0;
+	mopt->join_ack =3D 0;
+	mopt->mp_fail =3D 0;
+	mopt->mp_fclose =3D 0;
+}
+
+static inline __be32 mptcp_get_highorder_sndbits(const struct sk_buff *skb,
+						 const struct mptcp_cb *mpcb)
+{
+	return htonl(mpcb->snd_high_order[(TCP_SKB_CB(skb)->mptcp_flags &
+			MPTCPHDR_SEQ64_INDEX) ? 1 : 0]);
+}
+
+static inline u64 mptcp_get_data_seq_64(const struct mptcp_cb *mpcb, int i=
ndex,
+					u32 data_seq_32)
+{
+	return ((u64)mpcb->rcv_high_order[index] << 32) | data_seq_32;
+}
+
+static inline u64 mptcp_get_rcv_nxt_64(const struct tcp_sock *meta_tp)
+{
+	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
+	return mptcp_get_data_seq_64(mpcb, mpcb->rcv_hiseq_index,
+				     meta_tp->rcv_nxt);
+}
+
+static inline void mptcp_check_sndseq_wrap(struct tcp_sock *meta_tp, int i=
nc)
+{
+	if (unlikely(meta_tp->snd_nxt > meta_tp->snd_nxt + inc)) {
+		struct mptcp_cb *mpcb =3D meta_tp->mpcb;
+		mpcb->snd_hiseq_index =3D mpcb->snd_hiseq_index ? 0 : 1;
+		mpcb->snd_high_order[mpcb->snd_hiseq_index] +=3D 2;
+	}
+}
+
+static inline void mptcp_check_rcvseq_wrap(struct tcp_sock *meta_tp,
+					   u32 old_rcv_nxt)
+{
+	if (unlikely(old_rcv_nxt > meta_tp->rcv_nxt)) {
+		struct mptcp_cb *mpcb =3D meta_tp->mpcb;
+		mpcb->rcv_high_order[mpcb->rcv_hiseq_index] +=3D 2;
+		mpcb->rcv_hiseq_index =3D mpcb->rcv_hiseq_index ? 0 : 1;
+	}
+}
+
+static inline int mptcp_sk_can_send(const struct sock *sk)
+{
+	return tcp_passive_fastopen(sk) ||
+	       ((1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT) &&
+		!tcp_sk(sk)->mptcp->pre_established);
+}
+
+static inline int mptcp_sk_can_recv(const struct sock *sk)
+{
+	return (1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_FIN_WAIT1 | TCPF_FI=
N_WAIT2);
+}
+
+static inline int mptcp_sk_can_send_ack(const struct sock *sk)
+{
+	return !((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV |
+					TCPF_CLOSE | TCPF_LISTEN)) &&
+	       !tcp_sk(sk)->mptcp->pre_established;
+}
+
+/* Only support GSO if all subflows supports it */
+static inline bool mptcp_sk_can_gso(const struct sock *meta_sk)
+{
+	struct sock *sk;
+
+	if (tcp_sk(meta_sk)->mpcb->dss_csum)
+		return false;
+
+	mptcp_for_each_sk(tcp_sk(meta_sk)->mpcb, sk) {
+		if (!mptcp_sk_can_send(sk))
+			continue;
+		if (!sk_can_gso(sk))
+			return false;
+	}
+	return true;
+}
+
+static inline bool mptcp_can_sg(const struct sock *meta_sk)
+{
+	struct sock *sk;
+
+	if (tcp_sk(meta_sk)->mpcb->dss_csum)
+		return false;
+
+	mptcp_for_each_sk(tcp_sk(meta_sk)->mpcb, sk) {
+		if (!mptcp_sk_can_send(sk))
+			continue;
+		if (!(sk->sk_route_caps & NETIF_F_SG))
+			return false;
+	}
+	return true;
+}
+
+static inline void mptcp_set_rto(struct sock *sk)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct sock *sk_it;
+	struct inet_connection_sock *micsk =3D inet_csk(mptcp_meta_sk(sk));
+	__u32 max_rto =3D 0;
+
+	/* We are in recovery-phase on the MPTCP-level. Do not update the
+	 * RTO, because this would kill exponential backoff.
+	 */
+	if (micsk->icsk_retransmits)
+		return;
+
+	mptcp_for_each_sk(tp->mpcb, sk_it) {
+		if (mptcp_sk_can_send(sk_it) &&
+		    inet_csk(sk_it)->icsk_rto > max_rto)
+			max_rto =3D inet_csk(sk_it)->icsk_rto;
+	}
+	if (max_rto) {
+		micsk->icsk_rto =3D max_rto << 1;
+
+		/* A successfull rto-measurement - reset backoff counter */
+		micsk->icsk_backoff =3D 0;
+	}
+}
+
+static inline void mptcp_sub_close_passive(struct sock *sk)
+{
+	struct sock *meta_sk =3D mptcp_meta_sk(sk);
+	struct tcp_sock *tp =3D tcp_sk(sk), *meta_tp =3D tcp_sk(meta_sk);
+
+	/* Only close, if the app did a send-shutdown (passive close), and we
+	 * received the data-ack of the data-fin.
+	 */
+	if (tp->mpcb->passive_close && meta_tp->snd_una =3D=3D meta_tp->write_seq)
+		mptcp_sub_close(sk, 0);
+}
+
+static inline bool mptcp_fallback_infinite(struct sock *sk, int flag)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct mptcp_cb *mpcb =3D tp->mpcb;
+
+	/* If data has been acknowleged on the meta-level, fully_established
+	 * will have been set before and thus we will not fall back to infinite
+	 * mapping.
+	 */
+	if (likely(tp->mptcp->fully_established))
+		return false;
+
+	if (!(flag & MPTCP_FLAG_DATA_ACKED))
+		return false;
+
+	/* Don't fallback twice ;) */
+	if (mpcb->infinite_mapping_snd)
+		return false;
+
+	pr_err("%s %#x will fallback - pi %d, src %pI4 dst %pI4 from %pS\n",
+	       __func__, mpcb->mptcp_loc_token, tp->mptcp->path_index,
+	       &inet_sk(sk)->inet_saddr, &inet_sk(sk)->inet_daddr,
+	       __builtin_return_address(0));
+	if (!is_master_tp(tp)) {
+		MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_FBACKSUB);
+		return true;
+	}
+
+	mpcb->infinite_mapping_snd =3D 1;
+	mpcb->infinite_mapping_rcv =3D 1;
+	mpcb->infinite_rcv_seq =3D mptcp_get_rcv_nxt_64(mptcp_meta_tp(tp));
+	tp->mptcp->fully_established =3D 1;
+
+	mptcp_sub_force_close_all(mpcb, sk);
+
+	MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_FBACKINIT);
+
+	return false;
+}
+
+/* Find the first index whose bit in the bit-field =3D=3D 0 */
+static inline u8 mptcp_set_new_pathindex(struct mptcp_cb *mpcb)
+{
+	u8 base =3D mpcb->next_path_index;
+	int i;
+
+	/* Start at 1, because 0 is reserved for the meta-sk */
+	mptcp_for_each_bit_unset(mpcb->path_index_bits >> base, i) {
+		if (i + base < 1)
+			continue;
+		if (i + base >=3D sizeof(mpcb->path_index_bits) * 8)
+			break;
+		i +=3D base;
+		mpcb->path_index_bits |=3D (1 << i);
+		mpcb->next_path_index =3D i + 1;
+		return i;
+	}
+	mptcp_for_each_bit_unset(mpcb->path_index_bits, i) {
+		if (i >=3D sizeof(mpcb->path_index_bits) * 8)
+			break;
+		if (i < 1)
+			continue;
+		mpcb->path_index_bits |=3D (1 << i);
+		mpcb->next_path_index =3D i + 1;
+		return i;
+	}
+
+	return 0;
+}
+
+static inline bool mptcp_v6_is_v4_mapped(const struct sock *sk)
+{
+	return sk->sk_family =3D=3D AF_INET6 &&
+	       ipv6_addr_type(&inet6_sk(sk)->saddr) =3D=3D IPV6_ADDR_MAPPED;
+}
+
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
+/* TCP and MPTCP mpc flag-depending functions */
+u16 mptcp_select_window(struct sock *sk);
+void mptcp_init_buffer_space(struct sock *sk);
+void mptcp_tcp_set_rto(struct sock *sk);
+
+/* TCP and MPTCP flag-depending functions */
+bool mptcp_prune_ofo_queue(struct sock *sk);
+
+int mptcp_mtu_probe(struct sock *sk);
+void mptcp_retrans_try_collapse(struct sock *sk, struct sk_buff *to, int s=
pace);
+
+int mptcp_process_join_req(struct sock *meta_sk, struct sk_buff *skb);
+int mptcp_do_rcv(const struct sock *meta_sk, struct sk_buff *skb);
+
+#endif /* CONFIG_MPTCP */
+
+#endif /* _MPTCP_H */
diff --git a/include/net/mptcp_v4.h b/include/net/mptcp_v4.h
new file mode 100644
index 0000000..143523e
--- /dev/null
+++ b/include/net/mptcp_v4.h
@@ -0,0 +1,56 @@
+/*
+ *	MPTCP implementation
+ *
+ *	Initial Design & Implementation:
+ *	S=C3=A9bastien Barr=C3=A9 <sebastien.barre(a)uclouvain.be>
+ *
+ *	Current Maintainer & Author:
+ *	Christoph Paasch <christoph.paasch(a)uclouvain.be>
+ *
+ *	Additional authors:
+ *	Jaakko Korkeaniemi <jaakko.korkeaniemi(a)aalto.fi>
+ *	Gregory Detal <gregory.detal(a)uclouvain.be>
+ *	Fabien Duch=C3=AAne <fabien.duchene(a)uclouvain.be>
+ *	Andreas Seelinger <Andreas.Seelinger(a)rwth-aachen.de>
+ *	Lavkesh Lahngir <lavkesh51(a)gmail.com>
+ *	Andreas Ripke <ripke(a)neclab.eu>
+ *	Vlad Dogaru <vlad.dogaru(a)intel.com>
+ *	Octavian Purdila <octavian.purdila(a)intel.com>
+ *	John Ronan <jronan(a)tssg.org>
+ *	Catalin Nicutar <catalin.nicutar(a)gmail.com>
+ *	Brandon Heller <brandonh(a)stanford.edu>
+ *
+ *
+ *	This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+
+#ifndef MPTCP_V4_H_
+#define MPTCP_V4_H_
+
+
+#include <linux/in.h>
+#include <linux/skbuff.h>
+#include <net/mptcp.h>
+#include <net/request_sock.h>
+#include <net/sock.h>
+
+extern struct request_sock_ops mptcp_request_sock_ops;
+extern const struct inet_connection_sock_af_ops mptcp_v4_specific;
+extern struct tcp_request_sock_ops mptcp_request_sock_ipv4_ops;
+extern struct tcp_request_sock_ops mptcp_join_request_sock_ipv4_ops;
+
+#ifdef CONFIG_MPTCP
+
+int mptcp_init4_subsockets(struct sock *meta_sk, const struct mptcp_loc4 *=
loc,
+			   struct mptcp_rem4 *rem);
+int mptcp_pm_v4_init(void);
+void mptcp_pm_v4_undo(void);
+
+int mptcp_v6_join_request(struct sock *meta_sk, struct sk_buff *skb);
+
+#endif /* CONFIG_MPTCP */
+
+#endif /* MPTCP_V4_H_ */
diff --git a/include/net/mptcp_v6.h b/include/net/mptcp_v6.h
new file mode 100644
index 0000000..e75615b
--- /dev/null
+++ b/include/net/mptcp_v6.h
@@ -0,0 +1,56 @@
+/*
+ *	MPTCP implementation
+ *
+ *	Initial Design & Implementation:
+ *	S=C3=A9bastien Barr=C3=A9 <sebastien.barre(a)uclouvain.be>
+ *
+ *	Current Maintainer & Author:
+ *	Jaakko Korkeaniemi <jaakko.korkeaniemi(a)aalto.fi>
+ *
+ *	Additional authors:
+ *	Jaakko Korkeaniemi <jaakko.korkeaniemi(a)aalto.fi>
+ *	Gregory Detal <gregory.detal(a)uclouvain.be>
+ *	Fabien Duch=C3=AAne <fabien.duchene(a)uclouvain.be>
+ *	Andreas Seelinger <Andreas.Seelinger(a)rwth-aachen.de>
+ *	Lavkesh Lahngir <lavkesh51(a)gmail.com>
+ *	Andreas Ripke <ripke(a)neclab.eu>
+ *	Vlad Dogaru <vlad.dogaru(a)intel.com>
+ *	Octavian Purdila <octavian.purdila(a)intel.com>
+ *	John Ronan <jronan(a)tssg.org>
+ *	Catalin Nicutar <catalin.nicutar(a)gmail.com>
+ *	Brandon Heller <brandonh(a)stanford.edu>
+ *
+ *
+ *	This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _MPTCP_V6_H
+#define _MPTCP_V6_H
+
+#include <linux/in6.h>
+#include <net/if_inet6.h>
+
+#include <net/mptcp.h>
+
+
+#ifdef CONFIG_MPTCP
+extern const struct inet_connection_sock_af_ops mptcp_v6_mapped;
+extern const struct inet_connection_sock_af_ops mptcp_v6_specific;
+extern struct request_sock_ops mptcp6_request_sock_ops;
+extern struct tcp_request_sock_ops mptcp_request_sock_ipv6_ops;
+extern struct tcp_request_sock_ops mptcp_join_request_sock_ipv6_ops;
+
+int mptcp_v6_do_rcv(struct sock *meta_sk, struct sk_buff *skb);
+struct sock *mptcp_v6_search_req(const __be16 rport, const struct in6_addr=
 *raddr,
+				 const struct in6_addr *laddr, const struct net *net);
+int mptcp_init6_subsockets(struct sock *meta_sk, const struct mptcp_loc6 *=
loc,
+			   struct mptcp_rem6 *rem);
+int mptcp_pm_v6_init(void);
+void mptcp_pm_v6_undo(void);
+
+#endif /* CONFIG_MPTCP */
+
+#endif /* _MPTCP_V6_H */
diff --git a/include/net/netns/mptcp.h b/include/net/netns/mptcp.h
new file mode 100644
index 0000000..6680f3b
--- /dev/null
+++ b/include/net/netns/mptcp.h
@@ -0,0 +1,52 @@
+/*
+ *	MPTCP implementation - MPTCP namespace
+ *
+ *	Initial Design & Implementation:
+ *	S=C3=A9bastien Barr=C3=A9 <sebastien.barre(a)uclouvain.be>
+ *
+ *	Current Maintainer:
+ *	Christoph Paasch <christoph.paasch(a)uclouvain.be>
+ *
+ *	Additional authors:
+ *	Jaakko Korkeaniemi <jaakko.korkeaniemi(a)aalto.fi>
+ *	Gregory Detal <gregory.detal(a)uclouvain.be>
+ *	Fabien Duch=C3=AAne <fabien.duchene(a)uclouvain.be>
+ *	Andreas Seelinger <Andreas.Seelinger(a)rwth-aachen.de>
+ *	Lavkesh Lahngir <lavkesh51(a)gmail.com>
+ *	Andreas Ripke <ripke(a)neclab.eu>
+ *	Vlad Dogaru <vlad.dogaru(a)intel.com>
+ *	Octavian Purdila <octavian.purdila(a)intel.com>
+ *	John Ronan <jronan(a)tssg.org>
+ *	Catalin Nicutar <catalin.nicutar(a)gmail.com>
+ *	Brandon Heller <brandonh(a)stanford.edu>
+ *
+ *
+ *	This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+
+#ifndef __NETNS_MPTCP_H__
+#define __NETNS_MPTCP_H__
+
+#include <linux/compiler.h>
+
+enum {
+	MPTCP_PM_FULLMESH =3D 0,
+	MPTCP_PM_MAX
+};
+
+struct mptcp_mib;
+
+struct netns_mptcp {
+	DEFINE_SNMP_STAT(struct mptcp_mib, mptcp_statistics);
+
+#ifdef CONFIG_PROC_FS
+	struct proc_dir_entry *proc_net_mptcp;
+#endif
+
+	void *path_managers[MPTCP_PM_MAX];
+};
+
+#endif /* __NETNS_MPTCP_H__ */
diff --git a/net/Kconfig b/net/Kconfig
index 0428f12..d70128e 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -88,6 +88,7 @@ if INET
 source "net/ipv4/Kconfig"
 source "net/ipv6/Kconfig"
 source "net/netlabel/Kconfig"
+source "net/mptcp/Kconfig"
 =

 endif # if INET
 =

diff --git a/net/Makefile b/net/Makefile
index a6147c6..d9a55c0 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_TLS)		+=3D tls/
 obj-$(CONFIG_XFRM)		+=3D xfrm/
 obj-$(CONFIG_UNIX)		+=3D unix/
 obj-$(CONFIG_NET)		+=3D ipv6/
+obj-$(CONFIG_MPTCP)		+=3D mptcp/
 obj-$(CONFIG_PACKET)		+=3D packet/
 obj-$(CONFIG_NET_KEY)		+=3D key/
 obj-$(CONFIG_BRIDGE)		+=3D bridge/
diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
new file mode 100644
index 0000000..13cf4d5
--- /dev/null
+++ b/net/mptcp/Kconfig
@@ -0,0 +1,129 @@
+#
+# MPTCP configuration
+#
+config MPTCP
+        bool "MPTCP protocol"
+        depends on (IPV6=3Dy || IPV6=3Dn)
+        ---help---
+          This replaces the normal TCP stack with a Multipath TCP stack,
+          able to use several paths at once.
+
+menuconfig MPTCP_PM_ADVANCED
+	bool "MPTCP: advanced path-manager control"
+	depends on MPTCP=3Dy
+	---help---
+	  Support for selection of different path-managers. You should choose 'Y'=
 here,
+	  because otherwise you will not actively create new MPTCP-subflows.
+
+if MPTCP_PM_ADVANCED
+
+config MPTCP_FULLMESH
+	tristate "MPTCP Full-Mesh Path-Manager"
+	depends on MPTCP=3Dy
+	---help---
+	  This path-management module will create a full-mesh among all IP-addres=
ses.
+
+config MPTCP_NDIFFPORTS
+	tristate "MPTCP ndiff-ports"
+	depends on MPTCP=3Dy
+	---help---
+	  This path-management module will create multiple subflows between the s=
ame
+	  pair of IP-addresses, modifying the source-port. You can set the number
+	  of subflows via the mptcp_ndiffports-sysctl.
+
+config MPTCP_BINDER
+	tristate "MPTCP Binder"
+	depends on (MPTCP=3Dy)
+	---help---
+	  This path-management module works like ndiffports, and adds the sysctl
+	  option to set the gateway (and/or path to) per each additional subflow
+	  via Loose Source Routing (IPv4 only).
+
+choice
+	prompt "Default MPTCP Path-Manager"
+	default DEFAULT
+	help
+	  Select the Path-Manager of your choice
+
+	config DEFAULT_FULLMESH
+		bool "Full mesh" if MPTCP_FULLMESH=3Dy
+
+	config DEFAULT_NDIFFPORTS
+		bool "ndiff-ports" if MPTCP_NDIFFPORTS=3Dy
+
+	config DEFAULT_BINDER
+		bool "binder" if MPTCP_BINDER=3Dy
+
+	config DEFAULT_DUMMY
+		bool "Default"
+
+endchoice
+
+endif
+
+config DEFAULT_MPTCP_PM
+	string
+	default "default" if DEFAULT_DUMMY
+	default "fullmesh" if DEFAULT_FULLMESH =

+	default "ndiffports" if DEFAULT_NDIFFPORTS
+	default "binder" if DEFAULT_BINDER
+	default "default"
+
+menuconfig MPTCP_SCHED_ADVANCED
+	bool "MPTCP: advanced scheduler control"
+	depends on MPTCP=3Dy
+	---help---
+	  Support for selection of different schedulers. You should choose 'Y' he=
re,
+	  if you want to choose a different scheduler than the default one.
+
+if MPTCP_SCHED_ADVANCED
+
+config MPTCP_ROUNDROBIN
+	tristate "MPTCP Round-Robin"
+	depends on (MPTCP=3Dy)
+	---help---
+	  This is a very simple round-robin scheduler. Probably has bad performan=
ce
+	  but might be interesting for researchers.
+
+config MPTCP_REDUNDANT
+	tristate "MPTCP Redundant"
+	depends on (MPTCP=3Dy)
+	---help---
+	  This scheduler sends all packets redundantly over all subflows to decre=
ases
+	  latency and jitter on the cost of lower throughput.
+
+choice
+	prompt "Default MPTCP Scheduler"
+	default DEFAULT
+	help
+	  Select the Scheduler of your choice
+
+	config DEFAULT_SCHEDULER
+		bool "Default"
+		---help---
+		  This is the default scheduler, sending first on the subflow
+		  with the lowest RTT.
+
+	config DEFAULT_ROUNDROBIN
+		bool "Round-Robin" if MPTCP_ROUNDROBIN=3Dy
+		---help---
+		  This is the round-rob scheduler, sending in a round-robin
+		  fashion..
+
+	config DEFAULT_REDUNDANT
+		bool "Redundant" if MPTCP_REDUNDANT=3Dy
+		---help---
+		  This is the redundant scheduler, sending packets redundantly over
+		  all the subflows.
+
+endchoice
+endif
+
+config DEFAULT_MPTCP_SCHED
+	string
+	depends on (MPTCP=3Dy)
+	default "default" if DEFAULT_SCHEDULER
+	default "roundrobin" if DEFAULT_ROUNDROBIN
+	default "redundant" if DEFAULT_REDUNDANT
+	default "default"
+
diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
new file mode 100644
index 0000000..10a98ba
--- /dev/null
+++ b/net/mptcp/Makefile
@@ -0,0 +1,22 @@
+#
+## Makefile for MultiPath TCP support code.
+#
+#
+
+obj-$(CONFIG_MPTCP) +=3D mptcp.o
+
+mptcp-y :=3D mptcp_ctrl.o mptcp_ipv4.o mptcp_ofo_queue.o mptcp_pm.o \
+	   mptcp_output.o mptcp_input.o mptcp_sched.o
+
+obj-$(CONFIG_TCP_CONG_LIA) +=3D mptcp_coupled.o
+obj-$(CONFIG_TCP_CONG_OLIA) +=3D mptcp_olia.o
+obj-$(CONFIG_TCP_CONG_WVEGAS) +=3D mptcp_wvegas.o
+obj-$(CONFIG_TCP_CONG_BALIA) +=3D mptcp_balia.o
+obj-$(CONFIG_MPTCP_FULLMESH) +=3D mptcp_fullmesh.o
+obj-$(CONFIG_MPTCP_NDIFFPORTS) +=3D mptcp_ndiffports.o
+obj-$(CONFIG_MPTCP_BINDER) +=3D mptcp_binder.o
+obj-$(CONFIG_MPTCP_ROUNDROBIN) +=3D mptcp_rr.o
+obj-$(CONFIG_MPTCP_REDUNDANT) +=3D mptcp_redundant.o
+
+mptcp-$(subst m,y,$(CONFIG_IPV6)) +=3D mptcp_ipv6.o
+
diff --git a/net/mptcp/mptcp_balia.c b/net/mptcp/mptcp_balia.c
new file mode 100644
index 0000000..9206338
--- /dev/null
+++ b/net/mptcp/mptcp_balia.c
@@ -0,0 +1,267 @@
+/*
+ *	MPTCP implementation - Balia Congestion Control
+ *	(Balanced Linked Adaptation Algorithm)
+ *
+ *	Analysis, Design and Implementation:
+ *	Qiuyu Peng <qpeng(a)caltech.edu>
+ *	Anwar Walid <anwar(a)research.bell-labs.com>
+ *	Jaehyun Hwang <jhyun.hwang(a)samsung.com>
+ *	Steven H. Low <slow(a)caltech.edu>
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+
+#include <net/tcp.h>
+#include <net/mptcp.h>
+
+#include <linux/module.h>
+
+/* The variable 'rate' (i.e., x_r) will be scaled
+ * e.g., from B/s to KB/s, MB/s, or GB/s
+ * if max_rate > 2^rate_scale_limit
+ */
+
+static int rate_scale_limit =3D 25;
+static int alpha_scale =3D 10;
+static int scale_num =3D 5;
+
+struct mptcp_balia {
+	u64	ai;
+	u64	md;
+	bool	forced_update;
+};
+
+static inline int mptcp_balia_sk_can_send(const struct sock *sk)
+{
+	return mptcp_sk_can_send(sk) && tcp_sk(sk)->srtt_us;
+}
+
+static inline u64 mptcp_get_ai(const struct sock *meta_sk)
+{
+	return ((struct mptcp_balia *)inet_csk_ca(meta_sk))->ai;
+}
+
+static inline void mptcp_set_ai(const struct sock *meta_sk, u64 ai)
+{
+	((struct mptcp_balia *)inet_csk_ca(meta_sk))->ai =3D ai;
+}
+
+static inline u64 mptcp_get_md(const struct sock *meta_sk)
+{
+	return ((struct mptcp_balia *)inet_csk_ca(meta_sk))->md;
+}
+
+static inline void mptcp_set_md(const struct sock *meta_sk, u64 md)
+{
+	((struct mptcp_balia *)inet_csk_ca(meta_sk))->md =3D md;
+}
+
+static inline u64 mptcp_balia_scale(u64 val, int scale)
+{
+	return (u64) val << scale;
+}
+
+static inline bool mptcp_get_forced(const struct sock *meta_sk)
+{
+	return ((struct mptcp_balia *)inet_csk_ca(meta_sk))->forced_update;
+}
+
+static inline void mptcp_set_forced(const struct sock *meta_sk, bool force)
+{
+	((struct mptcp_balia *)inet_csk_ca(meta_sk))->forced_update =3D force;
+}
+
+static void mptcp_balia_recalc_ai(const struct sock *sk)
+{
+	const struct tcp_sock *tp =3D tcp_sk(sk);
+	const struct mptcp_cb *mpcb =3D tp->mpcb;
+	const struct sock *sub_sk;
+	u64 max_rate =3D 0, rate =3D 0, sum_rate =3D 0;
+	u64 alpha, ai =3D tp->snd_cwnd, md =3D (tp->snd_cwnd >> 1);
+	int num_scale_down =3D 0;
+
+	if (!mpcb)
+		return;
+
+	/* Only one subflow left - fall back to normal reno-behavior */
+	if (mpcb->cnt_established <=3D 1)
+		goto exit;
+
+	/* Find max_rate first */
+	mptcp_for_each_sk(mpcb, sub_sk) {
+		struct tcp_sock *sub_tp =3D tcp_sk(sub_sk);
+		u64 tmp;
+
+		if (!mptcp_balia_sk_can_send(sub_sk))
+			continue;
+
+		tmp =3D div_u64((u64)tp->mss_cache * sub_tp->snd_cwnd
+				* (USEC_PER_SEC << 3), sub_tp->srtt_us);
+		sum_rate +=3D tmp;
+
+		if (tp =3D=3D sub_tp)
+			rate =3D tmp;
+
+		if (tmp >=3D max_rate)
+			max_rate =3D tmp;
+	}
+
+	/* At least, the current subflow should be able to send */
+	if (unlikely(!rate))
+		goto exit;
+
+	alpha =3D div64_u64(max_rate, rate);
+
+	/* Scale down max_rate if it is too high (e.g., >2^25) */
+	while (max_rate > mptcp_balia_scale(1, rate_scale_limit)) {
+		max_rate >>=3D scale_num;
+		num_scale_down++;
+	}
+
+	if (num_scale_down) {
+		sum_rate =3D 0;
+		mptcp_for_each_sk(mpcb, sub_sk) {
+			struct tcp_sock *sub_tp =3D tcp_sk(sub_sk);
+			u64 tmp;
+
+			if (!mptcp_balia_sk_can_send(sub_sk))
+				continue;
+
+			tmp =3D div_u64((u64)tp->mss_cache * sub_tp->snd_cwnd
+				* (USEC_PER_SEC << 3), sub_tp->srtt_us);
+			tmp >>=3D (scale_num * num_scale_down);
+
+			sum_rate +=3D tmp;
+		}
+		rate >>=3D (scale_num * num_scale_down);
+	}
+
+	/*	(sum_rate)^2 * 10 * w_r
+	 * ai =3D ------------------------------------
+	 *	(x_r + max_rate) * (4x_r + max_rate)
+	 */
+	sum_rate *=3D sum_rate;
+
+	ai =3D div64_u64(sum_rate * 10, rate + max_rate);
+	ai =3D div64_u64(ai * tp->snd_cwnd, (rate << 2) + max_rate);
+
+	if (unlikely(!ai))
+		ai =3D tp->snd_cwnd;
+
+	md =3D ((tp->snd_cwnd >> 1) * min(mptcp_balia_scale(alpha, alpha_scale),
+					mptcp_balia_scale(3, alpha_scale) >> 1))
+					>> alpha_scale;
+
+exit:
+	mptcp_set_ai(sk, ai);
+	mptcp_set_md(sk, md);
+}
+
+static void mptcp_balia_init(struct sock *sk)
+{
+	if (mptcp(tcp_sk(sk))) {
+		mptcp_set_forced(sk, 0);
+		mptcp_set_ai(sk, 0);
+		mptcp_set_md(sk, 0);
+	}
+}
+
+static void mptcp_balia_cwnd_event(struct sock *sk, enum tcp_ca_event even=
t)
+{
+	if (event =3D=3D CA_EVENT_COMPLETE_CWR || event =3D=3D CA_EVENT_LOSS)
+		mptcp_balia_recalc_ai(sk);
+}
+
+static void mptcp_balia_set_state(struct sock *sk, u8 ca_state)
+{
+	if (!mptcp(tcp_sk(sk)))
+		return;
+
+	mptcp_set_forced(sk, 1);
+}
+
+static void mptcp_balia_cong_avoid(struct sock *sk, u32 ack, u32 acked)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	const struct mptcp_cb *mpcb =3D tp->mpcb;
+	int snd_cwnd;
+
+	if (!mptcp(tp)) {
+		tcp_reno_cong_avoid(sk, ack, acked);
+		return;
+	}
+
+	if (!tcp_is_cwnd_limited(sk))
+		return;
+
+	if (tp->snd_cwnd <=3D tp->snd_ssthresh) {
+		/* In "safe" area, increase. */
+		tcp_slow_start(tp, acked);
+		mptcp_balia_recalc_ai(sk);
+		return;
+	}
+
+	if (mptcp_get_forced(mptcp_meta_sk(sk))) {
+		mptcp_balia_recalc_ai(sk);
+		mptcp_set_forced(sk, 0);
+	}
+
+	if (mpcb->cnt_established > 1)
+		snd_cwnd =3D (int) mptcp_get_ai(sk);
+	else
+		snd_cwnd =3D tp->snd_cwnd;
+
+	if (tp->snd_cwnd_cnt >=3D snd_cwnd) {
+		if (tp->snd_cwnd < tp->snd_cwnd_clamp) {
+			tp->snd_cwnd++;
+			mptcp_balia_recalc_ai(sk);
+		}
+
+		tp->snd_cwnd_cnt =3D 0;
+	} else {
+		tp->snd_cwnd_cnt++;
+	}
+}
+
+static u32 mptcp_balia_ssthresh(struct sock *sk)
+{
+	const struct tcp_sock *tp =3D tcp_sk(sk);
+	const struct mptcp_cb *mpcb =3D tp->mpcb;
+
+	if (unlikely(!mptcp(tp) || mpcb->cnt_established <=3D 1))
+		return tcp_reno_ssthresh(sk);
+	else
+		return max((u32)(tp->snd_cwnd - mptcp_get_md(sk)), 1U);
+}
+
+static struct tcp_congestion_ops mptcp_balia =3D {
+	.init		=3D mptcp_balia_init,
+	.ssthresh	=3D mptcp_balia_ssthresh,
+	.cong_avoid	=3D mptcp_balia_cong_avoid,
+	.cwnd_event	=3D mptcp_balia_cwnd_event,
+	.set_state	=3D mptcp_balia_set_state,
+	.owner		=3D THIS_MODULE,
+	.name		=3D "balia",
+};
+
+static int __init mptcp_balia_register(void)
+{
+	BUILD_BUG_ON(sizeof(struct mptcp_balia) > ICSK_CA_PRIV_SIZE);
+	return tcp_register_congestion_control(&mptcp_balia);
+}
+
+static void __exit mptcp_balia_unregister(void)
+{
+	tcp_unregister_congestion_control(&mptcp_balia);
+}
+
+module_init(mptcp_balia_register);
+module_exit(mptcp_balia_unregister);
+
+MODULE_AUTHOR("Jaehyun Hwang, Anwar Walid, Qiuyu Peng, Steven H. Low");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MPTCP BALIA CONGESTION CONTROL ALGORITHM");
+MODULE_VERSION("0.1");
diff --git a/net/mptcp/mptcp_binder.c b/net/mptcp/mptcp_binder.c
new file mode 100644
index 0000000..93d3f86
--- /dev/null
+++ b/net/mptcp/mptcp_binder.c
@@ -0,0 +1,487 @@
+#include <linux/module.h>
+
+#include <net/mptcp.h>
+#include <net/mptcp_v4.h>
+
+#include <linux/route.h>
+#include <linux/inet.h>
+#include <linux/mroute.h>
+#include <linux/spinlock_types.h>
+#include <net/inet_ecn.h>
+#include <net/route.h>
+#include <net/xfrm.h>
+#include <net/compat.h>
+#include <linux/slab.h>
+
+#define MPTCP_GW_MAX_LISTS	10
+#define MPTCP_GW_LIST_MAX_LEN	6
+#define MPTCP_GW_SYSCTL_MAX_LEN	(15 * MPTCP_GW_LIST_MAX_LEN *	\
+							MPTCP_GW_MAX_LISTS)
+
+struct mptcp_gw_list {
+	struct in_addr list[MPTCP_GW_MAX_LISTS][MPTCP_GW_LIST_MAX_LEN];
+	u8 len[MPTCP_GW_MAX_LISTS];
+};
+
+struct binder_priv {
+	/* Worker struct for subflow establishment */
+	struct work_struct subflow_work;
+
+	struct mptcp_cb *mpcb;
+
+	/* Prevent multiple sub-sockets concurrently iterating over sockets */
+	spinlock_t *flow_lock;
+};
+
+static struct mptcp_gw_list *mptcp_gws;
+static rwlock_t mptcp_gws_lock;
+
+static int mptcp_binder_ndiffports __read_mostly =3D 1;
+
+static char sysctl_mptcp_binder_gateways[MPTCP_GW_SYSCTL_MAX_LEN] __read_m=
ostly;
+
+static int mptcp_get_avail_list_ipv4(struct sock *sk)
+{
+	int i, j, list_taken, opt_ret, opt_len;
+	unsigned char *opt_ptr, *opt_end_ptr, opt[MAX_IPOPTLEN];
+
+	for (i =3D 0; i < MPTCP_GW_MAX_LISTS; ++i) {
+		if (mptcp_gws->len[i] =3D=3D 0)
+			goto error;
+
+		mptcp_debug("mptcp_get_avail_list_ipv4: List %i\n", i);
+		list_taken =3D 0;
+
+		/* Loop through all sub-sockets in this connection */
+		mptcp_for_each_sk(tcp_sk(sk)->mpcb, sk) {
+			mptcp_debug("mptcp_get_avail_list_ipv4: Next sock\n");
+
+			/* Reset length and options buffer, then retrieve
+			 * from socket
+			 */
+			opt_len =3D MAX_IPOPTLEN;
+			memset(opt, 0, MAX_IPOPTLEN);
+			opt_ret =3D ip_getsockopt(sk, IPPROTO_IP,
+				IP_OPTIONS, opt, &opt_len);
+			if (opt_ret < 0) {
+				mptcp_debug(KERN_ERR "%s: MPTCP subsocket getsockopt() IP_OPTIONS fail=
ed, error %d\n",
+					    __func__, opt_ret);
+				goto error;
+			}
+
+			/* If socket has no options, it has no stake in this list */
+			if (opt_len <=3D 0)
+				continue;
+
+			/* Iterate options buffer */
+			for (opt_ptr =3D &opt[0]; opt_ptr < &opt[opt_len]; opt_ptr++) {
+				if (*opt_ptr =3D=3D IPOPT_LSRR) {
+					mptcp_debug("mptcp_get_avail_list_ipv4: LSRR options found\n");
+					goto sock_lsrr;
+				}
+			}
+			continue;
+
+sock_lsrr:
+			/* Pointer to the 2nd to last address */
+			opt_end_ptr =3D opt_ptr+(*(opt_ptr+1))-4;
+
+			/* Addresses start 3 bytes after type offset */
+			opt_ptr +=3D 3;
+			j =3D 0;
+
+			/* Different length lists cannot be the same */
+			if ((opt_end_ptr-opt_ptr)/4 !=3D mptcp_gws->len[i])
+				continue;
+
+			/* Iterate if we are still inside options list
+			 * and sysctl list
+			 */
+			while (opt_ptr < opt_end_ptr && j < mptcp_gws->len[i]) {
+				/* If there is a different address, this list must
+				 * not be set on this socket
+				 */
+				if (memcmp(&mptcp_gws->list[i][j], opt_ptr, 4))
+					break;
+
+				/* Jump 4 bytes to next address */
+				opt_ptr +=3D 4;
+				j++;
+			}
+
+			/* Reached the end without a differing address, lists
+			 * are therefore identical.
+			 */
+			if (j =3D=3D mptcp_gws->len[i]) {
+				mptcp_debug("mptcp_get_avail_list_ipv4: List already used\n");
+				list_taken =3D 1;
+				break;
+			}
+		}
+
+		/* Free list found if not taken by a socket */
+		if (!list_taken) {
+			mptcp_debug("mptcp_get_avail_list_ipv4: List free\n");
+			break;
+		}
+	}
+
+	if (i >=3D MPTCP_GW_MAX_LISTS)
+		goto error;
+
+	return i;
+error:
+	return -1;
+}
+
+/* The list of addresses is parsed each time a new connection is opened,
+ *  to make sure it's up to date. In case of error, all the lists are
+ *  marked as unavailable and the subflow's fingerprint is set to 0.
+ */
+static void mptcp_v4_add_lsrr(struct sock *sk, struct in_addr addr)
+{
+	int i, j, ret;
+	unsigned char opt[MAX_IPOPTLEN] =3D {0};
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct binder_priv *fmp =3D (struct binder_priv *)&tp->mpcb->mptcp_pm[0];
+
+	/* Read lock: multiple sockets can read LSRR addresses at the same
+	 * time, but writes are done in mutual exclusion.
+	 * Spin lock: must search for free list for one socket at a time, or
+	 * multiple sockets could take the same list.
+	 */
+	read_lock(&mptcp_gws_lock);
+	spin_lock(fmp->flow_lock);
+
+	i =3D mptcp_get_avail_list_ipv4(sk);
+
+	/* Execution enters here only if a free path is found.
+	 */
+	if (i >=3D 0) {
+		opt[0] =3D IPOPT_NOP;
+		opt[1] =3D IPOPT_LSRR;
+		opt[2] =3D sizeof(mptcp_gws->list[i][0].s_addr) *
+				(mptcp_gws->len[i] + 1) + 3;
+		opt[3] =3D IPOPT_MINOFF;
+		for (j =3D 0; j < mptcp_gws->len[i]; ++j)
+			memcpy(opt + 4 +
+				(j * sizeof(mptcp_gws->list[i][0].s_addr)),
+				&mptcp_gws->list[i][j].s_addr,
+				sizeof(mptcp_gws->list[i][0].s_addr));
+		/* Final destination must be part of IP_OPTIONS parameter. */
+		memcpy(opt + 4 + (j * sizeof(addr.s_addr)), &addr.s_addr,
+		       sizeof(addr.s_addr));
+
+		/* setsockopt must be inside the lock, otherwise another
+		 * subflow could fail to see that we have taken a list.
+		 */
+		ret =3D ip_setsockopt(sk, IPPROTO_IP, IP_OPTIONS, opt,
+				4 + sizeof(mptcp_gws->list[i][0].s_addr)
+				* (mptcp_gws->len[i] + 1));
+
+		if (ret < 0) {
+			mptcp_debug(KERN_ERR "%s: MPTCP subsock setsockopt() IP_OPTIONS failed,=
 error %d\n",
+				    __func__, ret);
+		}
+	}
+
+	spin_unlock(fmp->flow_lock);
+	read_unlock(&mptcp_gws_lock);
+
+	return;
+}
+
+/* Parses gateways string for a list of paths to different
+ * gateways, and stores them for use with the Loose Source Routing (LSRR)
+ * socket option. Each list must have "," separated addresses, and the lis=
ts
+ * themselves must be separated by "-". Returns -1 in case one or more of =
the
+ * addresses is not a valid ipv4/6 address.
+ */
+static int mptcp_parse_gateway_ipv4(char *gateways)
+{
+	int i, j, k, ret;
+	char *tmp_string =3D NULL;
+	struct in_addr tmp_addr;
+
+	tmp_string =3D kzalloc(16, GFP_KERNEL);
+	if (tmp_string =3D=3D NULL)
+		return -ENOMEM;
+
+	write_lock(&mptcp_gws_lock);
+
+	memset(mptcp_gws, 0, sizeof(struct mptcp_gw_list));
+
+	/* A TMP string is used since inet_pton needs a null terminated string
+	 * but we do not want to modify the sysctl for obvious reasons.
+	 * i will iterate over the SYSCTL string, j will iterate over the
+	 * temporary string where each IP is copied into, k will iterate over
+	 * the IPs in each list.
+	 */
+	for (i =3D j =3D k =3D 0;
+			i < MPTCP_GW_SYSCTL_MAX_LEN && k < MPTCP_GW_MAX_LISTS;
+			++i) {
+		if (gateways[i] =3D=3D '-' || gateways[i] =3D=3D ',' || gateways[i] =3D=
=3D '\0') {
+			/* If the temp IP is empty and the current list is
+			 *  empty, we are done.
+			 */
+			if (j =3D=3D 0 && mptcp_gws->len[k] =3D=3D 0)
+				break;
+
+			/* Terminate the temp IP string, then if it is
+			 * non-empty parse the IP and copy it.
+			 */
+			tmp_string[j] =3D '\0';
+			if (j > 0) {
+				mptcp_debug("mptcp_parse_gateway_list tmp: %s i: %d\n", tmp_string, i);
+
+				ret =3D in4_pton(tmp_string, strlen(tmp_string),
+						(u8 *)&tmp_addr.s_addr, '\0',
+						NULL);
+
+				if (ret) {
+					mptcp_debug("mptcp_parse_gateway_list ret: %d s_addr: %pI4\n",
+						    ret,
+						    &tmp_addr.s_addr);
+					memcpy(&mptcp_gws->list[k][mptcp_gws->len[k]].s_addr,
+					       &tmp_addr.s_addr,
+					       sizeof(tmp_addr.s_addr));
+					mptcp_gws->len[k]++;
+					j =3D 0;
+					tmp_string[j] =3D '\0';
+					/* Since we can't impose a limit to
+					 * what the user can input, make sure
+					 * there are not too many IPs in the
+					 * SYSCTL string.
+					 */
+					if (mptcp_gws->len[k] > MPTCP_GW_LIST_MAX_LEN) {
+						mptcp_debug("mptcp_parse_gateway_list too many members in list %i: m=
ax %i\n",
+							    k,
+							    MPTCP_GW_LIST_MAX_LEN);
+						goto error;
+					}
+				} else {
+					goto error;
+				}
+			}
+
+			if (gateways[i] =3D=3D '-' || gateways[i] =3D=3D '\0')
+				++k;
+		} else {
+			tmp_string[j] =3D gateways[i];
+			++j;
+		}
+	}
+
+	/* Number of flows is number of gateway lists plus master flow */
+	mptcp_binder_ndiffports =3D k+1;
+
+	write_unlock(&mptcp_gws_lock);
+	kfree(tmp_string);
+
+	return 0;
+
+error:
+	memset(mptcp_gws, 0, sizeof(struct mptcp_gw_list));
+	memset(gateways, 0, sizeof(char) * MPTCP_GW_SYSCTL_MAX_LEN);
+	write_unlock(&mptcp_gws_lock);
+	kfree(tmp_string);
+	return -1;
+}
+
+/**
+ * Create all new subflows, by doing calls to mptcp_initX_subsockets
+ *
+ * This function uses a goto next_subflow, to allow releasing the lock bet=
ween
+ * new subflows and giving other processes a chance to do some work on the
+ * socket and potentially finishing the communication.
+ **/
+static void create_subflow_worker(struct work_struct *work)
+{
+	const struct binder_priv *pm_priv =3D container_of(work,
+						     struct binder_priv,
+						     subflow_work);
+	struct mptcp_cb *mpcb =3D pm_priv->mpcb;
+	struct sock *meta_sk =3D mpcb->meta_sk;
+	int iter =3D 0;
+
+next_subflow:
+	if (iter) {
+		release_sock(meta_sk);
+		mutex_unlock(&mpcb->mpcb_mutex);
+
+		cond_resched();
+	}
+	mutex_lock(&mpcb->mpcb_mutex);
+	lock_sock_nested(meta_sk, SINGLE_DEPTH_NESTING);
+
+	iter++;
+
+	if (sock_flag(meta_sk, SOCK_DEAD))
+		goto exit;
+
+	if (mpcb->master_sk &&
+	    !tcp_sk(mpcb->master_sk)->mptcp->fully_established)
+		goto exit;
+
+	if (mptcp_binder_ndiffports > iter &&
+	    mptcp_binder_ndiffports > mpcb->cnt_subflows) {
+		struct mptcp_loc4 loc;
+		struct mptcp_rem4 rem;
+
+		loc.addr.s_addr =3D inet_sk(meta_sk)->inet_saddr;
+		loc.loc4_id =3D 0;
+		loc.low_prio =3D 0;
+
+		rem.addr.s_addr =3D inet_sk(meta_sk)->inet_daddr;
+		rem.port =3D inet_sk(meta_sk)->inet_dport;
+		rem.rem4_id =3D 0; /* Default 0 */
+
+		mptcp_init4_subsockets(meta_sk, &loc, &rem);
+
+		goto next_subflow;
+	}
+
+exit:
+	release_sock(meta_sk);
+	mutex_unlock(&mpcb->mpcb_mutex);
+	sock_put(meta_sk);
+}
+
+static void binder_new_session(const struct sock *meta_sk)
+{
+	struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
+	struct binder_priv *fmp =3D (struct binder_priv *)&mpcb->mptcp_pm[0];
+	static DEFINE_SPINLOCK(flow_lock);
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (meta_sk->sk_family =3D=3D AF_INET6 &&
+	    !mptcp_v6_is_v4_mapped(meta_sk)) {
+			mptcp_fallback_default(mpcb);
+			return;
+	}
+#endif
+
+	/* Initialize workqueue-struct */
+	INIT_WORK(&fmp->subflow_work, create_subflow_worker);
+	fmp->mpcb =3D mpcb;
+
+	fmp->flow_lock =3D &flow_lock;
+}
+
+static void binder_create_subflows(struct sock *meta_sk)
+{
+	struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
+	struct binder_priv *pm_priv =3D (struct binder_priv *)&mpcb->mptcp_pm[0];
+
+	if (mpcb->infinite_mapping_snd || mpcb->infinite_mapping_rcv ||
+	    mpcb->send_infinite_mapping ||
+	    mpcb->server_side || sock_flag(meta_sk, SOCK_DEAD))
+		return;
+
+	if (!work_pending(&pm_priv->subflow_work)) {
+		sock_hold(meta_sk);
+		queue_work(mptcp_wq, &pm_priv->subflow_work);
+	}
+}
+
+static int binder_get_local_id(sa_family_t family, union inet_addr *addr,
+				  struct net *net, bool *low_prio)
+{
+	return 0;
+}
+
+/* Callback functions, executed when syctl mptcp.mptcp_gateways is updated.
+ * Inspired from proc_tcp_congestion_control().
+ */
+static int proc_mptcp_gateways(struct ctl_table *ctl, int write,
+			       void __user *buffer, size_t *lenp,
+			       loff_t *ppos)
+{
+	int ret;
+	struct ctl_table tbl =3D {
+		.maxlen =3D MPTCP_GW_SYSCTL_MAX_LEN,
+	};
+
+	if (write) {
+		tbl.data =3D kzalloc(MPTCP_GW_SYSCTL_MAX_LEN, GFP_KERNEL);
+		if (tbl.data =3D=3D NULL)
+			return -1;
+		ret =3D proc_dostring(&tbl, write, buffer, lenp, ppos);
+		if (ret =3D=3D 0) {
+			ret =3D mptcp_parse_gateway_ipv4(tbl.data);
+			memcpy(ctl->data, tbl.data, MPTCP_GW_SYSCTL_MAX_LEN);
+		}
+		kfree(tbl.data);
+	} else {
+		ret =3D proc_dostring(ctl, write, buffer, lenp, ppos);
+	}
+
+
+	return ret;
+}
+
+static struct mptcp_pm_ops binder __read_mostly =3D {
+	.new_session =3D binder_new_session,
+	.fully_established =3D binder_create_subflows,
+	.get_local_id =3D binder_get_local_id,
+	.init_subsocket_v4 =3D mptcp_v4_add_lsrr,
+	.name =3D "binder",
+	.owner =3D THIS_MODULE,
+};
+
+static struct ctl_table binder_table[] =3D {
+	{
+		.procname =3D "mptcp_binder_gateways",
+		.data =3D &sysctl_mptcp_binder_gateways,
+		.maxlen =3D sizeof(char) * MPTCP_GW_SYSCTL_MAX_LEN,
+		.mode =3D 0644,
+		.proc_handler =3D &proc_mptcp_gateways
+	},
+	{ }
+};
+
+struct ctl_table_header *mptcp_sysctl_binder;
+
+/* General initialization of MPTCP_PM */
+static int __init binder_register(void)
+{
+	mptcp_gws =3D kzalloc(sizeof(*mptcp_gws), GFP_KERNEL);
+	if (!mptcp_gws)
+		return -ENOMEM;
+
+	rwlock_init(&mptcp_gws_lock);
+
+	BUILD_BUG_ON(sizeof(struct binder_priv) > MPTCP_PM_SIZE);
+
+	mptcp_sysctl_binder =3D register_net_sysctl(&init_net, "net/mptcp",
+			binder_table);
+	if (!mptcp_sysctl_binder)
+		goto sysctl_fail;
+
+	if (mptcp_register_path_manager(&binder))
+		goto pm_failed;
+
+	return 0;
+
+pm_failed:
+	unregister_net_sysctl_table(mptcp_sysctl_binder);
+sysctl_fail:
+	kfree(mptcp_gws);
+
+	return -1;
+}
+
+static void binder_unregister(void)
+{
+	mptcp_unregister_path_manager(&binder);
+	unregister_net_sysctl_table(mptcp_sysctl_binder);
+	kfree(mptcp_gws);
+}
+
+module_init(binder_register);
+module_exit(binder_unregister);
+
+MODULE_AUTHOR("Luca Boccassi, Duncan Eastoe, Christoph Paasch (ndiffports)=
");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("BINDER MPTCP");
+MODULE_VERSION("0.1");
diff --git a/net/mptcp/mptcp_coupled.c b/net/mptcp/mptcp_coupled.c
new file mode 100644
index 0000000..5d76116
--- /dev/null
+++ b/net/mptcp/mptcp_coupled.c
@@ -0,0 +1,270 @@
+/*
+ *	MPTCP implementation - Linked Increase congestion control Algorithm (LI=
A)
+ *
+ *	Initial Design & Implementation:
+ *	S=C3=A9bastien Barr=C3=A9 <sebastien.barre(a)uclouvain.be>
+ *
+ *	Current Maintainer & Author:
+ *	Christoph Paasch <christoph.paasch(a)uclouvain.be>
+ *
+ *	Additional authors:
+ *	Jaakko Korkeaniemi <jaakko.korkeaniemi(a)aalto.fi>
+ *	Gregory Detal <gregory.detal(a)uclouvain.be>
+ *	Fabien Duch=C3=AAne <fabien.duchene(a)uclouvain.be>
+ *	Andreas Seelinger <Andreas.Seelinger(a)rwth-aachen.de>
+ *	Lavkesh Lahngir <lavkesh51(a)gmail.com>
+ *	Andreas Ripke <ripke(a)neclab.eu>
+ *	Vlad Dogaru <vlad.dogaru(a)intel.com>
+ *	Octavian Purdila <octavian.purdila(a)intel.com>
+ *	John Ronan <jronan(a)tssg.org>
+ *	Catalin Nicutar <catalin.nicutar(a)gmail.com>
+ *	Brandon Heller <brandonh(a)stanford.edu>
+ *
+ *
+ *	This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+#include <net/tcp.h>
+#include <net/mptcp.h>
+
+#include <linux/module.h>
+
+/* Scaling is done in the numerator with alpha_scale_num and in the denomi=
nator
+ * with alpha_scale_den.
+ *
+ * To downscale, we just need to use alpha_scale.
+ *
+ * We have: alpha_scale =3D alpha_scale_num / (alpha_scale_den ^ 2)
+ */
+static int alpha_scale_den =3D 10;
+static int alpha_scale_num =3D 32;
+static int alpha_scale =3D 12;
+
+struct mptcp_ccc {
+	u64	alpha;
+	bool	forced_update;
+};
+
+static inline int mptcp_ccc_sk_can_send(const struct sock *sk)
+{
+	return mptcp_sk_can_send(sk) && tcp_sk(sk)->srtt_us;
+}
+
+static inline u64 mptcp_get_alpha(const struct sock *meta_sk)
+{
+	return ((struct mptcp_ccc *)inet_csk_ca(meta_sk))->alpha;
+}
+
+static inline void mptcp_set_alpha(const struct sock *meta_sk, u64 alpha)
+{
+	((struct mptcp_ccc *)inet_csk_ca(meta_sk))->alpha =3D alpha;
+}
+
+static inline u64 mptcp_ccc_scale(u32 val, int scale)
+{
+	return (u64) val << scale;
+}
+
+static inline bool mptcp_get_forced(const struct sock *meta_sk)
+{
+	return ((struct mptcp_ccc *)inet_csk_ca(meta_sk))->forced_update;
+}
+
+static inline void mptcp_set_forced(const struct sock *meta_sk, bool force)
+{
+	((struct mptcp_ccc *)inet_csk_ca(meta_sk))->forced_update =3D force;
+}
+
+static void mptcp_ccc_recalc_alpha(const struct sock *sk)
+{
+	const struct mptcp_cb *mpcb =3D tcp_sk(sk)->mpcb;
+	const struct sock *sub_sk;
+	int best_cwnd =3D 0, best_rtt =3D 0, can_send =3D 0;
+	u64 max_numerator =3D 0, sum_denominator =3D 0, alpha =3D 1;
+
+	if (!mpcb)
+		return;
+
+	/* Only one subflow left - fall back to normal reno-behavior
+	 * (set alpha to 1)
+	 */
+	if (mpcb->cnt_established <=3D 1)
+		goto exit;
+
+	/* Do regular alpha-calculation for multiple subflows */
+
+	/* Find the max numerator of the alpha-calculation */
+	mptcp_for_each_sk(mpcb, sub_sk) {
+		struct tcp_sock *sub_tp =3D tcp_sk(sub_sk);
+		u64 tmp;
+
+		if (!mptcp_ccc_sk_can_send(sub_sk))
+			continue;
+
+		can_send++;
+
+		/* We need to look for the path, that provides the max-value.
+		 * Integer-overflow is not possible here, because
+		 * tmp will be in u64.
+		 */
+		tmp =3D div64_u64(mptcp_ccc_scale(sub_tp->snd_cwnd,
+				alpha_scale_num), (u64)sub_tp->srtt_us * sub_tp->srtt_us);
+
+		if (tmp >=3D max_numerator) {
+			max_numerator =3D tmp;
+			best_cwnd =3D sub_tp->snd_cwnd;
+			best_rtt =3D sub_tp->srtt_us;
+		}
+	}
+
+	/* No subflow is able to send - we don't care anymore */
+	if (unlikely(!can_send))
+		goto exit;
+
+	/* Calculate the denominator */
+	mptcp_for_each_sk(mpcb, sub_sk) {
+		struct tcp_sock *sub_tp =3D tcp_sk(sub_sk);
+
+		if (!mptcp_ccc_sk_can_send(sub_sk))
+			continue;
+
+		sum_denominator +=3D div_u64(
+				mptcp_ccc_scale(sub_tp->snd_cwnd,
+						alpha_scale_den) * best_rtt,
+						sub_tp->srtt_us);
+	}
+	sum_denominator *=3D sum_denominator;
+	if (unlikely(!sum_denominator)) {
+		pr_err("%s: sum_denominator =3D=3D 0, cnt_established:%d\n",
+		       __func__, mpcb->cnt_established);
+		mptcp_for_each_sk(mpcb, sub_sk) {
+			struct tcp_sock *sub_tp =3D tcp_sk(sub_sk);
+			pr_err("%s: pi:%d, state:%d\n, rtt:%u, cwnd: %u",
+			       __func__, sub_tp->mptcp->path_index,
+			       sub_sk->sk_state, sub_tp->srtt_us,
+			       sub_tp->snd_cwnd);
+		}
+	}
+
+	alpha =3D div64_u64(mptcp_ccc_scale(best_cwnd, alpha_scale_num), sum_deno=
minator);
+
+	if (unlikely(!alpha))
+		alpha =3D 1;
+
+exit:
+	mptcp_set_alpha(mptcp_meta_sk(sk), alpha);
+}
+
+static void mptcp_ccc_init(struct sock *sk)
+{
+	if (mptcp(tcp_sk(sk))) {
+		mptcp_set_forced(mptcp_meta_sk(sk), 0);
+		mptcp_set_alpha(mptcp_meta_sk(sk), 1);
+	}
+	/* If we do not mptcp, behave like reno: return */
+}
+
+static void mptcp_ccc_cwnd_event(struct sock *sk, enum tcp_ca_event event)
+{
+	if (event =3D=3D CA_EVENT_LOSS)
+		mptcp_ccc_recalc_alpha(sk);
+}
+
+static void mptcp_ccc_set_state(struct sock *sk, u8 ca_state)
+{
+	if (!mptcp(tcp_sk(sk)))
+		return;
+
+	mptcp_set_forced(mptcp_meta_sk(sk), 1);
+}
+
+static void mptcp_ccc_cong_avoid(struct sock *sk, u32 ack, u32 acked)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	const struct mptcp_cb *mpcb =3D tp->mpcb;
+	int snd_cwnd;
+
+	if (!mptcp(tp)) {
+		tcp_reno_cong_avoid(sk, ack, acked);
+		return;
+	}
+
+	if (!tcp_is_cwnd_limited(sk))
+		return;
+
+	if (tp->snd_cwnd <=3D tp->snd_ssthresh) {
+		/* In "safe" area, increase. */
+		tcp_slow_start(tp, acked);
+		mptcp_ccc_recalc_alpha(sk);
+		return;
+	}
+
+	if (mptcp_get_forced(mptcp_meta_sk(sk))) {
+		mptcp_ccc_recalc_alpha(sk);
+		mptcp_set_forced(mptcp_meta_sk(sk), 0);
+	}
+
+	if (mpcb->cnt_established > 1) {
+		u64 alpha =3D mptcp_get_alpha(mptcp_meta_sk(sk));
+
+		/* This may happen, if at the initialization, the mpcb
+		 * was not yet attached to the sock, and thus
+		 * initializing alpha failed.
+		 */
+		if (unlikely(!alpha))
+			alpha =3D 1;
+
+		snd_cwnd =3D (int) div_u64 ((u64) mptcp_ccc_scale(1, alpha_scale),
+						alpha);
+
+		/* snd_cwnd_cnt >=3D max (scale * tot_cwnd / alpha, cwnd)
+		 * Thus, we select here the max value.
+		 */
+		if (snd_cwnd < tp->snd_cwnd)
+			snd_cwnd =3D tp->snd_cwnd;
+	} else {
+		snd_cwnd =3D tp->snd_cwnd;
+	}
+
+	if (tp->snd_cwnd_cnt >=3D snd_cwnd) {
+		if (tp->snd_cwnd < tp->snd_cwnd_clamp) {
+			tp->snd_cwnd++;
+			mptcp_ccc_recalc_alpha(sk);
+		}
+
+		tp->snd_cwnd_cnt =3D 0;
+	} else {
+		tp->snd_cwnd_cnt++;
+	}
+}
+
+static struct tcp_congestion_ops mptcp_ccc =3D {
+	.init		=3D mptcp_ccc_init,
+	.ssthresh	=3D tcp_reno_ssthresh,
+	.cong_avoid	=3D mptcp_ccc_cong_avoid,
+	.cwnd_event	=3D mptcp_ccc_cwnd_event,
+	.set_state	=3D mptcp_ccc_set_state,
+	.owner		=3D THIS_MODULE,
+	.name		=3D "lia",
+};
+
+static int __init mptcp_ccc_register(void)
+{
+	BUILD_BUG_ON(sizeof(struct mptcp_ccc) > ICSK_CA_PRIV_SIZE);
+	return tcp_register_congestion_control(&mptcp_ccc);
+}
+
+static void __exit mptcp_ccc_unregister(void)
+{
+	tcp_unregister_congestion_control(&mptcp_ccc);
+}
+
+module_init(mptcp_ccc_register);
+module_exit(mptcp_ccc_unregister);
+
+MODULE_AUTHOR("Christoph Paasch, S=C3=A9bastien Barr=C3=A9");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MPTCP LINKED INCREASE CONGESTION CONTROL ALGORITHM");
+MODULE_VERSION("0.1");
diff --git a/net/mptcp/mptcp_ctrl.c b/net/mptcp/mptcp_ctrl.c
new file mode 100644
index 0000000..db5ff52
--- /dev/null
+++ b/net/mptcp/mptcp_ctrl.c
@@ -0,0 +1,2981 @@
+/*
+ *	MPTCP implementation - MPTCP-control
+ *
+ *	Initial Design & Implementation:
+ *	S=C3=A9bastien Barr=C3=A9 <sebastien.barre(a)uclouvain.be>
+ *
+ *	Current Maintainer & Author:
+ *	Christoph Paasch <christoph.paasch(a)uclouvain.be>
+ *
+ *	Additional authors:
+ *	Jaakko Korkeaniemi <jaakko.korkeaniemi(a)aalto.fi>
+ *	Gregory Detal <gregory.detal(a)uclouvain.be>
+ *	Fabien Duch=C3=AAne <fabien.duchene(a)uclouvain.be>
+ *	Andreas Seelinger <Andreas.Seelinger(a)rwth-aachen.de>
+ *	Lavkesh Lahngir <lavkesh51(a)gmail.com>
+ *	Andreas Ripke <ripke(a)neclab.eu>
+ *	Vlad Dogaru <vlad.dogaru(a)intel.com>
+ *	Octavian Purdila <octavian.purdila(a)intel.com>
+ *	John Ronan <jronan(a)tssg.org>
+ *	Catalin Nicutar <catalin.nicutar(a)gmail.com>
+ *	Brandon Heller <brandonh(a)stanford.edu>
+ *
+ *
+ *	This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+
+#include <net/sock.h>
+#include <net/inet_common.h>
+#include <net/inet6_hashtables.h>
+#include <net/ip.h>
+#include <net/ipv6.h>
+#include <net/ip6_checksum.h>
+#include <net/secure_seq.h>
+#include <net/mptcp.h>
+#include <net/mptcp_v4.h>
+#if IS_ENABLED(CONFIG_IPV6)
+#include <net/ip6_route.h>
+#include <net/mptcp_v6.h>
+#endif
+#include <net/sock.h>
+#include <net/tcp.h>
+#include <net/tcp_states.h>
+#include <net/transp_v6.h>
+#include <net/xfrm.h>
+
+#include <linux/cryptohash.h>
+#include <linux/kconfig.h>
+#include <linux/module.h>
+#include <linux/netpoll.h>
+#include <linux/list.h>
+#include <linux/jhash.h>
+#include <linux/tcp.h>
+#include <linux/net.h>
+#include <linux/in.h>
+#include <linux/random.h>
+#include <linux/inetdevice.h>
+#include <linux/workqueue.h>
+#include <linux/atomic.h>
+#include <linux/sysctl.h>
+#include <linux/proc_fs.h>
+
+static struct kmem_cache *mptcp_sock_cache __read_mostly;
+static struct kmem_cache *mptcp_cb_cache __read_mostly;
+static struct kmem_cache *mptcp_tw_cache __read_mostly;
+
+int sysctl_mptcp_enabled __read_mostly =3D 1;
+int sysctl_mptcp_version __read_mostly;
+static int min_mptcp_version;
+static int max_mptcp_version =3D 1;
+int sysctl_mptcp_checksum __read_mostly =3D 1;
+int sysctl_mptcp_debug __read_mostly;
+EXPORT_SYMBOL(sysctl_mptcp_debug);
+int sysctl_mptcp_syn_retries __read_mostly =3D 3;
+
+bool mptcp_init_failed __read_mostly;
+static struct tcp_operational_ops mptcp_default_op_ops;
+
+struct static_key mptcp_static_key =3D STATIC_KEY_INIT_FALSE;
+EXPORT_SYMBOL(mptcp_static_key);
+
+static int proc_mptcp_path_manager(struct ctl_table *ctl, int write,
+				   void __user *buffer, size_t *lenp,
+				   loff_t *ppos)
+{
+	char val[MPTCP_PM_NAME_MAX];
+	struct ctl_table tbl =3D {
+		.data =3D val,
+		.maxlen =3D MPTCP_PM_NAME_MAX,
+	};
+	int ret;
+
+	mptcp_get_default_path_manager(val);
+
+	ret =3D proc_dostring(&tbl, write, buffer, lenp, ppos);
+	if (write && ret =3D=3D 0)
+		ret =3D mptcp_set_default_path_manager(val);
+	return ret;
+}
+
+static int proc_mptcp_scheduler(struct ctl_table *ctl, int write,
+				void __user *buffer, size_t *lenp,
+				loff_t *ppos)
+{
+	char val[MPTCP_SCHED_NAME_MAX];
+	struct ctl_table tbl =3D {
+		.data =3D val,
+		.maxlen =3D MPTCP_SCHED_NAME_MAX,
+	};
+	int ret;
+
+	mptcp_get_default_scheduler(val);
+
+	ret =3D proc_dostring(&tbl, write, buffer, lenp, ppos);
+	if (write && ret =3D=3D 0)
+		ret =3D mptcp_set_default_scheduler(val);
+	return ret;
+}
+
+static struct ctl_table mptcp_table[] =3D {
+	{
+		.procname =3D "mptcp_enabled",
+		.data =3D &sysctl_mptcp_enabled,
+		.maxlen =3D sizeof(int),
+		.mode =3D 0644,
+		.proc_handler =3D &proc_dointvec
+	},
+	{
+		.procname =3D "mptcp_version",
+		.data =3D &sysctl_mptcp_version,
+		.mode =3D 0644,
+		.maxlen =3D sizeof(int),
+		.proc_handler =3D &proc_dointvec_minmax,
+		.extra1 =3D &min_mptcp_version,
+		.extra2 =3D &max_mptcp_version,
+	},
+	{
+		.procname =3D "mptcp_checksum",
+		.data =3D &sysctl_mptcp_checksum,
+		.maxlen =3D sizeof(int),
+		.mode =3D 0644,
+		.proc_handler =3D &proc_dointvec
+	},
+	{
+		.procname =3D "mptcp_debug",
+		.data =3D &sysctl_mptcp_debug,
+		.maxlen =3D sizeof(int),
+		.mode =3D 0644,
+		.proc_handler =3D &proc_dointvec
+	},
+	{
+		.procname =3D "mptcp_syn_retries",
+		.data =3D &sysctl_mptcp_syn_retries,
+		.maxlen =3D sizeof(int),
+		.mode =3D 0644,
+		.proc_handler =3D &proc_dointvec
+	},
+	{
+		.procname	=3D "mptcp_path_manager",
+		.mode		=3D 0644,
+		.maxlen		=3D MPTCP_PM_NAME_MAX,
+		.proc_handler	=3D proc_mptcp_path_manager,
+	},
+	{
+		.procname	=3D "mptcp_scheduler",
+		.mode		=3D 0644,
+		.maxlen		=3D MPTCP_SCHED_NAME_MAX,
+		.proc_handler	=3D proc_mptcp_scheduler,
+	},
+	{ }
+};
+
+static inline u32 mptcp_hash_tk(u32 token)
+{
+	return token % MPTCP_HASH_SIZE;
+}
+
+struct hlist_nulls_head tk_hashtable[MPTCP_HASH_SIZE];
+EXPORT_SYMBOL(tk_hashtable);
+
+/* This second hashtable is needed to retrieve request socks
+ * created as a result of a join request. While the SYN contains
+ * the token, the final ack does not, so we need a separate hashtable
+ * to retrieve the mpcb.
+ */
+struct hlist_nulls_head mptcp_reqsk_htb[MPTCP_HASH_SIZE];
+spinlock_t mptcp_reqsk_hlock;	/* hashtable protection */
+
+/* The following hash table is used to avoid collision of token */
+static struct hlist_nulls_head mptcp_reqsk_tk_htb[MPTCP_HASH_SIZE];
+spinlock_t mptcp_tk_hashlock;	/* hashtable protection */
+
+static bool mptcp_reqsk_find_tk(const u32 token)
+{
+	const u32 hash =3D mptcp_hash_tk(token);
+	const struct mptcp_request_sock *mtreqsk;
+	const struct hlist_nulls_node *node;
+
+begin:
+	hlist_nulls_for_each_entry_rcu(mtreqsk, node,
+				       &mptcp_reqsk_tk_htb[hash], hash_entry) {
+		if (token =3D=3D mtreqsk->mptcp_loc_token)
+			return true;
+	}
+	/* A request-socket is destroyed by RCU. So, it might have been recycled
+	 * and put into another hash-table list. So, after the lookup we may
+	 * end up in a different list. So, we may need to restart.
+	 *
+	 * See also the comment in __inet_lookup_established.
+	 */
+	if (get_nulls_value(node) !=3D hash)
+		goto begin;
+	return false;
+}
+
+static void mptcp_reqsk_insert_tk(struct request_sock *reqsk, const u32 to=
ken)
+{
+	u32 hash =3D mptcp_hash_tk(token);
+
+	hlist_nulls_add_head_rcu(&mptcp_rsk(reqsk)->hash_entry,
+				 &mptcp_reqsk_tk_htb[hash]);
+}
+
+static void mptcp_reqsk_remove_tk(const struct request_sock *reqsk)
+{
+	rcu_read_lock();
+	spin_lock(&mptcp_tk_hashlock);
+	hlist_nulls_del_init_rcu(&mptcp_rsk(reqsk)->hash_entry);
+	spin_unlock(&mptcp_tk_hashlock);
+	rcu_read_unlock();
+}
+
+void mptcp_reqsk_destructor(struct request_sock *req)
+{
+	if (!mptcp_rsk(req)->is_sub) {
+		if (in_softirq()) {
+			mptcp_reqsk_remove_tk(req);
+		} else {
+			rcu_read_lock_bh();
+			spin_lock(&mptcp_tk_hashlock);
+			hlist_nulls_del_init_rcu(&mptcp_rsk(req)->hash_entry);
+			spin_unlock(&mptcp_tk_hashlock);
+			rcu_read_unlock_bh();
+		}
+	} else {
+		mptcp_hash_request_remove(req);
+	}
+}
+
+static void __mptcp_hash_insert(struct tcp_sock *meta_tp, const u32 token)
+{
+	u32 hash =3D mptcp_hash_tk(token);
+
+	hlist_nulls_add_head_rcu(&meta_tp->tk_table, &tk_hashtable[hash]);
+	meta_tp->inside_tk_table =3D 1;
+}
+
+static bool mptcp_find_token(u32 token)
+{
+	const u32 hash =3D mptcp_hash_tk(token);
+	const struct tcp_sock *meta_tp;
+	const struct hlist_nulls_node *node;
+
+begin:
+	hlist_nulls_for_each_entry_rcu(meta_tp, node,
+				       &tk_hashtable[hash], tk_table) {
+		if (token =3D=3D meta_tp->mptcp_loc_token)
+			return true;
+	}
+	/* A TCP-socket is destroyed by RCU. So, it might have been recycled
+	 * and put into another hash-table list. So, after the lookup we may
+	 * end up in a different list. So, we may need to restart.
+	 *
+	 * See also the comment in __inet_lookup_established.
+	 */
+	if (get_nulls_value(node) !=3D hash)
+		goto begin;
+	return false;
+}
+
+static void mptcp_set_key_reqsk(struct request_sock *req,
+				const struct sk_buff *skb,
+				u32 seed)
+{
+	const struct inet_request_sock *ireq =3D inet_rsk(req);
+	struct mptcp_request_sock *mtreq =3D mptcp_rsk(req);
+
+	if (skb->protocol =3D=3D htons(ETH_P_IP)) {
+		mtreq->mptcp_loc_key =3D mptcp_v4_get_key(ip_hdr(skb)->saddr,
+							ip_hdr(skb)->daddr,
+							htons(ireq->ir_num),
+							ireq->ir_rmt_port);
+#if IS_ENABLED(CONFIG_IPV6)
+	} else {
+		mtreq->mptcp_loc_key =3D
+			mptcp_v6_get_key(ipv6_hdr(skb)->saddr.s6_addr32,
+					 ipv6_hdr(skb)->daddr.s6_addr32,
+					 htons(ireq->ir_num),
+					 ireq->ir_rmt_port);
+#endif
+	}
+
+	mptcp_key_sha1(mtreq->mptcp_loc_key, &mtreq->mptcp_loc_token, NULL);
+}
+
+/* New MPTCP-connection request, prepare a new token for the meta-socket t=
hat
+ * will be created in mptcp_check_req_master(), and store the received tok=
en.
+ */
+static void mptcp_reqsk_new_mptcp(struct request_sock *req,
+				  const struct sock *sk,
+				  const struct mptcp_options_received *mopt,
+				  const struct sk_buff *skb)
+{
+	struct mptcp_request_sock *mtreq =3D mptcp_rsk(req);
+	struct tcp_sock *tp =3D tcp_sk(sk);
+
+	inet_rsk(req)->saw_mpc =3D 1;
+	/* MPTCP version agreement */
+	if (mopt->mptcp_ver >=3D tp->mptcp_ver)
+		mtreq->mptcp_ver =3D tp->mptcp_ver;
+	else
+		mtreq->mptcp_ver =3D mopt->mptcp_ver;
+
+	rcu_read_lock();
+	spin_lock(&mptcp_tk_hashlock);
+	do {
+		mptcp_set_key_reqsk(req, skb, mptcp_seed++);
+	} while (mptcp_reqsk_find_tk(mtreq->mptcp_loc_token) ||
+		 mptcp_find_token(mtreq->mptcp_loc_token));
+	mptcp_reqsk_insert_tk(req, mtreq->mptcp_loc_token);
+	spin_unlock(&mptcp_tk_hashlock);
+	rcu_read_unlock();
+	mtreq->mptcp_rem_key =3D mopt->mptcp_sender_key;
+}
+
+static void mptcp_set_key_sk(const struct sock *sk)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	const struct inet_sock *isk =3D inet_sk(sk);
+
+	if (sk->sk_family =3D=3D AF_INET)
+		tp->mptcp_loc_key =3D mptcp_v4_get_key(isk->inet_saddr,
+						     isk->inet_daddr,
+						     isk->inet_sport,
+						     isk->inet_dport);
+#if IS_ENABLED(CONFIG_IPV6)
+	else
+		tp->mptcp_loc_key =3D
+			mptcp_v6_get_key(inet6_sk(sk)->saddr.s6_addr32,
+					 sk->sk_v6_daddr.s6_addr32,
+					 isk->inet_sport,
+					 isk->inet_dport);
+#endif
+
+	mptcp_key_sha1(tp->mptcp_loc_key,
+		       &tp->mptcp_loc_token, NULL);
+}
+
+#ifdef HAVE_JUMP_LABEL
+/* We are not allowed to call static_key_slow_dec() from irq context
+ * If mptcp_enable/disable_static_key() is called from irq context,
+ * defer the static_key_slow_dec() calls.
+ */
+static atomic_t mptcp_enable_deferred;
+#endif
+
+void mptcp_enable_static_key(void)
+{
+#ifdef HAVE_JUMP_LABEL
+	int deferred;
+
+	if (in_interrupt()) {
+		atomic_inc(&mptcp_enable_deferred);
+		return;
+	}
+
+	deferred =3D atomic_xchg(&mptcp_enable_deferred, 0);
+
+	if (deferred > 0) {
+		while (deferred--)
+			static_key_slow_inc(&mptcp_static_key);
+	} else if (deferred < 0) {
+		/* Do exactly one dec less than necessary */
+		while (++deferred)
+			static_key_slow_dec(&mptcp_static_key);
+		return;
+	}
+#endif
+	static_key_slow_inc(&mptcp_static_key);
+	WARN_ON(atomic_read(&mptcp_static_key.enabled) =3D=3D 0);
+}
+
+void mptcp_disable_static_key(void)
+{
+#ifdef HAVE_JUMP_LABEL
+	int deferred;
+
+	if (in_interrupt()) {
+		atomic_dec(&mptcp_enable_deferred);
+		return;
+	}
+
+	deferred =3D atomic_xchg(&mptcp_enable_deferred, 0);
+
+	if (deferred > 0) {
+		/* Do exactly one inc less than necessary */
+		while (--deferred)
+			static_key_slow_inc(&mptcp_static_key);
+		return;
+	} else if (deferred < 0) {
+		while (deferred++)
+			static_key_slow_dec(&mptcp_static_key);
+	}
+#endif
+	static_key_slow_dec(&mptcp_static_key);
+}
+
+void mptcp_enable_sock(struct sock *sk)
+{
+	if (!sock_flag(sk, SOCK_MPTCP)) {
+		struct tcp_sock *tp =3D tcp_sk(sk);
+
+		sock_set_flag(sk, SOCK_MPTCP);
+		tcp_sk(sk)->mptcp_ver =3D sysctl_mptcp_version;
+
+		/* setup MPTCP specific ops */
+		tp->op_ops =3D &mptcp_default_op_ops;
+		tp->state_ops =3D &mptcp_state_ops;
+		/* Necessary here, because MPTCP can be enabled/disabled through
+		 * a setsockopt.
+		 */
+		if (sk->sk_family =3D=3D AF_INET)
+			inet_csk(sk)->icsk_af_ops =3D &mptcp_v4_specific;
+#if IS_ENABLED(CONFIG_IPV6)
+		else if (mptcp_v6_is_v4_mapped(sk))
+			inet_csk(sk)->icsk_af_ops =3D &mptcp_v6_mapped;
+		else
+			inet_csk(sk)->icsk_af_ops =3D &mptcp_v6_specific;
+#endif
+
+		mptcp_enable_static_key();
+	}
+}
+
+void mptcp_disable_sock(struct sock *sk)
+{
+	if (sock_flag(sk, SOCK_MPTCP)) {
+		struct tcp_sock *tp =3D tcp_sk(sk);
+
+		sock_reset_flag(sk, SOCK_MPTCP);
+
+		/* Necessary here, because MPTCP can be enabled/disabled through
+		 * a setsockopt.
+		 */
+
+		tp->op_ops =3D READ_ONCE(tcp_default_op_ops);
+		tp->state_ops =3D tcp_default_state_ops;
+
+		if (sk->sk_family =3D=3D AF_INET)
+			inet_csk(sk)->icsk_af_ops =3D &ipv4_specific;
+#if IS_ENABLED(CONFIG_IPV6)
+		else if (mptcp_v6_is_v4_mapped(sk))
+			inet_csk(sk)->icsk_af_ops =3D &ipv6_mapped;
+		else
+			inet_csk(sk)->icsk_af_ops =3D &ipv6_specific;
+#endif
+
+		mptcp_disable_static_key();
+	}
+}
+
+void __mptcp_connect_init(struct sock *sk)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+
+	rcu_read_lock_bh();
+	spin_lock(&mptcp_tk_hashlock);
+	do {
+		mptcp_set_key_sk(sk);
+	} while (mptcp_reqsk_find_tk(tp->mptcp_loc_token) ||
+		 mptcp_find_token(tp->mptcp_loc_token));
+
+	__mptcp_hash_insert(tp, tp->mptcp_loc_token);
+	spin_unlock(&mptcp_tk_hashlock);
+	rcu_read_unlock_bh();
+
+	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVE);
+}
+
+/**
+ * This function increments the refcount of the mpcb struct.
+ * It is the responsibility of the caller to decrement when releasing
+ * the structure.
+ */
+struct sock *mptcp_hash_find(const struct net *net, const u32 token)
+{
+	const u32 hash =3D mptcp_hash_tk(token);
+	const struct tcp_sock *meta_tp;
+	struct sock *meta_sk =3D NULL;
+	const struct hlist_nulls_node *node;
+
+	rcu_read_lock();
+begin:
+	hlist_nulls_for_each_entry_rcu(meta_tp, node, &tk_hashtable[hash],
+				       tk_table) {
+		meta_sk =3D (struct sock *)meta_tp;
+		if (token =3D=3D meta_tp->mptcp_loc_token &&
+		    net_eq(net, sock_net(meta_sk))) {
+			if (unlikely(!refcount_inc_not_zero(&meta_sk->sk_refcnt)))
+				goto out;
+			if (unlikely(token !=3D meta_tp->mptcp_loc_token ||
+				     !net_eq(net, sock_net(meta_sk)))) {
+				sock_gen_put(meta_sk);
+				goto begin;
+			}
+			goto found;
+		}
+	}
+	/* A TCP-socket is destroyed by RCU. So, it might have been recycled
+	 * and put into another hash-table list. So, after the lookup we may
+	 * end up in a different list. So, we may need to restart.
+	 *
+	 * See also the comment in __inet_lookup_established.
+	 */
+	if (get_nulls_value(node) !=3D hash)
+		goto begin;
+out:
+	meta_sk =3D NULL;
+found:
+	rcu_read_unlock();
+	return meta_sk;
+}
+
+void mptcp_hash_remove_bh(struct tcp_sock *meta_tp)
+{
+	/* remove from the token hashtable */
+	rcu_read_lock_bh();
+	spin_lock(&mptcp_tk_hashlock);
+	hlist_nulls_del_init_rcu(&meta_tp->tk_table);
+	meta_tp->inside_tk_table =3D 0;
+	spin_unlock(&mptcp_tk_hashlock);
+	rcu_read_unlock_bh();
+}
+
+void mptcp_hash_remove(struct tcp_sock *meta_tp)
+{
+	rcu_read_lock();
+	spin_lock(&mptcp_tk_hashlock);
+	hlist_nulls_del_init_rcu(&meta_tp->tk_table);
+	meta_tp->inside_tk_table =3D 0;
+	spin_unlock(&mptcp_tk_hashlock);
+	rcu_read_unlock();
+}
+
+struct sock *mptcp_select_ack_sock(const struct sock *meta_sk)
+{
+	const struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
+	struct sock *sk, *rttsk =3D NULL, *lastsk =3D NULL;
+	u32 min_time =3D 0, last_active =3D 0;
+
+	mptcp_for_each_sk(meta_tp->mpcb, sk) {
+		struct tcp_sock *tp =3D tcp_sk(sk);
+		u32 elapsed;
+
+		if (!mptcp_sk_can_send_ack(sk) || tp->pf)
+			continue;
+
+		elapsed =3D keepalive_time_elapsed(tp);
+
+		/* We take the one with the lowest RTT within a reasonable
+		 * (meta-RTO)-timeframe
+		 */
+		if (elapsed < inet_csk(meta_sk)->icsk_rto) {
+			if (!min_time || tp->srtt_us < min_time) {
+				min_time =3D tp->srtt_us;
+				rttsk =3D sk;
+			}
+			continue;
+		}
+
+		/* Otherwise, we just take the most recent active */
+		if (!rttsk && (!last_active || elapsed < last_active)) {
+			last_active =3D elapsed;
+			lastsk =3D sk;
+		}
+	}
+
+	if (rttsk)
+		return rttsk;
+
+	return lastsk;
+}
+EXPORT_SYMBOL(mptcp_select_ack_sock);
+
+static void mptcp_sock_def_error_report(struct sock *sk)
+{
+	const struct mptcp_cb *mpcb =3D tcp_sk(sk)->mpcb;
+
+	if (!sock_flag(sk, SOCK_DEAD))
+		mptcp_sub_close(sk, 0);
+
+	if (mpcb->infinite_mapping_rcv || mpcb->infinite_mapping_snd ||
+	    mpcb->send_infinite_mapping) {
+		struct sock *meta_sk =3D mptcp_meta_sk(sk);
+
+		meta_sk->sk_err =3D sk->sk_err;
+		meta_sk->sk_err_soft =3D sk->sk_err_soft;
+
+		if (!sock_flag(meta_sk, SOCK_DEAD))
+			meta_sk->sk_error_report(meta_sk);
+
+		WARN(meta_sk->sk_state =3D=3D TCP_CLOSE,
+		     "Meta already closed i_rcv %u i_snd %u send_i %u flags %#lx\n",
+		     mpcb->infinite_mapping_rcv, mpcb->infinite_mapping_snd,
+		     mpcb->send_infinite_mapping, meta_sk->sk_flags);
+
+		if (meta_sk->sk_state !=3D TCP_CLOSE)
+			tcp_done(meta_sk);
+	}
+
+	sk->sk_err =3D 0;
+}
+
+static void mptcp_mpcb_put(struct mptcp_cb *mpcb)
+{
+	if (atomic_dec_and_test(&mpcb->mpcb_refcnt)) {
+		mptcp_cleanup_path_manager(mpcb);
+		mptcp_cleanup_scheduler(mpcb);
+		kmem_cache_free(mptcp_cb_cache, mpcb);
+	}
+}
+
+void mptcp_sock_destruct(struct sock *sk)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+
+	if (!is_meta_sk(sk) && !tp->was_meta_sk) {
+		BUG_ON(!hlist_unhashed(&tp->mptcp->cb_list));
+
+		if (tp->mptcp->meta_skb)
+			kfree_skb(tp->mptcp->meta_skb);
+		kmem_cache_free(mptcp_sock_cache, tp->mptcp);
+		tp->mptcp =3D NULL;
+
+		/* Taken when mpcb pointer was set */
+		sock_put(mptcp_meta_sk(sk));
+		mptcp_mpcb_put(tp->mpcb);
+	} else {
+		struct mptcp_cb *mpcb =3D tp->mpcb;
+		struct mptcp_tw *mptw;
+
+		/* The mpcb is disappearing - we can make the final
+		 * update to the rcv_nxt of the time-wait-sock and remove
+		 * its reference to the mpcb.
+		 */
+		spin_lock_bh(&mpcb->tw_lock);
+		list_for_each_entry_rcu(mptw, &mpcb->tw_list, list) {
+			list_del_rcu(&mptw->list);
+			mptw->in_list =3D 0;
+			mptcp_mpcb_put(mpcb);
+			rcu_assign_pointer(mptw->mpcb, NULL);
+		}
+		spin_unlock_bh(&mpcb->tw_lock);
+
+		mptcp_mpcb_put(mpcb);
+
+		mptcp_debug("%s destroying meta-sk\n", __func__);
+	}
+
+	WARN_ON(!static_key_false(&mptcp_static_key));
+
+	/* Must be called here, because this will decrement the jump-label. */
+	inet_sock_destruct(sk);
+}
+
+void mptcp_destroy_sock(struct sock *sk)
+{
+	if (is_meta_sk(sk)) {
+		struct sock *sk_it, *tmpsk;
+
+		__skb_queue_purge(&tcp_sk(sk)->mpcb->reinject_queue);
+		/* RCHK: Do we need to do anything about the hints ? */
+		mptcp_purge_ofo_queue(tcp_sk(sk));
+
+		/* We have to close all remaining subflows. Normally, they
+		 * should all be about to get closed. But, if the kernel is
+		 * forcing a closure (e.g., tcp_write_err), the subflows might
+		 * not have been closed properly (as we are waiting for the
+		 * DATA_ACK of the DATA_FIN).
+		 */
+		mptcp_for_each_sk_safe(tcp_sk(sk)->mpcb, sk_it, tmpsk) {
+			/* Already did call tcp_close - waiting for graceful
+			 * closure, or if we are retransmitting fast-close on
+			 * the subflow. The reset (or timeout) will kill the
+			 * subflow..
+			 */
+			if (tcp_sk(sk_it)->closing ||
+			    tcp_sk(sk_it)->send_mp_fclose)
+				continue;
+
+			/* Allow the delayed work first
+			 * to prevent time-wait state
+			 */
+			if (delayed_work_pending(&tcp_sk(sk_it)->mptcp->work))
+				continue;
+
+			mptcp_sub_close(sk_it, 0);
+		}
+	} else {
+		mptcp_del_sock(sk);
+	}
+}
+
+static void mptcp_set_state(struct sock *sk)
+{
+	struct sock *meta_sk =3D mptcp_meta_sk(sk);
+
+	/* Meta is not yet established - wake up the application */
+	if ((1 << meta_sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV) &&
+	    sk->sk_state =3D=3D TCP_ESTABLISHED) {
+		tcp_set_state(meta_sk, TCP_ESTABLISHED);
+
+		if (!sock_flag(meta_sk, SOCK_DEAD)) {
+			meta_sk->sk_state_change(meta_sk);
+			sk_wake_async(meta_sk, SOCK_WAKE_IO, POLL_OUT);
+		}
+
+		tcp_sk(meta_sk)->lsndtime =3D tcp_time_stamp(tcp_sk(meta_sk));
+	}
+
+	if (sk->sk_state =3D=3D TCP_ESTABLISHED) {
+		tcp_sk(sk)->mptcp->establish_increased =3D 1;
+		tcp_sk(sk)->mpcb->cnt_established++;
+	}
+}
+
+static void mptcp_assign_congestion_control(struct sock *sk)
+{
+	struct inet_connection_sock *icsk =3D inet_csk(sk);
+	struct inet_connection_sock *meta_icsk =3D inet_csk(mptcp_meta_sk(sk));
+	const struct tcp_congestion_ops *ca =3D meta_icsk->icsk_ca_ops;
+
+	/* Congestion control is the same as meta. Thus, it has been
+	 * try_module_get'd by tcp_assign_congestion_control.
+	 */
+	if (icsk->icsk_ca_ops =3D=3D ca)
+		return;
+
+	/* Use the same congestion control as set on the meta-sk */
+	if (!try_module_get(ca->owner)) {
+		/* This should never happen. The congestion control is linked
+		 * to the meta-socket (through tcp_assign_congestion_control)
+		 * who "holds" the refcnt on the module.
+		 */
+		WARN(1, "Could not get the congestion control!");
+		return;
+	}
+	icsk->icsk_ca_ops =3D ca;
+
+	/* Clear out private data before diag gets it and
+	 * the ca has not been initialized.
+	 */
+	if (ca->get_info)
+		memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
+}
+
+u32 mptcp_secret[MD5_MESSAGE_BYTES / 4] ____cacheline_aligned;
+u32 mptcp_seed;
+
+void mptcp_key_sha1(u64 key, u32 *token, u64 *idsn)
+{
+	u32 workspace[SHA_WORKSPACE_WORDS];
+	u32 mptcp_hashed_key[SHA_DIGEST_WORDS];
+	u8 input[64];
+	int i;
+
+	memset(workspace, 0, sizeof(workspace));
+
+	/* Initialize input with appropriate padding */
+	memset(&input[9], 0, sizeof(input) - 10); /* -10, because the last byte
+						   * is explicitly set too
+						   */
+	memcpy(input, &key, sizeof(key)); /* Copy key to the msg beginning */
+	input[8] =3D 0x80; /* Padding: First bit after message =3D 1 */
+	input[63] =3D 0x40; /* Padding: Length of the message =3D 64 bits */
+
+	sha_init(mptcp_hashed_key);
+	sha_transform(mptcp_hashed_key, input, workspace);
+
+	for (i =3D 0; i < 5; i++)
+		mptcp_hashed_key[i] =3D cpu_to_be32(mptcp_hashed_key[i]);
+
+	if (token)
+		*token =3D mptcp_hashed_key[0];
+	if (idsn)
+		*idsn =3D *((u64 *)&mptcp_hashed_key[3]);
+}
+
+void mptcp_hmac_sha1(u8 *key_1, u8 *key_2, u32 *hash_out, int arg_num, ...)
+{
+	u32 workspace[SHA_WORKSPACE_WORDS];
+	u8 input[128]; /* 2 512-bit blocks */
+	int i;
+	int index;
+	int length;
+	u8 *msg;
+	va_list list;
+
+	memset(workspace, 0, sizeof(workspace));
+
+	/* Generate key xored with ipad */
+	memset(input, 0x36, 64);
+	for (i =3D 0; i < 8; i++)
+		input[i] ^=3D key_1[i];
+	for (i =3D 0; i < 8; i++)
+		input[i + 8] ^=3D key_2[i];
+
+	va_start(list, arg_num);
+	index =3D 64;
+	for (i =3D 0; i < arg_num; i++) {
+		length =3D va_arg(list, int);
+		msg =3D va_arg(list, u8 *);
+		BUG_ON(index + length > 125); /* Message is too long */
+		memcpy(&input[index], msg, length);
+		index +=3D length;
+	}
+	va_end(list);
+
+	input[index] =3D 0x80; /* Padding: First bit after message =3D 1 */
+	memset(&input[index + 1], 0, (126 - index));
+
+	/* Padding: Length of the message =3D 512 + message length (bits) */
+	input[126] =3D 0x02;
+	input[127] =3D ((index - 64) * 8); /* Message length (bits) */
+
+	sha_init(hash_out);
+	sha_transform(hash_out, input, workspace);
+	memset(workspace, 0, sizeof(workspace));
+
+	sha_transform(hash_out, &input[64], workspace);
+	memset(workspace, 0, sizeof(workspace));
+
+	for (i =3D 0; i < 5; i++)
+		hash_out[i] =3D cpu_to_be32(hash_out[i]);
+
+	/* Prepare second part of hmac */
+	memset(input, 0x5C, 64);
+	for (i =3D 0; i < 8; i++)
+		input[i] ^=3D key_1[i];
+	for (i =3D 0; i < 8; i++)
+		input[i + 8] ^=3D key_2[i];
+
+	memcpy(&input[64], hash_out, 20);
+	input[84] =3D 0x80;
+	memset(&input[85], 0, 41);
+
+	/* Padding: Length of the message =3D 512 + 160 bits */
+	input[126] =3D 0x02;
+	input[127] =3D 0xA0;
+
+	sha_init(hash_out);
+	sha_transform(hash_out, input, workspace);
+	memset(workspace, 0, sizeof(workspace));
+
+	sha_transform(hash_out, &input[64], workspace);
+
+	for (i =3D 0; i < 5; i++)
+		hash_out[i] =3D cpu_to_be32(hash_out[i]);
+}
+EXPORT_SYMBOL(mptcp_hmac_sha1);
+
+static void mptcp_mpcb_inherit_sockopts(struct sock *meta_sk,
+					struct sock *master_sk)
+{
+	/* Socket-options handled by sk_clone_lock while creating the meta-sk.
+	 * =3D=3D=3D=3D=3D=3D
+	 * SO_SNDBUF, SO_SNDBUFFORCE, SO_RCVBUF, SO_RCVBUFFORCE, SO_RCVLOWAT,
+	 * SO_RCVTIMEO, SO_SNDTIMEO, SO_ATTACH_FILTER, SO_DETACH_FILTER,
+	 * TCP_NODELAY, TCP_CORK
+	 *
+	 * Socket-options handled in this function here
+	 * =3D=3D=3D=3D=3D=3D
+	 * TCP_DEFER_ACCEPT
+	 * SO_KEEPALIVE
+	 *
+	 * Socket-options on the todo-list
+	 * =3D=3D=3D=3D=3D=3D
+	 * SO_BINDTODEVICE - should probably prevent creation of new subsocks
+	 *		     across other devices. - what about the api-draft?
+	 * SO_DEBUG
+	 * SO_REUSEADDR - probably we don't care about this
+	 * SO_DONTROUTE, SO_BROADCAST
+	 * SO_OOBINLINE
+	 * SO_LINGER
+	 * SO_TIMESTAMP* - I don't think this is of concern for a SOCK_STREAM
+	 * SO_PASSSEC - I don't think this is of concern for a SOCK_STREAM
+	 * SO_RXQ_OVFL
+	 * TCP_COOKIE_TRANSACTIONS
+	 * TCP_MAXSEG
+	 * TCP_THIN_* - Handled by sk_clone_lock, but we need to support this
+	 *		in mptcp_meta_retransmit_timer. AND we need to check
+	 *		what is about the subsockets.
+	 * TCP_LINGER2
+	 * TCP_WINDOW_CLAMP
+	 * TCP_USER_TIMEOUT
+	 * TCP_MD5SIG
+	 *
+	 * Socket-options of no concern for the meta-socket
+	 * (but for the subsocket)
+	 * =3D=3D=3D=3D=3D=3D
+	 * SO_PRIORITY
+	 * SO_MARK
+	 * TCP_CONGESTION
+	 * TCP_SYNCNT
+	 * TCP_QUICKACK
+	 */
+
+	/* DEFER_ACCEPT should not be set on the meta, as we want to accept
+	 * new subflows directly
+	 */
+	inet_csk(meta_sk)->icsk_accept_queue.rskq_defer_accept =3D 0;
+
+	/* Keepalives are handled entirely at the MPTCP-layer */
+	if (sock_flag(meta_sk, SOCK_KEEPOPEN)) {
+		inet_csk_reset_keepalive_timer(meta_sk,
+					       keepalive_time_when(tcp_sk(meta_sk)));
+		sock_reset_flag(master_sk, SOCK_KEEPOPEN);
+		inet_csk_delete_keepalive_timer(master_sk);
+	}
+
+	/* Do not propagate subflow-errors up to the MPTCP-layer */
+	inet_sk(master_sk)->recverr =3D 0;
+}
+
+static void mptcp_sub_inherit_sockopts(const struct sock *meta_sk,
+				       struct sock *sub_sk)
+{
+	/* IP_TOS also goes to the subflow. */
+	if (inet_sk(sub_sk)->tos !=3D inet_sk(meta_sk)->tos) {
+		inet_sk(sub_sk)->tos =3D inet_sk(meta_sk)->tos;
+		sub_sk->sk_priority =3D meta_sk->sk_priority;
+		sk_dst_reset(sub_sk);
+	}
+
+	/* Inherit SO_REUSEADDR */
+	sub_sk->sk_reuse =3D meta_sk->sk_reuse;
+
+	/* Inherit snd/rcv-buffer locks */
+	sub_sk->sk_userlocks =3D meta_sk->sk_userlocks & ~SOCK_BINDPORT_LOCK;
+
+	/* Nagle/Cork is forced off on the subflows.
+	 * It is handled at the meta-layer
+	 */
+	tcp_sk(sub_sk)->nonagle =3D TCP_NAGLE_OFF | TCP_NAGLE_PUSH;
+
+	/* Keepalives are handled entirely at the MPTCP-layer */
+	if (sock_flag(sub_sk, SOCK_KEEPOPEN)) {
+		sock_reset_flag(sub_sk, SOCK_KEEPOPEN);
+		inet_csk_delete_keepalive_timer(sub_sk);
+	}
+
+	/* Do not propagate subflow-errors up to the MPTCP-layer */
+	inet_sk(sub_sk)->recverr =3D 0;
+}
+
+extern int mptcp_process_backlog(struct sock *sk, struct sk_buff *skb);
+int mptcp_backlog_rcv(struct sock *meta_sk, struct sk_buff *skb)
+{
+	/* skb-sk may be NULL if we receive a packet immediately after the
+	 * SYN/ACK + MP_CAPABLE.
+	 */
+	struct sock *sk =3D skb->sk ? skb->sk : meta_sk;
+	int ret =3D 0;
+
+	skb->sk =3D NULL;
+
+	if (sk->sk_state =3D=3D TCP_NEW_SYN_RECV) {
+		struct request_sock *req =3D inet_reqsk(sk);
+
+		__mptcp_join_ack(req, skb);
+
+		return 0;
+	}
+
+	if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt))) {
+		kfree_skb(skb);
+		return 0;
+	}
+
+	if (sk->sk_family =3D=3D AF_INET)
+		ret =3D tcp_v4_do_rcv(sk, skb);
+#if IS_ENABLED(CONFIG_IPV6)
+	else
+		ret =3D tcp_v6_do_rcv(sk, skb);
+#endif
+	sock_put(sk);
+	return ret;
+}
+
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
+struct lock_class_key meta_key;
+char *meta_key_name =3D "sk_lock-AF_INET-MPTCP";
+struct lock_class_key meta_slock_key;
+char *meta_slock_key_name =3D "slock-AF_INET-MPTCP";
+
+static const struct tcp_operational_ops mptcp_meta_specific =3D {
+	.__select_window		=3D __mptcp_select_window,
+	.select_window			=3D mptcp_select_window,
+	.select_initial_window		=3D mptcp_select_initial_window,
+	.select_size			=3D mptcp_select_size,
+	.init_buffer_space		=3D mptcp_init_buffer_space,
+	.set_rto			=3D mptcp_tcp_set_rto,
+	.should_expand_sndbuf		=3D mptcp_should_expand_sndbuf,
+	.send_fin			=3D mptcp_send_fin,
+	.write_xmit			=3D mptcp_write_xmit,
+	.send_active_reset		=3D mptcp_send_active_reset,
+	.write_wakeup			=3D mptcp_write_wakeup,
+	.prune_ofo_queue		=3D mptcp_prune_ofo_queue,
+	.retransmit_timer		=3D mptcp_meta_retransmit_timer,
+	.time_wait			=3D mptcp_time_wait,
+	.cleanup_rbuf			=3D mptcp_cleanup_rbuf,
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
+};
+
+static const struct tcp_operational_ops mptcp_sub_specific =3D {
+	.__select_window		=3D __mptcp_select_window,
+	.select_window			=3D mptcp_select_window,
+	.select_initial_window		=3D mptcp_select_initial_window,
+	.select_size			=3D mptcp_select_size,
+	.init_buffer_space		=3D mptcp_init_buffer_space,
+	.set_rto			=3D mptcp_tcp_set_rto,
+	.should_expand_sndbuf		=3D mptcp_should_expand_sndbuf,
+	.send_fin			=3D tcp_send_fin,
+	.write_xmit			=3D tcp_write_xmit,
+	.send_active_reset		=3D tcp_send_active_reset,
+	.write_wakeup			=3D tcp_write_wakeup,
+	.prune_ofo_queue		=3D mptcp_prune_ofo_queue,
+	.retransmit_timer		=3D mptcp_sub_retransmit_timer,
+	.time_wait			=3D tcp_time_wait,
+	.cleanup_rbuf			=3D tcp_cleanup_rbuf,
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
+};
+
+static int mptcp_alloc_mpcb(struct sock *meta_sk, __u64 remote_key,
+			    __u8 mptcp_ver, u32 window)
+{
+	struct mptcp_cb *mpcb;
+	struct sock *master_sk;
+	struct inet_connection_sock *meta_icsk =3D inet_csk(meta_sk);
+	struct tcp_sock *master_tp, *meta_tp =3D tcp_sk(meta_sk);
+	u64 idsn;
+
+	dst_release(meta_sk->sk_rx_dst);
+	meta_sk->sk_rx_dst =3D NULL;
+	/* This flag is set to announce sock_lock_init to
+	 * reclassify the lock-class of the master socket.
+	 */
+	meta_tp->is_master_sk =3D 1;
+	master_sk =3D sk_clone_lock(meta_sk, GFP_ATOMIC | __GFP_ZERO);
+	meta_tp->is_master_sk =3D 0;
+	if (!master_sk)
+		return -ENOBUFS;
+
+	master_tp =3D tcp_sk(master_sk);
+
+	mpcb =3D kmem_cache_zalloc(mptcp_cb_cache, GFP_ATOMIC);
+	if (!mpcb) {
+		/* sk_free (and __sk_free) requirese wmem_alloc to be 1.
+		 * All the rest is set to 0 thanks to __GFP_ZERO above.
+		 */
+		refcount_set(&master_sk->sk_wmem_alloc, 1);
+		sk_free(master_sk);
+		return -ENOBUFS;
+	}
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (meta_icsk->icsk_af_ops =3D=3D &mptcp_v6_mapped) {
+		struct ipv6_pinfo *newnp, *np =3D inet6_sk(meta_sk);
+
+		inet_sk(master_sk)->pinet6 =3D
+			&((struct tcp6_sock *)master_sk)->inet6;
+
+		newnp =3D inet6_sk(master_sk);
+		memcpy(newnp, np, sizeof(struct ipv6_pinfo));
+
+		newnp->ipv6_mc_list =3D NULL;
+		newnp->ipv6_ac_list =3D NULL;
+		newnp->ipv6_fl_list =3D NULL;
+		newnp->opt =3D NULL;
+		newnp->pktoptions =3D NULL;
+		(void)xchg(&newnp->rxpmtu, NULL);
+	} else if (meta_sk->sk_family =3D=3D AF_INET6) {
+		struct ipv6_pinfo *newnp, *np =3D inet6_sk(meta_sk);
+
+		inet_sk(master_sk)->pinet6 =3D
+			&((struct tcp6_sock *)master_sk)->inet6;
+
+		newnp =3D inet6_sk(master_sk);
+		memcpy(newnp, np, sizeof(struct ipv6_pinfo));
+
+		newnp->hop_limit	=3D -1;
+		newnp->mcast_hops	=3D IPV6_DEFAULT_MCASTHOPS;
+		newnp->mc_loop	=3D 1;
+		newnp->pmtudisc	=3D IPV6_PMTUDISC_WANT;
+		newnp->repflow     =3D
+			sock_net(master_sk)->ipv6.sysctl.flowlabel_reflect;
+		master_sk->sk_ipv6only =3D
+			sock_net(master_sk)->ipv6.sysctl.bindv6only;
+	}
+#endif
+
+	meta_tp->mptcp =3D NULL;
+
+	/* Store the mptcp version agreed on initial handshake */
+	mpcb->mptcp_ver =3D mptcp_ver;
+
+	/* Store the keys and generate the peer's token */
+	mpcb->mptcp_loc_key =3D meta_tp->mptcp_loc_key;
+	mpcb->mptcp_loc_token =3D meta_tp->mptcp_loc_token;
+
+	/* Generate Initial data-sequence-numbers */
+	mptcp_key_sha1(mpcb->mptcp_loc_key, NULL, &idsn);
+	idsn =3D ntohll(idsn) + 1;
+	mpcb->snd_high_order[0] =3D idsn >> 32;
+	mpcb->snd_high_order[1] =3D mpcb->snd_high_order[0] - 1;
+
+	meta_tp->write_seq =3D (u32)idsn;
+	meta_tp->snd_sml =3D meta_tp->write_seq;
+	meta_tp->snd_una =3D meta_tp->write_seq;
+	meta_tp->snd_nxt =3D meta_tp->write_seq;
+	meta_tp->pushed_seq =3D meta_tp->write_seq;
+	meta_tp->snd_up =3D meta_tp->write_seq;
+
+	mpcb->mptcp_rem_key =3D remote_key;
+	mptcp_key_sha1(mpcb->mptcp_rem_key, &mpcb->mptcp_rem_token, &idsn);
+	idsn =3D ntohll(idsn) + 1;
+	mpcb->rcv_high_order[0] =3D idsn >> 32;
+	mpcb->rcv_high_order[1] =3D mpcb->rcv_high_order[0] + 1;
+	meta_tp->copied_seq =3D (u32) idsn;
+	meta_tp->rcv_nxt =3D (u32) idsn;
+	meta_tp->rcv_wup =3D (u32) idsn;
+
+	meta_tp->snd_wl1 =3D meta_tp->rcv_nxt - 1;
+	meta_tp->snd_wnd =3D window;
+	meta_tp->retrans_stamp =3D 0; /* Set in tcp_connect() */
+
+	meta_tp->packets_out =3D 0;
+	meta_icsk->icsk_probes_out =3D 0;
+
+	/* Set mptcp-pointers */
+	master_tp->mpcb =3D mpcb;
+	master_tp->meta_sk =3D meta_sk;
+	meta_tp->mpcb =3D mpcb;
+	meta_tp->meta_sk =3D meta_sk;
+	mpcb->meta_sk =3D meta_sk;
+	mpcb->master_sk =3D master_sk;
+
+	meta_tp->was_meta_sk =3D 0;
+
+	/* Initialize the queues */
+	skb_queue_head_init(&mpcb->reinject_queue);
+	INIT_LIST_HEAD(&master_tp->tsorted_sent_queue);
+	INIT_LIST_HEAD(&master_tp->tsq_node);
+
+	mutex_init(&mpcb->mpcb_mutex);
+
+	/* Init the accept_queue structure, we support a queue of 32 pending
+	 * connections, it does not need to be huge, since we only store  here
+	 * pending subflow creations.
+	 */
+	/* Init the accept_queue structure */
+	reqsk_queue_alloc(&meta_icsk->icsk_accept_queue);
+
+	if (!sock_flag(meta_sk, SOCK_MPTCP)) {
+		mptcp_enable_static_key();
+		sock_set_flag(meta_sk, SOCK_MPTCP);
+	}
+
+	/* Redefine function-pointers as the meta-sk is now fully ready */
+	meta_tp->mpc =3D 1;
+	meta_tp->op_ops =3D &mptcp_meta_specific;
+
+	meta_sk->sk_backlog_rcv =3D mptcp_backlog_rcv;
+	meta_sk->sk_destruct =3D mptcp_sock_destruct;
+
+	/* Meta-level retransmit timer */
+	meta_icsk->icsk_rto *=3D 2; /* Double of initial - rto */
+
+	tcp_init_xmit_timers(master_sk);
+	/* Has been set for sending out the SYN */
+	inet_csk_clear_xmit_timer(meta_sk, ICSK_TIME_RETRANS);
+
+	if (!meta_tp->inside_tk_table) {
+		/* Adding the meta_tp in the token hashtable - coming from server-side */
+		rcu_read_lock();
+		spin_lock(&mptcp_tk_hashlock);
+
+		__mptcp_hash_insert(meta_tp, mpcb->mptcp_loc_token);
+
+		spin_unlock(&mptcp_tk_hashlock);
+		rcu_read_unlock();
+	}
+	master_tp->inside_tk_table =3D 0;
+
+	/* Init time-wait stuff */
+	INIT_LIST_HEAD(&mpcb->tw_list);
+	spin_lock_init(&mpcb->tw_lock);
+
+	INIT_HLIST_HEAD(&mpcb->callback_list);
+
+	mptcp_mpcb_inherit_sockopts(meta_sk, master_sk);
+
+	mpcb->orig_sk_rcvbuf =3D meta_sk->sk_rcvbuf;
+	mpcb->orig_sk_sndbuf =3D meta_sk->sk_sndbuf;
+	mpcb->orig_window_clamp =3D meta_tp->window_clamp;
+
+	/* The meta is directly linked - set refcnt to 1 */
+	atomic_set(&mpcb->mpcb_refcnt, 1);
+
+	mptcp_init_path_manager(mpcb);
+	mptcp_init_scheduler(mpcb);
+
+	if (!try_module_get(inet_csk(master_sk)->icsk_ca_ops->owner))
+		tcp_assign_congestion_control(master_sk);
+
+	mptcp_debug("%s: created mpcb with token %#x\n",
+		    __func__, mpcb->mptcp_loc_token);
+
+	return 0;
+}
+
+void mptcp_fallback_meta_sk(struct sock *meta_sk)
+{
+	kmem_cache_free(mptcp_cb_cache, tcp_sk(meta_sk)->mpcb);
+}
+
+int mptcp_add_sock(struct sock *meta_sk, struct sock *sk, u8 loc_id, u8 re=
m_id,
+		   gfp_t flags)
+{
+	struct mptcp_cb *mpcb	=3D tcp_sk(meta_sk)->mpcb;
+	struct tcp_sock *tp	=3D tcp_sk(sk);
+
+	tp->mptcp =3D kmem_cache_zalloc(mptcp_sock_cache, flags);
+	if (!tp->mptcp)
+		return -ENOMEM;
+
+	tp->mptcp->path_index =3D mptcp_set_new_pathindex(mpcb);
+	/* No more space for more subflows? */
+	if (!tp->mptcp->path_index) {
+		kmem_cache_free(mptcp_sock_cache, tp->mptcp);
+		return -EPERM;
+	}
+
+	INIT_HLIST_NODE(&tp->mptcp->cb_list);
+
+	tp->mptcp->tp =3D tp;
+	tp->mpcb =3D mpcb;
+	tp->meta_sk =3D meta_sk;
+
+	if (!sock_flag(sk, SOCK_MPTCP)) {
+		mptcp_enable_static_key();
+		sock_set_flag(sk, SOCK_MPTCP);
+	}
+
+	tp->mpc =3D 1;
+	tp->op_ops =3D &mptcp_sub_specific;
+
+	tp->mptcp->loc_id =3D loc_id;
+	tp->mptcp->rem_id =3D rem_id;
+	if (mpcb->sched_ops->init)
+		mpcb->sched_ops->init(sk);
+
+	/* The corresponding sock_put is in mptcp_sock_destruct(). It cannot be
+	 * included in mptcp_del_sock(), because the mpcb must remain alive
+	 * until the last subsocket is completely destroyed.
+	 */
+	sock_hold(meta_sk);
+	atomic_inc(&mpcb->mpcb_refcnt);
+
+	tp->mptcp->next =3D mpcb->connection_list;
+	mpcb->connection_list =3D tp;
+	tp->mptcp->attached =3D 1;
+
+	mpcb->cnt_subflows++;
+	atomic_add(atomic_read(&((struct sock *)tp)->sk_rmem_alloc),
+		   &meta_sk->sk_rmem_alloc);
+
+	mptcp_sub_inherit_sockopts(meta_sk, sk);
+	INIT_DELAYED_WORK(&tp->mptcp->work, mptcp_sub_close_wq);
+
+	/* Properly inherit CC from the meta-socket */
+	mptcp_assign_congestion_control(sk);
+
+	/* As we successfully allocated the mptcp_tcp_sock, we have to
+	 * change the function-pointers here (for sk_destruct to work correctly)
+	 */
+	sk->sk_error_report =3D mptcp_sock_def_error_report;
+	sk->sk_data_ready =3D mptcp_data_ready;
+	sk->sk_write_space =3D mptcp_write_space;
+	sk->sk_state_change =3D mptcp_set_state;
+	sk->sk_destruct =3D mptcp_sock_destruct;
+	sk->sk_backlog_rcv =3D tcp_v4_do_rcv;
+
+	if (sk->sk_family =3D=3D AF_INET)
+		mptcp_debug("%s: token %#x pi %d, src_addr:%pI4:%d dst_addr:%pI4:%d, cnt=
_subflows now %d\n",
+			    __func__, mpcb->mptcp_loc_token,
+			    tp->mptcp->path_index,
+			    &((struct inet_sock *)tp)->inet_saddr,
+			    ntohs(((struct inet_sock *)tp)->inet_sport),
+			    &((struct inet_sock *)tp)->inet_daddr,
+			    ntohs(((struct inet_sock *)tp)->inet_dport),
+			    mpcb->cnt_subflows);
+#if IS_ENABLED(CONFIG_IPV6)
+	else
+		mptcp_debug("%s: token %#x pi %d, src_addr:%pI6:%d dst_addr:%pI6:%d, cnt=
_subflows now %d\n",
+			    __func__, mpcb->mptcp_loc_token,
+			    tp->mptcp->path_index, &inet6_sk(sk)->saddr,
+			    ntohs(((struct inet_sock *)tp)->inet_sport),
+			    &sk->sk_v6_daddr,
+			    ntohs(((struct inet_sock *)tp)->inet_dport),
+			    mpcb->cnt_subflows);
+#endif
+
+	return 0;
+}
+
+void mptcp_del_sock(struct sock *sk)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk), *tp_prev;
+	struct mptcp_cb *mpcb;
+
+	if (!tp->mptcp || !tp->mptcp->attached)
+		return;
+
+	mpcb =3D tp->mpcb;
+	tp_prev =3D mpcb->connection_list;
+
+	if (mpcb->sched_ops->release)
+		mpcb->sched_ops->release(sk);
+
+	mptcp_debug("%s: Removing subsock tok %#x pi:%d state %d is_meta? %d\n",
+		    __func__, mpcb->mptcp_loc_token, tp->mptcp->path_index,
+		    sk->sk_state, is_meta_sk(sk));
+
+	if (tp_prev =3D=3D tp) {
+		mpcb->connection_list =3D tp->mptcp->next;
+	} else {
+		for (; tp_prev && tp_prev->mptcp->next;
+			tp_prev =3D tp_prev->mptcp->next) {
+			if (tp_prev->mptcp->next =3D=3D tp) {
+				tp_prev->mptcp->next =3D tp->mptcp->next;
+				break;
+			}
+		}
+	}
+	mpcb->cnt_subflows--;
+	if (tp->mptcp->establish_increased)
+		mpcb->cnt_established--;
+
+	tp->mptcp->next =3D NULL;
+	tp->mptcp->attached =3D 0;
+	mpcb->path_index_bits &=3D ~(1 << tp->mptcp->path_index);
+
+	if (!skb_queue_empty(&sk->sk_write_queue))
+		mptcp_reinject_data(sk, 0);
+
+	if (is_master_tp(tp))
+		mpcb->master_sk =3D NULL;
+	else if (tp->mptcp->pre_established)
+		sk_stop_timer(sk, &tp->mptcp->mptcp_ack_timer);
+
+	rcu_assign_pointer(inet_sk(sk)->inet_opt, NULL);
+}
+
+/* Updates the MPTCP-session based on path-manager information (e.g., addr=
esses,
+ * low-prio flows,...).
+ */
+void mptcp_update_metasocket(struct sock *sk, const struct sock *meta_sk)
+{
+	if (tcp_sk(sk)->mpcb->pm_ops->new_session)
+		tcp_sk(sk)->mpcb->pm_ops->new_session(meta_sk);
+}
+
+/* Clean up the receive buffer for full frames taken by the user,
+ * then send an ACK if necessary.  COPIED is the number of bytes
+ * tcp_recvmsg has given to the user so far, it speeds up the
+ * calculation of whether or not we must ACK for the sake of
+ * a window update.
+ */
+void mptcp_cleanup_rbuf(struct sock *meta_sk, int copied)
+{
+	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
+	struct sock *sk;
+	__u32 rcv_window_now =3D 0;
+
+	if (copied > 0 && !(meta_sk->sk_shutdown & RCV_SHUTDOWN)) {
+		rcv_window_now =3D tcp_receive_window(meta_tp);
+
+		if (2 * rcv_window_now > meta_tp->window_clamp)
+			rcv_window_now =3D 0;
+	}
+
+	mptcp_for_each_sk(meta_tp->mpcb, sk) {
+		struct tcp_sock *tp =3D tcp_sk(sk);
+		const struct inet_connection_sock *icsk =3D inet_csk(sk);
+
+		if (!mptcp_sk_can_send_ack(sk))
+			continue;
+
+		if (!inet_csk_ack_scheduled(sk))
+			goto second_part;
+		/* Delayed ACKs frequently hit locked sockets during bulk
+		 * receive.
+		 */
+		if (icsk->icsk_ack.blocked ||
+		    /* Once-per-two-segments ACK was not sent by tcp_input.c */
+		    tp->rcv_nxt - tp->rcv_wup > icsk->icsk_ack.rcv_mss ||
+		    /* If this read emptied read buffer, we send ACK, if
+		     * connection is not bidirectional, user drained
+		     * receive buffer and there was a small segment
+		     * in queue.
+		     */
+		    (copied > 0 &&
+		     ((icsk->icsk_ack.pending & ICSK_ACK_PUSHED2) ||
+		      ((icsk->icsk_ack.pending & ICSK_ACK_PUSHED) &&
+		       !icsk->icsk_ack.pingpong)) &&
+		     !atomic_read(&meta_sk->sk_rmem_alloc))) {
+			tcp_send_ack(sk);
+			continue;
+		}
+
+second_part:
+		/* This here is the second part of tcp_cleanup_rbuf */
+		if (rcv_window_now) {
+			__u32 new_window =3D tp->op_ops->__select_window(sk);
+
+			/* Send ACK now, if this read freed lots of space
+			 * in our buffer. Certainly, new_window is new window.
+			 * We can advertise it now, if it is not less than
+			 * current one.
+			 * "Lots" means "at least twice" here.
+			 */
+			if (new_window && new_window >=3D 2 * rcv_window_now)
+				tcp_send_ack(sk);
+		}
+	}
+}
+
+static int mptcp_sub_send_fin(struct sock *sk)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct sk_buff *skb =3D tcp_write_queue_tail(sk);
+	int mss_now;
+
+	/* Optimization, tack on the FIN if we have a queue of
+	 * unsent frames.  But be careful about outgoing SACKS
+	 * and IP options.
+	 */
+	mss_now =3D tcp_current_mss(sk);
+
+	if (tcp_send_head(sk)) {
+		TCP_SKB_CB(skb)->tcp_flags |=3D TCPHDR_FIN;
+		TCP_SKB_CB(skb)->end_seq++;
+		tp->write_seq++;
+	} else {
+		skb =3D alloc_skb_fclone(MAX_TCP_HEADER, GFP_ATOMIC);
+		if (!skb)
+			return 1;
+
+		INIT_LIST_HEAD(&skb->tcp_tsorted_anchor);
+		/* Reserve space for headers and prepare control bits. */
+		skb_reserve(skb, MAX_TCP_HEADER);
+		/* FIN eats a sequence byte, write_seq advanced by tcp_queue_skb(). */
+		tcp_init_nondata_skb(skb, tp->write_seq,
+				     TCPHDR_ACK | TCPHDR_FIN);
+		tcp_queue_skb(sk, skb);
+	}
+	__tcp_push_pending_frames(sk, mss_now, TCP_NAGLE_OFF);
+
+	return 0;
+}
+
+void mptcp_sub_close_wq(struct work_struct *work)
+{
+	struct tcp_sock *tp =3D container_of(work, struct mptcp_tcp_sock, work.wo=
rk)->tp;
+	struct sock *sk =3D (struct sock *)tp;
+	struct sock *meta_sk =3D mptcp_meta_sk(sk);
+
+	mutex_lock(&tp->mpcb->mpcb_mutex);
+	lock_sock_nested(meta_sk, SINGLE_DEPTH_NESTING);
+
+	if (sock_flag(sk, SOCK_DEAD))
+		goto exit;
+
+	/* We come from tcp_disconnect. We are sure that meta_sk is set */
+	if (!mptcp(tp)) {
+		tp->closing =3D 1;
+		tcp_close(sk, 0);
+		goto exit;
+	}
+
+	if (meta_sk->sk_shutdown =3D=3D SHUTDOWN_MASK || sk->sk_state =3D=3D TCP_=
CLOSE) {
+		tp->closing =3D 1;
+		tcp_close(sk, 0);
+	} else if (tcp_close_state(sk)) {
+		sk->sk_shutdown |=3D SEND_SHUTDOWN;
+		tcp_send_fin(sk);
+	}
+
+exit:
+	release_sock(meta_sk);
+	mutex_unlock(&tp->mpcb->mpcb_mutex);
+	sock_put(sk);
+}
+
+void mptcp_sub_close(struct sock *sk, unsigned long delay)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct delayed_work *work =3D &tcp_sk(sk)->mptcp->work;
+
+	/* We are already closing - e.g., call from sock_def_error_report upon
+	 * tcp_disconnect in tcp_close.
+	 */
+	if (tp->closing)
+		return;
+
+	/* Work already scheduled ? */
+	if (work_pending(&work->work)) {
+		/* Work present - who will be first ? */
+		if (jiffies + delay > work->timer.expires)
+			return;
+
+		/* Try canceling - if it fails, work will be executed soon */
+		if (!cancel_delayed_work(work))
+			return;
+		sock_put(sk);
+	}
+
+	if (!delay) {
+		unsigned char old_state =3D sk->sk_state;
+
+		/* If we are in user-context we can directly do the closing
+		 * procedure. No need to schedule a work-queue.
+		 */
+		if (!in_softirq()) {
+			if (sock_flag(sk, SOCK_DEAD))
+				return;
+
+			if (!mptcp(tp)) {
+				tp->closing =3D 1;
+				tcp_close(sk, 0);
+				return;
+			}
+
+			if (mptcp_meta_sk(sk)->sk_shutdown =3D=3D SHUTDOWN_MASK ||
+			    sk->sk_state =3D=3D TCP_CLOSE) {
+				tp->closing =3D 1;
+				tcp_close(sk, 0);
+			} else if (tcp_close_state(sk)) {
+				sk->sk_shutdown |=3D SEND_SHUTDOWN;
+				tcp_send_fin(sk);
+			}
+
+			return;
+		}
+
+		/* We directly send the FIN. Because it may take so a long time,
+		 * untile the work-queue will get scheduled...
+		 *
+		 * If mptcp_sub_send_fin returns 1, it failed and thus we reset
+		 * the old state so that tcp_close will finally send the fin
+		 * in user-context.
+		 */
+		if (!sk->sk_err && old_state !=3D TCP_CLOSE &&
+		    tcp_close_state(sk) && mptcp_sub_send_fin(sk)) {
+			if (old_state =3D=3D TCP_ESTABLISHED)
+				TCP_INC_STATS(sock_net(sk), TCP_MIB_CURRESTAB);
+			sk->sk_state =3D old_state;
+		}
+	}
+
+	sock_hold(sk);
+	queue_delayed_work(mptcp_wq, work, delay);
+}
+
+void mptcp_sub_force_close(struct sock *sk)
+{
+	/* The below tcp_done may have freed the socket, if he is already dead.
+	 * Thus, we are not allowed to access it afterwards. That's why
+	 * we have to store the dead-state in this local variable.
+	 */
+	int sock_is_dead =3D sock_flag(sk, SOCK_DEAD);
+
+	tcp_sk(sk)->mp_killed =3D 1;
+
+	if (sk->sk_state !=3D TCP_CLOSE)
+		tcp_done(sk);
+
+	if (!sock_is_dead)
+		mptcp_sub_close(sk, 0);
+}
+EXPORT_SYMBOL(mptcp_sub_force_close);
+
+/* Update the mpcb send window, based on the contributions
+ * of each subflow
+ */
+void mptcp_update_sndbuf(const struct tcp_sock *tp)
+{
+	struct sock *meta_sk =3D tp->meta_sk, *sk;
+	int new_sndbuf =3D 0, old_sndbuf =3D meta_sk->sk_sndbuf;
+
+	mptcp_for_each_sk(tp->mpcb, sk) {
+		if (!mptcp_sk_can_send(sk))
+			continue;
+
+		new_sndbuf +=3D sk->sk_sndbuf;
+
+		if (new_sndbuf > sock_net(meta_sk)->ipv4.sysctl_tcp_wmem[2] ||
+		    new_sndbuf < 0) {
+			new_sndbuf =3D sock_net(meta_sk)->ipv4.sysctl_tcp_wmem[2];
+			break;
+		}
+	}
+	meta_sk->sk_sndbuf =3D max(min(new_sndbuf,
+				     sock_net(meta_sk)->ipv4.sysctl_tcp_wmem[2]),
+				 meta_sk->sk_sndbuf);
+
+	/* The subflow's call to sk_write_space in tcp_new_space ends up in
+	 * mptcp_write_space.
+	 * It has nothing to do with waking up the application.
+	 * So, we do it here.
+	 */
+	if (old_sndbuf !=3D meta_sk->sk_sndbuf)
+		meta_sk->sk_write_space(meta_sk);
+}
+
+void mptcp_close(struct sock *meta_sk, long timeout)
+{
+	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
+	struct sock *sk_it, *tmpsk;
+	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
+	struct sk_buff *skb;
+	int data_was_unread =3D 0;
+	int state;
+
+	mptcp_debug("%s: Close of meta_sk with tok %#x\n",
+		    __func__, mpcb->mptcp_loc_token);
+
+	mutex_lock(&mpcb->mpcb_mutex);
+	lock_sock(meta_sk);
+
+	if (meta_tp->inside_tk_table) {
+		/* Detach the mpcb from the token hashtable */
+		mptcp_hash_remove_bh(meta_tp);
+		/* RCHK -- Do we need to cleanup the accept queue ?
+		 * or will it get cleaned up as part of tcp_close of the
+		 * meta socket
+		 */
+	}
+
+	meta_sk->sk_shutdown =3D SHUTDOWN_MASK;
+	/* We need to flush the recv. buffs.  We do this only on the
+	 * descriptor close, not protocol-sourced closes, because the
+	 * reader process may not have drained the data yet!
+	 */
+	while ((skb =3D __skb_dequeue(&meta_sk->sk_receive_queue)) !=3D NULL) {
+		u32 len =3D TCP_SKB_CB(skb)->end_seq - TCP_SKB_CB(skb)->seq;
+
+		if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)
+			len--;
+		data_was_unread +=3D len;
+		__kfree_skb(skb);
+	}
+
+	sk_mem_reclaim(meta_sk);
+
+	/* If socket has been already reset (e.g. in tcp_reset()) - kill it. */
+	if (meta_sk->sk_state =3D=3D TCP_CLOSE) {
+		mptcp_for_each_sk_safe(mpcb, sk_it, tmpsk) {
+			if (tcp_sk(sk_it)->send_mp_fclose)
+				continue;
+			mptcp_sub_close(sk_it, 0);
+		}
+		goto adjudge_to_death;
+	}
+
+	if (data_was_unread) {
+		/* Unread data was tossed, zap the connection. */
+		NET_INC_STATS(sock_net(meta_sk), LINUX_MIB_TCPABORTONCLOSE);
+		tcp_set_state(meta_sk, TCP_CLOSE);
+		tcp_sk(meta_sk)->op_ops->send_active_reset(meta_sk,
+							meta_sk->sk_allocation);
+	} else if (sock_flag(meta_sk, SOCK_LINGER) && !meta_sk->sk_lingertime) {
+		/* Check zero linger _after_ checking for unread data. */
+		meta_sk->sk_prot->disconnect(meta_sk, 0);
+		NET_INC_STATS(sock_net(meta_sk), LINUX_MIB_TCPABORTONDATA);
+	} else if (tcp_close_state(meta_sk)) {
+		mptcp_send_fin(meta_sk);
+	} else if (meta_tp->snd_una =3D=3D meta_tp->write_seq) {
+		/* The DATA_FIN has been sent and acknowledged
+		 * (e.g., by sk_shutdown). Close all the other subflows
+		 */
+		mptcp_for_each_sk_safe(mpcb, sk_it, tmpsk) {
+			unsigned long delay =3D 0;
+			/* If we are the passive closer, don't trigger
+			 * subflow-fin until the subflow has been finned
+			 * by the peer. - thus we add a delay
+			 */
+			if (mpcb->passive_close &&
+			    sk_it->sk_state =3D=3D TCP_ESTABLISHED)
+				delay =3D inet_csk(sk_it)->icsk_rto << 3;
+
+			mptcp_sub_close(sk_it, delay);
+		}
+	}
+
+	sk_stream_wait_close(meta_sk, timeout);
+
+adjudge_to_death:
+	state =3D meta_sk->sk_state;
+	sock_hold(meta_sk);
+	sock_orphan(meta_sk);
+
+	/* socket will be freed after mptcp_close - we have to prevent
+	 * access from the subflows.
+	 */
+	mptcp_for_each_sk(mpcb, sk_it) {
+		/* Similar to sock_orphan, but we don't set it DEAD, because
+		 * the callbacks are still set and must be called.
+		 */
+		write_lock_bh(&sk_it->sk_callback_lock);
+		sk_set_socket(sk_it, NULL);
+		sk_it->sk_wq  =3D NULL;
+		write_unlock_bh(&sk_it->sk_callback_lock);
+	}
+
+	/* It is the last release_sock in its life. It will remove backlog. */
+	release_sock(meta_sk);
+
+	/* Now socket is owned by kernel and we acquire BH lock
+	 * to finish close. No need to check for user refs.
+	 */
+	local_bh_disable();
+	bh_lock_sock(meta_sk);
+	WARN_ON(sock_owned_by_user(meta_sk));
+
+	percpu_counter_inc(meta_sk->sk_prot->orphan_count);
+
+	/* Have we already been destroyed by a softirq or backlog? */
+	if (state !=3D TCP_CLOSE && meta_sk->sk_state =3D=3D TCP_CLOSE)
+		goto out;
+
+	/*	This is a (useful) BSD violating of the RFC. There is a
+	 *	problem with TCP as specified in that the other end could
+	 *	keep a socket open forever with no application left this end.
+	 *	We use a 3 minute timeout (about the same as BSD) then kill
+	 *	our end. If they send after that then tough - BUT: long enough
+	 *	that we won't make the old 4*rto =3D almost no time - whoops
+	 *	reset mistake.
+	 *
+	 *	Nope, it was not mistake. It is really desired behaviour
+	 *	f.e. on http servers, when such sockets are useless, but
+	 *	consume significant resources. Let's do it with special
+	 *	linger2	option.					--ANK
+	 */
+
+	if (meta_sk->sk_state =3D=3D TCP_FIN_WAIT2) {
+		if (meta_tp->linger2 < 0) {
+			tcp_set_state(meta_sk, TCP_CLOSE);
+			meta_tp->op_ops->send_active_reset(meta_sk, GFP_ATOMIC);
+			__NET_INC_STATS(sock_net(meta_sk),
+					LINUX_MIB_TCPABORTONLINGER);
+		} else {
+			const int tmo =3D tcp_fin_time(meta_sk);
+
+			if (tmo > TCP_TIMEWAIT_LEN) {
+				inet_csk_reset_keepalive_timer(meta_sk,
+							       tmo - TCP_TIMEWAIT_LEN);
+			} else {
+				meta_tp->op_ops->time_wait(meta_sk,
+							   TCP_FIN_WAIT2, tmo);
+				goto out;
+			}
+		}
+	}
+	if (meta_sk->sk_state !=3D TCP_CLOSE) {
+		sk_mem_reclaim(meta_sk);
+		if (tcp_check_oom(meta_sk, 0)) {
+			if (net_ratelimit())
+				pr_info("MPTCP: out of memory: force closing socket\n");
+			tcp_set_state(meta_sk, TCP_CLOSE);
+			meta_tp->op_ops->send_active_reset(meta_sk, GFP_ATOMIC);
+			__NET_INC_STATS(sock_net(meta_sk),
+					LINUX_MIB_TCPABORTONMEMORY);
+		}
+	}
+
+	if (meta_sk->sk_state =3D=3D TCP_CLOSE)
+		inet_csk_destroy_sock(meta_sk);
+	/* Otherwise, socket is reprieved until protocol close. */
+
+out:
+	bh_unlock_sock(meta_sk);
+	local_bh_enable();
+	mutex_unlock(&mpcb->mpcb_mutex);
+	sock_put(meta_sk); /* Taken by sock_hold */
+}
+
+void mptcp_disconnect(struct sock *sk)
+{
+	struct sock *subsk, *tmpsk;
+	struct tcp_sock *tp =3D tcp_sk(sk);
+
+	__skb_queue_purge(&tp->mpcb->reinject_queue);
+
+	if (tp->inside_tk_table) {
+		mptcp_hash_remove_bh(tp);
+		/* RCHK -- Do we need to cleanup the accept queue ?
+		 * or will it get cleaned up as part of tcp_close of the
+		 * meta socket
+		 */
+	}
+
+	local_bh_disable();
+	mptcp_for_each_sk_safe(tp->mpcb, subsk, tmpsk) {
+		/* Don't close subflow used for MP_FASTCLOSE */
+		if (tcp_sk(subsk)->send_mp_fclose)
+			continue;
+
+		/* The socket will get removed from the subsocket-list
+		 * and made non-mptcp by setting mpc to 0.
+		 *
+		 * This is necessary, because tcp_disconnect assumes
+		 * that the connection is completely dead afterwards.
+		 * Thus we need to do a mptcp_del_sock. Due to this call
+		 * we have to make it non-mptcp.
+		 *
+		 * We have to lock the socket, because we set mpc to 0.
+		 * An incoming packet would take the subsocket's lock
+		 * and go on into the receive-path.
+		 * This would be a race.
+		 */
+
+		bh_lock_sock(subsk);
+		mptcp_del_sock(subsk);
+		tcp_sk(subsk)->mpc =3D 0;
+		tcp_sk(subsk)->op_ops =3D READ_ONCE(tcp_default_op_ops);
+		mptcp_sub_force_close(subsk);
+		bh_unlock_sock(subsk);
+	}
+	local_bh_enable();
+
+	tp->was_meta_sk =3D 1;
+	tp->mpc =3D 0;
+	tp->op_ops =3D READ_ONCE(tcp_default_op_ops);
+}
+
+/* Returns 1 if we should enable MPTCP for that socket. */
+int mptcp_doit(struct sock *sk)
+{
+	/* Don't do mptcp over loopback */
+	if (sk->sk_family =3D=3D AF_INET &&
+	    (ipv4_is_loopback(inet_sk(sk)->inet_daddr) ||
+	     ipv4_is_loopback(inet_sk(sk)->inet_saddr)))
+		return 0;
+#if IS_ENABLED(CONFIG_IPV6)
+	if (sk->sk_family =3D=3D AF_INET6 &&
+	    (ipv6_addr_loopback(&sk->sk_v6_daddr) ||
+	     ipv6_addr_loopback(&inet6_sk(sk)->saddr)))
+		return 0;
+#endif
+	if (mptcp_v6_is_v4_mapped(sk) &&
+	    ipv4_is_loopback(inet_sk(sk)->inet_saddr))
+		return 0;
+
+#ifdef CONFIG_TCP_MD5SIG
+	/* If TCP_MD5SIG is enabled, NO MPTCP as there is no Option-Space */
+	if (tcp_sk(sk)->af_specific->md5_lookup(sk, sk))
+		return 0;
+#endif
+
+	return 1;
+}
+
+int mptcp_create_master_sk(struct sock *meta_sk, __u64 remote_key,
+			   __u8 mptcp_ver, u32 window)
+{
+	struct tcp_sock *master_tp;
+	struct sock *master_sk;
+	struct inet_connection_sock *master_icsk;
+
+	if (mptcp_alloc_mpcb(meta_sk, remote_key, mptcp_ver, window))
+		goto err_alloc_mpcb;
+
+	master_sk =3D tcp_sk(meta_sk)->mpcb->master_sk;
+
+	master_tp =3D tcp_sk(master_sk);
+	master_icsk =3D inet_csk(master_sk);
+
+	master_sk->sk_write_pending =3D 0;
+	master_icsk->icsk_accept_queue.rskq_defer_accept =3D 0;
+	master_icsk->icsk_ack.pingpong =3D 0;
+
+	if (mptcp_add_sock(meta_sk, master_sk, 0, 0, GFP_ATOMIC))
+		goto err_add_sock;
+
+	if (__inet_inherit_port(meta_sk, master_sk) < 0)
+		goto err_add_sock;
+
+	meta_sk->sk_prot->unhash(meta_sk);
+
+	if (master_sk->sk_family =3D=3D AF_INET || mptcp_v6_is_v4_mapped(master_s=
k))
+		inet_ehash_nolisten(master_sk, NULL);
+#if IS_ENABLED(CONFIG_IPV6)
+	else
+		__inet_hash(master_sk, NULL);
+#endif
+
+	master_tp->mptcp->init_rcv_wnd =3D master_tp->rcv_wnd;
+
+	return 0;
+
+err_add_sock:
+	mptcp_fallback_meta_sk(meta_sk);
+
+	inet_csk_prepare_forced_close(master_sk);
+	tcp_done(master_sk);
+	inet_csk_prepare_forced_close(meta_sk);
+	tcp_done(meta_sk);
+
+err_alloc_mpcb:
+	return -ENOBUFS;
+}
+
+static int __mptcp_check_req_master(struct sock *child,
+				    struct request_sock *req)
+{
+	struct tcp_sock *child_tp =3D tcp_sk(child);
+	struct sock *meta_sk =3D child;
+	struct mptcp_cb *mpcb;
+	struct mptcp_request_sock *mtreq;
+
+	/* Never contained an MP_CAPABLE */
+	if (!inet_rsk(req)->mptcp_rqsk)
+		return 1;
+
+	if (!inet_rsk(req)->saw_mpc) {
+		/* Fallback to regular TCP, because we saw one SYN without
+		 * MP_CAPABLE. In tcp_check_req we continue the regular path.
+		 * But, the socket has been added to the reqsk_tk_htb, so we
+		 * must still remove it.
+		 */
+		MPTCP_INC_STATS_BH(sock_net(meta_sk),
+				   MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
+		mptcp_reqsk_remove_tk(req);
+		return 1;
+	}
+
+	MPTCP_INC_STATS_BH(sock_net(meta_sk), MPTCP_MIB_MPCAPABLEPASSIVEACK);
+
+	/* Just set this values to pass them to mptcp_alloc_mpcb */
+	mtreq =3D mptcp_rsk(req);
+	child_tp->mptcp_loc_key =3D mtreq->mptcp_loc_key;
+	child_tp->mptcp_loc_token =3D mtreq->mptcp_loc_token;
+
+	if (mptcp_create_master_sk(meta_sk, mtreq->mptcp_rem_key,
+				   mtreq->mptcp_ver, child_tp->snd_wnd))
+		return -ENOBUFS;
+
+	child =3D tcp_sk(child)->mpcb->master_sk;
+	child_tp =3D tcp_sk(child);
+	mpcb =3D child_tp->mpcb;
+
+	child_tp->mptcp->snt_isn =3D tcp_rsk(req)->snt_isn;
+	child_tp->mptcp->rcv_isn =3D tcp_rsk(req)->rcv_isn;
+
+	mpcb->dss_csum =3D mtreq->dss_csum;
+	mpcb->server_side =3D 1;
+
+	/* Will be moved to ESTABLISHED by  tcp_rcv_state_process() */
+	mptcp_update_metasocket(child, meta_sk);
+
+	/* Needs to be done here additionally, because when accepting a
+	 * new connection we pass by __reqsk_free and not reqsk_free.
+	 */
+	mptcp_reqsk_remove_tk(req);
+
+	/* Held when creating the meta-sk in tcp_vX_syn_recv_sock. */
+	sock_put(meta_sk);
+
+	return 0;
+}
+
+int mptcp_check_req_fastopen(struct sock *child, struct request_sock *req)
+{
+	struct sock *meta_sk =3D child, *master_sk;
+	struct sk_buff *skb;
+	u32 new_mapping;
+	int ret;
+
+	ret =3D __mptcp_check_req_master(child, req);
+	if (ret)
+		return ret;
+
+	master_sk =3D tcp_sk(meta_sk)->mpcb->master_sk;
+
+	/* We need to rewind copied_seq as it is set to IDSN + 1 and as we have
+	 * pre-MPTCP data in the receive queue.
+	 */
+	tcp_sk(meta_sk)->copied_seq -=3D tcp_sk(master_sk)->rcv_nxt -
+				       tcp_rsk(req)->rcv_isn - 1;
+
+	/* Map subflow sequence number to data sequence numbers. We need to map
+	 * these data to [IDSN - len - 1, IDSN[.
+	 */
+	new_mapping =3D tcp_sk(meta_sk)->copied_seq - tcp_rsk(req)->rcv_isn - 1;
+
+	/* There should be only one skb: the SYN + data. */
+	skb_queue_walk(&meta_sk->sk_receive_queue, skb) {
+		TCP_SKB_CB(skb)->seq +=3D new_mapping;
+		TCP_SKB_CB(skb)->end_seq +=3D new_mapping;
+	}
+
+	/* With fastopen we change the semantics of the relative subflow
+	 * sequence numbers to deal with middleboxes that could add/remove
+	 * multiple bytes in the SYN. We chose to start counting at rcv_nxt - 1
+	 * instead of the regular TCP ISN.
+	 */
+	tcp_sk(master_sk)->mptcp->rcv_isn =3D tcp_sk(master_sk)->rcv_nxt - 1;
+
+	/* We need to update copied_seq of the master_sk to account for the
+	 * already moved data to the meta receive queue.
+	 */
+	tcp_sk(master_sk)->copied_seq =3D tcp_sk(master_sk)->rcv_nxt;
+
+	/* Handled by the master_sk */
+	tcp_sk(meta_sk)->fastopen_rsk =3D NULL;
+
+	return 0;
+}
+
+int mptcp_check_req_master(struct sock *sk, struct sock *child,
+			   struct request_sock *req,
+			   int drop)
+{
+	struct sock *meta_sk =3D child;
+	int ret;
+
+	ret =3D __mptcp_check_req_master(child, req);
+	if (ret)
+		return ret;
+
+	/* drop indicates that we come from tcp_check_req and thus need to
+	 * handle the request-socket fully.
+	 */
+	if (drop) {
+		inet_csk_reqsk_queue_drop(sk, req);
+	} else {
+		/* Thus, we come from syn-cookies */
+		refcount_set(&req->rsk_refcnt, 1);
+	}
+	inet_csk_reqsk_queue_add(sk, req, meta_sk);
+
+	return 0;
+}
+
+struct sock *mptcp_check_req_child(struct sock *meta_sk, struct sock *chil=
d,
+				   struct request_sock *req,
+				   const struct mptcp_options_received *mopt)
+{
+	struct tcp_sock *child_tp =3D tcp_sk(child);
+	struct mptcp_request_sock *mtreq =3D mptcp_rsk(req);
+	struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
+	u8 hash_mac_check[20];
+
+	child_tp->inside_tk_table =3D 0;
+
+	if (!mopt->join_ack) {
+		MPTCP_INC_STATS_BH(sock_net(meta_sk), MPTCP_MIB_JOINACKFAIL);
+		goto teardown;
+	}
+
+	mptcp_hmac_sha1((u8 *)&mpcb->mptcp_rem_key,
+			(u8 *)&mpcb->mptcp_loc_key,
+			(u32 *)hash_mac_check, 2,
+			4, (u8 *)&mtreq->mptcp_rem_nonce,
+			4, (u8 *)&mtreq->mptcp_loc_nonce);
+
+	if (memcmp(hash_mac_check, (char *)&mopt->mptcp_recv_mac, 20)) {
+		MPTCP_INC_STATS_BH(sock_net(meta_sk), MPTCP_MIB_JOINACKMAC);
+		goto teardown;
+	}
+
+	/* Point it to the same struct socket and wq as the meta_sk */
+	sk_set_socket(child, meta_sk->sk_socket);
+	child->sk_wq =3D meta_sk->sk_wq;
+
+	if (mptcp_add_sock(meta_sk, child, mtreq->loc_id,
+			   mtreq->rem_id, GFP_ATOMIC)) {
+		/* Has been inherited, but now child_tp->mptcp is NULL */
+		child_tp->mpc =3D 0;
+		child_tp->op_ops =3D READ_ONCE(tcp_default_op_ops);
+
+		/* TODO when we support acking the third ack for new subflows,
+		 * we should silently discard this third ack, by returning NULL.
+		 *
+		 * Maybe, at the retransmission we will have enough memory to
+		 * fully add the socket to the meta-sk.
+		 */
+		goto teardown;
+	}
+
+	/* The child is a clone of the meta socket, we must now reset
+	 * some of the fields
+	 */
+	child_tp->mptcp->rcv_low_prio =3D mtreq->rcv_low_prio;
+
+	/* We should allow proper increase of the snd/rcv-buffers. Thus, we
+	 * use the original values instead of the bloated up ones from the
+	 * clone.
+	 */
+	child->sk_sndbuf =3D mpcb->orig_sk_sndbuf;
+	child->sk_rcvbuf =3D mpcb->orig_sk_rcvbuf;
+
+	child_tp->mptcp->slave_sk =3D 1;
+	child_tp->mptcp->snt_isn =3D tcp_rsk(req)->snt_isn;
+	child_tp->mptcp->rcv_isn =3D tcp_rsk(req)->rcv_isn;
+
+	/* Subflows do not use the accept queue, as they
+	 * are attached immediately to the mpcb.
+	 */
+	inet_csk_reqsk_queue_drop(meta_sk, req);
+
+	/* The refcnt is initialized to 2, because regular TCP will put him
+	 * in the socket's listener queue. However, we do not have a
+	 * listener-queue. So, we need to make sure that this request-sock
+	 * indeed gets destroyed.
+	 */
+	reqsk_put(req);
+
+	MPTCP_INC_STATS_BH(sock_net(meta_sk), MPTCP_MIB_JOINACKRX);
+	return child;
+
+teardown:
+	/* Drop this request - sock creation failed. */
+	inet_csk_reqsk_queue_drop(meta_sk, req);
+	inet_csk_prepare_forced_close(child);
+	tcp_done(child);
+	return meta_sk;
+}
+
+int mptcp_init_tw_sock(struct sock *sk, struct tcp_timewait_sock *tw)
+{
+	struct mptcp_tw *mptw;
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct mptcp_cb *mpcb =3D tp->mpcb;
+
+	/* A subsocket in tw can only receive data. So, if we are in
+	 * infinite-receive, then we should not reply with a data-ack or act
+	 * upon general MPTCP-signaling. We prevent this by simply not creating
+	 * the mptcp_tw_sock.
+	 */
+	if (mpcb->infinite_mapping_rcv) {
+		tw->mptcp_tw =3D NULL;
+		return 0;
+	}
+
+	/* Alloc MPTCP-tw-sock */
+	mptw =3D kmem_cache_alloc(mptcp_tw_cache, GFP_ATOMIC);
+	if (!mptw) {
+		tw->mptcp_tw =3D NULL;
+		return -ENOBUFS;
+	}
+
+	atomic_inc(&mpcb->mpcb_refcnt);
+
+	tw->mptcp_tw =3D mptw;
+	mptw->loc_key =3D mpcb->mptcp_loc_key;
+	mptw->meta_tw =3D mpcb->in_time_wait;
+	if (mptw->meta_tw) {
+		mptw->rcv_nxt =3D mptcp_get_rcv_nxt_64(mptcp_meta_tp(tp));
+		if (mpcb->mptw_state !=3D TCP_TIME_WAIT)
+			mptw->rcv_nxt++;
+	}
+	rcu_assign_pointer(mptw->mpcb, mpcb);
+
+	spin_lock(&mpcb->tw_lock);
+	list_add_rcu(&mptw->list, &tp->mpcb->tw_list);
+	mptw->in_list =3D 1;
+	spin_unlock(&mpcb->tw_lock);
+
+	return 0;
+}
+
+void mptcp_twsk_destructor(struct tcp_timewait_sock *tw)
+{
+	struct mptcp_cb *mpcb;
+
+	rcu_read_lock();
+	mpcb =3D rcu_dereference(tw->mptcp_tw->mpcb);
+
+	/* If we are still holding a ref to the mpcb, we have to remove ourself
+	 * from the list and drop the ref properly.
+	 */
+	if (mpcb && atomic_inc_not_zero(&mpcb->mpcb_refcnt)) {
+		spin_lock(&mpcb->tw_lock);
+		if (tw->mptcp_tw->in_list) {
+			list_del_rcu(&tw->mptcp_tw->list);
+			tw->mptcp_tw->in_list =3D 0;
+		}
+		spin_unlock(&mpcb->tw_lock);
+
+		/* Twice, because we increased it above */
+		mptcp_mpcb_put(mpcb);
+		mptcp_mpcb_put(mpcb);
+	}
+
+	rcu_read_unlock();
+
+	kmem_cache_free(mptcp_tw_cache, tw->mptcp_tw);
+}
+
+/* Updates the rcv_nxt of the time-wait-socks and allows them to ack a
+ * data-fin.
+ */
+void mptcp_time_wait(struct sock *meta_sk, int state, int timeo)
+{
+	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
+	struct mptcp_tw *mptw;
+
+	/* Used for sockets that go into tw after the meta
+	 * (see mptcp_init_tw_sock())
+	 */
+	meta_tp->mpcb->in_time_wait =3D 1;
+	meta_tp->mpcb->mptw_state =3D state;
+
+	/* Update the time-wait-sock's information */
+	rcu_read_lock_bh();
+	list_for_each_entry_rcu(mptw, &meta_tp->mpcb->tw_list, list) {
+		mptw->meta_tw =3D 1;
+		mptw->rcv_nxt =3D mptcp_get_rcv_nxt_64(meta_tp);
+
+		/* We want to ack a DATA_FIN, but are yet in FIN_WAIT_2 -
+		 * pretend as if the DATA_FIN has already reached us, that way
+		 * the checks in tcp_timewait_state_process will be good as the
+		 * DATA_FIN comes in.
+		 */
+		if (state !=3D TCP_TIME_WAIT)
+			mptw->rcv_nxt++;
+	}
+	rcu_read_unlock_bh();
+
+	if (meta_sk->sk_state !=3D TCP_CLOSE)
+		tcp_done(meta_sk);
+}
+
+void mptcp_tsq_flags(struct sock *sk)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct sock *meta_sk =3D mptcp_meta_sk(sk);
+
+	/* It will be handled as a regular deferred-call */
+	if (is_meta_sk(sk))
+		return;
+
+	if (hlist_unhashed(&tp->mptcp->cb_list)) {
+		hlist_add_head(&tp->mptcp->cb_list, &tp->mpcb->callback_list);
+		/* We need to hold it here, as the sock_hold is not assured
+		 * by the release_sock as it is done in regular TCP.
+		 *
+		 * The subsocket may get inet_csk_destroy'd while it is inside
+		 * the callback_list.
+		 */
+		sock_hold(sk);
+	}
+
+	if (!test_and_set_bit(MPTCP_SUB_DEFERRED, &meta_sk->sk_tsq_flags))
+		sock_hold(meta_sk);
+}
+
+void mptcp_tsq_sub_deferred(struct sock *meta_sk)
+{
+	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
+	struct mptcp_tcp_sock *mptcp;
+	struct hlist_node *tmp;
+
+	BUG_ON(!is_meta_sk(meta_sk) && !meta_tp->was_meta_sk);
+
+	__sock_put(meta_sk);
+	hlist_for_each_entry_safe(mptcp, tmp, &meta_tp->mpcb->callback_list,
+				  cb_list) {
+		struct tcp_sock *tp =3D mptcp->tp;
+		struct sock *sk =3D (struct sock *)tp;
+
+		hlist_del_init(&mptcp->cb_list);
+		sk->sk_prot->release_cb(sk);
+		/* Final sock_put (cfr. mptcp_tsq_flags */
+		sock_put(sk);
+	}
+}
+
+void mptcp_join_reqsk_init(struct mptcp_cb *mpcb,
+			   const struct request_sock *req, struct sk_buff *skb)
+{
+	struct mptcp_request_sock *mtreq =3D mptcp_rsk(req);
+	struct mptcp_options_received mopt;
+	u8 mptcp_hash_mac[20];
+
+	mptcp_init_mp_opt(&mopt);
+	tcp_parse_mptcp_options(skb, &mopt);
+
+	mtreq->mptcp_mpcb =3D mpcb;
+	mtreq->is_sub =3D 1;
+	inet_rsk(req)->mptcp_rqsk =3D 1;
+
+	mtreq->mptcp_rem_nonce =3D mopt.mptcp_recv_nonce;
+
+	mptcp_hmac_sha1((u8 *)&mpcb->mptcp_loc_key,
+			(u8 *)&mpcb->mptcp_rem_key,
+			(u32 *)mptcp_hash_mac, 2,
+			4, (u8 *)&mtreq->mptcp_loc_nonce,
+			4, (u8 *)&mtreq->mptcp_rem_nonce);
+	mtreq->mptcp_hash_tmac =3D *(u64 *)mptcp_hash_mac;
+
+	mtreq->rem_id =3D mopt.rem_id;
+	mtreq->rcv_low_prio =3D mopt.low_prio;
+	inet_rsk(req)->saw_mpc =3D 1;
+
+	MPTCP_INC_STATS_BH(sock_net(mpcb->meta_sk), MPTCP_MIB_JOINSYNRX);
+}
+
+void mptcp_reqsk_init(struct request_sock *req, const struct sock *sk,
+		      struct sk_buff *skb, struct mptcp_options_received *mopt)
+{
+	struct mptcp_request_sock *mtreq =3D mptcp_rsk(req);
+
+	mptcp_rsk(req)->hash_entry.pprev =3D NULL;
+	mptcp_rsk(req)->is_sub =3D 0;
+	mtreq->dss_csum =3D mopt->dss_csum;
+	mptcp_reqsk_new_mptcp(req, sk, mopt, skb);
+}
+
+void mptcp_cookies_reqsk_init(struct request_sock *req,
+			      struct mptcp_options_received *mopt,
+			      struct sk_buff *skb)
+{
+	struct mptcp_request_sock *mtreq =3D mptcp_rsk(req);
+
+	/* Absolutely need to always initialize this. */
+	mtreq->hash_entry.pprev =3D NULL;
+
+	mtreq->mptcp_rem_key =3D mopt->mptcp_sender_key;
+	mtreq->mptcp_loc_key =3D mopt->mptcp_receiver_key;
+
+	/* Generate the token */
+	mptcp_key_sha1(mtreq->mptcp_loc_key, &mtreq->mptcp_loc_token, NULL);
+
+	rcu_read_lock();
+	spin_lock(&mptcp_tk_hashlock);
+
+	/* Check, if the key is still free */
+	if (mptcp_reqsk_find_tk(mtreq->mptcp_loc_token) ||
+	    mptcp_find_token(mtreq->mptcp_loc_token))
+		goto out;
+
+	inet_rsk(req)->saw_mpc =3D 1;
+	mtreq->is_sub =3D 0;
+	inet_rsk(req)->mptcp_rqsk =3D 1;
+	mtreq->dss_csum =3D mopt->dss_csum;
+
+out:
+	spin_unlock(&mptcp_tk_hashlock);
+	rcu_read_unlock();
+}
+
+int mptcp_conn_request(struct sock *sk, struct sk_buff *skb)
+{
+	struct mptcp_options_received mopt;
+
+	mptcp_init_mp_opt(&mopt);
+	tcp_parse_mptcp_options(skb, &mopt);
+
+	if (mopt.is_mp_join)
+		return mptcp_do_join_short(skb, &mopt, sock_net(sk));
+	if (mopt.drop_me)
+		goto drop;
+
+	if (!sock_flag(sk, SOCK_MPTCP))
+		mopt.saw_mpc =3D 0;
+
+	if (skb->protocol =3D=3D htons(ETH_P_IP)) {
+		if (mopt.saw_mpc) {
+			if (skb_rtable(skb)->rt_flags &
+			    (RTCF_BROADCAST | RTCF_MULTICAST))
+				goto drop;
+
+			MPTCP_INC_STATS_BH(sock_net(sk),
+					   MPTCP_MIB_MPCAPABLEPASSIVE);
+			return tcp_conn_request(&mptcp_request_sock_ops,
+						&mptcp_request_sock_ipv4_ops,
+						sk, skb);
+		}
+
+		return tcp_v4_conn_request(sk, skb);
+#if IS_ENABLED(CONFIG_IPV6)
+	} else {
+		if (mopt.saw_mpc) {
+			if (!ipv6_unicast_destination(skb))
+				goto drop;
+
+			MPTCP_INC_STATS_BH(sock_net(sk),
+					   MPTCP_MIB_MPCAPABLEPASSIVE);
+			return tcp_conn_request(&mptcp6_request_sock_ops,
+						&mptcp_request_sock_ipv6_ops,
+						sk, skb);
+		}
+
+		return tcp_v6_conn_request(sk, skb);
+#endif
+	}
+drop:
+	__NET_INC_STATS(sock_net(sk), LINUX_MIB_LISTENDROPS);
+	return 0;
+}
+
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
+static const struct snmp_mib mptcp_snmp_list[] =3D {
+	SNMP_MIB_ITEM("MPCapableSYNRX", MPTCP_MIB_MPCAPABLEPASSIVE),
+	SNMP_MIB_ITEM("MPCapableSYNTX", MPTCP_MIB_MPCAPABLEACTIVE),
+	SNMP_MIB_ITEM("MPCapableSYNACKRX", MPTCP_MIB_MPCAPABLEACTIVEACK),
+	SNMP_MIB_ITEM("MPCapableACKRX", MPTCP_MIB_MPCAPABLEPASSIVEACK),
+	SNMP_MIB_ITEM("MPCapableFallbackACK",
+		      MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK),
+	SNMP_MIB_ITEM("MPCapableFallbackSYNACK",
+		      MPTCP_MIB_MPCAPABLEACTIVEFALLBACK),
+	SNMP_MIB_ITEM("MPCapableRetransFallback",
+		      MPTCP_MIB_MPCAPABLERETRANSFALLBACK),
+	SNMP_MIB_ITEM("MPTCPCsumEnabled", MPTCP_MIB_CSUMENABLED),
+	SNMP_MIB_ITEM("MPTCPRetrans", MPTCP_MIB_RETRANSSEGS),
+	SNMP_MIB_ITEM("MPFailRX", MPTCP_MIB_MPFAILRX),
+	SNMP_MIB_ITEM("MPCsumFail", MPTCP_MIB_CSUMFAIL),
+	SNMP_MIB_ITEM("MPFastcloseRX", MPTCP_MIB_FASTCLOSERX),
+	SNMP_MIB_ITEM("MPFastcloseTX", MPTCP_MIB_FASTCLOSETX),
+	SNMP_MIB_ITEM("MPFallbackAckSub", MPTCP_MIB_FBACKSUB),
+	SNMP_MIB_ITEM("MPFallbackAckInit", MPTCP_MIB_FBACKINIT),
+	SNMP_MIB_ITEM("MPFallbackDataSub", MPTCP_MIB_FBDATASUB),
+	SNMP_MIB_ITEM("MPFallbackDataInit", MPTCP_MIB_FBDATAINIT),
+	SNMP_MIB_ITEM("MPRemoveAddrSubDelete", MPTCP_MIB_REMADDRSUB),
+	SNMP_MIB_ITEM("MPJoinNoTokenFound", MPTCP_MIB_JOINNOTOKEN),
+	SNMP_MIB_ITEM("MPJoinAlreadyFallenback", MPTCP_MIB_JOINFALLBACK),
+	SNMP_MIB_ITEM("MPJoinSynTx", MPTCP_MIB_JOINSYNTX),
+	SNMP_MIB_ITEM("MPJoinSynRx", MPTCP_MIB_JOINSYNRX),
+	SNMP_MIB_ITEM("MPJoinSynAckRx", MPTCP_MIB_JOINSYNACKRX),
+	SNMP_MIB_ITEM("MPJoinSynAckHMacFailure", MPTCP_MIB_JOINSYNACKMAC),
+	SNMP_MIB_ITEM("MPJoinAckRx", MPTCP_MIB_JOINACKRX),
+	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
+	SNMP_MIB_ITEM("MPJoinAckMissing", MPTCP_MIB_JOINACKFAIL),
+	SNMP_MIB_ITEM("MPJoinAckRTO", MPTCP_MIB_JOINACKRTO),
+	SNMP_MIB_ITEM("MPJoinAckRexmit", MPTCP_MIB_JOINACKRXMIT),
+	SNMP_MIB_ITEM("NoDSSInWindow", MPTCP_MIB_NODSSWINDOW),
+	SNMP_MIB_ITEM("DSSNotMatching", MPTCP_MIB_DSSNOMATCH),
+	SNMP_MIB_ITEM("InfiniteMapRx", MPTCP_MIB_INFINITEMAPRX),
+	SNMP_MIB_ITEM("DSSNoMatchTCP", MPTCP_MIB_DSSTCPMISMATCH),
+	SNMP_MIB_ITEM("DSSTrimHead", MPTCP_MIB_DSSTRIMHEAD),
+	SNMP_MIB_ITEM("DSSSplitTail", MPTCP_MIB_DSSSPLITTAIL),
+	SNMP_MIB_ITEM("DSSPurgeOldSubSegs", MPTCP_MIB_PURGEOLD),
+	SNMP_MIB_ITEM("AddAddrRx", MPTCP_MIB_ADDADDRRX),
+	SNMP_MIB_ITEM("AddAddrTx", MPTCP_MIB_ADDADDRTX),
+	SNMP_MIB_ITEM("RemAddrRx", MPTCP_MIB_REMADDRRX),
+	SNMP_MIB_ITEM("RemAddrTx", MPTCP_MIB_REMADDRTX),
+	SNMP_MIB_SENTINEL
+};
+
+struct workqueue_struct *mptcp_wq;
+EXPORT_SYMBOL(mptcp_wq);
+
+/* Output /proc/net/mptcp */
+static int mptcp_pm_seq_show(struct seq_file *seq, void *v)
+{
+	struct tcp_sock *meta_tp;
+	const struct net *net =3D seq->private;
+	int i, n =3D 0;
+
+	seq_printf(seq, "  sl  loc_tok  rem_tok  v6 local_address                =
         remote_address                        st ns tx_queue rx_queue inod=
e");
+	seq_putc(seq, '\n');
+
+	for (i =3D 0; i < MPTCP_HASH_SIZE; i++) {
+		struct hlist_nulls_node *node;
+
+		rcu_read_lock_bh();
+		hlist_nulls_for_each_entry_rcu(meta_tp, node,
+					       &tk_hashtable[i], tk_table) {
+			struct mptcp_cb *mpcb =3D meta_tp->mpcb;
+			struct sock *meta_sk =3D (struct sock *)meta_tp;
+			struct inet_sock *isk =3D inet_sk(meta_sk);
+
+			if (!mptcp(meta_tp) || !net_eq(net, sock_net(meta_sk)))
+				continue;
+
+			if (capable(CAP_NET_ADMIN)) {
+				seq_printf(seq, "%4d: %04X %04X ", n++,
+					   mpcb->mptcp_loc_token,
+					   mpcb->mptcp_rem_token);
+			} else {
+				seq_printf(seq, "%4d: %04X %04X ", n++, -1, -1);
+			}
+			if (meta_sk->sk_family =3D=3D AF_INET ||
+			    mptcp_v6_is_v4_mapped(meta_sk)) {
+				seq_printf(seq, " 0 %08X:%04X                         %08X:%04X       =
                 ",
+					   isk->inet_rcv_saddr,
+					   ntohs(isk->inet_sport),
+					   isk->inet_daddr,
+					   ntohs(isk->inet_dport));
+#if IS_ENABLED(CONFIG_IPV6)
+			} else if (meta_sk->sk_family =3D=3D AF_INET6) {
+				struct in6_addr *src =3D
+					&meta_sk->sk_v6_rcv_saddr;
+				struct in6_addr *dst =3D &meta_sk->sk_v6_daddr;
+
+				seq_printf(seq, " 1 %08X%08X%08X%08X:%04X %08X%08X%08X%08X:%04X",
+					   src->s6_addr32[0], src->s6_addr32[1],
+					   src->s6_addr32[2], src->s6_addr32[3],
+					   ntohs(isk->inet_sport),
+					   dst->s6_addr32[0], dst->s6_addr32[1],
+					   dst->s6_addr32[2], dst->s6_addr32[3],
+					   ntohs(isk->inet_dport));
+#endif
+			}
+			seq_printf(seq, " %02X %02X %08X:%08X %lu",
+				   meta_sk->sk_state, mpcb->cnt_subflows,
+				   meta_tp->write_seq - meta_tp->snd_una,
+				   max_t(int, meta_tp->rcv_nxt -
+					 meta_tp->copied_seq, 0),
+				   sock_i_ino(meta_sk));
+			seq_putc(seq, '\n');
+		}
+
+		rcu_read_unlock_bh();
+	}
+
+	return 0;
+}
+
+static int mptcp_pm_seq_open(struct inode *inode, struct file *file)
+{
+	return single_open_net(inode, file, mptcp_pm_seq_show);
+}
+
+static const struct file_operations mptcp_pm_seq_fops =3D {
+	.owner =3D THIS_MODULE,
+	.open =3D mptcp_pm_seq_open,
+	.read =3D seq_read,
+	.llseek =3D seq_lseek,
+	.release =3D single_release_net,
+};
+
+static int mptcp_snmp_seq_show(struct seq_file *seq, void *v)
+{
+	struct net *net =3D seq->private;
+	int i;
+
+	for (i =3D 0; mptcp_snmp_list[i].name; i++)
+		seq_printf(seq, "%-32s\t%ld\n", mptcp_snmp_list[i].name,
+			   snmp_fold_field(net->mptcp.mptcp_statistics,
+					   mptcp_snmp_list[i].entry));
+
+	return 0;
+}
+
+static int mptcp_snmp_seq_open(struct inode *inode, struct file *file)
+{
+	return single_open_net(inode, file, mptcp_snmp_seq_show);
+}
+
+static const struct file_operations mptcp_snmp_seq_fops =3D {
+	.owner =3D THIS_MODULE,
+	.open =3D mptcp_snmp_seq_open,
+	.read =3D seq_read,
+	.llseek =3D seq_lseek,
+	.release =3D single_release_net,
+};
+
+static int mptcp_pm_init_net(struct net *net)
+{
+	net->mptcp.mptcp_statistics =3D alloc_percpu(struct mptcp_mib);
+	if (!net->mptcp.mptcp_statistics)
+		goto out_mptcp_mibs;
+
+#ifdef CONFIG_PROC_FS
+	net->mptcp.proc_net_mptcp =3D proc_net_mkdir(net, "mptcp_net",
+						   net->proc_net);
+	if (!net->mptcp.proc_net_mptcp)
+		goto out_proc_net_mptcp;
+	if (!proc_create("mptcp", S_IRUGO, net->mptcp.proc_net_mptcp,
+			 &mptcp_pm_seq_fops))
+		goto out_mptcp_net_mptcp;
+	if (!proc_create("snmp", S_IRUGO, net->mptcp.proc_net_mptcp,
+			 &mptcp_snmp_seq_fops))
+		goto out_mptcp_net_snmp;
+#endif
+
+	return 0;
+
+#ifdef CONFIG_PROC_FS
+out_mptcp_net_snmp:
+	remove_proc_entry("mptcp", net->mptcp.proc_net_mptcp);
+out_mptcp_net_mptcp:
+	remove_proc_subtree("mptcp_net", net->proc_net);
+	net->mptcp.proc_net_mptcp =3D NULL;
+out_proc_net_mptcp:
+	free_percpu(net->mptcp.mptcp_statistics);
+#endif
+out_mptcp_mibs:
+	return -ENOMEM;
+}
+
+static void mptcp_pm_exit_net(struct net *net)
+{
+	remove_proc_entry("snmp", net->mptcp.proc_net_mptcp);
+	remove_proc_entry("mptcp", net->mptcp.proc_net_mptcp);
+	remove_proc_subtree("mptcp_net", net->proc_net);
+	free_percpu(net->mptcp.mptcp_statistics);
+}
+
+static struct pernet_operations mptcp_pm_proc_ops =3D {
+	.init =3D mptcp_pm_init_net,
+	.exit =3D mptcp_pm_exit_net,
+};
+
+/* General initialization of mptcp */
+void __init mptcp_init(void)
+{
+	int i;
+	struct ctl_table_header *mptcp_sysctl;
+
+	mptcp_sock_cache =3D kmem_cache_create("mptcp_sock",
+					     sizeof(struct mptcp_tcp_sock),
+					     0, SLAB_HWCACHE_ALIGN,
+					     NULL);
+	if (!mptcp_sock_cache)
+		goto mptcp_sock_cache_failed;
+
+	mptcp_cb_cache =3D
+		kmem_cache_create("mptcp_cb", sizeof(struct mptcp_cb), 0,
+				  SLAB_TYPESAFE_BY_RCU | SLAB_HWCACHE_ALIGN,
+				  NULL);
+	if (!mptcp_cb_cache)
+		goto mptcp_cb_cache_failed;
+
+	mptcp_tw_cache =3D
+		kmem_cache_create("mptcp_tw", sizeof(struct mptcp_tw), 0,
+				  SLAB_TYPESAFE_BY_RCU | SLAB_HWCACHE_ALIGN,
+				  NULL);
+	if (!mptcp_tw_cache)
+		goto mptcp_tw_cache_failed;
+
+	if (cmpxchg(&tcp_process_unclaimed, NULL, mptcp_do_rcv))
+		goto mptcp_tw_cache_failed;
+
+	get_random_bytes(mptcp_secret, sizeof(mptcp_secret));
+
+	mptcp_wq =3D alloc_workqueue("mptcp_wq", WQ_UNBOUND | WQ_MEM_RECLAIM, 8);
+	if (!mptcp_wq)
+		goto alloc_workqueue_failed;
+
+	for (i =3D 0; i < MPTCP_HASH_SIZE; i++) {
+		INIT_HLIST_NULLS_HEAD(&tk_hashtable[i], i);
+		INIT_HLIST_NULLS_HEAD(&mptcp_reqsk_htb[i],
+				      i + MPTCP_REQSK_NULLS_BASE);
+		INIT_HLIST_NULLS_HEAD(&mptcp_reqsk_tk_htb[i], i);
+	}
+
+	spin_lock_init(&mptcp_reqsk_hlock);
+	spin_lock_init(&mptcp_tk_hashlock);
+
+	if (register_pernet_subsys(&mptcp_pm_proc_ops))
+		goto pernet_failed;
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (mptcp_pm_v6_init())
+		goto mptcp_pm_v6_failed;
+#endif
+	if (mptcp_pm_v4_init())
+		goto mptcp_pm_v4_failed;
+
+	mptcp_sysctl =3D register_net_sysctl(&init_net, "net/mptcp", mptcp_table);
+	if (!mptcp_sysctl)
+		goto register_sysctl_failed;
+
+	if (mptcp_register_path_manager(&mptcp_pm_default))
+		goto register_pm_failed;
+
+	if (mptcp_register_scheduler(&mptcp_sched_default))
+		goto register_sched_failed;
+
+	pr_info("MPTCP: Stable release v0.91.3");
+
+	mptcp_init_failed =3D false;
+
+	tcp_default_op_ops->sock_init =3D mptcp_init_tcp_sock;
+	mptcp_default_op_ops =3D *tcp_default_op_ops;
+	mptcp_default_op_ops.synack_options_size =3D mptcp_synack_options_size;
+	mptcp_default_op_ops.options_size =3D mptcp_options_size;
+	mptcp_default_op_ops.options_write =3D mptcp_options_write;
+	mptcp_default_op_ops.connect_init =3D mptcp_connect_init;
+
+	return;
+
+register_sched_failed:
+	mptcp_unregister_path_manager(&mptcp_pm_default);
+register_pm_failed:
+	unregister_net_sysctl_table(mptcp_sysctl);
+register_sysctl_failed:
+	mptcp_pm_v4_undo();
+mptcp_pm_v4_failed:
+#if IS_ENABLED(CONFIG_IPV6)
+	mptcp_pm_v6_undo();
+mptcp_pm_v6_failed:
+#endif
+	unregister_pernet_subsys(&mptcp_pm_proc_ops);
+pernet_failed:
+	destroy_workqueue(mptcp_wq);
+alloc_workqueue_failed:
+	kmem_cache_destroy(mptcp_tw_cache);
+	tcp_process_unclaimed =3D NULL;
+mptcp_tw_cache_failed:
+	kmem_cache_destroy(mptcp_cb_cache);
+mptcp_cb_cache_failed:
+	kmem_cache_destroy(mptcp_sock_cache);
+mptcp_sock_cache_failed:
+	mptcp_init_failed =3D true;
+}
diff --git a/net/mptcp/mptcp_fullmesh.c b/net/mptcp/mptcp_fullmesh.c
new file mode 100644
index 0000000..a16fb14
--- /dev/null
+++ b/net/mptcp/mptcp_fullmesh.c
@@ -0,0 +1,1877 @@
+#include <linux/module.h>
+
+#include <net/mptcp.h>
+#include <net/mptcp_v4.h>
+
+#if IS_ENABLED(CONFIG_IPV6)
+#include <net/mptcp_v6.h>
+#include <net/addrconf.h>
+#endif
+#include <linux/proc_fs.h>
+
+enum {
+	MPTCP_EVENT_ADD =3D 1,
+	MPTCP_EVENT_DEL,
+	MPTCP_EVENT_MOD,
+};
+
+#define MPTCP_SUBFLOW_RETRY_DELAY	1000
+
+/* Max number of local or remote addresses we can store.
+ * When changing, see the bitfield below in fullmesh_rem4/6.
+ */
+#define MPTCP_MAX_ADDR	8
+
+struct fullmesh_rem4 {
+	u8		rem4_id;
+	u8		bitfield;
+	u8		retry_bitfield;
+	__be16		port;
+	struct in_addr	addr;
+};
+
+struct fullmesh_rem6 {
+	u8		rem6_id;
+	u8		bitfield;
+	u8		retry_bitfield;
+	__be16		port;
+	struct in6_addr	addr;
+};
+
+struct mptcp_loc_addr {
+	struct mptcp_loc4 locaddr4[MPTCP_MAX_ADDR];
+	u8 loc4_bits;
+	u8 next_v4_index;
+
+	struct mptcp_loc6 locaddr6[MPTCP_MAX_ADDR];
+	u8 loc6_bits;
+	u8 next_v6_index;
+};
+
+struct mptcp_addr_event {
+	struct list_head list;
+	unsigned short	family;
+	u8	code:7,
+		low_prio:1;
+	int	if_idx;
+	union inet_addr addr;
+};
+
+struct fullmesh_priv {
+	/* Worker struct for subflow establishment */
+	struct work_struct subflow_work;
+	/* Delayed worker, when the routing-tables are not yet ready. */
+	struct delayed_work subflow_retry_work;
+
+	/* Remote addresses */
+	struct fullmesh_rem4 remaddr4[MPTCP_MAX_ADDR];
+	struct fullmesh_rem6 remaddr6[MPTCP_MAX_ADDR];
+
+	struct mptcp_cb *mpcb;
+
+	u16 remove_addrs; /* Addresses to remove */
+	u8 announced_addrs_v4; /* IPv4 Addresses we did announce */
+	u8 announced_addrs_v6; /* IPv6 Addresses we did announce */
+
+	u8	add_addr; /* Are we sending an add_addr? */
+
+	u8 rem4_bits;
+	u8 rem6_bits;
+
+	/* Are we established the additional subflows for primary pair? */
+	u8 first_pair:1;
+};
+
+struct mptcp_fm_ns {
+	struct mptcp_loc_addr __rcu *local;
+	spinlock_t local_lock; /* Protecting the above pointer */
+	struct list_head events;
+	struct delayed_work address_worker;
+
+	struct net *net;
+};
+
+static int num_subflows __read_mostly =3D 1;
+module_param(num_subflows, int, 0644);
+MODULE_PARM_DESC(num_subflows, "choose the number of subflows per pair of =
IP addresses of MPTCP connection");
+
+static struct mptcp_pm_ops full_mesh __read_mostly;
+
+static void full_mesh_create_subflows(struct sock *meta_sk);
+
+static struct mptcp_fm_ns *fm_get_ns(const struct net *net)
+{
+	return (struct mptcp_fm_ns *)net->mptcp.path_managers[MPTCP_PM_FULLMESH];
+}
+
+static struct fullmesh_priv *fullmesh_get_priv(const struct mptcp_cb *mpcb)
+{
+	return (struct fullmesh_priv *)&mpcb->mptcp_pm[0];
+}
+
+/* Find the first free index in the bitfield */
+static int __mptcp_find_free_index(u8 bitfield, u8 base)
+{
+	int i;
+
+	/* There are anyways no free bits... */
+	if (bitfield =3D=3D 0xff)
+		goto exit;
+
+	i =3D ffs(~(bitfield >> base)) - 1;
+	if (i < 0)
+		goto exit;
+
+	/* No free bits when starting at base, try from 0 on */
+	if (i + base >=3D sizeof(bitfield) * 8)
+		return __mptcp_find_free_index(bitfield, 0);
+
+	return i + base;
+exit:
+	return -1;
+}
+
+static int mptcp_find_free_index(u8 bitfield)
+{
+	return __mptcp_find_free_index(bitfield, 0);
+}
+
+static void mptcp_addv4_raddr(struct mptcp_cb *mpcb,
+			      const struct in_addr *addr,
+			      __be16 port, u8 id)
+{
+	int i;
+	struct fullmesh_rem4 *rem4;
+	struct fullmesh_priv *fmp =3D fullmesh_get_priv(mpcb);
+
+	mptcp_for_each_bit_set(fmp->rem4_bits, i) {
+		rem4 =3D &fmp->remaddr4[i];
+
+		/* Address is already in the list --- continue */
+		if (rem4->rem4_id =3D=3D id &&
+		    rem4->addr.s_addr =3D=3D addr->s_addr && rem4->port =3D=3D port)
+			return;
+
+		/* This may be the case, when the peer is behind a NAT. He is
+		 * trying to JOIN, thus sending the JOIN with a certain ID.
+		 * However the src_addr of the IP-packet has been changed. We
+		 * update the addr in the list, because this is the address as
+		 * OUR BOX sees it.
+		 */
+		if (rem4->rem4_id =3D=3D id && rem4->addr.s_addr !=3D addr->s_addr) {
+			/* update the address */
+			mptcp_debug("%s: updating old addr:%pI4 to addr %pI4 with id:%d\n",
+				    __func__, &rem4->addr.s_addr,
+				    &addr->s_addr, id);
+			rem4->addr.s_addr =3D addr->s_addr;
+			rem4->port =3D port;
+			mpcb->list_rcvd =3D 1;
+			return;
+		}
+	}
+
+	i =3D mptcp_find_free_index(fmp->rem4_bits);
+	/* Do we have already the maximum number of local/remote addresses? */
+	if (i < 0) {
+		mptcp_debug("%s: At max num of remote addresses: %d --- not adding addre=
ss: %pI4\n",
+			    __func__, MPTCP_MAX_ADDR, &addr->s_addr);
+		return;
+	}
+
+	rem4 =3D &fmp->remaddr4[i];
+
+	/* Address is not known yet, store it */
+	rem4->addr.s_addr =3D addr->s_addr;
+	rem4->port =3D port;
+	rem4->bitfield =3D 0;
+	rem4->retry_bitfield =3D 0;
+	rem4->rem4_id =3D id;
+	mpcb->list_rcvd =3D 1;
+	fmp->rem4_bits |=3D (1 << i);
+
+	return;
+}
+
+static void mptcp_addv6_raddr(struct mptcp_cb *mpcb,
+			      const struct in6_addr *addr,
+			      __be16 port, u8 id)
+{
+	int i;
+	struct fullmesh_rem6 *rem6;
+	struct fullmesh_priv *fmp =3D fullmesh_get_priv(mpcb);
+
+	mptcp_for_each_bit_set(fmp->rem6_bits, i) {
+		rem6 =3D &fmp->remaddr6[i];
+
+		/* Address is already in the list --- continue */
+		if (rem6->rem6_id =3D=3D id &&
+		    ipv6_addr_equal(&rem6->addr, addr) && rem6->port =3D=3D port)
+			return;
+
+		/* This may be the case, when the peer is behind a NAT. He is
+		 * trying to JOIN, thus sending the JOIN with a certain ID.
+		 * However the src_addr of the IP-packet has been changed. We
+		 * update the addr in the list, because this is the address as
+		 * OUR BOX sees it.
+		 */
+		if (rem6->rem6_id =3D=3D id) {
+			/* update the address */
+			mptcp_debug("%s: updating old addr: %pI6 to addr %pI6 with id:%d\n",
+				    __func__, &rem6->addr, addr, id);
+			rem6->addr =3D *addr;
+			rem6->port =3D port;
+			mpcb->list_rcvd =3D 1;
+			return;
+		}
+	}
+
+	i =3D mptcp_find_free_index(fmp->rem6_bits);
+	/* Do we have already the maximum number of local/remote addresses? */
+	if (i < 0) {
+		mptcp_debug("%s: At max num of remote addresses: %d --- not adding addre=
ss: %pI6\n",
+			    __func__, MPTCP_MAX_ADDR, addr);
+		return;
+	}
+
+	rem6 =3D &fmp->remaddr6[i];
+
+	/* Address is not known yet, store it */
+	rem6->addr =3D *addr;
+	rem6->port =3D port;
+	rem6->bitfield =3D 0;
+	rem6->retry_bitfield =3D 0;
+	rem6->rem6_id =3D id;
+	mpcb->list_rcvd =3D 1;
+	fmp->rem6_bits |=3D (1 << i);
+
+	return;
+}
+
+static void mptcp_v4_rem_raddress(struct mptcp_cb *mpcb, u8 id)
+{
+	int i;
+	struct fullmesh_priv *fmp =3D fullmesh_get_priv(mpcb);
+
+	mptcp_for_each_bit_set(fmp->rem4_bits, i) {
+		if (fmp->remaddr4[i].rem4_id =3D=3D id) {
+			/* remove address from bitfield */
+			fmp->rem4_bits &=3D ~(1 << i);
+
+			break;
+		}
+	}
+}
+
+static void mptcp_v6_rem_raddress(const struct mptcp_cb *mpcb, u8 id)
+{
+	int i;
+	struct fullmesh_priv *fmp =3D fullmesh_get_priv(mpcb);
+
+	mptcp_for_each_bit_set(fmp->rem6_bits, i) {
+		if (fmp->remaddr6[i].rem6_id =3D=3D id) {
+			/* remove address from bitfield */
+			fmp->rem6_bits &=3D ~(1 << i);
+
+			break;
+		}
+	}
+}
+
+/* Sets the bitfield of the remote-address field */
+static void mptcp_v4_set_init_addr_bit(const struct mptcp_cb *mpcb,
+				       const struct in_addr *addr, u8 index)
+{
+	int i;
+	struct fullmesh_priv *fmp =3D fullmesh_get_priv(mpcb);
+
+	mptcp_for_each_bit_set(fmp->rem4_bits, i) {
+		if (fmp->remaddr4[i].addr.s_addr =3D=3D addr->s_addr) {
+			fmp->remaddr4[i].bitfield |=3D (1 << index);
+			return;
+		}
+	}
+}
+
+/* Sets the bitfield of the remote-address field */
+static void mptcp_v6_set_init_addr_bit(struct mptcp_cb *mpcb,
+				       const struct in6_addr *addr, u8 index)
+{
+	int i;
+	struct fullmesh_priv *fmp =3D fullmesh_get_priv(mpcb);
+
+	mptcp_for_each_bit_set(fmp->rem6_bits, i) {
+		if (ipv6_addr_equal(&fmp->remaddr6[i].addr, addr)) {
+			fmp->remaddr6[i].bitfield |=3D (1 << index);
+			return;
+		}
+	}
+}
+
+static void mptcp_set_init_addr_bit(struct mptcp_cb *mpcb,
+				    const union inet_addr *addr,
+				    sa_family_t family, u8 id)
+{
+	if (family =3D=3D AF_INET)
+		mptcp_v4_set_init_addr_bit(mpcb, &addr->in, id);
+	else
+		mptcp_v6_set_init_addr_bit(mpcb, &addr->in6, id);
+}
+
+static void mptcp_v4_subflows(struct sock *meta_sk,
+			      const struct mptcp_loc4 *loc,
+			      struct mptcp_rem4 *rem)
+{
+	int i;
+
+	for (i =3D 1; i < num_subflows; i++)
+		mptcp_init4_subsockets(meta_sk, loc, rem);
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+static void mptcp_v6_subflows(struct sock *meta_sk,
+			      const struct mptcp_loc6 *loc,
+			      struct mptcp_rem6 *rem)
+{
+	int i;
+
+	for (i =3D 1; i < num_subflows; i++)
+		mptcp_init6_subsockets(meta_sk, loc, rem);
+}
+#endif
+
+static void retry_subflow_worker(struct work_struct *work)
+{
+	struct delayed_work *delayed_work =3D container_of(work,
+							 struct delayed_work,
+							 work);
+	struct fullmesh_priv *fmp =3D container_of(delayed_work,
+						 struct fullmesh_priv,
+						 subflow_retry_work);
+	struct mptcp_cb *mpcb =3D fmp->mpcb;
+	struct sock *meta_sk =3D mpcb->meta_sk;
+	struct mptcp_loc_addr *mptcp_local;
+	struct mptcp_fm_ns *fm_ns =3D fm_get_ns(sock_net(meta_sk));
+	int iter =3D 0, i;
+
+	/* We need a local (stable) copy of the address-list. Really, it is not
+	 * such a big deal, if the address-list is not 100% up-to-date.
+	 */
+	rcu_read_lock_bh();
+	mptcp_local =3D rcu_dereference_bh(fm_ns->local);
+	mptcp_local =3D kmemdup(mptcp_local, sizeof(*mptcp_local), GFP_ATOMIC);
+	rcu_read_unlock_bh();
+
+	if (!mptcp_local)
+		return;
+
+next_subflow:
+	if (iter) {
+		release_sock(meta_sk);
+		mutex_unlock(&mpcb->mpcb_mutex);
+
+		cond_resched();
+	}
+	mutex_lock(&mpcb->mpcb_mutex);
+	lock_sock_nested(meta_sk, SINGLE_DEPTH_NESTING);
+
+	iter++;
+
+	if (sock_flag(meta_sk, SOCK_DEAD))
+		goto exit;
+
+	mptcp_for_each_bit_set(fmp->rem4_bits, i) {
+		struct fullmesh_rem4 *rem =3D &fmp->remaddr4[i];
+		/* Do we need to retry establishing a subflow ? */
+		if (rem->retry_bitfield) {
+			int i =3D mptcp_find_free_index(~rem->retry_bitfield);
+			struct mptcp_rem4 rem4;
+
+			rem->bitfield |=3D (1 << i);
+			rem->retry_bitfield &=3D ~(1 << i);
+
+			rem4.addr =3D rem->addr;
+			rem4.port =3D rem->port;
+			rem4.rem4_id =3D rem->rem4_id;
+
+			mptcp_init4_subsockets(meta_sk, &mptcp_local->locaddr4[i], &rem4);
+			mptcp_v4_subflows(meta_sk,
+					  &mptcp_local->locaddr4[i],
+					  &rem4);
+			goto next_subflow;
+		}
+	}
+
+#if IS_ENABLED(CONFIG_IPV6)
+	mptcp_for_each_bit_set(fmp->rem6_bits, i) {
+		struct fullmesh_rem6 *rem =3D &fmp->remaddr6[i];
+
+		/* Do we need to retry establishing a subflow ? */
+		if (rem->retry_bitfield) {
+			int i =3D mptcp_find_free_index(~rem->retry_bitfield);
+			struct mptcp_rem6 rem6;
+
+			rem->bitfield |=3D (1 << i);
+			rem->retry_bitfield &=3D ~(1 << i);
+
+			rem6.addr =3D rem->addr;
+			rem6.port =3D rem->port;
+			rem6.rem6_id =3D rem->rem6_id;
+
+			mptcp_init6_subsockets(meta_sk, &mptcp_local->locaddr6[i], &rem6);
+			mptcp_v6_subflows(meta_sk,
+					  &mptcp_local->locaddr6[i],
+					  &rem6);
+			goto next_subflow;
+		}
+	}
+#endif
+
+exit:
+	kfree(mptcp_local);
+	release_sock(meta_sk);
+	mutex_unlock(&mpcb->mpcb_mutex);
+	sock_put(meta_sk);
+}
+
+/**
+ * Create all new subflows, by doing calls to mptcp_initX_subsockets
+ *
+ * This function uses a goto next_subflow, to allow releasing the lock bet=
ween
+ * new subflows and giving other processes a chance to do some work on the
+ * socket and potentially finishing the communication.
+ **/
+static void create_subflow_worker(struct work_struct *work)
+{
+	struct fullmesh_priv *fmp =3D container_of(work, struct fullmesh_priv,
+						 subflow_work);
+	struct mptcp_cb *mpcb =3D fmp->mpcb;
+	struct sock *meta_sk =3D mpcb->meta_sk;
+	struct mptcp_loc_addr *mptcp_local;
+	const struct mptcp_fm_ns *fm_ns =3D fm_get_ns(sock_net(meta_sk));
+	int iter =3D 0, retry =3D 0;
+	int i;
+
+	/* We need a local (stable) copy of the address-list. Really, it is not
+	 * such a big deal, if the address-list is not 100% up-to-date.
+	 */
+	rcu_read_lock_bh();
+	mptcp_local =3D rcu_dereference_bh(fm_ns->local);
+	mptcp_local =3D kmemdup(mptcp_local, sizeof(*mptcp_local), GFP_ATOMIC);
+	rcu_read_unlock_bh();
+
+	if (!mptcp_local)
+		return;
+
+next_subflow:
+	if (iter) {
+		release_sock(meta_sk);
+		mutex_unlock(&mpcb->mpcb_mutex);
+
+		cond_resched();
+	}
+	mutex_lock(&mpcb->mpcb_mutex);
+	lock_sock_nested(meta_sk, SINGLE_DEPTH_NESTING);
+
+	/* Create the additional subflows for the first pair */
+	if (fmp->first_pair =3D=3D 0 && mpcb->master_sk) {
+		struct mptcp_loc4 loc;
+		struct mptcp_rem4 rem;
+
+		loc.addr.s_addr =3D inet_sk(meta_sk)->inet_saddr;
+		loc.loc4_id =3D 0;
+		loc.low_prio =3D 0;
+		loc.if_idx =3D mpcb->master_sk->sk_bound_dev_if;
+
+		rem.addr.s_addr =3D inet_sk(meta_sk)->inet_daddr;
+		rem.port =3D inet_sk(meta_sk)->inet_dport;
+		rem.rem4_id =3D 0; /* Default 0 */
+
+		mptcp_v4_subflows(meta_sk, &loc, &rem);
+
+		fmp->first_pair =3D 1;
+	}
+	iter++;
+
+	if (sock_flag(meta_sk, SOCK_DEAD))
+		goto exit;
+
+	if (mpcb->master_sk &&
+	    !tcp_sk(mpcb->master_sk)->mptcp->fully_established)
+		goto exit;
+
+	mptcp_for_each_bit_set(fmp->rem4_bits, i) {
+		struct fullmesh_rem4 *rem;
+		u8 remaining_bits;
+
+		rem =3D &fmp->remaddr4[i];
+		remaining_bits =3D ~(rem->bitfield) & mptcp_local->loc4_bits;
+
+		/* Are there still combinations to handle? */
+		if (remaining_bits) {
+			int i =3D mptcp_find_free_index(~remaining_bits);
+			struct mptcp_rem4 rem4;
+
+			rem->bitfield |=3D (1 << i);
+
+			rem4.addr =3D rem->addr;
+			rem4.port =3D rem->port;
+			rem4.rem4_id =3D rem->rem4_id;
+
+			/* If a route is not yet available then retry once */
+			if (mptcp_init4_subsockets(meta_sk, &mptcp_local->locaddr4[i],
+						   &rem4) =3D=3D -ENETUNREACH)
+				retry =3D rem->retry_bitfield |=3D (1 << i);
+			else
+				mptcp_v4_subflows(meta_sk,
+						  &mptcp_local->locaddr4[i],
+						  &rem4);
+			goto next_subflow;
+		}
+	}
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (fmp->first_pair =3D=3D 0 && mpcb->master_sk) {
+			struct mptcp_loc6 loc;
+			struct mptcp_rem6 rem;
+
+			loc.addr =3D inet6_sk(meta_sk)->saddr;
+			loc.loc6_id =3D 0;
+			loc.low_prio =3D 0;
+			loc.if_idx =3D mpcb->master_sk->sk_bound_dev_if;
+
+			rem.addr =3D meta_sk->sk_v6_daddr;
+			rem.port =3D inet_sk(meta_sk)->inet_dport;
+			rem.rem6_id =3D 0; /* Default 0 */
+
+			mptcp_v6_subflows(meta_sk, &loc, &rem);
+
+			fmp->first_pair =3D 1;
+	}
+	mptcp_for_each_bit_set(fmp->rem6_bits, i) {
+		struct fullmesh_rem6 *rem;
+		u8 remaining_bits;
+
+		rem =3D &fmp->remaddr6[i];
+		remaining_bits =3D ~(rem->bitfield) & mptcp_local->loc6_bits;
+
+		/* Are there still combinations to handle? */
+		if (remaining_bits) {
+			int i =3D mptcp_find_free_index(~remaining_bits);
+			struct mptcp_rem6 rem6;
+
+			rem->bitfield |=3D (1 << i);
+
+			rem6.addr =3D rem->addr;
+			rem6.port =3D rem->port;
+			rem6.rem6_id =3D rem->rem6_id;
+
+			/* If a route is not yet available then retry once */
+			if (mptcp_init6_subsockets(meta_sk, &mptcp_local->locaddr6[i],
+						   &rem6) =3D=3D -ENETUNREACH)
+				retry =3D rem->retry_bitfield |=3D (1 << i);
+			else
+				mptcp_v6_subflows(meta_sk,
+						  &mptcp_local->locaddr6[i],
+						  &rem6);
+			goto next_subflow;
+		}
+	}
+#endif
+
+	if (retry && !delayed_work_pending(&fmp->subflow_retry_work)) {
+		sock_hold(meta_sk);
+		queue_delayed_work(mptcp_wq, &fmp->subflow_retry_work,
+				   msecs_to_jiffies(MPTCP_SUBFLOW_RETRY_DELAY));
+	}
+
+exit:
+	kfree(mptcp_local);
+	release_sock(meta_sk);
+	mutex_unlock(&mpcb->mpcb_mutex);
+	sock_put(meta_sk);
+}
+
+static void announce_remove_addr(u8 addr_id, struct sock *meta_sk)
+{
+	struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
+	struct fullmesh_priv *fmp =3D fullmesh_get_priv(mpcb);
+	struct sock *sk =3D mptcp_select_ack_sock(meta_sk);
+
+	fmp->remove_addrs |=3D (1 << addr_id);
+	mpcb->addr_signal =3D 1;
+
+	if (sk)
+		tcp_send_ack(sk);
+}
+
+static void update_addr_bitfields(struct sock *meta_sk,
+				  const struct mptcp_loc_addr *mptcp_local)
+{
+	struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
+	struct fullmesh_priv *fmp =3D fullmesh_get_priv(mpcb);
+	int i;
+
+	/* The bits in announced_addrs_* always match with loc*_bits. So, a
+	 * simply & operation unsets the correct bits, because these go from
+	 * announced to non-announced
+	 */
+	fmp->announced_addrs_v4 &=3D mptcp_local->loc4_bits;
+
+	mptcp_for_each_bit_set(fmp->rem4_bits, i) {
+		fmp->remaddr4[i].bitfield &=3D mptcp_local->loc4_bits;
+		fmp->remaddr4[i].retry_bitfield &=3D mptcp_local->loc4_bits;
+	}
+
+	fmp->announced_addrs_v6 &=3D mptcp_local->loc6_bits;
+
+	mptcp_for_each_bit_set(fmp->rem6_bits, i) {
+		fmp->remaddr6[i].bitfield &=3D mptcp_local->loc6_bits;
+		fmp->remaddr6[i].retry_bitfield &=3D mptcp_local->loc6_bits;
+	}
+}
+
+static int mptcp_find_address(const struct mptcp_loc_addr *mptcp_local,
+			      sa_family_t family, const union inet_addr *addr,
+			      int if_idx)
+{
+	int i;
+	u8 loc_bits;
+	bool found =3D false;
+
+	if (family =3D=3D AF_INET)
+		loc_bits =3D mptcp_local->loc4_bits;
+	else
+		loc_bits =3D mptcp_local->loc6_bits;
+
+	mptcp_for_each_bit_set(loc_bits, i) {
+		if (family =3D=3D AF_INET &&
+		    (!if_idx || mptcp_local->locaddr4[i].if_idx =3D=3D if_idx) &&
+		    mptcp_local->locaddr4[i].addr.s_addr =3D=3D addr->in.s_addr) {
+			found =3D true;
+			break;
+		}
+		if (family =3D=3D AF_INET6 &&
+		    (!if_idx || mptcp_local->locaddr6[i].if_idx =3D=3D if_idx) &&
+		    ipv6_addr_equal(&mptcp_local->locaddr6[i].addr,
+				    &addr->in6)) {
+			found =3D true;
+			break;
+		}
+	}
+
+	if (!found)
+		return -1;
+
+	return i;
+}
+
+static void mptcp_address_worker(struct work_struct *work)
+{
+	const struct delayed_work *delayed_work =3D container_of(work,
+							 struct delayed_work,
+							 work);
+	struct mptcp_fm_ns *fm_ns =3D container_of(delayed_work,
+						 struct mptcp_fm_ns,
+						 address_worker);
+	struct net *net =3D fm_ns->net;
+	struct mptcp_addr_event *event =3D NULL;
+	struct mptcp_loc_addr *mptcp_local, *old;
+	int i, id =3D -1; /* id is used in the socket-code on a delete-event */
+	bool success; /* Used to indicate if we succeeded handling the event */
+
+next_event:
+	success =3D false;
+	kfree(event);
+
+	/* First, let's dequeue an event from our event-list */
+	rcu_read_lock_bh();
+	spin_lock(&fm_ns->local_lock);
+
+	event =3D list_first_entry_or_null(&fm_ns->events,
+					 struct mptcp_addr_event, list);
+	if (!event) {
+		spin_unlock(&fm_ns->local_lock);
+		rcu_read_unlock_bh();
+		return;
+	}
+
+	list_del(&event->list);
+
+	mptcp_local =3D rcu_dereference_bh(fm_ns->local);
+
+	if (event->code =3D=3D MPTCP_EVENT_DEL) {
+		id =3D mptcp_find_address(mptcp_local, event->family,
+					&event->addr, event->if_idx);
+
+		/* Not in the list - so we don't care */
+		if (id < 0) {
+			mptcp_debug("%s could not find id\n", __func__);
+			goto duno;
+		}
+
+		old =3D mptcp_local;
+		mptcp_local =3D kmemdup(mptcp_local, sizeof(*mptcp_local),
+				      GFP_ATOMIC);
+		if (!mptcp_local)
+			goto duno;
+
+		if (event->family =3D=3D AF_INET)
+			mptcp_local->loc4_bits &=3D ~(1 << id);
+		else
+			mptcp_local->loc6_bits &=3D ~(1 << id);
+
+		rcu_assign_pointer(fm_ns->local, mptcp_local);
+		kfree(old);
+	} else {
+		int i =3D mptcp_find_address(mptcp_local, event->family,
+					   &event->addr, event->if_idx);
+		int j =3D i;
+
+		if (j < 0) {
+			/* Not in the list, so we have to find an empty slot */
+			if (event->family =3D=3D AF_INET)
+				i =3D __mptcp_find_free_index(mptcp_local->loc4_bits,
+							    mptcp_local->next_v4_index);
+			if (event->family =3D=3D AF_INET6)
+				i =3D __mptcp_find_free_index(mptcp_local->loc6_bits,
+							    mptcp_local->next_v6_index);
+
+			if (i < 0) {
+				mptcp_debug("%s no more space\n", __func__);
+				goto duno;
+			}
+
+			/* It might have been a MOD-event. */
+			event->code =3D MPTCP_EVENT_ADD;
+		} else {
+			/* Let's check if anything changes */
+			if (event->family =3D=3D AF_INET &&
+			    event->low_prio =3D=3D mptcp_local->locaddr4[i].low_prio)
+				goto duno;
+
+			if (event->family =3D=3D AF_INET6 &&
+			    event->low_prio =3D=3D mptcp_local->locaddr6[i].low_prio)
+				goto duno;
+		}
+
+		old =3D mptcp_local;
+		mptcp_local =3D kmemdup(mptcp_local, sizeof(*mptcp_local),
+				      GFP_ATOMIC);
+		if (!mptcp_local)
+			goto duno;
+
+		if (event->family =3D=3D AF_INET) {
+			mptcp_local->locaddr4[i].addr.s_addr =3D event->addr.in.s_addr;
+			mptcp_local->locaddr4[i].loc4_id =3D i + 1;
+			mptcp_local->locaddr4[i].low_prio =3D event->low_prio;
+			mptcp_local->locaddr4[i].if_idx =3D event->if_idx;
+		} else {
+			mptcp_local->locaddr6[i].addr =3D event->addr.in6;
+			mptcp_local->locaddr6[i].loc6_id =3D i + MPTCP_MAX_ADDR;
+			mptcp_local->locaddr6[i].low_prio =3D event->low_prio;
+			mptcp_local->locaddr6[i].if_idx =3D event->if_idx;
+		}
+
+		if (j < 0) {
+			if (event->family =3D=3D AF_INET) {
+				mptcp_local->loc4_bits |=3D (1 << i);
+				mptcp_local->next_v4_index =3D i + 1;
+			} else {
+				mptcp_local->loc6_bits |=3D (1 << i);
+				mptcp_local->next_v6_index =3D i + 1;
+			}
+		}
+
+		rcu_assign_pointer(fm_ns->local, mptcp_local);
+		kfree(old);
+	}
+	success =3D true;
+
+duno:
+	spin_unlock(&fm_ns->local_lock);
+	rcu_read_unlock_bh();
+
+	if (!success)
+		goto next_event;
+
+	/* Now we iterate over the MPTCP-sockets and apply the event. */
+	for (i =3D 0; i < MPTCP_HASH_SIZE; i++) {
+		const struct hlist_nulls_node *node;
+		struct tcp_sock *meta_tp;
+
+		rcu_read_lock_bh();
+		hlist_nulls_for_each_entry_rcu(meta_tp, node, &tk_hashtable[i],
+					       tk_table) {
+			struct mptcp_cb *mpcb =3D meta_tp->mpcb;
+			struct sock *meta_sk =3D (struct sock *)meta_tp, *sk;
+			struct fullmesh_priv *fmp =3D fullmesh_get_priv(mpcb);
+			bool meta_v4 =3D meta_sk->sk_family =3D=3D AF_INET;
+
+			if (sock_net(meta_sk) !=3D net)
+				continue;
+
+			if (meta_v4) {
+				/* skip IPv6 events if meta is IPv4 */
+				if (event->family =3D=3D AF_INET6)
+					continue;
+			}
+			/* skip IPv4 events if IPV6_V6ONLY is set */
+			else if (event->family =3D=3D AF_INET && meta_sk->sk_ipv6only)
+				continue;
+
+			if (unlikely(!refcount_inc_not_zero(&meta_sk->sk_refcnt)))
+				continue;
+
+			bh_lock_sock(meta_sk);
+
+			if (!mptcp(meta_tp) || !is_meta_sk(meta_sk) ||
+			    mpcb->infinite_mapping_snd ||
+			    mpcb->infinite_mapping_rcv ||
+			    mpcb->send_infinite_mapping)
+				goto next;
+
+			/* May be that the pm has changed in-between */
+			if (mpcb->pm_ops !=3D &full_mesh)
+				goto next;
+
+			if (sock_owned_by_user(meta_sk)) {
+				if (!test_and_set_bit(MPTCP_PATH_MANAGER,
+						      &meta_sk->sk_tsq_flags))
+					sock_hold(meta_sk);
+
+				goto next;
+			}
+
+			if (event->code =3D=3D MPTCP_EVENT_ADD) {
+				fmp->add_addr++;
+				mpcb->addr_signal =3D 1;
+
+				sk =3D mptcp_select_ack_sock(meta_sk);
+				if (sk)
+					tcp_send_ack(sk);
+
+				full_mesh_create_subflows(meta_sk);
+			}
+
+			if (event->code =3D=3D MPTCP_EVENT_DEL) {
+				struct sock *sk, *tmpsk;
+				struct mptcp_loc_addr *mptcp_local;
+				bool found =3D false;
+
+				mptcp_local =3D rcu_dereference_bh(fm_ns->local);
+
+				/* In any case, we need to update our bitfields */
+				if (id >=3D 0)
+					update_addr_bitfields(meta_sk, mptcp_local);
+
+				/* Look for the socket and remove him */
+				mptcp_for_each_sk_safe(mpcb, sk, tmpsk) {
+					if ((event->family =3D=3D AF_INET6 &&
+					     (sk->sk_family =3D=3D AF_INET ||
+					      mptcp_v6_is_v4_mapped(sk))) ||
+					    (event->family =3D=3D AF_INET &&
+					     (sk->sk_family =3D=3D AF_INET6 &&
+					      !mptcp_v6_is_v4_mapped(sk))))
+						continue;
+
+					if (event->family =3D=3D AF_INET &&
+					    (sk->sk_family =3D=3D AF_INET ||
+					     mptcp_v6_is_v4_mapped(sk)) &&
+					     inet_sk(sk)->inet_saddr !=3D event->addr.in.s_addr)
+						continue;
+
+					if (event->family =3D=3D AF_INET6 &&
+					    sk->sk_family =3D=3D AF_INET6 &&
+					    !ipv6_addr_equal(&inet6_sk(sk)->saddr, &event->addr.in6))
+						continue;
+
+					/* Reinject, so that pf =3D 1 and so we
+					 * won't select this one as the
+					 * ack-sock.
+					 */
+					mptcp_reinject_data(sk, 0);
+
+					/* We announce the removal of this id */
+					announce_remove_addr(tcp_sk(sk)->mptcp->loc_id, meta_sk);
+
+					mptcp_sub_force_close(sk);
+					found =3D true;
+				}
+
+				if (found)
+					goto next;
+
+				/* The id may have been given by the event,
+				 * matching on a local address. And it may not
+				 * have matched on one of the above sockets,
+				 * because the client never created a subflow.
+				 * So, we have to finally remove it here.
+				 */
+				if (id > 0)
+					announce_remove_addr(id, meta_sk);
+			}
+
+			if (event->code =3D=3D MPTCP_EVENT_MOD) {
+				struct sock *sk;
+
+				mptcp_for_each_sk(mpcb, sk) {
+					struct tcp_sock *tp =3D tcp_sk(sk);
+					if (event->family =3D=3D AF_INET &&
+					    (sk->sk_family =3D=3D AF_INET ||
+					     mptcp_v6_is_v4_mapped(sk)) &&
+					     inet_sk(sk)->inet_saddr =3D=3D event->addr.in.s_addr) {
+						if (event->low_prio !=3D tp->mptcp->low_prio) {
+							tp->mptcp->send_mp_prio =3D 1;
+							tp->mptcp->low_prio =3D event->low_prio;
+
+							tcp_send_ack(sk);
+						}
+					}
+
+					if (event->family =3D=3D AF_INET6 &&
+					    sk->sk_family =3D=3D AF_INET6 &&
+					    !ipv6_addr_equal(&inet6_sk(sk)->saddr, &event->addr.in6)) {
+						if (event->low_prio !=3D tp->mptcp->low_prio) {
+							tp->mptcp->send_mp_prio =3D 1;
+							tp->mptcp->low_prio =3D event->low_prio;
+
+							tcp_send_ack(sk);
+						}
+					}
+				}
+			}
+next:
+			bh_unlock_sock(meta_sk);
+			sock_put(meta_sk);
+		}
+		rcu_read_unlock_bh();
+	}
+	goto next_event;
+}
+
+static struct mptcp_addr_event *lookup_similar_event(const struct net *net,
+						     const struct mptcp_addr_event *event)
+{
+	struct mptcp_addr_event *eventq;
+	struct mptcp_fm_ns *fm_ns =3D fm_get_ns(net);
+
+	list_for_each_entry(eventq, &fm_ns->events, list) {
+		if (eventq->family !=3D event->family)
+			continue;
+		if (event->family =3D=3D AF_INET) {
+			if (eventq->addr.in.s_addr =3D=3D event->addr.in.s_addr)
+				return eventq;
+		} else {
+			if (ipv6_addr_equal(&eventq->addr.in6, &event->addr.in6))
+				return eventq;
+		}
+	}
+	return NULL;
+}
+
+/* We already hold the net-namespace MPTCP-lock */
+static void add_pm_event(struct net *net, const struct mptcp_addr_event *e=
vent)
+{
+	struct mptcp_addr_event *eventq =3D lookup_similar_event(net, event);
+	struct mptcp_fm_ns *fm_ns =3D fm_get_ns(net);
+
+	if (eventq) {
+		switch (event->code) {
+		case MPTCP_EVENT_DEL:
+			mptcp_debug("%s del old_code %u\n", __func__, eventq->code);
+			list_del(&eventq->list);
+			kfree(eventq);
+			break;
+		case MPTCP_EVENT_ADD:
+			mptcp_debug("%s add old_code %u\n", __func__, eventq->code);
+			eventq->low_prio =3D event->low_prio;
+			eventq->code =3D MPTCP_EVENT_ADD;
+			return;
+		case MPTCP_EVENT_MOD:
+			mptcp_debug("%s mod old_code %u\n", __func__, eventq->code);
+			eventq->low_prio =3D event->low_prio;
+			eventq->code =3D MPTCP_EVENT_MOD;
+			return;
+		}
+	}
+
+	/* OK, we have to add the new address to the wait queue */
+	eventq =3D kmemdup(event, sizeof(struct mptcp_addr_event), GFP_ATOMIC);
+	if (!eventq)
+		return;
+
+	list_add_tail(&eventq->list, &fm_ns->events);
+
+	/* Create work-queue */
+	if (!delayed_work_pending(&fm_ns->address_worker))
+		queue_delayed_work(mptcp_wq, &fm_ns->address_worker,
+				   msecs_to_jiffies(500));
+}
+
+static void addr4_event_handler(const struct in_ifaddr *ifa, unsigned long=
 event,
+				struct net *net)
+{
+	const struct net_device *netdev =3D ifa->ifa_dev->dev;
+	struct mptcp_fm_ns *fm_ns =3D fm_get_ns(net);
+	struct mptcp_addr_event mpevent;
+
+	if (ifa->ifa_scope > RT_SCOPE_LINK ||
+	    ipv4_is_loopback(ifa->ifa_local))
+		return;
+
+	spin_lock_bh(&fm_ns->local_lock);
+
+	mpevent.family =3D AF_INET;
+	mpevent.addr.in.s_addr =3D ifa->ifa_local;
+	mpevent.low_prio =3D (netdev->flags & IFF_MPBACKUP) ? 1 : 0;
+	mpevent.if_idx  =3D netdev->ifindex;
+
+	if (event =3D=3D NETDEV_DOWN || !netif_running(netdev) ||
+	    (netdev->flags & IFF_NOMULTIPATH) || !(netdev->flags & IFF_UP))
+		mpevent.code =3D MPTCP_EVENT_DEL;
+	else if (event =3D=3D NETDEV_UP)
+		mpevent.code =3D MPTCP_EVENT_ADD;
+	else if (event =3D=3D NETDEV_CHANGE)
+		mpevent.code =3D MPTCP_EVENT_MOD;
+
+	mptcp_debug("%s created event for %pI4, code %u prio %u\n", __func__,
+		    &ifa->ifa_local, mpevent.code, mpevent.low_prio);
+	add_pm_event(net, &mpevent);
+
+	spin_unlock_bh(&fm_ns->local_lock);
+	return;
+}
+
+/* React on IPv4-addr add/rem-events */
+static int mptcp_pm_inetaddr_event(struct notifier_block *this,
+				   unsigned long event, void *ptr)
+{
+	const struct in_ifaddr *ifa =3D (struct in_ifaddr *)ptr;
+	struct net *net =3D dev_net(ifa->ifa_dev->dev);
+
+	if (!(event =3D=3D NETDEV_UP || event =3D=3D NETDEV_DOWN ||
+	      event =3D=3D NETDEV_CHANGE))
+		return NOTIFY_DONE;
+
+	addr4_event_handler(ifa, event, net);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block mptcp_pm_inetaddr_notifier =3D {
+		.notifier_call =3D mptcp_pm_inetaddr_event,
+};
+
+#if IS_ENABLED(CONFIG_IPV6)
+
+/* IPV6-related address/interface watchers */
+struct mptcp_dad_data {
+	struct timer_list timer;
+	struct inet6_ifaddr *ifa;
+};
+
+static void dad_callback(struct timer_list *t);
+static int inet6_addr_event(struct notifier_block *this,
+				     unsigned long event, void *ptr);
+
+static bool ipv6_dad_finished(const struct inet6_ifaddr *ifa)
+{
+	return !(ifa->flags & IFA_F_TENTATIVE) ||
+	       ifa->state > INET6_IFADDR_STATE_DAD;
+}
+
+static void dad_init_timer(struct mptcp_dad_data *data,
+				 struct inet6_ifaddr *ifa)
+{
+	data->ifa =3D ifa;
+	data->timer.function =3D dad_callback;
+	if (ifa->idev->cnf.rtr_solicit_delay)
+		data->timer.expires =3D jiffies + ifa->idev->cnf.rtr_solicit_delay;
+	else
+		data->timer.expires =3D jiffies + (HZ/10);
+}
+
+static void dad_callback(struct timer_list *t)
+{
+	struct mptcp_dad_data *data =3D from_timer(data, t, timer);
+
+	return;
+#ifdef RAO
+	/* DAD failed or IP brought down? */
+	if (data->ifa->state =3D=3D INET6_IFADDR_STATE_ERRDAD ||
+	    data->ifa->state =3D=3D INET6_IFADDR_STATE_DEAD)
+		goto exit;
+
+	if (!ipv6_dad_finished(data->ifa)) {
+		dad_init_timer(data, data->ifa);
+		add_timer(&data->timer);
+		return;
+	}
+
+	inet6_addr_event(NULL, NETDEV_UP, data->ifa);
+
+exit:
+	in6_ifa_put(data->ifa);
+	kfree(data);
+#endif
+}
+
+static inline void dad_setup_timer(struct inet6_ifaddr *ifa)
+{
+	struct mptcp_dad_data *data;
+
+	return;
+#ifdef RAO
+	data =3D kmalloc(sizeof(*data), GFP_ATOMIC);
+
+	if (!data)
+		return;
+
+	dad_init_timer(data, ifa);
+	timer_setup(&data->timer, data->timer.function, 0);
+	add_timer(&data->timer);
+	in6_ifa_hold(ifa);
+#endif
+}
+
+static void addr6_event_handler(const struct inet6_ifaddr *ifa, unsigned l=
ong event,
+				struct net *net)
+{
+	const struct net_device *netdev =3D ifa->idev->dev;
+	int addr_type =3D ipv6_addr_type(&ifa->addr);
+	struct mptcp_fm_ns *fm_ns =3D fm_get_ns(net);
+	struct mptcp_addr_event mpevent;
+
+	if (ifa->scope > RT_SCOPE_LINK ||
+	    addr_type =3D=3D IPV6_ADDR_ANY ||
+	    (addr_type & IPV6_ADDR_LOOPBACK) ||
+	    (addr_type & IPV6_ADDR_LINKLOCAL))
+		return;
+
+	spin_lock_bh(&fm_ns->local_lock);
+
+	mpevent.family =3D AF_INET6;
+	mpevent.addr.in6 =3D ifa->addr;
+	mpevent.low_prio =3D (netdev->flags & IFF_MPBACKUP) ? 1 : 0;
+	mpevent.if_idx =3D netdev->ifindex;
+
+	if (event =3D=3D NETDEV_DOWN || !netif_running(netdev) ||
+	    (netdev->flags & IFF_NOMULTIPATH) || !(netdev->flags & IFF_UP))
+		mpevent.code =3D MPTCP_EVENT_DEL;
+	else if (event =3D=3D NETDEV_UP)
+		mpevent.code =3D MPTCP_EVENT_ADD;
+	else if (event =3D=3D NETDEV_CHANGE)
+		mpevent.code =3D MPTCP_EVENT_MOD;
+
+	mptcp_debug("%s created event for %pI6, code %u prio %u\n", __func__,
+		    &ifa->addr, mpevent.code, mpevent.low_prio);
+	add_pm_event(net, &mpevent);
+
+	spin_unlock_bh(&fm_ns->local_lock);
+	return;
+}
+
+/* React on IPv6-addr add/rem-events */
+static int inet6_addr_event(struct notifier_block *this, unsigned long eve=
nt,
+			    void *ptr)
+{
+	struct inet6_ifaddr *ifa6 =3D (struct inet6_ifaddr *)ptr;
+	struct net *net =3D dev_net(ifa6->idev->dev);
+
+	if (!(event =3D=3D NETDEV_UP || event =3D=3D NETDEV_DOWN ||
+	      event =3D=3D NETDEV_CHANGE))
+		return NOTIFY_DONE;
+
+	if (!ipv6_dad_finished(ifa6))
+		dad_setup_timer(ifa6);
+	else
+		addr6_event_handler(ifa6, event, net);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block inet6_addr_notifier =3D {
+		.notifier_call =3D inet6_addr_event,
+};
+
+#endif
+
+/* React on ifup/down-events */
+static int netdev_event(struct notifier_block *this, unsigned long event,
+			void *ptr)
+{
+	const struct net_device *dev =3D netdev_notifier_info_to_dev(ptr);
+	struct in_device *in_dev;
+#if IS_ENABLED(CONFIG_IPV6)
+	struct inet6_dev *in6_dev;
+#endif
+
+	if (!(event =3D=3D NETDEV_UP || event =3D=3D NETDEV_DOWN ||
+	      event =3D=3D NETDEV_CHANGE))
+		return NOTIFY_DONE;
+
+	rcu_read_lock();
+	in_dev =3D __in_dev_get_rtnl(dev);
+
+	if (in_dev) {
+		for_ifa(in_dev) {
+			mptcp_pm_inetaddr_event(NULL, event, ifa);
+		} endfor_ifa(in_dev);
+	}
+
+#if IS_ENABLED(CONFIG_IPV6)
+	in6_dev =3D __in6_dev_get(dev);
+
+	if (in6_dev) {
+		struct inet6_ifaddr *ifa6;
+		list_for_each_entry(ifa6, &in6_dev->addr_list, if_list)
+			inet6_addr_event(NULL, event, ifa6);
+	}
+#endif
+
+	rcu_read_unlock();
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block mptcp_pm_netdev_notifier =3D {
+		.notifier_call =3D netdev_event,
+};
+
+static void full_mesh_add_raddr(struct mptcp_cb *mpcb,
+				const union inet_addr *addr,
+				sa_family_t family, __be16 port, u8 id)
+{
+	if (family =3D=3D AF_INET)
+		mptcp_addv4_raddr(mpcb, &addr->in, port, id);
+	else
+		mptcp_addv6_raddr(mpcb, &addr->in6, port, id);
+}
+
+static void full_mesh_new_session(const struct sock *meta_sk)
+{
+	struct mptcp_loc_addr *mptcp_local;
+	struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
+	struct fullmesh_priv *fmp =3D fullmesh_get_priv(mpcb);
+	const struct mptcp_fm_ns *fm_ns =3D fm_get_ns(sock_net(meta_sk));
+	struct tcp_sock *master_tp =3D tcp_sk(mpcb->master_sk);
+	int i, index, if_idx;
+	union inet_addr saddr, daddr;
+	sa_family_t family;
+	bool meta_v4 =3D meta_sk->sk_family =3D=3D AF_INET;
+
+	/* Init local variables necessary for the rest */
+	if (meta_sk->sk_family =3D=3D AF_INET || mptcp_v6_is_v4_mapped(meta_sk)) {
+		saddr.ip =3D inet_sk(meta_sk)->inet_saddr;
+		daddr.ip =3D inet_sk(meta_sk)->inet_daddr;
+		if_idx =3D mpcb->master_sk->sk_bound_dev_if;
+		family =3D AF_INET;
+#if IS_ENABLED(CONFIG_IPV6)
+	} else {
+		saddr.in6 =3D inet6_sk(meta_sk)->saddr;
+		daddr.in6 =3D meta_sk->sk_v6_daddr;
+		if_idx =3D mpcb->master_sk->sk_bound_dev_if;
+		family =3D AF_INET6;
+#endif
+	}
+
+	rcu_read_lock();
+	mptcp_local =3D rcu_dereference(fm_ns->local);
+
+	index =3D mptcp_find_address(mptcp_local, family, &saddr, if_idx);
+	if (index < 0)
+		goto fallback;
+
+	if (family =3D=3D AF_INET)
+		master_tp->mptcp->low_prio =3D mptcp_local->locaddr4[index].low_prio;
+	else
+		master_tp->mptcp->low_prio =3D mptcp_local->locaddr6[index].low_prio;
+	master_tp->mptcp->send_mp_prio =3D master_tp->mptcp->low_prio;
+
+	full_mesh_add_raddr(mpcb, &daddr, family, 0, 0);
+	mptcp_set_init_addr_bit(mpcb, &daddr, family, index);
+
+	/* Initialize workqueue-struct */
+	INIT_WORK(&fmp->subflow_work, create_subflow_worker);
+	INIT_DELAYED_WORK(&fmp->subflow_retry_work, retry_subflow_worker);
+	fmp->mpcb =3D mpcb;
+
+	if (!meta_v4 && meta_sk->sk_ipv6only)
+		goto skip_ipv4;
+
+	/* Look for the address among the local addresses */
+	mptcp_for_each_bit_set(mptcp_local->loc4_bits, i) {
+		__be32 ifa_address =3D mptcp_local->locaddr4[i].addr.s_addr;
+
+		/* We do not need to announce the initial subflow's address again */
+		if (family =3D=3D AF_INET &&
+		    (!if_idx || mptcp_local->locaddr4[i].if_idx =3D=3D if_idx) &&
+		    saddr.ip =3D=3D ifa_address)
+			continue;
+
+		fmp->add_addr++;
+		mpcb->addr_signal =3D 1;
+	}
+
+skip_ipv4:
+#if IS_ENABLED(CONFIG_IPV6)
+	/* skip IPv6 addresses if meta-socket is IPv4 */
+	if (meta_v4)
+		goto skip_ipv6;
+
+	mptcp_for_each_bit_set(mptcp_local->loc6_bits, i) {
+		const struct in6_addr *ifa6 =3D &mptcp_local->locaddr6[i].addr;
+
+		/* We do not need to announce the initial subflow's address again */
+		if (family =3D=3D AF_INET6 &&
+		    (!if_idx || mptcp_local->locaddr6[i].if_idx =3D=3D if_idx) &&
+		    ipv6_addr_equal(&saddr.in6, ifa6))
+			continue;
+
+		fmp->add_addr++;
+		mpcb->addr_signal =3D 1;
+	}
+
+skip_ipv6:
+#endif
+
+	rcu_read_unlock();
+
+	if (family =3D=3D AF_INET)
+		fmp->announced_addrs_v4 |=3D (1 << index);
+	else
+		fmp->announced_addrs_v6 |=3D (1 << index);
+
+	for (i =3D fmp->add_addr; i && fmp->add_addr; i--)
+		tcp_send_ack(mpcb->master_sk);
+
+	if (master_tp->mptcp->send_mp_prio)
+		tcp_send_ack(mpcb->master_sk);
+
+	return;
+
+fallback:
+	rcu_read_unlock();
+	mptcp_fallback_default(mpcb);
+	return;
+}
+
+static void full_mesh_create_subflows(struct sock *meta_sk)
+{
+	const struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
+	struct fullmesh_priv *fmp =3D fullmesh_get_priv(mpcb);
+
+	if (mpcb->infinite_mapping_snd || mpcb->infinite_mapping_rcv ||
+	    mpcb->send_infinite_mapping ||
+	    mpcb->server_side || sock_flag(meta_sk, SOCK_DEAD))
+		return;
+
+	if (mpcb->master_sk &&
+	    !tcp_sk(mpcb->master_sk)->mptcp->fully_established)
+		return;
+
+	if (!work_pending(&fmp->subflow_work)) {
+		sock_hold(meta_sk);
+		queue_work(mptcp_wq, &fmp->subflow_work);
+	}
+}
+
+/* Called upon release_sock, if the socket was owned by the user during
+ * a path-management event.
+ */
+static void full_mesh_release_sock(struct sock *meta_sk)
+{
+	struct mptcp_loc_addr *mptcp_local;
+	struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
+	struct fullmesh_priv *fmp =3D fullmesh_get_priv(mpcb);
+	const struct mptcp_fm_ns *fm_ns =3D fm_get_ns(sock_net(meta_sk));
+	struct sock *sk, *tmpsk;
+	bool meta_v4 =3D meta_sk->sk_family =3D=3D AF_INET;
+	int i;
+
+	rcu_read_lock();
+	mptcp_local =3D rcu_dereference(fm_ns->local);
+
+	if (!meta_v4 && meta_sk->sk_ipv6only)
+		goto skip_ipv4;
+
+	/* First, detect modifications or additions */
+	mptcp_for_each_bit_set(mptcp_local->loc4_bits, i) {
+		struct in_addr ifa =3D mptcp_local->locaddr4[i].addr;
+		bool found =3D false;
+
+		mptcp_for_each_sk(mpcb, sk) {
+			struct tcp_sock *tp =3D tcp_sk(sk);
+
+			if (sk->sk_family =3D=3D AF_INET6 &&
+			    !mptcp_v6_is_v4_mapped(sk))
+				continue;
+
+			if (inet_sk(sk)->inet_saddr !=3D ifa.s_addr)
+				continue;
+
+			found =3D true;
+
+			if (mptcp_local->locaddr4[i].low_prio !=3D tp->mptcp->low_prio) {
+				tp->mptcp->send_mp_prio =3D 1;
+				tp->mptcp->low_prio =3D mptcp_local->locaddr4[i].low_prio;
+
+				tcp_send_ack(sk);
+			}
+		}
+
+		if (!found) {
+			fmp->add_addr++;
+			mpcb->addr_signal =3D 1;
+
+			sk =3D mptcp_select_ack_sock(meta_sk);
+			if (sk)
+				tcp_send_ack(sk);
+			full_mesh_create_subflows(meta_sk);
+		}
+	}
+
+skip_ipv4:
+#if IS_ENABLED(CONFIG_IPV6)
+	/* skip IPv6 addresses if meta-socket is IPv4 */
+	if (meta_v4)
+		goto removal;
+
+	mptcp_for_each_bit_set(mptcp_local->loc6_bits, i) {
+		struct in6_addr ifa =3D mptcp_local->locaddr6[i].addr;
+		bool found =3D false;
+
+		mptcp_for_each_sk(mpcb, sk) {
+			struct tcp_sock *tp =3D tcp_sk(sk);
+
+			if (sk->sk_family =3D=3D AF_INET ||
+			    mptcp_v6_is_v4_mapped(sk))
+				continue;
+
+			if (!ipv6_addr_equal(&inet6_sk(sk)->saddr, &ifa))
+				continue;
+
+			found =3D true;
+
+			if (mptcp_local->locaddr6[i].low_prio !=3D tp->mptcp->low_prio) {
+				tp->mptcp->send_mp_prio =3D 1;
+				tp->mptcp->low_prio =3D mptcp_local->locaddr6[i].low_prio;
+
+				tcp_send_ack(sk);
+			}
+		}
+
+		if (!found) {
+			fmp->add_addr++;
+			mpcb->addr_signal =3D 1;
+
+			sk =3D mptcp_select_ack_sock(meta_sk);
+			if (sk)
+				tcp_send_ack(sk);
+			full_mesh_create_subflows(meta_sk);
+		}
+	}
+
+removal:
+#endif
+
+	/* Now, detect address-removals */
+	mptcp_for_each_sk_safe(mpcb, sk, tmpsk) {
+		bool shall_remove =3D true;
+
+		if (sk->sk_family =3D=3D AF_INET || mptcp_v6_is_v4_mapped(sk)) {
+			mptcp_for_each_bit_set(mptcp_local->loc4_bits, i) {
+				if (inet_sk(sk)->inet_saddr =3D=3D mptcp_local->locaddr4[i].addr.s_add=
r) {
+					shall_remove =3D false;
+					break;
+				}
+			}
+		} else {
+			mptcp_for_each_bit_set(mptcp_local->loc6_bits, i) {
+				if (ipv6_addr_equal(&inet6_sk(sk)->saddr, &mptcp_local->locaddr6[i].ad=
dr)) {
+					shall_remove =3D false;
+					break;
+				}
+			}
+		}
+
+		if (shall_remove) {
+			/* Reinject, so that pf =3D 1 and so we
+			 * won't select this one as the
+			 * ack-sock.
+			 */
+			mptcp_reinject_data(sk, 0);
+
+			announce_remove_addr(tcp_sk(sk)->mptcp->loc_id,
+					     meta_sk);
+
+			mptcp_sub_force_close(sk);
+		}
+	}
+
+	/* Just call it optimistically. It actually cannot do any harm */
+	update_addr_bitfields(meta_sk, mptcp_local);
+
+	rcu_read_unlock();
+}
+
+static int full_mesh_get_local_id(sa_family_t family, union inet_addr *add=
r,
+				  struct net *net, bool *low_prio)
+{
+	struct mptcp_loc_addr *mptcp_local;
+	const struct mptcp_fm_ns *fm_ns =3D fm_get_ns(net);
+	int index, id =3D -1;
+
+	/* Handle the backup-flows */
+	rcu_read_lock();
+	mptcp_local =3D rcu_dereference(fm_ns->local);
+
+	index =3D mptcp_find_address(mptcp_local, family, addr, 0);
+
+	if (index !=3D -1) {
+		if (family =3D=3D AF_INET) {
+			id =3D mptcp_local->locaddr4[index].loc4_id;
+			*low_prio =3D mptcp_local->locaddr4[index].low_prio;
+		} else {
+			id =3D mptcp_local->locaddr6[index].loc6_id;
+			*low_prio =3D mptcp_local->locaddr6[index].low_prio;
+		}
+	}
+
+
+	rcu_read_unlock();
+
+	return id;
+}
+
+static void full_mesh_addr_signal(struct sock *sk, unsigned *size,
+				  struct tcp_out_options *opts,
+				  struct sk_buff *skb)
+{
+	const struct tcp_sock *tp =3D tcp_sk(sk);
+	struct mptcp_cb *mpcb =3D tp->mpcb;
+	struct sock *meta_sk =3D mpcb->meta_sk;
+	struct fullmesh_priv *fmp =3D fullmesh_get_priv(mpcb);
+	struct mptcp_loc_addr *mptcp_local;
+	struct mptcp_fm_ns *fm_ns =3D fm_get_ns(sock_net(sk));
+	int remove_addr_len;
+	u8 unannouncedv4 =3D 0, unannouncedv6 =3D 0;
+	bool meta_v4 =3D meta_sk->sk_family =3D=3D AF_INET;
+
+	mpcb->addr_signal =3D 0;
+
+	if (likely(!fmp->add_addr))
+		goto remove_addr;
+
+	rcu_read_lock();
+	mptcp_local =3D rcu_dereference(fm_ns->local);
+
+	if (!meta_v4 && meta_sk->sk_ipv6only)
+		goto skip_ipv4;
+
+	/* IPv4 */
+	unannouncedv4 =3D (~fmp->announced_addrs_v4) & mptcp_local->loc4_bits;
+	if (unannouncedv4 &&
+	    ((mpcb->mptcp_ver =3D=3D MPTCP_VERSION_0 &&
+	    MAX_TCP_OPTION_SPACE - *size >=3D MPTCP_SUB_LEN_ADD_ADDR4_ALIGN) ||
+	    (mpcb->mptcp_ver >=3D MPTCP_VERSION_1 &&
+	    MAX_TCP_OPTION_SPACE - *size >=3D MPTCP_SUB_LEN_ADD_ADDR4_ALIGN_VER1)=
)) {
+		int ind =3D mptcp_find_free_index(~unannouncedv4);
+
+		opts->options |=3D OPTION_MPTCP;
+		opts->mptcp_options |=3D OPTION_ADD_ADDR;
+		opts->add_addr4.addr_id =3D mptcp_local->locaddr4[ind].loc4_id;
+		opts->add_addr4.addr =3D mptcp_local->locaddr4[ind].addr;
+		opts->add_addr_v4 =3D 1;
+		if (mpcb->mptcp_ver >=3D MPTCP_VERSION_1) {
+			u8 mptcp_hash_mac[20];
+			u8 no_key[8];
+
+			*(u64 *)no_key =3D 0;
+			mptcp_hmac_sha1((u8 *)&mpcb->mptcp_loc_key,
+					(u8 *)no_key,
+					(u32 *)mptcp_hash_mac, 2,
+					1, (u8 *)&mptcp_local->locaddr4[ind].loc4_id,
+					4, (u8 *)&opts->add_addr4.addr.s_addr);
+			opts->add_addr4.trunc_mac =3D *(u64 *)mptcp_hash_mac;
+		}
+
+		if (skb) {
+			fmp->announced_addrs_v4 |=3D (1 << ind);
+			fmp->add_addr--;
+		}
+
+		if (mpcb->mptcp_ver < MPTCP_VERSION_1)
+			*size +=3D MPTCP_SUB_LEN_ADD_ADDR4_ALIGN;
+		if (mpcb->mptcp_ver >=3D MPTCP_VERSION_1)
+			*size +=3D MPTCP_SUB_LEN_ADD_ADDR4_ALIGN_VER1;
+
+		goto skip_ipv6;
+	}
+
+	if (meta_v4)
+		goto skip_ipv6;
+skip_ipv4:
+	/* IPv6 */
+	unannouncedv6 =3D (~fmp->announced_addrs_v6) & mptcp_local->loc6_bits;
+	if (unannouncedv6 &&
+	    ((mpcb->mptcp_ver =3D=3D MPTCP_VERSION_0 &&
+	    MAX_TCP_OPTION_SPACE - *size >=3D MPTCP_SUB_LEN_ADD_ADDR6_ALIGN) ||
+	    (mpcb->mptcp_ver >=3D MPTCP_VERSION_1 &&
+	    MAX_TCP_OPTION_SPACE - *size >=3D MPTCP_SUB_LEN_ADD_ADDR6_ALIGN_VER1)=
)) {
+		int ind =3D mptcp_find_free_index(~unannouncedv6);
+
+		opts->options |=3D OPTION_MPTCP;
+		opts->mptcp_options |=3D OPTION_ADD_ADDR;
+		opts->add_addr6.addr_id =3D mptcp_local->locaddr6[ind].loc6_id;
+		opts->add_addr6.addr =3D mptcp_local->locaddr6[ind].addr;
+		opts->add_addr_v6 =3D 1;
+		if (mpcb->mptcp_ver >=3D MPTCP_VERSION_1) {
+			u8 mptcp_hash_mac[20];
+			u8 no_key[8];
+
+			*(u64 *)no_key =3D 0;
+			mptcp_hmac_sha1((u8 *)&mpcb->mptcp_loc_key,
+					(u8 *)no_key,
+					(u32 *)mptcp_hash_mac, 2,
+					1, (u8 *)&mptcp_local->locaddr6[ind].loc6_id,
+					16, (u8 *)&opts->add_addr6.addr.s6_addr);
+			opts->add_addr6.trunc_mac =3D *(u64 *)mptcp_hash_mac;
+		}
+
+		if (skb) {
+			fmp->announced_addrs_v6 |=3D (1 << ind);
+			fmp->add_addr--;
+		}
+		if (mpcb->mptcp_ver < MPTCP_VERSION_1)
+			*size +=3D MPTCP_SUB_LEN_ADD_ADDR6_ALIGN;
+		if (mpcb->mptcp_ver >=3D MPTCP_VERSION_1)
+			*size +=3D MPTCP_SUB_LEN_ADD_ADDR6_ALIGN_VER1;
+	}
+
+skip_ipv6:
+	rcu_read_unlock();
+
+	if (!unannouncedv4 && !unannouncedv6 && skb)
+		fmp->add_addr--;
+
+remove_addr:
+	if (likely(!fmp->remove_addrs))
+		goto exit;
+
+	remove_addr_len =3D mptcp_sub_len_remove_addr_align(fmp->remove_addrs);
+	if (MAX_TCP_OPTION_SPACE - *size < remove_addr_len)
+		goto exit;
+
+	opts->options |=3D OPTION_MPTCP;
+	opts->mptcp_options |=3D OPTION_REMOVE_ADDR;
+	opts->remove_addrs =3D fmp->remove_addrs;
+	*size +=3D remove_addr_len;
+	if (skb)
+		fmp->remove_addrs =3D 0;
+
+exit:
+	mpcb->addr_signal =3D !!(fmp->add_addr || fmp->remove_addrs);
+}
+
+static void full_mesh_rem_raddr(struct mptcp_cb *mpcb, u8 rem_id)
+{
+	mptcp_v4_rem_raddress(mpcb, rem_id);
+	mptcp_v6_rem_raddress(mpcb, rem_id);
+}
+
+/* Output /proc/net/mptcp_fullmesh */
+static int mptcp_fm_seq_show(struct seq_file *seq, void *v)
+{
+	const struct net *net =3D seq->private;
+	struct mptcp_loc_addr *mptcp_local;
+	const struct mptcp_fm_ns *fm_ns =3D fm_get_ns(net);
+	int i;
+
+	seq_printf(seq, "Index, Address-ID, Backup, IP-address\n");
+
+	rcu_read_lock_bh();
+	mptcp_local =3D rcu_dereference(fm_ns->local);
+
+	seq_printf(seq, "IPv4, next v4-index: %u\n", mptcp_local->next_v4_index);
+
+	mptcp_for_each_bit_set(mptcp_local->loc4_bits, i) {
+		struct mptcp_loc4 *loc4 =3D &mptcp_local->locaddr4[i];
+
+		seq_printf(seq, "%u, %u, %u, %pI4\n", i, loc4->loc4_id,
+			   loc4->low_prio, &loc4->addr);
+	}
+
+	seq_printf(seq, "IPv6, next v6-index: %u\n", mptcp_local->next_v6_index);
+
+	mptcp_for_each_bit_set(mptcp_local->loc6_bits, i) {
+		struct mptcp_loc6 *loc6 =3D &mptcp_local->locaddr6[i];
+
+		seq_printf(seq, "%u, %u, %u, %pI6\n", i, loc6->loc6_id,
+			   loc6->low_prio, &loc6->addr);
+	}
+	rcu_read_unlock_bh();
+
+	return 0;
+}
+
+static int mptcp_fm_seq_open(struct inode *inode, struct file *file)
+{
+	return single_open_net(inode, file, mptcp_fm_seq_show);
+}
+
+static const struct file_operations mptcp_fm_seq_fops =3D {
+	.owner =3D THIS_MODULE,
+	.open =3D mptcp_fm_seq_open,
+	.read =3D seq_read,
+	.llseek =3D seq_lseek,
+	.release =3D single_release_net,
+};
+
+static int mptcp_fm_init_net(struct net *net)
+{
+	struct mptcp_loc_addr *mptcp_local;
+	struct mptcp_fm_ns *fm_ns;
+	int err =3D 0;
+
+	fm_ns =3D kzalloc(sizeof(*fm_ns), GFP_KERNEL);
+	if (!fm_ns)
+		return -ENOBUFS;
+
+	mptcp_local =3D kzalloc(sizeof(*mptcp_local), GFP_KERNEL);
+	if (!mptcp_local) {
+		err =3D -ENOBUFS;
+		goto err_mptcp_local;
+	}
+
+	if (!proc_create("mptcp_fullmesh", S_IRUGO, net->proc_net,
+			 &mptcp_fm_seq_fops)) {
+		err =3D -ENOMEM;
+		goto err_seq_fops;
+	}
+
+	mptcp_local->next_v4_index =3D 1;
+
+	rcu_assign_pointer(fm_ns->local, mptcp_local);
+	INIT_DELAYED_WORK(&fm_ns->address_worker, mptcp_address_worker);
+	INIT_LIST_HEAD(&fm_ns->events);
+	spin_lock_init(&fm_ns->local_lock);
+	fm_ns->net =3D net;
+	net->mptcp.path_managers[MPTCP_PM_FULLMESH] =3D fm_ns;
+
+	return 0;
+err_seq_fops:
+	kfree(mptcp_local);
+err_mptcp_local:
+	kfree(fm_ns);
+	return err;
+}
+
+static void mptcp_fm_exit_net(struct net *net)
+{
+	struct mptcp_addr_event *eventq, *tmp;
+	struct mptcp_fm_ns *fm_ns;
+	struct mptcp_loc_addr *mptcp_local;
+
+	fm_ns =3D fm_get_ns(net);
+	cancel_delayed_work_sync(&fm_ns->address_worker);
+
+	rcu_read_lock_bh();
+
+	mptcp_local =3D rcu_dereference_bh(fm_ns->local);
+	kfree(mptcp_local);
+
+	spin_lock(&fm_ns->local_lock);
+	list_for_each_entry_safe(eventq, tmp, &fm_ns->events, list) {
+		list_del(&eventq->list);
+		kfree(eventq);
+	}
+	spin_unlock(&fm_ns->local_lock);
+
+	rcu_read_unlock_bh();
+
+	remove_proc_entry("mptcp_fullmesh", net->proc_net);
+
+	kfree(fm_ns);
+}
+
+static struct pernet_operations full_mesh_net_ops =3D {
+	.init =3D mptcp_fm_init_net,
+	.exit =3D mptcp_fm_exit_net,
+};
+
+static struct mptcp_pm_ops full_mesh __read_mostly =3D {
+	.new_session =3D full_mesh_new_session,
+	.release_sock =3D full_mesh_release_sock,
+	.fully_established =3D full_mesh_create_subflows,
+	.new_remote_address =3D full_mesh_create_subflows,
+	.get_local_id =3D full_mesh_get_local_id,
+	.addr_signal =3D full_mesh_addr_signal,
+	.add_raddr =3D full_mesh_add_raddr,
+	.rem_raddr =3D full_mesh_rem_raddr,
+	.name =3D "fullmesh",
+	.owner =3D THIS_MODULE,
+};
+
+/* General initialization of MPTCP_PM */
+static int __init full_mesh_register(void)
+{
+	int ret;
+
+	BUILD_BUG_ON(sizeof(struct fullmesh_priv) > MPTCP_PM_SIZE);
+
+	ret =3D register_pernet_subsys(&full_mesh_net_ops);
+	if (ret)
+		goto out;
+
+	ret =3D register_inetaddr_notifier(&mptcp_pm_inetaddr_notifier);
+	if (ret)
+		goto err_reg_inetaddr;
+	ret =3D register_netdevice_notifier(&mptcp_pm_netdev_notifier);
+	if (ret)
+		goto err_reg_netdev;
+
+#if IS_ENABLED(CONFIG_IPV6)
+	ret =3D register_inet6addr_notifier(&inet6_addr_notifier);
+	if (ret)
+		goto err_reg_inet6addr;
+#endif
+
+	ret =3D mptcp_register_path_manager(&full_mesh);
+	if (ret)
+		goto err_reg_pm;
+
+out:
+	return ret;
+
+
+err_reg_pm:
+#if IS_ENABLED(CONFIG_IPV6)
+	unregister_inet6addr_notifier(&inet6_addr_notifier);
+err_reg_inet6addr:
+#endif
+	unregister_netdevice_notifier(&mptcp_pm_netdev_notifier);
+err_reg_netdev:
+	unregister_inetaddr_notifier(&mptcp_pm_inetaddr_notifier);
+err_reg_inetaddr:
+	unregister_pernet_subsys(&full_mesh_net_ops);
+	goto out;
+}
+
+static void full_mesh_unregister(void)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	unregister_inet6addr_notifier(&inet6_addr_notifier);
+#endif
+	unregister_netdevice_notifier(&mptcp_pm_netdev_notifier);
+	unregister_inetaddr_notifier(&mptcp_pm_inetaddr_notifier);
+	unregister_pernet_subsys(&full_mesh_net_ops);
+	mptcp_unregister_path_manager(&full_mesh);
+}
+
+module_init(full_mesh_register);
+module_exit(full_mesh_unregister);
+
+MODULE_AUTHOR("Christoph Paasch");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Full-Mesh MPTCP");
+MODULE_VERSION("0.88");
diff --git a/net/mptcp/mptcp_input.c b/net/mptcp/mptcp_input.c
new file mode 100644
index 0000000..68c7680
--- /dev/null
+++ b/net/mptcp/mptcp_input.c
@@ -0,0 +1,2970 @@
+/*
+ *	MPTCP implementation - Sending side
+ *
+ *	Initial Design & Implementation:
+ *	S=C3=A9bastien Barr=C3=A9 <sebastien.barre(a)uclouvain.be>
+ *
+ *	Current Maintainer & Author:
+ *	Christoph Paasch <christoph.paasch(a)uclouvain.be>
+ *
+ *	Additional authors:
+ *	Jaakko Korkeaniemi <jaakko.korkeaniemi(a)aalto.fi>
+ *	Gregory Detal <gregory.detal(a)uclouvain.be>
+ *	Fabien Duch=C3=AAne <fabien.duchene(a)uclouvain.be>
+ *	Andreas Seelinger <Andreas.Seelinger(a)rwth-aachen.de>
+ *	Lavkesh Lahngir <lavkesh51(a)gmail.com>
+ *	Andreas Ripke <ripke(a)neclab.eu>
+ *	Vlad Dogaru <vlad.dogaru(a)intel.com>
+ *	Octavian Purdila <octavian.purdila(a)intel.com>
+ *	John Ronan <jronan(a)tssg.org>
+ *	Catalin Nicutar <catalin.nicutar(a)gmail.com>
+ *	Brandon Heller <brandonh(a)stanford.edu>
+ *
+ *
+ *	This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+
+#include <asm/unaligned.h>
+
+#include <net/mptcp.h>
+#include <net/mptcp_v4.h>
+#include <net/mptcp_v6.h>
+
+#include <linux/kconfig.h>
+
+/* is seq1 < seq2 ? */
+static inline bool before64(const u64 seq1, const u64 seq2)
+{
+	return (s64)(seq1 - seq2) < 0;
+}
+
+/* is seq1 > seq2 ? */
+#define after64(seq1, seq2)	before64(seq2, seq1)
+
+static inline void mptcp_become_fully_estab(struct sock *sk)
+{
+	tcp_sk(sk)->mptcp->fully_established =3D 1;
+
+	if (is_master_tp(tcp_sk(sk)) &&
+	    tcp_sk(sk)->mpcb->pm_ops->fully_established)
+		tcp_sk(sk)->mpcb->pm_ops->fully_established(mptcp_meta_sk(sk));
+}
+
+/* Similar to tcp_tso_acked without any memory accounting */
+static inline int mptcp_tso_acked_reinject(const struct sock *meta_sk,
+					   struct sk_buff *skb)
+{
+	const struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
+	u32 packets_acked, len;
+
+	BUG_ON(!after(TCP_SKB_CB(skb)->end_seq, meta_tp->snd_una));
+
+	packets_acked =3D tcp_skb_pcount(skb);
+
+	if (skb_unclone(skb, GFP_ATOMIC))
+		return 0;
+
+	len =3D meta_tp->snd_una - TCP_SKB_CB(skb)->seq;
+	pskb_trim_head(skb, len);
+
+	TCP_SKB_CB(skb)->seq +=3D len;
+	skb->ip_summed =3D CHECKSUM_PARTIAL;
+	skb->truesize	     -=3D len;
+
+	/* Any change of skb->len requires recalculation of tso factor. */
+	if (tcp_skb_pcount(skb) > 1)
+		mptcp_set_skb_tso_segs(meta_sk, skb, tcp_skb_mss(skb));
+	packets_acked -=3D tcp_skb_pcount(skb);
+
+	if (packets_acked) {
+		BUG_ON(tcp_skb_pcount(skb) =3D=3D 0);
+		BUG_ON(!before(TCP_SKB_CB(skb)->seq, TCP_SKB_CB(skb)->end_seq));
+	}
+
+	return packets_acked;
+}
+
+/**
+ * Cleans the meta-socket retransmission queue and the reinject-queue.
+ * @sk must be the metasocket.
+ */
+static void mptcp_clean_rtx_queue(struct sock *meta_sk, u32 prior_snd_una)
+{
+	struct sk_buff *skb, *tmp;
+	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
+	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
+	bool acked =3D false;
+	u32 acked_pcount;
+	struct sk_buff *next;
+
+	for (skb =3D skb_rb_first(&meta_sk->tcp_rtx_queue); skb; skb =3D next) {
+		bool fully_acked =3D true;
+
+		if (before(meta_tp->snd_una, TCP_SKB_CB(skb)->end_seq)) {
+			if (tcp_skb_pcount(skb) =3D=3D 1 ||
+			    !after(meta_tp->snd_una, TCP_SKB_CB(skb)->seq))
+				break;
+
+			acked_pcount =3D tcp_tso_acked(meta_sk, skb);
+			if (!acked_pcount)
+				break;
+
+			fully_acked =3D false;
+		} else {
+			acked_pcount =3D tcp_skb_pcount(skb);
+		}
+
+		acked =3D true;
+		meta_tp->packets_out -=3D acked_pcount;
+		meta_tp->retrans_stamp =3D 0;
+
+		if (!fully_acked)
+			break;
+
+		next =3D skb_rb_next(skb);
+		tcp_rtx_queue_unlink(skb, meta_sk);
+		if (mptcp_is_data_fin(skb)) {
+			struct sock *sk_it;
+
+			/* DATA_FIN has been acknowledged - now we can close
+			 * the subflows
+			 */
+			mptcp_for_each_sk(mpcb, sk_it) {
+				unsigned long delay =3D 0;
+
+				/* If we are the passive closer, don't trigger
+				 * subflow-fin until the subflow has been finned
+				 * by the peer - thus we add a delay.
+				 */
+				if (mpcb->passive_close &&
+				    sk_it->sk_state =3D=3D TCP_ESTABLISHED)
+					delay =3D inet_csk(sk_it)->icsk_rto << 3;
+
+				mptcp_sub_close(sk_it, delay);
+			}
+		}
+		sk_wmem_free_skb(meta_sk, skb);
+	}
+	/* Remove acknowledged data from the reinject queue */
+	skb_queue_walk_safe(&mpcb->reinject_queue, skb, tmp) {
+		if (before(meta_tp->snd_una, TCP_SKB_CB(skb)->end_seq)) {
+			if (tcp_skb_pcount(skb) =3D=3D 1 ||
+			    !after(meta_tp->snd_una, TCP_SKB_CB(skb)->seq))
+				break;
+
+			mptcp_tso_acked_reinject(meta_sk, skb);
+			break;
+		}
+
+		__skb_unlink(skb, &mpcb->reinject_queue);
+		__kfree_skb(skb);
+	}
+
+	if (likely(between(meta_tp->snd_up, prior_snd_una, meta_tp->snd_una)))
+		meta_tp->snd_up =3D meta_tp->snd_una;
+
+	if (acked) {
+		tcp_rearm_rto(meta_sk);
+		/* Normally this is done in tcp_try_undo_loss - but MPTCP
+		 * does not call this function.
+		 */
+		inet_csk(meta_sk)->icsk_retransmits =3D 0;
+	}
+}
+
+/* Inspired by tcp_rcv_state_process */
+static int mptcp_rcv_state_process(struct sock *meta_sk, struct sock *sk,
+				   const struct sk_buff *skb, u32 data_seq,
+				   u16 data_len)
+{
+	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk), *tp =3D tcp_sk(sk);
+	const struct tcphdr *th =3D tcp_hdr(skb);
+
+	/* State-machine handling if FIN has been enqueued and he has
+	 * been acked (snd_una =3D=3D write_seq) - it's important that this
+	 * here is after sk_wmem_free_skb because otherwise
+	 * sk_forward_alloc is wrong upon inet_csk_destroy_sock()
+	 */
+	switch (meta_sk->sk_state) {
+	case TCP_FIN_WAIT1: {
+		struct dst_entry *dst;
+		int tmo;
+
+		if (meta_tp->snd_una !=3D meta_tp->write_seq)
+			break;
+
+		tcp_set_state(meta_sk, TCP_FIN_WAIT2);
+		meta_sk->sk_shutdown |=3D SEND_SHUTDOWN;
+
+		dst =3D __sk_dst_get(sk);
+		if (dst)
+			dst_confirm(dst);
+
+		if (!sock_flag(meta_sk, SOCK_DEAD)) {
+			/* Wake up lingering close() */
+			meta_sk->sk_state_change(meta_sk);
+			break;
+		}
+
+		if (meta_tp->linger2 < 0 ||
+		    (data_len &&
+		     after(data_seq + data_len -
+			   (mptcp_is_data_fin2(skb, tp) ? 1 : 0),
+			   meta_tp->rcv_nxt))) {
+			mptcp_send_active_reset(meta_sk, GFP_ATOMIC);
+			tcp_done(meta_sk);
+			__NET_INC_STATS(sock_net(meta_sk),
+					LINUX_MIB_TCPABORTONDATA);
+			return 1;
+		}
+
+		tmo =3D tcp_fin_time(meta_sk);
+		if (tmo > TCP_TIMEWAIT_LEN) {
+			inet_csk_reset_keepalive_timer(meta_sk,
+						       tmo - TCP_TIMEWAIT_LEN);
+		} else if (mptcp_is_data_fin2(skb, tp) ||
+			   sock_owned_by_user(meta_sk)) {
+			/* Bad case. We could lose such FIN otherwise.
+			 * It is not a big problem, but it looks confusing
+			 * and not so rare event. We still can lose it now,
+			 * if it spins in bh_lock_sock(), but it is really
+			 * marginal case.
+			 */
+			inet_csk_reset_keepalive_timer(meta_sk, tmo);
+		} else {
+			meta_tp->op_ops->time_wait(meta_sk, TCP_FIN_WAIT2, tmo);
+		}
+		break;
+	}
+	case TCP_CLOSING:
+	case TCP_LAST_ACK:
+		if (meta_tp->snd_una =3D=3D meta_tp->write_seq) {
+			tcp_done(meta_sk);
+			return 1;
+		}
+		break;
+	}
+
+	/* step 7: process the segment text */
+	switch (meta_sk->sk_state) {
+	case TCP_FIN_WAIT1:
+	case TCP_FIN_WAIT2:
+		/* RFC 793 says to queue data in these states,
+		 * RFC 1122 says we MUST send a reset.
+		 * BSD 4.4 also does reset.
+		 */
+		if (meta_sk->sk_shutdown & RCV_SHUTDOWN) {
+			if (TCP_SKB_CB(skb)->end_seq !=3D TCP_SKB_CB(skb)->seq &&
+			    after(TCP_SKB_CB(skb)->end_seq - th->fin,
+				  tp->rcv_nxt) &&
+			    !mptcp_is_data_fin2(skb, tp)) {
+				__NET_INC_STATS(sock_net(meta_sk),
+						LINUX_MIB_TCPABORTONDATA);
+				mptcp_send_active_reset(meta_sk, GFP_ATOMIC);
+				tcp_reset(meta_sk);
+				return 1;
+			}
+		}
+		break;
+	}
+
+	return 0;
+}
+
+/**
+ * @return:
+ *  i) 1: Everything's fine.
+ *  ii) -1: A reset has been sent on the subflow - csum-failure
+ *  iii) 0: csum-failure but no reset sent, because it's the last subflow.
+ *	 Last packet should not be destroyed by the caller because it has
+ *	 been done here.
+ */
+static int mptcp_verif_dss_csum(struct sock *sk)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct sk_buff *tmp, *tmp1, *last =3D NULL;
+	__wsum csum_tcp =3D 0; /* cumulative checksum of pld + mptcp-header */
+	int ans =3D 1, overflowed =3D 0, offset =3D 0, dss_csum_added =3D 0;
+	int iter =3D 0;
+
+	skb_queue_walk_safe(&sk->sk_receive_queue, tmp, tmp1) {
+		unsigned int csum_len;
+
+		if (before(tp->mptcp->map_subseq + tp->mptcp->map_data_len,
+			   TCP_SKB_CB(tmp)->end_seq))
+			/* Mapping ends in the middle of the packet -
+			 * csum only these bytes
+			 */
+			csum_len =3D tp->mptcp->map_subseq +
+				   tp->mptcp->map_data_len -
+				   TCP_SKB_CB(tmp)->seq;
+		else
+			csum_len =3D tmp->len;
+
+		offset =3D 0;
+		if (overflowed) {
+			char first_word[4];
+
+			first_word[0] =3D 0;
+			first_word[1] =3D 0;
+			first_word[2] =3D 0;
+			first_word[3] =3D *(tmp->data);
+			csum_tcp =3D csum_partial(first_word, 4, csum_tcp);
+			offset =3D 1;
+			csum_len--;
+			overflowed =3D 0;
+		}
+
+		csum_tcp =3D skb_checksum(tmp, offset, csum_len, csum_tcp);
+
+		/* Was it on an odd-length? Then we have to merge the next byte
+		 * correctly (see above)
+		 */
+		if (csum_len !=3D (csum_len & (~1)))
+			overflowed =3D 1;
+
+		if (mptcp_is_data_seq(tmp) && !dss_csum_added) {
+			__be32 data_seq =3D htonl((u32)(tp->mptcp->map_data_seq >> 32));
+
+			/* If a 64-bit dss is present, we increase the offset
+			 * by 4 bytes, as the high-order 64-bits will be added
+			 * in the final csum_partial-call.
+			 */
+			u32 offset =3D skb_transport_offset(tmp) +
+					tp->mptcp->rx_opt.mptcp_dss_off;
+			if (TCP_SKB_CB(tmp)->mptcp_flags & MPTCPHDR_SEQ64_SET)
+				offset +=3D 4;
+
+			csum_tcp =3D skb_checksum(tmp, offset,
+						MPTCP_SUB_LEN_SEQ_CSUM,
+						csum_tcp);
+
+			csum_tcp =3D csum_partial(&data_seq,
+						sizeof(data_seq), csum_tcp);
+
+			dss_csum_added =3D 1; /* Just do it once */
+		}
+		last =3D tmp;
+		iter++;
+
+		if (!skb_queue_is_last(&sk->sk_receive_queue, tmp) &&
+		    !before(TCP_SKB_CB(tmp1)->seq,
+			    tp->mptcp->map_subseq + tp->mptcp->map_data_len))
+			break;
+	}
+
+	/* Now, checksum must be 0 */
+	if (unlikely(csum_fold(csum_tcp))) {
+		pr_err("%s csum is wrong: %#x data_seq %u dss_csum_added %d overflowed %=
d iterations %d\n",
+		       __func__, csum_fold(csum_tcp), TCP_SKB_CB(last)->seq,
+		       dss_csum_added, overflowed, iter);
+
+		MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_CSUMFAIL);
+		tp->mptcp->send_mp_fail =3D 1;
+
+		/* map_data_seq is the data-seq number of the
+		 * mapping we are currently checking
+		 */
+		tp->mpcb->csum_cutoff_seq =3D tp->mptcp->map_data_seq;
+
+		if (tp->mpcb->cnt_subflows > 1) {
+			mptcp_send_reset(sk);
+			ans =3D -1;
+		} else {
+			tp->mpcb->send_infinite_mapping =3D 1;
+
+			/* Need to purge the rcv-queue as it's no more valid */
+			while ((tmp =3D __skb_dequeue(&sk->sk_receive_queue)) !=3D NULL) {
+				tp->copied_seq =3D TCP_SKB_CB(tmp)->end_seq;
+				kfree_skb(tmp);
+			}
+
+			ans =3D 0;
+		}
+	}
+
+	return ans;
+}
+
+static inline void mptcp_prepare_skb(struct sk_buff *skb,
+				     const struct sock *sk)
+{
+	const struct tcp_sock *tp =3D tcp_sk(sk);
+	struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
+	u32 inc =3D 0, end_seq =3D tcb->end_seq;
+
+	if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)
+		end_seq--;
+	/* If skb is the end of this mapping (end is always at mapping-boundary
+	 * thanks to the splitting/trimming), then we need to increase
+	 * data-end-seq by 1 if this here is a data-fin.
+	 *
+	 * We need to do -1 because end_seq includes the subflow-FIN.
+	 */
+	if (tp->mptcp->map_data_fin &&
+	    end_seq =3D=3D tp->mptcp->map_subseq + tp->mptcp->map_data_len) {
+		inc =3D 1;
+
+		/* We manually set the fin-flag if it is a data-fin. For easy
+		 * processing in tcp_recvmsg.
+		 */
+		TCP_SKB_CB(skb)->tcp_flags |=3D TCPHDR_FIN;
+	} else {
+		/* We may have a subflow-fin with data but without data-fin */
+		TCP_SKB_CB(skb)->tcp_flags &=3D ~TCPHDR_FIN;
+	}
+
+	/* Adapt data-seq's to the packet itself. We kinda transform the
+	 * dss-mapping to a per-packet granularity. This is necessary to
+	 * correctly handle overlapping mappings coming from different
+	 * subflows. Otherwise it would be a complete mess.
+	 */
+	tcb->seq =3D ((u32)tp->mptcp->map_data_seq) + tcb->seq -
+			 tp->mptcp->map_subseq;
+	tcb->end_seq =3D tcb->seq + skb->len + inc;
+}
+
+static inline void mptcp_reset_mapping(struct tcp_sock *tp, u32 old_copied=
_seq)
+{
+	tp->mptcp->map_data_len =3D 0;
+	tp->mptcp->map_data_seq =3D 0;
+	tp->mptcp->map_subseq =3D 0;
+	tp->mptcp->map_data_fin =3D 0;
+	tp->mptcp->mapping_present =3D 0;
+
+	/* In infinite mapping receiver mode, we have to advance the implied
+	 * data-sequence number when we progress the subflow's data.
+	 */
+	if (tp->mpcb->infinite_mapping_rcv)
+		tp->mpcb->infinite_rcv_seq +=3D (tp->copied_seq - old_copied_seq);
+}
+
+/* The DSS-mapping received on the sk only covers the second half of the s=
kb
+ * (cut at seq). We trim the head from the skb.
+ * Data will be freed upon kfree().
+ *
+ * Inspired by tcp_trim_head().
+ */
+static void mptcp_skb_trim_head(struct sk_buff *skb, struct sock *sk, u32 =
seq)
+{
+	int len =3D seq - TCP_SKB_CB(skb)->seq;
+	u32 new_seq =3D TCP_SKB_CB(skb)->seq + len;
+
+	pskb_trim_head(skb, len);
+
+	TCP_SKB_CB(skb)->seq =3D new_seq;
+
+	skb->truesize -=3D len;
+	atomic_sub(len, &sk->sk_rmem_alloc);
+	sk_mem_uncharge(sk, len);
+}
+
+/* The DSS-mapping received on the sk only covers the first half of the skb
+ * (cut at seq). We create a second skb (@return), and queue it in the rcv=
-queue
+ * as further packets may resolve the mapping of the second half of data.
+ *
+ * Inspired by tcp_fragment().
+ */
+static int mptcp_skb_split_tail(struct sk_buff *skb, struct sock *sk, u32 =
seq)
+{
+	struct sk_buff *buff;
+	int nsize;
+	int nlen, len;
+	u8 flags;
+
+	len =3D seq - TCP_SKB_CB(skb)->seq;
+	nsize =3D skb_headlen(skb) - len + tcp_sk(sk)->tcp_header_len;
+	if (nsize < 0)
+		nsize =3D 0;
+
+	/* Get a new skb... force flag on. */
+	buff =3D alloc_skb(nsize, GFP_ATOMIC);
+	if (!buff)
+		return -ENOMEM;
+
+	skb_reserve(buff, tcp_sk(sk)->tcp_header_len);
+	skb_reset_transport_header(buff);
+
+	flags =3D TCP_SKB_CB(skb)->tcp_flags;
+	TCP_SKB_CB(skb)->tcp_flags =3D flags & ~(TCPHDR_FIN);
+	TCP_SKB_CB(buff)->tcp_flags =3D flags;
+
+	/* We absolutly need to call skb_set_owner_r before refreshing the
+	 * truesize of buff, otherwise the moved data will account twice.
+	 */
+	skb_set_owner_r(buff, sk);
+	nlen =3D skb->len - len - nsize;
+	buff->truesize +=3D nlen;
+	skb->truesize -=3D nlen;
+
+	/* Correct the sequence numbers. */
+	TCP_SKB_CB(buff)->seq =3D TCP_SKB_CB(skb)->seq + len;
+	TCP_SKB_CB(buff)->end_seq =3D TCP_SKB_CB(skb)->end_seq;
+	TCP_SKB_CB(skb)->end_seq =3D TCP_SKB_CB(buff)->seq;
+
+	skb_split(skb, buff, len);
+
+	__skb_queue_after(&sk->sk_receive_queue, skb, buff);
+
+	return 0;
+}
+
+/* @return: 0  everything is fine. Just continue processing
+ *	    1  subflow is broken stop everything
+ *	    -1 this packet was broken - continue with the next one.
+ */
+static int mptcp_prevalidate_skb(struct sock *sk, struct sk_buff *skb)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct mptcp_cb *mpcb =3D tp->mpcb;
+
+	/* If we are in infinite mode, the subflow-fin is in fact a data-fin. */
+	if (!skb->len && (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN) &&
+	    !mptcp_is_data_fin(skb) && !mpcb->infinite_mapping_rcv) {
+		/* Remove a pure subflow-fin from the queue and increase
+		 * copied_seq.
+		 */
+		tp->copied_seq =3D TCP_SKB_CB(skb)->end_seq;
+		__skb_unlink(skb, &sk->sk_receive_queue);
+		__kfree_skb(skb);
+		return -1;
+	}
+
+	/* If we are not yet fully established and do not know the mapping for
+	 * this segment, this path has to fallback to infinite or be torn down.
+	 */
+	if (!tp->mptcp->fully_established && !mptcp_is_data_seq(skb) &&
+	    !tp->mptcp->mapping_present && !mpcb->infinite_mapping_rcv) {
+		pr_err("%s %#x will fallback - pi %d from %pS, seq %u\n",
+		       __func__, mpcb->mptcp_loc_token,
+		       tp->mptcp->path_index, __builtin_return_address(0),
+		       TCP_SKB_CB(skb)->seq);
+
+		if (!is_master_tp(tp)) {
+			MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_FBDATASUB);
+			mptcp_send_reset(sk);
+			return 1;
+		}
+
+		MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_FBDATAINIT);
+
+		mpcb->infinite_mapping_snd =3D 1;
+		mpcb->infinite_mapping_rcv =3D 1;
+		mpcb->infinite_rcv_seq =3D mptcp_get_rcv_nxt_64(mptcp_meta_tp(tp));
+
+		mptcp_sub_force_close_all(mpcb, sk);
+
+		/* We do a seamless fallback and
+		 * should not send a inf.mapping.
+		 */
+		mpcb->send_infinite_mapping =3D 0;
+		tp->mptcp->fully_established =3D 1;
+	}
+
+	/* Receiver-side becomes fully established when a whole rcv-window has
+	 * been received without the need to fallback due to the previous
+	 * condition.
+	 */
+	if (!tp->mptcp->fully_established) {
+		tp->mptcp->init_rcv_wnd -=3D skb->len;
+		if (tp->mptcp->init_rcv_wnd < 0)
+			mptcp_become_fully_estab(sk);
+	}
+
+	return 0;
+}
+
+/* @return: 0  everything is fine. Just continue processing
+ *	    1  subflow is broken stop everything
+ *	    -1 this packet was broken - continue with the next one.
+ */
+static int mptcp_detect_mapping(struct sock *sk, struct sk_buff *skb)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk), *meta_tp =3D mptcp_meta_tp(tp);
+	struct mptcp_cb *mpcb =3D tp->mpcb;
+	struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
+	u32 *ptr;
+	u32 data_seq, sub_seq, data_len, tcp_end_seq;
+	bool set_infinite_rcv =3D false;
+
+	/* If we are in infinite-mapping-mode, the subflow is guaranteed to be
+	 * in-order at the data-level. Thus data-seq-numbers can be inferred
+	 * from what is expected at the data-level.
+	 */
+	if (mpcb->infinite_mapping_rcv) {
+		/* copied_seq may be bigger than tcb->seq (e.g., when the peer
+		 * retransmits data that actually has already been acknowledged
+		 * with newer data, if he did not receive our acks). Thus, we
+		 * need to account for this overlap as well.
+		 */
+		tp->mptcp->map_data_seq =3D mpcb->infinite_rcv_seq -
+					  (tp->copied_seq - tcb->seq);
+		tp->mptcp->map_subseq =3D tcb->seq;
+		tp->mptcp->map_data_len =3D skb->len;
+		tp->mptcp->map_data_fin =3D
+				!!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN);
+		tp->mptcp->mapping_present =3D 1;
+		return 0;
+	}
+
+	/* No mapping here? Exit -
+	 * it is either already set or still on its way
+	 */
+	if (!mptcp_is_data_seq(skb)) {
+		/* Too many packets without a mapping -
+		 * this subflow is broken
+		 */
+		if (!tp->mptcp->mapping_present &&
+		    tp->rcv_nxt - tp->copied_seq > 65536) {
+			MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_NODSSWINDOW);
+			mptcp_send_reset(sk);
+			return 1;
+		}
+
+		return 0;
+	}
+
+	ptr =3D mptcp_skb_set_data_seq(tp, skb, &data_seq, mpcb);
+	ptr++;
+	sub_seq =3D get_unaligned_be32(ptr) + tp->mptcp->rcv_isn;
+	ptr++;
+	data_len =3D get_unaligned_be16(ptr);
+
+	/* If it's an empty skb with DATA_FIN, sub_seq must get fixed.
+	 * The draft sets it to 0, but we really would like to have the
+	 * real value, to have an easy handling afterwards here in this
+	 * function.
+	 */
+	if (mptcp_is_data_fin(skb) && skb->len =3D=3D 0)
+		sub_seq =3D TCP_SKB_CB(skb)->seq;
+
+	/* If there is already a mapping - we check if it maps with the current
+	 * one. If not - we reset.
+	 * We can get few different mappings
+	 * 1. Mapping that is exactly same as the existing mapping
+	 * 2. (Sub) Mapping that fits within the current mapping and does not
+	 *    violate it.
+	 * 3. (Extended) mapping that covers the current
+	 *    mapping but extends it. We currently do not support that.
+	 * The code below does not validate sub_seq numbers -- It should.
+	 */
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
+	}
+
+	/* If the previous check was good,
+	 * the current mapping is valid and we exit.
+	 */
+	if (tp->mptcp->mapping_present)
+		return 0;
+
+	/* Mapping not yet set on this subflow - we set it here! */
+
+	if (!data_len) {
+		mpcb->infinite_mapping_rcv =3D 1;
+		mpcb->send_infinite_mapping =3D 1;
+		tp->mptcp->fully_established =3D 1;
+		/* We need to repeat mp_fail's until the sender felt
+		 * back to infinite-mapping - here we stop repeating it.
+		 */
+		tp->mptcp->send_mp_fail =3D 0;
+
+		/* We have to fixup data_len - it must be same as skb->len */
+		data_len =3D skb->len + (mptcp_is_data_fin(skb) ? 1 : 0);
+		sub_seq =3D tcb->seq;
+
+		mptcp_sub_force_close_all(mpcb, sk);
+
+		/* data_seq and so on are set correctly */
+
+		/* At this point, the meta-ofo-queue has to be emptied,
+		 * as the following data is guaranteed to be in-order at
+		 * the data and subflow-level
+		 */
+		mptcp_purge_ofo_queue(meta_tp);
+
+		set_infinite_rcv =3D true;
+		MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_INFINITEMAPRX);
+	}
+
+	/* We are sending mp-fail's and thus are in fallback mode.
+	 * Ignore packets which do not announce the fallback and still
+	 * want to provide a mapping.
+	 */
+	if (tp->mptcp->send_mp_fail) {
+		tp->copied_seq =3D TCP_SKB_CB(skb)->end_seq;
+		__skb_unlink(skb, &sk->sk_receive_queue);
+		__kfree_skb(skb);
+		return -1;
+	}
+
+	/* Subflow-sequences of packet must be
+	 * (at least partially) be part of the DSS-mapping's
+	 * subflow-sequence-space.
+	 *
+	 * Basically the mapping is not valid, if either of the
+	 * following conditions is true:
+	 *
+	 * 1. It's not a data_fin and
+	 *    MPTCP-sub_seq >=3D TCP-end_seq
+	 *
+	 * 2. It's a data_fin and TCP-end_seq > TCP-seq and
+	 *    MPTCP-sub_seq >=3D TCP-end_seq
+	 *
+	 * The previous two can be merged into:
+	 *    TCP-end_seq > TCP-seq and MPTCP-sub_seq >=3D TCP-end_seq
+	 *    Because if it's not a data-fin, TCP-end_seq > TCP-seq
+	 *
+	 * 3. It's a data_fin and skb->len =3D=3D 0 and
+	 *    MPTCP-sub_seq > TCP-end_seq
+	 *
+	 * 4. It's not a data_fin and TCP-end_seq > TCP-seq and
+	 *    MPTCP-sub_seq + MPTCP-data_len <=3D TCP-seq
+	 */
+
+	/* subflow-fin is not part of the mapping - ignore it here ! */
+	tcp_end_seq =3D tcb->end_seq;
+	if (tcb->tcp_flags & TCPHDR_FIN)
+		tcp_end_seq--;
+	if ((!before(sub_seq, tcb->end_seq) && after(tcp_end_seq, tcb->seq)) ||
+	    (mptcp_is_data_fin(skb) && skb->len =3D=3D 0 &&
+	    after(sub_seq, tcb->end_seq)) ||
+	    (!after(sub_seq + data_len, tcb->seq) &&
+	    after(tcp_end_seq, tcb->seq))) {
+		/* Subflow-sequences of packet is different from what is in the
+		 * packet's dss-mapping. The peer is misbehaving - reset
+		 */
+		pr_err("%s Packet's mapping does not map to the DSS sub_seq %u end_seq %=
u, tcp_end_seq %u seq %u dfin %u len %u data_len %u copied_seq %u\n",
+			__func__, sub_seq, tcb->end_seq, tcp_end_seq, tcb->seq,
+			mptcp_is_data_fin(skb), skb->len, data_len,
+			tp->copied_seq);
+		MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_DSSTCPMISMATCH);
+		mptcp_send_reset(sk);
+		return 1;
+	}
+
+	/* Does the DSS had 64-bit seqnum's ? */
+	if (!(TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_SEQ64_SET)) {
+		/* Wrapped around? */
+		if (unlikely(after(data_seq, meta_tp->rcv_nxt) &&
+				   data_seq < meta_tp->rcv_nxt)) {
+			tp->mptcp->map_data_seq =3D
+				mptcp_get_data_seq_64(mpcb,
+						      !mpcb->rcv_hiseq_index,
+						      data_seq);
+		} else {
+			/* Else, access the default high-order bits */
+			tp->mptcp->map_data_seq =3D mptcp_get_data_seq_64(mpcb,
+						  mpcb->rcv_hiseq_index,
+						  data_seq);
+		}
+	} else {
+		tp->mptcp->map_data_seq =3D mptcp_get_data_seq_64(mpcb,
+		    (TCP_SKB_CB(skb)->mptcp_flags &
+		    MPTCPHDR_SEQ64_INDEX) ? 1 : 0, data_seq);
+
+		if (unlikely(TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_SEQ64_OFO)) {
+			/* We make sure that the data_seq is invalid.
+			 * It will be dropped later.
+			 */
+			tp->mptcp->map_data_seq +=3D 0xFFFFFFFF;
+			tp->mptcp->map_data_seq +=3D 0xFFFFFFFF;
+		}
+	}
+
+	if (set_infinite_rcv)
+		mpcb->infinite_rcv_seq =3D tp->mptcp->map_data_seq;
+
+	tp->mptcp->map_data_len =3D data_len;
+	tp->mptcp->map_subseq =3D sub_seq;
+	tp->mptcp->map_data_fin =3D mptcp_is_data_fin(skb) ? 1 : 0;
+	tp->mptcp->mapping_present =3D 1;
+
+	return 0;
+}
+
+/* Similar to tcp_sequence(...) */
+static inline bool mptcp_sequence(const struct tcp_sock *meta_tp,
+				 u64 data_seq, u64 end_data_seq)
+{
+	const struct mptcp_cb *mpcb =3D meta_tp->mpcb;
+	u64 rcv_wup64;
+
+	/* Wrap-around? */
+	if (meta_tp->rcv_wup > meta_tp->rcv_nxt) {
+		rcv_wup64 =3D ((u64)(mpcb->rcv_high_order[mpcb->rcv_hiseq_index] - 1) <<=
 32) |
+				meta_tp->rcv_wup;
+	} else {
+		rcv_wup64 =3D mptcp_get_data_seq_64(mpcb, mpcb->rcv_hiseq_index,
+						  meta_tp->rcv_wup);
+	}
+
+	return	!before64(end_data_seq, rcv_wup64) &&
+		!after64(data_seq, mptcp_get_rcv_nxt_64(meta_tp) +
+			 tcp_receive_window(meta_tp));
+}
+
+/* @return: 0  everything is fine. Just continue processing
+ *	    -1 this packet was broken - continue with the next one.
+ */
+static int mptcp_validate_mapping(struct sock *sk, struct sk_buff *skb)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct sk_buff *tmp, *tmp1;
+	u32 tcp_end_seq;
+
+	if (!tp->mptcp->mapping_present)
+		return 0;
+
+	/* either, the new skb gave us the mapping and the first segment
+	 * in the sub-rcv-queue has to be trimmed ...
+	 */
+	tmp =3D skb_peek(&sk->sk_receive_queue);
+	if (before(TCP_SKB_CB(tmp)->seq, tp->mptcp->map_subseq) &&
+	    after(TCP_SKB_CB(tmp)->end_seq, tp->mptcp->map_subseq)) {
+		MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_DSSTRIMHEAD);
+		mptcp_skb_trim_head(tmp, sk, tp->mptcp->map_subseq);
+	}
+
+	/* ... or the new skb (tail) has to be split at the end. */
+	tcp_end_seq =3D TCP_SKB_CB(skb)->end_seq;
+	if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)
+		tcp_end_seq--;
+	if (after(tcp_end_seq, tp->mptcp->map_subseq + tp->mptcp->map_data_len)) {
+		u32 seq =3D tp->mptcp->map_subseq + tp->mptcp->map_data_len;
+
+		MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_DSSSPLITTAIL);
+		if (mptcp_skb_split_tail(skb, sk, seq)) {
+			/* Allocation failed */
+			/* TODO : maybe handle this here better.
+			 * We now just force meta-retransmission.
+			 */
+			tp->copied_seq =3D TCP_SKB_CB(skb)->end_seq;
+			__skb_unlink(skb, &sk->sk_receive_queue);
+			__kfree_skb(skb);
+			return -1;
+		}
+	}
+
+	/* Now, remove old sk_buff's from the receive-queue.
+	 * This may happen if the mapping has been lost for these segments and
+	 * the next mapping has already been received.
+	 */
+	if (before(TCP_SKB_CB(skb_peek(&sk->sk_receive_queue))->seq,
+				       tp->mptcp->map_subseq)) {
+		skb_queue_walk_safe(&sk->sk_receive_queue, tmp1, tmp) {
+			if (!before(TCP_SKB_CB(tmp1)->seq,
+				    tp->mptcp->map_subseq))
+				break;
+
+			tp->copied_seq =3D TCP_SKB_CB(tmp1)->end_seq;
+			__skb_unlink(tmp1, &sk->sk_receive_queue);
+
+			MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_PURGEOLD);
+			/* Impossible that we could free skb here, because his
+			 * mapping is known to be valid from previous checks
+			 */
+			__kfree_skb(tmp1);
+		}
+	}
+
+	return 0;
+}
+
+/* @return: 0  everything is fine. Just continue processing
+ *	    1  subflow is broken stop everything
+ *	    -1 this mapping has been put in the meta-receive-queue
+ *	    -2 this mapping has been eaten by the application
+ */
+static int mptcp_queue_skb(struct sock *sk)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk), *meta_tp =3D mptcp_meta_tp(tp);
+	struct sock *meta_sk =3D mptcp_meta_sk(sk);
+	struct mptcp_cb *mpcb =3D tp->mpcb;
+	struct sk_buff *tmp, *tmp1;
+	u64 rcv_nxt64 =3D mptcp_get_rcv_nxt_64(meta_tp);
+	u32 old_copied_seq =3D tp->copied_seq;
+	bool data_queued =3D false;
+
+	/* Have we not yet received the full mapping? */
+	if (!tp->mptcp->mapping_present ||
+	    before(tp->rcv_nxt, tp->mptcp->map_subseq +
+		   tp->mptcp->map_data_len))
+		return 0;
+
+	/* Is this an overlapping mapping? rcv_nxt >=3D end_data_seq
+	 * OR
+	 * This mapping is out of window
+	 */
+	if (!before64(rcv_nxt64, tp->mptcp->map_data_seq + tp->mptcp->map_data_le=
n + tp->mptcp->map_data_fin) ||
+	    !mptcp_sequence(meta_tp, tp->mptcp->map_data_seq,
+			    tp->mptcp->map_data_seq + tp->mptcp->map_data_len + tp->mptcp->map_=
data_fin)) {
+		skb_queue_walk_safe(&sk->sk_receive_queue, tmp1, tmp) {
+			__skb_unlink(tmp1, &sk->sk_receive_queue);
+			tp->copied_seq =3D TCP_SKB_CB(tmp1)->end_seq;
+			__kfree_skb(tmp1);
+
+			if (!skb_queue_empty(&sk->sk_receive_queue) &&
+			    !before(TCP_SKB_CB(tmp)->seq,
+				    tp->mptcp->map_subseq + tp->mptcp->map_data_len))
+				break;
+		}
+
+		mptcp_reset_mapping(tp, old_copied_seq);
+
+		return -1;
+	}
+
+	/* Record it, because we want to send our data_fin on the same path */
+	if (tp->mptcp->map_data_fin) {
+		mpcb->dfin_path_index =3D tp->mptcp->path_index;
+		mpcb->dfin_combined =3D !!(sk->sk_shutdown & RCV_SHUTDOWN);
+	}
+
+	/* Verify the checksum */
+	if (mpcb->dss_csum && !mpcb->infinite_mapping_rcv) {
+		int ret =3D mptcp_verif_dss_csum(sk);
+
+		if (ret <=3D 0) {
+			mptcp_reset_mapping(tp, old_copied_seq);
+			return 1;
+		}
+	}
+
+	if (before64(rcv_nxt64, tp->mptcp->map_data_seq)) {
+		/* Seg's have to go to the meta-ofo-queue */
+		skb_queue_walk_safe(&sk->sk_receive_queue, tmp1, tmp) {
+			tp->copied_seq =3D TCP_SKB_CB(tmp1)->end_seq;
+			mptcp_prepare_skb(tmp1, sk);
+			__skb_unlink(tmp1, &sk->sk_receive_queue);
+			/* MUST be done here, because fragstolen may be true later.
+			 * Then, kfree_skb_partial will not account the memory.
+			 */
+			skb_orphan(tmp1);
+
+			if (!mpcb->in_time_wait) /* In time-wait, do not receive data */
+				mptcp_add_meta_ofo_queue(meta_sk, tmp1);
+			else
+				__kfree_skb(tmp1);
+
+			if (!skb_queue_empty(&sk->sk_receive_queue) &&
+			    !before(TCP_SKB_CB(tmp)->seq,
+				    tp->mptcp->map_subseq + tp->mptcp->map_data_len))
+				break;
+		}
+
+		/* Quick ACK if more 3/4 of the receive window is filled */
+		if (after64(tp->mptcp->map_data_seq,
+			    rcv_nxt64 + 3 * (tcp_receive_window(meta_tp) >> 2)))
+			tcp_enter_quickack_mode(sk);
+
+	} else {
+		/* Ready for the meta-rcv-queue */
+		skb_queue_walk_safe(&sk->sk_receive_queue, tmp1, tmp) {
+			int eaten =3D 0;
+			bool fragstolen =3D false;
+			u32 old_rcv_nxt =3D meta_tp->rcv_nxt;
+
+			tp->copied_seq =3D TCP_SKB_CB(tmp1)->end_seq;
+			mptcp_prepare_skb(tmp1, sk);
+			__skb_unlink(tmp1, &sk->sk_receive_queue);
+			/* MUST be done here, because fragstolen may be true.
+			 * Then, kfree_skb_partial will not account the memory.
+			 */
+			skb_orphan(tmp1);
+
+			/* This segment has already been received */
+			if (!after(TCP_SKB_CB(tmp1)->end_seq, meta_tp->rcv_nxt)) {
+				__kfree_skb(tmp1);
+				goto next;
+			}
+
+			/* In time-wait, do not receive data */
+			if (mpcb->in_time_wait)
+				eaten =3D 1;
+
+			if (!eaten) {
+				eaten =3D tcp_queue_rcv(meta_sk, tmp1, 0,
+						      &fragstolen);
+			}
+
+			meta_tp->rcv_nxt =3D TCP_SKB_CB(tmp1)->end_seq;
+			mptcp_check_rcvseq_wrap(meta_tp, old_rcv_nxt);
+
+			if (TCP_SKB_CB(tmp1)->tcp_flags & TCPHDR_FIN)
+				mptcp_fin(meta_sk);
+
+			/* Check if this fills a gap in the ofo queue */
+			if (!RB_EMPTY_ROOT(&meta_tp->out_of_order_queue))
+				mptcp_ofo_queue(meta_sk);
+
+			if (eaten)
+				kfree_skb_partial(tmp1, fragstolen);
+
+			data_queued =3D true;
+next:
+			if (!skb_queue_empty(&sk->sk_receive_queue) &&
+			    !before(TCP_SKB_CB(tmp)->seq,
+				    tp->mptcp->map_subseq + tp->mptcp->map_data_len))
+				break;
+		}
+	}
+
+	inet_csk(meta_sk)->icsk_ack.lrcvtime =3D tcp_jiffies32;
+	mptcp_reset_mapping(tp, old_copied_seq);
+
+	return data_queued ? -1 : -2;
+}
+
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
+void mptcp_data_ready(struct sock *sk)
+{
+	struct sock *meta_sk =3D mptcp_meta_sk(sk);
+	struct sk_buff *skb, *tmp;
+	int queued =3D 0;
+
+	/* restart before the check, because mptcp_fin might have changed the
+	 * state.
+	 */
+restart:
+	/* If the meta cannot receive data, there is no point in pushing data.
+	 * If we are in time-wait, we may still be waiting for the final FIN.
+	 * So, we should proceed with the processing.
+	 */
+	if (!mptcp_sk_can_recv(meta_sk) && !tcp_sk(sk)->mpcb->in_time_wait) {
+		skb_queue_purge(&sk->sk_receive_queue);
+		tcp_sk(sk)->copied_seq =3D tcp_sk(sk)->rcv_nxt;
+		goto exit;
+	}
+
+	/* Iterate over all segments, detect their mapping (if we don't have
+	 * one yet), validate them and push everything one level higher.
+	 */
+	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
+		int ret;
+
+		skb =3D mptcp_process_options_ack(sk, skb);
+		if (skb =3D=3D NULL)
+			continue;
+		/* Pre-validation - e.g., early fallback */
+		ret =3D mptcp_prevalidate_skb(sk, skb);
+		if (ret < 0)
+			goto restart;
+		else if (ret > 0)
+			break;
+
+		/* Set the current mapping */
+		ret =3D mptcp_detect_mapping(sk, skb);
+		if (ret < 0)
+			goto restart;
+		else if (ret > 0)
+			break;
+
+		/* Validation */
+		if (mptcp_validate_mapping(sk, skb) < 0)
+			goto restart;
+
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
+		/* Push a level higher */
+		ret =3D mptcp_queue_skb(sk);
+		if (ret < 0) {
+			if (ret =3D=3D -1)
+				queued =3D ret;
+			goto restart;
+		} else if (ret =3D=3D 0) {
+			continue;
+		} else { /* ret =3D=3D 1 */
+			break;
+		}
+	}
+
+exit:
+	if (tcp_sk(sk)->close_it && sk->sk_state =3D=3D TCP_FIN_WAIT2) {
+		tcp_send_ack(sk);
+		tcp_sk(sk)->op_ops->time_wait(sk, TCP_TIME_WAIT, 0);
+	}
+
+	if (queued =3D=3D -1 && !sock_flag(meta_sk, SOCK_DEAD))
+		meta_sk->sk_data_ready(meta_sk);
+}
+
+struct mp_join *mptcp_find_join(const struct sk_buff *skb)
+{
+	const struct tcphdr *th =3D tcp_hdr(skb);
+	unsigned char *ptr;
+	int length =3D (th->doff * 4) - sizeof(struct tcphdr);
+
+	/* Jump through the options to check whether JOIN is there */
+	ptr =3D (unsigned char *)(th + 1);
+	while (length > 0) {
+		int opcode =3D *ptr++;
+		int opsize;
+
+		switch (opcode) {
+		case TCPOPT_EOL:
+			return NULL;
+		case TCPOPT_NOP:	/* Ref: RFC 793 section 3.1 */
+			length--;
+			continue;
+		default:
+			opsize =3D *ptr++;
+			if (opsize < 2)	/* "silly options" */
+				return NULL;
+			if (opsize > length)
+				return NULL;  /* don't parse partial options */
+			if (opcode =3D=3D TCPOPT_MPTCP &&
+			    ((struct mptcp_option *)(ptr - 2))->sub =3D=3D MPTCP_SUB_JOIN)
+				return (struct mp_join *)(ptr - 2);
+			ptr +=3D opsize - 2;
+			length -=3D opsize;
+		}
+	}
+	return NULL;
+}
+
+/* Shoaib: With the recent changes this is most likely not needed
+ */
+int mptcp_lookup_join(struct sk_buff *skb, struct inet_timewait_sock *tw)
+{
+	const struct mptcp_cb *mpcb;
+	struct sock *meta_sk;
+	u32 token;
+	bool meta_v4;
+	struct mp_join *join_opt =3D mptcp_find_join(skb);
+
+	if (!join_opt)
+		return 0;
+
+	/* MPTCP structures were not initialized, so return error */
+	if (mptcp_init_failed)
+		return 0;
+
+	token =3D join_opt->u.syn.token;
+	meta_sk =3D mptcp_hash_find(dev_net(skb_dst(skb)->dev), token);
+
+	if (!meta_sk) {
+		MPTCP_INC_STATS_BH(dev_net(skb_dst(skb)->dev),
+				   MPTCP_MIB_JOINNOTOKEN);
+		mptcp_debug("%s:mpcb not found:%x\n", __func__, token);
+		return 0;
+	}
+
+	meta_v4 =3D meta_sk->sk_family =3D=3D AF_INET;
+
+	if (meta_v4) {
+		if (skb->protocol =3D=3D htons(ETH_P_IPV6)) {
+			mptcp_debug("SYN+MP_JOIN with IPV6 address on pure IPV4 meta\n");
+			sock_put(meta_sk); /* Taken by mptcp_hash_find */
+			return 0;
+		}
+	} else if (skb->protocol =3D=3D htons(ETH_P_IP) && meta_sk->sk_ipv6only) {
+		mptcp_debug("SYN+MP_JOIN with IPV4 address on IPV6_V6ONLY meta\n");
+		sock_put(meta_sk); /* Taken by mptcp_hash_find */
+		return 0;
+	}
+
+	mpcb =3D tcp_sk(meta_sk)->mpcb;
+	if (mpcb->infinite_mapping_rcv || mpcb->send_infinite_mapping) {
+		/* We are in fallback-mode on the reception-side -
+		 * no new subflows!
+		 */
+		sock_put(meta_sk); /* Taken by mptcp_hash_find */
+		MPTCP_INC_STATS_BH(sock_net(meta_sk), MPTCP_MIB_JOINFALLBACK);
+		return 0;
+	}
+
+	/* Coming from time-wait-sock processing in tcp_v4_rcv.
+	 * We have to deschedule it before continuing, because otherwise
+	 * mptcp_v4_do_rcv will hit again on it inside tcp_v4_hnd_req.
+	 */
+	if (tw)
+		inet_twsk_deschedule_put(tw);
+
+	TCP_SKB_CB(skb)->mptcp_flags |=3D MPTCPHDR_JOIN;
+	/* OK, this is a new syn/join, let's create a new open request and
+	 * send syn+ack
+	 */
+	bh_lock_sock_nested(meta_sk);
+	if (sock_owned_by_user(meta_sk)) {
+		skb->sk =3D meta_sk;
+		if (unlikely(sk_add_backlog(meta_sk, skb,
+					    meta_sk->sk_rcvbuf +
+					    meta_sk->sk_sndbuf))) {
+			bh_unlock_sock(meta_sk);
+			__NET_INC_STATS(sock_net(meta_sk),
+					 LINUX_MIB_TCPBACKLOGDROP);
+			sock_put(meta_sk); /* Taken by mptcp_hash_find */
+			kfree_skb(skb);
+			return 1;
+		}
+	} else {
+		mptcp_process_join_req(meta_sk, skb);
+	}
+
+	bh_unlock_sock(meta_sk);
+	sock_put(meta_sk); /* Taken by mptcp_hash_find */
+	return 1;
+}
+
+int mptcp_do_join_short(struct sk_buff *skb,
+			const struct mptcp_options_received *mopt,
+			struct net *net)
+{
+	struct sock *meta_sk;
+	u32 token;
+	bool meta_v4;
+
+	token =3D mopt->mptcp_rem_token;
+	meta_sk =3D mptcp_hash_find(net, token);
+	if (!meta_sk) {
+		MPTCP_INC_STATS_BH(dev_net(skb_dst(skb)->dev),
+				   MPTCP_MIB_JOINNOTOKEN);
+		mptcp_debug("%s:mpcb not found:%x\n", __func__, token);
+		return -1;
+	}
+
+	meta_v4 =3D meta_sk->sk_family =3D=3D AF_INET;
+	if (meta_v4) {
+		if (skb->protocol =3D=3D htons(ETH_P_IPV6)) {
+			mptcp_debug("SYN+MP_JOIN with IPV6 address on pure IPV4 meta\n");
+			sock_put(meta_sk); /* Taken by mptcp_hash_find */
+			return -1;
+		}
+	} else if (skb->protocol =3D=3D htons(ETH_P_IP) && meta_sk->sk_ipv6only) {
+		mptcp_debug("SYN+MP_JOIN with IPV4 address on IPV6_V6ONLY meta\n");
+		sock_put(meta_sk); /* Taken by mptcp_hash_find */
+		return -1;
+	}
+
+	/* OK, this is a new syn/join, let's create a new open request and
+	 * send syn+ack
+	 */
+	bh_lock_sock(meta_sk);
+
+	/* This check is also done in mptcp_vX_do_rcv. But, there we cannot
+	 * call tcp_vX_send_reset, because we hold already two socket-locks.
+	 * (the listener and the meta from above)
+	 *
+	 * And the send-reset will try to take yet another one (ip_send_reply).
+	 * Thus, we propagate the reset up to tcp_rcv_state_process.
+	 */
+	if (tcp_sk(meta_sk)->mpcb->infinite_mapping_rcv ||
+	    tcp_sk(meta_sk)->mpcb->send_infinite_mapping ||
+	    meta_sk->sk_state =3D=3D TCP_CLOSE || !tcp_sk(meta_sk)->inside_tk_tab=
le) {
+		MPTCP_INC_STATS_BH(sock_net(meta_sk), MPTCP_MIB_JOINFALLBACK);
+		bh_unlock_sock(meta_sk);
+		sock_put(meta_sk); /* Taken by mptcp_hash_find */
+		return -1;
+	}
+
+	if (sock_owned_by_user(meta_sk)) {
+		skb->sk =3D meta_sk;
+		if (unlikely(sk_add_backlog(meta_sk, skb,
+					    meta_sk->sk_rcvbuf + meta_sk->sk_sndbuf)))
+			__NET_INC_STATS(net, LINUX_MIB_TCPBACKLOGDROP);
+		else
+			/* Must make sure that upper layers won't free the
+			 * skb if it is added to the backlog-queue.
+			 */
+			skb_get(skb);
+	} else {
+		/* mptcp_v4_do_rcv tries to free the skb - we prevent this, as
+		 * the skb will finally be freed by tcp_v4_do_rcv (where we are
+		 * coming from)
+		 */
+		skb_get(skb);
+		mptcp_process_join_req(meta_sk, skb);
+	}
+
+	bh_unlock_sock(meta_sk);
+	sock_put(meta_sk); /* Taken by mptcp_hash_find */
+	return 0;
+}
+
+/**
+ * Equivalent of tcp_fin() for MPTCP
+ * Can be called only when the FIN is validly part
+ * of the data seqnum space. Not before when we get holes.
+ */
+void mptcp_fin(struct sock *meta_sk)
+{
+	struct sock *sk =3D NULL, *sk_it;
+	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
+	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
+	unsigned char state;
+
+	mptcp_for_each_sk(mpcb, sk_it) {
+		if (tcp_sk(sk_it)->mptcp->path_index =3D=3D mpcb->dfin_path_index) {
+			sk =3D sk_it;
+			break;
+		}
+	}
+
+	if (!sk || sk->sk_state =3D=3D TCP_CLOSE)
+		sk =3D mptcp_select_ack_sock(meta_sk);
+
+	inet_csk_schedule_ack(sk);
+
+	if (!mpcb->in_time_wait) {
+		meta_sk->sk_shutdown |=3D RCV_SHUTDOWN;
+		sock_set_flag(meta_sk, SOCK_DONE);
+		state =3D meta_sk->sk_state;
+	} else {
+		state =3D mpcb->mptw_state;
+	}
+
+	switch (state) {
+	case TCP_SYN_RECV:
+	case TCP_ESTABLISHED:
+		/* Move to CLOSE_WAIT */
+		tcp_set_state(meta_sk, TCP_CLOSE_WAIT);
+		inet_csk(sk)->icsk_ack.pingpong =3D 1;
+		break;
+
+	case TCP_CLOSE_WAIT:
+	case TCP_CLOSING:
+		/* Received a retransmission of the FIN, do
+		 * nothing.
+		 */
+		break;
+	case TCP_LAST_ACK:
+		/* RFC793: Remain in the LAST-ACK state. */
+		break;
+
+	case TCP_FIN_WAIT1:
+		/* This case occurs when a simultaneous close
+		 * happens, we must ack the received FIN and
+		 * enter the CLOSING state.
+		 */
+		tcp_send_ack(sk);
+		tcp_set_state(meta_sk, TCP_CLOSING);
+		break;
+	case TCP_FIN_WAIT2:
+		/* Received a FIN -- send ACK and enter TIME_WAIT. */
+		tcp_send_ack(sk);
+		meta_tp->op_ops->time_wait(meta_sk, TCP_TIME_WAIT, 0);
+		break;
+	default:
+		/* Only TCP_LISTEN and TCP_CLOSE are left, in these
+		 * cases we should never reach this piece of code.
+		 */
+		pr_err("%s: Impossible, meta_sk->sk_state=3D%d\n", __func__,
+		       meta_sk->sk_state);
+		break;
+	}
+
+	/* It _is_ possible, that we have something out-of-order _after_ FIN.
+	 * Probably, we should reset in this case. For now drop them.
+	 */
+	mptcp_purge_ofo_queue(meta_tp);
+	sk_mem_reclaim(meta_sk);
+
+	if (!sock_flag(meta_sk, SOCK_DEAD)) {
+		meta_sk->sk_state_change(meta_sk);
+
+		/* Do not send POLL_HUP for half duplex close. */
+		if (meta_sk->sk_shutdown =3D=3D SHUTDOWN_MASK ||
+		    meta_sk->sk_state =3D=3D TCP_CLOSE)
+			sk_wake_async(meta_sk, SOCK_WAKE_WAITD, POLL_HUP);
+		else
+			sk_wake_async(meta_sk, SOCK_WAKE_WAITD, POLL_IN);
+	}
+
+	return;
+}
+
+static void mptcp_xmit_retransmit_queue(struct sock *meta_sk)
+{
+	const struct inet_connection_sock *icsk =3D inet_csk(meta_sk);
+	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
+	struct sk_buff *rtx_head, *skb;
+
+	if (!meta_tp->packets_out)
+		return;
+
+	rtx_head =3D skb =3D tcp_rtx_queue_head(meta_sk);
+	skb_rbtree_walk_from(skb) {
+#ifdef RCHK
+		if (tcp_pacing_check(meta_sk))
+			break;
+#endif
+		if (mptcp_retransmit_skb(meta_sk, skb))
+			return;
+		if (skb =3D=3D rtx_head &&
+		    icsk->icsk_pending !=3D ICSK_TIME_REO_TIMEOUT)
+			inet_csk_reset_xmit_timer(meta_sk, ICSK_TIME_RETRANS,
+			    inet_csk(meta_sk)->icsk_rto, TCP_RTO_MAX);
+	}
+}
+
+static void mptcp_snd_una_update(struct tcp_sock *meta_tp, u32 data_ack)
+{
+	u32 delta =3D data_ack - meta_tp->snd_una;
+
+	sock_owned_by_me((struct sock *)meta_tp);
+	meta_tp->bytes_acked +=3D delta;
+	meta_tp->snd_una =3D data_ack;
+}
+
+/* Handle the DATA_ACK */
+static void mptcp_data_ack(struct sock *sk, const struct sk_buff *skb)
+{
+	struct sock *meta_sk =3D mptcp_meta_sk(sk);
+	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk), *tp =3D tcp_sk(sk);
+	u32 prior_snd_una =3D meta_tp->snd_una;
+	int prior_packets;
+	u32 nwin, data_ack, data_seq;
+	u16 data_len =3D 0;
+
+	/* A valid packet came in - subflow is operational again */
+	tp->pf =3D 0;
+
+	/* Even if there is no data-ack, we stop retransmitting.
+	 * Except if this is a SYN/ACK. Then it is just a retransmission
+	 */
+	if (tp->mptcp->pre_established && !tcp_hdr(skb)->syn) {
+		tp->mptcp->pre_established =3D 0;
+		sk_stop_timer(sk, &tp->mptcp->mptcp_ack_timer);
+	}
+
+	/* If we are in infinite mapping mode, rx_opt.data_ack has been
+	 * set by mptcp_clean_rtx_infinite.
+	 */
+	if (!(TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_ACK) &&
+		!tp->mpcb->infinite_mapping_snd)
+		goto exit;
+
+	data_ack =3D tp->mptcp->rx_opt.data_ack;
+
+	if (unlikely(!tp->mptcp->fully_established) &&
+	    tp->mptcp->snt_isn + 1 !=3D TCP_SKB_CB(skb)->ack_seq)
+		/* As soon as a subflow-data-ack (not acking syn, thus snt_isn + 1)
+		 * includes a data-ack, we are fully established
+		 */
+		mptcp_become_fully_estab(sk);
+
+	/* Get the data_seq */
+	if (mptcp_is_data_seq(skb)) {
+		data_seq =3D tp->mptcp->rx_opt.data_seq;
+		data_len =3D tp->mptcp->rx_opt.data_len;
+	} else {
+		data_seq =3D meta_tp->snd_wl1;
+	}
+
+	/* If the ack is older than previous acks
+	 * then we can probably ignore it.
+	 */
+	if (before(data_ack, prior_snd_una))
+		goto exit;
+
+	/* If the ack includes data we haven't sent yet, discard
+	 * this segment (RFC793 Section 3.9).
+	 */
+	if (after(data_ack, meta_tp->snd_nxt))
+		goto exit;
+
+	/*** Now, update the window  - inspired by tcp_ack_update_window ***/
+	nwin =3D ntohs(tcp_hdr(skb)->window);
+
+	if (likely(!tcp_hdr(skb)->syn))
+		nwin <<=3D tp->rx_opt.snd_wscale;
+
+	if (tcp_may_update_window(meta_tp, data_ack, data_seq, nwin)) {
+		tcp_update_wl(meta_tp, data_seq);
+
+		/* Draft v09, Section 3.3.5:
+		 * [...] It should only update its local receive window values
+		 * when the largest sequence number allowed (i.e.  DATA_ACK +
+		 * receive window) increases. [...]
+		 */
+		if (meta_tp->snd_wnd !=3D nwin &&
+		    !before(data_ack + nwin, tcp_wnd_end(meta_tp))) {
+			meta_tp->snd_wnd =3D nwin;
+
+			if (nwin > meta_tp->max_window)
+				meta_tp->max_window =3D nwin;
+		}
+	}
+	/*** Done, update the window ***/
+
+	/* We passed data and got it acked, remove any soft error
+	 * log. Something worked...
+	 */
+	sk->sk_err_soft =3D 0;
+	inet_csk(meta_sk)->icsk_probes_out =3D 0;
+	meta_tp->rcv_tstamp =3D tcp_jiffies32;
+	prior_packets =3D meta_tp->packets_out;
+	if (!prior_packets)
+		goto no_queue;
+
+	mptcp_snd_una_update(meta_tp, data_ack);
+
+	mptcp_clean_rtx_queue(meta_sk, prior_snd_una);
+
+	/* We are in loss-state, and something got acked, retransmit the whole
+	 * queue now!
+	 */
+	if (inet_csk(meta_sk)->icsk_ca_state =3D=3D TCP_CA_Loss &&
+	    after(data_ack, prior_snd_una)) {
+		mptcp_xmit_retransmit_queue(meta_sk);
+		inet_csk(meta_sk)->icsk_ca_state =3D TCP_CA_Open;
+	}
+
+	/* Simplified version of tcp_new_space, because the snd-buffer
+	 * is handled by all the subflows.
+	 */
+	if (sock_flag(meta_sk, SOCK_QUEUE_SHRUNK)) {
+		sock_reset_flag(meta_sk, SOCK_QUEUE_SHRUNK);
+		if (meta_sk->sk_socket &&
+		    test_bit(SOCK_NOSPACE, &meta_sk->sk_socket->flags))
+			meta_sk->sk_write_space(meta_sk);
+	}
+
+	if (meta_sk->sk_state !=3D TCP_ESTABLISHED &&
+	    mptcp_rcv_state_process(meta_sk, sk, skb, data_seq, data_len))
+		return;
+
+exit:
+	mptcp_push_pending_frames(meta_sk);
+
+	return;
+
+no_queue:
+	if (tcp_send_head(meta_sk))
+		tcp_ack_probe(meta_sk);
+
+	mptcp_push_pending_frames(meta_sk);
+
+	return;
+}
+
+void mptcp_clean_rtx_infinite(const struct sk_buff *skb, struct sock *sk)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk), *meta_tp =3D tcp_sk(mptcp_meta_sk(sk)=
);
+
+	if (!tp->mpcb->infinite_mapping_snd)
+		return;
+
+	/* The difference between both write_seq's represents the offset between
+	 * data-sequence and subflow-sequence. As we are infinite, this must
+	 * match.
+	 *
+	 * Thus, from this difference we can infer the meta snd_una.
+	 */
+	tp->mptcp->rx_opt.data_ack =3D meta_tp->snd_nxt - tp->snd_nxt +
+				     tp->snd_una;
+
+	mptcp_data_ack(sk, skb);
+}
+
+/**** static functions used by mptcp_parse_options */
+
+static void mptcp_send_reset_rem_id(const struct mptcp_cb *mpcb, u8 rem_id)
+{
+	struct sock *sk_it, *tmpsk;
+
+	mptcp_for_each_sk_safe(mpcb, sk_it, tmpsk) {
+		if (tcp_sk(sk_it)->mptcp->rem_id =3D=3D rem_id) {
+			mptcp_reinject_data(sk_it, 0);
+			mptcp_send_reset(sk_it);
+		}
+	}
+}
+
+static inline bool is_valid_addropt_opsize(u8 mptcp_ver,
+					   struct mp_add_addr *mpadd,
+					   int opsize)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	if (mptcp_ver < MPTCP_VERSION_1 && mpadd->ipver =3D=3D 6) {
+		return opsize =3D=3D MPTCP_SUB_LEN_ADD_ADDR6 ||
+		       opsize =3D=3D MPTCP_SUB_LEN_ADD_ADDR6 + 2;
+	}
+	if (mptcp_ver >=3D MPTCP_VERSION_1 && mpadd->ipver =3D=3D 6)
+		return opsize =3D=3D MPTCP_SUB_LEN_ADD_ADDR6_VER1 ||
+		       opsize =3D=3D MPTCP_SUB_LEN_ADD_ADDR6_VER1 + 2;
+#endif
+	if (mptcp_ver < MPTCP_VERSION_1 && mpadd->ipver =3D=3D 4) {
+		return opsize =3D=3D MPTCP_SUB_LEN_ADD_ADDR4 ||
+		       opsize =3D=3D MPTCP_SUB_LEN_ADD_ADDR4 + 2;
+	}
+	if (mptcp_ver >=3D MPTCP_VERSION_1 && mpadd->ipver =3D=3D 4) {
+		return opsize =3D=3D MPTCP_SUB_LEN_ADD_ADDR4_VER1 ||
+		       opsize =3D=3D MPTCP_SUB_LEN_ADD_ADDR4_VER1 + 2;
+	}
+	return false;
+}
+
+void mptcp_parse_options(const uint8_t *ptr, int opsize,
+			 struct mptcp_options_received *mopt,
+			 struct sk_buff *skb,
+			 struct tcp_sock *tp)
+{
+	const struct mptcp_option *mp_opt =3D (struct mptcp_option *)ptr;
+
+	/* If the socket is mp-capable we would have a mopt. */
+	if (!mopt)
+		return;
+
+	switch (mp_opt->sub) {
+	case MPTCP_SUB_CAPABLE:
+	{
+		const struct mp_capable *mpcapable =3D (struct mp_capable *)ptr;
+
+		if (opsize !=3D MPTCP_SUB_LEN_CAPABLE_SYN &&
+		    opsize !=3D MPTCP_SUB_LEN_CAPABLE_ACK) {
+			mptcp_debug("%s: mp_capable: bad option size %d\n",
+				    __func__, opsize);
+			break;
+		}
+
+		/* MPTCP-RFC 6824:
+		 * "If receiving a message with the 'B' flag set to 1, and this
+		 * is not understood, then this SYN MUST be silently ignored;
+		 */
+		if (mpcapable->b) {
+			mopt->drop_me =3D 1;
+			break;
+		}
+
+		/* MPTCP-RFC 6824:
+		 * "An implementation that only supports this method MUST set
+		 *  bit "H" to 1, and bits "C" through "G" to 0."
+		 */
+		if (!mpcapable->h)
+			break;
+
+		mopt->saw_mpc =3D 1;
+		mopt->dss_csum =3D sysctl_mptcp_checksum || mpcapable->a;
+
+		if (opsize >=3D MPTCP_SUB_LEN_CAPABLE_SYN)
+			mopt->mptcp_sender_key =3D mpcapable->sender_key;
+		if (opsize =3D=3D MPTCP_SUB_LEN_CAPABLE_ACK)
+			mopt->mptcp_receiver_key =3D mpcapable->receiver_key;
+
+		mopt->mptcp_ver =3D mpcapable->ver;
+		break;
+	}
+	case MPTCP_SUB_JOIN:
+	{
+		const struct mp_join *mpjoin =3D (struct mp_join *)ptr;
+
+		if (opsize !=3D MPTCP_SUB_LEN_JOIN_SYN &&
+		    opsize !=3D MPTCP_SUB_LEN_JOIN_SYNACK &&
+		    opsize !=3D MPTCP_SUB_LEN_JOIN_ACK) {
+			mptcp_debug("%s: mp_join: bad option size %d\n",
+				    __func__, opsize);
+			break;
+		}
+
+		/* saw_mpc must be set, because in tcp_check_req we assume that
+		 * it is set to support falling back to reg. TCP if a rexmitted
+		 * SYN has no MP_CAPABLE or MP_JOIN
+		 */
+		switch (opsize) {
+		case MPTCP_SUB_LEN_JOIN_SYN:
+			mopt->is_mp_join =3D 1;
+			mopt->saw_mpc =3D 1;
+			mopt->low_prio =3D mpjoin->b;
+			mopt->rem_id =3D mpjoin->addr_id;
+			mopt->mptcp_rem_token =3D mpjoin->u.syn.token;
+			mopt->mptcp_recv_nonce =3D mpjoin->u.syn.nonce;
+			break;
+		case MPTCP_SUB_LEN_JOIN_SYNACK:
+			mopt->saw_mpc =3D 1;
+			mopt->low_prio =3D mpjoin->b;
+			mopt->rem_id =3D mpjoin->addr_id;
+			mopt->mptcp_recv_tmac =3D mpjoin->u.synack.mac;
+			mopt->mptcp_recv_nonce =3D mpjoin->u.synack.nonce;
+			break;
+		case MPTCP_SUB_LEN_JOIN_ACK:
+			mopt->saw_mpc =3D 1;
+			mopt->join_ack =3D 1;
+			memcpy(mopt->mptcp_recv_mac, mpjoin->u.ack.mac, 20);
+			break;
+		}
+		break;
+	}
+	case MPTCP_SUB_DSS:
+	{
+		const struct mp_dss *mdss =3D (struct mp_dss *)ptr;
+
+		/* We check opsize for the csum and non-csum case. We do this,
+		 * because the draft says that the csum SHOULD be ignored if
+		 * it has not been negotiated in the MP_CAPABLE but still is
+		 * present in the data.
+		 *
+		 * It will get ignored later in mptcp_queue_skb.
+		 */
+		if (opsize !=3D mptcp_sub_len_dss(mdss, 0) &&
+		    opsize !=3D mptcp_sub_len_dss(mdss, 1)) {
+			mptcp_debug("%s: mp_dss: bad option size %d\n",
+				    __func__, opsize);
+			break;
+		}
+
+		ptr +=3D 4;
+
+		if (mdss->A) {
+			TCP_SKB_CB(skb)->mptcp_flags |=3D MPTCPHDR_ACK;
+
+			if (mdss->a) {
+				mopt->data_ack =3D (u32) get_unaligned_be64(ptr);
+				ptr +=3D MPTCP_SUB_LEN_ACK_64;
+			} else {
+				mopt->data_ack =3D get_unaligned_be32(ptr);
+				ptr +=3D MPTCP_SUB_LEN_ACK;
+			}
+		}
+
+		mopt->mptcp_dss_off =3D (ptr - skb_transport_header(skb));
+
+		if (mdss->M) {
+			if (mdss->m) {
+				u64 data_seq64 =3D get_unaligned_be64(ptr);
+
+				TCP_SKB_CB(skb)->mptcp_flags |=3D
+				    MPTCPHDR_SEQ64_SET;
+				mopt->data_seq =3D (u32) data_seq64;
+
+				ptr +=3D 12; /* 64-bit dseq + subseq */
+			} else {
+				mopt->data_seq =3D get_unaligned_be32(ptr);
+				ptr +=3D 8; /* 32-bit dseq + subseq */
+			}
+			mopt->data_len =3D get_unaligned_be16(ptr);
+
+			TCP_SKB_CB(skb)->mptcp_flags |=3D MPTCPHDR_SEQ;
+
+			/* Is a check-sum present? */
+			if (opsize =3D=3D mptcp_sub_len_dss(mdss, 1)) {
+				TCP_SKB_CB(skb)->mptcp_flags |=3D
+					MPTCPHDR_DSS_CSUM;
+			}
+
+			/* DATA_FIN only possible with DSS-mapping */
+			if (mdss->F)
+				TCP_SKB_CB(skb)->mptcp_flags |=3D MPTCPHDR_FIN;
+		}
+
+		break;
+	}
+	case MPTCP_SUB_ADD_ADDR:
+	{
+		struct mp_add_addr *mpadd =3D (struct mp_add_addr *)ptr;
+
+		/* If tcp_sock is not available, MPTCP version can't be
+		 * retrieved and ADD_ADDR opsize validation is not possible.
+		 */
+		if (!tp)
+			break;
+
+		if (!is_valid_addropt_opsize(tp->mpcb->mptcp_ver,
+					     mpadd, opsize)) {
+			mptcp_debug("%s: mp_add_addr: bad option size %d\n",
+				    __func__, opsize);
+			break;
+		}
+
+		/* We have to manually parse the options if we got two of them. */
+		if (mopt->saw_add_addr) {
+			mopt->more_add_addr =3D 1;
+			break;
+		}
+		mopt->saw_add_addr =3D 1;
+		mopt->add_addr_ptr =3D ptr;
+		break;
+	}
+	case MPTCP_SUB_REMOVE_ADDR:
+		if ((opsize - MPTCP_SUB_LEN_REMOVE_ADDR) < 0) {
+			mptcp_debug("%s: mp_remove_addr: bad option size %d\n",
+				    __func__, opsize);
+			break;
+		}
+
+		if (mopt->saw_rem_addr) {
+			mopt->more_rem_addr =3D 1;
+			break;
+		}
+		mopt->saw_rem_addr =3D 1;
+		mopt->rem_addr_ptr =3D ptr;
+		break;
+	case MPTCP_SUB_PRIO:
+	{
+		const struct mp_prio *mpprio =3D (struct mp_prio *)ptr;
+
+		if (opsize !=3D MPTCP_SUB_LEN_PRIO &&
+		    opsize !=3D MPTCP_SUB_LEN_PRIO_ADDR) {
+			mptcp_debug("%s: mp_prio: bad option size %d\n",
+				    __func__, opsize);
+			break;
+		}
+
+		mopt->saw_low_prio =3D 1;
+		mopt->low_prio =3D mpprio->b;
+
+		if (opsize =3D=3D MPTCP_SUB_LEN_PRIO_ADDR) {
+			mopt->saw_low_prio =3D 2;
+			mopt->prio_addr_id =3D mpprio->addr_id;
+		}
+		break;
+	}
+	case MPTCP_SUB_FAIL:
+		if (opsize !=3D MPTCP_SUB_LEN_FAIL) {
+			mptcp_debug("%s: mp_fail: bad option size %d\n",
+				    __func__, opsize);
+			break;
+		}
+		mopt->mp_fail =3D 1;
+		break;
+	case MPTCP_SUB_FCLOSE:
+		if (opsize !=3D MPTCP_SUB_LEN_FCLOSE) {
+			mptcp_debug("%s: mp_fclose: bad option size %d\n",
+				    __func__, opsize);
+			break;
+		}
+
+		mopt->mp_fclose =3D 1;
+		mopt->mptcp_sender_key =3D ((struct mp_fclose *)ptr)->key;
+
+		break;
+	default:
+		mptcp_debug("%s: Received unkown subtype: %d\n",
+			    __func__, mp_opt->sub);
+		break;
+	}
+}
+
+/** Parse only MPTCP options */
+void tcp_parse_mptcp_options(struct sk_buff *skb,
+			     struct mptcp_options_received *mopt)
+{
+	const struct tcphdr *th =3D tcp_hdr(skb);
+	int length =3D (th->doff * 4) - sizeof(struct tcphdr);
+	const unsigned char *ptr =3D (const unsigned char *)(th + 1);
+
+	while (length > 0) {
+		int opcode =3D *ptr++;
+		int opsize;
+
+		switch (opcode) {
+		case TCPOPT_EOL:
+			return;
+		case TCPOPT_NOP:	/* Ref: RFC 793 section 3.1 */
+			length--;
+			continue;
+		default:
+			opsize =3D *ptr++;
+			if (opsize < 2)	/* "silly options" */
+				return;
+			if (opsize > length)
+				return;	/* don't parse partial options */
+			if (opcode =3D=3D TCPOPT_MPTCP) {
+				mptcp_parse_options(ptr - 2, opsize,
+						    mopt, skb, NULL);
+			}
+		}
+		ptr +=3D opsize - 2;
+		length -=3D opsize;
+	}
+}
+
+bool mptcp_check_rtt(struct sock *sk)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct mptcp_cb *mpcb =3D tp->mpcb;
+	struct sock *__sk;
+	int time;
+	u32 rtt_max =3D 0;
+
+	time =3D tcp_stamp_us_delta(tp->tcp_mstamp, tp->rcvq_space.time);
+
+	/* In MPTCP, we take the max delay across all flows,
+	 * in order to take into account meta-reordering buffers.
+	 */
+	mptcp_for_each_sk(mpcb, __sk) {
+		if (!mptcp_sk_can_recv(__sk))
+			continue;
+
+		if (rtt_max < tcp_sk(__sk)->rcv_rtt_est.rtt_us)
+			rtt_max =3D tcp_sk(__sk)->rcv_rtt_est.rtt_us;
+	}
+
+	if (time < (rtt_max >> 3) || !rtt_max)
+		return true;
+
+	return false;
+}
+
+static void mptcp_handle_add_addr(const unsigned char *ptr, struct sock *s=
k)
+{
+	struct mp_add_addr *mpadd =3D (struct mp_add_addr *)ptr;
+	struct mptcp_cb *mpcb =3D tcp_sk(sk)->mpcb;
+	__be16 port =3D 0;
+	union inet_addr addr;
+	sa_family_t family;
+
+	if (mpadd->ipver =3D=3D 4) {
+		char *recv_hmac;
+		u8 hash_mac_check[20];
+		u8 no_key[8];
+		int msg_parts =3D 0;
+
+		if (mpcb->mptcp_ver < MPTCP_VERSION_1)
+			goto skip_hmac_v4;
+
+		*(u64 *)no_key =3D 0;
+		recv_hmac =3D (char *)mpadd->u.v4.mac;
+		if (mpadd->len =3D=3D MPTCP_SUB_LEN_ADD_ADDR4_VER1) {
+			recv_hmac -=3D sizeof(mpadd->u.v4.port);
+			msg_parts =3D 2;
+		} else if (mpadd->len =3D=3D MPTCP_SUB_LEN_ADD_ADDR4_VER1 + 2) {
+			msg_parts =3D 3;
+		}
+		mptcp_hmac_sha1((u8 *)&mpcb->mptcp_rem_key,
+				(u8 *)no_key,
+				(u32 *)hash_mac_check, msg_parts,
+				1, (u8 *)&mpadd->addr_id,
+				4, (u8 *)&mpadd->u.v4.addr.s_addr,
+				2, (u8 *)&mpadd->u.v4.port);
+		if (memcmp(hash_mac_check, recv_hmac, 8) !=3D 0) {
+			/* ADD_ADDR2 discarded */
+			return;
+		}
+skip_hmac_v4:
+		if ((mpcb->mptcp_ver =3D=3D MPTCP_VERSION_0 &&
+		     mpadd->len =3D=3D MPTCP_SUB_LEN_ADD_ADDR4 + 2) ||
+		     (mpcb->mptcp_ver =3D=3D MPTCP_VERSION_1 &&
+		     mpadd->len =3D=3D MPTCP_SUB_LEN_ADD_ADDR4_VER1 + 2))
+			port  =3D mpadd->u.v4.port;
+		family =3D AF_INET;
+		addr.in =3D mpadd->u.v4.addr;
+#if IS_ENABLED(CONFIG_IPV6)
+	} else if (mpadd->ipver =3D=3D 6) {
+		char *recv_hmac;
+		u8 hash_mac_check[20];
+		u8 no_key[8];
+		int msg_parts =3D 0;
+
+		if (mpcb->mptcp_ver < MPTCP_VERSION_1)
+			goto skip_hmac_v6;
+
+		*(u64 *)no_key =3D 0;
+		recv_hmac =3D (char *)mpadd->u.v6.mac;
+		if (mpadd->len =3D=3D MPTCP_SUB_LEN_ADD_ADDR6_VER1) {
+			recv_hmac -=3D sizeof(mpadd->u.v6.port);
+			msg_parts =3D 2;
+		} else if (mpadd->len =3D=3D MPTCP_SUB_LEN_ADD_ADDR6_VER1 + 2) {
+			msg_parts =3D 3;
+		}
+		mptcp_hmac_sha1((u8 *)&mpcb->mptcp_rem_key,
+				(u8 *)no_key,
+				(u32 *)hash_mac_check, msg_parts,
+				1, (u8 *)&mpadd->addr_id,
+				16, (u8 *)&mpadd->u.v6.addr.s6_addr,
+				2, (u8 *)&mpadd->u.v6.port);
+		if (memcmp(hash_mac_check, recv_hmac, 8) !=3D 0)
+			/* ADD_ADDR2 discarded */
+			return;
+skip_hmac_v6:
+		if ((mpcb->mptcp_ver =3D=3D MPTCP_VERSION_0 &&
+		     mpadd->len =3D=3D MPTCP_SUB_LEN_ADD_ADDR6 + 2) ||
+		     (mpcb->mptcp_ver =3D=3D MPTCP_VERSION_1 &&
+		     mpadd->len =3D=3D MPTCP_SUB_LEN_ADD_ADDR6_VER1 + 2))
+			port  =3D mpadd->u.v6.port;
+		family =3D AF_INET6;
+		addr.in6 =3D mpadd->u.v6.addr;
+#endif /* CONFIG_IPV6 */
+	} else {
+		return;
+	}
+
+	if (mpcb->pm_ops->add_raddr)
+		mpcb->pm_ops->add_raddr(mpcb, &addr, family,
+					port, mpadd->addr_id);
+
+	MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_ADDADDRRX);
+}
+
+static void mptcp_handle_rem_addr(const unsigned char *ptr, struct sock *s=
k)
+{
+	struct mp_remove_addr *mprem =3D (struct mp_remove_addr *)ptr;
+	int i;
+	u8 rem_id;
+	struct mptcp_cb *mpcb =3D tcp_sk(sk)->mpcb;
+
+	for (i =3D 0; i <=3D mprem->len - MPTCP_SUB_LEN_REMOVE_ADDR; i++) {
+		rem_id =3D (&mprem->addrs_id)[i];
+
+		if (mpcb->pm_ops->rem_raddr)
+			mpcb->pm_ops->rem_raddr(mpcb, rem_id);
+		mptcp_send_reset_rem_id(mpcb, rem_id);
+
+		MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_REMADDRSUB);
+	}
+
+	MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_REMADDRRX);
+}
+
+static void mptcp_parse_addropt(const struct sk_buff *skb, struct sock *sk)
+{
+	struct tcphdr *th =3D tcp_hdr(skb);
+	unsigned char *ptr;
+	int length =3D (th->doff * 4) - sizeof(struct tcphdr);
+
+	/* Jump through the options to check whether ADD_ADDR is there */
+	ptr =3D (unsigned char *)(th + 1);
+	while (length > 0) {
+		int opcode =3D *ptr++;
+		int opsize;
+
+		switch (opcode) {
+		case TCPOPT_EOL:
+			return;
+		case TCPOPT_NOP:
+			length--;
+			continue;
+		default:
+			opsize =3D *ptr++;
+			if (opsize < 2)
+				return;
+			if (opsize > length)
+				return;  /* don't parse partial options */
+			if (opcode =3D=3D TCPOPT_MPTCP &&
+			    ((struct mptcp_option *)ptr)->sub =3D=3D MPTCP_SUB_ADD_ADDR) {
+				u8 mptcp_ver =3D tcp_sk(sk)->mpcb->mptcp_ver;
+				struct mp_add_addr *mpadd =3D (struct mp_add_addr *)ptr;
+
+				if (!is_valid_addropt_opsize(mptcp_ver, mpadd,
+							     opsize))
+					goto cont;
+
+				mptcp_handle_add_addr(ptr, sk);
+			}
+			if (opcode =3D=3D TCPOPT_MPTCP &&
+			    ((struct mptcp_option *)ptr)->sub =3D=3D MPTCP_SUB_REMOVE_ADDR) {
+				if ((opsize - MPTCP_SUB_LEN_REMOVE_ADDR) < 0)
+					goto cont;
+
+				mptcp_handle_rem_addr(ptr, sk);
+			}
+cont:
+			ptr +=3D opsize - 2;
+			length -=3D opsize;
+		}
+	}
+	return;
+}
+
+static bool mptcp_mp_fastclose_rcvd(struct sock *sk)
+{
+	struct mptcp_tcp_sock *mptcp =3D tcp_sk(sk)->mptcp;
+	struct mptcp_cb *mpcb =3D tcp_sk(sk)->mpcb;
+
+	if (likely(!mptcp->rx_opt.mp_fclose))
+		return false;
+
+	MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_FASTCLOSERX);
+	mptcp->rx_opt.mp_fclose =3D 0;
+	if (mptcp->rx_opt.mptcp_sender_key !=3D mpcb->mptcp_loc_key)
+		return false;
+
+	mptcp_sub_force_close_all(mpcb, NULL);
+
+	tcp_reset(mptcp_meta_sk(sk));
+
+	return true;
+}
+
+static void mptcp_mp_fail_rcvd(struct sock *sk, const struct tcphdr *th)
+{
+	struct mptcp_tcp_sock *mptcp =3D tcp_sk(sk)->mptcp;
+	struct sock *meta_sk =3D mptcp_meta_sk(sk);
+	struct mptcp_cb *mpcb =3D tcp_sk(sk)->mpcb;
+
+	MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_MPFAILRX);
+	mptcp->rx_opt.mp_fail =3D 0;
+
+	if (!th->rst && !mpcb->infinite_mapping_snd) {
+		mpcb->send_infinite_mapping =3D 1;
+		/* We resend everything that has not been acknowledged */
+		meta_sk->sk_send_head =3D tcp_write_queue_head(meta_sk);
+
+		/* We artificially restart the whole send-queue. Thus,
+		 * it is as if no packets are in flight
+		 */
+		tcp_sk(meta_sk)->packets_out =3D 0;
+
+		/* If the snd_nxt already wrapped around, we have to
+		 * undo the wrapping, as we are restarting from snd_una
+		 * on.
+		 */
+		if (tcp_sk(meta_sk)->snd_nxt < tcp_sk(meta_sk)->snd_una) {
+			mpcb->snd_high_order[mpcb->snd_hiseq_index] -=3D 2;
+			mpcb->snd_hiseq_index =3D mpcb->snd_hiseq_index ? 0 : 1;
+		}
+		tcp_sk(meta_sk)->snd_nxt =3D tcp_sk(meta_sk)->snd_una;
+
+		/* Trigger a sending on the meta. */
+		mptcp_push_pending_frames(meta_sk);
+
+		mptcp_sub_force_close_all(mpcb, sk);
+	}
+}
+
+static inline void mptcp_path_array_check(struct sock *meta_sk)
+{
+	struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
+
+	if (unlikely(mpcb->list_rcvd)) {
+		mpcb->list_rcvd =3D 0;
+		if (mpcb->pm_ops->new_remote_address)
+			mpcb->pm_ops->new_remote_address(meta_sk);
+	}
+}
+
+bool mptcp_handle_options(struct sock *sk, const struct tcphdr *th,
+			  const struct sk_buff *skb)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct mptcp_options_received *mopt =3D &tp->mptcp->rx_opt;
+
+	BUG_ON(sk =3D=3D mptcp_meta_sk(sk));
+
+	if (tp->mpcb->infinite_mapping_rcv || tp->mpcb->infinite_mapping_snd)
+		return false;
+
+	if (mptcp_mp_fastclose_rcvd(sk))
+		return true;
+
+	if (sk->sk_state =3D=3D TCP_RST_WAIT && !th->rst)
+		return true;
+
+	if (unlikely(mopt->mp_fail))
+		mptcp_mp_fail_rcvd(sk, th);
+
+	/* RFC 6824, Section 3.3:
+	 * If a checksum is not present when its use has been negotiated, the
+	 * receiver MUST close the subflow with a RST as it is considered
+	 * broken.
+	 */
+	if (mptcp_is_data_seq(skb) && tp->mpcb->dss_csum &&
+	    !(TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_DSS_CSUM)) {
+		mptcp_send_reset(sk);
+		return true;
+	}
+
+	/* We have to acknowledge retransmissions of the third
+	 * ack.
+	 */
+	if (mopt->join_ack) {
+		tcp_send_delayed_ack(sk);
+		mopt->join_ack =3D 0;
+	}
+
+	if (mopt->saw_add_addr || mopt->saw_rem_addr) {
+		if (mopt->more_add_addr || mopt->more_rem_addr) {
+			mptcp_parse_addropt(skb, sk);
+		} else {
+			if (mopt->saw_add_addr)
+				mptcp_handle_add_addr(mopt->add_addr_ptr, sk);
+			if (mopt->saw_rem_addr)
+				mptcp_handle_rem_addr(mopt->rem_addr_ptr, sk);
+		}
+
+		mopt->more_add_addr =3D 0;
+		mopt->saw_add_addr =3D 0;
+		mopt->more_rem_addr =3D 0;
+		mopt->saw_rem_addr =3D 0;
+	}
+	if (mopt->saw_low_prio) {
+		if (mopt->saw_low_prio =3D=3D 1) {
+			tp->mptcp->rcv_low_prio =3D mopt->low_prio;
+		} else {
+			struct sock *sk_it;
+
+			mptcp_for_each_sk(tp->mpcb, sk_it) {
+				struct mptcp_tcp_sock *mptcp =3D
+							tcp_sk(sk_it)->mptcp;
+				if (mptcp->rem_id =3D=3D mopt->prio_addr_id)
+					mptcp->rcv_low_prio =3D mopt->low_prio;
+			}
+		}
+		mopt->saw_low_prio =3D 0;
+	}
+
+	mptcp_data_ack(sk, skb);
+
+	mptcp_path_array_check(mptcp_meta_sk(sk));
+	/* Socket may have been mp_killed by a REMOVE_ADDR */
+	if (tp->mp_killed)
+		return true;
+
+	return false;
+}
+
+/* In case of fastopen, some data can already be in the write queue.
+ * We need to update the sequence number of the segments as they
+ * were initially TCP sequence numbers.
+ */
+static void mptcp_rcv_synsent_fastopen(struct sock *meta_sk)
+{
+	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
+	struct tcp_sock *master_tp =3D tcp_sk(meta_tp->mpcb->master_sk);
+	struct sk_buff *skb;
+	u32 new_mapping =3D meta_tp->write_seq - master_tp->snd_una;
+
+	/* There should only be one skb in write queue: the data not
+	 * acknowledged in the SYN+ACK. In this case, we need to map
+	 * this data to data sequence numbers.
+	 */
+	skb_queue_walk(&meta_sk->sk_write_queue, skb) {
+		/* If the server only acknowledges partially the data sent in
+		 * the SYN, we need to trim the acknowledged part because
+		 * we don't want to retransmit this already received data.
+		 * When we reach this point, tcp_ack() has already cleaned up
+		 * fully acked segments. However, tcp trims partially acked
+		 * segments only when retransmitting. Since MPTCP comes into
+		 * play only now, we will fake an initial transmit, and
+		 * retransmit_skb() will not be called. The following fragment
+		 * comes from __tcp_retransmit_skb().
+		 */
+		if (before(TCP_SKB_CB(skb)->seq, master_tp->snd_una)) {
+			BUG_ON(before(TCP_SKB_CB(skb)->end_seq,
+				      master_tp->snd_una));
+			/* tcp_trim_head can only returns ENOMEM if skb is
+			 * cloned. It is not the case here (see
+			 * tcp_send_syn_data).
+			 */
+			BUG_ON(meta_tp->op_ops->trim_head(meta_sk, skb,
+							  master_tp->snd_una -
+							  TCP_SKB_CB(skb)->seq));
+		}
+
+		TCP_SKB_CB(skb)->seq +=3D new_mapping;
+		TCP_SKB_CB(skb)->end_seq +=3D new_mapping;
+	}
+
+	/* We can advance write_seq by the number of bytes unacknowledged
+	 * and that were mapped in the previous loop.
+	 */
+	meta_tp->write_seq +=3D master_tp->write_seq - master_tp->snd_una;
+
+	/* The packets from the master_sk will be entailed to it later
+	 * Until that time, its write queue is empty, and
+	 * write_seq must align with snd_una
+	 */
+	master_tp->snd_nxt =3D master_tp->write_seq =3D master_tp->snd_una;
+	master_tp->packets_out =3D 0;
+
+	/* Although these data have been sent already over the subsk,
+	 * They have never been sent over the meta_sk, so we rewind
+	 * the send_head so that tcp considers it as an initial send
+	 * (instead of retransmit).
+	 */
+	meta_sk->sk_send_head =3D tcp_write_queue_head(meta_sk);
+}
+
+/* The skptr is needed, because if we become MPTCP-capable, we have to swi=
tch
+ * from meta-socket to master-socket.
+ *
+ * @return: 1 - we want to reset this connection
+ *	    2 - we want to discard the received syn/ack
+ *	    0 - everything is fine - continue
+ */
+static int __mptcp_rcv_synsent_state_process(struct sock *sk,
+					     struct sock **skptr,
+					     struct sk_buff *skb)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct mptcp_options_received mopt;
+
+	mptcp_init_mp_opt(&mopt);
+	tcp_parse_mptcp_options(skb, &mopt);
+
+	/* This is the case of a join ? */
+	if (mptcp(tp)) {
+		u8 hash_mac_check[20];
+		struct mptcp_cb *mpcb =3D tp->mpcb;
+
+		mptcp_hmac_sha1((u8 *)&mpcb->mptcp_rem_key,
+				(u8 *)&mpcb->mptcp_loc_key,
+				(u32 *)hash_mac_check, 2,
+				4, (u8 *)&mopt.mptcp_recv_nonce,
+				4, (u8 *)&tp->mptcp->mptcp_loc_nonce);
+		if (memcmp(hash_mac_check,
+			   (char *)&mopt.mptcp_recv_tmac, 8)) {
+			MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_JOINSYNACKMAC);
+			mptcp_sub_force_close(sk);
+			return 1;
+		}
+
+		/* Set this flag in order to postpone data sending
+		 * until the 4th ack arrives.
+		 */
+		tp->mptcp->pre_established =3D 1;
+		tp->mptcp->rcv_low_prio =3D mopt.low_prio;
+
+		mptcp_hmac_sha1((u8 *)&mpcb->mptcp_loc_key,
+				(u8 *)&mpcb->mptcp_rem_key,
+				(u32 *)&tp->mptcp->sender_mac[0], 2,
+				4, (u8 *)&tp->mptcp->mptcp_loc_nonce,
+				4, (u8 *)&mopt.mptcp_recv_nonce);
+
+		MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_JOINSYNACKRX);
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
+
+			/* -1, because the SYN consumed 1 byte. In case of TFO,
+			 * we start the subflow-sequence number as if the data
+			 * of the SYN is not part of any mapping.
+			 */
+			tp->mptcp->snt_isn =3D tp->snd_una;
+			tp->mpcb->dss_csum =3D mopt.dss_csum;
+			if (tp->mpcb->dss_csum)
+				MPTCP_INC_STATS_BH(sock_net(sk),
+						   MPTCP_MIB_CSUMENABLED);
+
+			tp->mptcp->include_mpc =3D 1;
+
+			/* Ensure that fastopen is handled at the meta-level. */
+			tp->fastopen_req =3D NULL;
+
+			sk_set_socket(sk, mptcp_meta_sk(sk)->sk_socket);
+			sk->sk_wq =3D mptcp_meta_sk(sk)->sk_wq;
+
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
+
+			if (tp->inside_tk_table)
+				mptcp_hash_remove(tp);
+		}
+	}
+
+	if (mptcp(tp))
+		tp->mptcp->rcv_isn =3D TCP_SKB_CB(skb)->seq;
+
+	*skptr =3D sk;
+	return 0;
+}
+
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
+
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
+
+	if (is_meta_sk(sk)) {
+		sk =3D tcp_sk(sk)->mpcb->master_sk;
+		tp =3D tcp_sk(sk);
+		/* Need to call it here, because it will announce new
+		 * addresses, which can only be done after the third ack
+		 * of the 3-way handshake.
+		 */
+		mptcp_update_metasocket(sk, tp->meta_sk);
+	}
+
+	if (queued >=3D 0)
+		return queued;
+
+	/* Do step6 onward by hand. */
+	tp->op_ops->urg(sk, skb, th);
+	__kfree_skb(skb);
+
+	if (mptcp(tp))
+		mptcp_push_pending_frames(mptcp_meta_sk(sk));
+	else
+		tcp_data_snd_check(sk);
+
+	if (mptcp(tp) && is_master_tp(tp))
+		bh_unlock_sock(sk);
+	return 0;
+}
+
+/* Similar to tcp_should_expand_sndbuf */
+bool mptcp_should_expand_sndbuf(const struct sock *sk)
+{
+	const struct sock *sk_it;
+	const struct sock *meta_sk =3D mptcp_meta_sk(sk);
+	const struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
+	int cnt_backups =3D 0;
+	int backup_available =3D 0;
+
+	/* We circumvent this check in tcp_check_space, because we want to
+	 * always call sk_write_space. So, we reproduce the check here.
+	 */
+	if (!meta_sk->sk_socket ||
+	    !test_bit(SOCK_NOSPACE, &meta_sk->sk_socket->flags))
+		return false;
+
+	/* If the user specified a specific send buffer setting, do
+	 * not modify it.
+	 */
+	if (meta_sk->sk_userlocks & SOCK_SNDBUF_LOCK)
+		return false;
+
+	/* If we are under global TCP memory pressure, do not expand.  */
+	if (sk_under_memory_pressure(meta_sk))
+		return false;
+
+	/* If we are under soft global TCP memory pressure, do not expand.  */
+	if (sk_memory_allocated(meta_sk) >=3D sk_prot_mem_limits(meta_sk, 0))
+		return false;
+
+	/* For MPTCP we look for a subsocket that could send data.
+	 * If we found one, then we update the send-buffer.
+	 */
+	mptcp_for_each_sk(meta_tp->mpcb, sk_it) {
+		struct tcp_sock *tp_it =3D tcp_sk(sk_it);
+
+		if (!mptcp_sk_can_send(sk_it))
+			continue;
+
+		/* Backup-flows have to be counted - if there is no other
+		 * subflow we take the backup-flow into account.
+		 */
+		if (tp_it->mptcp->rcv_low_prio || tp_it->mptcp->low_prio)
+			cnt_backups++;
+
+		if (tcp_packets_in_flight(tp_it) < tp_it->snd_cwnd) {
+			if (tp_it->mptcp->rcv_low_prio ||
+			    tp_it->mptcp->low_prio) {
+				backup_available =3D 1;
+				continue;
+			}
+			return true;
+		}
+	}
+
+	/* Backup-flow is available for sending - update send-buffer */
+	if (meta_tp->mpcb->cnt_established =3D=3D cnt_backups && backup_available)
+		return true;
+	return false;
+}
+
+void mptcp_init_buffer_space(struct sock *sk)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct sock *meta_sk =3D mptcp_meta_sk(sk);
+	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
+	struct net *net =3D sock_net(meta_sk);
+	int space;
+
+	tcp_init_buffer_space(sk);
+
+	if (is_master_tp(tp)) {
+		meta_tp->rcvq_space.space =3D meta_tp->rcv_wnd;
+		meta_tp->rcvq_space.time =3D tcp_jiffies32;
+		meta_tp->rcvq_space.seq =3D meta_tp->copied_seq;
+
+		/* If there is only one subflow, we just use regular TCP
+		 * autotuning. User-locks are handled already by
+		 * tcp_init_buffer_space
+		 */
+		meta_tp->window_clamp =3D tp->window_clamp;
+		meta_tp->rcv_ssthresh =3D tp->rcv_ssthresh;
+		meta_sk->sk_rcvbuf =3D sk->sk_rcvbuf;
+		meta_sk->sk_sndbuf =3D sk->sk_sndbuf;
+
+		return;
+	}
+
+	if (meta_sk->sk_userlocks & SOCK_RCVBUF_LOCK)
+		goto snd_buf;
+
+	/* Adding a new subflow to the rcv-buffer space. We make a simple
+	 * addition, to give some space to allow traffic on the new subflow.
+	 * Autotuning will increase it further later on.
+	 */
+	space =3D min(meta_sk->sk_rcvbuf + sk->sk_rcvbuf,
+		    net->ipv4.sysctl_tcp_rmem[2]);
+	if (space > meta_sk->sk_rcvbuf) {
+		meta_tp->window_clamp +=3D tp->window_clamp;
+		meta_tp->rcv_ssthresh +=3D tp->rcv_ssthresh;
+		meta_sk->sk_rcvbuf =3D space;
+	}
+
+snd_buf:
+	if (meta_sk->sk_userlocks & SOCK_SNDBUF_LOCK)
+		return;
+
+	/* Adding a new subflow to the send-buffer space. We make a simple
+	 * addition, to give some space to allow traffic on the new subflow.
+	 * Autotuning will increase it further later on.
+	 */
+	space =3D min(meta_sk->sk_sndbuf + sk->sk_sndbuf,
+		    net->ipv4.sysctl_tcp_wmem[2]);
+	if (space > meta_sk->sk_sndbuf) {
+		meta_sk->sk_sndbuf =3D space;
+		meta_sk->sk_write_space(meta_sk);
+	}
+}
+
+void mptcp_tcp_set_rto(struct sock *sk)
+{
+	tcp_set_rto(sk);
+	mptcp_set_rto(sk);
+}
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
new file mode 100644
index 0000000..a0cded5
--- /dev/null
+++ b/net/mptcp/mptcp_ipv4.c
@@ -0,0 +1,345 @@
+/*
+ *	MPTCP implementation - IPv4-specific functions
+ *
+ *	Initial Design & Implementation:
+ *	S=C3=A9bastien Barr=C3=A9 <sebastien.barre(a)uclouvain.be>
+ *
+ *	Current Maintainer:
+ *	Christoph Paasch <christoph.paasch(a)uclouvain.be>
+ *
+ *	Additional authors:
+ *	Jaakko Korkeaniemi <jaakko.korkeaniemi(a)aalto.fi>
+ *	Gregory Detal <gregory.detal(a)uclouvain.be>
+ *	Fabien Duch=C3=AAne <fabien.duchene(a)uclouvain.be>
+ *	Andreas Seelinger <Andreas.Seelinger(a)rwth-aachen.de>
+ *	Lavkesh Lahngir <lavkesh51(a)gmail.com>
+ *	Andreas Ripke <ripke(a)neclab.eu>
+ *	Vlad Dogaru <vlad.dogaru(a)intel.com>
+ *	Octavian Purdila <octavian.purdila(a)intel.com>
+ *	John Ronan <jronan(a)tssg.org>
+ *	Catalin Nicutar <catalin.nicutar(a)gmail.com>
+ *	Brandon Heller <brandonh(a)stanford.edu>
+ *
+ *
+ *	This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/export.h>
+#include <linux/siphash.h>
+#include <linux/ip.h>
+#include <linux/list.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+#include <linux/tcp.h>
+
+#include <net/inet_common.h>
+#include <net/inet_connection_sock.h>
+#include <net/mptcp.h>
+#include <net/mptcp_v4.h>
+#include <net/request_sock.h>
+#include <net/tcp.h>
+#include <net/secure_seq.h>
+
+static void mptcp_v4_init_req(struct request_sock *req,
+			      const struct sock *sk_listener,
+			      struct sk_buff *skb)
+{
+	struct mptcp_options_received mopt;
+
+	tcp_request_sock_ipv4_ops.init_req(req, sk_listener, skb);
+
+	inet_rsk(req)->mptcp_rqsk =3D 1;
+	mptcp_init_mp_opt(&mopt);
+	tcp_parse_mptcp_options(skb, &mopt);
+	/* In case of SYN-cookies, the entry in the hash will be deleted
+	 * when the request socket is freed.
+	 */
+	mptcp_reqsk_init(req, sk_listener, skb, &mopt);
+}
+
+#ifdef CONFIG_SYN_COOKIES
+static u32 mptcp_v4_cookie_init_seq(const struct sk_buff *skb, __u16 *mssp)
+{
+	return cookie_v4_init_sequence(skb, mssp);
+}
+#endif
+
+static void mptcp_v4_join_init_req(struct request_sock *req,
+				   const struct sock *sk,
+				   struct sk_buff *skb)
+{
+	struct mptcp_request_sock *mtreq =3D mptcp_rsk(req);
+	struct mptcp_cb *mpcb =3D tcp_sk(sk)->mpcb;
+	union inet_addr addr;
+	int loc_id;
+	bool low_prio =3D false;
+
+	/* We need to do this as early as possible. Because, if we fail later
+	 * (e.g., get_local_id), then reqsk_free tries to remove the
+	 * request-socket from the htb in mptcp_hash_request_remove as pprev
+	 * may be different from NULL.
+	 */
+	mtreq->hash_entry.pprev =3D NULL;
+
+	tcp_request_sock_ipv4_ops.init_req(req, sk, skb);
+
+	mtreq->mptcp_loc_nonce =3D mptcp_v4_get_nonce(ip_hdr(skb)->saddr,
+						    ip_hdr(skb)->daddr,
+						    tcp_hdr(skb)->source,
+						    tcp_hdr(skb)->dest);
+	addr.ip =3D inet_rsk(req)->ir_loc_addr;
+	loc_id =3D mpcb->pm_ops->get_local_id(AF_INET, &addr,
+					    sock_net(sk), &low_prio);
+	mtreq->loc_id =3D loc_id =3D=3D -1 ? 0 : loc_id;
+	mtreq->low_prio =3D low_prio;
+
+	mptcp_join_reqsk_init(mpcb, req, skb);
+}
+
+/* Similar to tcp_request_sock_ops */
+struct request_sock_ops mptcp_request_sock_ops __read_mostly =3D {
+	.family		=3D	PF_INET,
+	.obj_size	=3D	sizeof(struct mptcp_request_sock),
+	.rtx_syn_ack	=3D	tcp_rtx_synack,
+	.send_ack	=3D	tcp_v4_reqsk_send_ack,
+	.destructor	=3D	tcp_v4_reqsk_destructor,
+	.send_reset	=3D	tcp_v4_send_reset,
+	.syn_ack_timeout =3D	tcp_syn_ack_timeout,
+};
+
+/* Similar to tcp_v4_conn_request */
+static int mptcp_v4_join_request(struct sock *meta_sk, struct sk_buff *skb)
+{
+	return tcp_conn_request(&mptcp_request_sock_ops,
+				&mptcp_join_request_sock_ipv4_ops,
+				meta_sk, skb);
+}
+
+/* We only process join requests here. (either the SYN or the final ACK) */
+int mptcp_process_join_req(struct sock *meta_sk, struct sk_buff *skb)
+{
+	const struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
+	struct sock *child, *rsk =3D NULL;
+	int ret;
+
+	/* Has been removed from the tk-table. Thus, no new subflows.
+	 *
+	 * Check for close-state is necessary, because we may have been closed
+	 * without passing by mptcp_close().
+	 *
+	 * When falling back, no new subflows are allowed either.
+	 */
+	if (meta_sk->sk_state =3D=3D TCP_CLOSE ||
+	    !tcp_sk(meta_sk)->inside_tk_table ||
+	    mpcb->infinite_mapping_rcv || mpcb->send_infinite_mapping)
+		goto reset_and_discard;
+
+	if (meta_sk->sk_family =3D=3D AF_INET)
+		child =3D tcp_v4_cookie_check(meta_sk, skb);
+	else
+		child =3D tcp_v6_cookie_check(meta_sk, skb);
+
+	if (!child)
+		goto discard;
+
+	if (child !=3D meta_sk) {
+		sock_rps_save_rxhash(child, skb);
+		/* We don't call tcp_child_process here, because we hold
+		 * already the meta-sk-lock and are sure that it is not owned
+		 * by the user.
+		 */
+		ret =3D tcp_rcv_state_process(child, skb);
+		bh_unlock_sock(child);
+		sock_put(child);
+		if (ret) {
+			rsk =3D child;
+			goto reset_and_discard;
+		}
+	} else {
+		if (tcp_hdr(skb)->syn) {
+			if (meta_sk->sk_family =3D=3D AF_INET)
+				mptcp_v4_join_request(meta_sk, skb);
+			else
+				mptcp_v6_join_request(meta_sk, skb);
+			goto discard;
+		}
+		goto reset_and_discard;
+	}
+	return 0;
+
+reset_and_discard:
+	tcp_v4_send_reset(rsk, skb);
+discard:
+	kfree_skb(skb);
+	return 0;
+}
+
+/* Create a new IPv4 subflow.
+ *
+ * We are in user-context and meta-sock-lock is hold.
+ */
+int mptcp_init4_subsockets(struct sock *meta_sk, const struct mptcp_loc4 *=
loc,
+			   struct mptcp_rem4 *rem)
+{
+	struct tcp_sock *tp;
+	struct sock *sk;
+	struct sockaddr_in loc_in, rem_in;
+	struct socket_alloc sock_full;
+	struct socket *sock =3D (struct socket *)&sock_full;
+	int ret;
+
+	/** First, create and prepare the new socket */
+	memcpy(&sock_full, meta_sk->sk_socket, sizeof(sock_full));
+	sock->state =3D SS_UNCONNECTED;
+	sock->ops =3D NULL;
+
+	ret =3D inet_create(sock_net(meta_sk), sock, IPPROTO_TCP, 1);
+	if (unlikely(ret < 0)) {
+		mptcp_debug("%s inet_create failed ret: %d\n", __func__, ret);
+		return ret;
+	}
+
+	sk =3D sock->sk;
+	tp =3D tcp_sk(sk);
+
+	/* All subsockets need the MPTCP-lock-class */
+	lockdep_set_class_and_name(&(sk)->sk_lock.slock,
+				   &meta_slock_key, meta_slock_key_name);
+	lockdep_init_map(&(sk)->sk_lock.dep_map, meta_key_name, &meta_key, 0);
+
+	if (mptcp_add_sock(meta_sk, sk, loc->loc4_id, rem->rem4_id, GFP_KERNEL))
+		goto error;
+
+	tp->mptcp->slave_sk =3D 1;
+	tp->mptcp->low_prio =3D loc->low_prio;
+
+	/* Initializing the timer for an MPTCP subflow */
+	timer_setup(&tp->mptcp->mptcp_ack_timer, mptcp_ack_handler, 0);
+
+	/** Then, connect the socket to the peer */
+	loc_in.sin_family =3D AF_INET;
+	rem_in.sin_family =3D AF_INET;
+	loc_in.sin_port =3D 0;
+	if (rem->port)
+		rem_in.sin_port =3D rem->port;
+	else
+		rem_in.sin_port =3D inet_sk(meta_sk)->inet_dport;
+	loc_in.sin_addr =3D loc->addr;
+	rem_in.sin_addr =3D rem->addr;
+
+	if (loc->if_idx)
+		sk->sk_bound_dev_if =3D loc->if_idx;
+
+	ret =3D sock->ops->bind(sock, (struct sockaddr *)&loc_in,
+			      sizeof(struct sockaddr_in));
+	if (ret < 0) {
+		mptcp_debug("%s: MPTCP subsocket bind() failed, error %d\n",
+			    __func__, ret);
+		goto error;
+	}
+
+	mptcp_debug("%s: token %#x pi %d src_addr:%pI4:%d dst_addr:%pI4:%d ifidx:=
 %d\n",
+		    __func__, tcp_sk(meta_sk)->mpcb->mptcp_loc_token,
+		    tp->mptcp->path_index, &loc_in.sin_addr,
+		    ntohs(loc_in.sin_port), &rem_in.sin_addr,
+		    ntohs(rem_in.sin_port), loc->if_idx);
+
+	if (tcp_sk(meta_sk)->mpcb->pm_ops->init_subsocket_v4)
+		tcp_sk(meta_sk)->mpcb->pm_ops->init_subsocket_v4(sk, rem->addr);
+
+	ret =3D sock->ops->connect(sock, (struct sockaddr *)&rem_in,
+				 sizeof(struct sockaddr_in), O_NONBLOCK);
+	if (ret < 0 && ret !=3D -EINPROGRESS) {
+		mptcp_debug("%s: MPTCP subsocket connect() failed, error %d\n",
+			    __func__, ret);
+		goto error;
+	}
+
+	MPTCP_INC_STATS(sock_net(meta_sk), MPTCP_MIB_JOINSYNTX);
+
+	sk_set_socket(sk, meta_sk->sk_socket);
+	sk->sk_wq =3D meta_sk->sk_wq;
+
+	return 0;
+
+error:
+	/* May happen if mptcp_add_sock fails first */
+	if (!mptcp(tp)) {
+		tcp_close(sk, 0);
+	} else {
+		local_bh_disable();
+		mptcp_sub_force_close(sk);
+		local_bh_enable();
+	}
+	return ret;
+}
+EXPORT_SYMBOL(mptcp_init4_subsockets);
+
+const struct inet_connection_sock_af_ops mptcp_v4_specific =3D {
+	.queue_xmit	   =3D ip_queue_xmit,
+	.send_check	   =3D tcp_v4_send_check,
+	.rebuild_header	   =3D inet_sk_rebuild_header,
+	.sk_rx_dst_set	   =3D inet_sk_rx_dst_set,
+	.conn_request	   =3D mptcp_conn_request,
+	.syn_recv_sock	   =3D mptcp_v4_syn_recv_sock,
+	.net_header_len	   =3D sizeof(struct iphdr),
+	.setsockopt	   =3D ip_setsockopt,
+	.getsockopt	   =3D ip_getsockopt,
+	.addr2sockaddr	   =3D inet_csk_addr2sockaddr,
+	.sockaddr_len	   =3D sizeof(struct sockaddr_in),
+#ifdef CONFIG_COMPAT
+	.compat_setsockopt =3D compat_ip_setsockopt,
+	.compat_getsockopt =3D compat_ip_getsockopt,
+#endif
+	.mtu_reduced	   =3D tcp_v4_mtu_reduced,
+};
+
+struct tcp_request_sock_ops mptcp_request_sock_ipv4_ops;
+struct tcp_request_sock_ops mptcp_join_request_sock_ipv4_ops;
+
+/* General initialization of IPv4 for MPTCP */
+int mptcp_pm_v4_init(void)
+{
+	int ret =3D 0;
+	struct request_sock_ops *ops =3D &mptcp_request_sock_ops;
+
+	mptcp_request_sock_ipv4_ops =3D tcp_request_sock_ipv4_ops;
+	mptcp_request_sock_ipv4_ops.init_req =3D mptcp_v4_init_req;
+#ifdef CONFIG_SYN_COOKIES
+	mptcp_request_sock_ipv4_ops.cookie_init_seq =3D mptcp_v4_cookie_init_seq;
+#endif
+	mptcp_join_request_sock_ipv4_ops =3D tcp_request_sock_ipv4_ops;
+	mptcp_join_request_sock_ipv4_ops.init_req =3D mptcp_v4_join_init_req;
+
+	ops->slab_name =3D kasprintf(GFP_KERNEL, "request_sock_%s", "MPTCP");
+	if (!ops->slab_name) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
+
+	ops->slab =3D kmem_cache_create(ops->slab_name, ops->obj_size, 0,
+				      SLAB_TYPESAFE_BY_RCU | SLAB_HWCACHE_ALIGN,
+				      NULL);
+
+	if (!ops->slab) {
+		ret =3D  -ENOMEM;
+		goto err_reqsk_create;
+	}
+
+out:
+	return ret;
+
+err_reqsk_create:
+	kfree(ops->slab_name);
+	ops->slab_name =3D NULL;
+	goto out;
+}
+
+void mptcp_pm_v4_undo(void)
+{
+	kmem_cache_destroy(mptcp_request_sock_ops.slab);
+	kfree(mptcp_request_sock_ops.slab_name);
+}
diff --git a/net/mptcp/mptcp_ipv6.c b/net/mptcp/mptcp_ipv6.c
new file mode 100644
index 0000000..e88b5b9
--- /dev/null
+++ b/net/mptcp/mptcp_ipv6.c
@@ -0,0 +1,316 @@
+/*
+ *	MPTCP implementation - IPv6-specific functions
+ *
+ *	Initial Design & Implementation:
+ *	S=C3=A9bastien Barr=C3=A9 <sebastien.barre(a)uclouvain.be>
+ *
+ *	Current Maintainer:
+ *	Jaakko Korkeaniemi <jaakko.korkeaniemi(a)aalto.fi>
+ *
+ *	Additional authors:
+ *	Jaakko Korkeaniemi <jaakko.korkeaniemi(a)aalto.fi>
+ *	Gregory Detal <gregory.detal(a)uclouvain.be>
+ *	Fabien Duch=C3=AAne <fabien.duchene(a)uclouvain.be>
+ *	Andreas Seelinger <Andreas.Seelinger(a)rwth-aachen.de>
+ *	Lavkesh Lahngir <lavkesh51(a)gmail.com>
+ *	Andreas Ripke <ripke(a)neclab.eu>
+ *	Vlad Dogaru <vlad.dogaru(a)intel.com>
+ *	Octavian Purdila <octavian.purdila(a)intel.com>
+ *	John Ronan <jronan(a)tssg.org>
+ *	Catalin Nicutar <catalin.nicutar(a)gmail.com>
+ *	Brandon Heller <brandonh(a)stanford.edu>
+ *
+ *
+ *	This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/export.h>
+#include <linux/in6.h>
+#include <linux/kernel.h>
+
+#include <net/addrconf.h>
+#include <net/flow.h>
+#include <net/inet6_connection_sock.h>
+#include <net/inet6_hashtables.h>
+#include <net/inet_common.h>
+#include <net/ipv6.h>
+#include <net/ip6_checksum.h>
+#include <net/ip6_route.h>
+#include <net/mptcp.h>
+#include <net/mptcp_v6.h>
+#include <net/tcp.h>
+#include <net/transp_v6.h>
+#include <net/secure_seq.h>
+
+static void mptcp_v6_reqsk_destructor(struct request_sock *req)
+{
+	mptcp_reqsk_destructor(req);
+
+	tcp_v6_reqsk_destructor(req);
+}
+
+static void mptcp_v6_init_req(struct request_sock *req,
+			      const struct sock *sk_listener,
+			      struct sk_buff *skb)
+{
+	struct mptcp_options_received mopt;
+
+	tcp_request_sock_ipv6_ops.init_req(req, sk_listener, skb);
+
+	mptcp_init_mp_opt(&mopt);
+	inet_rsk(req)->mptcp_rqsk =3D 1;
+	tcp_parse_mptcp_options(skb, &mopt);
+	if (mopt.saw_mpc) {
+		/* In case of SYN-cookies, the entry in the hash will be deleted
+		 * when the request socket is freed.
+		 */
+		mptcp_reqsk_init(req, sk_listener, skb, &mopt);
+	}
+}
+
+#ifdef CONFIG_SYN_COOKIES
+static u32 mptcp_v6_cookie_init_seq(const struct sk_buff *skb, __u16 *mssp)
+{
+	return cookie_v6_init_sequence(skb, mssp);
+}
+#endif
+
+static void mptcp_v6_join_init_req(struct request_sock *req,
+				   const struct sock *sk, struct sk_buff *skb)
+{
+	struct mptcp_request_sock *mtreq =3D mptcp_rsk(req);
+	struct mptcp_cb *mpcb =3D tcp_sk(sk)->mpcb;
+	union inet_addr addr;
+	int loc_id;
+	bool low_prio =3D false;
+
+	/* We need to do this as early as possible. Because, if we fail later
+	 * (e.g., get_local_id), then reqsk_free tries to remove the
+	 * request-socket from the htb in mptcp_hash_request_remove as pprev
+	 * may be different from NULL.
+	 */
+	mtreq->hash_entry.pprev =3D NULL;
+
+	tcp_request_sock_ipv6_ops.init_req(req, sk, skb);
+
+	mtreq->mptcp_loc_nonce =3D
+		mptcp_v6_get_nonce(ipv6_hdr(skb)->saddr.s6_addr32,
+				   ipv6_hdr(skb)->daddr.s6_addr32,
+				   tcp_hdr(skb)->source, tcp_hdr(skb)->dest);
+	addr.in6 =3D inet_rsk(req)->ir_v6_loc_addr;
+	loc_id =3D mpcb->pm_ops->get_local_id(AF_INET6, &addr, sock_net(sk),
+					    &low_prio);
+	if (loc_id =3D=3D -1)
+		return;
+	mtreq->loc_id =3D loc_id;
+	mtreq->low_prio =3D low_prio;
+
+	mptcp_join_reqsk_init(mpcb, req, skb);
+}
+
+/* Similar to tcp6_request_sock_ops */
+struct request_sock_ops mptcp6_request_sock_ops __read_mostly =3D {
+	.family		=3D	AF_INET6,
+	.obj_size	=3D	sizeof(struct mptcp_request_sock),
+	.rtx_syn_ack	=3D	tcp_rtx_synack,
+	.send_ack	=3D	tcp_v6_reqsk_send_ack,
+	.destructor	=3D	mptcp_v6_reqsk_destructor,
+	.send_reset	=3D	tcp_v6_send_reset,
+	.syn_ack_timeout =3D	tcp_syn_ack_timeout,
+};
+
+int mptcp_v6_join_request(struct sock *meta_sk, struct sk_buff *skb)
+{
+	return tcp_conn_request(&mptcp6_request_sock_ops,
+				&mptcp_join_request_sock_ipv6_ops,
+				meta_sk, skb);
+}
+
+/* Create a new IPv6 subflow.
+ *
+ * We are in user-context and meta-sock-lock is hold.
+ */
+int mptcp_init6_subsockets(struct sock *meta_sk, const struct mptcp_loc6 *=
loc,
+			   struct mptcp_rem6 *rem)
+{
+	struct tcp_sock *tp;
+	struct sock *sk;
+	struct sockaddr_in6 loc_in, rem_in;
+	struct socket_alloc sock_full;
+	struct socket *sock =3D (struct socket *)&sock_full;
+	int ret;
+
+	/** First, create and prepare the new socket */
+	memcpy(&sock_full, meta_sk->sk_socket, sizeof(sock_full));
+	sock->state =3D SS_UNCONNECTED;
+	sock->ops =3D NULL;
+
+	ret =3D inet6_create(sock_net(meta_sk), sock, IPPROTO_TCP, 1);
+	if (unlikely(ret < 0)) {
+		mptcp_debug("%s inet6_create failed ret: %d\n", __func__, ret);
+		return ret;
+	}
+
+	sk =3D sock->sk;
+	tp =3D tcp_sk(sk);
+
+	/* All subsockets need the MPTCP-lock-class */
+	lockdep_set_class_and_name(&(sk)->sk_lock.slock, &meta_slock_key,
+				   meta_slock_key_name);
+	lockdep_init_map(&(sk)->sk_lock.dep_map, meta_key_name, &meta_key, 0);
+
+	if (mptcp_add_sock(meta_sk, sk, loc->loc6_id, rem->rem6_id, GFP_KERNEL))
+		goto error;
+
+	tp->mptcp->slave_sk =3D 1;
+	tp->mptcp->low_prio =3D loc->low_prio;
+
+	/* Initializing the timer for an MPTCP subflow */
+	timer_setup(&tp->mptcp->mptcp_ack_timer, mptcp_ack_handler, 0);
+
+	/** Then, connect the socket to the peer */
+	loc_in.sin6_family =3D AF_INET6;
+	rem_in.sin6_family =3D AF_INET6;
+	loc_in.sin6_port =3D 0;
+	if (rem->port)
+		rem_in.sin6_port =3D rem->port;
+	else
+		rem_in.sin6_port =3D inet_sk(meta_sk)->inet_dport;
+	loc_in.sin6_addr =3D loc->addr;
+	rem_in.sin6_addr =3D rem->addr;
+
+	if (loc->if_idx)
+		sk->sk_bound_dev_if =3D loc->if_idx;
+
+	ret =3D sock->ops->bind(sock, (struct sockaddr *)&loc_in,
+			      sizeof(struct sockaddr_in6));
+	if (ret < 0) {
+		mptcp_debug("%s: MPTCP subsocket bind()failed, error %d\n",
+			    __func__, ret);
+		goto error;
+	}
+
+	mptcp_debug("%s: token %#x pi %d src_addr:%pI6:%d dst_addr:%pI6:%d ifidx:=
 %u\n",
+		    __func__, tcp_sk(meta_sk)->mpcb->mptcp_loc_token,
+		    tp->mptcp->path_index, &loc_in.sin6_addr,
+		    ntohs(loc_in.sin6_port), &rem_in.sin6_addr,
+		    ntohs(rem_in.sin6_port), loc->if_idx);
+
+	if (tcp_sk(meta_sk)->mpcb->pm_ops->init_subsocket_v6)
+		tcp_sk(meta_sk)->mpcb->pm_ops->init_subsocket_v6(sk, rem->addr);
+
+	ret =3D sock->ops->connect(sock, (struct sockaddr *)&rem_in,
+				 sizeof(struct sockaddr_in6), O_NONBLOCK);
+	if (ret < 0 && ret !=3D -EINPROGRESS) {
+		mptcp_debug("%s: MPTCP subsocket connect() failed, error %d\n",
+			    __func__, ret);
+		goto error;
+	}
+
+	MPTCP_INC_STATS(sock_net(meta_sk), MPTCP_MIB_JOINSYNTX);
+
+	sk_set_socket(sk, meta_sk->sk_socket);
+	sk->sk_wq =3D meta_sk->sk_wq;
+
+	return 0;
+
+error:
+	/* May happen if mptcp_add_sock fails first */
+	if (!mptcp(tp)) {
+		tcp_close(sk, 0);
+	} else {
+		local_bh_disable();
+		mptcp_sub_force_close(sk);
+		local_bh_enable();
+	}
+	return ret;
+}
+EXPORT_SYMBOL(mptcp_init6_subsockets);
+
+const struct inet_connection_sock_af_ops mptcp_v6_specific =3D {
+	.queue_xmit	   =3D inet6_csk_xmit,
+	.send_check	   =3D tcp_v6_send_check,
+	.rebuild_header	   =3D inet6_sk_rebuild_header,
+	.sk_rx_dst_set	   =3D inet6_sk_rx_dst_set,
+	.conn_request	   =3D mptcp_conn_request,
+	.syn_recv_sock	   =3D mptcp_v4_syn_recv_sock,
+	.net_header_len	   =3D sizeof(struct ipv6hdr),
+	.net_frag_header_len =3D sizeof(struct frag_hdr),
+	.setsockopt	   =3D ipv6_setsockopt,
+	.getsockopt	   =3D ipv6_getsockopt,
+	.addr2sockaddr	   =3D inet6_csk_addr2sockaddr,
+	.sockaddr_len	   =3D sizeof(struct sockaddr_in6),
+#ifdef CONFIG_COMPAT
+	.compat_setsockopt =3D compat_ipv6_setsockopt,
+	.compat_getsockopt =3D compat_ipv6_getsockopt,
+#endif
+	.mtu_reduced	   =3D tcp_v6_mtu_reduced,
+};
+
+const struct inet_connection_sock_af_ops mptcp_v6_mapped =3D {
+	.queue_xmit	   =3D ip_queue_xmit,
+	.send_check	   =3D tcp_v4_send_check,
+	.rebuild_header	   =3D inet_sk_rebuild_header,
+	.sk_rx_dst_set	   =3D inet_sk_rx_dst_set,
+	.conn_request	   =3D mptcp_conn_request,
+	.syn_recv_sock	   =3D mptcp_v4_syn_recv_sock,
+	.net_header_len	   =3D sizeof(struct iphdr),
+	.setsockopt	   =3D ipv6_setsockopt,
+	.getsockopt	   =3D ipv6_getsockopt,
+	.addr2sockaddr	   =3D inet6_csk_addr2sockaddr,
+	.sockaddr_len	   =3D sizeof(struct sockaddr_in6),
+#ifdef CONFIG_COMPAT
+	.compat_setsockopt =3D compat_ipv6_setsockopt,
+	.compat_getsockopt =3D compat_ipv6_getsockopt,
+#endif
+	.mtu_reduced	   =3D tcp_v4_mtu_reduced,
+};
+
+struct tcp_request_sock_ops mptcp_request_sock_ipv6_ops;
+struct tcp_request_sock_ops mptcp_join_request_sock_ipv6_ops;
+
+int mptcp_pm_v6_init(void)
+{
+	int ret =3D 0;
+	struct request_sock_ops *ops =3D &mptcp6_request_sock_ops;
+
+	mptcp_request_sock_ipv6_ops =3D tcp_request_sock_ipv6_ops;
+	mptcp_request_sock_ipv6_ops.init_req =3D mptcp_v6_init_req;
+#ifdef CONFIG_SYN_COOKIES
+	mptcp_request_sock_ipv6_ops.cookie_init_seq =3D mptcp_v6_cookie_init_seq;
+#endif
+
+	mptcp_join_request_sock_ipv6_ops =3D tcp_request_sock_ipv6_ops;
+	mptcp_join_request_sock_ipv6_ops.init_req =3D mptcp_v6_join_init_req;
+
+	ops->slab_name =3D kasprintf(GFP_KERNEL, "request_sock_%s", "MPTCP6");
+	if (!ops->slab_name) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
+
+	ops->slab =3D kmem_cache_create(ops->slab_name, ops->obj_size, 0,
+				      SLAB_TYPESAFE_BY_RCU | SLAB_HWCACHE_ALIGN,
+				      NULL);
+	if (!ops->slab) {
+		ret =3D  -ENOMEM;
+		goto err_reqsk_create;
+	}
+
+out:
+	return ret;
+
+err_reqsk_create:
+	kfree(ops->slab_name);
+	ops->slab_name =3D NULL;
+	goto out;
+}
+
+void mptcp_pm_v6_undo(void)
+{
+	kmem_cache_destroy(mptcp6_request_sock_ops.slab);
+	kfree(mptcp6_request_sock_ops.slab_name);
+}
diff --git a/net/mptcp/mptcp_ndiffports.c b/net/mptcp/mptcp_ndiffports.c
new file mode 100644
index 0000000..10147d5
--- /dev/null
+++ b/net/mptcp/mptcp_ndiffports.c
@@ -0,0 +1,169 @@
+#include <linux/module.h>
+
+#include <net/mptcp.h>
+#include <net/mptcp_v4.h>
+
+#if IS_ENABLED(CONFIG_IPV6)
+#include <net/mptcp_v6.h>
+#endif
+
+struct ndiffports_priv {
+	/* Worker struct for subflow establishment */
+	struct work_struct subflow_work;
+
+	struct mptcp_cb *mpcb;
+};
+
+static int num_subflows __read_mostly =3D 2;
+module_param(num_subflows, int, 0644);
+MODULE_PARM_DESC(num_subflows, "choose the number of subflows per MPTCP co=
nnection");
+
+/**
+ * Create all new subflows, by doing calls to mptcp_initX_subsockets
+ *
+ * This function uses a goto next_subflow, to allow releasing the lock bet=
ween
+ * new subflows and giving other processes a chance to do some work on the
+ * socket and potentially finishing the communication.
+ **/
+static void create_subflow_worker(struct work_struct *work)
+{
+	const struct ndiffports_priv *pm_priv =3D container_of(work,
+						     struct ndiffports_priv,
+						     subflow_work);
+	struct mptcp_cb *mpcb =3D pm_priv->mpcb;
+	struct sock *meta_sk =3D mpcb->meta_sk;
+	int iter =3D 0;
+
+next_subflow:
+	if (iter) {
+		release_sock(meta_sk);
+		mutex_unlock(&mpcb->mpcb_mutex);
+
+		cond_resched();
+	}
+	mutex_lock(&mpcb->mpcb_mutex);
+	lock_sock_nested(meta_sk, SINGLE_DEPTH_NESTING);
+
+	iter++;
+
+	if (sock_flag(meta_sk, SOCK_DEAD))
+		goto exit;
+
+	if (mpcb->master_sk &&
+	    !tcp_sk(mpcb->master_sk)->mptcp->fully_established)
+		goto exit;
+
+	if (num_subflows > iter && num_subflows > mpcb->cnt_subflows) {
+		if (meta_sk->sk_family =3D=3D AF_INET ||
+		    mptcp_v6_is_v4_mapped(meta_sk)) {
+			struct mptcp_loc4 loc;
+			struct mptcp_rem4 rem;
+
+			loc.addr.s_addr =3D inet_sk(meta_sk)->inet_saddr;
+			loc.loc4_id =3D 0;
+			loc.low_prio =3D 0;
+			if (mpcb->master_sk)
+				loc.if_idx =3D mpcb->master_sk->sk_bound_dev_if;
+			else
+				loc.if_idx =3D 0;
+
+			rem.addr.s_addr =3D inet_sk(meta_sk)->inet_daddr;
+			rem.port =3D inet_sk(meta_sk)->inet_dport;
+			rem.rem4_id =3D 0; /* Default 0 */
+
+			mptcp_init4_subsockets(meta_sk, &loc, &rem);
+		} else {
+#if IS_ENABLED(CONFIG_IPV6)
+			struct mptcp_loc6 loc;
+			struct mptcp_rem6 rem;
+
+			loc.addr =3D inet6_sk(meta_sk)->saddr;
+			loc.loc6_id =3D 0;
+			loc.low_prio =3D 0;
+			if (mpcb->master_sk)
+				loc.if_idx =3D mpcb->master_sk->sk_bound_dev_if;
+			else
+				loc.if_idx =3D 0;
+
+			rem.addr =3D meta_sk->sk_v6_daddr;
+			rem.port =3D inet_sk(meta_sk)->inet_dport;
+			rem.rem6_id =3D 0; /* Default 0 */
+
+			mptcp_init6_subsockets(meta_sk, &loc, &rem);
+#endif
+		}
+		goto next_subflow;
+	}
+
+exit:
+	release_sock(meta_sk);
+	mutex_unlock(&mpcb->mpcb_mutex);
+	sock_put(meta_sk);
+}
+
+static void ndiffports_new_session(const struct sock *meta_sk)
+{
+	struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
+	struct ndiffports_priv *fmp =3D (struct ndiffports_priv *)&mpcb->mptcp_pm=
[0];
+
+	/* Initialize workqueue-struct */
+	INIT_WORK(&fmp->subflow_work, create_subflow_worker);
+	fmp->mpcb =3D mpcb;
+}
+
+static void ndiffports_create_subflows(struct sock *meta_sk)
+{
+	const struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
+	struct ndiffports_priv *pm_priv =3D (struct ndiffports_priv *)&mpcb->mptc=
p_pm[0];
+
+	if (mpcb->infinite_mapping_snd || mpcb->infinite_mapping_rcv ||
+	    mpcb->send_infinite_mapping ||
+	    mpcb->server_side || sock_flag(meta_sk, SOCK_DEAD))
+		return;
+
+	if (!work_pending(&pm_priv->subflow_work)) {
+		sock_hold(meta_sk);
+		queue_work(mptcp_wq, &pm_priv->subflow_work);
+	}
+}
+
+static int ndiffports_get_local_id(sa_family_t family, union inet_addr *ad=
dr,
+				   struct net *net, bool *low_prio)
+{
+	return 0;
+}
+
+static struct mptcp_pm_ops ndiffports __read_mostly =3D {
+	.new_session =3D ndiffports_new_session,
+	.fully_established =3D ndiffports_create_subflows,
+	.get_local_id =3D ndiffports_get_local_id,
+	.name =3D "ndiffports",
+	.owner =3D THIS_MODULE,
+};
+
+/* General initialization of MPTCP_PM */
+static int __init ndiffports_register(void)
+{
+	BUILD_BUG_ON(sizeof(struct ndiffports_priv) > MPTCP_PM_SIZE);
+
+	if (mptcp_register_path_manager(&ndiffports))
+		goto exit;
+
+	return 0;
+
+exit:
+	return -1;
+}
+
+static void ndiffports_unregister(void)
+{
+	mptcp_unregister_path_manager(&ndiffports);
+}
+
+module_init(ndiffports_register);
+module_exit(ndiffports_unregister);
+
+MODULE_AUTHOR("Christoph Paasch");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("NDIFF-PORTS MPTCP");
+MODULE_VERSION("0.88");
diff --git a/net/mptcp/mptcp_ofo_queue.c b/net/mptcp/mptcp_ofo_queue.c
new file mode 100644
index 0000000..d795f33
--- /dev/null
+++ b/net/mptcp/mptcp_ofo_queue.c
@@ -0,0 +1,177 @@
+/*
+ *	MPTCP implementation - Fast algorithm for MPTCP meta-reordering
+ *
+ *	Initial Design & Implementation:
+ *	S=C3=A9bastien Barr=C3=A9 <sebastien.barre(a)uclouvain.be>
+ *
+ *	Current Maintainer & Author:
+ *	Christoph Paasch <christoph.paasch(a)uclouvain.be>
+ *
+ *	Additional authors:
+ *	Jaakko Korkeaniemi <jaakko.korkeaniemi(a)aalto.fi>
+ *	Gregory Detal <gregory.detal(a)uclouvain.be>
+ *	Fabien Duch=C3=AAne <fabien.duchene(a)uclouvain.be>
+ *	Andreas Seelinger <Andreas.Seelinger(a)rwth-aachen.de>
+ *	Lavkesh Lahngir <lavkesh51(a)gmail.com>
+ *	Andreas Ripke <ripke(a)neclab.eu>
+ *	Vlad Dogaru <vlad.dogaru(a)intel.com>
+ *	Octavian Purdila <octavian.purdila(a)intel.com>
+ *	John Ronan <jronan(a)tssg.org>
+ *	Catalin Nicutar <catalin.nicutar(a)gmail.com>
+ *	Brandon Heller <brandonh(a)stanford.edu>
+ *
+ *	This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/skbuff.h>
+#include <linux/slab.h>
+#include <net/tcp.h>
+#include <net/mptcp.h>
+
+void mptcp_add_meta_ofo_queue(struct sock *meta_sk, struct sk_buff *skb)
+{
+	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
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
+	}
+
+	/* In the typical case, we are adding an skb to the end of the list.
+	 * Use of ooo_last_skb avoids the O(Log(N)) rbtree lookup.
+	 */
+	if (tcp_try_coalesce(meta_sk, meta_tp->ooo_last_skb,
+			     skb, &fragstolen)) {
+coalesce_done:
+		kfree_skb_partial(skb, fragstolen);
+		skb =3D NULL;
+		goto done;
+	}
+
+	/* Can avoid an rbtree lookup if we are adding skb after ooo_last_skb */
+	if (!before(seq, TCP_SKB_CB(meta_tp->ooo_last_skb)->end_seq)) {
+		parent =3D &meta_tp->ooo_last_skb->rbnode;
+		p =3D &parent->rb_right;
+		goto insert;
+	}
+
+	/* Find place to insert this segment. Handle overlaps on the way. */
+	parent =3D NULL;
+	while (*p) {
+		parent =3D *p;
+		skb1 =3D rb_entry(parent, struct sk_buff, rbnode);
+		if (before(seq, TCP_SKB_CB(skb1)->seq)) {
+			p =3D &parent->rb_left;
+			continue;
+		}
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
+			}
+		} else if (tcp_try_coalesce(meta_sk, skb1, skb, &fragstolen)) {
+			goto coalesce_done;
+		}
+		p =3D &parent->rb_right;
+	}
+insert:
+	/* Insert segment into RB tree. */
+	rb_link_node(&skb->rbnode, parent, p);
+	rb_insert_color(&skb->rbnode, &meta_tp->out_of_order_queue);
+
+merge_right:
+	/* Remove other segments covered by skb. */
+	while ((q =3D rb_next(&skb->rbnode)) !=3D NULL) {
+		skb1 =3D rb_entry(q, struct sk_buff, rbnode);
+
+		if (!after(end_seq, TCP_SKB_CB(skb1)->seq))
+			break;
+		if (before(end_seq, TCP_SKB_CB(skb1)->end_seq)) {
+			break;
+		}
+		rb_erase(&skb1->rbnode, &meta_tp->out_of_order_queue);
+		__kfree_skb(skb1);
+	}
+	/* If there is no skb after us, we are the last_skb ! */
+	if (!q)
+		meta_tp->ooo_last_skb =3D skb;
+done:
+	return;
+}
+
+/*
+ * This one checks to see if we can put data from the
+ * out_of_order queue into the receive_queue.
+ */
+void mptcp_ofo_queue(struct sock *meta_sk)
+{
+	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
+	struct sk_buff *skb;
+	struct rb_node *p;
+
+	p =3D rb_first(&meta_tp->out_of_order_queue);
+	while (p) {
+		u32 old_rcv_nxt;
+
+		skb =3D rb_entry(p, struct sk_buff, rbnode);
+		old_rcv_nxt =3D meta_tp->rcv_nxt;
+		if (after(TCP_SKB_CB(skb)->seq, meta_tp->rcv_nxt))
+			break;
+
+		if (!after(TCP_SKB_CB(skb)->end_seq, meta_tp->rcv_nxt)) {
+			p =3D rb_next(p);
+			rb_erase(&skb->rbnode, &meta_tp->out_of_order_queue);
+#ifdef RCHK
+			mptcp_remove_shortcuts(meta_tp->mpcb, skb);
+#endif
+			__kfree_skb(skb);
+			continue;
+		}
+		p =3D rb_next(p);
+		rb_erase(&skb->rbnode, &meta_tp->out_of_order_queue);
+#ifdef RCHK
+		mptcp_remove_shortcuts(meta_tp->mpcb, skb);
+#endif
+		__skb_queue_tail(&meta_sk->sk_receive_queue, skb);
+		meta_tp->rcv_nxt =3D TCP_SKB_CB(skb)->end_seq;
+		mptcp_check_rcvseq_wrap(meta_tp, old_rcv_nxt);
+
+		if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)
+			mptcp_fin(meta_sk);
+	}
+}
+
+/* call to mptcp_remove_shortcuts prohibits use from using tcp_prune_ofo_q=
ueue */
+void mptcp_purge_ofo_queue(struct tcp_sock *meta_tp)
+{
+
+	skb_rbtree_purge(&meta_tp->out_of_order_queue);
+}
+
+bool mptcp_prune_ofo_queue(struct sock *meta_sk)
+{
+	return tcp_prune_ofo_queue(meta_sk);
+}
diff --git a/net/mptcp/mptcp_olia.c b/net/mptcp/mptcp_olia.c
new file mode 100644
index 0000000..73298b2
--- /dev/null
+++ b/net/mptcp/mptcp_olia.c
@@ -0,0 +1,309 @@
+/*
+ * MPTCP implementation - OPPORTUNISTIC LINKED INCREASES CONGESTION CONTRO=
L:
+ *
+ * Algorithm design:
+ * Ramin Khalili <ramin.khalili(a)epfl.ch>
+ * Nicolas Gast <nicolas.gast(a)epfl.ch>
+ * Jean-Yves Le Boudec <jean-yves.leboudec(a)epfl.ch>
+ *
+ * Implementation:
+ * Ramin Khalili <ramin.khalili(a)epfl.ch>
+ *
+ * Ported to the official MPTCP-kernel:
+ * Christoph Paasch <christoph.paasch(a)uclouvain.be>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+
+#include <net/tcp.h>
+#include <net/mptcp.h>
+
+#include <linux/module.h>
+
+static int scale =3D 10;
+
+struct mptcp_olia {
+	u32	mptcp_loss1;
+	u32	mptcp_loss2;
+	u32	mptcp_loss3;
+	int	epsilon_num;
+	u32	epsilon_den;
+	int	mptcp_snd_cwnd_cnt;
+};
+
+static inline int mptcp_olia_sk_can_send(const struct sock *sk)
+{
+	return mptcp_sk_can_send(sk) && tcp_sk(sk)->srtt_us;
+}
+
+static inline u64 mptcp_olia_scale(u64 val, int scale)
+{
+	return (u64) val << scale;
+}
+
+/* take care of artificially inflate (see RFC5681)
+ * of cwnd during fast-retransmit phase
+ */
+static u32 mptcp_get_crt_cwnd(struct sock *sk)
+{
+	const struct inet_connection_sock *icsk =3D inet_csk(sk);
+
+	if (icsk->icsk_ca_state =3D=3D TCP_CA_Recovery)
+		return tcp_sk(sk)->snd_ssthresh;
+	else
+		return tcp_sk(sk)->snd_cwnd;
+}
+
+/* return the dominator of the first term of  the increasing term */
+static u64 mptcp_get_rate(const struct mptcp_cb *mpcb , u32 path_rtt)
+{
+	struct sock *sk;
+	u64 rate =3D 1; /* We have to avoid a zero-rate because it is used as a d=
ivisor */
+
+	mptcp_for_each_sk(mpcb, sk) {
+		struct tcp_sock *tp =3D tcp_sk(sk);
+		u64 scaled_num;
+		u32 tmp_cwnd;
+
+		if (!mptcp_olia_sk_can_send(sk))
+			continue;
+
+		tmp_cwnd =3D mptcp_get_crt_cwnd(sk);
+		scaled_num =3D mptcp_olia_scale(tmp_cwnd, scale) * path_rtt;
+		rate +=3D div_u64(scaled_num , tp->srtt_us);
+	}
+	rate *=3D rate;
+	return rate;
+}
+
+/* find the maximum cwnd, used to find set M */
+static u32 mptcp_get_max_cwnd(const struct mptcp_cb *mpcb)
+{
+	struct sock *sk;
+	u32 best_cwnd =3D 0;
+
+	mptcp_for_each_sk(mpcb, sk) {
+		u32 tmp_cwnd;
+
+		if (!mptcp_olia_sk_can_send(sk))
+			continue;
+
+		tmp_cwnd =3D mptcp_get_crt_cwnd(sk);
+		if (tmp_cwnd > best_cwnd)
+			best_cwnd =3D tmp_cwnd;
+	}
+	return best_cwnd;
+}
+
+static void mptcp_get_epsilon(const struct mptcp_cb *mpcb)
+{
+	struct mptcp_olia *ca;
+	struct tcp_sock *tp;
+	struct sock *sk;
+	u64 tmp_int, tmp_rtt, best_int =3D 0, best_rtt =3D 1;
+	u32 max_cwnd, tmp_cwnd;
+	u8 M =3D 0, B_not_M =3D 0;
+
+	/* TODO - integrate this in the following loop - we just want to iterate =
once */
+
+	max_cwnd =3D mptcp_get_max_cwnd(mpcb);
+
+	/* find the best path */
+	mptcp_for_each_sk(mpcb, sk) {
+		tp =3D tcp_sk(sk);
+		ca =3D inet_csk_ca(sk);
+
+		if (!mptcp_olia_sk_can_send(sk))
+			continue;
+
+		tmp_rtt =3D (u64)tp->srtt_us * tp->srtt_us;
+		/* TODO - check here and rename variables */
+		tmp_int =3D max(ca->mptcp_loss3 - ca->mptcp_loss2,
+			      ca->mptcp_loss2 - ca->mptcp_loss1);
+
+		if ((u64)tmp_int * best_rtt >=3D (u64)best_int * tmp_rtt) {
+			best_rtt =3D tmp_rtt;
+			best_int =3D tmp_int;
+		}
+	}
+
+	/* TODO - integrate this here in mptcp_get_max_cwnd and in the previous l=
oop */
+	/* find the size of M and B_not_M */
+	mptcp_for_each_sk(mpcb, sk) {
+		tp =3D tcp_sk(sk);
+		ca =3D inet_csk_ca(sk);
+
+		if (!mptcp_olia_sk_can_send(sk))
+			continue;
+
+		tmp_cwnd =3D mptcp_get_crt_cwnd(sk);
+		if (tmp_cwnd =3D=3D max_cwnd) {
+			M++;
+		} else {
+			tmp_rtt =3D (u64)tp->srtt_us * tp->srtt_us;
+			tmp_int =3D max(ca->mptcp_loss3 - ca->mptcp_loss2,
+				      ca->mptcp_loss2 - ca->mptcp_loss1);
+
+			if ((u64)tmp_int * best_rtt =3D=3D (u64)best_int * tmp_rtt)
+				B_not_M++;
+		}
+	}
+
+	/* check if the path is in M or B_not_M and set the value of epsilon acco=
rdingly */
+	mptcp_for_each_sk(mpcb, sk) {
+		tp =3D tcp_sk(sk);
+		ca =3D inet_csk_ca(sk);
+
+		if (!mptcp_olia_sk_can_send(sk))
+			continue;
+
+		if (B_not_M =3D=3D 0) {
+			ca->epsilon_num =3D 0;
+			ca->epsilon_den =3D 1;
+		} else {
+			tmp_rtt =3D (u64)tp->srtt_us * tp->srtt_us;
+			tmp_int =3D max(ca->mptcp_loss3 - ca->mptcp_loss2,
+				      ca->mptcp_loss2 - ca->mptcp_loss1);
+			tmp_cwnd =3D mptcp_get_crt_cwnd(sk);
+
+			if (tmp_cwnd < max_cwnd &&
+			    (u64)tmp_int * best_rtt =3D=3D (u64)best_int * tmp_rtt) {
+				ca->epsilon_num =3D 1;
+				ca->epsilon_den =3D mpcb->cnt_established * B_not_M;
+			} else if (tmp_cwnd =3D=3D max_cwnd) {
+				ca->epsilon_num =3D -1;
+				ca->epsilon_den =3D mpcb->cnt_established  * M;
+			} else {
+				ca->epsilon_num =3D 0;
+				ca->epsilon_den =3D 1;
+			}
+		}
+	}
+}
+
+/* setting the initial values */
+static void mptcp_olia_init(struct sock *sk)
+{
+	const struct tcp_sock *tp =3D tcp_sk(sk);
+	struct mptcp_olia *ca =3D inet_csk_ca(sk);
+
+	if (mptcp(tp)) {
+		ca->mptcp_loss1 =3D tp->snd_una;
+		ca->mptcp_loss2 =3D tp->snd_una;
+		ca->mptcp_loss3 =3D tp->snd_una;
+		ca->mptcp_snd_cwnd_cnt =3D 0;
+		ca->epsilon_num =3D 0;
+		ca->epsilon_den =3D 1;
+	}
+}
+
+/* updating inter-loss distance and ssthresh */
+static void mptcp_olia_set_state(struct sock *sk, u8 new_state)
+{
+	if (!mptcp(tcp_sk(sk)))
+		return;
+
+	if (new_state =3D=3D TCP_CA_Loss ||
+	    new_state =3D=3D TCP_CA_Recovery || new_state =3D=3D TCP_CA_CWR) {
+		struct mptcp_olia *ca =3D inet_csk_ca(sk);
+
+		if (ca->mptcp_loss3 !=3D ca->mptcp_loss2 &&
+		    !inet_csk(sk)->icsk_retransmits) {
+			ca->mptcp_loss1 =3D ca->mptcp_loss2;
+			ca->mptcp_loss2 =3D ca->mptcp_loss3;
+		}
+	}
+}
+
+/* main algorithm */
+static void mptcp_olia_cong_avoid(struct sock *sk, u32 ack, u32 acked)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct mptcp_olia *ca =3D inet_csk_ca(sk);
+	const struct mptcp_cb *mpcb =3D tp->mpcb;
+
+	u64 inc_num, inc_den, rate, cwnd_scaled;
+
+	if (!mptcp(tp)) {
+		tcp_reno_cong_avoid(sk, ack, acked);
+		return;
+	}
+
+	ca->mptcp_loss3 =3D tp->snd_una;
+
+	if (!tcp_is_cwnd_limited(sk))
+		return;
+
+	/* slow start if it is in the safe area */
+	if (tp->snd_cwnd <=3D tp->snd_ssthresh) {
+		tcp_slow_start(tp, acked);
+		return;
+	}
+
+	mptcp_get_epsilon(mpcb);
+	rate =3D mptcp_get_rate(mpcb, tp->srtt_us);
+	cwnd_scaled =3D mptcp_olia_scale(tp->snd_cwnd, scale);
+	inc_den =3D ca->epsilon_den * tp->snd_cwnd * rate ? : 1;
+
+	/* calculate the increasing term, scaling is used to reduce the rounding =
effect */
+	if (ca->epsilon_num =3D=3D -1) {
+		if (ca->epsilon_den * cwnd_scaled * cwnd_scaled < rate) {
+			inc_num =3D rate - ca->epsilon_den *
+				cwnd_scaled * cwnd_scaled;
+			ca->mptcp_snd_cwnd_cnt -=3D div64_u64(
+			    mptcp_olia_scale(inc_num , scale) , inc_den);
+		} else {
+			inc_num =3D ca->epsilon_den *
+			    cwnd_scaled * cwnd_scaled - rate;
+			ca->mptcp_snd_cwnd_cnt +=3D div64_u64(
+			    mptcp_olia_scale(inc_num , scale) , inc_den);
+		}
+	} else {
+		inc_num =3D ca->epsilon_num * rate +
+		    ca->epsilon_den * cwnd_scaled * cwnd_scaled;
+		ca->mptcp_snd_cwnd_cnt +=3D div64_u64(
+		    mptcp_olia_scale(inc_num , scale) , inc_den);
+	}
+
+
+	if (ca->mptcp_snd_cwnd_cnt >=3D (1 << scale) - 1) {
+		if (tp->snd_cwnd < tp->snd_cwnd_clamp)
+			tp->snd_cwnd++;
+		ca->mptcp_snd_cwnd_cnt =3D 0;
+	} else if (ca->mptcp_snd_cwnd_cnt <=3D 0 - (1 << scale) + 1) {
+		tp->snd_cwnd =3D max((int) 1 , (int) tp->snd_cwnd - 1);
+		ca->mptcp_snd_cwnd_cnt =3D 0;
+	}
+}
+
+static struct tcp_congestion_ops mptcp_olia =3D {
+	.init		=3D mptcp_olia_init,
+	.ssthresh	=3D tcp_reno_ssthresh,
+	.cong_avoid	=3D mptcp_olia_cong_avoid,
+	.set_state	=3D mptcp_olia_set_state,
+	.owner		=3D THIS_MODULE,
+	.name		=3D "olia",
+};
+
+static int __init mptcp_olia_register(void)
+{
+	BUILD_BUG_ON(sizeof(struct mptcp_olia) > ICSK_CA_PRIV_SIZE);
+	return tcp_register_congestion_control(&mptcp_olia);
+}
+
+static void __exit mptcp_olia_unregister(void)
+{
+	tcp_unregister_congestion_control(&mptcp_olia);
+}
+
+module_init(mptcp_olia_register);
+module_exit(mptcp_olia_unregister);
+
+MODULE_AUTHOR("Ramin Khalili, Nicolas Gast, Jean-Yves Le Boudec");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MPTCP COUPLED CONGESTION CONTROL");
+MODULE_VERSION("0.1");
diff --git a/net/mptcp/mptcp_output.c b/net/mptcp/mptcp_output.c
new file mode 100644
index 0000000..ca241ee
--- /dev/null
+++ b/net/mptcp/mptcp_output.c
@@ -0,0 +1,1837 @@
+/*
+ *	MPTCP implementation - Sending side
+ *
+ *	Initial Design & Implementation:
+ *	S=C3=A9bastien Barr=C3=A9 <sebastien.barre(a)uclouvain.be>
+ *
+ *	Current Maintainer & Author:
+ *	Christoph Paasch <christoph.paasch(a)uclouvain.be>
+ *
+ *	Additional authors:
+ *	Jaakko Korkeaniemi <jaakko.korkeaniemi(a)aalto.fi>
+ *	Gregory Detal <gregory.detal(a)uclouvain.be>
+ *	Fabien Duch=C3=AAne <fabien.duchene(a)uclouvain.be>
+ *	Andreas Seelinger <Andreas.Seelinger(a)rwth-aachen.de>
+ *	Lavkesh Lahngir <lavkesh51(a)gmail.com>
+ *	Andreas Ripke <ripke(a)neclab.eu>
+ *	Vlad Dogaru <vlad.dogaru(a)intel.com>
+ *	Octavian Purdila <octavian.purdila(a)intel.com>
+ *	John Ronan <jronan(a)tssg.org>
+ *	Catalin Nicutar <catalin.nicutar(a)gmail.com>
+ *	Brandon Heller <brandonh(a)stanford.edu>
+ *
+ *
+ *	This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kconfig.h>
+#include <linux/skbuff.h>
+#include <linux/tcp.h>
+
+#include <net/mptcp.h>
+#include <net/mptcp_v4.h>
+#include <net/mptcp_v6.h>
+#include <net/sock.h>
+
+static const int mptcp_dss_len =3D MPTCP_SUB_LEN_DSS_ALIGN +
+				 MPTCP_SUB_LEN_ACK_ALIGN +
+				 MPTCP_SUB_LEN_SEQ_ALIGN;
+
+static inline int mptcp_sub_len_remove_addr(u16 bitfield)
+{
+	unsigned int c;
+
+	for (c =3D 0; bitfield; c++)
+		bitfield &=3D bitfield - 1;
+	return MPTCP_SUB_LEN_REMOVE_ADDR + c - 1;
+}
+
+int mptcp_sub_len_remove_addr_align(u16 bitfield)
+{
+	return ALIGN(mptcp_sub_len_remove_addr(bitfield), 4);
+}
+EXPORT_SYMBOL(mptcp_sub_len_remove_addr_align);
+
+/* get the data-seq and end-data-seq and store them again in the
+ * tcp_skb_cb
+ */
+static bool mptcp_reconstruct_mapping(struct sk_buff *skb)
+{
+	int len;
+
+	if (!mptcp_is_data_seq(skb))
+		return false;
+
+	len =3D TCP_SKB_CB(skb)->end_seq - TCP_SKB_CB(skb)->seq;
+	TCP_SKB_CB(skb)->seq =3D TCP_SKB_CB(skb)->mptcp_data_seq;
+	TCP_SKB_CB(skb)->end_seq =3D TCP_SKB_CB(skb)->mptcp_data_seq + len;
+
+	return true;
+}
+
+static bool mptcp_is_reinjected(const struct sk_buff *skb)
+{
+	return TCP_SKB_CB(skb)->mptcp_flags & MPTCP_REINJECT;
+}
+
+static void mptcp_find_and_set_pathmask(const struct sock *meta_sk,
+					struct sk_buff *skb)
+{
+	struct sk_buff *skb_it;
+
+	skb_it =3D tcp_write_queue_head(meta_sk);
+
+	skb_queue_walk_from(&(meta_sk)->sk_write_queue, skb_it) {
+		if (skb_it =3D=3D tcp_send_head(meta_sk))
+			break;
+
+		if (TCP_SKB_CB(skb_it)->seq =3D=3D TCP_SKB_CB(skb)->seq) {
+			TCP_SKB_CB(skb)->mptcp_path_mask =3D
+				TCP_SKB_CB(skb_it)->mptcp_path_mask;
+			break;
+		}
+	}
+}
+
+/* Reinject data from one TCP subflow to the meta_sk. If sk =3D=3D NULL, w=
e are
+ * coming from the meta-retransmit-timer
+ */
+static void __mptcp_reinject_data(struct sk_buff *orig_skb,
+				  struct sock *meta_sk,
+				  struct sock *sk, int clone_it)
+{
+	struct sk_buff *skb, *skb1;
+	const struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
+	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
+	u32 seq, end_seq;
+
+	if (clone_it) {
+		/* pskb_copy is necessary here, because the TCP/IP-headers
+		 * will be changed when it's going to be reinjected on another
+		 * subflow.
+		 */
+		tcp_skb_tsorted_save(orig_skb) {
+			skb =3D pskb_copy_for_clone(orig_skb, GFP_ATOMIC);
+		} tcp_skb_tsorted_restore(orig_skb);
+	} else {
+		list_del(&orig_skb->tcp_tsorted_anchor);
+		tcp_rtx_queue_unlink(orig_skb, sk);
+		sock_set_flag(sk, SOCK_QUEUE_SHRUNK);
+		sk->sk_wmem_queued -=3D orig_skb->truesize;
+		sk_mem_uncharge(sk, orig_skb->truesize);
+		skb =3D orig_skb;
+	}
+	if (unlikely(!skb))
+		return;
+
+	if (sk && !mptcp_reconstruct_mapping(skb)) {
+		__kfree_skb(skb);
+		return;
+	}
+
+	skb->sk =3D meta_sk;
+
+	/* Reset subflow-specific TCP control-data */
+	TCP_SKB_CB(skb)->sacked =3D 0;
+	TCP_SKB_CB(skb)->tcp_flags &=3D (TCPHDR_ACK | TCPHDR_PSH);
+
+	/* If it reached already the destination,
+	 * we don't have to reinject it
+	 */
+	if (!after(TCP_SKB_CB(skb)->end_seq, meta_tp->snd_una)) {
+		__kfree_skb(skb);
+		return;
+	}
+
+	/* Only reinject segments that are fully covered by the mapping */
+	if (skb->len + (mptcp_is_data_fin(skb) ? 1 : 0) !=3D
+	    TCP_SKB_CB(skb)->end_seq - TCP_SKB_CB(skb)->seq) {
+		u32 seq =3D TCP_SKB_CB(skb)->seq;
+		u32 end_seq =3D TCP_SKB_CB(skb)->end_seq;
+
+		__kfree_skb(skb);
+
+		/* Ok, now we have to look for the full mapping in the meta
+		 * send-queue :S
+		 */
+		for (skb =3D skb_rb_first(&meta_sk->tcp_rtx_queue); skb;
+		     skb =3D skb1) {
+			skb1 =3D skb_rb_next(skb);
+			/* Not yet at the mapping? */
+			if (before(TCP_SKB_CB(skb)->seq, seq))
+				continue;
+			/* We have passed by the mapping */
+			if (after(TCP_SKB_CB(skb)->end_seq, end_seq))
+				return;
+
+			__mptcp_reinject_data(skb, meta_sk, NULL, 1);
+		}
+		return;
+	}
+
+	/* Segment goes back to the MPTCP-layer. So, we need to zero the
+	 * path_mask.
+	 */
+	TCP_SKB_CB(skb)->mptcp_path_mask =3D 0;
+
+	/* We need to find out the path-mask from the meta-write-queue
+	 * to properly select a subflow.
+	 */
+	mptcp_find_and_set_pathmask(meta_sk, skb);
+
+	/* If it's empty, just add */
+	if (skb_queue_empty(&mpcb->reinject_queue)) {
+		skb_queue_head(&mpcb->reinject_queue, skb);
+		return;
+	}
+
+	/* Find place to insert skb - or even we can 'drop' it, as the
+	 * data is already covered by other skb's in the reinject-queue.
+	 *
+	 * This is inspired by code from tcp_data_queue.
+	 */
+
+	skb1 =3D skb_peek_tail(&mpcb->reinject_queue);
+	seq =3D TCP_SKB_CB(skb)->seq;
+	while (1) {
+		if (!after(TCP_SKB_CB(skb1)->seq, seq))
+			break;
+		if (skb_queue_is_first(&mpcb->reinject_queue, skb1)) {
+			skb1 =3D NULL;
+			break;
+		}
+		skb1 =3D skb_queue_prev(&mpcb->reinject_queue, skb1);
+	}
+
+	/* Do skb overlap to previous one? */
+	end_seq =3D TCP_SKB_CB(skb)->end_seq;
+	if (skb1 && before(seq, TCP_SKB_CB(skb1)->end_seq)) {
+		if (!after(end_seq, TCP_SKB_CB(skb1)->end_seq)) {
+			/* All the bits are present. Don't reinject */
+			__kfree_skb(skb);
+			return;
+		}
+		if (seq =3D=3D TCP_SKB_CB(skb1)->seq) {
+			if (skb_queue_is_first(&mpcb->reinject_queue, skb1))
+				skb1 =3D NULL;
+			else
+				skb1 =3D skb_queue_prev(&mpcb->reinject_queue,
+						      skb1);
+		}
+	}
+	if (!skb1)
+		__skb_queue_head(&mpcb->reinject_queue, skb);
+	else
+		__skb_queue_after(&mpcb->reinject_queue, skb1, skb);
+
+	/* And clean segments covered by new one as whole. */
+	while (!skb_queue_is_last(&mpcb->reinject_queue, skb)) {
+		skb1 =3D skb_queue_next(&mpcb->reinject_queue, skb);
+
+		if (!after(end_seq, TCP_SKB_CB(skb1)->seq))
+			break;
+
+		__skb_unlink(skb1, &mpcb->reinject_queue);
+		__kfree_skb(skb1);
+	}
+}
+
+/* Inserts data into the reinject queue */
+void mptcp_reinject_data(struct sock *sk, int clone_it)
+{
+	struct sk_buff *skb_it, *next;
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct sock *meta_sk =3D tp->meta_sk;
+
+	/* It has already been closed -
+	 * there is really no point in reinjecting
+	 */
+	if (meta_sk->sk_state =3D=3D TCP_CLOSE)
+		return;
+
+	for (skb_it =3D skb_rb_first(&sk->tcp_rtx_queue); skb_it; skb_it =3D next=
) {
+		struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb_it);
+
+		next =3D skb_rb_next(skb_it);
+
+		/* Subflow syn's and fin's are not reinjected.
+		 *
+		 * As well as empty subflow-fins with a data-fin.
+		 * They are reinjected below (without the subflow-fin-flag)
+		 */
+		if (tcb->tcp_flags & TCPHDR_SYN ||
+		    (tcb->tcp_flags & TCPHDR_FIN &&
+		    !mptcp_is_data_fin(skb_it)) ||
+		    (tcb->tcp_flags & TCPHDR_FIN &&
+		    mptcp_is_data_fin(skb_it) && !skb_it->len))
+			continue;
+		if (mptcp_is_reinjected(skb_it))
+			continue;
+
+		TCP_SKB_CB(skb_it)->mptcp_flags |=3D MPTCP_REINJECT;
+		__mptcp_reinject_data(skb_it, meta_sk, sk, clone_it);
+	}
+
+	skb_it =3D skb_rb_last(&meta_sk->tcp_rtx_queue);
+	/* If sk has sent the empty data-fin, we have to reinject it too. */
+	if (skb_it && mptcp_is_data_fin(skb_it) && skb_it->len =3D=3D 0 &&
+	    TCP_SKB_CB(skb_it)->mptcp_path_mask &
+	    mptcp_pi_to_flag(tp->mptcp->path_index)) {
+		__mptcp_reinject_data(skb_it, meta_sk, NULL, 1);
+	}
+
+	tp->pf =3D 1;
+
+	mptcp_push_pending_frames(meta_sk);
+}
+EXPORT_SYMBOL(mptcp_reinject_data);
+
+static void mptcp_combine_dfin(const struct sk_buff *skb,
+			       const struct sock *meta_sk,
+			       struct sock *subsk)
+{
+	const struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
+	const struct mptcp_cb *mpcb =3D meta_tp->mpcb;
+
+	/* In infinite mapping we always try to combine */
+	if (mpcb->infinite_mapping_snd)
+		goto combine;
+
+	/* Don't combine, if they didn't combine when closing - otherwise we end
+	 * up in TIME_WAIT, even if our app is smart enough to avoid it.
+	 */
+	if (!mptcp_sk_can_recv(meta_sk) && !mpcb->dfin_combined)
+		return;
+
+	/* Don't combine if there is still outstanding data that remains to be
+	 * DATA_ACKed, because otherwise we may never be able to deliver this.
+	 */
+	if (meta_tp->snd_una !=3D TCP_SKB_CB(skb)->seq)
+		return;
+
+combine:
+	if (tcp_close_state(subsk)) {
+		subsk->sk_shutdown |=3D SEND_SHUTDOWN;
+		TCP_SKB_CB(skb)->tcp_flags |=3D TCPHDR_FIN;
+	}
+}
+
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
+{
+	const struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
+	__u16 data_len;
+	__be32 *start =3D ptr;
+
+	*ptr++ =3D htonl(tcb->mptcp_data_seq); /* data_seq */
+
+	/* If it's a non-data DATA_FIN, we set subseq to 0 (draft v7) */
+	if (mptcp_is_data_fin(skb) && skb->len =3D=3D 0)
+		*ptr++ =3D 0; /* subseq */
+	else
+		*ptr++ =3D htonl(tcb->seq - tp->mptcp->snt_isn); /* subseq */
+
+	if (TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_INF) {
+		data_len =3D 0;
+	} else {
+		data_len =3D tcb->end_seq - tcb->seq;
+		/* mptcp_entail_skb adds one for FIN */
+		if (tcb->tcp_flags & TCPHDR_FIN)
+			data_len -=3D 1;
+	}
+
+	if (tp->mpcb->dss_csum && data_len) {
+		__be16 *p16 =3D (__be16 *)ptr;
+		__be32 hdseq =3D mptcp_get_highorder_sndbits(skb, tp->mpcb);
+		__wsum csum;
+
+		*ptr =3D htonl(((data_len) << 16) |
+			     (TCPOPT_EOL << 8) |
+			     (TCPOPT_EOL));
+		csum =3D csum_partial(ptr - 2, 12, skb->csum);
+		p16++;
+		*p16 =3D csum_fold(csum_partial(&hdseq, sizeof(hdseq), csum));
+		ptr++;
+	} else {
+		*ptr++ =3D htonl(((data_len) << 16) |
+			       (TCPOPT_NOP << 8) |
+			       (TCPOPT_NOP));
+	}
+
+	return (ptr - start);
+}
+
+static int mptcp_write_dss_data_ack(const struct tcp_sock *tp,
+				    const struct sk_buff *skb, __be32 *ptr)
+{
+	struct mp_dss *mdss =3D (struct mp_dss *)ptr;
+	__be32 *start =3D ptr;
+
+	mdss->kind =3D TCPOPT_MPTCP;
+	mdss->sub =3D MPTCP_SUB_DSS;
+	mdss->rsv1 =3D 0;
+	mdss->rsv2 =3D 0;
+	mdss->F =3D mptcp_is_data_fin(skb) ? 1 : 0;
+	mdss->m =3D 0;
+	mdss->M =3D mptcp_is_data_seq(skb) ? 1 : 0;
+	mdss->a =3D 0;
+	mdss->A =3D 1;
+	mdss->len =3D mptcp_sub_len_dss(mdss, tp->mpcb->dss_csum);
+	ptr++;
+
+	/* data_ack */
+	*ptr++ =3D htonl(mptcp_meta_tp(tp)->rcv_nxt);
+
+	return (ptr - start);
+}
+
+static bool mptcp_skb_entail(struct sock *sk, struct sk_buff *skb, int rei=
nject)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	const struct sock *meta_sk =3D mptcp_meta_sk(sk);
+	const struct mptcp_cb *mpcb =3D tp->mpcb;
+	struct tcp_skb_cb *tcb;
+	struct sk_buff *subskb =3D NULL;
+
+	if (!reinject)
+		TCP_SKB_CB(skb)->mptcp_flags |=3D (mpcb->snd_hiseq_index ?
+					MPTCPHDR_SEQ64_INDEX : 0);
+
+	tcp_skb_tsorted_save(skb) {
+		subskb =3D pskb_copy_for_clone(skb, GFP_ATOMIC);
+	} tcp_skb_tsorted_restore(skb);
+
+	if (!subskb)
+		return false;
+
+	INIT_LIST_HEAD(&subskb->tcp_tsorted_anchor);
+
+	/* At the subflow-level we need to call again tcp_init_tso_segs. We
+	 * force this, by setting pcount to 0. It has been set to 1 prior to
+	 * the call to mptcp_skb_entail.
+	 */
+	tcp_skb_pcount_set(subskb, 0);
+
+	TCP_SKB_CB(skb)->mptcp_path_mask |=3D
+		mptcp_pi_to_flag(tp->mptcp->path_index);
+
+	subskb->csum =3D 0;
+
+	/* If dss-csum is enabled, we do not do hw-csum. */
+	if (tp->mpcb->dss_csum || !sk_check_csum_caps(sk)) {
+		skb->csum =3D skb_checksum(skb, 0, skb->len, 0);
+		subskb->csum =3D skb->csum;
+		subskb->ip_summed =3D CHECKSUM_NONE;
+		skb->ip_summed =3D CHECKSUM_NONE;
+	}
+
+	tcb =3D TCP_SKB_CB(subskb);
+
+	if (tp->mpcb->send_infinite_mapping &&
+	    !tp->mpcb->infinite_mapping_snd &&
+	    !before(tcb->seq, mptcp_meta_tp(tp)->snd_nxt)) {
+		tp->mptcp->fully_established =3D 1;
+		tp->mpcb->infinite_mapping_snd =3D 1;
+		tp->mptcp->infinite_cutoff_seq =3D tp->write_seq;
+		tcb->mptcp_flags |=3D MPTCPHDR_INF;
+	}
+
+	if (mptcp_is_data_fin(subskb))
+		mptcp_combine_dfin(subskb, meta_sk, sk);
+
+	tcb->mptcp_flags |=3D MPTCPHDR_SEQ;
+
+	tcb->mptcp_data_seq =3D tcb->seq;
+
+	tcb->seq =3D tp->write_seq;
+
+	/* Take into account seg len */
+	tp->write_seq +=3D subskb->len + ((tcb->tcp_flags & TCPHDR_FIN) ? 1 : 0);
+	tcb->end_seq =3D tp->write_seq;
+
+	/* If it's a non-payload DATA_FIN (also no subflow-fin), the
+	 * segment is not part of the subflow but on a meta-only-level.
+	 */
+	if (!mptcp_is_data_fin(subskb) || tcb->end_seq !=3D tcb->seq) {
+		tcp_add_write_queue_tail(sk, subskb);
+		sk->sk_wmem_queued +=3D subskb->truesize;
+		sk_mem_charge(sk, subskb->truesize);
+	} else {
+		int err;
+
+		/* Necessary to initialize for tcp_transmit_skb. mss of 1, as
+		 * skb->len =3D 0 will force tso_segs to 1.
+		 */
+		tcp_init_tso_segs(subskb, 1);
+		/* Empty data-fins are sent immediately on the subflow */
+		err =3D tcp_transmit_skb(sk, subskb, 1, GFP_ATOMIC);
+
+		/* It has not been queued, we can free it now. */
+		kfree_skb(subskb);
+
+		if (err)
+			return false;
+	}
+
+	if (!tp->mptcp->fully_established) {
+		tp->mptcp->second_packet =3D 1;
+		tp->mptcp->last_end_data_seq =3D TCP_SKB_CB(skb)->end_seq;
+	}
+
+	return true;
+}
+
+/* Fragment an skb and update the mptcp meta-data. Due to reinject, we
+ * might need to undo some operations done by tcp_fragment.
+ */
+static int mptcp_fragment(struct sock *meta_sk, enum tcp_queue tcp_queue,
+			  struct sk_buff *skb, u32 len,
+			  gfp_t gfp, int reinject)
+{
+	int ret, diff, old_factor;
+	struct sk_buff *buff;
+	u8 flags;
+
+	if (skb_headlen(skb) < len)
+		diff =3D skb->len - len;
+	else
+		diff =3D skb->data_len;
+	old_factor =3D tcp_skb_pcount(skb);
+
+	/* The mss_now in tcp_fragment is used to set the tso_segs of the skb.
+	 * At the MPTCP-level we do not care about the absolute value. All we
+	 * care about is that it is set to 1 for accurate packets_out
+	 * accounting.
+	 */
+	ret =3D tcp_fragment(meta_sk, tcp_queue, skb, len, UINT_MAX, gfp);
+	if (ret)
+		return ret;
+
+	buff =3D skb->next;
+
+	flags =3D TCP_SKB_CB(skb)->mptcp_flags;
+	TCP_SKB_CB(skb)->mptcp_flags =3D flags & ~(MPTCPHDR_FIN);
+	TCP_SKB_CB(buff)->mptcp_flags =3D flags;
+	TCP_SKB_CB(buff)->mptcp_path_mask =3D TCP_SKB_CB(skb)->mptcp_path_mask;
+
+	/* If reinject =3D=3D 1, the buff will be added to the reinject
+	 * queue, which is currently not part of memory accounting. So
+	 * undo the changes done by tcp_fragment and update the
+	 * reinject queue. Also, undo changes to the packet counters.
+	 */
+	if (reinject =3D=3D 1) {
+		int undo =3D buff->truesize - diff;
+
+		meta_sk->sk_wmem_queued -=3D undo;
+		sk_mem_uncharge(meta_sk, undo);
+
+		tcp_sk(meta_sk)->mpcb->reinject_queue.qlen++;
+		meta_sk->sk_write_queue.qlen--;
+
+		if (!before(tcp_sk(meta_sk)->snd_nxt,
+			    TCP_SKB_CB(buff)->end_seq)) {
+			undo =3D old_factor - tcp_skb_pcount(skb) -
+				tcp_skb_pcount(buff);
+			if (undo)
+				tcp_adjust_pcount(meta_sk, skb, -undo);
+		}
+	}
+
+	return 0;
+}
+
+/* Inspired by tcp_write_wakeup */
+int mptcp_write_wakeup(struct sock *meta_sk, int mib)
+{
+	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
+	struct sk_buff *skb;
+	struct sock *sk_it;
+	int ans =3D 0;
+
+	if (meta_sk->sk_state =3D=3D TCP_CLOSE)
+		return -1;
+
+	skb =3D tcp_send_head(meta_sk);
+	if (skb &&
+	    before(TCP_SKB_CB(skb)->seq, tcp_wnd_end(meta_tp))) {
+		unsigned int mss;
+		unsigned int seg_size =3D
+			tcp_wnd_end(meta_tp) - TCP_SKB_CB(skb)->seq;
+		struct sock *subsk =3D
+			meta_tp->mpcb->sched_ops->get_subflow(meta_sk, skb,
+							      true);
+		struct tcp_sock *subtp;
+
+		WARN_ON(TCP_SKB_CB(skb)->sacked);
+
+		if (!subsk)
+			goto window_probe;
+		subtp =3D tcp_sk(subsk);
+		mss =3D tcp_current_mss(subsk);
+
+		seg_size =3D min(tcp_wnd_end(meta_tp) - TCP_SKB_CB(skb)->seq,
+			       tcp_wnd_end(subtp) - subtp->write_seq);
+
+		if (before(meta_tp->pushed_seq, TCP_SKB_CB(skb)->end_seq))
+			meta_tp->pushed_seq =3D TCP_SKB_CB(skb)->end_seq;
+
+		/* We are probing the opening of a window
+		 * but the window size is !=3D 0
+		 * must have been a result SWS avoidance ( sender )
+		 */
+		if (seg_size < TCP_SKB_CB(skb)->end_seq -
+			TCP_SKB_CB(skb)->seq || skb->len > mss) {
+			seg_size =3D min(seg_size, mss);
+			TCP_SKB_CB(skb)->tcp_flags |=3D TCPHDR_PSH;
+			if (mptcp_fragment(meta_sk, TCP_FRAG_IN_WRITE_QUEUE,
+					   skb, seg_size,
+					   GFP_ATOMIC, 0))
+				return -1;
+		} else if (!tcp_skb_pcount(skb)) {
+			/* see mptcp_write_xmit on why we use UINT_MAX */
+			mptcp_set_skb_tso_segs(meta_sk, skb, UINT_MAX);
+		}
+
+		TCP_SKB_CB(skb)->tcp_flags |=3D TCPHDR_PSH;
+		if (!mptcp_skb_entail(subsk, skb, 0))
+			return -1;
+		/* RCHK Check this is correct */
+		skb->skb_mstamp =3D meta_tp->tcp_mstamp;
+
+		mptcp_check_sndseq_wrap(meta_tp, TCP_SKB_CB(skb)->end_seq -
+						 TCP_SKB_CB(skb)->seq);
+		tcp_event_new_data_sent(meta_sk, skb);
+
+		__tcp_push_pending_frames(subsk, mss, TCP_NAGLE_PUSH);
+		meta_tp->lsndtime =3D tcp_jiffies32;
+
+		return 0;
+	}
+window_probe:
+	if (between(meta_tp->snd_up, meta_tp->snd_una + 1,
+		    meta_tp->snd_una + 0xFFFF)) {
+		mptcp_for_each_sk(meta_tp->mpcb, sk_it) {
+			if (mptcp_sk_can_send_ack(sk_it))
+				tcp_xmit_probe_skb(sk_it, 1, mib);
+		}
+	}
+
+	/* At least one of the tcp_xmit_probe_skb's has to succeed */
+	mptcp_for_each_sk(meta_tp->mpcb, sk_it) {
+		int ret;
+
+		if (!mptcp_sk_can_send_ack(sk_it))
+			continue;
+
+		ret =3D tcp_xmit_probe_skb(sk_it, 0, mib);
+		if (unlikely(ret > 0))
+			ans =3D ret;
+	}
+	return ans;
+}
+
+bool mptcp_write_xmit(struct sock *meta_sk, unsigned int mss_now, int nona=
gle,
+		      int push_one, gfp_t gfp)
+{
+	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk), *subtp;
+	struct sock *subsk =3D NULL;
+	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
+	struct sk_buff *skb;
+	int reinject =3D 0;
+	unsigned int sublimit;
+	__u32 path_mask =3D 0;
+
+	while ((skb =3D mpcb->sched_ops->next_segment(meta_sk, &reinject, &subsk,
+						    &sublimit))) {
+		unsigned int limit;
+
+		WARN(TCP_SKB_CB(skb)->sacked, "sacked: %u reinject: %u",
+		     TCP_SKB_CB(skb)->sacked, reinject);
+
+		subtp =3D tcp_sk(subsk);
+		mss_now =3D tcp_current_mss(subsk);
+
+		if (reinject =3D=3D 1) {
+			if (!after(TCP_SKB_CB(skb)->end_seq,
+				   meta_tp->snd_una)) {
+				/* Segment already reached the peer,
+				 * take the next one
+				 */
+				__skb_unlink(skb, &mpcb->reinject_queue);
+				__kfree_skb(skb);
+				continue;
+			}
+		}
+
+		/* If the segment was cloned (e.g. a meta retransmission),
+		 * the header must be expanded/copied so that there is no
+		 * corruption of TSO information.
+		 */
+		if (skb_unclone(skb, GFP_ATOMIC))
+			break;
+
+		if (unlikely(!tcp_snd_wnd_test(meta_tp, skb, mss_now)))
+			break;
+
+		/* Force tso_segs to 1 by using UINT_MAX.
+		 * We actually don't care about the exact number of segments
+		 * emitted on the subflow. We need just to set tso_segs, because
+		 * we still need an accurate packets_out count in
+		 * tcp_event_new_data_sent.
+		 */
+		mptcp_set_skb_tso_segs(meta_sk, skb, UINT_MAX);
+
+		/* Check for nagle, irregardless of tso_segs. If the segment is
+		 * actually larger than mss_now (TSO segment), then
+		 * tcp_nagle_check will have partial =3D=3D false and always trigger
+		 * the transmission.
+		 * tcp_write_xmit has a TSO-level nagle check which is not
+		 * subject to the MPTCP-level. It is based on the properties of
+		 * the subflow, not the MPTCP-level.
+		 */
+		if (unlikely(!tcp_nagle_test(meta_tp, skb, mss_now,
+					     (tcp_skb_is_last(meta_sk, skb) ?
+					      nonagle : TCP_NAGLE_PUSH))))
+			break;
+
+		limit =3D mss_now;
+		/* skb->len > mss_now is the equivalent of tso_segs > 1 in
+		 * tcp_write_xmit. Otherwise split-point would return 0.
+		 */
+		if (skb->len > mss_now && !tcp_urg_mode(meta_tp))
+			/* We limit the size of the skb so that it fits into the
+			 * window. Call tcp_mss_split_point to avoid duplicating
+			 * code.
+			 * We really only care about fitting the skb into the
+			 * window. That's why we use UINT_MAX. If the skb does
+			 * not fit into the cwnd_quota or the NIC's max-segs
+			 * limitation, it will be split by the subflow's
+			 * tcp_write_xmit which does the appropriate call to
+			 * tcp_mss_split_point.
+			 */
+			limit =3D tcp_mss_split_point(meta_sk, skb, mss_now,
+						    UINT_MAX / mss_now,
+						    nonagle);
+
+		if (sublimit)
+			limit =3D min(limit, sublimit);
+
+		if (skb->len > limit &&
+		    unlikely(mptcp_fragment(meta_sk, TCP_FRAG_IN_WRITE_QUEUE,
+					    skb, limit, gfp, reinject)))
+			break;
+
+		if (!mptcp_skb_entail(subsk, skb, reinject))
+			break;
+		/* Nagle is handled at the MPTCP-layer, so
+		 * always push on the subflow
+		 */
+		__tcp_push_pending_frames(subsk, mss_now, TCP_NAGLE_PUSH);
+		meta_tp->lsndtime =3D tcp_jiffies32;
+
+		path_mask |=3D mptcp_pi_to_flag(subtp->mptcp->path_index);
+		/* RCHK Check this is correct */
+		skb->skb_mstamp =3D meta_tp->tcp_mstamp;
+
+		if (!reinject) {
+			mptcp_check_sndseq_wrap(meta_tp,
+						TCP_SKB_CB(skb)->end_seq -
+						TCP_SKB_CB(skb)->seq);
+			tcp_event_new_data_sent(meta_sk, skb);
+		}
+
+		tcp_minshall_update(meta_tp, mss_now, skb);
+
+		if (reinject > 0) {
+			__skb_unlink(skb, &mpcb->reinject_queue);
+			kfree_skb(skb);
+		}
+
+		if (push_one)
+			break;
+	}
+
+	mptcp_for_each_sk(mpcb, subsk) {
+		subtp =3D tcp_sk(subsk);
+
+		if (!(path_mask & mptcp_pi_to_flag(subtp->mptcp->path_index)))
+			continue;
+
+		/* We have pushed data on this subflow. We ignore the call to
+		 * cwnd_validate in tcp_write_xmit as is_cwnd_limited will never
+		 * be true (we never push more than what the cwnd can accept).
+		 * We need to ensure that we call tcp_cwnd_validate with
+		 * is_cwnd_limited set to true if we have filled the cwnd.
+		 */
+		tcp_cwnd_validate(subsk, tcp_packets_in_flight(subtp) >=3D
+				  subtp->snd_cwnd);
+	}
+
+	return !meta_tp->packets_out && tcp_send_head(meta_sk);
+}
+
+void mptcp_write_space(struct sock *sk)
+{
+	mptcp_push_pending_frames(mptcp_meta_sk(sk));
+}
+
+u32 __mptcp_select_window(struct sock *sk)
+{
+	struct inet_connection_sock *icsk =3D inet_csk(sk);
+	struct tcp_sock *tp =3D tcp_sk(sk), *meta_tp =3D mptcp_meta_tp(tp);
+	struct sock *meta_sk =3D mptcp_meta_sk(sk);
+	int mss, free_space, full_space, window;
+
+	/* MSS for the peer's data.  Previous versions used mss_clamp
+	 * here.  I don't know if the value based on our guesses
+	 * of peer's MSS is better for the performance.  It's more correct
+	 * but may be worse for the performance because of rcv_mss
+	 * fluctuations.  --SAW  1998/11/1
+	 */
+	mss =3D icsk->icsk_ack.rcv_mss;
+	free_space =3D tcp_space(meta_sk);
+	full_space =3D min_t(int, meta_tp->window_clamp, tcp_full_space(meta_sk));
+
+	if (mss > full_space)
+		mss =3D full_space;
+
+	if (free_space < (full_space >> 1)) {
+		/* If free_space is decreasing due to mostly meta-level
+		 * out-of-order packets, don't turn off the quick-ack mode.
+		 */
+		if (meta_tp->rcv_nxt - meta_tp->copied_seq >
+		    ((full_space - free_space) >> 1))
+			icsk->icsk_ack.quick =3D 0;
+
+		if (tcp_memory_pressure)
+			/* TODO this has to be adapted when we support different
+			 * MSS's among the subflows.
+			 */
+			meta_tp->rcv_ssthresh =3D min(meta_tp->rcv_ssthresh,
+						    4U * meta_tp->advmss);
+
+		if (free_space < mss)
+			return 0;
+	}
+
+	if (free_space > meta_tp->rcv_ssthresh)
+		free_space =3D meta_tp->rcv_ssthresh;
+
+	/* Don't do rounding if we are using window scaling, since the
+	 * scaled window will not line up with the MSS boundary anyway.
+	 */
+	window =3D meta_tp->rcv_wnd;
+	if (tp->rx_opt.rcv_wscale) {
+		window =3D free_space;
+
+		/* Advertise enough space so that it won't get scaled away.
+		 * Import case: prevent zero window announcement if
+		 * 1<<rcv_wscale > mss.
+		 */
+		if (((window >> tp->rx_opt.rcv_wscale) <<
+		    tp->rx_opt.rcv_wscale) !=3D window)
+			window =3D (((window >> tp->rx_opt.rcv_wscale) + 1)
+				  << tp->rx_opt.rcv_wscale);
+	} else {
+		/* Get the largest window that is a nice multiple of mss.
+		 * Window clamp already applied above.
+		 * If our current window offering is within 1 mss of the
+		 * free space we just keep it. This prevents the divide
+		 * and multiply from happening most of the time.
+		 * We also don't do any window rounding when the free space
+		 * is too small.
+		 */
+		if (window <=3D free_space - mss || window > free_space)
+			window =3D (free_space / mss) * mss;
+		else if (mss =3D=3D full_space &&
+			 free_space > window + (full_space >> 1))
+			window =3D free_space;
+	}
+
+	return window;
+}
+
+void mptcp_syn_options(const struct sock *sk, struct tcp_out_options *opts,
+		       unsigned int *size)
+{
+	const struct tcp_sock *tp =3D tcp_sk(sk);
+
+	opts->options |=3D OPTION_MPTCP;
+	if (is_master_tp(tp)) {
+		opts->mptcp_options |=3D OPTION_MP_CAPABLE | OPTION_TYPE_SYN;
+		opts->mptcp_ver =3D tcp_sk(sk)->mptcp_ver;
+		*size +=3D MPTCP_SUB_LEN_CAPABLE_SYN_ALIGN;
+		opts->mp_capable.sender_key =3D tp->mptcp_loc_key;
+		opts->dss_csum =3D !!sysctl_mptcp_checksum;
+	} else {
+		const struct mptcp_cb *mpcb =3D tp->mpcb;
+
+		opts->mptcp_options |=3D OPTION_MP_JOIN | OPTION_TYPE_SYN;
+		*size +=3D MPTCP_SUB_LEN_JOIN_SYN_ALIGN;
+		opts->mp_join_syns.token =3D mpcb->mptcp_rem_token;
+		opts->mp_join_syns.low_prio  =3D tp->mptcp->low_prio;
+		opts->addr_id =3D tp->mptcp->loc_id;
+		opts->mp_join_syns.sender_nonce =3D tp->mptcp->mptcp_loc_nonce;
+	}
+}
+
+void mptcp_synack_options(struct request_sock *req,
+			  struct tcp_out_options *opts, unsigned int *size)
+{
+	struct mptcp_request_sock *mtreq;
+
+	mtreq =3D mptcp_rsk(req);
+
+	opts->options |=3D OPTION_MPTCP;
+	/* MPCB not yet set - thus it's a new MPTCP-session */
+	if (!mtreq->is_sub) {
+		opts->mptcp_options |=3D OPTION_MP_CAPABLE | OPTION_TYPE_SYNACK;
+		opts->mptcp_ver =3D mtreq->mptcp_ver;
+		opts->mp_capable.sender_key =3D mtreq->mptcp_loc_key;
+		opts->dss_csum =3D !!sysctl_mptcp_checksum || mtreq->dss_csum;
+		*size +=3D MPTCP_SUB_LEN_CAPABLE_SYN_ALIGN;
+	} else {
+		opts->mptcp_options |=3D OPTION_MP_JOIN | OPTION_TYPE_SYNACK;
+		opts->mp_join_syns.sender_truncated_mac =3D
+				mtreq->mptcp_hash_tmac;
+		opts->mp_join_syns.sender_nonce =3D mtreq->mptcp_loc_nonce;
+		opts->mp_join_syns.low_prio =3D mtreq->low_prio;
+		opts->addr_id =3D mtreq->loc_id;
+		*size +=3D MPTCP_SUB_LEN_JOIN_SYNACK_ALIGN;
+	}
+}
+
+void mptcp_established_options(struct sock *sk, struct sk_buff *skb,
+			       struct tcp_out_options *opts, unsigned int *size)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct mptcp_cb *mpcb =3D tp->mpcb;
+	const struct tcp_skb_cb *tcb =3D skb ? TCP_SKB_CB(skb) : NULL;
+
+	/* We are coming from tcp_current_mss with the meta_sk as an argument.
+	 * It does not make sense to check for the options, because when the
+	 * segment gets sent, another subflow will be chosen.
+	 */
+	/* tp->mptcp gets set in mptcp_add_sock() */
+	if (!skb && is_meta_sk(sk))
+		return;
+
+	/* In fallback mp_fail-mode, we have to repeat it until the fallback
+	 * has been done by the sender
+	 */
+	if (unlikely(tp->mptcp->send_mp_fail)) {
+		opts->options |=3D OPTION_MPTCP;
+		opts->mptcp_options |=3D OPTION_MP_FAIL;
+		*size +=3D MPTCP_SUB_LEN_FAIL;
+	}
+
+	if (unlikely(tp->send_mp_fclose)) {
+		opts->options |=3D OPTION_MPTCP;
+		opts->mptcp_options |=3D OPTION_MP_FCLOSE;
+		opts->mp_capable.receiver_key =3D mpcb->mptcp_rem_key;
+		*size +=3D MPTCP_SUB_LEN_FCLOSE_ALIGN;
+		return;
+	}
+
+	/* 1. If we are the sender of the infinite-mapping, we need the
+	 *    MPTCPHDR_INF-flag, because a retransmission of the
+	 *    infinite-announcment still needs the mptcp-option.
+	 *
+	 *    We need infinite_cutoff_seq, because retransmissions from before
+	 *    the infinite-cutoff-moment still need the MPTCP-signalling to stay
+	 *    consistent.
+	 *
+	 * 2. If we are the receiver of the infinite-mapping, we always skip
+	 *    mptcp-options, because acknowledgments from before the
+	 *    infinite-mapping point have already been sent out.
+	 *
+	 * I know, the whole infinite-mapping stuff is ugly...
+	 *
+	 * TODO: Handle wrapped data-sequence numbers
+	 *       (even if it's very unlikely)
+	 */
+	if (unlikely(mpcb->infinite_mapping_snd) &&
+	    ((mpcb->send_infinite_mapping && tcb && skb &&
+	      mptcp_is_data_seq(skb) &&
+	      !(TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_INF) &&
+	      !before(tcb->seq, tp->mptcp->infinite_cutoff_seq)) ||
+	     !mpcb->send_infinite_mapping)) {
+		return;
+	}
+
+	if (unlikely(tp->mptcp->include_mpc)) {
+		opts->options |=3D OPTION_MPTCP;
+		opts->mptcp_options |=3D OPTION_MP_CAPABLE |
+				       OPTION_TYPE_ACK;
+		*size +=3D MPTCP_SUB_LEN_CAPABLE_ACK_ALIGN;
+		opts->mptcp_ver =3D mpcb->mptcp_ver;
+		opts->mp_capable.sender_key =3D mpcb->mptcp_loc_key;
+		opts->mp_capable.receiver_key =3D mpcb->mptcp_rem_key;
+		opts->dss_csum =3D mpcb->dss_csum;
+
+		if (skb)
+			tp->mptcp->include_mpc =3D 0;
+	}
+	if (unlikely(tp->mptcp->pre_established)) {
+		opts->options |=3D OPTION_MPTCP;
+		opts->mptcp_options |=3D OPTION_MP_JOIN | OPTION_TYPE_ACK;
+		*size +=3D MPTCP_SUB_LEN_JOIN_ACK_ALIGN;
+	}
+
+	if (unlikely(mpcb->addr_signal) && mpcb->pm_ops->addr_signal &&
+	    mpcb->mptcp_ver >=3D MPTCP_VERSION_1 && skb &&
+	    !mptcp_is_data_seq(skb)) {
+		mpcb->pm_ops->addr_signal(sk, size, opts, skb);
+
+		if (opts->add_addr_v6) {
+			/* Skip subsequent options */
+			return;
+		}
+	}
+
+	if (!tp->mptcp->include_mpc && !tp->mptcp->pre_established) {
+		opts->options |=3D OPTION_MPTCP;
+		opts->mptcp_options |=3D OPTION_DATA_ACK;
+		/* If !skb, we come from tcp_current_mss and thus we always
+		 * assume that the DSS-option will be set for the data-packet.
+		 */
+		if (skb && !mptcp_is_data_seq(skb)) {
+			*size +=3D MPTCP_SUB_LEN_ACK_ALIGN;
+		} else {
+			/* Doesn't matter, if csum included or not. It will be
+			 * either 10 or 12, and thus aligned =3D 12
+			 */
+			*size +=3D MPTCP_SUB_LEN_ACK_ALIGN +
+				 MPTCP_SUB_LEN_SEQ_ALIGN;
+		}
+
+		*size +=3D MPTCP_SUB_LEN_DSS_ALIGN;
+	}
+
+	if (unlikely(mpcb->addr_signal) && mpcb->pm_ops->addr_signal &&
+	    mpcb->mptcp_ver < MPTCP_VERSION_1)
+		mpcb->pm_ops->addr_signal(sk, size, opts, skb);
+
+	if (unlikely(tp->mptcp->send_mp_prio) &&
+	    MAX_TCP_OPTION_SPACE - *size >=3D MPTCP_SUB_LEN_PRIO_ALIGN) {
+		opts->options |=3D OPTION_MPTCP;
+		opts->mptcp_options |=3D OPTION_MP_PRIO;
+		if (skb)
+			tp->mptcp->send_mp_prio =3D 0;
+		*size +=3D MPTCP_SUB_LEN_PRIO_ALIGN;
+	}
+}
+
+u16 mptcp_select_window(struct sock *sk)
+{
+	u16 new_win		=3D tcp_select_window(sk);
+	struct tcp_sock *tp	=3D tcp_sk(sk);
+	struct tcp_sock *meta_tp =3D mptcp_meta_tp(tp);
+
+	meta_tp->rcv_wnd	=3D tp->rcv_wnd;
+	meta_tp->rcv_wup	=3D meta_tp->rcv_nxt;
+
+	return new_win;
+}
+
+void mptcp_options_write(__be32 **ptr_ptr, struct tcp_sock *tp,
+			 struct tcp_out_options *opts,
+			 struct sk_buff *skb)
+{
+	__be32 *ptr;
+	__be32 *orig;
+
+	orig =3D *ptr_ptr;
+
+	tcp_options_write(ptr_ptr, tp, opts, skb);
+	if (!(OPTION_MPTCP & opts->options))
+		return;
+	ptr =3D *ptr_ptr;
+	if (unlikely(OPTION_MP_CAPABLE & opts->mptcp_options)) {
+		struct mp_capable *mpc =3D (struct mp_capable *)ptr;
+
+		mpc->kind =3D TCPOPT_MPTCP;
+
+		if ((OPTION_TYPE_SYN & opts->mptcp_options) ||
+		    (OPTION_TYPE_SYNACK & opts->mptcp_options)) {
+			mpc->sender_key =3D opts->mp_capable.sender_key;
+			mpc->len =3D MPTCP_SUB_LEN_CAPABLE_SYN;
+			mpc->ver =3D opts->mptcp_ver;
+			ptr +=3D MPTCP_SUB_LEN_CAPABLE_SYN_ALIGN >> 2;
+		} else if (OPTION_TYPE_ACK & opts->mptcp_options) {
+			mpc->sender_key =3D opts->mp_capable.sender_key;
+			mpc->receiver_key =3D opts->mp_capable.receiver_key;
+			mpc->len =3D MPTCP_SUB_LEN_CAPABLE_ACK;
+			mpc->ver =3D opts->mptcp_ver;
+			ptr +=3D MPTCP_SUB_LEN_CAPABLE_ACK_ALIGN >> 2;
+		}
+
+		mpc->sub =3D MPTCP_SUB_CAPABLE;
+		mpc->a =3D opts->dss_csum;
+		mpc->b =3D 0;
+		mpc->rsv =3D 0;
+		mpc->h =3D 1;
+	}
+	if (unlikely(OPTION_MP_JOIN & opts->mptcp_options)) {
+		struct mp_join *mpj =3D (struct mp_join *)ptr;
+
+		mpj->kind =3D TCPOPT_MPTCP;
+		mpj->sub =3D MPTCP_SUB_JOIN;
+		mpj->rsv =3D 0;
+
+		if (OPTION_TYPE_SYN & opts->mptcp_options) {
+			mpj->len =3D MPTCP_SUB_LEN_JOIN_SYN;
+			mpj->u.syn.token =3D opts->mp_join_syns.token;
+			mpj->u.syn.nonce =3D opts->mp_join_syns.sender_nonce;
+			mpj->b =3D opts->mp_join_syns.low_prio;
+			mpj->addr_id =3D opts->addr_id;
+			ptr +=3D MPTCP_SUB_LEN_JOIN_SYN_ALIGN >> 2;
+		} else if (OPTION_TYPE_SYNACK & opts->mptcp_options) {
+			mpj->len =3D MPTCP_SUB_LEN_JOIN_SYNACK;
+			mpj->u.synack.mac =3D
+				opts->mp_join_syns.sender_truncated_mac;
+			mpj->u.synack.nonce =3D opts->mp_join_syns.sender_nonce;
+			mpj->b =3D opts->mp_join_syns.low_prio;
+			mpj->addr_id =3D opts->addr_id;
+			ptr +=3D MPTCP_SUB_LEN_JOIN_SYNACK_ALIGN >> 2;
+		} else if (OPTION_TYPE_ACK & opts->mptcp_options) {
+			mpj->len =3D MPTCP_SUB_LEN_JOIN_ACK;
+			mpj->addr_id =3D 0; /* addr_id is rsv (RFC 6824, p. 21) */
+			memcpy(mpj->u.ack.mac, &tp->mptcp->sender_mac[0], 20);
+			ptr +=3D MPTCP_SUB_LEN_JOIN_ACK_ALIGN >> 2;
+		}
+	}
+	if (unlikely(OPTION_ADD_ADDR & opts->mptcp_options)) {
+		struct mp_add_addr *mpadd =3D (struct mp_add_addr *)ptr;
+		struct mptcp_cb *mpcb =3D tp->mpcb;
+
+		mpadd->kind =3D TCPOPT_MPTCP;
+		if (opts->add_addr_v4) {
+			mpadd->sub =3D MPTCP_SUB_ADD_ADDR;
+			mpadd->ipver =3D 4;
+			mpadd->addr_id =3D opts->add_addr4.addr_id;
+			mpadd->u.v4.addr =3D opts->add_addr4.addr;
+			if (mpcb->mptcp_ver < MPTCP_VERSION_1) {
+				mpadd->len =3D MPTCP_SUB_LEN_ADD_ADDR4;
+				ptr +=3D MPTCP_SUB_LEN_ADD_ADDR4_ALIGN >> 2;
+			} else {
+				memcpy((char *)mpadd->u.v4.mac - 2,
+				       (char *)&opts->add_addr4.trunc_mac, 8);
+				mpadd->len =3D MPTCP_SUB_LEN_ADD_ADDR4_VER1;
+				ptr +=3D MPTCP_SUB_LEN_ADD_ADDR4_ALIGN_VER1 >> 2;
+			}
+		} else if (opts->add_addr_v6) {
+			mpadd->sub =3D MPTCP_SUB_ADD_ADDR;
+			mpadd->ipver =3D 6;
+			mpadd->addr_id =3D opts->add_addr6.addr_id;
+			memcpy(&mpadd->u.v6.addr, &opts->add_addr6.addr,
+			       sizeof(mpadd->u.v6.addr));
+			if (mpcb->mptcp_ver < MPTCP_VERSION_1) {
+				mpadd->len =3D MPTCP_SUB_LEN_ADD_ADDR6;
+				ptr +=3D MPTCP_SUB_LEN_ADD_ADDR6_ALIGN >> 2;
+			} else {
+				memcpy((char *)mpadd->u.v6.mac - 2,
+				       (char *)&opts->add_addr6.trunc_mac, 8);
+				mpadd->len =3D MPTCP_SUB_LEN_ADD_ADDR6_VER1;
+				ptr +=3D MPTCP_SUB_LEN_ADD_ADDR6_ALIGN_VER1 >> 2;
+			}
+		}
+
+		MPTCP_INC_STATS_BH(sock_net((struct sock *)tp),
+				   MPTCP_MIB_ADDADDRTX);
+	}
+	if (unlikely(OPTION_REMOVE_ADDR & opts->mptcp_options)) {
+		struct mp_remove_addr *mprem =3D (struct mp_remove_addr *)ptr;
+		u8 *addrs_id;
+		int id, len, len_align;
+
+		len =3D mptcp_sub_len_remove_addr(opts->remove_addrs);
+		len_align =3D mptcp_sub_len_remove_addr_align(opts->remove_addrs);
+
+		mprem->kind =3D TCPOPT_MPTCP;
+		mprem->len =3D len;
+		mprem->sub =3D MPTCP_SUB_REMOVE_ADDR;
+		mprem->rsv =3D 0;
+		addrs_id =3D &mprem->addrs_id;
+
+		mptcp_for_each_bit_set(opts->remove_addrs, id)
+			*(addrs_id++) =3D id;
+
+		/* Fill the rest with NOP's */
+		if (len_align > len) {
+			int i;
+
+			for (i =3D 0; i < len_align - len; i++)
+				*(addrs_id++) =3D TCPOPT_NOP;
+		}
+
+		ptr +=3D len_align >> 2;
+
+		MPTCP_INC_STATS_BH(sock_net((struct sock *)tp),
+				   MPTCP_MIB_REMADDRTX);
+	}
+	if (unlikely(OPTION_MP_FAIL & opts->mptcp_options)) {
+		struct mp_fail *mpfail =3D (struct mp_fail *)ptr;
+
+		mpfail->kind =3D TCPOPT_MPTCP;
+		mpfail->len =3D MPTCP_SUB_LEN_FAIL;
+		mpfail->sub =3D MPTCP_SUB_FAIL;
+		mpfail->rsv1 =3D 0;
+		mpfail->rsv2 =3D 0;
+		mpfail->data_seq =3D htonll(tp->mpcb->csum_cutoff_seq);
+
+		ptr +=3D MPTCP_SUB_LEN_FAIL_ALIGN >> 2;
+	}
+	if (unlikely(OPTION_MP_FCLOSE & opts->mptcp_options)) {
+		struct mp_fclose *mpfclose =3D (struct mp_fclose *)ptr;
+
+		mpfclose->kind =3D TCPOPT_MPTCP;
+		mpfclose->len =3D MPTCP_SUB_LEN_FCLOSE;
+		mpfclose->sub =3D MPTCP_SUB_FCLOSE;
+		mpfclose->rsv1 =3D 0;
+		mpfclose->rsv2 =3D 0;
+		mpfclose->key =3D opts->mp_capable.receiver_key;
+
+		ptr +=3D MPTCP_SUB_LEN_FCLOSE_ALIGN >> 2;
+	}
+
+	if (OPTION_DATA_ACK & opts->mptcp_options) {
+		ptr +=3D mptcp_write_dss_data_ack(tp, skb, ptr);
+		if (mptcp_is_data_seq(skb))
+			ptr +=3D mptcp_write_dss_mapping(tp, skb, ptr);
+	}
+
+	if (unlikely(OPTION_MP_PRIO & opts->mptcp_options)) {
+		struct mp_prio *mpprio =3D (struct mp_prio *)ptr;
+
+		mpprio->kind =3D TCPOPT_MPTCP;
+		mpprio->len =3D MPTCP_SUB_LEN_PRIO;
+		mpprio->sub =3D MPTCP_SUB_PRIO;
+		mpprio->rsv =3D 0;
+		mpprio->b =3D tp->mptcp->low_prio;
+		mpprio->addr_id =3D TCPOPT_NOP;
+
+		ptr +=3D MPTCP_SUB_LEN_PRIO_ALIGN >> 2;
+	}
+	*ptr_ptr =3D ptr;
+}
+
+/* Sends the datafin */
+void mptcp_send_fin(struct sock *meta_sk)
+{
+	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
+	struct sk_buff *skb =3D tcp_write_queue_tail(meta_sk);
+	int mss_now;
+
+	if ((1 << meta_sk->sk_state) & (TCPF_CLOSE_WAIT | TCPF_LAST_ACK))
+		meta_tp->mpcb->passive_close =3D 1;
+
+	/* Optimization, tack on the FIN if we have a queue of
+	 * unsent frames.  But be careful about outgoing SACKS
+	 * and IP options.
+	 */
+	mss_now =3D mptcp_current_mss(meta_sk);
+
+	if (tcp_send_head(meta_sk)) {
+		TCP_SKB_CB(skb)->mptcp_flags |=3D MPTCPHDR_FIN;
+		TCP_SKB_CB(skb)->end_seq++;
+		meta_tp->write_seq++;
+	} else {
+		/* Socket is locked, keep trying until memory is available. */
+		for (;;) {
+			skb =3D alloc_skb_fclone(MAX_TCP_HEADER,
+					       meta_sk->sk_allocation);
+			if (skb)
+				break;
+			yield();
+		}
+		INIT_LIST_HEAD(&skb->tcp_tsorted_anchor);
+		/* Reserve space for headers and prepare control bits. */
+		skb_reserve(skb, MAX_TCP_HEADER);
+
+		tcp_init_nondata_skb(skb, meta_tp->write_seq, TCPHDR_ACK);
+		TCP_SKB_CB(skb)->end_seq++;
+		TCP_SKB_CB(skb)->mptcp_flags |=3D MPTCPHDR_FIN;
+		tcp_queue_skb(meta_sk, skb);
+	}
+	__tcp_push_pending_frames(meta_sk, mss_now, TCP_NAGLE_OFF);
+}
+
+void mptcp_send_active_reset(struct sock *meta_sk, gfp_t priority)
+{
+	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
+	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
+	struct sock *sk;
+
+	if (!mpcb->cnt_subflows)
+		return;
+
+	WARN_ON(meta_tp->send_mp_fclose);
+
+	/* First - select a socket */
+	sk =3D mptcp_select_ack_sock(meta_sk);
+
+	/* May happen if no subflow is in an appropriate state, OR
+	 * we are in infinite mode or about to go there - just send a reset
+	 */
+	if (!sk || mpcb->infinite_mapping_snd || mpcb->send_infinite_mapping ||
+	    mpcb->infinite_mapping_rcv) {
+		/* tcp_done must be handled with bh disabled */
+		if (!in_serving_softirq())
+			local_bh_disable();
+
+		mptcp_sub_force_close_all(mpcb, NULL);
+
+		if (!in_serving_softirq())
+			local_bh_enable();
+		return;
+	}
+
+	tcp_sk(sk)->send_mp_fclose =3D 1;
+	/** Reset all other subflows */
+
+	/* tcp_done must be handled with bh disabled */
+	if (!in_serving_softirq())
+		local_bh_disable();
+
+	/* RCHK Fix me ?
+	 *	mptcp_sub_force_close_all(mpcb, sk);
+	 */
+
+	tcp_set_state(sk, TCP_RST_WAIT);
+
+	if (!in_serving_softirq())
+		local_bh_enable();
+
+	tcp_send_ack(sk);
+	tcp_clear_xmit_timers(sk);
+	inet_csk_reset_keepalive_timer(sk, inet_csk(sk)->icsk_rto);
+
+	meta_tp->send_mp_fclose =3D 1;
+
+	MPTCP_INC_STATS(sock_net(meta_sk), MPTCP_MIB_FASTCLOSETX);
+}
+
+static void mptcp_ack_retransmit_timer(struct sock *sk)
+{
+	struct sk_buff *skb;
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct inet_connection_sock *icsk =3D inet_csk(sk);
+	struct net *net =3D sock_net(sk);
+
+	if (inet_csk(sk)->icsk_af_ops->rebuild_header(sk))
+		goto out; /* Routing failure or similar */
+
+	if (!tp->retrans_stamp)
+		tp->retrans_stamp =3D tcp_jiffies32 ? : 1;
+
+	if (tcp_write_timeout(sk)) {
+		MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_JOINACKRTO);
+		tp->mptcp->pre_established =3D 0;
+		sk_stop_timer(sk, &tp->mptcp->mptcp_ack_timer);
+		tp->op_ops->send_active_reset(sk, GFP_ATOMIC);
+		goto out;
+	}
+
+	skb =3D alloc_skb(MAX_TCP_HEADER, GFP_ATOMIC);
+	if (!skb) {
+		sk_reset_timer(sk, &tp->mptcp->mptcp_ack_timer,
+			       jiffies + icsk->icsk_rto);
+		return;
+	}
+
+	/* Reserve space for headers and prepare control bits */
+	skb_reserve(skb, MAX_TCP_HEADER);
+	tcp_init_nondata_skb(skb, tp->snd_una, TCPHDR_ACK);
+
+	MPTCP_INC_STATS_BH(sock_net(sk), MPTCP_MIB_JOINACKRXMIT);
+
+	if (tcp_transmit_skb(sk, skb, 0, GFP_ATOMIC) > 0) {
+		/* Retransmission failed because of local congestion,
+		 * do not backoff.
+		 */
+		if (!icsk->icsk_retransmits)
+			icsk->icsk_retransmits =3D 1;
+		sk_reset_timer(sk, &tp->mptcp->mptcp_ack_timer,
+			       jiffies + icsk->icsk_rto);
+		return;
+	}
+
+	icsk->icsk_retransmits++;
+	icsk->icsk_rto =3D min(icsk->icsk_rto << 1, TCP_RTO_MAX);
+	sk_reset_timer(sk, &tp->mptcp->mptcp_ack_timer,
+		       jiffies + icsk->icsk_rto);
+	if (retransmits_timed_out(sk, net->ipv4.sysctl_tcp_retries1 + 1, 0))
+		__sk_dst_reset(sk);
+
+out:;
+}
+
+void mptcp_ack_handler(struct timer_list *t)
+{
+	struct mptcp_tcp_sock *mptcp =3D from_timer(mptcp, t, mptcp_ack_timer);
+	struct tcp_sock *tp =3D mptcp->tp;
+	struct sock *sk =3D (struct sock *)tp;
+	struct sock *meta_sk =3D tp->meta_sk;
+
+	bh_lock_sock(meta_sk);
+	if (sock_owned_by_user(meta_sk)) {
+		/* Try again later */
+		sk_reset_timer(sk, &tcp_sk(sk)->mptcp->mptcp_ack_timer,
+			       jiffies + (HZ / 20));
+		goto out_unlock;
+	}
+
+	if (sk->sk_state =3D=3D TCP_CLOSE)
+		goto out_unlock;
+	if (!tcp_sk(sk)->mptcp->pre_established)
+		goto out_unlock;
+
+	mptcp_ack_retransmit_timer(sk);
+
+	sk_mem_reclaim(sk);
+
+out_unlock:
+	bh_unlock_sock(meta_sk);
+	sock_put(sk);
+}
+
+/* Similar to tcp_retransmit_skb
+ *
+ * The diff is that we handle the retransmission-stats (retrans_stamp) at =
the
+ * meta-level.
+ */
+int mptcp_retransmit_skb(struct sock *meta_sk, struct sk_buff *skb)
+{
+	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
+	struct sock *subsk;
+	unsigned int limit, mss_now;
+	int err =3D -1;
+
+	WARN_ON(TCP_SKB_CB(skb)->sacked);
+
+	/* Do not sent more than we queued. 1/4 is reserved for possible
+	 * copying overhead: fragmentation, tunneling, mangling etc.
+	 *
+	 * This is a meta-retransmission thus we check on the meta-socket.
+	 */
+	if (refcount_read(&meta_sk->sk_wmem_alloc) >
+	    min(meta_sk->sk_wmem_queued + (meta_sk->sk_wmem_queued >> 2),
+		meta_sk->sk_sndbuf)) {
+		return -EAGAIN;
+	}
+
+	/* We need to make sure that the retransmitted segment can be sent on a
+	 * subflow right now. If it is too big, it needs to be fragmented.
+	 */
+	subsk =3D meta_tp->mpcb->sched_ops->get_subflow(meta_sk, skb, false);
+	if (!subsk) {
+		/* We want to increase icsk_retransmits, thus return 0, so that
+		 * mptcp_meta_retransmit_timer enters the desired branch.
+		 */
+		err =3D 0;
+		goto failed;
+	}
+	mss_now =3D tcp_current_mss(subsk);
+
+	/* If the segment was cloned (e.g. a meta retransmission), the header
+	 * must be expanded/copied so that there is no corruption of TSO
+	 * information.
+	 */
+	if (skb_unclone(skb, GFP_ATOMIC)) {
+		err =3D -ENOMEM;
+		goto failed;
+	}
+
+	/* Must have been set by mptcp_write_xmit before */
+	BUG_ON(!tcp_skb_pcount(skb));
+
+	limit =3D mss_now;
+	/* skb->len > mss_now is the equivalent of tso_segs > 1 in
+	 * tcp_write_xmit. Otherwise split-point would return 0.
+	 */
+	if (skb->len > mss_now && !tcp_urg_mode(meta_tp))
+		limit =3D tcp_mss_split_point(meta_sk, skb, mss_now,
+					    UINT_MAX / mss_now,
+					    TCP_NAGLE_OFF);
+
+	if (skb->len > limit &&
+	    unlikely(mptcp_fragment(meta_sk, TCP_FRAG_IN_RTX_QUEUE, skb, limit,
+				    GFP_ATOMIC, 0)))
+		goto failed;
+
+	if (!mptcp_skb_entail(subsk, skb, -1))
+		goto failed;
+	/* RCHK Check this is correct */
+	skb->skb_mstamp =3D meta_tp->tcp_mstamp;
+
+	/* Update global TCP statistics. */
+	MPTCP_INC_STATS_BH(sock_net(meta_sk), MPTCP_MIB_RETRANSSEGS);
+
+	/* Diff to tcp_retransmit_skb */
+
+	/* Save stamp of the first retransmit. */
+	if (!meta_tp->retrans_stamp)
+		meta_tp->retrans_stamp =3D tcp_skb_timestamp(skb);
+
+	__tcp_push_pending_frames(subsk, mss_now, TCP_NAGLE_PUSH);
+	meta_tp->lsndtime =3D tcp_jiffies32;
+
+	return 0;
+
+failed:
+	__NET_INC_STATS(sock_net(meta_sk), LINUX_MIB_TCPRETRANSFAIL);
+	return err;
+}
+
+/* Similar to tcp_retransmit_timer
+ *
+ * The diff is that we have to handle retransmissions of the FAST_CLOSE-me=
ssage
+ * and that we don't have an srtt estimation at the meta-level.
+ */
+void mptcp_meta_retransmit_timer(struct sock *meta_sk)
+{
+	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
+	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
+	struct net *net =3D sock_net(meta_sk);
+	struct inet_connection_sock *meta_icsk =3D inet_csk(meta_sk);
+	int err;
+
+	/* In fallback, retransmission is handled at the subflow-level */
+	if (!meta_tp->packets_out || mpcb->infinite_mapping_snd ||
+	    tcp_rtx_queue_empty(meta_sk))
+		return;
+
+	if (!meta_tp->snd_wnd && !sock_flag(meta_sk, SOCK_DEAD) &&
+	    !((1 << meta_sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))) {
+		/* Receiver dastardly shrinks window. Our retransmits
+		 * become zero probes, but we should not timeout this
+		 * connection. If the socket is an orphan, time it out,
+		 * we cannot allow such beasts to hang infinitely.
+		 */
+		struct inet_sock *meta_inet =3D inet_sk(meta_sk);
+
+		if (meta_sk->sk_family =3D=3D AF_INET) {
+			net_dbg_ratelimited("MPTCP: Peer %pI4:%u/%u unexpectedly shrunk window =
%u:%u (repaired)\n",
+					    &meta_inet->inet_daddr,
+					    ntohs(meta_inet->inet_dport),
+					    meta_inet->inet_num,
+					    meta_tp->snd_una,
+					    meta_tp->snd_nxt);
+		}
+#if IS_ENABLED(CONFIG_IPV6)
+		else if (meta_sk->sk_family =3D=3D AF_INET6) {
+			net_dbg_ratelimited("MPTCP: Peer %pI6:%u/%u unexpectedly shrunk window =
%u:%u (repaired)\n",
+					    &meta_sk->sk_v6_daddr,
+					    ntohs(meta_inet->inet_dport),
+					    meta_inet->inet_num,
+					    meta_tp->snd_una,
+					    meta_tp->snd_nxt);
+		}
+#endif
+		if (tcp_jiffies32 - meta_tp->rcv_tstamp > TCP_RTO_MAX) {
+			tcp_write_err(meta_sk);
+			return;
+		}
+
+		mptcp_retransmit_skb(meta_sk, tcp_rtx_queue_head(meta_sk));
+		goto out_reset_timer;
+	}
+
+	if (tcp_write_timeout(meta_sk))
+		return;
+
+	if (meta_icsk->icsk_retransmits =3D=3D 0)
+		__NET_INC_STATS(net, LINUX_MIB_TCPTIMEOUTS);
+
+	meta_icsk->icsk_ca_state =3D TCP_CA_Loss;
+
+	err =3D mptcp_retransmit_skb(meta_sk, tcp_rtx_queue_head(meta_sk));
+	if (err > 0) {
+		/* Retransmission failed because of local congestion,
+		 * do not backoff.
+		 */
+		if (!meta_icsk->icsk_retransmits)
+			meta_icsk->icsk_retransmits =3D 1;
+		inet_csk_reset_xmit_timer(meta_sk, ICSK_TIME_RETRANS,
+					  min(meta_icsk->icsk_rto,
+					      TCP_RESOURCE_PROBE_INTERVAL),
+					      TCP_RTO_MAX);
+		return;
+	}
+
+	/* Increase the timeout each time we retransmit.  Note that
+	 * we do not increase the rtt estimate.  rto is initialized
+	 * from rtt, but increases here.  Jacobson (SIGCOMM 88) suggests
+	 * that doubling rto each time is the least we can get away with.
+	 * In KA9Q, Karn uses this for the first few times, and then
+	 * goes to quadratic.  netBSD doubles, but only goes up to *64,
+	 * and clamps at 1 to 64 sec afterwards.  Note that 120 sec is
+	 * defined in the protocol as the maximum possible RTT.  I guess
+	 * we'll have to use something other than TCP to talk to the
+	 * University of Mars.
+	 *
+	 * PAWS allows us longer timeouts and large windows, so once
+	 * implemented ftp to mars will work nicely. We will have to fix
+	 * the 120 second clamps though!
+	 */
+	meta_icsk->icsk_backoff++;
+	meta_icsk->icsk_retransmits++;
+
+out_reset_timer:
+	/* If stream is thin, use linear timeouts. Since 'icsk_backoff' is
+	 * used to reset timer, set to 0. Recalculate 'icsk_rto' as this
+	 * might be increased if the stream oscillates between thin and thick,
+	 * thus the old value might already be too high compared to the value
+	 * set by 'tcp_set_rto' in tcp_input.c which resets the rto without
+	 * backoff. Limit to TCP_THIN_LINEAR_RETRIES before initiating
+	 * exponential backoff behaviour to avoid continue hammering
+	 * linear-timeout retransmissions into a black hole
+	 */
+	if (meta_sk->sk_state =3D=3D TCP_ESTABLISHED &&
+	    (meta_tp->thin_lto || net->ipv4.sysctl_tcp_thin_linear_timeouts) &&
+	    tcp_stream_is_thin(meta_tp) &&
+	    meta_icsk->icsk_retransmits <=3D TCP_THIN_LINEAR_RETRIES) {
+		meta_icsk->icsk_backoff =3D 0;
+		/* We cannot do the same as in tcp_write_timer because the
+		 * srtt is not set here.
+		 */
+		mptcp_set_rto(meta_sk);
+	} else {
+		/* Use normal (exponential) backoff */
+		meta_icsk->icsk_rto =3D
+			min(meta_icsk->icsk_rto << 1, TCP_RTO_MAX);
+	}
+	inet_csk_reset_xmit_timer(meta_sk, ICSK_TIME_RETRANS,
+				  meta_icsk->icsk_rto, TCP_RTO_MAX);
+}
+
+void mptcp_sub_retransmit_timer(struct sock *sk)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+
+	/* RCHK Fixme -- I should not be here */
+	if (tcp_rtx_queue_empty(sk)) {
+		WARN_ON(printk("%s: tcp_rtx_queue_empty\n", __func__));
+		return;
+	}
+
+	tcp_retransmit_timer(sk);
+
+	if (!tp->fastopen_rsk) {
+		mptcp_reinject_data(sk, 1);
+		mptcp_set_rto(sk);
+	}
+}
+
+/* Modify values to an mptcp-level for the initial window of new subflows =
*/
+void mptcp_select_initial_window(const struct sock *sk, int __space,
+				 __u32 mss, __u32 *rcv_wnd,
+				 __u32 *window_clamp, int wscale_ok,
+				 __u8 *rcv_wscale, __u32 init_rcv_wnd)
+{
+	struct mptcp_cb *mpcb =3D tcp_sk(sk)->mpcb;
+
+	*window_clamp =3D mpcb->orig_window_clamp;
+	__space =3D tcp_win_from_space(sk, mpcb->orig_sk_rcvbuf);
+
+	tcp_select_initial_window(sk, __space, mss, rcv_wnd, window_clamp,
+				  wscale_ok, rcv_wscale, init_rcv_wnd);
+}
+
+static inline u64 mptcp_calc_rate(const struct sock *meta_sk, unsigned int=
 mss,
+				  unsigned int (*mss_cb)(struct sock *sk))
+{
+	struct sock *sk;
+	u64 rate =3D 0;
+
+	mptcp_for_each_sk(tcp_sk(meta_sk)->mpcb, sk) {
+		struct tcp_sock *tp =3D tcp_sk(sk);
+		int this_mss;
+		u64 this_rate;
+
+		if (!mptcp_sk_can_send(sk))
+			continue;
+
+		/* Do not consider subflows without a RTT estimation yet
+		 * otherwise this_rate >>> rate.
+		 */
+		if (unlikely(!tp->srtt_us))
+			continue;
+
+		this_mss =3D mss_cb(sk);
+
+		/* If this_mss is smaller than mss, it means that a segment will
+		 * be split in two (or more) when pushed on this subflow. If
+		 * you consider that mss =3D 1428 and this_mss =3D 1420 then two
+		 * segments will be generated: a 1420-byte and 8-byte segment.
+		 * The latter will introduce a large overhead as for a single
+		 * data segment 2 slots will be used in the congestion window.
+		 * Therefore reducing by ~2 the potential throughput of this
+		 * subflow. Indeed, 1428 will be send while 2840 could have been
+		 * sent if mss =3D=3D 1420 reducing the throughput by 2840 / 1428.
+		 *
+		 * The following algorithm take into account this overhead
+		 * when computing the potential throughput that MPTCP can
+		 * achieve when generating mss-byte segments.
+		 *
+		 * The formulae is the following:
+		 *  \sum_{\forall sub} ratio * \frac{mss * cwnd_sub}{rtt_sub}
+		 * Where ratio is computed as follows:
+		 *  \frac{mss}{\ceil{mss / mss_sub} * mss_sub}
+		 *
+		 * ratio gives the reduction factor of the theoretical
+		 * throughput a subflow can achieve if MPTCP uses a specific
+		 * MSS value.
+		 */
+		this_rate =3D div64_u64((u64)mss * mss * (USEC_PER_SEC << 3) *
+				      max(tp->snd_cwnd, tp->packets_out),
+				      (u64)tp->srtt_us *
+				      DIV_ROUND_UP(mss, this_mss) * this_mss);
+		rate +=3D this_rate;
+	}
+
+	return rate;
+}
+
+static unsigned int __mptcp_current_mss(const struct sock *meta_sk,
+					unsigned int (*mss_cb)(struct sock *sk))
+{
+	unsigned int mss =3D 0;
+	u64 rate =3D 0;
+	struct sock *sk;
+
+	mptcp_for_each_sk(tcp_sk(meta_sk)->mpcb, sk) {
+		int this_mss;
+		u64 this_rate;
+
+		if (!mptcp_sk_can_send(sk))
+			continue;
+
+		this_mss =3D mss_cb(sk);
+
+		/* Same mss values will produce the same throughput. */
+		if (this_mss =3D=3D mss)
+			continue;
+
+		/* See whether using this mss value can theoretically improve
+		 * the performances.
+		 */
+		this_rate =3D mptcp_calc_rate(meta_sk, this_mss, mss_cb);
+		if (this_rate >=3D rate) {
+			mss =3D this_mss;
+			rate =3D this_rate;
+		}
+	}
+
+	return mss;
+}
+
+unsigned int mptcp_current_mss(struct sock *meta_sk)
+{
+	unsigned int mss =3D __mptcp_current_mss(meta_sk, tcp_current_mss);
+
+	/* If no subflow is available, we take a default-mss from the
+	 * meta-socket.
+	 */
+	return !mss ? tcp_current_mss(meta_sk) : mss;
+}
+
+static unsigned int mptcp_select_size_mss(struct sock *sk)
+{
+	return tcp_sk(sk)->mss_cache;
+}
+
+int mptcp_select_size(const struct sock *meta_sk, bool sg,
+		      bool first_skb, bool zc)
+{
+	/* RCHK This has changed -- fix it */
+	unsigned int mss =3D __mptcp_current_mss(meta_sk, mptcp_select_size_mss);
+
+	if (sg) {
+		if (mptcp_sk_can_gso(meta_sk)) {
+			mss =3D SKB_WITH_OVERHEAD(2048 - MAX_TCP_HEADER);
+		} else {
+			int pgbreak =3D SKB_MAX_HEAD(MAX_TCP_HEADER);
+
+			if (mss >=3D pgbreak &&
+			    mss <=3D pgbreak + (MAX_SKB_FRAGS - 1) * PAGE_SIZE)
+				mss =3D pgbreak;
+		}
+	}
+
+	return !mss ? tcp_sk(meta_sk)->mss_cache : mss;
+}
+
+int mptcp_check_snd_buf(const struct tcp_sock *tp)
+{
+	const struct sock *sk;
+	u32 rtt_max =3D tp->srtt_us;
+	u64 bw_est;
+
+	if (!tp->srtt_us)
+		return tp->reordering + 1;
+
+	mptcp_for_each_sk(tp->mpcb, sk) {
+		if (!mptcp_sk_can_send(sk))
+			continue;
+
+		if (rtt_max < tcp_sk(sk)->srtt_us)
+			rtt_max =3D tcp_sk(sk)->srtt_us;
+	}
+
+	bw_est =3D div64_u64(((u64)tp->snd_cwnd * rtt_max) << 16,
+			   (u64)tp->srtt_us);
+
+	return max_t(unsigned int, (u32)(bw_est >> 16),
+			tp->reordering + 1);
+}
+
+unsigned int mptcp_xmit_size_goal(const struct sock *meta_sk, u32 mss_now,
+				  int large_allowed)
+{
+	struct sock *sk;
+	u32 xmit_size_goal =3D 0;
+
+	if (large_allowed && mptcp_sk_can_gso(meta_sk)) {
+		mptcp_for_each_sk(tcp_sk(meta_sk)->mpcb, sk) {
+			int this_size_goal;
+
+			if (!mptcp_sk_can_send(sk))
+				continue;
+
+			this_size_goal =3D tcp_xmit_size_goal(sk, mss_now, 1);
+			if (this_size_goal > xmit_size_goal)
+				xmit_size_goal =3D this_size_goal;
+		}
+	}
+
+	return max(xmit_size_goal, mss_now);
+}
+
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
diff --git a/net/mptcp/mptcp_pm.c b/net/mptcp/mptcp_pm.c
new file mode 100644
index 0000000..5b18b59
--- /dev/null
+++ b/net/mptcp/mptcp_pm.c
@@ -0,0 +1,178 @@
+/*
+ *     MPTCP implementation - MPTCP-subflow-management
+ *
+ *     Initial Design & Implementation:
+ *     S=C3=A9bastien Barr=C3=A9 <sebastien.barre(a)uclouvain.be>
+ *
+ *     Current Maintainer & Author:
+ *     Christoph Paasch <christoph.paasch(a)uclouvain.be>
+ *
+ *     Additional authors:
+ *     Jaakko Korkeaniemi <jaakko.korkeaniemi(a)aalto.fi>
+ *     Gregory Detal <gregory.detal(a)uclouvain.be>
+ *     Fabien Duch=C3=AAne <fabien.duchene(a)uclouvain.be>
+ *     Andreas Seelinger <Andreas.Seelinger(a)rwth-aachen.de>
+ *     Lavkesh Lahngir <lavkesh51(a)gmail.com>
+ *     Andreas Ripke <ripke(a)neclab.eu>
+ *     Vlad Dogaru <vlad.dogaru(a)intel.com>
+ *     Octavian Purdila <octavian.purdila(a)intel.com>
+ *     John Ronan <jronan(a)tssg.org>
+ *     Catalin Nicutar <catalin.nicutar(a)gmail.com>
+ *     Brandon Heller <brandonh(a)stanford.edu>
+ *
+ *
+ *     This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+
+
+#include <linux/module.h>
+#include <net/mptcp.h>
+
+static DEFINE_SPINLOCK(mptcp_pm_list_lock);
+static LIST_HEAD(mptcp_pm_list);
+
+static int mptcp_default_id(sa_family_t family, union inet_addr *addr,
+			    struct net *net, bool *low_prio)
+{
+	return 0;
+}
+
+struct mptcp_pm_ops mptcp_pm_default =3D {
+	.get_local_id =3D mptcp_default_id, /* We do not care */
+	.name =3D "default",
+	.owner =3D THIS_MODULE,
+};
+
+static struct mptcp_pm_ops *mptcp_pm_find(const char *name)
+{
+	struct mptcp_pm_ops *e;
+
+	list_for_each_entry_rcu(e, &mptcp_pm_list, list) {
+		if (strcmp(e->name, name) =3D=3D 0)
+			return e;
+	}
+
+	return NULL;
+}
+
+int mptcp_register_path_manager(struct mptcp_pm_ops *pm)
+{
+	int ret =3D 0;
+
+	if (!pm->get_local_id)
+		return -EINVAL;
+
+	spin_lock(&mptcp_pm_list_lock);
+	if (mptcp_pm_find(pm->name)) {
+		pr_notice("%s already registered\n", pm->name);
+		ret =3D -EEXIST;
+	} else {
+		list_add_tail_rcu(&pm->list, &mptcp_pm_list);
+		pr_info("%s registered\n", pm->name);
+	}
+	spin_unlock(&mptcp_pm_list_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mptcp_register_path_manager);
+
+void mptcp_unregister_path_manager(struct mptcp_pm_ops *pm)
+{
+	spin_lock(&mptcp_pm_list_lock);
+	list_del_rcu(&pm->list);
+	spin_unlock(&mptcp_pm_list_lock);
+
+	/* Wait for outstanding readers to complete before the
+	 * module gets removed entirely.
+	 *
+	 * A try_module_get() should fail by now as our module is
+	 * in "going" state since no refs are held anymore and
+	 * module_exit() handler being called.
+	 */
+	synchronize_rcu();
+}
+EXPORT_SYMBOL_GPL(mptcp_unregister_path_manager);
+
+void mptcp_get_default_path_manager(char *name)
+{
+	struct mptcp_pm_ops *pm;
+
+	BUG_ON(list_empty(&mptcp_pm_list));
+
+	rcu_read_lock();
+	pm =3D list_entry(mptcp_pm_list.next, struct mptcp_pm_ops, list);
+	strncpy(name, pm->name, MPTCP_PM_NAME_MAX);
+	rcu_read_unlock();
+}
+
+int mptcp_set_default_path_manager(const char *name)
+{
+	struct mptcp_pm_ops *pm;
+	int ret =3D -ENOENT;
+
+	spin_lock(&mptcp_pm_list_lock);
+	pm =3D mptcp_pm_find(name);
+#ifdef CONFIG_MODULES
+	if (!pm && capable(CAP_NET_ADMIN)) {
+		spin_unlock(&mptcp_pm_list_lock);
+
+		request_module("mptcp_%s", name);
+		spin_lock(&mptcp_pm_list_lock);
+		pm =3D mptcp_pm_find(name);
+	}
+#endif
+
+	if (pm) {
+		list_move(&pm->list, &mptcp_pm_list);
+		ret =3D 0;
+	} else {
+		pr_info("%s is not available\n", name);
+	}
+	spin_unlock(&mptcp_pm_list_lock);
+
+	return ret;
+}
+
+void mptcp_init_path_manager(struct mptcp_cb *mpcb)
+{
+	struct mptcp_pm_ops *pm;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(pm, &mptcp_pm_list, list) {
+		if (try_module_get(pm->owner)) {
+			mpcb->pm_ops =3D pm;
+			break;
+		}
+	}
+	rcu_read_unlock();
+}
+
+/* Manage refcounts on socket close. */
+void mptcp_cleanup_path_manager(struct mptcp_cb *mpcb)
+{
+	module_put(mpcb->pm_ops->owner);
+}
+
+/* Fallback to the default path-manager. */
+void mptcp_fallback_default(struct mptcp_cb *mpcb)
+{
+	struct mptcp_pm_ops *pm;
+
+	mptcp_cleanup_path_manager(mpcb);
+	pm =3D mptcp_pm_find("default");
+
+	/* Cannot fail - it's the default module */
+	try_module_get(pm->owner);
+	mpcb->pm_ops =3D pm;
+}
+EXPORT_SYMBOL_GPL(mptcp_fallback_default);
+
+/* Set default value from kernel configuration at bootup */
+static int __init mptcp_path_manager_default(void)
+{
+	return mptcp_set_default_path_manager(CONFIG_DEFAULT_MPTCP_PM);
+}
+late_initcall(mptcp_path_manager_default);
diff --git a/net/mptcp/mptcp_redundant.c b/net/mptcp/mptcp_redundant.c
new file mode 100644
index 0000000..37a13f4
--- /dev/null
+++ b/net/mptcp/mptcp_redundant.c
@@ -0,0 +1,268 @@
+/*
+ *	MPTCP Scheduler to reduce latency and jitter.
+ *
+ *	This scheduler sends all packets redundantly on all available subflows.
+ *
+ *	Initial Design & Implementation:
+ *	Tobias Erbshaeusser <erbshauesser(a)dvs.tu-darmstadt.de>
+ *	Alexander Froemmgen <froemmge(a)dvs.tu-darmstadt.de>
+ *
+ *	Initial corrections & modifications:
+ *	Christian Pinedo <christian.pinedo(a)ehu.eus>
+ *	Igor Lopez <igor.lopez(a)ehu.eus>
+ *
+ *	This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <net/mptcp.h>
+
+/* Struct to store the data of a single subflow */
+struct redsched_sock_data {
+	/* The skb or NULL */
+	struct sk_buff *skb;
+	/* End sequence number of the skb. This number should be checked
+	 * to be valid before the skb field is used
+	 */
+	u32 skb_end_seq;
+};
+
+/* Struct to store the data of the control block */
+struct redsched_cb_data {
+	/* The next subflow where a skb should be sent or NULL */
+	struct tcp_sock *next_subflow;
+};
+
+/* Returns the socket data from a given subflow socket */
+static struct redsched_sock_data *redsched_get_sock_data(struct tcp_sock *=
tp)
+{
+	return (struct redsched_sock_data *)&tp->mptcp->mptcp_sched[0];
+}
+
+/* Returns the control block data from a given meta socket */
+static struct redsched_cb_data *redsched_get_cb_data(struct tcp_sock *tp)
+{
+	return (struct redsched_cb_data *)&tp->mpcb->mptcp_sched[0];
+}
+
+static bool redsched_get_active_valid_sks(struct sock *meta_sk)
+{
+	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
+	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
+	struct sock *sk;
+	int active_valid_sks =3D 0;
+
+	mptcp_for_each_sk(mpcb, sk) {
+		if (subflow_is_active((struct tcp_sock *)sk) &&
+		    !mptcp_is_def_unavailable(sk))
+			active_valid_sks++;
+	}
+
+	return active_valid_sks;
+}
+
+static bool redsched_use_subflow(struct sock *meta_sk,
+				 int active_valid_sks,
+				 struct tcp_sock *tp,
+				 struct sk_buff *skb)
+{
+	if (!skb || !mptcp_is_available((struct sock *)tp, skb, false))
+		return false;
+
+	if (TCP_SKB_CB(skb)->mptcp_path_mask !=3D 0)
+		return subflow_is_active(tp);
+
+	if (TCP_SKB_CB(skb)->mptcp_path_mask =3D=3D 0) {
+		if (active_valid_sks =3D=3D -1)
+			active_valid_sks =3D redsched_get_active_valid_sks(meta_sk);
+
+		if (subflow_is_backup(tp) && active_valid_sks > 0)
+			return false;
+		else
+			return true;
+	}
+
+	return false;
+}
+
+static struct sock *redundant_get_subflow(struct sock *meta_sk,
+					  struct sk_buff *skb,
+					  bool zero_wnd_test)
+{
+	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
+	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
+	struct redsched_cb_data *cb_data =3D redsched_get_cb_data(meta_tp);
+	struct tcp_sock *first_tp =3D cb_data->next_subflow;
+	struct sock *sk;
+	struct tcp_sock *tp;
+
+	/* Answer data_fin on same subflow */
+	if (meta_sk->sk_shutdown & RCV_SHUTDOWN &&
+	    skb && mptcp_is_data_fin(skb)) {
+		mptcp_for_each_sk(mpcb, sk) {
+			if (tcp_sk(sk)->mptcp->path_index =3D=3D
+				mpcb->dfin_path_index &&
+			    mptcp_is_available(sk, skb, zero_wnd_test))
+				return sk;
+		}
+	}
+
+	if (!first_tp)
+		first_tp =3D mpcb->connection_list;
+	tp =3D first_tp;
+
+	/* Search for any subflow to send it */
+	do {
+		if (mptcp_is_available((struct sock *)tp, skb,
+				       zero_wnd_test)) {
+			cb_data->next_subflow =3D tp->mptcp->next;
+			return (struct sock *)tp;
+		}
+
+		tp =3D tp->mptcp->next;
+		if (!tp)
+			tp =3D mpcb->connection_list;
+	} while (tp !=3D first_tp);
+
+	/* No space */
+	return NULL;
+}
+
+/* Corrects the stored skb pointers if they are invalid */
+static void redsched_correct_skb_pointers(struct sock *meta_sk,
+					  struct redsched_sock_data *sk_data)
+{
+	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
+
+	if (sk_data->skb && !after(sk_data->skb_end_seq, meta_tp->snd_una))
+		sk_data->skb =3D NULL;
+}
+
+/* Returns the next skb from the queue */
+static struct sk_buff *redundant_next_skb_from_queue(struct sk_buff_head *=
queue,
+						     struct sk_buff *previous)
+{
+	if (skb_queue_empty(queue))
+		return NULL;
+
+	if (!previous)
+		return skb_peek(queue);
+
+	if (skb_queue_is_last(queue, previous))
+		return NULL;
+
+	return skb_queue_next(queue, previous);
+}
+
+static struct sk_buff *redundant_next_segment(struct sock *meta_sk,
+					      int *reinject,
+					      struct sock **subsk,
+					      unsigned int *limit)
+{
+	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
+	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
+	struct redsched_cb_data *cb_data =3D redsched_get_cb_data(meta_tp);
+	struct tcp_sock *first_tp =3D cb_data->next_subflow;
+	struct tcp_sock *tp;
+	struct sk_buff *skb;
+	int active_valid_sks =3D -1;
+
+	if (skb_queue_empty(&mpcb->reinject_queue) &&
+	    skb_queue_empty(&meta_sk->sk_write_queue))
+		/* Nothing to send */
+		return NULL;
+
+	/* First try reinjections */
+	skb =3D skb_peek(&mpcb->reinject_queue);
+	if (skb) {
+		*subsk =3D get_available_subflow(meta_sk, skb, false);
+		if (!*subsk)
+			return NULL;
+		*reinject =3D 1;
+		return skb;
+	}
+
+	/* Then try indistinctly redundant and normal skbs */
+
+	if (!first_tp)
+		first_tp =3D mpcb->connection_list;
+	tp =3D first_tp;
+
+	*reinject =3D 0;
+	active_valid_sks =3D redsched_get_active_valid_sks(meta_sk);
+	do {
+		struct redsched_sock_data *sk_data;
+
+		/* Correct the skb pointers of the current subflow */
+		sk_data =3D redsched_get_sock_data(tp);
+		redsched_correct_skb_pointers(meta_sk, sk_data);
+
+		skb =3D redundant_next_skb_from_queue(&meta_sk->sk_write_queue,
+						    sk_data->skb);
+		if (skb && redsched_use_subflow(meta_sk, active_valid_sks, tp,
+						skb)) {
+			sk_data->skb =3D skb;
+			sk_data->skb_end_seq =3D TCP_SKB_CB(skb)->end_seq;
+			cb_data->next_subflow =3D tp->mptcp->next;
+			*subsk =3D (struct sock *)tp;
+
+			if (TCP_SKB_CB(skb)->mptcp_path_mask)
+				*reinject =3D -1;
+			return skb;
+		}
+
+		tp =3D tp->mptcp->next;
+		if (!tp)
+			tp =3D mpcb->connection_list;
+	} while (tp !=3D first_tp);
+
+	/* Nothing to send */
+	return NULL;
+}
+
+static void redundant_release(struct sock *sk)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct redsched_cb_data *cb_data =3D redsched_get_cb_data(tp);
+
+	/* Check if the next subflow would be the released one. If yes correct
+	 * the pointer
+	 */
+	if (cb_data->next_subflow =3D=3D tp)
+		cb_data->next_subflow =3D tp->mptcp->next;
+}
+
+struct mptcp_sched_ops mptcp_sched_redundant =3D {
+	.get_subflow =3D redundant_get_subflow,
+	.next_segment =3D redundant_next_segment,
+	.release =3D redundant_release,
+	.name =3D "redundant",
+	.owner =3D THIS_MODULE,
+};
+
+static int __init redundant_register(void)
+{
+	BUILD_BUG_ON(sizeof(struct redsched_sock_data) > MPTCP_SCHED_SIZE);
+	BUILD_BUG_ON(sizeof(struct redsched_cb_data) > MPTCP_SCHED_DATA_SIZE);
+
+	if (mptcp_register_scheduler(&mptcp_sched_redundant))
+		return -1;
+
+	return 0;
+}
+
+static void redundant_unregister(void)
+{
+	mptcp_unregister_scheduler(&mptcp_sched_redundant);
+}
+
+module_init(redundant_register);
+module_exit(redundant_unregister);
+
+MODULE_AUTHOR("Tobias Erbshaeusser, Alexander Froemmgen");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("REDUNDANT MPTCP");
+MODULE_VERSION("0.90");
diff --git a/net/mptcp/mptcp_rr.c b/net/mptcp/mptcp_rr.c
new file mode 100644
index 0000000..83837f2
--- /dev/null
+++ b/net/mptcp/mptcp_rr.c
@@ -0,0 +1,301 @@
+/* MPTCP Scheduler module selector. Highly inspired by tcp_cong.c */
+
+#include <linux/module.h>
+#include <net/mptcp.h>
+
+static unsigned char num_segments __read_mostly =3D 1;
+module_param(num_segments, byte, 0644);
+MODULE_PARM_DESC(num_segments, "The number of consecutive segments that ar=
e part of a burst");
+
+static bool cwnd_limited __read_mostly =3D 1;
+module_param(cwnd_limited, bool, 0644);
+MODULE_PARM_DESC(cwnd_limited, "if set to 1, the scheduler tries to fill t=
he congestion-window on all subflows");
+
+struct rrsched_priv {
+	unsigned char quota;
+};
+
+static struct rrsched_priv *rrsched_get_priv(const struct tcp_sock *tp)
+{
+	return (struct rrsched_priv *)&tp->mptcp->mptcp_sched[0];
+}
+
+/* If the sub-socket sk available to send the skb? */
+static bool mptcp_rr_is_available(const struct sock *sk, const struct sk_b=
uff *skb,
+				  bool zero_wnd_test, bool cwnd_test)
+{
+	const struct tcp_sock *tp =3D tcp_sk(sk);
+	unsigned int space, in_flight;
+
+	/* Set of states for which we are allowed to send data */
+	if (!mptcp_sk_can_send(sk))
+		return false;
+
+	/* We do not send data on this subflow unless it is
+	 * fully established, i.e. the 4th ack has been received.
+	 */
+	if (tp->mptcp->pre_established)
+		return false;
+
+	if (tp->pf)
+		return false;
+
+	if (inet_csk(sk)->icsk_ca_state =3D=3D TCP_CA_Loss) {
+		/* If SACK is disabled, and we got a loss, TCP does not exit
+		 * the loss-state until something above high_seq has been acked.
+		 * (see tcp_try_undo_recovery)
+		 *
+		 * high_seq is the snd_nxt at the moment of the RTO. As soon
+		 * as we have an RTO, we won't push data on the subflow.
+		 * Thus, snd_una can never go beyond high_seq.
+		 */
+		if (!tcp_is_reno(tp))
+			return false;
+		else if (tp->snd_una !=3D tp->high_seq)
+			return false;
+	}
+
+	if (!tp->mptcp->fully_established) {
+		/* Make sure that we send in-order data */
+		if (skb && tp->mptcp->second_packet &&
+		    tp->mptcp->last_end_data_seq !=3D TCP_SKB_CB(skb)->seq)
+			return false;
+	}
+
+	if (!cwnd_test)
+		goto zero_wnd_test;
+
+	in_flight =3D tcp_packets_in_flight(tp);
+	/* Not even a single spot in the cwnd */
+	if (in_flight >=3D tp->snd_cwnd)
+		return false;
+
+	/* Now, check if what is queued in the subflow's send-queue
+	 * already fills the cwnd.
+	 */
+	space =3D (tp->snd_cwnd - in_flight) * tp->mss_cache;
+
+	if (tp->write_seq - tp->snd_nxt > space)
+		return false;
+
+zero_wnd_test:
+	if (zero_wnd_test && !before(tp->write_seq, tcp_wnd_end(tp)))
+		return false;
+
+	return true;
+}
+
+/* Are we not allowed to reinject this skb on tp? */
+static int mptcp_rr_dont_reinject_skb(const struct tcp_sock *tp, const str=
uct sk_buff *skb)
+{
+	/* If the skb has already been enqueued in this sk, try to find
+	 * another one.
+	 */
+	return skb &&
+		/* Has the skb already been enqueued into this subsocket? */
+		mptcp_pi_to_flag(tp->mptcp->path_index) & TCP_SKB_CB(skb)->mptcp_path_ma=
sk;
+}
+
+/* We just look for any subflow that is available */
+static struct sock *rr_get_available_subflow(struct sock *meta_sk,
+					     struct sk_buff *skb,
+					     bool zero_wnd_test)
+{
+	const struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
+	struct sock *sk, *bestsk =3D NULL, *backupsk =3D NULL;
+
+	/* Answer data_fin on same subflow!!! */
+	if (meta_sk->sk_shutdown & RCV_SHUTDOWN &&
+	    skb && mptcp_is_data_fin(skb)) {
+		mptcp_for_each_sk(mpcb, sk) {
+			if (tcp_sk(sk)->mptcp->path_index =3D=3D mpcb->dfin_path_index &&
+			    mptcp_rr_is_available(sk, skb, zero_wnd_test, true))
+				return sk;
+		}
+	}
+
+	/* First, find the best subflow */
+	mptcp_for_each_sk(mpcb, sk) {
+		struct tcp_sock *tp =3D tcp_sk(sk);
+
+		if (!mptcp_rr_is_available(sk, skb, zero_wnd_test, true))
+			continue;
+
+		if (mptcp_rr_dont_reinject_skb(tp, skb)) {
+			backupsk =3D sk;
+			continue;
+		}
+
+		bestsk =3D sk;
+	}
+
+	if (bestsk) {
+		sk =3D bestsk;
+	} else if (backupsk) {
+		/* It has been sent on all subflows once - let's give it a
+		 * chance again by restarting its pathmask.
+		 */
+		if (skb)
+			TCP_SKB_CB(skb)->mptcp_path_mask =3D 0;
+		sk =3D backupsk;
+	}
+
+	return sk;
+}
+
+/* Returns the next segment to be sent from the mptcp meta-queue.
+ * (chooses the reinject queue if any segment is waiting in it, otherwise,
+ * chooses the normal write queue).
+ * Sets *@reinject to 1 if the returned segment comes from the
+ * reinject queue. Sets it to 0 if it is the regular send-head of the meta=
-sk,
+ * and sets it to -1 if it is a meta-level retransmission to optimize the
+ * receive-buffer.
+ */
+static struct sk_buff *__mptcp_rr_next_segment(const struct sock *meta_sk,=
 int *reinject)
+{
+	const struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
+	struct sk_buff *skb =3D NULL;
+
+	*reinject =3D 0;
+
+	/* If we are in fallback-mode, just take from the meta-send-queue */
+	if (mpcb->infinite_mapping_snd || mpcb->send_infinite_mapping)
+		return tcp_send_head(meta_sk);
+
+	skb =3D skb_peek(&mpcb->reinject_queue);
+
+	if (skb)
+		*reinject =3D 1;
+	else
+		skb =3D tcp_send_head(meta_sk);
+	return skb;
+}
+
+static struct sk_buff *mptcp_rr_next_segment(struct sock *meta_sk,
+					     int *reinject,
+					     struct sock **subsk,
+					     unsigned int *limit)
+{
+	const struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
+	struct sock *sk_it, *choose_sk =3D NULL;
+	struct sk_buff *skb =3D __mptcp_rr_next_segment(meta_sk, reinject);
+	unsigned char split =3D num_segments;
+	unsigned char iter =3D 0, full_subs =3D 0;
+
+	/* As we set it, we have to reset it as well. */
+	*limit =3D 0;
+
+	if (!skb)
+		return NULL;
+
+	if (*reinject) {
+		*subsk =3D rr_get_available_subflow(meta_sk, skb, false);
+		if (!*subsk)
+			return NULL;
+
+		return skb;
+	}
+
+retry:
+
+	/* First, we look for a subflow who is currently being used */
+	mptcp_for_each_sk(mpcb, sk_it) {
+		struct tcp_sock *tp_it =3D tcp_sk(sk_it);
+		struct rrsched_priv *rsp =3D rrsched_get_priv(tp_it);
+
+		if (!mptcp_rr_is_available(sk_it, skb, false, cwnd_limited))
+			continue;
+
+		iter++;
+
+		/* Is this subflow currently being used? */
+		if (rsp->quota > 0 && rsp->quota < num_segments) {
+			split =3D num_segments - rsp->quota;
+			choose_sk =3D sk_it;
+			goto found;
+		}
+
+		/* Or, it's totally unused */
+		if (!rsp->quota) {
+			split =3D num_segments;
+			choose_sk =3D sk_it;
+		}
+
+		/* Or, it must then be fully used  */
+		if (rsp->quota >=3D num_segments)
+			full_subs++;
+	}
+
+	/* All considered subflows have a full quota, and we considered at
+	 * least one.
+	 */
+	if (iter && iter =3D=3D full_subs) {
+		/* So, we restart this round by setting quota to 0 and retry
+		 * to find a subflow.
+		 */
+		mptcp_for_each_sk(mpcb, sk_it) {
+			struct tcp_sock *tp_it =3D tcp_sk(sk_it);
+			struct rrsched_priv *rsp =3D rrsched_get_priv(tp_it);
+
+			if (!mptcp_rr_is_available(sk_it, skb, false, cwnd_limited))
+				continue;
+
+			rsp->quota =3D 0;
+		}
+
+		goto retry;
+	}
+
+found:
+	if (choose_sk) {
+		unsigned int mss_now;
+		struct tcp_sock *choose_tp =3D tcp_sk(choose_sk);
+		struct rrsched_priv *rsp =3D rrsched_get_priv(choose_tp);
+
+		if (!mptcp_rr_is_available(choose_sk, skb, false, true))
+			return NULL;
+
+		*subsk =3D choose_sk;
+		mss_now =3D tcp_current_mss(*subsk);
+		*limit =3D split * mss_now;
+
+		if (skb->len > mss_now)
+			rsp->quota +=3D DIV_ROUND_UP(skb->len, mss_now);
+		else
+			rsp->quota++;
+
+		return skb;
+	}
+
+	return NULL;
+}
+
+static struct mptcp_sched_ops mptcp_sched_rr =3D {
+	.get_subflow =3D rr_get_available_subflow,
+	.next_segment =3D mptcp_rr_next_segment,
+	.name =3D "roundrobin",
+	.owner =3D THIS_MODULE,
+};
+
+static int __init rr_register(void)
+{
+	BUILD_BUG_ON(sizeof(struct rrsched_priv) > MPTCP_SCHED_SIZE);
+
+	if (mptcp_register_scheduler(&mptcp_sched_rr))
+		return -1;
+
+	return 0;
+}
+
+static void rr_unregister(void)
+{
+	mptcp_unregister_scheduler(&mptcp_sched_rr);
+}
+
+module_init(rr_register);
+module_exit(rr_unregister);
+
+MODULE_AUTHOR("Christoph Paasch");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("ROUNDROBIN MPTCP");
+MODULE_VERSION("0.89");
diff --git a/net/mptcp/mptcp_sched.c b/net/mptcp/mptcp_sched.c
new file mode 100644
index 0000000..0d45296
--- /dev/null
+++ b/net/mptcp/mptcp_sched.c
@@ -0,0 +1,597 @@
+/* MPTCP Scheduler module selector. Highly inspired by tcp_cong.c */
+
+#include <linux/module.h>
+#include <net/mptcp.h>
+
+static DEFINE_SPINLOCK(mptcp_sched_list_lock);
+static LIST_HEAD(mptcp_sched_list);
+
+struct defsched_priv {
+	u32	last_rbuf_opti;
+};
+
+static struct defsched_priv *defsched_get_priv(const struct tcp_sock *tp)
+{
+	return (struct defsched_priv *)&tp->mptcp->mptcp_sched[0];
+}
+
+bool mptcp_is_def_unavailable(struct sock *sk)
+{
+	const struct tcp_sock *tp =3D tcp_sk(sk);
+
+	/* Set of states for which we are allowed to send data */
+	if (!mptcp_sk_can_send(sk))
+		return true;
+
+	/* We do not send data on this subflow unless it is
+	 * fully established, i.e. the 4th ack has been received.
+	 */
+	if (tp->mptcp->pre_established)
+		return true;
+
+	if (tp->pf)
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(mptcp_is_def_unavailable);
+
+static bool mptcp_is_temp_unavailable(struct sock *sk,
+				      const struct sk_buff *skb,
+				      bool zero_wnd_test)
+{
+	const struct tcp_sock *tp =3D tcp_sk(sk);
+	unsigned int mss_now, space, in_flight;
+
+	if (inet_csk(sk)->icsk_ca_state =3D=3D TCP_CA_Loss) {
+		/* If SACK is disabled, and we got a loss, TCP does not exit
+		 * the loss-state until something above high_seq has been
+		 * acked. (see tcp_try_undo_recovery)
+		 *
+		 * high_seq is the snd_nxt at the moment of the RTO. As soon
+		 * as we have an RTO, we won't push data on the subflow.
+		 * Thus, snd_una can never go beyond high_seq.
+		 */
+		if (!tcp_is_reno(tp))
+			return(true);
+		else if (tp->snd_una !=3D tp->high_seq)
+			return true;
+	}
+
+	if (!tp->mptcp->fully_established) {
+		/* Make sure that we send in-order data */
+		if (skb && tp->mptcp->second_packet &&
+		    tp->mptcp->last_end_data_seq !=3D TCP_SKB_CB(skb)->seq)
+			return true;
+	}
+
+	/* If TSQ is already throttling us, do not send on this subflow. When
+	 * TSQ gets cleared the subflow becomes eligible again.
+	 */
+	if (test_bit(TSQF_THROTTLED, &sk->sk_tsq_flags))
+		return true;
+
+	in_flight =3D tcp_packets_in_flight(tp);
+	/* Not even a single spot in the cwnd */
+	if (in_flight >=3D tp->snd_cwnd)
+		return true;
+
+	/* Now, check if what is queued in the subflow's send-queue
+	 * already fills the cwnd.
+	 */
+	space =3D (tp->snd_cwnd - in_flight) * tp->mss_cache;
+
+	if (tp->write_seq - tp->snd_nxt > space)
+		return true;
+
+	if (zero_wnd_test && !before(tp->write_seq, tcp_wnd_end(tp)))
+		return true;
+
+	mss_now =3D tcp_current_mss(sk);
+
+	/* Don't send on this subflow if we bypass the allowed send-window at
+	 * the per-subflow level. Similar to tcp_snd_wnd_test, but manually
+	 * calculated end_seq (because here at this point end_seq is still at
+	 * the meta-level).
+	 */
+	if (skb && !zero_wnd_test &&
+	    after(tp->write_seq + min(skb->len, mss_now), tcp_wnd_end(tp)))
+		return true;
+
+	return false;
+}
+
+/* Is the sub-socket sk available to send the skb? */
+bool mptcp_is_available(struct sock *sk, const struct sk_buff *skb,
+			bool zero_wnd_test)
+{
+	return !mptcp_is_def_unavailable(sk) &&
+	       !mptcp_is_temp_unavailable(sk, skb, zero_wnd_test);
+}
+EXPORT_SYMBOL_GPL(mptcp_is_available);
+
+/* Are we not allowed to reinject this skb on tp? */
+static int mptcp_dont_reinject_skb(const struct tcp_sock *tp,
+				   const struct sk_buff *skb)
+{
+	/* If the skb has already been enqueued in this sk, try to find
+	 * another one.
+	 */
+	return skb &&
+		/* Has the skb already been enqueued into this subsocket? */
+		mptcp_pi_to_flag(tp->mptcp->path_index) &
+		TCP_SKB_CB(skb)->mptcp_path_mask;
+}
+
+bool subflow_is_backup(const struct tcp_sock *tp)
+{
+	return tp->mptcp->rcv_low_prio || tp->mptcp->low_prio;
+}
+EXPORT_SYMBOL_GPL(subflow_is_backup);
+
+bool subflow_is_active(const struct tcp_sock *tp)
+{
+	return !tp->mptcp->rcv_low_prio && !tp->mptcp->low_prio;
+}
+EXPORT_SYMBOL_GPL(subflow_is_active);
+
+/* Generic function to iterate over used and unused subflows and to select=
 the
+ * best one
+ */
+static struct sock
+*get_subflow_from_selectors(struct mptcp_cb *mpcb, struct sk_buff *skb,
+			    bool (*selector)(const struct tcp_sock *),
+			    bool zero_wnd_test, bool *force)
+{
+	struct sock *bestsk =3D NULL;
+	u32 min_srtt =3D 0xffffffff;
+	bool found_unused =3D false;
+	bool found_unused_una =3D false;
+	struct sock *sk;
+
+	mptcp_for_each_sk(mpcb, sk) {
+		struct tcp_sock *tp =3D tcp_sk(sk);
+		bool unused =3D false;
+
+		/* First, we choose only the wanted sks */
+		if (!(*selector)(tp))
+			continue;
+
+		if (!mptcp_dont_reinject_skb(tp, skb))
+			unused =3D true;
+		else if (found_unused)
+			/* If a unused sk was found previously, we continue -
+			 * no need to check used sks anymore.
+			 */
+			continue;
+
+		if (mptcp_is_def_unavailable(sk))
+			continue;
+
+		if (mptcp_is_temp_unavailable(sk, skb, zero_wnd_test)) {
+			if (unused)
+				found_unused_una =3D true;
+			continue;
+		}
+
+		if (unused) {
+			if (!found_unused) {
+				/* It's the first time we encounter an unused
+				 * sk - thus we reset the bestsk (which might
+				 * have been set to a used sk).
+				 */
+				min_srtt =3D 0xffffffff;
+				bestsk =3D NULL;
+			}
+			found_unused =3D true;
+		}
+
+		if (tp->srtt_us < min_srtt) {
+			min_srtt =3D tp->srtt_us;
+			bestsk =3D sk;
+		}
+	}
+
+	if (bestsk) {
+		/* The force variable is used to mark the returned sk as
+		 * previously used or not-used.
+		 */
+		if (found_unused)
+			*force =3D true;
+		else
+			*force =3D false;
+	} else {
+		/* The force variable is used to mark if there are temporally
+		 * unavailable not-used sks.
+		 */
+		if (found_unused_una)
+			*force =3D true;
+		else
+			*force =3D false;
+	}
+
+	return bestsk;
+}
+
+/* This is the scheduler. This function decides on which flow to send
+ * a given MSS. If all subflows are found to be busy, NULL is returned
+ * The flow is selected based on the shortest RTT.
+ * If all paths have full cong windows, we simply return NULL.
+ *
+ * Additionally, this function is aware of the backup-subflows.
+ */
+struct sock *get_available_subflow(struct sock *meta_sk, struct sk_buff *s=
kb,
+				   bool zero_wnd_test)
+{
+	struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
+	struct sock *sk;
+	bool force;
+
+	/* if there is only one subflow, bypass the scheduling function */
+	if (mpcb->cnt_subflows =3D=3D 1) {
+		sk =3D (struct sock *)mpcb->connection_list;
+		if (!mptcp_is_available(sk, skb, zero_wnd_test))
+			sk =3D NULL;
+		return sk;
+	}
+
+	/* Answer data_fin on same subflow!!! */
+	if (meta_sk->sk_shutdown & RCV_SHUTDOWN &&
+	    skb && mptcp_is_data_fin(skb)) {
+		mptcp_for_each_sk(mpcb, sk) {
+			if (tcp_sk(sk)->mptcp->path_index =3D=3D
+			    mpcb->dfin_path_index &&
+			    mptcp_is_available(sk, skb, zero_wnd_test))
+				return sk;
+		}
+	}
+
+	/* Find the best subflow */
+	sk =3D get_subflow_from_selectors(mpcb, skb, &subflow_is_active,
+					zero_wnd_test, &force);
+	if (force)
+		/* one unused active sk or one NULL sk when there is at least
+		 * one temporally unavailable unused active sk
+		 */
+		return sk;
+
+	sk =3D get_subflow_from_selectors(mpcb, skb, &subflow_is_backup,
+					zero_wnd_test, &force);
+	if (!force && skb)
+		/* one used backup sk or one NULL sk where there is no one
+		 * temporally unavailable unused backup sk
+		 *
+		 * the skb passed through all the available active and backups
+		 * sks, so clean the path mask
+		 */
+		TCP_SKB_CB(skb)->mptcp_path_mask =3D 0;
+	return sk;
+}
+EXPORT_SYMBOL_GPL(get_available_subflow);
+
+static struct sk_buff *mptcp_rcv_buf_optimization(struct sock *sk, int pen=
al)
+{
+	struct sock *meta_sk;
+	const struct tcp_sock *tp =3D tcp_sk(sk);
+	struct tcp_sock *tp_it;
+	struct sk_buff *skb_head;
+	struct defsched_priv *dsp =3D defsched_get_priv(tp);
+
+	if (tp->mpcb->cnt_subflows =3D=3D 1)
+		return NULL;
+
+	meta_sk =3D mptcp_meta_sk(sk);
+	skb_head =3D tcp_write_queue_head(meta_sk);
+
+	if (!skb_head || skb_head =3D=3D tcp_send_head(meta_sk))
+		return NULL;
+
+	/* If penalization is optional (coming from mptcp_next_segment() and
+	 * We are not send-buffer-limited we do not penalize. The retransmission
+	 * is just an optimization to fix the idle-time due to the delay before
+	 * we wake up the application.
+	 */
+	if (!penal && sk_stream_memory_free(meta_sk))
+		goto retrans;
+
+	/* Only penalize again after an RTT has elapsed */
+	if (tcp_time_stamp(tp) - dsp->last_rbuf_opti <
+	    usecs_to_jiffies(tp->srtt_us >> 3))
+		goto retrans;
+
+	/* Half the cwnd of the slow flow */
+	mptcp_for_each_tp(tp->mpcb, tp_it) {
+		if (tp_it !=3D tp &&
+		    TCP_SKB_CB(skb_head)->mptcp_path_mask &
+		    mptcp_pi_to_flag(tp_it->mptcp->path_index)) {
+			if (tp->srtt_us < tp_it->srtt_us &&
+			    inet_csk((struct sock *)tp_it)->icsk_ca_state =3D=3D
+				     TCP_CA_Open) {
+				u32 prior_cwnd =3D tp_it->snd_cwnd;
+
+				tp_it->snd_cwnd =3D
+				    max(tp_it->snd_cwnd >> 1U, 1U);
+
+				/* If in slow start, do not reduce ssthresh */
+				if (prior_cwnd >=3D tp_it->snd_ssthresh)
+					tp_it->snd_ssthresh =3D
+					max(tp_it->snd_ssthresh >> 1U, 2U);
+
+				dsp->last_rbuf_opti =3D tcp_time_stamp(tp_it);
+			}
+			break;
+		}
+	}
+
+retrans:
+
+	/* Segment not yet injected into this path? Take it!!! */
+	if (!(TCP_SKB_CB(skb_head)->mptcp_path_mask &
+	    mptcp_pi_to_flag(tp->mptcp->path_index))) {
+		bool do_retrans =3D false;
+
+		mptcp_for_each_tp(tp->mpcb, tp_it) {
+			if (tp_it !=3D tp &&
+			    TCP_SKB_CB(skb_head)->mptcp_path_mask &
+			    mptcp_pi_to_flag(tp_it->mptcp->path_index)) {
+				if (tp_it->snd_cwnd <=3D 4) {
+					do_retrans =3D true;
+					break;
+				}
+
+				if (4 * tp->srtt_us >=3D tp_it->srtt_us) {
+					do_retrans =3D false;
+					break;
+				}
+				do_retrans =3D true;
+			}
+		}
+
+		if (do_retrans && mptcp_is_available(sk, skb_head, false))
+			return skb_head;
+	}
+	return NULL;
+}
+
+/* Returns the next segment to be sent from the mptcp meta-queue.
+ * (chooses the reinject queue if any segment is waiting in it, otherwise,
+ * chooses the normal write queue).
+ * Sets *@reinject to 1 if the returned segment comes from the
+ * reinject queue. Sets it to 0 if it is the regular send-head of the meta=
-sk,
+ * and sets it to -1 if it is a meta-level retransmission to optimize the
+ * receive-buffer.
+ */
+static struct sk_buff *__mptcp_next_segment(struct sock *meta_sk, int *rei=
nject)
+{
+	const struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
+	struct sk_buff *skb =3D NULL;
+
+	*reinject =3D 0;
+
+	/* If we are in fallback-mode, just take from the meta-send-queue */
+	if (mpcb->infinite_mapping_snd || mpcb->send_infinite_mapping)
+		return tcp_send_head(meta_sk);
+
+	skb =3D skb_peek(&mpcb->reinject_queue);
+
+	if (skb) {
+		*reinject =3D 1;
+	} else {
+		skb =3D tcp_send_head(meta_sk);
+
+		if (!skb && meta_sk->sk_socket &&
+		    test_bit(SOCK_NOSPACE, &meta_sk->sk_socket->flags) &&
+		    sk_stream_wspace(meta_sk) < sk_stream_min_wspace(meta_sk)) {
+			struct sock *subsk;
+
+			subsk =3D get_available_subflow(meta_sk, NULL, false);
+			if (!subsk)
+				return NULL;
+
+			skb =3D mptcp_rcv_buf_optimization(subsk, 0);
+			if (skb)
+				*reinject =3D -1;
+		}
+	}
+	return skb;
+}
+
+static struct sk_buff *mptcp_next_segment(struct sock *meta_sk,
+					  int *reinject,
+					  struct sock **subsk,
+					  unsigned int *limit)
+{
+	struct sk_buff *skb =3D __mptcp_next_segment(meta_sk, reinject);
+	unsigned int mss_now;
+	struct tcp_sock *subtp;
+	u16 gso_max_segs;
+	u32 max_len, max_segs, window, needed;
+
+	/* As we set it, we have to reset it as well. */
+	*limit =3D 0;
+
+	if (!skb)
+		return NULL;
+
+	*subsk =3D get_available_subflow(meta_sk, skb, false);
+	if (!*subsk)
+		return NULL;
+
+	subtp =3D tcp_sk(*subsk);
+	mss_now =3D tcp_current_mss(*subsk);
+
+	if (!*reinject && unlikely(!tcp_snd_wnd_test(tcp_sk(meta_sk),
+						     skb, mss_now))) {
+		skb =3D mptcp_rcv_buf_optimization(*subsk, 1);
+		if (skb)
+			*reinject =3D -1;
+		else
+			return NULL;
+	}
+
+	/* No splitting required, as we will only send one single segment */
+	if (skb->len <=3D mss_now)
+		return skb;
+
+	/* The following is similar to tcp_mss_split_point, but
+	 * we do not care about nagle, because we will anyways
+	 * use TCP_NAGLE_PUSH, which overrides this.
+	 *
+	 * So, we first limit according to the cwnd/gso-size and then according
+	 * to the subflow's window.
+	 */
+
+	gso_max_segs =3D (*subsk)->sk_gso_max_segs;
+	if (!gso_max_segs) /* No gso supported on the subflow's NIC */
+		gso_max_segs =3D 1;
+	max_segs =3D min_t(unsigned int, tcp_cwnd_test(subtp, skb), gso_max_segs);
+	if (!max_segs)
+		return NULL;
+
+	max_len =3D mss_now * max_segs;
+	window =3D tcp_wnd_end(subtp) - subtp->write_seq;
+
+	needed =3D min(skb->len, window);
+	if (max_len <=3D skb->len)
+		/* Take max_win, which is actually the cwnd/gso-size */
+		*limit =3D max_len;
+	else
+		/* Or, take the window */
+		*limit =3D needed;
+
+	return skb;
+}
+
+static void defsched_init(struct sock *sk)
+{
+	struct defsched_priv *dsp =3D defsched_get_priv(tcp_sk(sk));
+
+	dsp->last_rbuf_opti =3D tcp_time_stamp(tcp_sk(sk));
+}
+
+struct mptcp_sched_ops mptcp_sched_default =3D {
+	.get_subflow =3D get_available_subflow,
+	.next_segment =3D mptcp_next_segment,
+	.init =3D defsched_init,
+	.name =3D "default",
+	.owner =3D THIS_MODULE,
+};
+
+static struct mptcp_sched_ops *mptcp_sched_find(const char *name)
+{
+	struct mptcp_sched_ops *e;
+
+	list_for_each_entry_rcu(e, &mptcp_sched_list, list) {
+		if (strcmp(e->name, name) =3D=3D 0)
+			return e;
+	}
+
+	return NULL;
+}
+
+int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
+{
+	int ret =3D 0;
+
+	if (!sched->get_subflow || !sched->next_segment)
+		return -EINVAL;
+
+	spin_lock(&mptcp_sched_list_lock);
+	if (mptcp_sched_find(sched->name)) {
+		pr_notice("%s already registered\n", sched->name);
+		ret =3D -EEXIST;
+	} else {
+		list_add_tail_rcu(&sched->list, &mptcp_sched_list);
+		pr_info("%s registered\n", sched->name);
+	}
+	spin_unlock(&mptcp_sched_list_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mptcp_register_scheduler);
+
+void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched)
+{
+	spin_lock(&mptcp_sched_list_lock);
+	list_del_rcu(&sched->list);
+	spin_unlock(&mptcp_sched_list_lock);
+
+	/* Wait for outstanding readers to complete before the
+	 * module gets removed entirely.
+	 *
+	 * A try_module_get() should fail by now as our module is
+	 * in "going" state since no refs are held anymore and
+	 * module_exit() handler being called.
+	 */
+	synchronize_rcu();
+}
+EXPORT_SYMBOL_GPL(mptcp_unregister_scheduler);
+
+void mptcp_get_default_scheduler(char *name)
+{
+	struct mptcp_sched_ops *sched;
+
+	BUG_ON(list_empty(&mptcp_sched_list));
+
+	rcu_read_lock();
+	sched =3D list_entry(mptcp_sched_list.next, struct mptcp_sched_ops, list);
+	strncpy(name, sched->name, MPTCP_SCHED_NAME_MAX);
+	rcu_read_unlock();
+}
+
+int mptcp_set_default_scheduler(const char *name)
+{
+	struct mptcp_sched_ops *sched;
+	int ret =3D -ENOENT;
+
+	spin_lock(&mptcp_sched_list_lock);
+	sched =3D mptcp_sched_find(name);
+#ifdef CONFIG_MODULES
+	if (!sched && capable(CAP_NET_ADMIN)) {
+		spin_unlock(&mptcp_sched_list_lock);
+
+		request_module("mptcp_%s", name);
+		spin_lock(&mptcp_sched_list_lock);
+		sched =3D mptcp_sched_find(name);
+	}
+#endif
+
+	if (sched) {
+		list_move(&sched->list, &mptcp_sched_list);
+		ret =3D 0;
+	} else {
+		pr_info("%s is not available\n", name);
+	}
+	spin_unlock(&mptcp_sched_list_lock);
+
+	return ret;
+}
+
+void mptcp_init_scheduler(struct mptcp_cb *mpcb)
+{
+	struct mptcp_sched_ops *sched;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(sched, &mptcp_sched_list, list) {
+		if (try_module_get(sched->owner)) {
+			mpcb->sched_ops =3D sched;
+			break;
+		}
+	}
+	rcu_read_unlock();
+}
+
+/* Manage refcounts on socket close. */
+void mptcp_cleanup_scheduler(struct mptcp_cb *mpcb)
+{
+	module_put(mpcb->sched_ops->owner);
+}
+
+/* Set default value from kernel configuration at bootup */
+static int __init mptcp_scheduler_default(void)
+{
+	BUILD_BUG_ON(sizeof(struct defsched_priv) > MPTCP_SCHED_SIZE);
+
+	return mptcp_set_default_scheduler(CONFIG_DEFAULT_MPTCP_SCHED);
+}
+late_initcall(mptcp_scheduler_default);
diff --git a/net/mptcp/mptcp_wvegas.c b/net/mptcp/mptcp_wvegas.c
new file mode 100644
index 0000000..29ca1d8
--- /dev/null
+++ b/net/mptcp/mptcp_wvegas.c
@@ -0,0 +1,268 @@
+/*
+ *	MPTCP implementation - WEIGHTED VEGAS
+ *
+ *	Algorithm design:
+ *	Yu Cao <cyAnalyst(a)126.com>
+ *	Mingwei Xu <xmw(a)csnet1.cs.tsinghua.edu.cn>
+ *	Xiaoming Fu <fu(a)cs.uni-goettinggen.de>
+ *
+ *	Implementation:
+ *	Yu Cao <cyAnalyst(a)126.com>
+ *	Enhuan Dong <deh13(a)mails.tsinghua.edu.cn>
+ *
+ *	Ported to the official MPTCP-kernel:
+ *	Christoph Paasch <christoph.paasch(a)uclouvain.be>
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/skbuff.h>
+#include <net/tcp.h>
+#include <net/mptcp.h>
+#include <linux/module.h>
+#include <linux/tcp.h>
+
+static int initial_alpha =3D 2;
+static int total_alpha =3D 10;
+static int gamma =3D 1;
+
+module_param(initial_alpha, int, 0644);
+MODULE_PARM_DESC(initial_alpha, "initial alpha for all subflows");
+module_param(total_alpha, int, 0644);
+MODULE_PARM_DESC(total_alpha, "total alpha for all subflows");
+module_param(gamma, int, 0644);
+MODULE_PARM_DESC(gamma, "limit on increase (scale by 2)");
+
+#define MPTCP_WVEGAS_SCALE 16
+
+/* wVegas variables */
+struct wvegas {
+	u32	beg_snd_nxt;	/* right edge during last RTT */
+	u8	doing_wvegas_now;/* if true, do wvegas for this RTT */
+
+	u16	cnt_rtt;		/* # of RTTs measured within last RTT */
+	u32 sampled_rtt; /* cumulative RTTs measured within last RTT (in usec) */
+	u32	base_rtt;	/* the min of all wVegas RTT measurements seen (in usec) */
+
+	u64 instant_rate; /* cwnd / srtt_us, unit: pkts/us * 2^16 */
+	u64 weight; /* the ratio of subflow's rate to the total rate, * 2^16 */
+	int alpha; /* alpha for each subflows */
+
+	u32 queue_delay; /* queue delay*/
+};
+
+
+static inline u64 mptcp_wvegas_scale(u32 val, int scale)
+{
+	return (u64) val << scale;
+}
+
+static void wvegas_enable(const struct sock *sk)
+{
+	const struct tcp_sock *tp =3D tcp_sk(sk);
+	struct wvegas *wvegas =3D inet_csk_ca(sk);
+
+	wvegas->doing_wvegas_now =3D 1;
+
+	wvegas->beg_snd_nxt =3D tp->snd_nxt;
+
+	wvegas->cnt_rtt =3D 0;
+	wvegas->sampled_rtt =3D 0;
+
+	wvegas->instant_rate =3D 0;
+	wvegas->alpha =3D initial_alpha;
+	wvegas->weight =3D mptcp_wvegas_scale(1, MPTCP_WVEGAS_SCALE);
+
+	wvegas->queue_delay =3D 0;
+}
+
+static inline void wvegas_disable(const struct sock *sk)
+{
+	struct wvegas *wvegas =3D inet_csk_ca(sk);
+
+	wvegas->doing_wvegas_now =3D 0;
+}
+
+static void mptcp_wvegas_init(struct sock *sk)
+{
+	struct wvegas *wvegas =3D inet_csk_ca(sk);
+
+	wvegas->base_rtt =3D 0x7fffffff;
+	wvegas_enable(sk);
+}
+
+static inline u64 mptcp_wvegas_rate(u32 cwnd, u32 rtt_us)
+{
+	return div_u64(mptcp_wvegas_scale(cwnd, MPTCP_WVEGAS_SCALE), rtt_us);
+}
+
+static void mptcp_wvegas_pkts_acked(struct sock *sk, u32 cnt, s32 rtt_us)
+{
+	struct wvegas *wvegas =3D inet_csk_ca(sk);
+	u32 vrtt;
+
+	if (rtt_us < 0)
+		return;
+
+	vrtt =3D rtt_us + 1;
+
+	if (vrtt < wvegas->base_rtt)
+		wvegas->base_rtt =3D vrtt;
+
+	wvegas->sampled_rtt +=3D vrtt;
+	wvegas->cnt_rtt++;
+}
+
+static void mptcp_wvegas_state(struct sock *sk, u8 ca_state)
+{
+	if (ca_state =3D=3D TCP_CA_Open)
+		wvegas_enable(sk);
+	else
+		wvegas_disable(sk);
+}
+
+static void mptcp_wvegas_cwnd_event(struct sock *sk, enum tcp_ca_event eve=
nt)
+{
+	if (event =3D=3D CA_EVENT_CWND_RESTART) {
+		mptcp_wvegas_init(sk);
+	} else if (event =3D=3D CA_EVENT_LOSS) {
+		struct wvegas *wvegas =3D inet_csk_ca(sk);
+		wvegas->instant_rate =3D 0;
+	}
+}
+
+static inline u32 mptcp_wvegas_ssthresh(const struct tcp_sock *tp)
+{
+	return  min(tp->snd_ssthresh, tp->snd_cwnd - 1);
+}
+
+static u64 mptcp_wvegas_weight(const struct mptcp_cb *mpcb, const struct s=
ock *sk)
+{
+	u64 total_rate =3D 0;
+	struct sock *sub_sk;
+	const struct wvegas *wvegas =3D inet_csk_ca(sk);
+
+	if (!mpcb)
+		return wvegas->weight;
+
+
+	mptcp_for_each_sk(mpcb, sub_sk) {
+		struct wvegas *sub_wvegas =3D inet_csk_ca(sub_sk);
+
+		/* sampled_rtt is initialized by 0 */
+		if (mptcp_sk_can_send(sub_sk) && (sub_wvegas->sampled_rtt > 0))
+			total_rate +=3D sub_wvegas->instant_rate;
+	}
+
+	if (total_rate && wvegas->instant_rate)
+		return div64_u64(mptcp_wvegas_scale(wvegas->instant_rate, MPTCP_WVEGAS_S=
CALE), total_rate);
+	else
+		return wvegas->weight;
+}
+
+static void mptcp_wvegas_cong_avoid(struct sock *sk, u32 ack, u32 acked)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct wvegas *wvegas =3D inet_csk_ca(sk);
+
+	if (!wvegas->doing_wvegas_now) {
+		tcp_reno_cong_avoid(sk, ack, acked);
+		return;
+	}
+
+	if (after(ack, wvegas->beg_snd_nxt)) {
+		wvegas->beg_snd_nxt  =3D tp->snd_nxt;
+
+		if (wvegas->cnt_rtt <=3D 2) {
+			tcp_reno_cong_avoid(sk, ack, acked);
+		} else {
+			u32 rtt, diff, q_delay;
+			u64 target_cwnd;
+
+			rtt =3D wvegas->sampled_rtt / wvegas->cnt_rtt;
+			target_cwnd =3D div_u64(((u64)tp->snd_cwnd * wvegas->base_rtt), rtt);
+
+			diff =3D div_u64((u64)tp->snd_cwnd * (rtt - wvegas->base_rtt), rtt);
+
+			if (diff > gamma && tp->snd_cwnd <=3D tp->snd_ssthresh) {
+				tp->snd_cwnd =3D min(tp->snd_cwnd, (u32)target_cwnd+1);
+				tp->snd_ssthresh =3D mptcp_wvegas_ssthresh(tp);
+
+			} else if (tp->snd_cwnd <=3D tp->snd_ssthresh) {
+				tcp_slow_start(tp, acked);
+			} else {
+				if (diff >=3D wvegas->alpha) {
+					wvegas->instant_rate =3D mptcp_wvegas_rate(tp->snd_cwnd, rtt);
+					wvegas->weight =3D mptcp_wvegas_weight(tp->mpcb, sk);
+					wvegas->alpha =3D max(2U, (u32)((wvegas->weight * total_alpha) >> MPT=
CP_WVEGAS_SCALE));
+				}
+				if (diff > wvegas->alpha) {
+					tp->snd_cwnd--;
+					tp->snd_ssthresh =3D mptcp_wvegas_ssthresh(tp);
+				} else if (diff < wvegas->alpha) {
+					tp->snd_cwnd++;
+				}
+
+				/* Try to drain link queue if needed*/
+				q_delay =3D rtt - wvegas->base_rtt;
+				if ((wvegas->queue_delay =3D=3D 0) || (wvegas->queue_delay > q_delay))
+					wvegas->queue_delay =3D q_delay;
+
+				if (q_delay >=3D 2 * wvegas->queue_delay) {
+					u32 backoff_factor =3D div_u64(mptcp_wvegas_scale(wvegas->base_rtt, M=
PTCP_WVEGAS_SCALE), 2 * rtt);
+					tp->snd_cwnd =3D ((u64)tp->snd_cwnd * backoff_factor) >> MPTCP_WVEGAS=
_SCALE;
+					wvegas->queue_delay =3D 0;
+				}
+			}
+
+			if (tp->snd_cwnd < 2)
+				tp->snd_cwnd =3D 2;
+			else if (tp->snd_cwnd > tp->snd_cwnd_clamp)
+				tp->snd_cwnd =3D tp->snd_cwnd_clamp;
+
+			tp->snd_ssthresh =3D tcp_current_ssthresh(sk);
+		}
+
+		wvegas->cnt_rtt =3D 0;
+		wvegas->sampled_rtt =3D 0;
+	}
+	/* Use normal slow start */
+	else if (tp->snd_cwnd <=3D tp->snd_ssthresh)
+		tcp_slow_start(tp, acked);
+}
+
+
+static struct tcp_congestion_ops mptcp_wvegas __read_mostly =3D {
+	.init		=3D mptcp_wvegas_init,
+	.ssthresh	=3D tcp_reno_ssthresh,
+	.cong_avoid	=3D mptcp_wvegas_cong_avoid,
+	.pkts_acked	=3D mptcp_wvegas_pkts_acked,
+	.set_state	=3D mptcp_wvegas_state,
+	.cwnd_event	=3D mptcp_wvegas_cwnd_event,
+
+	.owner		=3D THIS_MODULE,
+	.name		=3D "wvegas",
+};
+
+static int __init mptcp_wvegas_register(void)
+{
+	BUILD_BUG_ON(sizeof(struct wvegas) > ICSK_CA_PRIV_SIZE);
+	tcp_register_congestion_control(&mptcp_wvegas);
+	return 0;
+}
+
+static void __exit mptcp_wvegas_unregister(void)
+{
+	tcp_unregister_congestion_control(&mptcp_wvegas);
+}
+
+module_init(mptcp_wvegas_register);
+module_exit(mptcp_wvegas_unregister);
+
+MODULE_AUTHOR("Yu Cao, Enhuan Dong");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MPTCP wVegas");
+MODULE_VERSION("0.1");
-- =

2.7.4


--===============2208300193116022014==--
