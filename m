Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06234692
	for <mptcp@lists.linux.dev>; Mon, 11 Jul 2022 19:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657567001; x=1689103001;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vO0zkgBW9XgcHpCVS57kml2KFt+CKWNlRoirYSa2RXQ=;
  b=lF5kOh1A/3naVOuHhDp+JvQQJC6Id9CIk3jrb0EPOHqY5xHDxBmY719p
   5ZmmFOF+hwJfjjpOfBUJ6m+IBlPdkGeljhAJp3MNEO260Dz0kwverB2u6
   a3WiK7Wu11z5YiFNpf0aqo/DuIRnQnuyouCNhJ0gnEStNWIACTn36cB2l
   GD2pKkY2qnwvsN2WdzahnjMBW2gDGAj/GOvVdD++9gTazefwBFcIOGuUQ
   yvwhVLHyYTsw5PS0My4xfRmCNykQKzveoYi1o1mpM9IFZEaYk2sJvx7Dl
   OTRO5CsY/XQxUAg4RWKX6n1oPBIP9lONMOZdKYPDdLFhO8rmjaVEwS5zn
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="284775359"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="284775359"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 12:16:39 -0700
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="697742716"
Received: from eedeets-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.2.111])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 12:16:39 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 4/5] mptcp: more accurate MPC endpoint tracking
Date: Mon, 11 Jul 2022 12:16:32 -0700
Message-Id: <20220711191633.80826-5-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220711191633.80826-1-mathew.j.martineau@linux.intel.com>
References: <20220711191633.80826-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

Currently the id accounting for the ID 0 subflow is not correct:
at creation time we mark (correctly) as unavailable the endpoint
id corresponding the MPC subflow source address, while at subflow
removal time set as available the id 0.

With this change we track explicitly the endpoint id corresponding
to the MPC subflow so that we can mark it as available at removal time.
Additionally this allow deleting the initial subflow via the NL PM
specifying the corresponding endpoint id.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c | 21 ++++++++++++++-------
 net/mptcp/protocol.h   |  1 +
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index b767a336ad98..291b5da42fdb 100644
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
@@ -794,15 +801,15 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
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
+				 i, rm_id, subflow->local_id, subflow->remote_id,
+				 msk->mpc_endpoint_id);
 			spin_unlock_bh(&msk->pm.lock);
 			mptcp_subflow_shutdown(sk, ssk, how);
 
@@ -814,7 +821,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		}
 		if (rm_type == MPTCP_MIB_RMSUBFLOW)
-			__set_bit(rm_list->ids[i], msk->pm.id_avail_bitmap);
+			__set_bit(rm_id ? rm_id : msk->mpc_endpoint_id, msk->pm.id_avail_bitmap);
 		if (!removed)
 			continue;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e38b861263ce..5d6043c16b09 100644
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
2.37.0

