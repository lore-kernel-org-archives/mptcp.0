Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6441171647
	for <mptcp@lists.linux.dev>; Mon, 22 Jul 2024 19:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676970; cv=none; b=YVr09f2QyWX3aKVP9MuZpYLmQIhCp1GsFw5Gs+KLEKpL6JmQAs78n+WQXUI33N55Btj8QlwV22OAv3uCJQjbU6VbdbY6mFnWMpd8uzGCF1QZ/CS84Su0cdJWAl90rCw3Nf+dP+pvCUVNlmg656T47AqCrJeaSDd5Hqov8C9m6gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676970; c=relaxed/simple;
	bh=0xFMDS4qYHKOiwYm0etxgWoqfwa1KQQH9JL0qVq+ToY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X9ffaFHgqZZefu4EDBdvo6KPB7EaQtzl1u60+/9sSJSIuV2aHmGA5LX62qnJsAo+eINqFDnz88Rzz3BpUX6sk/XFYT9olofCQGrotLxIbdc8KwqapUShIIsznjy/Bkgui8VtKwxvZKCgUMBBV6/pUnm82VQNBWl6kCy86mbR48Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKcozcTw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKcozcTw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A020C116B1;
	Mon, 22 Jul 2024 19:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721676969;
	bh=0xFMDS4qYHKOiwYm0etxgWoqfwa1KQQH9JL0qVq+ToY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YKcozcTwKoTesYcg1uNwJUDkf0pGgzljRWIRjdQ+UPz91HgJv2ccQEyp6mrfl8tSM
	 5rtVfNZp7vv334cQwxJhg9Q2ViJGKdqMsw58uTzW8kvxrsbHJRHldxvM2MsYuK6kas
	 8GIhga2i3VJLU+Naos1rsxSAAMMDZYj623JINxPT1RhIy6+xDKgDBr2136bVUeBCPB
	 1b2ecnfUdOJWMqhj57xUAB9BOCTNSapOBbEFgSES8RRcSQZ3gCeELJxotagvJ+85GD
	 5DFIOTW+L9/5KRNSyDQxUkq3DhShZPAOoc6rnyyXJMipY+3HWeRd35NbtExM3MUBG3
	 9u2Jxzuaaqzcg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 22 Jul 2024 21:35:53 +0200
Subject: [PATCH mptcp-net v4 15/23] mptcp: pm: only mark 'subflow' endp as
 available
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-mptcp-pm-avail-v4-15-15bfd73de384@kernel.org>
References: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
In-Reply-To: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4021; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=0xFMDS4qYHKOiwYm0etxgWoqfwa1KQQH9JL0qVq+ToY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmnrSWi1kLQALLaQce1nxfnEuM1Fp6NX8zEAVmS
 928faM/uPeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZp60lgAKCRD2t4JPQmmg
 c9KHEACPd0uxa+o5WA7B8O/Hr3IFfFDO4cFpoXcXYDtxQoMsDZfV9d80pp+r5pUjdA2iSOxgaTG
 vodoZzzkTGYg9Rlo4nFDs3b1JaXLAAe2pKpAAQJXKU8ST5bSrVBeLmSNIvbQR7cXLFe7JudQkW3
 btppQ3ZWf62VD5UZAS5BjML/u3ukn1dudDjWPs179LGc3AXx8tykaUvSTEuDYqxQmgvNJzRkP2/
 S19I+zC/sJWE4u9R/48j2knugSFsHjOPtQi2vd46sko+Z9T4DiD7HFY6+Zs26tdS2HBK7YcmPVu
 po7maJjPjIbhgltvBASe6QeDJ2PCZlBkNocIZU2LzoS144kHMY9yaaVqfrz+MaoLpGFEViqq4c1
 I6b1RXgtOn+cdwLnL715Cpnn2ElNU/IC+tbQZtYN150xfZjsEO5DYpJAip4uukDIPsLJjbKTzFU
 R+EM+gejWHaB+BxqS72Lk+IAn9oWij8oGsT7B68pxgcFY2vUJywcea8MxJJaGiuhd+C8OC+AcpG
 fC0Y6xU/19yFmrUW/mz5QPCdfUeDZcrdyChkvOpPzGqHRrMzSoIA7ZmmzNCwr95PFS4hTb876ck
 VmS5clyywXnXcddYcxgClwU9LcgviSXr3iV7n4gGtaP96VfDvOtnUFZfDQwdbMTMHUz435jpkjq
 EchE2oE4r23accA==
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
index a653ecc9e9ad..ea942c9f998f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -834,10 +834,10 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
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
 
@@ -847,8 +847,6 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 		if (rm_type == MPTCP_MIB_RMADDR) {
 			msk->pm.add_addr_accepted--;
 			WRITE_ONCE(msk->pm.accept_addr, true);
-		} else if (rm_type == MPTCP_MIB_RMSUBFLOW) {
-			msk->pm.local_addr_used--;
 		}
 	}
 }
@@ -1426,6 +1424,14 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
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
@@ -1459,11 +1465,11 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
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
 
@@ -1501,6 +1507,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 		spin_lock_bh(&msk->pm.lock);
 		mptcp_pm_remove_addr(msk, &list);
 		mptcp_pm_nl_rm_subflow_received(msk, &list);
+		__mark_subflow_endp_available(msk, 0);
 		spin_unlock_bh(&msk->pm.lock);
 		release_sock(sk);
 
@@ -1902,6 +1909,7 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
 
 	spin_lock_bh(&msk->pm.lock);
 	mptcp_pm_nl_rm_subflow_received(msk, &list);
+	__mark_subflow_endp_available(msk, addr->id);
 	mptcp_pm_create_subflow_or_signal_addr(msk);
 	spin_unlock_bh(&msk->pm.lock);
 }

-- 
2.45.2

