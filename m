Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D94618021
	for <mptcp@lists.linux.dev>; Fri,  6 Oct 2023 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYc0vGgb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41882C433C8;
	Fri,  6 Oct 2023 14:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696603649;
	bh=cuafUrJcRVy2Q66jd1WS6PQHmUZaY2VMMr7lLnTd8O8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YYc0vGgbyOpBJvZjHU3p9bdyDESkJ+JI5GFE/iX/oPazMZnK8VYj48jW0C9HLbdEm
	 q32lFahEl/0wF9XHuAc/8dXt3RjqkyZwZ4M0I1BIi+9ApGVm6fKJIg6TCwaoIAThq/
	 i+H6x38lRdSU7qbVBZo7VeW3eUNtGAKyQECEUOSkNiPeGiBSNyhNrwD4PXu25CuWYo
	 hiA1APATDetrgP3dP/O6fCEXzxGED5oM3E4jw3UTJsTUz1UBlB3YfhoH0bDMuQOpI9
	 7zrJbWaTlUcuSPDYQDNaLa0GNQc7/lXFPkGEZM0MZh3vfR2d5JhTLfYadNzVbwX4xh
	 EVl5uOoc4/IaQ==
From: Matthieu Baerts <matttbe@kernel.org>
Date: Fri, 06 Oct 2023 16:46:39 +0200
Subject: [PATCH net-next 4/6] uapi: mptcp: use header file generated from
 YAML spec
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231006-upstream-net-next-20231006-mptcp-ynl-v1-4-0a97f2f5410e@kernel.org>
References: <20231006-upstream-net-next-20231006-mptcp-ynl-v1-0-0a97f2f5410e@kernel.org>
In-Reply-To: <20231006-upstream-net-next-20231006-mptcp-ynl-v1-0-0a97f2f5410e@kernel.org>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>, 
 Davide Caratti <dcaratti@redhat.com>, Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=12531; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=vWgtCouIRTrJ5tUZ2NkQHWyHpbxOiMYpTLs49qthVHw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlIB35rI1XLLxLIl8wPDlU/D0YuFEG/nhc16zM9
 8PdWaM72XuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZSAd+QAKCRD2t4JPQmmg
 c1zKD/wKkUFt+dC3YKNjl/dEPp03SVnfjYlNNiDX8pfp80WMyzTVlpttRbswDV1uzP4JANniYDa
 aRUdnGOrvxeG4Md17KZNMRZ6W74PJQo4PFIF012cEFSShJnk3gAforlLbMK9PP9swfd4FQbp6OS
 f9hNATLceJlZYQUD/WiM0J2MdmA52VhT14a+H5Xm4krHOzDPMSBmSWukCXngUU2NaUbEybcusb3
 qoq3OkOKme+a7hliBUxx69RXgCrpr8ideVyT5ycYOd/eUD/NLH4gfHsj8S9f5UEq1tSeVsNC0Dk
 Sp94D4HV/ee/47P0E+NtGhzrx+WhClDuzaPXmvZY5HQ5xFhcXx3X3qFccbYH1eo910+8iW21jtQ
 cDFFCW8bfOucBF8rfjdzIHm/E2RAP4mt9UUk4dy+Mt14XK15facBjS/VfadEu888KoSUyt15eyd
 rXUvvdmkFxar/iPGgRaEtOSZIOaJIZkVsjd/u0nXW785ehx9ZMOd3JOjhRRQTubWPIUr/ss6sk6
 NHAHYnQ6RWqKourNpKnr2unYa2GvD9Wj5gjQJhVGyrOyfc4ZHPp2SpVPrnHESHdjm8juztPsrK8
 5rRqwGJ0E0DIBIyEc2grvcCZcMz74I2EfY1bMMU9UZmNFhL7CE8YJkIndPg86GzDWKcL5fB8eC7
 37Zuz+3jl2AG5+w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Davide Caratti <dcaratti@redhat.com>

