Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77966EEB2
	for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 14:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722004131; cv=none; b=tn4+bu1yApM8ajv95PFBJIzjaG4rcDStKz3Av1qoSTJRBskY/Ip+m/tZuI/6GS1x7MD6GvloVF17ePqHW3llkza3mBAvXfkFVLnGHF780AnSps9Y195F3B2B0WfUn26O9Xp/MZhR39PPxgS4ethvvhBLsgKNMGsHMIGFc4oWDa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722004131; c=relaxed/simple;
	bh=7uKCkouFh7aZOTnXfxSEcsOj8l2v5R6KHktgqkOb79w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ro4X2qq2Vb6suy97QyE06cfz2uErXWV74WKe2XaYyxawSYOib+fSTsuVWKHfGay9aMldlX0uPtXsTb+a7LOVTbfws29HYRWEk5/pP8hn5LgF0Fbk8UHSQcQUtI3PKeqRzgx9U2oBNXYCC/vUta3ssXapy4/f3MEsaNMWrybm4Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaCVeBjr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaCVeBjr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6E2C32782;
	Fri, 26 Jul 2024 14:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722004131;
	bh=7uKCkouFh7aZOTnXfxSEcsOj8l2v5R6KHktgqkOb79w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NaCVeBjrvW10xP4bhkA91DnyD5o0QyxOEIIsTaMsT3Ls7G8wGimwlKakKYG5aQ5Wl
	 hsKwpduFIBxP++9dlfREdnrM6t8g6Ja/7veQnmUHELUHvxVS1Ow+jbsGYjkeC+bmDH
	 NCyOd6pWFjcM5WjiqPEPAIvb7OjBDmMlxiDzXvf7A8xcTMMP4yMvSZrFQ1Z1YavMxV
	 qU/M54/CcP9+2K/xOmXthLQzmvS2YDVkmRWe2ISNVDAnHRS2QsS/SiggA6nnqX41Bm
	 7MAxckeYhjyx0KyE5zaqbl3VhnHJll2JpVFvTb1yZNtYBdsKD1r8GoCEAZ4BNG4D9R
	 7xaxpOqU9GIIQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 26 Jul 2024 16:28:30 +0200
Subject: [PATCH mptcp-net v5 04/13] mptcp: pm: only mark 'subflow' endp as
 available
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-mptcp-pm-avail-v5-4-fb1117ddeef6@kernel.org>
References: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
In-Reply-To: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4021; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=7uKCkouFh7aZOTnXfxSEcsOj8l2v5R6KHktgqkOb79w=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmo7KcvA1aZ319h87q6iq9X0SLztNh8rBsJUGk+
 G9G86vKpKSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqOynAAKCRD2t4JPQmmg
 c5/0D/9rb9zHX8//xh4e3Oc2TsQd+GROsJKvFojaF7gNCNMTK1N47ginEbhPI4+B7cDtjfZj1Sh
 wQoc9kA6Az038a6tvEstZmHaxkIDyfm0M9S/IgiRfHkGJosbSwnbttRcXuOyR1Iq5CRiHjbUBSA
 evQjLteYnBpFUPpeZuhyjkfAR7mJ5GzxAgQfp9ZcFNAdpV//G04LaZDCkYfo65+wShOcDB2RjA8
 sBRXOKB8sfJfaSmbVgugFyISmKyztj0WrK91Y/2Ge/dQlJinzG4uS6xP7uSookQe/kSelZ1Ot4t
 um2sqAobiPc8d8I8WFS4l0xB2iFSPO9nnpWWj+OdreL/dclVHBiBm3wN4TeQ4cKAZC7nynMSVDx
 RouzeBFMwjNMGV3ljc1LBje7OXdrq3v7GIMchUlCJO9W02H34yJ+xxjBQ1KLpGWypqHDERIFfrg
 vQ4kvMJHI85ouJBQis4y93A9D7HjTYvlpvJwyohZNVaouIpzGMfgO9XVLlU1iZ0bnvon2MMMFG5
 BeeQduB5oWZeUAMdlWHrDmIIJ3HAHO0WKnOvdSXXGZFFlkLR1MJ/iqHMV64V0fcPhNzZO03Gkm6
 n7h5yeyTD4LB6IUYHTybF/6NPZgirSIpF5P8MtgzZ41bVRuF//PZG84X3ZHoE9wYvz8dm+fKOYg
 CH7Wadu8t8RRWJg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Adding the following warning ...

  WARN_ON_ONCE(msk->pm.local_addr_used == 0)

