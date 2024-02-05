Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FC940BE5
	for <mptcp@lists.linux.dev>; Mon,  5 Feb 2024 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148320; cv=none; b=GNGwtg0MSbeQPiPWXhhSFbvcCFu2qUOJGP/8lQcfym1ZjLB27hrPFEtvfgaLU3zd1+FAu8D78tfN99j9auRqa0P5AcAHlNgQD98+vGbF9DMsPDZMTlXxt05u1MdXRwaNNEkKzhG4fdhi+5RGJ/2848J2TLkfgCHDKeos7NJnqVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148320; c=relaxed/simple;
	bh=ulcqp5t2whr0QNpKFvWoYHxr8/PU3NxAxfWKa57rkYo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oeiYx5SO3rpMI3MVCMydpZQy7ocqdENgk9rjxCM7hfGmHwqg4UTlx+qJkvtpr0slGHAyhVqECbUahJ2P9h3iii1i0524R+o6v8IF6JX+dweFQYVI1nXChNd5PDuOxF02DzA/7d7ma1mBTU7NYB5zem75iSLRPY+lKxZ9Ja7aFg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zp6BdJFY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zp6BdJFY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707148318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=liaJYtvApVInMCvwL6I+QC/u0NAnvPf9shC8ahwhmNE=;
	b=Zp6BdJFYAQK7IE8L7xj5Ss1Z3abfJs8OUptsMpmOoGBRPWs0TqVWUWIJgGUIY+fThwxAaO
	LFArJgzsZBwQVgTyucSnwboHuXveqhP/sa5xAoJTyO01JHCvAIGX88Y8bsgcUrZluUAtuX
	MmEPYFn5fVRKwf1Xy5ve70tWK17Gr6Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-PtIS33_dPEKjaX7pEAhm7w-1; Mon, 05 Feb 2024 10:51:56 -0500
X-MC-Unique: PtIS33_dPEKjaX7pEAhm7w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7207D881C80
	for <mptcp@lists.linux.dev>; Mon,  5 Feb 2024 15:51:56 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.229])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 018113C2E
	for <mptcp@lists.linux.dev>; Mon,  5 Feb 2024 15:51:55 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 3/4] mptcp: fix data races on remote_id
Date: Mon,  5 Feb 2024 16:51:41 +0100
Message-ID: <7487c3a37301428f088edb73cab6d01e55049353.1707144963.git.pabeni@redhat.com>
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

Similar to the previous patch, address the data race on
remote_id, adding the suitable ONCE annotations.

Fixes: bedee0b56113 ("mptcp: address lookup improvements")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm_netlink.c | 8 ++++----
 net/mptcp/subflow.c    | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d1b984c9dc25..066bc855365c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -443,7 +443,7 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
 		mptcp_for_each_subflow(msk, subflow) {
 			ssk = mptcp_subflow_tcp_sock(subflow);
 			remote_address((struct sock_common *)ssk, &addrs[i]);
-			addrs[i].id = subflow->remote_id;
+			addrs[i].id = READ_ONCE(subflow->remote_id);
 			if (deny_id0 && !addrs[i].id)
 				continue;
 
@@ -800,17 +800,17 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 		mptcp_for_each_subflow_safe(msk, subflow, tmp) {
 			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
+			u8 srm_id = READ_ONCE(subflow->remote_id);
 			u8 id = subflow_get_local_id(subflow);
 
-			if (rm_type == MPTCP_MIB_RMADDR && subflow->remote_id != rm_id)
+			if (rm_type == MPTCP_MIB_RMADDR && srm_id != rm_id)
 				continue;
 			if (rm_type == MPTCP_MIB_RMSUBFLOW && !mptcp_local_id_match(msk, id, rm_id))
 				continue;
 
 			pr_debug(" -> %s rm_list_ids[%d]=%u local_id=%u remote_id=%u mpc_id=%u",
 				 rm_type == MPTCP_MIB_RMADDR ? "address" : "subflow",
-				 i, rm_id, id, subflow->remote_id,
-				 msk->mpc_endpoint_id);
+				 i, rm_id, id, srm_id, msk->mpc_endpoint_id);
 			spin_unlock_bh(&msk->pm.lock);
 			mptcp_subflow_shutdown(sk, ssk, how);
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 068784d3e748..6403c56f2902 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -536,7 +536,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		subflow->backup = mp_opt.backup;
 		subflow->thmac = mp_opt.thmac;
 		subflow->remote_nonce = mp_opt.nonce;
-		subflow->remote_id = mp_opt.join_id;
+		WRITE_ONCE(subflow->remote_id, mp_opt.join_id);
 		pr_debug("subflow=%p, thmac=%llu, remote_nonce=%u backup=%d",
 			 subflow, subflow->thmac, subflow->remote_nonce,
 			 subflow->backup);
@@ -1569,7 +1569,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	pr_debug("msk=%p remote_token=%u local_id=%d remote_id=%d", msk,
 		 remote_token, local_id, remote_id);
 	subflow->remote_token = remote_token;
-	subflow->remote_id = remote_id;
+	WRITE_ONCE(subflow->remote_id, remote_id);
 	subflow->request_join = 1;
 	subflow->request_bkup = !!(flags & MPTCP_PM_ADDR_FLAG_BACKUP);
 	subflow->subflow_id = msk->subflow_id++;
@@ -1976,7 +1976,7 @@ static void subflow_ulp_clone(const struct request_sock *req,
 		new_ctx->fully_established = 1;
 		new_ctx->remote_key_valid = 1;
 		new_ctx->backup = subflow_req->backup;
-		new_ctx->remote_id = subflow_req->remote_id;
+		WRITE_ONCE(new_ctx->remote_id, subflow_req->remote_id);
 		new_ctx->token = subflow_req->token;
 		new_ctx->thmac = subflow_req->thmac;
 
-- 
2.43.0

