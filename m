Content-Type: multipart/mixed; boundary="===============3739475006225330546=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][RFC mptcp-next 3/6] mptcp: add tracepoints for
 options operations
Date: Tue, 26 Jan 2021 21:21:50 +0800
Message-ID: <dec50a09c5e543c16d2bd7fddce8ca20d007843b.1611667027.git.geliangtang@gmail.com>
In-Reply-To: 2ae1ee585b508fe596788a747dfac676127afa4c.1611667027.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7485

--===============3739475006225330546==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add tracepoints in MPTCP for tracing the options writing and getting.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 include/trace/events/mptcp.h | 161 +++++++++++++++++++++++++++++++++++
 net/mptcp/options.c          |   8 ++
 2 files changed, 169 insertions(+)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index b56ece509dc5..498b116056c1 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -60,6 +60,167 @@ TRACE_EVENT(mptcp_recvmsg,
 		  __entry->data_ready, __entry->empty, __entry->copied)
 );
 =

+TRACE_EVENT_CONDITION(mptcp_write_options,
+
+	TP_PROTO(struct mptcp_out_options *opts),
+
+	TP_ARGS(opts),
+
+	TP_CONDITION(opts->suboptions || opts->ext_copy.use_ack || opts->ext_copy=
.use_map),
+
+	TP_STRUCT__entry(
+		__array(char, str, 128)
+	),
+
+	TP_fast_assign(
+		memset(__entry->str, 0, 128);
+
+		if (OPTION_MPTCP_MPC_SYN & opts->suboptions)
+			sprintf(__entry->str, "mp_capable syn");
+		if (OPTION_MPTCP_MPC_SYNACK & opts->suboptions) {
+			sprintf(__entry->str,
+				"mp_capable synack sndr_key=3D%llu", opts->sndr_key);
+		}
+		if (OPTION_MPTCP_MPC_ACK & opts->suboptions) {
+			sprintf(__entry->str,
+				"mp_capable ack sndr_key=3D%llu rcvr_key=3D%llu data_len=3D%d",
+				opts->sndr_key, opts->rcvr_key, opts->ext_copy.data_len);
+		}
+		if ((OPTION_MPTCP_ADD_ADDR
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+		     | OPTION_MPTCP_ADD_ADDR6
+#endif
+		    ) & opts->suboptions) {
+			sprintf(__entry->str, "add_addr addr_id=3D%d, ahmac=3D%llu, echo=3D%d, =
port=3D%d",
+				opts->addr_id, opts->ahmac, opts->echo, opts->port);
+		}
+		if (OPTION_MPTCP_RM_ADDR & opts->suboptions)
+			sprintf(__entry->str, "rm_addr rm_id=3D%d", opts->rm_id);
+		if (OPTION_MPTCP_PRIO & opts->suboptions)
+			sprintf(__entry->str, "mp_prio prio=3D%d", opts->backup);
+		if (OPTION_MPTCP_MPJ_SYN & opts->suboptions) {
+			sprintf(__entry->str,
+				"mp_join syn join_id=3D%u token=3D%u nonce=3D%u backup=3D%u",
+				opts->join_id, opts->token, opts->nonce, opts->backup);
+		}
+		if (OPTION_MPTCP_MPJ_SYNACK & opts->suboptions) {
+			sprintf(__entry->str,
+				"mp_join synack backup=3D%u join_id=3D%u thmac=3D%llu nonce=3D%u",
+				opts->backup, opts->join_id, opts->thmac, opts->nonce);
+		}
+		if (OPTION_MPTCP_MPJ_ACK & opts->suboptions)
+			sprintf(__entry->str, "mp_join ack");
+
+		if (opts->ext_copy.use_ack || opts->ext_copy.use_map) {
+			sprintf(__entry->str, "dss");
+
+			if (opts->ext_copy.use_map) {
+				sprintf(__entry->str + strlen(__entry->str),
+					" use_map dsn64=3D%d", opts->ext_copy.dsn64);
+			}
+			if (opts->ext_copy.data_fin)
+				sprintf(__entry->str + strlen(__entry->str), " data_fin");
+			if (opts->ext_copy.use_ack) {
+				sprintf(__entry->str + strlen(__entry->str),
+					" use_ack ack64=3D%d", opts->ext_copy.ack64);
+			}
+		}
+	),
+
+	TP_printk("%s", __entry->str)
+);
+
+TRACE_EVENT(mptcp_get_options,
+
+	TP_PROTO(struct mptcp_options_received *opts),
+
+	TP_ARGS(opts),
+
+	TP_STRUCT__entry(
+		__array(char, str, 128)
+	),
+
+	TP_fast_assign(
+		memset(__entry->str, 0, 128);
+
+		if (opts->mp_capable) {
+			sprintf(__entry->str, "MP_CAPABLE: ");
+
+			if (!opts->sndr_key && !opts->rcvr_key)
+				sprintf(__entry->str + strlen(__entry->str), "syn");
+			if (opts->sndr_key && !opts->rcvr_key) {
+				sprintf(__entry->str + strlen(__entry->str),
+					"synack sndr_key=3D%llu", opts->sndr_key);
+			}
+			if (opts->sndr_key && opts->rcvr_key) {
+				sprintf(__entry->str + strlen(__entry->str),
+					"ack sndr_key=3D%llu rcvr_key=3D%llu data_len=3D%d",
+					opts->sndr_key, opts->rcvr_key, opts->data_len);
+			}
+		}
+		if (opts->mp_join) {
+			u8 i, hmac =3D 0;
+
+			for (i =3D 0; i < MPTCPOPT_HMAC_LEN; i++) {
+				if (opts->hmac[i]) {
+					hmac =3D 1;
+					break;
+				}
+			}
+
+			sprintf(__entry->str, "MP_JOIN: ");
+
+			if (!opts->thmac && !hmac) {
+				sprintf(__entry->str + strlen(__entry->str),
+					"syn backup=3D%u join_id=3D%u token=3D%u nonce=3D%u",
+					opts->backup, opts->join_id, opts->token, opts->nonce);
+			}
+			if (opts->thmac && !hmac) {
+				sprintf(__entry->str + strlen(__entry->str),
+					"synack backup=3D%u join_id=3D%u thmac=3D%llu nonce=3D%u",
+					opts->backup, opts->join_id, opts->thmac, opts->nonce);
+			}
+			if (!opts->thmac && hmac)
+				sprintf(__entry->str + strlen(__entry->str), "ack");
+		}
+		if (opts->dss) {
+			sprintf(__entry->str, "DSS:");
+
+			if (opts->use_map) {
+				sprintf(__entry->str + strlen(__entry->str),
+					" dsn64=3D%d data_seq=3D%llu subflow_seq=3D%u data_len=3D%u",
+					opts->dsn64, opts->data_seq,
+					opts->subflow_seq, opts->data_len);
+			}
+			if (opts->data_fin)
+				sprintf(__entry->str + strlen(__entry->str), " data_fin");
+			if (opts->use_ack) {
+				sprintf(__entry->str + strlen(__entry->str),
+					" ack64=3D%d data_ack=3D%llu",
+					opts->ack64, opts->data_ack);
+			}
+		}
+		if (opts->add_addr) {
+			sprintf(__entry->str, "ADD_ADDR");
+
+			if (opts->family =3D=3D MPTCP_ADDR_IPVERSION_6)
+				sprintf(__entry->str + strlen(__entry->str), "6");
+
+			sprintf(__entry->str + strlen(__entry->str),
+				": addr_id=3D%d ahmac=3D%llu echo=3D%d port=3D%d",
+				opts->addr_id, opts->ahmac, opts->echo, opts->port);
+		}
+		if (opts->rm_addr)
+			sprintf(__entry->str, "RM_ADDR: id=3D%d", opts->rm_id);
+		if (opts->mp_prio)
+			sprintf(__entry->str, "MP_PRIO: prio=3D%d", opts->backup);
+		if (opts->fastclose)
+			sprintf(__entry->str, "MP_FASTCLOSE: rcvr_key=3D%llu", opts->rcvr_key);
+	),
+
+	TP_printk("%s", __entry->str)
+);
+
 #endif /* _TRACE_MPTCP_H */
 =

 /* This part must be outside protection */
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 465144afade8..57adebec2d42 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -13,6 +13,8 @@
 #include "protocol.h"
 #include "mib.h"
 =

