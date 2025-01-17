Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691701F9409
	for <mptcp@lists.linux.dev>; Fri, 17 Jan 2025 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737106477; cv=none; b=QIaFsmvBhGjpMsgV3m3wGIg82wfCUMCqsHj335uv5RQPPiFukzcu1JLWzu1Gxs8zbFeCmhiVg8vrZFM2WOW0UMdjG1i+R/u98Tie6L59Ji0ymZ4Nsd/IbwRrFoQJERFG6KhGbTGU3/InSDVknz9nGOmBkZAB1NPf3lYZvc9iiho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737106477; c=relaxed/simple;
	bh=BcMcrorEXUu7i7uxqZTK+Vz4e7CI+plstckMmnXnx+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tX9x8eFZkQUZPzeg5Z+9QvDzXkf28FL+rPwO306wRiYIWPDZ4Ea6ClF5o7CKrgMvR6CHwImRU7v39GtjZYAnpKyNP9IK98ek9Uh2NYUviuH/uPDWVaeL367ToK1MIuDg0DAk6OFc7yrnAajQkJk0feNeC5LkqUqCUEoIpEWs5Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDaQae90; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDaQae90"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765B6C4CEE2;
	Fri, 17 Jan 2025 09:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737106477;
	bh=BcMcrorEXUu7i7uxqZTK+Vz4e7CI+plstckMmnXnx+g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UDaQae90LoviMhCcf+Njdy5fySj2jDPuNzkLSaPSCecoTxcb9vQuvw0eDmnQNgr4G
	 FQ4nME262E4IZhXllS8iCl1PaNeg2e6Ev6cMLsGIedGzXJ1waZcBn4pF8egZ/BLNdh
	 Mhxg5XbHG8Nm0iWvJsvEohCp2eK83Pv1KLhpXXCDOraXuheLObPy7X6Eq5VgFTXxzt
	 XI/HNN7xMeiNJ0f6lXL0vG+mMUSO2kRh1AElcvkRxSM+Pm6L47D5Klg+DA49nF4NIa
	 F5TByDCwZxn3nb76iUH4jBW5DYOU3fLxofV8eNgZisiRll2SveBm9rF07RnVpumMDc
	 LwB5U3VytDhOA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 Jan 2025 10:34:14 +0100
Subject: [PATCH mptcp-net v2 2/3] mptcp: pm: remove unused ret value to set
 flags
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-mptcp-issue-540-v2-2-a194740fb380@kernel.org>
References: <20250117-mptcp-issue-540-v2-0-a194740fb380@kernel.org>
In-Reply-To: <20250117-mptcp-issue-540-v2-0-a194740fb380@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1571; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=BcMcrorEXUu7i7uxqZTK+Vz4e7CI+plstckMmnXnx+g=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBniiQocEWkhCBF5kS4yc/EWrS5bp7aDsO24nnXS
 6IDWWRb/5eJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4okKAAKCRD2t4JPQmmg
 cwLREACs0zGcSaIK/rlJHwrwX8AZWvygfDs9Ct5P63dyZIW4HVkcgUtX0BfoOuB5ufClCLFHKwI
 GT2OBC4Ewsl7+A7ezcWy7ZhLbc1Y7Zzt5QCH7HZVWA0hYulRP7Q0cuZyxN1xfC2lRwmepZE9s+Z
 /ya0YAGbo/ygtxyZPrZG+ZxZ3ApsHvbGInlT2Cl0UCgzI+hZIqlCqZ9KEpwJvDkLhO1FTOgb4ij
 rI+ido2JbTEDXJtGfqv4UWhnvu0FdibC+VQDhIN+ouglZ5jSjUM9FNd5Aj4M0mab2aKKGmhKn+o
 qIYaiSr8ItyYDDO5rZYIMxOCsvwh8Ikoa88pPDQmW7LTujhQJ040+6bVvnZ4Qu0yyFnyeuBkLMg
 ge4i3iCNdDOektnUeR4R1fsSCefEyw/9nwN+0m5LY6Cyb6ToQ7tLfLxZZge4QwRWIShKbAAVyvk
 u4zxDQxB/qvyzp6j6kqi6CSkgepu2l6O189xMpmN+kY8byoeWQkG22T3tgXAHFKxjaFZ3JRpbLp
 3yY6kYSlIBhqUbL/AkjeaRzJvpq6gxlvS2FcwUGjPdjZo6xjRSdy0/2GL992IrTalx7ksPNQVO2
 O/kaGad8Y9zG1Z5jSMJTCAXfvqNi8nkcL9ekriWtjahjkPGe48fNgZl6LvYddsxacj1/VedGTu7
 kEJKQDCzh2rhWXw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The returned value is not used, it can then be dropped.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 99705a9c2238c6be96e320e8cd1d12bfa0e0e7f0..ff1e5695dc1db5e32d5f45bef7cf22e43aea0ef1 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1922,13 +1922,11 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
 	spin_unlock_bh(&msk->pm.lock);
 }
 
-static int mptcp_nl_set_flags(struct net *net,
-			      struct mptcp_addr_info *addr,
-			      u8 bkup, u8 changed)
+static void mptcp_nl_set_flags(struct net *net, struct mptcp_addr_info *addr,
+			       u8 bkup, u8 changed)
 {
 	long s_slot = 0, s_num = 0;
 	struct mptcp_sock *msk;
-	int ret = -EINVAL;
 
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
@@ -1938,7 +1936,7 @@ static int mptcp_nl_set_flags(struct net *net,
 
 		lock_sock(sk);
 		if (changed & MPTCP_PM_ADDR_FLAG_BACKUP)
-			ret = mptcp_pm_nl_mp_prio_send_ack(msk, addr, NULL, bkup);
+			mptcp_pm_nl_mp_prio_send_ack(msk, addr, NULL, bkup);
 		if (changed & MPTCP_PM_ADDR_FLAG_FULLMESH)
 			mptcp_pm_nl_fullmesh(msk, addr);
 		release_sock(sk);
@@ -1948,7 +1946,7 @@ static int mptcp_nl_set_flags(struct net *net,
 		cond_resched();
 	}
 
-	return ret;
+	return;
 }
 
 int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,

-- 
2.47.1

