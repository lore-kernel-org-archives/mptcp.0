Content-Type: multipart/mixed; boundary="===============1357706788985224998=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 2/3] mptcp: add tracepoint for
 get_mapping_status
Date: Mon, 22 Feb 2021 15:30:32 +0800
Message-ID: <0db05b909b602f18d84f07de6a8641eaa9daf070.1613978710.git.geliangtang@gmail.com>
In-Reply-To: 38cfc37b362365f951585f9fda3031896f734e01.1613978710.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7886

--===============1357706788985224998==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added the tracepoint for the mapping status function
get_mapping_status.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 include/trace/events/mptcp.h | 51 ++++++++++++++++++++++++++++++++++++
 net/mptcp/subflow.c          | 13 +++------
 2 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index b36b308f48e2..f06a7d33b237 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -39,6 +39,57 @@ TRACE_EVENT(mptcp_subflow_get_send,
 		  __entry->ssk_1, __entry->ratio_1)
 );
 =

+TRACE_EVENT(get_mapping_status,
+
+	TP_PROTO(struct mptcp_ext *mpext),
+
+	TP_ARGS(mpext),
+
+	TP_STRUCT__entry(
+		__array(char, str, 128)
+	),
+
+	TP_fast_assign(
+		memset(__entry->str, 0, 128);
+
+		if (!mpext) {
+			sprintf(__entry->str, "mpext is NULL");
+		} else {
+			if (!mpext->data_len) {
+				sprintf(__entry->str, "Infinite mapping not handled");
+			} else {
+				if (mpext->data_fin =3D=3D 1) {
+					if (mpext->data_len =3D=3D 1) {
+						sprintf(__entry->str,
+							"data_fin: with no payload seq=3D%llu",
+							mpext->data_seq);
+					} else {
+						sprintf(__entry->str,
+							"data_fin: with mapping seq=3D%llu dsn64=3D%d",
+							mpext->data_seq + mpext->data_len - 1,
+							mpext->dsn64);
+					}
+				}
+
+				if (mpext->use_map) {
+					sprintf(__entry->str + strlen(__entry->str),
+						"use_map: dsn64=3D%d data_seq=3D%llu subflow_seq=3D%u data_len=3D%u",
+						mpext->dsn64, mpext->data_seq,
+						mpext->subflow_seq, mpext->data_len);
+				}
+
+				if (mpext->use_ack) {
+					sprintf(__entry->str + strlen(__entry->str),
+						"use_ack: ack64=3D%d data_ack=3D%llu",
+						mpext->ack64, mpext->data_ack);
+				}
+			}
+		}
+	),
+
+	TP_printk("%s", __entry->str)
+);
+
 #endif /* _TRACE_MPTCP_H */
 =

 /* This part must be outside protection */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 82ec174e2bac..6f4145abd85e 100644
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
@@ -808,6 +810,7 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk,
 		return MAPPING_DUMMY;
 =

 	mpext =3D mptcp_get_ext(skb);
+	trace_get_mapping_status(mpext);
 	if (!mpext || !mpext->use_map) {
 		if (!subflow->map_valid && !skb->len) {
 			/* the TCP stack deliver 0 len FIN pkt to the receive
@@ -829,10 +832,6 @@ static enum mapping_status get_mapping_status(struct s=
ock *ssk,
 		goto validate_seq;
 	}
 =

-	pr_debug("seq=3D%llu is64=3D%d ssn=3D%u data_len=3D%u data_fin=3D%d",
-		 mpext->data_seq, mpext->dsn64, mpext->subflow_seq,
-		 mpext->data_len, mpext->data_fin);
-
 	data_len =3D mpext->data_len;
 	if (data_len =3D=3D 0) {
 		pr_err("Infinite mapping not handled");
@@ -844,7 +843,6 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk,
 		if (data_len =3D=3D 1) {
 			bool updated =3D mptcp_update_rcv_data_fin(msk, mpext->data_seq,
 								 mpext->dsn64);
-			pr_debug("DATA_FIN with no payload seq=3D%llu", mpext->data_seq);
 			if (subflow->map_valid) {
 				/* A DATA_FIN might arrive in a DSS
 				 * option before the previous mapping
@@ -869,8 +867,6 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk,
 				data_fin_seq &=3D GENMASK_ULL(31, 0);
 =

 			mptcp_update_rcv_data_fin(msk, data_fin_seq, mpext->dsn64);
-			pr_debug("DATA_FIN with mapping seq=3D%llu dsn64=3D%d",
-				 data_fin_seq, mpext->dsn64);
 		}
 =

 		/* Adjust for DATA_FIN using 1 byte of sequence space */
@@ -912,9 +908,6 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk,
 	subflow->map_data_len =3D data_len;
 	subflow->map_valid =3D 1;
 	subflow->mpc_map =3D mpext->mpc_map;
-	pr_debug("new map seq=3D%llu subflow_seq=3D%u data_len=3D%u",
-		 subflow->map_seq, subflow->map_subflow_seq,
-		 subflow->map_data_len);
 =

 validate_seq:
 	/* we revalidate valid mapping on new skb, because we must ensure
-- =

2.29.2

--===============1357706788985224998==--
