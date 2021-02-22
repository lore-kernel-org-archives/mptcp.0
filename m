Content-Type: multipart/mixed; boundary="===============7623210550412994443=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 3/3] mptcp: add tracepoint for
 subflow_check_data_avail
Date: Mon, 22 Feb 2021 15:30:33 +0800
Message-ID: <17cc2a04d179090f095f22300aba6c8bbc868ba4.1613978710.git.geliangtang@gmail.com>
In-Reply-To: 0db05b909b602f18d84f07de6a8641eaa9daf070.1613978710.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7887

--===============7623210550412994443==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added the tracepoint for subflow_check_data_avail to show the
mapping status.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 include/trace/events/mptcp.h | 26 ++++++++++++++++++++++++++
 net/mptcp/subflow.c          |  2 +-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index f06a7d33b237..29570009a7e4 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -7,6 +7,14 @@
 =

 #include <linux/tracepoint.h>
 =

+#define show_mapping_status(status)					\
+	__print_symbolic(status,					\
+		{ 0, "MAPPING_OK" },					\
+		{ 1, "MAPPING_INVALID" },				\
+		{ 2, "MAPPING_EMPTY" },					\
+		{ 3, "MAPPING_DATA_FIN" },				\
+		{ 4, "MAPPING_DUMMY" })
+
 TRACE_EVENT(mptcp_subflow_get_send,
 =

 	TP_PROTO(struct mptcp_sock *msk, int nr_active,
@@ -90,6 +98,24 @@ TRACE_EVENT(get_mapping_status,
 	TP_printk("%s", __entry->str)
 );
 =

+TRACE_EVENT(subflow_check_data_avail,
+
+	TP_PROTO(__u8 status),
+
+	TP_ARGS(status),
+
+	TP_STRUCT__entry(
+		__field(__u8, status)
+	),
+
+	TP_fast_assign(
+		__entry->status =3D status;
+	),
+
+	TP_printk("mapping_status =3D %s",
+		  show_mapping_status(__entry->status))
+);
+
 #endif /* _TRACE_MPTCP_H */
 =

 /* This part must be outside protection */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6f4145abd85e..0c5e1ec0d418 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -975,7 +975,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		u64 old_ack;
 =

 		status =3D get_mapping_status(ssk, msk);
-		pr_debug("msk=3D%p ssk=3D%p status=3D%d", msk, ssk, status);
+		trace_subflow_check_data_avail(status);
 		if (status =3D=3D MAPPING_INVALID) {
 			ssk->sk_err =3D EBADMSG;
 			goto fatal;
-- =

2.29.2

--===============7623210550412994443==--
