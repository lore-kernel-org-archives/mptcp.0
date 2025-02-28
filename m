Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAB61E4A9
	for <mptcp@lists.linux.dev>; Fri, 28 Feb 2025 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740749512; cv=none; b=tY3Y41Jar3QC/mm0zg3Rz5Rymsvs97a/gy8iK/5vSSSPU1vldEdbk83rBso4sbey6hmkN+0iTb0ib/BmgrLLzaxOZ8UA9iCDbKdL9Rdl5rd2m2agJvdj40BNayodF2OWDGSkZNUx5BXDM0qQIfJmhYtd+8/qdkNhxhjhf2/Fzvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740749512; c=relaxed/simple;
	bh=+YFmQ8e3mD3WTEPmZJuPYSqXbEqpWXHAt8z7l6AfdH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VPA4WuLVYTRAzfxyAETOEFPuwq4V8FbEb7u1ZDixUvnNigywAZ1gWg5X9VLCb44wZ7USKQ4jb9w1OGSHtz1Eb8yzbeAzJb4hBFEI1MHw3R5Rm/7qPpKrknx6R0CZIKTqjbUT5+osb4BGzcJHjTeNoKPj27aiNR558FYGEaFowKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1StG/KQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1StG/KQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABF8C4CEE2;
	Fri, 28 Feb 2025 13:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740749512;
	bh=+YFmQ8e3mD3WTEPmZJuPYSqXbEqpWXHAt8z7l6AfdH8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l1StG/KQrRFVfEqiPSRZlo+z5/lj9xwHLupR+3iSEVdCvRb++P5rDNzzs2z5a+v+2
	 Od0vwX+CazeiyPC5VXO9uH/UeKf1VPGXPHbl2nnRkvEAhk+rDhKrQ9Ii7PyNTT0XgR
	 tU7cBDvZNCQUzxv4/9Hya5KD4DbSaem9WEpiqKmnc99rA4f0fw1WZQtmMydKgr6zEl
	 wSHRvl5jtebNJCsXAHztjh6vRMR6AT5DUMyWMwyZDoIY2larPViA2K7rHeBeGRY7fo
	 Xf4VC6oGd+X/CHZvn58AINt8Zsnn/0OlEAn42/nsv6DFhQBYVJHNJm6ab3IY9KiYnw
	 m8Q87Oa9HR/sQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 28 Feb 2025 14:31:30 +0100
Subject: [PATCH mptcp-next v2 10/14] mptcp: pm: export mptcp_remote_address
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-mptcp-pm-reorg-code-v2-10-fa8b2542b7a5@kernel.org>
References: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>
In-Reply-To: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3628; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=+YFmQ8e3mD3WTEPmZJuPYSqXbEqpWXHAt8z7l6AfdH8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnwbq6+A4jTLnz4HFvQPpxF0DZ2hCDR9xZ/Zc5/
 NNeRITf5VaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8G6ugAKCRD2t4JPQmmg
 c9uZEADsnyDkn+RemTkC9bpwBsG9koFVhJ5H/g2QrqX/NB1DyBcMb8IGeK7IHVTDVfMHssFP245
 caX5lDYFMDLkVHXoRdHYMktyx+5k5ynujIadZ2ZbU35/sEDvAx6HCzDUQIx0eCiy64pvAI/V3Ai
 hB8SP8kJKyHub0/+7nvT35URAbTGhBjJAeCEkeQCt73l0D5KPFr+sQN+lh8TZoM9kvryUyiqjx6
 W7g4c5buKh/cPno3RgN3SldoNlBKeb3sNFbdSgLsWtV8Ax+wb7piqTSFaPIT9cI3m7380lBE+3H
 ajk3a5HtPBwYVJWXh4FQwplHvWygUSlPwT6/HN3DQNEmNPngWd1bpA2fHjlLiV4Tho8FsA7fRCr
 o8Ln6lezOSz60RFanJ8A9uT6CAle4BQS4JkGDPgJFOqMQ4Jl1bi2BwsVHk3k0e6A2eSIzx3neOg
 wxbmM/xgXk0SXrPT1GrsJkOcZrC+g+8KaNgmXX0QLjl4GgMsOBm//RrgAxKy8CncVFRaaE6WpJB
 rfoDHt5IaZJEOWBp8AoNGCkZtOBylXaX6yPaSyNKwgQGMdVs8Nrwh7qRkVLwwAowtEoKCLfcgnu
 mgtT59z6DKYwlMgnWWNA4AgL0hU/cl8lnuAz0s9X/2JIVZw4MU5ioM0Zle8XT/pB1JFu2LItakk
 RxR9X6Sa2yTe+TQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In a following commit, the 'remote_address' helper will need to be used
