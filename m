Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFDBAD29
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 17:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680802344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9sMTjUgBCg5RQURuwZB7BqHBHTzaNNE52gijOTF87Lw=;
	b=Ye7EzEPSBZKo4IBpyaB2soF4AiYSNI8UxGRfOMMwrcqFSZJRSmNRLmhmqDe+ZGog3DxEoW
	bN3bSbLAnzjqcu26heuMWbC5lKY2XAiRzuBJ0a/fPwUYDtWMeWTeCCxOQkPUco0dP7IQ0O
	BKIB1qlOVpGGIW5LQ9Ap5PpC4X436gI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-civxzVlCPF-rs2e6WFKHGg-1; Thu, 06 Apr 2023 13:32:23 -0400
X-MC-Unique: civxzVlCPF-rs2e6WFKHGg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2535C2A59560
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 17:32:23 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.225.137])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B58ED202701F
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 17:32:22 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH RFC mptcp-net-next 4/5] mptcp: uapi: add header files generated from YAML spec
Date: Thu,  6 Apr 2023 19:32:04 +0200
Message-ID: <4c229365bc411badb667514dc5c06d6771b86a90.1680801697.git.dcaratti@redhat.com>
In-Reply-To: <cover.1680801697.git.dcaratti@redhat.com>
References: <cover.1680801697.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Message-ID: <20230406173204.Vmvbc_hdd45ECLw0HRYhazp9PN9ICaZOkRcLdecQsCE@z>

 $ ./tools/net/ynl/ynl-gen-c.py --mode uapi \
 > --spec Documentation/netlink/specs/mptcp.yaml --header \
 > -o include/uapi/linux/mptcp_pm.h

and remove these definitions from mptcp.h

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 include/uapi/linux/mptcp.h    | 167 +---------------------------------
 include/uapi/linux/mptcp_pm.h | 145 +++++++++++++++++++++++++++++
 2 files changed, 149 insertions(+), 163 deletions(-)
 create mode 100644 include/uapi/linux/mptcp_pm.h

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 32af2d278cb4..f919f43a178a 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -12,6 +12,10 @@
 #include <linux/in.h>		/* for sockaddr_in			*/
 #include <linux/in6.h>		/* for sockaddr_in6			*/
 #include <linux/socket.h>	/* for sockaddr_storage and sa_family	*/
+#include <linux/mptcp_pm.h>	/* for netlink interface		*/
+
+#define __MPTCP_PM_CMD_AFTER_LAST  __MPTCP_PM_CMD_MAX
+#define __MPTCP_ATTR_AFTER_LAST	__MPTCP_ATTR_MAX
 
 #define MPTCP_SUBFLOW_FLAG_MCAP_REM		_BITUL(0)
 #define MPTCP_SUBFLOW_FLAG_MCAP_LOC		_BITUL(1)
@@ -23,88 +27,12 @@
 #define MPTCP_SUBFLOW_FLAG_CONNECTED		_BITUL(7)
 #define MPTCP_SUBFLOW_FLAG_MAPVALID		_BITUL(8)
 
