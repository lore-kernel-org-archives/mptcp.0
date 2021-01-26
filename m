Content-Type: multipart/mixed; boundary="===============8482274874908129881=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][RFC mptcp-next 5/6] mptcp: add tracepoints for PM
 operations
Date: Tue, 26 Jan 2021 21:21:52 +0800
Message-ID: <0ee088c09c673fe8b91c1b090b8e4fa189da1dce.1611667027.git.geliangtang@gmail.com>
In-Reply-To: 54bb5802527e4b8b52f8fc9d0a8e561218e25637.1611667027.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7487

--===============8482274874908129881==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add tracepoints in MPTCP for tracing the path management operations.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 include/trace/events/mptcp.h | 73 ++++++++++++++++++++++++++++++++++++
 net/mptcp/pm.c               |  3 ++
 net/mptcp/pm_netlink.c       |  3 ++
 3 files changed, 79 insertions(+)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index 498b116056c1..2d607cecdfa8 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -221,6 +221,79 @@ TRACE_EVENT(mptcp_get_options,
 	TP_printk("%s", __entry->str)
 );
 =

+TRACE_EVENT(mptcp_pm_announce_addr,
+
+	TP_PROTO(struct mptcp_sock *msk, const struct mptcp_addr_info *addr),
+
+	TP_ARGS(msk, addr),
+
+	TP_STRUCT__entry(
+		__array(char, str, 100)
+	),
+
+	TP_fast_assign(
+		memset(__entry->str, 0, 100);
+
+		sprintf(__entry->str, "family=3D%u port=3D%u id=3D%u flags=3D%u",
+			addr->family, ntohs(addr->port), addr->id, addr->flags);
+		if (addr->family =3D=3D AF_INET) {
+			sprintf(__entry->str + strlen(__entry->str),
+				" addr=3D%pI4", &addr->addr);
+		}
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+		if (addr->family =3D=3D AF_INET6) {
+			sprintf(__entry->str + strlen(__entry->str),
+				" addr6=3D%pI6", &addr->addr6);
+		}
+#endif
+	),
+
+	TP_printk("%s", __entry->str)
+);
+
+TRACE_EVENT(mptcp_pm_create_subflow_or_signal_addr,
+
+	TP_PROTO(struct mptcp_sock *msk),
+
+	TP_ARGS(msk),
+
+	TP_STRUCT__entry(
+		__field_struct(struct mptcp_info, info)
+	),
+
+	TP_fast_assign(
+		u32 flags =3D 0;
+
+		__entry->info.mptcpi_subflows =3D READ_ONCE(msk->pm.subflows);
+		__entry->info.mptcpi_add_addr_signaled =3D READ_ONCE(msk->pm.add_addr_si=
gnaled);
+		__entry->info.mptcpi_add_addr_accepted =3D READ_ONCE(msk->pm.add_addr_ac=
cepted);
+		__entry->info.mptcpi_local_addr_used =3D READ_ONCE(msk->pm.local_addr_us=
ed);
+		__entry->info.mptcpi_subflows_max =3D mptcp_pm_get_subflows_max(msk);
+		__entry->info.mptcpi_add_addr_signal_max =3D mptcp_pm_get_add_addr_signa=
l_max(msk);
+		__entry->info.mptcpi_add_addr_accepted_max =3D mptcp_pm_get_add_addr_acc=
ept_max(msk);
+		__entry->info.mptcpi_local_addr_max =3D mptcp_pm_get_local_addr_max(msk);
+		if (test_bit(MPTCP_FALLBACK_DONE, &msk->flags))
+			flags |=3D MPTCP_INFO_FLAG_FALLBACK;
+		if (READ_ONCE(msk->can_ack))
+			flags |=3D MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED;
+		__entry->info.mptcpi_flags =3D flags;
+		__entry->info.mptcpi_token =3D READ_ONCE(msk->token);
+		__entry->info.mptcpi_write_seq =3D READ_ONCE(msk->write_seq);
+		__entry->info.mptcpi_snd_una =3D READ_ONCE(msk->snd_una);
+		__entry->info.mptcpi_rcv_nxt =3D READ_ONCE(msk->ack_seq);
+	),
+
+	TP_printk("local %d:%d signal %d:%d subflows %d:%d accept %d:%d",
+		  __entry->info.mptcpi_local_addr_used,
+		  __entry->info.mptcpi_local_addr_max,
+		  __entry->info.mptcpi_add_addr_signaled,
+		  __entry->info.mptcpi_add_addr_signal_max,
+		  __entry->info.mptcpi_subflows,
+		  __entry->info.mptcpi_subflows_max,
+		  __entry->info.mptcpi_add_addr_accepted,
+		  __entry->info.mptcpi_add_addr_accepted_max)
+);
+
 #endif /* _TRACE_MPTCP_H */
 =

 /* This part must be outside protection */
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 1a25003fd8e3..eef85c3a97d1 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -10,6 +10,8 @@
 #include <net/mptcp.h>
 #include "protocol.h"
 =

+#include <trace/events/mptcp.h>
+
 /* path manager command handlers */
 =

 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
@@ -18,6 +20,7 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 {
 	u8 add_addr =3D READ_ONCE(msk->pm.addr_signal);
 =

+	trace_mptcp_pm_announce_addr(msk, addr);
 	pr_debug("msk=3D%p, local_id=3D%d", msk, addr->id);
 =

 	lockdep_assert_held(&msk->pm.lock);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index b6ee53623005..af7ff6b83483 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -17,6 +17,8 @@
 #include "protocol.h"
 #include "mib.h"
 =

+#include <trace/events/mptcp.h>
+
 /* forward declaration */
 static struct genl_family mptcp_genl_family;
 =

@@ -404,6 +406,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(stru=
ct mptcp_sock *msk)
 	local_addr_max =3D mptcp_pm_get_local_addr_max(msk);
 	subflows_max =3D mptcp_pm_get_subflows_max(msk);
 =

+	trace_mptcp_pm_create_subflow_or_signal_addr(msk);
 	pr_debug("local %d:%d signal %d:%d subflows %d:%d\n",
 		 msk->pm.local_addr_used, local_addr_max,
 		 msk->pm.add_addr_signaled, add_addr_signal_max,
-- =

2.29.2

--===============8482274874908129881==--
