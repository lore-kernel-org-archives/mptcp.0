Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D16271288
	for <mptcp@lists.linux.dev>; Thu, 27 Feb 2025 20:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740686941; cv=none; b=ADI8WUVkDx2XoPmH4SPGnX0RM7C4zvFgHLga0rHs59UpaBie59+447T58wkZBMdZInDMU8jTVjjEPem6q2SVtlSw95B2pJsDopU61ohz0Ivv4R/zh/k7bzpJAoeu2c0eMuGnTr0B5CgAdv6RpdpjyOrum8i/AqtfqAIpe8XPLc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740686941; c=relaxed/simple;
	bh=UILxa/TqfhzdXpuDLwwRz/IgNjXN8euvQyCOxLlbGPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DKw5UzF3cGlZWPhN+g/HeOsPGsJ96f/zsnckebZScvL6EXcWEb0eML3vuuotMCm3yhq8eSjiqtPHK4XWzi+ontTJgKsKeeV4zlUFzJQAc1O3C1NV71cybrfUEIMkGqijKQecNs5dHp+g4cToE5IOYAjx5FdS/7c27KkX8wbtehA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svxHKDOp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svxHKDOp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A386C4CEE5;
	Thu, 27 Feb 2025 20:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740686940;
	bh=UILxa/TqfhzdXpuDLwwRz/IgNjXN8euvQyCOxLlbGPo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=svxHKDOpbzMgmcGqsYlmA8OmnxKB2Xsvv0RQciinAcuMedQOQ/ekLuq/jLJrfed8P
	 We7n38hytzg07yyX1A6Qr/mstxRkO8T/Iy17qIPo76CSRQKza8Nb7tfGM0OjZXbw25
	 VeBnGuxur85TEBu1hP9HDgbme6XR5tgloyAAWrkW/ZoiZz4+AMpqm42O0IXzkiQkZS
	 tmRbwhtooX4QdIWhSRT9VLr2e4Xm5EVSP0Vx8//GeOhHWHcwc5/dgHqY9WYVUQFj2k
	 LbeNX8+ud+kb4XkvyoRP4Nrfepw9CxGaLiJvxsgysNiDyW1MkadwzR7q65mwbWQmAg
	 kftSQpzcXN6yA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 27 Feb 2025 21:08:49 +0100
Subject: [PATCH mptcp-next 2/7] mptcp: pm: remove '_nl' from
 mptcp_pm_nl_mp_prio_send_ack
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-mptcp-pm-reorg-code-v1-2-cb4677096709@kernel.org>
References: <20250227-mptcp-pm-reorg-code-v1-0-cb4677096709@kernel.org>
In-Reply-To: <20250227-mptcp-pm-reorg-code-v1-0-cb4677096709@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3369; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=UILxa/TqfhzdXpuDLwwRz/IgNjXN8euvQyCOxLlbGPo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnwMZYVwk733QPXzh8YAv9fY4YKMmy8+2SKREZe
 SrN0TPHFUyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8DGWAAKCRD2t4JPQmmg
 c9Z6D/9BcfNxBt9EXvekGS9e5OIAaLcMffKFBW2gxVMT5B/tVUk2B2CZ0p4gWsXqzoETFX/IBWQ
 nntbmq9wkbP/RqgbZ9PXjJxQ+xS8Na5K+NksiGymhN0uVg7mqG9eH4lhBUr84epYMTlihwyfB64
 ToGNhCVCRL06IJ0wIUYH15pP7mu2AKEMV3f7BGpiWDV9KyXvYF2C9Qq+pMK6O+G1qwNbxxMuJga
 KK5x/liFVQPPdegeaRnWgbj0KulqjlQPn4fK6Waj0FzpSZlHu0yF/EQO7zdOq7++VieCFa5UQL5
 BWcma5K5+sJRfbaCpon1PvNB9/lDa6cw07qKe+XSt2mlvJs3Z+69A6XG82/L/EOYdchPouH++8a
 +De6rh0VBA4u3zyeI027WP2ksvPeHjSCrgt4B0vaQ+1Cm5dITyYnIEuV9Yh+a0j1jA+QFiMEL3D
 rsYRhdcx9bGV5l/6PWyED8jGZJlQfiYtFXHhVn6eI9ObuRYBtp6Axdxhbkzlz6uef18e7gjisPn
 118FKMcymHGVDYpPeRfGcUXIAOXx0n3C+O4awKL7XaOoytIwVmPkILo2SECjIuN77/tthUr4/qs
 TvLh3VNB6U3EHZ8lD3ErexMizmzv6uAvQFJQCS4cORPIzfnsnNiP551nl+ygXWLKkuukQGLk+bk
 rlKVgeADP0z4XjQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Currently, in-kernel PM specific helpers are prefixed with
