Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAD325A659
	for <mptcp@lists.linux.dev>; Fri, 17 Jan 2025 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737106478; cv=none; b=A5S68jxst18VBSvs0rrGRSd6O2R5X17qiFHAwFl16pOZBNlwWiDF6w9gGfo3+/zmnOJ8f54drKpD8W4CjLdrnm7gS6LF8OkuPps5nG7ueGyey1L1fKZrU8LZs4BHoJSiK1HLk9byHwdbp3WJcIGYlrsfAHCTRcobYM5JDLa9R0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737106478; c=relaxed/simple;
	bh=Z9VH9EKYJiONuf7Hf/esBY50wItS6sWRscwSaTlPiWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VFpda7qTcnFEchCniy3wWrXalZgXMvSjBUf9+2z8axqlr0uIWHqDxZ4onUSztlpnP7fvaMGyLz8mEtsPa+rrLJu5w7xShVcGNhHx+Vx6sVxJG+avslJdmIj4sqGnkqsqtSA21QxfuQJzHGAZ39v3aXVK4lJHlmJftQsMT7FhCL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4cJJdOP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4cJJdOP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758A3C4CEDD;
	Fri, 17 Jan 2025 09:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737106478;
	bh=Z9VH9EKYJiONuf7Hf/esBY50wItS6sWRscwSaTlPiWU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O4cJJdOPvKax9J/2q2LTJuwHhDWifw3m1Z+nRNxTSlCZX7DZw64RkpcqTweIkMsuT
	 VPVaFJkAzBVdz3VUD+06F1Sr/n604XyTL8xw8ZFZv6Lal2F+G5n9IUzF/2wwxrjAqw
	 qtnv2tTowyixM/MDa2omfy3NMNiOsH/wn/k/CzEDhtVUKBZfCDXRwGOECUxYlGfDCa
	 7pSupHFxPj2u7DiNQWAw7mThN1CqP4UW7BQNraP+QFCEk/meZg1PpgIqIIufQqz2+s
	 IuXY+Qq8L9yFCXm8+qa2pyva0/XM8eKbVGZDrA2ivR3MLGoDAT4CQAcZkQCL3xWxtz
	 vbr29/WQXM/fg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 Jan 2025 10:34:15 +0100
Subject: [PATCH mptcp-net v2 3/3] mptcp: pm: change to fullmesh only for
 'subflow'
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-mptcp-issue-540-v2-3-a194740fb380@kernel.org>
References: <20250117-mptcp-issue-540-v2-0-a194740fb380@kernel.org>
In-Reply-To: <20250117-mptcp-issue-540-v2-0-a194740fb380@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2507; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Z9VH9EKYJiONuf7Hf/esBY50wItS6sWRscwSaTlPiWU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBniiQofX9c+ku0mIdpDkRTTu5uKueHddSv61RPB
 peRXxM9wMCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4okKAAKCRD2t4JPQmmg
 cxQ3EAChvLiDOhc2hvEXSlirOtVgzd1+SQPS/Gg0JkiwYasaUYZ0tfas93YF0zuOcZSs2kZbyog
 b908szB3TXp1Y82SRC5WREvU6QDo3AjGlJwi3xUpQFOybyvdAEf4FCVtcy5q/w5naHB141YuWX4
 OMbvugRWPy4CtRIRaXt/xRDV1S9L8IWP/KTmkLacSVvsO02ZQx4WOZdTI5UInKpvOtayGRL3OYZ
 IFNe0LTQ3gQ9P1reV4WUC8zdoiIrpYvj0SMV/ZpuMbJUWWvLsM1KfMF+BRamKhLfuGzSUr4ZtFN
 oV3PBfQ2SebLdPt/69McKYkeZ9eU5okXaZ/UWLzYi1212lGi3YDuqfds0CP3I8/5qEUq0ET0Diu
 aeG/mPE4Z9i6+ZLVSPVk9LExXBGulikMUCSLQlKQsPyRrw8mcuaDHOcZyAICUwUAz7ECDEeYzbc
 WNhZlJiLbnga/ZjvnagkgyFjt/WNa7979ckv7SON9vBAsqBbVkaAMC7IEWFb7EBiTSEAoJVy+6F
 2LrsVrqgiEgIcD04SVL+bkvO1RjrbqDYzliEv04nswTNzxaq3wrNjwN3ftBOlz/Zlry0qwarKmm
 tdw2W7Jz9QnY7KWy4gt+muxG2BZ0rJGpO3ywaKzcjADwxeTN585fowDcLoNZpVR5wdc+O/g1FWl
 6GYphfdkMqdmHzA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

If an entrypoint has no type -- so not 'subflow', 'signal', 'implicit' --
there are then no subflows to re-create from this local endpoint.

In this case, there is then no need to iterate over all connections to
do nothing. So stop early when this case is present.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ff1e5695dc1db5e32d5f45bef7cf22e43aea0ef1..b1fe2a74fcfe97896de8f9eaee9a1afa5378fabb 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1923,11 +1923,16 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
 }
 
 static void mptcp_nl_set_flags(struct net *net, struct mptcp_addr_info *addr,
-			       u8 bkup, u8 changed)
+			       u8 flags, u8 changed)
 {
+	u8 is_subflow = !!(flags & MPTCP_PM_ADDR_FLAG_SUBFLOW);
+	u8 bkup = !!(flags & MPTCP_PM_ADDR_FLAG_BACKUP);
 	long s_slot = 0, s_num = 0;
 	struct mptcp_sock *msk;
 
+	if (changed == MPTCP_PM_ADDR_FLAG_FULLMESH && !is_subflow)
+		return;
+
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
 
@@ -1937,7 +1942,7 @@ static void mptcp_nl_set_flags(struct net *net, struct mptcp_addr_info *addr,
 		lock_sock(sk);
 		if (changed & MPTCP_PM_ADDR_FLAG_BACKUP)
 			mptcp_pm_nl_mp_prio_send_ack(msk, addr, NULL, bkup);
-		if (changed & MPTCP_PM_ADDR_FLAG_FULLMESH)
+		if (is_subflow && (changed & MPTCP_PM_ADDR_FLAG_FULLMESH))
 			mptcp_pm_nl_fullmesh(msk, addr);
 		release_sock(sk);
 
@@ -1959,7 +1964,6 @@ int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
 	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
 	u8 lookup_by_id = 0;
-	u8 bkup = 0;
 
 	pernet = pm_nl_get_pernet(net);
 
@@ -1972,9 +1976,6 @@ int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
 		}
 	}
 
-	if (local->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
-		bkup = 1;
-
 	spin_lock_bh(&pernet->lock);
 	entry = lookup_by_id ? __lookup_addr_by_id(pernet, local->addr.id) :
 			       __lookup_addr(pernet, &local->addr);
@@ -1996,7 +1997,7 @@ int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
 	*local = *entry;
 	spin_unlock_bh(&pernet->lock);
 
-	mptcp_nl_set_flags(net, &local->addr, bkup, changed);
+	mptcp_nl_set_flags(net, &local->addr, entry->flags, changed);
 	return 0;
 }
 

-- 
2.47.1