-enum {
-	MPTCP_SUBFLOW_ATTR_UNSPEC,
-	MPTCP_SUBFLOW_ATTR_TOKEN_REM,
-	MPTCP_SUBFLOW_ATTR_TOKEN_LOC,
-	MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ,
-	MPTCP_SUBFLOW_ATTR_MAP_SEQ,
-	MPTCP_SUBFLOW_ATTR_MAP_SFSEQ,
-	MPTCP_SUBFLOW_ATTR_SSN_OFFSET,
-	MPTCP_SUBFLOW_ATTR_MAP_DATALEN,
-	MPTCP_SUBFLOW_ATTR_FLAGS,
-	MPTCP_SUBFLOW_ATTR_ID_REM,
-	MPTCP_SUBFLOW_ATTR_ID_LOC,
-	MPTCP_SUBFLOW_ATTR_PAD,
-	__MPTCP_SUBFLOW_ATTR_MAX
-};
-
-#define MPTCP_SUBFLOW_ATTR_MAX (__MPTCP_SUBFLOW_ATTR_MAX - 1)
-
-/* netlink interface */
-#define MPTCP_PM_NAME		"mptcp_pm"
-#define MPTCP_PM_CMD_GRP_NAME	"mptcp_pm_cmds"
-#define MPTCP_PM_EV_GRP_NAME	"mptcp_pm_events"
-#define MPTCP_PM_VER		0x1
-
-/*
- * ATTR types defined for MPTCP
- */
-enum {
-	MPTCP_PM_ATTR_UNSPEC,
-
-	MPTCP_PM_ATTR_ADDR,				/* nested address */
-	MPTCP_PM_ATTR_RCV_ADD_ADDRS,			/* u32 */
-	MPTCP_PM_ATTR_SUBFLOWS,				/* u32 */
-	MPTCP_PM_ATTR_TOKEN,				/* u32 */
-	MPTCP_PM_ATTR_LOC_ID,				/* u8 */
-	MPTCP_PM_ATTR_ADDR_REMOTE,			/* nested address */
-
-	__MPTCP_PM_ATTR_MAX
-};
-
-#define MPTCP_PM_ATTR_MAX (__MPTCP_PM_ATTR_MAX - 1)
-
-enum {
-	MPTCP_PM_ADDR_ATTR_UNSPEC,
-
-	MPTCP_PM_ADDR_ATTR_FAMILY,			/* u16 */
-	MPTCP_PM_ADDR_ATTR_ID,				/* u8 */
-	MPTCP_PM_ADDR_ATTR_ADDR4,			/* struct in_addr */
-	MPTCP_PM_ADDR_ATTR_ADDR6,			/* struct in6_addr */
-	MPTCP_PM_ADDR_ATTR_PORT,			/* u16 */
-	MPTCP_PM_ADDR_ATTR_FLAGS,			/* u32 */
-	MPTCP_PM_ADDR_ATTR_IF_IDX,			/* s32 */
-
-	__MPTCP_PM_ADDR_ATTR_MAX
-};
-
-#define MPTCP_PM_ADDR_ATTR_MAX (__MPTCP_PM_ADDR_ATTR_MAX - 1)
-
 #define MPTCP_PM_ADDR_FLAG_SIGNAL			(1 << 0)
 #define MPTCP_PM_ADDR_FLAG_SUBFLOW			(1 << 1)
 #define MPTCP_PM_ADDR_FLAG_BACKUP			(1 << 2)
 #define MPTCP_PM_ADDR_FLAG_FULLMESH			(1 << 3)
 #define MPTCP_PM_ADDR_FLAG_IMPLICIT			(1 << 4)
 
-enum {
-	MPTCP_PM_CMD_UNSPEC,
-
-	MPTCP_PM_CMD_ADD_ADDR,
-	MPTCP_PM_CMD_DEL_ADDR,
-	MPTCP_PM_CMD_GET_ADDR,
-	MPTCP_PM_CMD_FLUSH_ADDRS,
-	MPTCP_PM_CMD_SET_LIMITS,
-	MPTCP_PM_CMD_GET_LIMITS,
-	MPTCP_PM_CMD_SET_FLAGS,
-	MPTCP_PM_CMD_ANNOUNCE,
-	MPTCP_PM_CMD_REMOVE,
-	MPTCP_PM_CMD_SUBFLOW_CREATE,
-	MPTCP_PM_CMD_SUBFLOW_DESTROY,
-
-	__MPTCP_PM_CMD_AFTER_LAST
-};
-
 #define MPTCP_INFO_FLAG_FALLBACK		_BITUL(0)
 #define MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED	_BITUL(1)
 
@@ -125,93 +53,6 @@ struct mptcp_info {
 	__u8	mptcpi_csum_enabled;
 };
 
