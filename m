Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D8D1AE029
	for <mptcp@lists.linux.dev>; Fri,  2 Aug 2024 18:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722622673; cv=none; b=p2v794EOi9kaQwl2MeN9gHoXyonCgrp2UXfJKVkKhJzADRvJjsrXWDrI6Esc9pXlZ1Iy54Vf2MFJifUspmxz1H9GSBXq3pDmyLw9ZV/U6CjQSgM+ajIBjAjP5kwDoXyAKu3bzD3PoaKr2tSs+hzRmNbgOPlXFwl8VTV3UaI0FJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722622673; c=relaxed/simple;
	bh=UbXCCFkTuOpDNHIkLtS260QO4lsFcdAGt77nB6VMSgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CCr8q03sPy4dVe7XSzjXE6P3huJRBtlbDK9j8hJLP+eKIoukBD57rr/gfaAjrdXAvKTHWGfutv3CGaSs7kUrRSkKYXX7KlOw5rkuclk08OgVtFBE7IM4egdmizio3OZWLI8LQ+JYT34BbZ67eltletxMMVzYSkOXAez0zFkKoko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJYBOKPu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJYBOKPu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4801CC4AF0C;
	Fri,  2 Aug 2024 18:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722622673;
	bh=UbXCCFkTuOpDNHIkLtS260QO4lsFcdAGt77nB6VMSgQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HJYBOKPugSIbtNV79t1MsLKoSHv0nZ2WN62McfoXI0LXi1v//zrWwwns/YVk+rBwg
	 /mPHl+k8J9cpjwEkBPN1d4i+vyvvhHX/CiE4weqzVEAQSXFukUmWQSZnIID+uRGowf
	 QBNCTrhJVH6lt9m9yAQV9EKu2/dtmF9SSHjjzBof+znoh7+SWtxGWJ6rEHjLwPEuf6
	 Y76/ZM6K58Arg4BuMeN70V2UAGH4+1pH6MaCdF3ZmtaLhYJi61acqdOCB3hAqPyuKb
	 ngqrvPv/bLXGavVlaWwbNkf4fPLSlg8epxcNTpwlkzA2nhkDyqnUO8CS3T2/VGpIFw
	 YYDvbUBTkZdDQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 02 Aug 2024 20:17:40 +0200
Subject: [PATCH mptcp-net v6 03/11] mptcp: pm: fix RM_ADDR ID for the
 initial subflow
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-mptcp-pm-avail-v6-3-964ba9ce279f@kernel.org>
References: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org>
In-Reply-To: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4941; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=UbXCCFkTuOpDNHIkLtS260QO4lsFcdAGt77nB6VMSgQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmrSLKgJhQtbwDk+mSOiC792WDSzKcYVlPtA86S
 V6akb4zcrOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZq0iygAKCRD2t4JPQmmg
 c2o0D/9peyyp76CuG2MmU96foadhAPqK5aSZPxzUvsDcan5XlazjsnRGCGxa1D8HWXmYNrBFTWs
 tbQ6DmdJW+VkIPJBROrW3NTliss2lMAWsqdVC8WAgGmOcLavv8cAHvLXz0FeUDbDJQE5IISQhNn
 /Pw6ydzLjVfJXIEN2c//otA3rX5uSBGoXtG4uWBfyrJ1WWMujy5TksCGdptNdmHYPJvzUemDpKa
 KX9vpFKlWbyE7xVjkg2atWr2FEoRxJDeYUBfphrkeQMAJZ3HRpHr6MbOk1WMNYQ4JiNJ7p71yXx
 wy02DKYyQC3dKSOe+MFMlLezJ+bQthjLu+ssOrYUEjajU+tAX6vVH6IBynxgwScIE2kbfuupiQw
 0B2lTIOXgasvpLQJNtldRFdEpqMVinoGl8G1XIJYvMUMFnf+98LUM//Z4yia0aUyyFKd7mEqXEU
 1j54VkpuDmnG438FJsxig1yTA73MUSBMqBbVjtbgH7jpLAF7WrT7LJFbR7sEtvlkUxhe5Ip5B5r
 3jX/xsaWmSITXAUq3SY6y247PqUxfVoSVZFRrrzLa2boUb+l4538a1EFMmR04DpMxi7GSmEeIIF
 HtUxO0sBGxK4IHQxigElrN/pSC1Zgess1ejhCFiLF5EWo8Du6es4qOlWRBCVHZZ2mhnPxppInDf
 xE2qCw17JkN14JQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The initial subflow has a special local ID: 0. When an endpoint is being
