Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B442FAF
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 21:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1626210839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K2N6Fn/N7ABq3u76utru/yFxxfiVTI3Y393H9vjWKgU=;
	b=XgJF607ck2yNlBmkLDR85LUHi3K3m9kUJz0+RhABA6ZpFylglkuKGvA3y877hZM7eG+n0q
	8dsrFd/cyjoInTg5OFH4nTC2jhz5lMm+juZJO39/LvQhNwT0wwQ4B8WWbP+N1N2gJ6QVMe
	WIo0ZcKCLf9XPxFtUfP/Br8Ui/2pnHE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-OqITF5wcOyShzamvVuX6dw-1; Tue, 13 Jul 2021 17:13:57 -0400
X-MC-Unique: OqITF5wcOyShzamvVuX6dw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE931804140
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 21:13:56 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-113-114.ams2.redhat.com [10.36.113.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 66DB860C5F
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 21:13:56 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 6/8] mptcp: add mibs for stale subflows processing
Date: Tue, 13 Jul 2021 23:13:36 +0200
Message-Id: <31dc07338af1eb3a6be4d562354c1e132ecb45c8.1626210682.git.pabeni@redhat.com>
In-Reply-To: <cover.1626210682.git.pabeni@redhat.com>
References: <cover.1626210682.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

This allows monitoring exceptional events like
active backup scenarios.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/mib.c        | 2 ++
 net/mptcp/mib.h        | 2 ++
 net/mptcp/pm.c         | 2 ++
 net/mptcp/pm_netlink.c | 1 +
 net/mptcp/protocol.c   | 1 +
 5 files changed, 8 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index ff2cc0e3273d..3a7c4e7b2d79 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -45,6 +45,8 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPPrioTx", MPTCP_MIB_MPPRIOTX),
 	SNMP_MIB_ITEM("MPPrioRx", MPTCP_MIB_MPPRIORX),
 	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
+	SNMP_MIB_ITEM("SubflowStale", MPTCP_MIB_SUBFLOWSTALE),
+	SNMP_MIB_ITEM("SubflowRecover", MPTCP_MIB_SUBFLOWRECOVER),
 	SNMP_MIB_SENTINEL
 };
 
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 0663cb12b448..8ec16c991aac 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -38,6 +38,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_MPPRIOTX,		/* Transmit a MP_PRIO */
 	MPTCP_MIB_MPPRIORX,		/* Received a MP_PRIO */
 	MPTCP_MIB_RCVPRUNED,		/* Incoming packet dropped due to memory limit */
+	MPTCP_MIB_SUBFLOWSTALE,		/* Subflows entered 'stale' status */
+	MPTCP_MIB_SUBFLOWRECOVER,	/* Subflows returned to active status after being stale */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d8a85fe92360..0ed3e565f8f8 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -10,6 +10,8 @@
 #include <net/mptcp.h>
 #include "protocol.h"
 
+#include "mib.h"
+
 /* path manager command handlers */
 
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index eb1f5cf89423..3d4fa2dd2cea 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -924,6 +924,7 @@ void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ss
 			if (!tcp_rtx_and_write_queues_empty(ssk)) {
 				subflow->stale = 1;
 				push = __mptcp_retransmit_pending_data(sk);
+				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_SUBFLOWSTALE);
 			}
 			unlock_sock_fast(ssk, slow);
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e936b88d340d..8eb2626503d7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1397,6 +1397,7 @@ void mptcp_subflow_set_active(struct mptcp_subflow_context *subflow)
 		return;
 
 	subflow->stale = 0;
+	MPTCP_INC_STATS(sock_net(mptcp_subflow_tcp_sock(subflow)), MPTCP_MIB_SUBFLOWRECOVER);
 }
 
 bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
-- 
2.26.3

