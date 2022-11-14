Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451D64C60
	for <mptcp@lists.linux.dev>; Mon, 14 Nov 2022 11:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668426873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c8UCMdHy3UuKwXyjx/OyAuvrslIObTk2bCS04EI4vFA=;
	b=P9WLe68c4qpVwypmYAwut70pp3s7dXzt43T2ik5WciA+aN7GtSB/Hns8QbMqk8h6mGmuHv
	X1g3N7rVzvcYJu0+X0EP/t/t9CZbDkqObskxpjIXMWnfDbobR0l/eN8M+0GHsV3kTBlXw2
	ClsmKxIzFtN5JWqX4Cw7DKSoBrCeJF0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-245-4Ygj8V1bNBOoe0FCM-KpKQ-1; Mon, 14 Nov 2022 06:54:30 -0500
X-MC-Unique: 4Ygj8V1bNBOoe0FCM-KpKQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D89C9101A52A;
	Mon, 14 Nov 2022 11:54:29 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.100])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4757F40C845B;
	Mon, 14 Nov 2022 11:54:29 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Subject: [PATCH mptcp-next 1/3] Squash-to: "mptcp: implement delayed seq generation for passive fastopen"
Date: Mon, 14 Nov 2022 12:54:05 +0100
Message-Id: <2b4b21555e06719ee3923f4ed1b0f00c2a3ef507.1668426733.git.pabeni@redhat.com>
In-Reply-To: <cover.1668426733.git.pabeni@redhat.com>
References: <cover.1668426733.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

We should not use double forward slashes for comments. The affending
comments could be removed altogether.

Additionally fix the  SPDX license indentifier

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/fastopen.c | 6 ++++--
 net/mptcp/protocol.h | 2 --
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index d1ae7d2405dc..b41248b50123 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -1,5 +1,7 @@
-/* SPDX-License-Identifier: GPL-2.0
- * MPTCP Fast Open Mechanism. Copyright (c) 2021-2022, Dmytro SHYTYI
+// SPDX-License-Identifier: GPL-2.0
+/* MPTCP Fast Open Mechanism
+ *
+ * Copyright (c) 2021-2022, Dmytro SHYTYI
  */
 
 #include "protocol.h"
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c81bb7d6aab7..0f1e26e55c01 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -848,13 +848,11 @@ void mptcp_event_addr_announced(const struct sock *ssk, const struct mptcp_addr_
 void mptcp_event_addr_removed(const struct mptcp_sock *msk, u8 id);
 bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
 
-// Fast Open Mechanism functions begin
 void mptcp_gen_msk_ackseq_fastopen(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
 				   const struct mptcp_options_received *mp_opt);
 void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk);
 void subflow_fastopen_send_synack_set_params(struct mptcp_subflow_context *subflow,
 					     struct request_sock *req);
-// Fast Open Mechanism functions end
 
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
 {
-- 
2.38.1

