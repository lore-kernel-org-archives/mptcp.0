Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1AB23C8
	for <mptcp@lists.linux.dev>; Mon,  4 Jul 2022 09:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656926094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TjR7Ms2pLLD69b5s2wUt45RzlgR9Ju8nK34ei07XjSY=;
	b=cMtDNhwkm/HjiuV/Uex7RaCJD3aawY8n3bzaP2989uRnSUzCC+alrnYW7Bwirwj4cX7Avz
	mSJfewe62dYbiSVLLuIS3qcEatnyO0PMxihQQFr57sOT0f51hOtYAmuIPyobSCx5Rt/Vxg
	PHRksKMQQYerpw39zTExYNL4pciX574=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-TbA90xKxPtm2-SuAv_9gbQ-1; Mon, 04 Jul 2022 05:14:52 -0400
X-MC-Unique: TbA90xKxPtm2-SuAv_9gbQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43FC43C01D99
	for <mptcp@lists.linux.dev>; Mon,  4 Jul 2022 09:14:52 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.94])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CB0D82166B26
	for <mptcp@lists.linux.dev>; Mon,  4 Jul 2022 09:14:51 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 3/5] mptcp: allow the in kernel PM to set MPC subflow priority
Date: Mon,  4 Jul 2022 11:14:34 +0200
Message-Id: <414465fb0c27e24f5616bc7660e018a6474ba672.1656925387.git.pabeni@redhat.com>
In-Reply-To: <cover.1656925387.git.pabeni@redhat.com>
References: <cover.1656925387.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Any local endpoints configured on the address matching the
MPC subflow are currently ignored.

Specifically, setting a backup flag on them has no effect
on the first subflow, as the MPC handshake can't carry such
info.

This change refactors the MPC endpoint id accounting to
additionally fetch the priority info from the relevant endpoint
and eventually trigger the MP_PRIO handshake as needed.

As a result, the MPC subflow now switches to backup priority
after that the MPTCP socket is fully established, according
to the local endpoint configuration.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm_netlink.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c0a4c947347b..d846ceeceb9a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -514,30 +514,14 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info,
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
-		if ((!lookup_by_id && mptcp_addresses_equal(&entry->addr, info, true)) ||
+		if ((!lookup_by_id &&
+		     mptcp_addresses_equal(&entry->addr, info, entry->addr.port)) ||
 		    (lookup_by_id && entry->addr.id == info->id))
 			return entry;
 	}
 	return NULL;
 }
 
-static int
-lookup_id_by_addr(const struct pm_nl_pernet *pernet, const struct mptcp_addr_info *addr)
-{
-	const struct mptcp_pm_addr_entry *entry;
-	int ret = -1;
-
-	rcu_read_lock();
-	list_for_each_entry(entry, &pernet->local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, addr, entry->addr.port)) {
-			ret = entry->addr.id;
-			break;
-		}
-	}
-	rcu_read_unlock();
-	return ret;
-}
-
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
@@ -555,13 +539,22 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 	/* do lazy endpoint usage accounting for the MPC subflows */
 	if (unlikely(!(msk->pm.status & BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED))) && msk->first) {
+		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(msk->first);
+		struct mptcp_pm_addr_entry *entry;
 		struct mptcp_addr_info mpc_addr;
-		int mpc_id;
+		bool backup = false;
 
 		local_address((struct sock_common *)msk->first, &mpc_addr);
-		mpc_id = lookup_id_by_addr(pernet, &mpc_addr);
-		if (mpc_id >= 0)
-			__clear_bit(mpc_id, msk->pm.id_avail_bitmap);
+		rcu_read_lock();
+		entry = __lookup_addr(pernet, &mpc_addr, false);
+		if (entry) {
+			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
+			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+		}
+		rcu_read_unlock();
+
+		if (backup)
+			mptcp_pm_send_ack(msk, subflow, true, backup);
 
 		msk->pm.status |= BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED);
 	}
-- 
2.35.3