-/*
- * MPTCP_EVENT_CREATED: token, family, saddr4 | saddr6, daddr4 | daddr6,
- *                      sport, dport
- * A new MPTCP connection has been created. It is the good time to allocate
- * memory and send ADD_ADDR if needed. Depending on the traffic-patterns
- * it can take a long time until the MPTCP_EVENT_ESTABLISHED is sent.
- *
- * MPTCP_EVENT_ESTABLISHED: token, family, saddr4 | saddr6, daddr4 | daddr6,
- *			    sport, dport
- * A MPTCP connection is established (can start new subflows).
- *
- * MPTCP_EVENT_CLOSED: token
- * A MPTCP connection has stopped.
- *
- * MPTCP_EVENT_ANNOUNCED: token, rem_id, family, daddr4 | daddr6 [, dport]
- * A new address has been announced by the peer.
- *
- * MPTCP_EVENT_REMOVED: token, rem_id
- * An address has been lost by the peer.
- *
- * MPTCP_EVENT_SUB_ESTABLISHED: token, family, loc_id, rem_id,
- *                              saddr4 | saddr6, daddr4 | daddr6, sport,
- *                              dport, backup, if_idx [, error]
- * A new subflow has been established. 'error' should not be set.
- *
- * MPTCP_EVENT_SUB_CLOSED: token, family, loc_id, rem_id, saddr4 | saddr6,
- *                         daddr4 | daddr6, sport, dport, backup, if_idx
- *                         [, error]
- * A subflow has been closed. An error (copy of sk_err) could be set if an
- * error has been detected for this subflow.
- *
- * MPTCP_EVENT_SUB_PRIORITY: token, family, loc_id, rem_id, saddr4 | saddr6,
- *                           daddr4 | daddr6, sport, dport, backup, if_idx
- *                           [, error]
- * The priority of a subflow has changed. 'error' should not be set.
- *
- * MPTCP_EVENT_LISTENER_CREATED: family, sport, saddr4 | saddr6
- * A new PM listener is created.
- *
- * MPTCP_EVENT_LISTENER_CLOSED: family, sport, saddr4 | saddr6
- * A PM listener is closed.
- */
-enum mptcp_event_type {
-	MPTCP_EVENT_UNSPEC = 0,
-	MPTCP_EVENT_CREATED = 1,
-	MPTCP_EVENT_ESTABLISHED = 2,
-	MPTCP_EVENT_CLOSED = 3,
-
-	MPTCP_EVENT_ANNOUNCED = 6,
-	MPTCP_EVENT_REMOVED = 7,
-
-	MPTCP_EVENT_SUB_ESTABLISHED = 10,
-	MPTCP_EVENT_SUB_CLOSED = 11,
-
-	MPTCP_EVENT_SUB_PRIORITY = 13,
-
-	MPTCP_EVENT_LISTENER_CREATED = 15,
-	MPTCP_EVENT_LISTENER_CLOSED = 16,
-};
-
-enum mptcp_event_attr {
-	MPTCP_ATTR_UNSPEC = 0,
-
-	MPTCP_ATTR_TOKEN,	/* u32 */
-	MPTCP_ATTR_FAMILY,	/* u16 */
-	MPTCP_ATTR_LOC_ID,	/* u8 */
-	MPTCP_ATTR_REM_ID,	/* u8 */
-	MPTCP_ATTR_SADDR4,	/* be32 */
-	MPTCP_ATTR_SADDR6,	/* struct in6_addr */
-	MPTCP_ATTR_DADDR4,	/* be32 */
-	MPTCP_ATTR_DADDR6,	/* struct in6_addr */
-	MPTCP_ATTR_SPORT,	/* be16 */
-	MPTCP_ATTR_DPORT,	/* be16 */
-	MPTCP_ATTR_BACKUP,	/* u8 */
-	MPTCP_ATTR_ERROR,	/* u8 */
-	MPTCP_ATTR_FLAGS,	/* u16 */
-	MPTCP_ATTR_TIMEOUT,	/* u32 */
-	MPTCP_ATTR_IF_IDX,	/* s32 */
-	MPTCP_ATTR_RESET_REASON,/* u32 */
-	MPTCP_ATTR_RESET_FLAGS, /* u32 */
-	MPTCP_ATTR_SERVER_SIDE,	/* u8 */
-
-	__MPTCP_ATTR_AFTER_LAST
-};
-
-#define MPTCP_ATTR_MAX (__MPTCP_ATTR_AFTER_LAST - 1)
-
 /* MPTCP Reset reason codes, rfc8684 */
 #define MPTCP_RST_EUNSPEC	0
 #define MPTCP_RST_EMPTCP	1
