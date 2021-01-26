Content-Type: multipart/mixed; boundary="===============5623732496505484048=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][RFC mptcp-next 6/6] mptcp: add tracepoints for
 subflow operations
Date: Tue, 26 Jan 2021 21:21:53 +0800
Message-ID: <b3a484bf1f07216bdf3f074578643bc506ddb62d.1611667027.git.geliangtang@gmail.com>
In-Reply-To: 0ee088c09c673fe8b91c1b090b8e4fa189da1dce.1611667027.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7488

--===============5623732496505484048==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add tracepoints in MPTCP for tracing the subflow operations.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 include/trace/events/mptcp.h | 108 +++++++++++++++++++++++++++++++++++
 net/mptcp/subflow.c          |   6 ++
 2 files changed, 114 insertions(+)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index 2d607cecdfa8..bdcf46e4e28e 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -294,6 +294,114 @@ TRACE_EVENT(mptcp_pm_create_subflow_or_signal_addr,
 		  __entry->info.mptcpi_add_addr_accepted_max)
 );
 =

+/*
+ * mptcp event with arguments subflow_req
+ *
+ * Note: this class requires a valid subflow_req pointer.
+ */
+DECLARE_EVENT_CLASS(mptcp_event_subflow_req,
+
+	TP_PROTO(struct mptcp_subflow_request_sock *subflow_req),
+
+	TP_ARGS(subflow_req),
+
+	TP_STRUCT__entry(
+		__array(char, str, 128)
+	),
+
+	TP_fast_assign(
+		memset(__entry->str, 0, 128);
+
+		if (subflow_req->mp_capable)
+			sprintf(__entry->str, "subflow_req mp_capable");
+
+		if (subflow_req->mp_join)
+			sprintf(__entry->str, "subflow_req mp_join, token=3D%u remote_nonce=3D%=
u",
+				subflow_req->token, subflow_req->remote_nonce);
+	),
+
+	TP_printk("%s", __entry->str)
+);
+
+DEFINE_EVENT(mptcp_event_subflow_req, subflow_init_req,
+
+	TP_PROTO(struct mptcp_subflow_request_sock *subflow_req),
+
+	TP_ARGS(subflow_req)
+);
+
+DEFINE_EVENT(mptcp_event_subflow_req, subflow_syn_recv_sock,
+
+	TP_PROTO(struct mptcp_subflow_request_sock *subflow_req),
+
+	TP_ARGS(subflow_req)
+);
+
+/*
+ * mptcp event with arguments subflow
+ *
+ * Note: this class requires a valid subflow pointer.
+ */
+DECLARE_EVENT_CLASS(mptcp_event_subflow,
+
+	TP_PROTO(struct mptcp_subflow_context *subflow),
+
+	TP_ARGS(subflow),
+
+	TP_STRUCT__entry(
+		__array(char, str, 128)
+	),
+
+	TP_fast_assign(
+		memset(__entry->str, 0, 128);
+
+		if (subflow->mp_capable)
+			sprintf(__entry->str, "remote_key=3D%llu", subflow->remote_key);
+
+		if (subflow->mp_join) {
+			sprintf(__entry->str, "thmac=3D%llu, remote_nonce=3D%u",
+				subflow->thmac, subflow->remote_nonce);
+		}
+	),
+
+	TP_printk("%s", __entry->str)
+);
+
+DEFINE_EVENT(mptcp_event_subflow, subflow_finish_connect,
+
+	TP_PROTO(struct mptcp_subflow_context *subflow),
+
+	TP_ARGS(subflow)
+);
+
+TRACE_EVENT(get_mapping_status,
+
+	TP_PROTO(struct mptcp_ext *mpext),
+
+	TP_ARGS(mpext),
+
+	TP_STRUCT__entry(
+		__field(__u64, data_seq)
+		__field(__u32, subflow_seq)
+		__field(__u16, data_len)
+		__field(__u8, dsn64)
+		__field(__u8, data_fin)
+	),
+
+	TP_fast_assign(
+		__entry->data_seq =3D mpext->data_seq;
+		__entry->subflow_seq =3D mpext->subflow_seq;
+		__entry->data_len =3D mpext->data_len;
+		__entry->dsn64 =3D mpext->dsn64;
+		__entry->data_fin =3D mpext->data_fin;
+	),
+
+	TP_printk("data_seq=3D%llu subflow_seq=3D%u data_len=3D%u dsn64=3D%d data=
_fin=3D%d",
+		  __entry->data_seq, __entry->subflow_seq,
+		  __entry->data_len, __entry->dsn64,
+		  __entry->data_fin)
+);
+
 #endif /* _TRACE_MPTCP_H */
 =

 /* This part must be outside protection */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 280da418d60b..668a1b1bf049 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -27,6 +27,8 @@
 =

 static void mptcp_subflow_ops_undo_override(struct sock *ssk);
 =

+#include <trace/events/mptcp.h>
+
 static void SUBFLOW_REQ_INC_STATS(struct request_sock *req,
 				  enum linux_mptcp_mib_field field)
 {
@@ -223,6 +225,7 @@ static int subflow_init_req(struct request_sock *req,
 		pr_debug("token=3D%u, remote_nonce=3D%u msk=3D%p", subflow_req->token,
 			 subflow_req->remote_nonce, subflow_req->msk);
 	}
+	trace_subflow_init_req(subflow_req);
 =

 	return 0;
 }
@@ -439,6 +442,7 @@ static void subflow_finish_connect(struct sock *sk, con=
st struct sk_buff *skb)
 fallback:
 		mptcp_rcv_space_init(mptcp_sk(parent), sk);
 	}
+	trace_subflow_finish_connect(subflow);
 	return;
 =

 do_reset:
@@ -610,6 +614,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 	if (fallback)
 		goto create_child;
 =

+	trace_subflow_syn_recv_sock(subflow_req);
 	/* if the sk is MP_CAPABLE, we try to fetch the client key */
 	if (subflow_req->mp_capable) {
 		if (TCP_SKB_CB(skb)->seq !=3D subflow_req->ssn_offset + 1) {
@@ -836,6 +841,7 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk,
 		goto validate_seq;
 	}
 =

+	trace_get_mapping_status(mpext);
 	pr_debug("seq=3D%llu is64=3D%d ssn=3D%u data_len=3D%u data_fin=3D%d",
 		 mpext->data_seq, mpext->dsn64, mpext->subflow_seq,
 		 mpext->data_len, mpext->data_fin);
-- =

2.29.2

--===============5623732496505484048==--