+#include <trace/events/mptcp.h>
+
 static bool mptcp_cap_flag_sha256(u8 flags)
 {
 	return (flags & MPTCP_CAP_FLAG_MASK) =3D=3D MPTCP_CAP_HMAC_SHA256;
@@ -323,6 +325,9 @@ void mptcp_get_options(const struct sk_buff *skb,
 	mp_opt->rm_addr =3D 0;
 	mp_opt->dss =3D 0;
 	mp_opt->mp_prio =3D 0;
+	mp_opt->sndr_key =3D 0;
+	mp_opt->rcvr_key =3D 0;
+	memset(mp_opt->hmac, 0, MPTCPOPT_HMAC_LEN);
 =

 	length =3D (th->doff * 4) - sizeof(struct tcphdr);
 	ptr =3D (const unsigned char *)(th + 1);
@@ -349,6 +354,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 			length -=3D opsize;
 		}
 	}
+	trace_mptcp_get_options(mp_opt);
 }
 =

 bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
@@ -1114,6 +1120,8 @@ static void mptcp_set_rwin(const struct tcp_sock *tp)
 void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			 struct mptcp_out_options *opts)
 {
+	trace_mptcp_write_options(opts);
+
 	if ((OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK |
 	     OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
 		u8 len;
-- =

2.29.2

--===============3739475006225330546==--