diff --git a/include/uapi/linux/mptcp_pm.h b/include/uapi/linux/mptcp_pm.h
new file mode 100644
index 000000000000..37cdae7a871b
--- /dev/null
+++ b/include/uapi/linux/mptcp_pm.h
@@ -0,0 +1,145 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/mptcp.yaml */
+/* YNL-GEN uapi header */
+
+#ifndef _UAPI_LINUX_MPTCP_PM_H
+#define _UAPI_LINUX_MPTCP_PM_H
+
+#define MPTCP_PM_NAME	"mptcp_pm"
+#define MPTCP_PM_VER	1
+
+/**
+ * enum mptcp_pm_event_type
+ * @MPTCP_EVENT_CREATED: token, family, saddr4 | saddr6, daddr4 | daddr6,
+ *   sport, dport A new MPTCP connection has been created. It is the good time
+ *   to allocate memory and send ADD_ADDR if needed. Depending on the
+ *   traffic-patterns it can take a long time until the MPTCP_EVENT_ESTABLISHED
+ *   is sent.
+ * @MPTCP_EVENT_ESTABLISHED: token, family, saddr4 | saddr6, daddr4 | daddr6,
+ *   sport, dport A MPTCP connection is established (can start new subflows).
+ * @MPTCP_EVENT_CLOSED: token A MPTCP connection has stopped.
+ * @MPTCP_EVENT_ANNOUNCED: token, rem_id, family, daddr4 | daddr6 [, dport] A
+ *   new address has been announced by the peer.
+ * @MPTCP_EVENT_REMOVED: token, rem_id An address has been lost by the peer.
+ * @MPTCP_EVENT_SUB_ESTABLISHED: token, family, loc_id, rem_id, saddr4 |
+ *   saddr6, daddr4 | daddr6, sport, dport, backup, if_idx [, error] A new
+ *   subflow has been established. 'error' should not be set.
+ * @MPTCP_EVENT_SUB_CLOSED: token, family, loc_id, rem_id, saddr4 | saddr6,
+ *   daddr4 | daddr6, sport, dport, backup, if_idx [, error] A subflow has been
+ *   closed. An error (copy of sk_err) could be set if an error has been
+ *   detected for this subflow.
+ * @MPTCP_EVENT_SUB_PRIORITY: token, family, loc_id, rem_id, saddr4 | saddr6,
+ *   daddr4 | daddr6, sport, dport, backup, if_idx [, error] The priority of a
+ *   subflow has changed. 'error' should not be set.
+ * @MPTCP_EVENT_LISTENER_CREATED: family, sport, saddr4 | saddr6 A new PM
+ *   listener is created.
+ * @MPTCP_EVENT_LISTENER_CLOSED: family, sport, saddr4 | saddr6 A PM listener
+ *   is closed.
+ */
+enum mptcp_event_type {
+	MPTCP_EVENT_UNSPEC,
+	MPTCP_EVENT_CREATED,
+	MPTCP_EVENT_ESTABLISHED,
+	MPTCP_EVENT_CLOSED,
+	MPTCP_EVENT_ANNOUNCED = 6,
+	MPTCP_EVENT_REMOVED,
+	MPTCP_EVENT_SUB_ESTABLISHED = 10,
+	MPTCP_EVENT_SUB_CLOSED,
+	MPTCP_EVENT_SUB_PRIORITY = 13,
+	MPTCP_EVENT_LISTENER_CREATED = 15,
+	MPTCP_EVENT_LISTENER_CLOSED,
+};
+
+enum {
+	MPTCP_PM_ADDR_ATTR_UNSPEC,
+	MPTCP_PM_ADDR_ATTR_FAMILY,
+	MPTCP_PM_ADDR_ATTR_ID,
+	MPTCP_PM_ADDR_ATTR_ADDR4,
+	MPTCP_PM_ADDR_ATTR_ADDR6,
+	MPTCP_PM_ADDR_ATTR_PORT,
+	MPTCP_PM_ADDR_ATTR_FLAGS,
+	MPTCP_PM_ADDR_ATTR_IF_IDX,
+
+	__MPTCP_PM_ADDR_ATTR_MAX
+};
+#define MPTCP_PM_ADDR_ATTR_MAX (__MPTCP_PM_ADDR_ATTR_MAX - 1)
+
+enum {
+	MPTCP_SUBFLOW_ATTR_UNSPEC,
+	MPTCP_SUBFLOW_ATTR_TOKEN_REM,
+	MPTCP_SUBFLOW_ATTR_TOKEN_LOC,
+	MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ,
+	MPTCP_SUBFLOW_ATTR_MAP_SEQ,
+	MPTCP_SUBFLOW_ATTR_MAP_SFSEQ,
+	MPTCP_SUBFLOW_ATTR_SSN_OFFSET,
+	MPTCP_SUBFLOW_ATTR_MAP_DATALEN,
+	MPTCP_SUBFLOW_ATTR_FLAGS,
+	MPTCP_SUBFLOW_ATTR_ID_REM,
+	MPTCP_SUBFLOW_ATTR_ID_LOC,
+	MPTCP_SUBFLOW_ATTR_PAD,
+
+	__MPTCP_SUBFLOW_ATTR_MAX
+};
+#define MPTCP_SUBFLOW_ATTR_MAX (__MPTCP_SUBFLOW_ATTR_MAX - 1)
+
+enum {
+	MPTCP_PM_ATTR_UNSPEC,
+	MPTCP_PM_ATTR_ADDR,
+	MPTCP_PM_ATTR_RCV_ADD_ADDRS,
+	MPTCP_PM_ATTR_SUBFLOWS,
+	MPTCP_PM_ATTR_TOKEN,
+	MPTCP_PM_ATTR_LOC_ID,
+	MPTCP_PM_ATTR_ADDR_REMOTE,
+
+	__MPTCP_PM_ATTR_MAX
+};
+#define MPTCP_PM_ATTR_MAX (__MPTCP_PM_ATTR_MAX - 1)
+
+enum mptcp_event_attr {
+	MPTCP_ATTR_UNSPEC,
+	MPTCP_ATTR_TOKEN,
+	MPTCP_ATTR_FAMILY,
+	MPTCP_ATTR_LOC_ID,
+	MPTCP_ATTR_REM_ID,
+	MPTCP_ATTR_SADDR4,
+	MPTCP_ATTR_SADDR6,
+	MPTCP_ATTR_DADDR4,
+	MPTCP_ATTR_DADDR6,
+	MPTCP_ATTR_SPORT,
+	MPTCP_ATTR_DPORT,
+	MPTCP_ATTR_BACKUP,
+	MPTCP_ATTR_ERROR,
+	MPTCP_ATTR_FLAGS,
+	MPTCP_ATTR_TIMEOUT,
+	MPTCP_ATTR_IF_IDX,
+	MPTCP_ATTR_RESET_REASON,
+	MPTCP_ATTR_RESET_FLAGS,
+	MPTCP_ATTR_SERVER_SIDE,
+
+	__MPTCP_ATTR_MAX
+};
+#define MPTCP_ATTR_MAX (__MPTCP_ATTR_MAX - 1)
+
+enum {
+	MPTCP_PM_CMD_UNSPEC,
+	MPTCP_PM_CMD_ADD_ADDR,
+	MPTCP_PM_CMD_DEL_ADDR,
+	MPTCP_PM_CMD_GET_ADDR,
+	MPTCP_PM_CMD_FLUSH_ADDRS,
+	MPTCP_PM_CMD_SET_LIMITS,
+	MPTCP_PM_CMD_GET_LIMITS,
+	MPTCP_PM_CMD_SET_FLAGS,
+	MPTCP_PM_CMD_ANNOUNCE,
+	MPTCP_PM_CMD_REMOVE,
+	MPTCP_PM_CMD_SUBFLOW_CREATE,
+	MPTCP_PM_CMD_SUBFLOW_DESTROY,
+
+	__MPTCP_PM_CMD_MAX
+};
+#define MPTCP_PM_CMD_MAX (__MPTCP_PM_CMD_MAX - 1)
+
+#define MPTCP_PM_CMD_GRP_NAME	"mptcp_pm_cmds"
+#define MPTCP_PM_EV_GRP_NAME	"mptcp_pm_events"
+
+#endif /* _UAPI_LINUX_MPTCP_PM_H */
-- 
2.39.2

