Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAD940BF4
	for <mptcp@lists.linux.dev>; Mon,  5 Feb 2024 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148321; cv=none; b=TyC2mvQ3U+nbJyegGLlqRQx+IRulrW3HHgl0wzFdfWpI0kY48C4ObrEZgPTY4cto94ZSwG06/Fdapmx95Ijxq2jtFRUobSOvHxTeAAzLjtNqNazBtN6riHmAePL0FLxBbMfv9zHouDkqE3r1ETpASmujlsSW5WhcYf8QcD9FYMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148321; c=relaxed/simple;
	bh=t7bRzGw8v9zjSo+6pymOrtk3Z7hKulBLXIt6KxoXE2k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pBUoNk2ZD58vVyxbOYDmUi72D5Zp4xDTwFhWIDNYW/DPPbV4VDYhcNCTR1qZ/IQMN21USFh+LxgiDWOUETwcaZM+DNNW4NSVYeDerFy0UBmJCCvOJAq15e1wHq9y4he7DniLAmVPA9KGbFbzWcnxabyBUFayyMTKHLhWd9zLkX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LkTyz60u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LkTyz60u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707148317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jCZWWVpYMu8sxWHH5MJaVEICzHIhmk4cs70pZyJPklE=;
	b=LkTyz60u8NGW/FwZIUkbnDB6+igpF559ru7SLkeDJsR4mt8vTwl6ScXbFud5l8TGGtC1oe
	axZipCG87P4LQtGI0VHWWDRHl8qcziaWj35Wa0E42XGjNRHBoUFP+d02skEaAy1h1Kedvz
	5e/fm3DkZU7vfdcQkbNbwT2U4rCYifs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-ptZrIWgbMCSMneJRqGZlZQ-1; Mon,
 05 Feb 2024 10:51:55 -0500
X-MC-Unique: ptZrIWgbMCSMneJRqGZlZQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0E101C04332
	for <mptcp@lists.linux.dev>; Mon,  5 Feb 2024 15:51:55 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.229])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 409EF3C2E
	for <mptcp@lists.linux.dev>; Mon,  5 Feb 2024 15:51:55 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 2/4] mptcp: fix data races on local_id
Date: Mon,  5 Feb 2024 16:51:40 +0100
Message-ID: <34c617cdc777aa32b1fa4ecc5c23784255f5fa56.1707144963.git.pabeni@redhat.com>
In-Reply-To: <cover.1707144963.git.pabeni@redhat.com>
References: <cover.1707144963.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The local address id is accessed lockless by the NL PM, add
all the required ONCE annotation. There is a caveat: the local
id can be initialized late in the subflow life-cycle, and its
validity is controlled by the local_id_valid flag.

Remove such flag and encode the validity in the local_id field
itself with negative value before initialization. That allows
accessing the field consistently with a single read operation.

