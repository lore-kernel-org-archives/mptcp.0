Content-Type: multipart/mixed; boundary="===============3345065107256516623=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 1/3] mptcp: add tracepoint for
 mptcp_subflow_get_send
Date: Mon, 22 Feb 2021 15:30:31 +0800
Message-ID: <38cfc37b362365f951585f9fda3031896f734e01.1613978710.git.geliangtang@gmail.com>
In-Reply-To: cover.1613978710.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7885

--===============3345065107256516623==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added the tracepoint for the packet scheduler function
mptcp_subflow_get_send.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 include/trace/events/mptcp.h | 45 ++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c         |  9 +++++---
 2 files changed, 51 insertions(+), 3 deletions(-)
 create mode 100644 include/trace/events/mptcp.h

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
new file mode 100644
index 000000000000..b36b308f48e2
--- /dev/null
+++ b/include/trace/events/mptcp.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM mptcp
+
+#if !defined(_TRACE_MPTCP_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_MPTCP_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(mptcp_subflow_get_send,
+
+	TP_PROTO(struct mptcp_sock *msk, int nr_active,
+		 struct sock *ssk_0, u64 ratio_0,
+		 struct sock *ssk_1, u64 ratio_1),
+
+	TP_ARGS(msk, nr_active, ssk_0, ratio_0, ssk_1, ratio_1),
+
+	TP_STRUCT__entry(
+		__field(const void *, msk)
+		__field(__u32, nr_active)
+		__field(const void *, ssk_0)
+		__field(__u64, ratio_0)
+		__field(const void *, ssk_1)
+		__field(__u64, ratio_1)
+	),
+
+	TP_fast_assign(
+		__entry->msk =3D msk;
+		__entry->nr_active =3D nr_active;
+		__entry->ssk_0 =3D ssk_0;
+		__entry->ratio_0 =3D ratio_0;
+		__entry->ssk_1 =3D ssk_1;
+		__entry->ratio_1 =3D ratio_1;
+	),
+
+	TP_printk("msk=3D%p nr_active=3D%d ssk=3D%p:%lld backup=3D%p:%lld",
+		  __entry->msk, __entry->nr_active,
+		  __entry->ssk_0, __entry->ratio_0,
+		  __entry->ssk_1, __entry->ratio_1)
+);
+
+#endif /* _TRACE_MPTCP_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ec808187fa0e..dff3f8c96c5d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -27,6 +27,9 @@
 #include "protocol.h"
 #include "mib.h"
 =

+#define CREATE_TRACE_POINTS
+#include <trace/events/mptcp.h>
+
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 struct mptcp6_sock {
 	struct mptcp_sock msk;
@@ -1418,9 +1421,9 @@ static struct sock *mptcp_subflow_get_send(struct mpt=
cp_sock *msk)
 		}
 	}
 =

-	pr_debug("msk=3D%p nr_active=3D%d ssk=3D%p:%lld backup=3D%p:%lld",
-		 msk, nr_active, send_info[0].ssk, send_info[0].ratio,
-		 send_info[1].ssk, send_info[1].ratio);
+	trace_mptcp_subflow_get_send(msk, nr_active,
+				     send_info[0].ssk, send_info[0].ratio,
+				     send_info[1].ssk, send_info[1].ratio);
 =

 	/* pick the best backup if no other subflow is active */
 	if (!nr_active)
-- =

2.29.2

--===============3345065107256516623==--