'mptcp_pm_nl_'. But here 'mptcp_pm_nl_mp_prio_send_ack()' is not
specific to this PM: it is used by both the in-kernel and userspace PMs.

To avoid confusions, the '_nl' bit has been removed from the name.

No behavioural changes intended.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c   | 10 +++++-----
 net/mptcp/pm_userspace.c |  4 ++--
 net/mptcp/protocol.h     |  8 ++++----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a70a688eae845c562c03caa0f3e20169c5f5be11..5494b5b409dc478dc783844b9cfdef870688d17e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -808,10 +808,10 @@ void mptcp_pm_addr_send_ack(struct mptcp_sock *msk)
 		mptcp_pm_send_ack(msk, alt, false, false);
 }
 
-int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
-				 struct mptcp_addr_info *addr,
-				 struct mptcp_addr_info *rem,
-				 u8 bkup)
+int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
+			      struct mptcp_addr_info *addr,
+			      struct mptcp_addr_info *rem,
+			      u8 bkup)
 {
 	struct mptcp_subflow_context *subflow;
 
@@ -1936,7 +1936,7 @@ static void mptcp_nl_set_flags(struct net *net,
 
 		lock_sock(sk);
 		if (changed & MPTCP_PM_ADDR_FLAG_BACKUP)
-			mptcp_pm_nl_mp_prio_send_ack(msk, &local->addr, NULL, bkup);
+			mptcp_pm_mp_prio_send_ack(msk, &local->addr, NULL, bkup);
 		/* Subflows will only be recreated if the SUBFLOW flag is set */
 		if (is_subflow && (changed & MPTCP_PM_ADDR_FLAG_FULLMESH))
 			mptcp_pm_nl_fullmesh(msk, &local->addr);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index fbb29a9eb19125ea29f557e97123488689bfb3ce..434f59b793ef9a581ab37667fc904927c1600199 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -606,10 +606,10 @@ int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
 	spin_unlock_bh(&msk->pm.lock);
 
 	lock_sock(sk);
-	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &local->addr, &rem, bkup);
+	ret = mptcp_pm_mp_prio_send_ack(msk, &local->addr, &rem, bkup);
 	release_sock(sk);
 
-	/* mptcp_pm_nl_mp_prio_send_ack() only fails in one case */
+	/* mptcp_pm_mp_prio_send_ack() only fails in one case */
 	if (ret < 0)
 		GENL_SET_ERR_MSG(info, "subflow not found");
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b8800fd208429df43869c40e5f67f110d9584332..500c147cd4d4b4bf274b65fc9a181417fa90bc1a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1018,10 +1018,10 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 			       const struct mptcp_rm_list *rm_list);
 void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
 void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq);
-int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
-				 struct mptcp_addr_info *addr,
-				 struct mptcp_addr_info *rem,
-				 u8 bkup);
+int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
+			      struct mptcp_addr_info *addr,
+			      struct mptcp_addr_info *rem,
+			      u8 bkup);
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);

-- 
2.47.1