... before decrementing the local_addr_used counter helped to find a bug
when running the "remove single address" subtest from the mptcp_join.sh
selftests.

Removing a 'signal' endpoint will trigger the removal of all subflows
linked to this endpoint via mptcp_pm_nl_rm_addr_or_subflow() with
rm_type == MPTCP_MIB_RMSUBFLOW. This will decrement the local_addr_used
counter, which is wrong in this case because this counter is linked to
'subflow' endpoints, and here it is a 'signal' endpoint that is being
removed.

Now, the counter is decremented, only if the ID is being used outside
of mptcp_pm_nl_rm_addr_or_subflow(), only for 'subflow' endpoints, and
if the ID is not 0 -- local_addr_used is not taking into account these
ones. This marking of the ID as being available, and the decrement is
done no matter if a subflow using this ID is currently available,
because the subflow could have been closed before.

Fixes: 06faa2271034 ("mptcp: remove multi addresses and subflows in PM")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 8a28fdaf3bb6..3ea417b52ff4 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -833,10 +833,10 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			if (rm_type == MPTCP_MIB_RMSUBFLOW)
 				__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		}
-		if (rm_type == MPTCP_MIB_RMSUBFLOW)
-			__set_bit(rm_id ? rm_id : msk->mpc_endpoint_id, msk->pm.id_avail_bitmap);
-		else if (rm_type == MPTCP_MIB_RMADDR)
+
+		if (rm_type == MPTCP_MIB_RMADDR)
 			__MPTCP_INC_STATS(sock_net(sk), rm_type);
+
 		if (!removed)
 			continue;
 
@@ -846,8 +846,6 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 		if (rm_type == MPTCP_MIB_RMADDR) {
 			msk->pm.add_addr_accepted--;
 			WRITE_ONCE(msk->pm.accept_addr, true);
-		} else if (rm_type == MPTCP_MIB_RMSUBFLOW) {
-			msk->pm.local_addr_used--;
 		}
 	}
 }
@@ -1443,6 +1441,14 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 	return ret;
 }
 
+static void __mark_subflow_endp_available(struct mptcp_sock *msk, u8 id)
+{
+	/* If it was marked as used, and not ID 0, decrement local_addr_used */
+	if (!__test_and_set_bit(id ? : msk->mpc_endpoint_id, msk->pm.id_avail_bitmap) &&
+	    id && !WARN_ON_ONCE(msk->pm.local_addr_used == 0))
+		msk->pm.local_addr_used--;
+}
+
 static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 						   const struct mptcp_pm_addr_entry *entry)
 {
@@ -1476,11 +1482,11 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 			spin_lock_bh(&msk->pm.lock);
 			mptcp_pm_nl_rm_subflow_received(msk, &list);
 			spin_unlock_bh(&msk->pm.lock);
-		} else if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
-			/* If the subflow has been used, but now closed */
+		}
+
+		if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
 			spin_lock_bh(&msk->pm.lock);
-			if (!__test_and_set_bit(entry->addr.id, msk->pm.id_avail_bitmap))
-				msk->pm.local_addr_used--;
+			__mark_subflow_endp_available(msk, entry->addr.id);
 			spin_unlock_bh(&msk->pm.lock);
 		}
 
@@ -1518,6 +1524,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 		spin_lock_bh(&msk->pm.lock);
 		mptcp_pm_remove_addr(msk, &list);
 		mptcp_pm_nl_rm_subflow_received(msk, &list);
+		__mark_subflow_endp_available(msk, 0);
 		spin_unlock_bh(&msk->pm.lock);
 		release_sock(sk);
 
@@ -1919,6 +1926,7 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
 
 	spin_lock_bh(&msk->pm.lock);
 	mptcp_pm_nl_rm_subflow_received(msk, &list);
+	__mark_subflow_endp_available(msk, addr->id);
 	mptcp_pm_create_subflow_or_signal_addr(msk);
 	spin_unlock_bh(&msk->pm.lock);
 }

-- 
2.45.2