generated with:

 $ ./tools/net/ynl/ynl-gen-c.py --mode uapi \
 > --spec Documentation/netlink/specs/mptcp.yaml \
 > --header -o include/uapi/linux/mptcp_pm.h

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/340
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 MAINTAINERS                   |   2 +-
 include/uapi/linux/mptcp.h    | 182 +++---------------------------------------
 include/uapi/linux/mptcp_pm.h | 149 ++++++++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+), 173 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d64e3c9eba3f..3441b5a0bcd6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14964,7 +14964,7 @@ F:	Documentation/netlink/specs/mptcp.yaml
 F:	Documentation/networking/mptcp-sysctl.rst
 F:	include/net/mptcp.h
 F:	include/trace/events/mptcp.h
-F:	include/uapi/linux/mptcp.h
+F:	include/uapi/linux/mptcp*.h
 F:	net/mptcp/
 F:	tools/testing/selftests/bpf/*/*mptcp*.c
 F:	tools/testing/selftests/net/mptcp/
diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 0e62937ab17c..64ecc8a3f9f2 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -23,99 +23,24 @@
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
 #define MPTCP_PM_CMD_GRP_NAME	"mptcp_pm_cmds"
 #define MPTCP_PM_EV_GRP_NAME	"mptcp_pm_events"
-#define MPTCP_PM_VER		0x1
 
-/*
- * ATTR types defined for MPTCP
- */
-enum {
-	MPTCP_PM_ATTR_UNSPEC,
+#include <linux/mptcp_pm.h>
 
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
-	MPTCP_PM_ENDPOINT_ADDR = 1,
-
-	__MPTCP_PM_ENDPOINT_MAX
-};
-
-#define MPTCP_PM_ENDPOINT_MAX (__MPTCP_PM_ENDPOINT_MAX - 1)
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
-#define MPTCP_PM_ADDR_FLAG_SIGNAL			(1 << 0)
-#define MPTCP_PM_ADDR_FLAG_SUBFLOW			(1 << 1)
-#define MPTCP_PM_ADDR_FLAG_BACKUP			(1 << 2)
-#define MPTCP_PM_ADDR_FLAG_FULLMESH			(1 << 3)
-#define MPTCP_PM_ADDR_FLAG_IMPLICIT			(1 << 4)
-
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
+/* for backward compatibility */
+#define	__MPTCP_PM_CMD_AFTER_LAST	__MPTCP_PM_CMD_MAX
+#define	__MPTCP_ATTR_AFTER_LAST		__MPTCP_ATTR_MAX
 
 #define MPTCP_INFO_FLAG_FALLBACK		_BITUL(0)
 #define MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED	_BITUL(1)
 
+#define MPTCP_PM_ADDR_FLAG_SIGNAL                      (1 << 0)
+#define MPTCP_PM_ADDR_FLAG_SUBFLOW                     (1 << 1)
+#define MPTCP_PM_ADDR_FLAG_BACKUP                      (1 << 2)
+#define MPTCP_PM_ADDR_FLAG_FULLMESH                    (1 << 3)
+#define MPTCP_PM_ADDR_FLAG_IMPLICIT                    (1 << 4)
+
 struct mptcp_info {
 	__u8	mptcpi_subflows;
 	__u8	mptcpi_add_addr_signal;
@@ -138,93 +63,6 @@ struct mptcp_info {
 	__u64	mptcpi_bytes_acked;
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
index 000000000000..0c7206531eb1
--- /dev/null
+++ b/include/uapi/linux/mptcp_pm.h
@@ -0,0 +1,149 @@
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
+ * enum mptcp_event_type
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
+	MPTCP_PM_ENDPOINT_ADDR = 1,
+
+	__MPTCP_PM_ENDPOINT_MAX
+};
+#define MPTCP_PM_ENDPOINT_MAX (__MPTCP_PM_ENDPOINT_MAX - 1)
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
+#endif /* _UAPI_LINUX_MPTCP_PM_H */

-- 
2.40.1

