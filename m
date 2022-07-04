Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D79923B6
	for <mptcp@lists.linux.dev>; Mon,  4 Jul 2022 09:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656926094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yx8gscXQLt+O9V4Yg2p11V0oOyQxujGlWPURGa3OHDI=;
	b=LKmVS3oPV/CgW/6XLNY1cf5fvKBxqrlXkVqi5W9csMvkV0CeDa5YGp4dJ7eY61e3sgXkRG
	Iv1eM+4x3uDsK27Ogg7r4dDF4N9GaR3FeSHhsq6p+yiOWvDMjXC8aUBPDJsa7bMJhU1unC
	recKokXGuCw3dvmTKoSqmf6YdolmKQ0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-o6eO7OK-Mo2Bd71XCTl5kw-1; Mon, 04 Jul 2022 05:14:53 -0400
X-MC-Unique: o6eO7OK-Mo2Bd71XCTl5kw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01A881C05EB7
	for <mptcp@lists.linux.dev>; Mon,  4 Jul 2022 09:14:53 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.94])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 882742166B26
	for <mptcp@lists.linux.dev>; Mon,  4 Jul 2022 09:14:52 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 4/5] mptcp: more accurate MPC endpoint tracking
Date: Mon,  4 Jul 2022 11:14:35 +0200
Message-Id: <0ac098842905cdf73e2066296eba0a9f4168c25e.1656925387.git.pabeni@redhat.com>
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
index d846ceeceb9a..60aada85b476 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -549,6 +549,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		entry = __lookup_addr(pernet, &mpc_addr, false);
 		if (entry) {
 			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
+			msk->mpc_endpoint_id = entry->addr.id;
 			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
 		}
 		rcu_read_unlock();
@@ -764,6 +765,11 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
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
@@ -787,6 +793,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 		return;
 
 	for (i = 0; i < rm_list->nr; i++) {
+		u8 rm_id = rm_list->ids[i];
 		bool removed = false;
 
 		list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
@@ -794,15 +801,14 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
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
 
@@ -814,7 +820,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		}
 		if (rm_type == MPTCP_MIB_RMSUBFLOW)
-			__set_bit(rm_list->ids[i], msk->pm.id_avail_bitmap);
+			__set_bit(rm_id ? rm_id : msk->mpc_endpoint_id, msk->pm.id_avail_bitmap);
 		if (!removed)
 			continue;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bc4dc81a4c3c..b9333e7f380a 100644
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

