Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7582218629E
	for <mptcp@lists.linux.dev>; Mon, 15 Jul 2024 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721038221; cv=none; b=fOSZ8kMuQK2KEHpwp8GTUlpB/1+eFMhvr2Ckvg4BI6ZFBG91iiH5CFWO+h6w/+qHoN0KPjZtW5pCPqJD4Ecx1u+j4uGZL7Mjy3tP+Do7jj/jpdWDueqGDRj/+Hia9mA2Gv7RF8NwH28ZTkw3z2h2nvwOIAdZk4ymqcvFI9fw1uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721038221; c=relaxed/simple;
	bh=blOWQA/F005Tz1Q/hizFMX7CIZmnvE8H1ikmy20WQec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hc9ifV09k6yBTwVUrptYOGKJyGI/lSxshwqNL/mDR/NAtSxCNxw9QcUQ5jbezisoSaB2CShtC21ma4B2BtSRJjqbPn/G1v07JtQmzxEmeTO+CiXkk9qR0iPEqH7EaIqFSW9o4f22NpOC5OiNFsvnEWtt52TbGBYdgW2pQwm9UUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLcVssAE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLcVssAE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B372C32782;
	Mon, 15 Jul 2024 10:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721038221;
	bh=blOWQA/F005Tz1Q/hizFMX7CIZmnvE8H1ikmy20WQec=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GLcVssAEzhWEJGrpyirb8LKhrPRp9NBfZIzxdDPqkmU7yRfoGV3v4ckmHMYk59NZS
	 oqx/UV9mLMd8GzhWlO8M8AY6GvElKCVGOM4NZBN9jx/uuOQL9fZNF6kGSIjDKY6ycN
	 Exuv0CF48XJfm/ZXn5Lm4feH6hJlJ1k7pf/30FgwzQPTRQwyKaMIGWX8ZpdL2vb4xy
	 wo9WxB3YqsD4T4EQnRG1FdmPyl8I7TC5jPfSFogMD+q8Dlw1yBQHiuas4PeHn6uLhW
	 OqQfcwqV/q9Yvder/aEfEClURKsn2F0Mj9Hs6gOsOFKlcQyqXMN8zQluV9c8b9//d4
	 4ZLZsTvUANcwA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 15 Jul 2024 12:09:53 +0200
Subject: [PATCH mptcp-net v2 15/17] mptcp: pm: only mark 'subflow' endp as
 available
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-mptcp-pm-avail-v2-15-fc5153bd1f6e@kernel.org>
References: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
In-Reply-To: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4021; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=blOWQA/F005Tz1Q/hizFMX7CIZmnvE8H1ikmy20WQec=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmlPV3CzvPCDwQe6TzSWZDvy45JK9zauZrB0Pg4
 pPPF9WMPU2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpT1dwAKCRD2t4JPQmmg
 c0bvD/9zo6bHGVAhVUAhWwcUZBpCO/JsY8+41vi67Ye0tB46O8XMU8dJA6zXIaaz/5brogN4mI5
 yzFvv0Eek7vwL6c0nLIpRA5ROrk11yokHq96e1UG31ZKdGVdL71cch44yySO3/WsbQvzVK22ZuV
 kvOZvuQf3W1ChGKWbCUCbpWK1vrCPMS31pP2q2rilglLc2zu4vVirNIJQ3xgrQXaKojk2va9rKP
 +3dftupF17LpdgPpgz/L0gb7Yis75R3kTto4WtcbMsZwx0Sg7TkNePvZ2xwN0+iAknjWidcpsSH
 Er/uqWqR5HGk5O4CXntvTcfUcRztDpeViTN/df3x0sv1mVVcy/g2pYS8RDsDY3kNHkaa6/sUmsf
 SHQRPmj7Qt1TXy69uLLm3rqsILE0csSPSodANyAJI7XnH7QN+bT6UPoogJdNo8uWpPflZR3DPS/
 Dcgm7kczSYAfz5WS4VFMSarDPWg7Vod/CCty9S/mwGVEFR4DIXylOajpho8HyfFZd3gW5mv9wHb
 KW3Hvb0IrqStoz7RLXzI3E2FZjFYzH52trKoJNSlbVXJlKGG9/lBXqm3hjffMfvfhuJXkwYuIIF
 nx3zRfOkdb/KFIYkcJ0UQVTtg4OS5n3+0Lz2eCdCwSW03x3LoDju3OZ7R5w0MhZMsDXkl4ZTalK
 Nnw6M5EcvAn6Ykw==
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
index 96336a87973f..ed24a7045619 100644
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
 
@@ -1909,6 +1916,7 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
 
 	spin_lock_bh(&msk->pm.lock);
 	mptcp_pm_nl_rm_subflow_received(msk, &list);
+	__mark_subflow_endp_available(msk, addr->id);
 	mptcp_pm_create_subflow_or_signal_addr(msk);
 	spin_unlock_bh(&msk->pm.lock);
 }

-- 
2.45.2