from different files.

It is then exported, and prefixed with 'mptcp_', similar to
'mptcp_local_address'.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 14 +++++++-------
 net/mptcp/protocol.h   |  5 ++++-
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 37986208b9c0aac48d9a7b29fb37e11e947f0d66..27b8daf3bc3ff550b61fc9fdbd6f728804ea43bf 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -94,8 +94,8 @@ void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *
 #endif
 }
 
-static void remote_address(const struct sock_common *skc,
-			   struct mptcp_addr_info *addr)
+void mptcp_remote_address(const struct sock_common *skc,
+			  struct mptcp_addr_info *addr)
 {
 	addr->family = skc->skc_family;
 	addr->port = skc->skc_dport;
@@ -138,7 +138,7 @@ static bool lookup_subflow_by_daddr(const struct list_head *list,
 		      (TCPF_ESTABLISHED | TCPF_SYN_SENT | TCPF_SYN_RECV)))
 			continue;
 
-		remote_address((struct sock_common *)ssk, &cur);
+		mptcp_remote_address((struct sock_common *)ssk, &cur);
 		if (mptcp_addresses_equal(&cur, daddr, daddr->port))
 			return true;
 	}
@@ -428,7 +428,7 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
 	int i = 0;
 
 	subflows_max = mptcp_pm_get_subflows_max(msk);
-	remote_address((struct sock_common *)sk, &remote);
+	mptcp_remote_address((struct sock_common *)sk, &remote);
 
 	/* Non-fullmesh endpoint, fill in the single entry
 	 * corresponding to the primary MPC subflow remote address
@@ -455,7 +455,7 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
 
 		mptcp_for_each_subflow(msk, subflow) {
 			ssk = mptcp_subflow_tcp_sock(subflow);
-			remote_address((struct sock_common *)ssk, &addrs[i]);
+			mptcp_remote_address((struct sock_common *)ssk, &addrs[i]);
 			addrs[i].id = READ_ONCE(subflow->remote_id);
 			if (deny_id0 && !addrs[i].id)
 				continue;
@@ -777,7 +777,7 @@ bool mptcp_pm_is_init_remote_addr(struct mptcp_sock *msk,
 {
 	struct mptcp_addr_info mpc_remote;
 
-	remote_address((struct sock_common *)msk, &mpc_remote);
+	mptcp_remote_address((struct sock_common *)msk, &mpc_remote);
 	return mptcp_addresses_equal(&mpc_remote, remote, remote->port);
 }
 
@@ -826,7 +826,7 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
 			continue;
 
 		if (rem && rem->family != AF_UNSPEC) {
-			remote_address((struct sock_common *)ssk, &remote);
+			mptcp_remote_address((struct sock_common *)ssk, &remote);
 			if (!mptcp_addresses_equal(&remote, rem, rem->port))
 				continue;
 		}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 83ac7ac08e7723d8aea62f9d2f03f2d01ebf01e1..bd1782a569fe39f3c21c520feb8174472151e0de 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -729,7 +729,10 @@ void mptcp_set_state(struct sock *sk, int state);
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 			   const struct mptcp_addr_info *b, bool use_port);
-void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr);
+void mptcp_local_address(const struct sock_common *skc,
+			 struct mptcp_addr_info *addr);
+void mptcp_remote_address(const struct sock_common *skc,
+			  struct mptcp_addr_info *addr);
 
 /* called with sk socket lock held */
 int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,

-- 
2.47.1

