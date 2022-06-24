Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E837C
	for <mptcp@lists.linux.dev>; Fri, 24 Jun 2022 16:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656088700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hby7L1tgly8ED5o+KmGz7tjD892ck5ORtnujVbBFiMg=;
	b=KgOsat3F/uVsBXjY/zURc9wakYQZnknr/S5XrakV5mpMbV7GkpIjC91YbI0CLQ6lbxIi59
	j8hVgBuqhoQ35r3u57AUxn7tm/49Zpy/Au8U+4p4T7P/PHKZVumibOcenxZpse0IbHKSHR
	yhVcMnDKyVt6efIIYHrJBQ9vmKw4V4c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-209-poj616DZPsiuqiWYpVjB5A-1; Fri, 24 Jun 2022 12:38:19 -0400
X-MC-Unique: poj616DZPsiuqiWYpVjB5A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC3CB3C0D1A7
	for <mptcp@lists.linux.dev>; Fri, 24 Jun 2022 16:38:18 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.243])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4A4EE2026D64
	for <mptcp@lists.linux.dev>; Fri, 24 Jun 2022 16:38:18 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH RFC 4/4] mptcp: more accurate MPC endpoint tracking
Date: Fri, 24 Jun 2022 18:38:10 +0200
Message-Id: <25ad186319f6b464aee3286c0386f2851f9a1f8f.1656088406.git.pabeni@redhat.com>
In-Reply-To: <cover.1656088406.git.pabeni@redhat.com>
References: <cover.1656088406.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Currently the id accounting for the ID 0 subflow is not correct:
at creation time we mark (correctly) as unavailable the endpoint
id corresponding the MPC subflow source address, while at subflow
removal time set as available the id 0.

With this change we track explicitly the endpoint id corresponding
to the MPC subflow so that we can mark it as available at removal time.
Additionally this allow deleting the initial subflow via the NL PM
specifying the corresponding endpoint id.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm_netlink.c | 20 +++++++++++++-------
 net/mptcp/protocol.h   |  1 +
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a6eb501e5031..cd0093ff1103 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -540,6 +540,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		entry = __lookup_addr(pernet, &mpc_addr, false);
 		if (entry) {
 			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
+			msk->mpc_endpoint_id = entry->addr.id;
 			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
 		}
 		rcu_read_unlock();
@@ -752,6 +753,11 @@ static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 	return -EINVAL;
 }
 
+static bool mptcp_local_id_match(const struct mptcp_sock *msk, u8 local_id, u8 id)
+{
+	return local_id == id || (!local_id && msk->mpc_endpoint_id == id);
+}
+
 static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 					   const struct mptcp_rm_list *rm_list,
 					   enum linux_mptcp_mib_field rm_type)
@@ -775,6 +781,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 		return;
 
 	for (i = 0; i < rm_list->nr; i++) {
+		u8 rm_id = rm_list->ids[i];
 		bool removed = false;
 
 		list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
@@ -782,15 +789,14 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
 			u8 id = subflow->local_id;
 
-			if (rm_type == MPTCP_MIB_RMADDR)
-				id = subflow->remote_id;
-
-			if (rm_list->ids[i] != id)
+			if (rm_type == MPTCP_MIB_RMADDR && subflow->remote_id != rm_id)
+				continue;
+			if (rm_type == MPTCP_MIB_RMSUBFLOW && !mptcp_local_id_match(msk, id, rm_id))
 				continue;
 
-			pr_debug(" -> %s rm_list_ids[%d]=%u local_id=%u remote_id=%u",
+			pr_debug(" -> %s rm_list_ids[%d]=%u local_id=%u remote_id=%u mpc_id=%u",
 				 rm_type == MPTCP_MIB_RMADDR ? "address" : "subflow",
-				 i, rm_list->ids[i], subflow->local_id, subflow->remote_id);
+				 i, rm_id, subflow->local_id, subflow->remote_id, msk->mpc_endpoint_id);
 			spin_unlock_bh(&msk->pm.lock);
 			mptcp_subflow_shutdown(sk, ssk, how);
 
@@ -802,7 +808,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		}
 		if (rm_type == MPTCP_MIB_RMSUBFLOW)
-			__set_bit(rm_list->ids[i], msk->pm.id_avail_bitmap);
+			__set_bit(rm_id ? rm_id : msk->mpc_endpoint_id, msk->pm.id_avail_bitmap);
 		if (!removed)
 			continue;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a92b6276a03c..ec91776f9b18 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -282,6 +282,7 @@ struct mptcp_sock {
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
 	bool		csum_enabled;
 	bool		allow_infinite_fallback;
+	u8		mpc_endpoint_id;
 	u8		recvmsg_inq:1,
 			cork:1,
 			nodelay:1;
-- 
2.35.3

