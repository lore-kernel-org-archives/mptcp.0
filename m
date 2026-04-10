Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE5F26CE05
	for <mptcp@lists.linux.dev>; Fri, 10 Apr 2026 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775831528; cv=none; b=rDGoGNFKNttkWq0CUiaseM/HyoPQcCIm2iCi/PfipSG5HS3tUCRzVB70KX/+jbR40t18t24b1M56ev6KeWCyE9fEwbjU31ROYBn347ZR0up7H+7pFpIIZmtzwy0hzzxShK8gqgwyhPABfDuPYETybt6jzWurQgGe8JF0Weq7HKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775831528; c=relaxed/simple;
	bh=0KN6SmaLsFq4+oTKOP3cZm1bwxb9wxqcqaeKJ7O9c84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R506ut/Ej/2yCh2Zmhr7maC8l3+BbMfnI/IGwTJvZpABXFIxNXjiyZZxYrByUcDfqwhU3W+hSweUz9QSwPtx/p7xpsoaCQPsvAD0v4pgBVi5e6lCdL1nbAmloGhO9N0djUhWCOsy2rhDdVo8kGWl7ZD668vjg2gWxyKrk10l+P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1i5iSYZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1i5iSYZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078D6C4AF09;
	Fri, 10 Apr 2026 14:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775831528;
	bh=0KN6SmaLsFq4+oTKOP3cZm1bwxb9wxqcqaeKJ7O9c84=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=b1i5iSYZxhaPxzcZeNVju0e4YSE770oebiRTIBwICUnCPrqZLJEmJZtSbZ8btRozA
	 FA5zA+27z3XWxtciXqH1OQLxzK/ZHtuwTrz4hHc0CuNKiDqw7uVEDMR7B9PEOxy5nM
	 D5nw9FWz3lg7oOWD146ibrY1MNdLiYGqagm5MgxzcpZDReM0/p5W/BJq7p4clVRNOL
	 b8kqAkItdcW2/Vk6MfoSU9glGea/2mp8v03gFllGo4KkKeGiOvyEhCrNlRsEMHsQws
	 O3wJpoOcllptStU5EpFnKlcVBajMEGC77EO3icD0bv/VuoinqUl8jcXlu6ZwKv0YMh
	 C6Qhf6mK4X3DA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 10 Apr 2026 16:31:40 +0200
Subject: [PATCH mptcp-next v2 02/17] mptcp: pm: ADD_ADDR rtx: fix potential
 data-race
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-mptcp-inc-limits-v2-2-5402209f05d3@kernel.org>
References: <20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org>
In-Reply-To: <20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1178; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=0KN6SmaLsFq4+oTKOP3cZm1bwxb9wxqcqaeKJ7O9c84=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJvct68/1jhccYWy/0Z9/hX9Qtw8Ob5Gkx2dPv3PWPfs
 u7mGJmvHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABMxUGX4Xys279ZZwU3L/k3y
 ifybPfOpneT6900/pZOUD8/vu22xrZmRYcn2hTWTL6Y2vLYM98oRXFVddPfPzwzJrcJ+wTX6rcJ
 beQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This mptcp_pm_add_timer() helper is executed as a timer callback in
softirq context. To avoid any data races, the socket lock needs to be
held with bh_lock_sock().

If the socket is in use, retry again soon after, similar to what is done
with the keepalive timer.

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 52f8f4eddfc2..989d87e2dc13 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -340,6 +340,13 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	if (!entry->addr.id)
 		return;
 
+	bh_lock_sock(sk);
+	if (sock_owned_by_user(sk)) {
+		/* Try again later. */
+		sk_reset_timer(sk, timer, jiffies + HZ / 20);
+		goto out;
+	}
+
 	if (mptcp_pm_should_add_signal_addr(msk)) {
 		sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX / 8);
 		goto out;
@@ -368,6 +375,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		mptcp_pm_subflow_established(msk);
 
 out:
+	bh_unlock_sock(sk);
 	sock_put(sk);
 }
 

-- 
2.53.0

