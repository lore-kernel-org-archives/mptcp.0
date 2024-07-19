Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10AB83CA1
	for <mptcp@lists.linux.dev>; Fri, 19 Jul 2024 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721391891; cv=none; b=qKBLdy80LzumNL55LXq8Q2afk0VAYt/QsjJcAXsCtcTqCV4ij9o7TzpkuLirl+TzrOeHh99hAIV6hsX6fJ17lWRO4dE0cnWoJHT+ky6Tmw1CQ9ntJwXukHkplxLE8OR1BnlTs08iS35FSS+86PWnmy9Ei16AC5AlejpaBe98FL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721391891; c=relaxed/simple;
	bh=0xFMDS4qYHKOiwYm0etxgWoqfwa1KQQH9JL0qVq+ToY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PkeU0IsLPm2T6kl9r6R9ciIDhLgePkkJeyus40IRrXCwbdTBlZ6jfrQcoGFHAq7dIU7BDhPoqHuP44J9zKq0im4KudAqs4chH/L9HN0HIDlNaVRUBXCyP6yFyUvv+4qojCGvhnzinYGVlQZv3sv4nDRP7db0MOdr3gCb5jx/NdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hK7jsMGg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hK7jsMGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6570C4AF0D;
	Fri, 19 Jul 2024 12:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721391891;
	bh=0xFMDS4qYHKOiwYm0etxgWoqfwa1KQQH9JL0qVq+ToY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hK7jsMGgvT24VnVJerpCyyfpGb7utiau2HbJGHUxjUjNgOT4f0pN0PY4NkgReApT8
	 qYvSArm6y6svIb6OIoLKQKhy+RCB+ExVVauNnMtpP8Y/VNv2LI4MaCdR/QNGu+j1Si
	 KjUuxyDgb7EYIQrAa0sQWhE5IlgVugBg6xUn1Bp8Zla286O0k4vrLcCSICjRbSq4mR
	 mPIaY62Xxsz6TMBp66SH2bsKRm6mFATYujlGB4fQmUZTDfEZuJ5OgSDwrSS35fFqvg
	 DFPlT3DoGW07xbq+u2fAK2euMhVBjBfhD0eJ01WpkGaV5waMcScg3rfTU6mXAJMiJd
	 MNdlHTwDVSugw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Jul 2024 14:24:26 +0200
Subject: [PATCH mptcp-net v3 15/20] mptcp: pm: only mark 'subflow' endp as
 available
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-mptcp-pm-avail-v3-15-e96b5591ced3@kernel.org>
References: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
In-Reply-To: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4021; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=0xFMDS4qYHKOiwYm0etxgWoqfwa1KQQH9JL0qVq+ToY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmlsA5YdgSfZiQIPpsche40jiPS6YNaMUDnZvU
 soIFsEUXeKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZppbAAAKCRD2t4JPQmmg
 c1vKEACKc5H450TOd++KcBl3GDYwPrAckuvfwtBlpYawm9bfpJsKMFjn/vdyy6kHJklgYGSBmq1
 bFV0WGmVLFJED1YkVcompKJ6PlswGMRAgShnKHVNkV8XbcMUAuIUBonUC/z97hoOpdPsWVmXEHU
 jEogu4LArY2EdTs2sSppcs+ESkuEWLg3UUryMlLvr6DNh9iaccjBgoi9TuSNIbZ73rARH27dBIC
 W4IJBE20dNS8ZJwY8bHNo6yL/+J8DuW6Zb0F084/Ie0GHtg5yvsbwA8RmC+Mf12+SqFzZShpXFS
 uPcrmuq7xS1IDykmfrdvTJrMiFjMA+JnUdFGvjH+9n+f/XkKt3bVZCSHKF7SaekK/QL4G3Lx7Jp
 8Jh73zNxMjPmIb149px+cMeiKZG6y/oHBYTOCNjRuILnrXu1KQ6H5b2kvF/YTdaRtgLG8EKSShB
 /hhqBuENqzsgp8j2fQPrLtuq+BsaFta5qTZcErsqaM8ognfDJ7F9g0Uul3Drf+Vxrug7LmYdB39
 mHZPLjJi3xYGPw2eFmJWdImzEv3OMZmmvc90pMcROutM3BjJVjzdW5KyPlqDRIRS42fudraDjkL
 Cnm+IjbiAp9aW6n710SFfTnZTa1nv3OD9Hp18y/an3oGcnv4luQbKMDLSXCn6mfmtkoNcKp+9bA
 Zm/ko43gI2mpH2Q==
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