Fixes: 0ee4261a3681 ("mptcp: implement mptcp_pm_remove_subflow")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm_netlink.c |  4 ++--
 net/mptcp/protocol.c   |  2 +-
 net/mptcp/protocol.h   | 15 ++++++++++++---
 net/mptcp/subflow.c    |  9 +++++----
 4 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d9ad45959219..d1b984c9dc25 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -800,7 +800,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 		mptcp_for_each_subflow_safe(msk, subflow, tmp) {
 			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
-			u8 id = subflow->local_id;
+			u8 id = subflow_get_local_id(subflow);
 
 			if (rm_type == MPTCP_MIB_RMADDR && subflow->remote_id != rm_id)
 				continue;
@@ -809,7 +809,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 
 			pr_debug(" -> %s rm_list_ids[%d]=%u local_id=%u remote_id=%u mpc_id=%u",
 				 rm_type == MPTCP_MIB_RMADDR ? "address" : "subflow",
-				 i, rm_id, subflow->local_id, subflow->remote_id,
+				 i, rm_id, id, subflow->remote_id,
 				 msk->mpc_endpoint_id);
 			spin_unlock_bh(&msk->pm.lock);
 			mptcp_subflow_shutdown(sk, ssk, how);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a8a94b34a51e..626fb4907381 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -85,7 +85,7 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
 	subflow->subflow_id = msk->subflow_id++;
 
 	/* This is the first subflow, always with id 0 */
-	subflow->local_id_valid = 1;
+	WRITE_ONCE(subflow->local_id, 0);
 	mptcp_sock_graft(msk->first, sk->sk_socket);
 	iput(SOCK_INODE(ssock));
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index de04b97e8dd1..9813de82bab8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -493,10 +493,9 @@ struct mptcp_subflow_context {
 		remote_key_valid : 1,        /* received the peer key from */
 		disposable : 1,	    /* ctx can be free at ulp release time */
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
-		local_id_valid : 1, /* local_id is correctly initialized */
 		valid_csum_seen : 1,        /* at least one csum validated */
 		is_mptfo : 1,	    /* subflow is doing TFO */
-		__unused : 9;
+		__unused : 10;
 	bool	data_avail;
 	bool	scheduled;
 	u32	remote_nonce;
@@ -507,7 +506,7 @@ struct mptcp_subflow_context {
 		u8	hmac[MPTCPOPT_HMAC_LEN]; /* MPJ subflow only */
 		u64	iasn;	    /* initial ack sequence number, MPC subflows only */
 	};
-	u8	local_id;
+	s16	local_id;	    /* if negative not initialized yet */
 	u8	remote_id;
 	u8	reset_seen:1;
 	u8	reset_transient:1;
@@ -558,6 +557,7 @@ mptcp_subflow_ctx_reset(struct mptcp_subflow_context *subflow)
 {
 	memset(&subflow->reset, 0, sizeof(subflow->reset));
 	subflow->request_mptcp = 1;
+	WRITE_ONCE(subflow->local_id, -1);
 }
 
 static inline u64
@@ -1064,6 +1064,15 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 
+static inline int subflow_get_local_id(struct mptcp_subflow_context *subflow)
+{
+	int local_id = READ_ONCE(subflow->local_id);
+
+	if (local_id < 0)
+		return 0;
+	return local_id;
+}
+
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
 void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 02dab0669cfc..068784d3e748 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -578,8 +578,8 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 
 static void subflow_set_local_id(struct mptcp_subflow_context *subflow, int local_id)
 {
-	subflow->local_id = local_id;
-	subflow->local_id_valid = 1;
+	WARN_ON_ONCE(local_id < 0 || local_id > 255);
+	WRITE_ONCE(subflow->local_id, local_id);
 }
 
 static int subflow_chk_local_id(struct sock *sk)
@@ -588,7 +588,7 @@ static int subflow_chk_local_id(struct sock *sk)
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	int err;
 
-	if (likely(subflow->local_id_valid))
+	if (likely(subflow->local_id >= 0))
 		return 0;
 
 	err = mptcp_pm_get_local_id(msk, (struct sock_common *)sk);
@@ -1733,6 +1733,7 @@ static struct mptcp_subflow_context *subflow_create_ctx(struct sock *sk,
 	pr_debug("subflow=%p", ctx);
 
 	ctx->tcp_sock = sk;
+	WRITE_ONCE(ctx->local_id, -1);
 
 	return ctx;
 }
@@ -1968,7 +1969,7 @@ static void subflow_ulp_clone(const struct request_sock *req,
 		new_ctx->idsn = subflow_req->idsn;
 
 		/* this is the first subflow, id is always 0 */
-		new_ctx->local_id_valid = 1;
+		subflow_set_local_id(new_ctx, 0);
 	} else if (subflow_req->mp_join) {
 		new_ctx->ssn_offset = subflow_req->ssn_offset;
 		new_ctx->mp_join = 1;
-- 
2.43.0

