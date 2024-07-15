Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6733618629E
	for <mptcp@lists.linux.dev>; Mon, 15 Jul 2024 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721038217; cv=none; b=sgI8+DSJrV3Ahb3rNpuTQ2BQt62VCNGTxXurR0k/Ss0YZ0DLCAjZqzCW0s2HSGSo2k9sBOEkWtKKkRrG9aIyhq76XjnboILmZArHGJ3Q8dZt6nKokzDI/uB2h85+IYVJDOne6Uu9NSHItTc2XhI5iJrVK3VqJGtp3N01dkLvTgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721038217; c=relaxed/simple;
	bh=7eBKreaPM9QQMsiz0VgOKGNDPKZOdgjkPhlALqaRZ0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SfkdNHS873siN2mRJyxFiqaccZwD8znjyo0gS3S7Tbn3HjH6UmCZAVjJhS3ddyJTFtflsb77jEvYB+BPalT8gDnh5CYlXrsA9WJsLu3m3NLmQyMNeJIsPOrzk+BkheiyK/D8jt2Pr2VJO3DSRMNu6vsGjQbStQR6Fky0tMhhhOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiM3+j6D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiM3+j6D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80613C4AF0A;
	Mon, 15 Jul 2024 10:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721038217;
	bh=7eBKreaPM9QQMsiz0VgOKGNDPKZOdgjkPhlALqaRZ0Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HiM3+j6D8cSeJMptbClBZVO3EAm0jJyD0+hRlH7w4i+dyrdaUrAeYHZ+z0zcKG0SS
	 /+Qbwrf4a8EKG1N1seLoX3VkAWGUeFeSaO8PXfC35BNDnAEgQiUh9t5acX1DFppsYa
	 B3cUf4fB0rPUY7nNFsHQ+nFlSvybGCiGa44bdOoKG+myU/oGjFrKTkpiLDTpiZvTxl
	 6naNtAvD5/YKXiWZRS1cpJZ+KO0AStOiOeH9KgWaskYU/7tJwAx0vAaWLPzSMZo5sw
	 8vQwN4BPY1fVqCt/fB0EtuKp+QVqsPNX0mNzwaTtJVGfljvPfSD6YbUwP7JsE1u0Mz
	 rcuYLtvtulcpQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 15 Jul 2024 12:09:50 +0200
Subject: [PATCH mptcp-net v2 12/17] mptcp: pm: re-using ID of unused
 flushed subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-mptcp-pm-avail-v2-12-fc5153bd1f6e@kernel.org>
References: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
In-Reply-To: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2788; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=7eBKreaPM9QQMsiz0VgOKGNDPKZOdgjkPhlALqaRZ0Q=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmlPV3gIAp7R02nGFXW0tSB9gcMJLVoZBrs/ygw
 gvNAXcahP6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpT1dwAKCRD2t4JPQmmg
 c1eGEACj5w/mJ6yEH1ROVAuJ+sbbRaZgs+2HkOoj9jpyLEpT24r7I4i0iQrnNWpO8K2+CRtt1of
 Np7SdKm0K+kUdNkkyyWiv7hxl/Mu8XooxFD2R9Ace0wZZAkL8AVytxgZQMSuShbFiVUa1tQnd3/
 bf3ga/O+o4tIU9nb4GIYG33GNudzjAc54rggPx7moepinK0+eJoWHpWOjO2x8iN8BbyPD+RMIry
 Y2wfaJZCMUW0jBOMaeFtx/Ex/2ImK6ArnCGdcgAlhXNlsEcqdhZeszJmvBzmIOycHO+hq+irY1g
 64RzMBpkAYjck7tXMJWR3rq9/ShdKGppLS7BGBSNiBb0tXLNtCmcAgv8Nkboc/d67sbDTZF1wK1
 VEPSqKF+4eDnJ9L86CVpu67rsPnCOHXfnsjcy/OvbsheWgtg47/TnTNz+B83Zvuva4zLexpLmss
 K4xTbgcEWBOlFqyDKcilRFLESZEah9M74FWajBumlW4qqOjQBGEaBAwsCJoT5otM8ymSN8sy6n8
 HZEhT6es0DMnOJc4xMd+S0vMu/7eobSrsS4s1Oh/ofoSjel692bzWLVa56EVKw6kzY58T1JSryp
 QMS1RyjC55HJlXIy7AhaEGkPRlK/OIgT3xG3JPWqXs/DicjiudALrDoRBY/Lhi/O8PopzYxWCFc
 W7uXDFzv3egXEQg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

If no subflows are attached to the 'subflow' endpoints that are being
flushed, the corresponding addr IDs will not be marked as available
again.

Mark all ID as being available when flushing all the 'subflow'
endpoints, and reset local_addr_used counter to cover these cases.

While at it, renamed the helpers linked to the flushing operations to
make it clear that the intention is to flush all created subflows, and
remove all announced addresses, not just a "random" selection.

Fixes: 06faa2271034 ("mptcp: remove multi addresses and subflows in PM")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 36a1bda25d2e..44092246259c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1585,8 +1585,8 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
 	}
 }
 
-static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
-					       struct list_head *rm_list)
+static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
+					      struct list_head *rm_list)
 {
 	struct mptcp_rm_list alist = { .nr = 0 }, slist = { .nr = 0 };
 	struct mptcp_pm_addr_entry *entry;
@@ -1607,12 +1607,19 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 		mptcp_pm_remove_addr(msk, &alist);
 		spin_unlock_bh(&msk->pm.lock);
 	}
+
 	if (slist.nr)
 		mptcp_pm_remove_subflow(msk, &slist);
+
+	/* Reset counters: maybe some subflows have been removed before */
+	spin_lock_bh(&msk->pm.lock);
+	bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+	msk->pm.local_addr_used = 0;
+	spin_unlock_bh(&msk->pm.lock);
 }
 
-static void mptcp_nl_remove_addrs_list(struct net *net,
-				       struct list_head *rm_list)
+static void mptcp_nl_flush_addrs_list(struct net *net,
+				      struct list_head *rm_list)
 {
 	long s_slot = 0, s_num = 0;
 	struct mptcp_sock *msk;
@@ -1625,7 +1632,7 @@ static void mptcp_nl_remove_addrs_list(struct net *net,
 
 		if (!mptcp_pm_is_userspace(msk)) {
 			lock_sock(sk);
-			mptcp_pm_remove_addrs_and_subflows(msk, rm_list);
+			mptcp_pm_flush_addrs_and_subflows(msk, rm_list);
 			release_sock(sk);
 		}
 
@@ -1666,7 +1673,7 @@ int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 	pernet->next_id = 1;
 	bitmap_zero(pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	spin_unlock_bh(&pernet->lock);
-	mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
+	mptcp_nl_flush_addrs_list(sock_net(skb->sk), &free_list);
 	synchronize_rcu();
 	__flush_addrs(&free_list);
 	return 0;

-- 
2.45.2

