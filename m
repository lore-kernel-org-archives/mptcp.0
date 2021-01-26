Content-Type: multipart/mixed; boundary="===============3979716070359721116=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][RFC mptcp-next 1/6] mptcp: add tracepoints for data
 operations
Date: Tue, 26 Jan 2021 21:21:48 +0800
Message-ID: <4234f6b39337db1410b2a26bd5f1aacb391d712e.1611667027.git.geliangtang@gmail.com>
In-Reply-To: cover.1611667027.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7483

--===============3979716070359721116==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add tracepoints in MPTCP for tracing the data sending and receiving.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 include/trace/events/mptcp.h | 66 ++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c         |  5 +++
 2 files changed, 71 insertions(+)
 create mode 100644 include/trace/events/mptcp.h

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
new file mode 100644
index 000000000000..b56ece509dc5
--- /dev/null
+++ b/include/trace/events/mptcp.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM mptcp
+
+#if !defined(_TRACE_MPTCP_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_MPTCP_H
+
+#include <linux/mptcp.h>
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(mptcp_sendmsg,
+
+	TP_PROTO(struct mptcp_data_frag *dfrag),
+
+	TP_ARGS(dfrag),
+
+	TP_STRUCT__entry(
+		__field(__u64, data_seq)
+		__field(__u16, data_len)
+		__field(__u16, offset)
+		__field(__u16, overhead)
+		__field(__u16, already_sent)
+	),
+
+	TP_fast_assign(
+		__entry->data_seq =3D dfrag->data_seq;
+		__entry->data_len =3D dfrag->data_len;
+		__entry->offset =3D dfrag->offset;
+		__entry->overhead =3D dfrag->overhead;
+		__entry->already_sent =3D dfrag->already_sent;
+	),
+
+	TP_printk("data_seq=3D%llx data_len=3D%d offset=3D%d overhead=3D%d alread=
y_sent=3D%d",
+		  __entry->data_seq, __entry->data_len,
+		  __entry->offset, __entry->overhead,
+		  __entry->already_sent)
+);
+
+TRACE_EVENT(mptcp_recvmsg,
+
+	TP_PROTO(struct sock *sk, int copied),
+
+	TP_ARGS(sk, copied),
+
+	TP_STRUCT__entry(
+		__field(int, data_ready)
+		__field(int, empty)
+		__field(int, copied)
+	),
+
+	TP_fast_assign(
+		struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+		__entry->data_ready =3D test_bit(MPTCP_DATA_READY, &msk->flags);
+		__entry->empty =3D skb_queue_empty_lockless(&sk->sk_receive_queue);
+		__entry->copied =3D copied;
+	),
+
+	TP_printk("data_ready=3D%d rx queue empty=3D%d copied=3D%d",
+		  __entry->data_ready, __entry->empty, __entry->copied)
+);
+
+#endif /* _TRACE_MPTCP_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e9ad8cb5268b..f1d713834382 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -25,6 +25,9 @@
 #include "protocol.h"
 #include "mib.h"
 =

+#define CREATE_TRACE_POINTS
+#include <trace/events/mptcp.h>
+
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 struct mptcp6_sock {
 	struct mptcp_sock msk;
@@ -1674,6 +1677,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 			if (!msk->first_pending)
 				WRITE_ONCE(msk->first_pending, dfrag);
 		}
+		trace_mptcp_sendmsg(dfrag);
 		pr_debug("msk=3D%p dfrag at seq=3D%lld len=3D%d sent=3D%d new=3D%d", msk,
 			 dfrag->data_seq, dfrag->data_len, dfrag->already_sent,
 			 !dfrag_collapsed);
@@ -2022,6 +2026,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
 		set_bit(MPTCP_DATA_READY, &msk->flags);
 	}
 out_err:
+	trace_mptcp_recvmsg(sk, copied);
 	pr_debug("msk=3D%p data_ready=3D%d rx queue empty=3D%d copied=3D%d",
 		 msk, test_bit(MPTCP_DATA_READY, &msk->flags),
 		 skb_queue_empty_lockless(&sk->sk_receive_queue), copied);
-- =

2.29.2

--===============3979716070359721116==--
