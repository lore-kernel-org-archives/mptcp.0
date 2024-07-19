Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA0F83CA1
	for <mptcp@lists.linux.dev>; Fri, 19 Jul 2024 12:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721391878; cv=none; b=G7CnlzYV13QSZRkkp1H0N1Ka6YppibRN2DeNR/eE5HDFXjp0QWb93tFV2TYl2IsuLYIzBvYaubF69DxsiSwSd/iF6u6Mvd38+YrQi2KUq4RWQQ6DebcL67BtkMCwmHZQb92o/dTSe2hWWEm+VEDPf6j2SbcbeI0Qk49G8czUxTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721391878; c=relaxed/simple;
	bh=3bp0+EUTF1pd58//Srb/ytyXhrPRDQI38dewIb8zZ0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aZDK9a6Mog2dszqg+NFMQ+rmwm7wSg4yWSmRtr3iNRHhTyI71G2WCU3JSixV3vQwu92oTDYLIAaJKH4yfduTU/GqOvXhzRIiUS3KIQ4pVI7aFcjjX2j5pZLZhSMo5smDIRSbH7Unb48L0jQ9xoFDA9OjEVrQk/IPMNbGboUKnNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCoWemjF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCoWemjF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFE1C32782;
	Fri, 19 Jul 2024 12:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721391878;
	bh=3bp0+EUTF1pd58//Srb/ytyXhrPRDQI38dewIb8zZ0I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lCoWemjF3gtx18dnicRNcpOCsv8OeWjlkdoe/alY+ALyW/z6mQV+3OEsZADNilt2h
	 zhztRfcWel9ikUe6mS50cGGsqSalsIMXmeCKaE6Cyjwgp0Mfg5nDmYmU1qvT0QD8Iy
	 2LSk+EWoRjkmGQhtn4AdE9fGZcai9XBaSqoZL5qn7p5cDbg0sYoirUQppXaoqngEjt
	 EtS55pZ3bLW1Nr+4P3rfeM9yd2BuiA+hfpcLIhWGKLLG7kVWaAdvmliGbiFfRVj5Ns
	 KKbZAxymHyGdsSM5w7nbqRM28tO5sbtG2NQX7gMdm3bymkltOySoSkYInRPaoVkpKG
	 vLjHbQPi8xCMQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Jul 2024 14:24:15 +0200
Subject: [PATCH mptcp-net v3 04/20] mptcp: pm: don't try to create sf if
 alloc failed
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-mptcp-pm-avail-v3-4-e96b5591ced3@kernel.org>
References: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
In-Reply-To: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2161; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=3bp0+EUTF1pd58//Srb/ytyXhrPRDQI38dewIb8zZ0I=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmlr/XN+oxN0wFUNim3HxcfM8ygfB9p8dwb1KW
 QQ55lmRHQWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZppa/wAKCRD2t4JPQmmg
 c0IoEACnPhYzPq550e8XvuY5qUpuCHl3LHJbJY5x3leXIzjPzZC/ZX4LzF4O6YK+offmtwFqa/8
 LbhHmUzJc/ezBEi7FHMkUHeiyhyp9mzmlGpdh8com3ScF1py4GDCqJyeXZrm/uTSZSdC4F/ZeTF
 i2kAFcGAOG43RsLOOz42KIk+DjFp0oTBfh1mK8ZTi3zzSeeuoR1YazAorXKpllh2IycxhXDDZRY
 Jz8yHLSWXaUFI2C2kr3zBzROdhtzPpmZSw6P+UxnPHgLjDwjDk5bK0xtuWyUg3F2m5ZTTX1gP/L
 JvhHboJoEJTiAGTm4nF5H1hjl7gF+95GEpTuJlOY0V7FFZ6D3Y/Z4UOfRlrEr18qjE3kSIsNJb1
 zM7ITiWQhGxlJ5OaxRKj6Of+nitVWC7pb0LC20KFJr8yJoUgGdmoi39Rq8wNTesQZTycfkVMSLJ
 CAUAQ9e4Jqi6Zc0HynJLVqjRn5MmtdE0iyKz3VK4V+EJ0btVPMO5ZqkcNddXsSQcTqcaVrD+6f0
 szbk+8VP+l/btyjgzwmO40Pjs5ooW7xYEff8c0VrYXCil5SH+IWnULB/H/iBrRAcl3I5U6zhlWX
 uSJPQ6AaZNs0P+nEEGopigHKke2ot3usvFQilE53aX/a+NMzm8bhubT0DhFoNua8ObdgwMsFeP1
 leNYsABCyef6ZNg==
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

