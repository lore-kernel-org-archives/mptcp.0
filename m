Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9965118629E
	for <mptcp@lists.linux.dev>; Mon, 15 Jul 2024 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721038206; cv=none; b=P4SnN4Q1Qn59zyk6XNxJ6kM9+BUne2Lx6FhO+fHuLz/Kiaoc5YFBI/xCX95XkvhM1wWscP+33MN+WzRv3/P4LbwGU0o1B2jieOBDWU6PxLKsL3vxSnSmNzmL9euIy/oYZ0g12fJgvVf8HbpuEsofi8wf6g5AY8Ji89C1SOIWZ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721038206; c=relaxed/simple;
	bh=3bp0+EUTF1pd58//Srb/ytyXhrPRDQI38dewIb8zZ0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TBIXc8zFmSuZr/jQxPYtlPQDpzOlvoaPE2GClJ5LfsPDJ73QoceriSEsAbnsxig4celRYHVPMDhXpn48QVrrNmSz85hQDVRSkpdfeioZapYqJlEAdZK77dGCflou/+iiduhx1/0R1eKaa6i6y2/HfB5bZU/XnsScnrqihNtDOQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqff1Ggt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqff1Ggt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AEEC4AF0B;
	Mon, 15 Jul 2024 10:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721038206;
	bh=3bp0+EUTF1pd58//Srb/ytyXhrPRDQI38dewIb8zZ0I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qqff1GgtLMrdISQidTYP0ZG6QMbUe5afTbc15gKyPubOpAhFOw8oANIAXCody11d/
	 OAsE9F8jE+Nkqcki9UgCZNo5CCpTWPllEsHNj86xq9BzQsmeBA2TOeW2KvBB1yGcte
	 GCYZMIml2ffuOjVyqdF2foMzP6GP1+BL8k4+LPHBhEN2rhYbhcSzk4OcKj8lB5D0FL
	 6TCSF2WujBAfXhMILColxVutV1l8pfZ+f0Fj4dlhMkL1hLQnS+lOFSuA39BC0yeYfR
	 gmb8dL9DpjQVTtYT5zTL72NBjARyrRnYCnqMHCOQN07TVlFVpGiONSpKeVKzCW27Nh
	 Zjo/JbraW23Dw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 15 Jul 2024 12:09:42 +0200
Subject: [PATCH mptcp-net v2 04/17] mptcp: pm: don't try to create sf if
 alloc failed
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-mptcp-pm-avail-v2-4-fc5153bd1f6e@kernel.org>
References: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
In-Reply-To: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2161; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=3bp0+EUTF1pd58//Srb/ytyXhrPRDQI38dewIb8zZ0I=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmlPV34AtWQ4vLaFL8IG8MjTJLvQ4UjpnLxhmPr
 oWWdCpPsfiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpT1dwAKCRD2t4JPQmmg
 c/8sD/sG3yBAQWp2UtdxXGt1SGkqyM8z509w58jffF3N3A2ha56tDy8+YP+wlewzgkKkScw6z3u
 ZCjJm1OJuYqH6O6SnVcCOvjbm3SZlICoAMlXcfOQErPMapQ4VHXydmx9i+/wJd8erZQY3oocNKa
 HXWDz5vc5WnKRhm3E40sjseUYCiqQiymNNcP0fDEoa5YBwmd+FgouN/llSMD3o+ZfMzKVjEaStT
 sERsq/o1mApeGTPbitSBBwWSRL566pCs9/L16DggY3G/KZM8wzOFYucosey0/gYh+jeayKtI1U0
 XaevG7MsZI6NFDhDo6RUyNmay/N5G7bYs2yBVq7Sq0in0lns7HsQSbgE7WpyYP2qYkYUmDZ13af
 1WeU8jkyFITvoYKH6tvgh3BlvojmmHqU/HziXexQAh4fv2OLxByfEf+v7+iS9uow98+4ieZ0vzd
 6RCVWLBK2zlZB/sTBlS4U4SkRVN5lA/0f5jBQ2pJe9VmMTpZA5kWOKZ6wQGrTiG5ZXFFrK3FmKQ
 J/h6HVBuGFYmoq4ml6jZXbZFDczwB3uayBJ0Qha8jl8s1vc3K0mBXoDPMKQZDsp9P75yAVDFjgH
 tBaNJFpUnKY4ziGkSImte8RNhQewSHlVnBkKrghbq6XXiyexx35XlAC2Zz+J1ghAI6e7Rsw3fPN
 vO9wsq60UTDhiPg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It sounds better to avoid wasting cycles and / or put extreme memory
pressure on the system by trying to create new subflows if it was not
possible to add a new item in the announce list.

While at it, a warning is now printed if the entry was already in the
list as it should not happen with the in-kernel path-manager. With this
PM, mptcp_pm_alloc_anno_list() should only fail in case of memory
pressure.

Fixes: b6c08380860b ("mptcp: remove addr and subflow in PM netlink")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index adc0183b8d3f..0ca6b358ab51 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -348,7 +348,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 
 	if (add_entry) {
-		if (mptcp_pm_is_kernel(msk))
+		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
 			return false;
 
 		sk_reset_timer(sk, &add_entry->add_timer,
@@ -556,8 +556,6 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 	/* check first for announce */
 	if (msk->pm.add_addr_signaled < add_addr_signal_max) {
-		local = select_signal_address(pernet, msk);
-
 		/* due to racing events on both ends we can reach here while
 		 * previous add address is still running: if we invoke now
 		 * mptcp_pm_announce_addr(), that will fail and the
@@ -568,11 +566,15 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		if (msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL))
 			return;
 
+		local = select_signal_address(pernet, msk);
 		if (!local)
 			goto subflow;
 
+		/* If the alloc fails, we are on memory pressure, not worth
+		 * continuing, and trying to create subflows.
+		 */
 		if (!mptcp_pm_alloc_anno_list(msk, &local->addr))
-			goto subflow;
+			return;
 
 		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 		msk->pm.add_addr_signaled++;

-- 
2.45.2