deleted, it is then important to check if its address is not linked to
the initial subflow to send the right ID.

If there was an endpoint linked to the initial subflow, msk's
mpc_endpoint_id field will be set. We can then use this info when an
endpoint is being removed to see if it is linked to the initial subflow.

So now, the correct IDs are passed to mptcp_pm_nl_rm_addr_or_subflow(),
it is no longer needed to use mptcp_local_id_match().

Fixes: 3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 605cfd7bc004..4000de54c99c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -803,11 +803,6 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 	return -EINVAL;
 }
 
-static bool mptcp_local_id_match(const struct mptcp_sock *msk, u8 local_id, u8 id)
-{
-	return local_id == id || (!local_id && msk->mpc_endpoint_id == id);
-}
-
 static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 					   const struct mptcp_rm_list *rm_list,
 					   enum linux_mptcp_mib_field rm_type)
@@ -842,7 +837,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 
 			if (rm_type == MPTCP_MIB_RMADDR && remote_id != rm_id)
 				continue;
-			if (rm_type == MPTCP_MIB_RMSUBFLOW && !mptcp_local_id_match(msk, id, rm_id))
+			if (rm_type == MPTCP_MIB_RMSUBFLOW && id != rm_id)
 				continue;
 
 			pr_debug(" -> %s rm_list_ids[%d]=%u local_id=%u remote_id=%u mpc_id=%u",
@@ -1429,6 +1424,12 @@ static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 	return false;
 }
 
+static u8 mptcp_endp_get_local_id(struct mptcp_sock *msk,
+				  const struct mptcp_addr_info *addr)
+{
+	return msk->mpc_endpoint_id == addr->id ? 0 : addr->id;
+}
+
 static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 				      const struct mptcp_addr_info *addr,
 				      bool force)
@@ -1436,7 +1437,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 	struct mptcp_rm_list list = { .nr = 0 };
 	bool ret;
 
-	list.ids[list.nr++] = addr->id;
+	list.ids[list.nr++] = mptcp_endp_get_local_id(msk, addr);
 
 	ret = remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
@@ -1461,14 +1462,12 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 						   const struct mptcp_pm_addr_entry *entry)
 {
 	const struct mptcp_addr_info *addr = &entry->addr;
-	struct mptcp_rm_list list = { .nr = 0 };
+	struct mptcp_rm_list list = { .nr = 1 };
 	long s_slot = 0, s_num = 0;
 	struct mptcp_sock *msk;
 
 	pr_debug("remove_id=%d", addr->id);
 
-	list.ids[list.nr++] = addr->id;
-
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
 		bool remove_subflow;
@@ -1487,6 +1486,8 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
 
 		if (remove_subflow) {
+			list.ids[0] = mptcp_endp_get_local_id(msk, addr);
+
 			spin_lock_bh(&msk->pm.lock);
 			mptcp_pm_nl_rm_subflow_received(msk, &list);
 			spin_unlock_bh(&msk->pm.lock);
@@ -1592,6 +1593,7 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+/* Called from the userspace PM only */
 void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
 {
 	struct mptcp_rm_list alist = { .nr = 0 };
@@ -1620,6 +1622,7 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
 	}
 }
 
+/* Called from the in-kernel PM only */
 static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
 					      struct list_head *rm_list)
 {
@@ -1629,11 +1632,11 @@ static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
 	list_for_each_entry(entry, rm_list, list) {
 		if (slist.nr < MPTCP_RM_IDS_MAX &&
 		    lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
-			slist.ids[slist.nr++] = entry->addr.id;
+			slist.ids[slist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
 
 		if (alist.nr < MPTCP_RM_IDS_MAX &&
 		    remove_anno_list_by_saddr(msk, &entry->addr))
-			alist.ids[alist.nr++] = entry->addr.id;
+			alist.ids[alist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
 	}
 
 	spin_lock_bh(&msk->pm.lock);
@@ -1930,7 +1933,7 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
 {
 	struct mptcp_rm_list list = { .nr = 0 };
 
-	list.ids[list.nr++] = addr->id;
+	list.ids[list.nr++] = mptcp_endp_get_local_id(msk, addr);
 
 	spin_lock_bh(&msk->pm.lock);
 	mptcp_pm_nl_rm_subflow_received(msk, &list);

-- 
2.45.2

