Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2372FA1
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 14:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619189418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LO+mEG7+/nDIeDLcTZMyPogJhfB+p22mb4BMBPpvDaE=;
	b=dCddn9lF1RMLw3LHtaeKENv60mKTuQo+qTOrG/6+GglXl9sB3eIKFUugz0AjYub9xH+hgG
	apIccbpjxw0+wVqvSLWo+S4719Rd3l7T46ybve6i2o3woxELvwicgndBTXEpRczEhRE4Sf
	YTQZYBH6wu46i0NsMxoMlz1UXwiKslU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-PemPSNQINsGok86uHfs9Jg-1; Fri, 23 Apr 2021 10:50:16 -0400
X-MC-Unique: PemPSNQINsGok86uHfs9Jg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E573107ACC7;
	Fri, 23 Apr 2021 14:50:15 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-115-60.ams2.redhat.com [10.36.115.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B122419D9B;
	Fri, 23 Apr 2021 14:50:14 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v4 mptcp-next 01/22] mptcp: add csum_enabled in mptcp_sock
Date: Fri, 23 Apr 2021 16:49:40 +0200
Message-Id: <511ec4079ae824f1b007eff8065a6b962bb4adbf.1619189145.git.pabeni@redhat.com>
In-Reply-To: <cover.1619189145.git.pabeni@redhat.com>
References: <cover.1619189145.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

From: Geliang Tang <geliangtang@gmail.com>

This patch added a new member named csum_enabled in struct mptcp_sock,
used a dummy mptcp_is_checksum_enabled() helper to initialize it.

Also added a new member named mptcpi_csum_enabled in struct mptcp_info
to expose the csum_enabled flag.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 include/uapi/linux/mptcp.h | 1 +
 net/mptcp/mptcp_diag.c     | 1 +
 net/mptcp/protocol.c       | 1 +
 net/mptcp/protocol.h       | 2 ++
 4 files changed, 5 insertions(+)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 8eb3c0844bff..7b05f7102321 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -105,6 +105,7 @@ struct mptcp_info {
 	__u64	mptcpi_rcv_nxt;
 	__u8	mptcpi_local_addr_used;
 	__u8	mptcpi_local_addr_max;
+	__u8	mptcpi_csum_enabled;
 };
 
 /*
diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
index f16d9b5ee978..8f88ddeab6a2 100644
--- a/net/mptcp/mptcp_diag.c
+++ b/net/mptcp/mptcp_diag.c
@@ -144,6 +144,7 @@ static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
 	info->mptcpi_write_seq = READ_ONCE(msk->write_seq);
 	info->mptcpi_snd_una = READ_ONCE(msk->snd_una);
 	info->mptcpi_rcv_nxt = READ_ONCE(msk->ack_seq);
+	info->mptcpi_csum_enabled = READ_ONCE(msk->csum_enabled);
 	unlock_sock_fast(sk, slow);
 }
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a8180a917649..5b6bb1d27af5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2392,6 +2392,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	msk->ack_hint = NULL;
 	msk->first = NULL;
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
+	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
 
 	mptcp_pm_data_init(msk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index edc0128730df..240a5d9bc7da 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -234,6 +234,7 @@ struct mptcp_sock {
 	bool		snd_data_fin_enable;
 	bool		rcv_fastclose;
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
+	bool		csum_enabled;
 	spinlock_t	join_list_lock;
 	struct sock	*ack_hint;
 	struct work_struct work;
@@ -524,6 +525,7 @@ static inline void mptcp_subflow_delegated_done(struct mptcp_subflow_context *su
 
 int mptcp_is_enabled(struct net *net);
 unsigned int mptcp_get_add_addr_timeout(struct net *net);
+static inline int mptcp_is_checksum_enabled(struct net *net) { return false; }
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
 bool mptcp_subflow_data_available(struct sock *sk);
-- 
2.26.2

