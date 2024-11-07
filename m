Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADFD18FDBC
	for <mptcp@lists.linux.dev>; Thu,  7 Nov 2024 06:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730961967; cv=none; b=cg0okBwQMC4jr/qY93Ih8KDAUSpcrp4lpRAiJ9hmytqgphx8Js3ex/YBr2DEA9c1WAVl+AYXt/OYRr7RzKns/Wqlgj7+6IdGNjHb3KQKBHsPoDHNgck+e0R1TpNZYmAiE9encAoPVAdFhTyiL/cMpqXcvLgUzM5WOfM6k1Ibs3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730961967; c=relaxed/simple;
	bh=4G7vkWbUjhcSLDVJQOpc7SWXGApXZs5Ohe/M3yBF87k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJvk5TKC6KThody8TbNJdwEIvCLKG9YR5XTkM0tquTCrp/HJeI906zF33sjw52WL+9XiT8H+K92n3UfQ4lMycLAPnNPjNGpDuCOwUOnuKkuHeEr7tmIcfbj7vU6bWbK1eu7pBtdBgglUDWcjw6K68nzjL/RH1BZkMfUGgVSRmGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaDGT1zJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaDGT1zJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC221C4CECC;
	Thu,  7 Nov 2024 06:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730961967;
	bh=4G7vkWbUjhcSLDVJQOpc7SWXGApXZs5Ohe/M3yBF87k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aaDGT1zJZlP7kxW3nG1EgkMWHQkYMqDQPzSCFzjtmIv/1zRxKVzsakbFET74Akqrp
	 st93fkpYO7sZgAKlRjMxkqoEVCHIqpXOghY4gQpYMh0U4RM36dmocgfUsN117GxvOu
	 EWlpfn5HbwtRjYew4/355Nz55LbOvkFcG8YrXpRxwjNRQ99gZSlkl+WPWKKGjOS62V
	 T/zNA8CuyofX6QqnKTj4OhL0Jc+aNd6EnzPSJcHlwrgumCjml6jNgX1QVsDpnIdrMt
	 DYSutD3PbdbufQFLPPFyEsVq5JXLtN7jwv+G9xw/4iLC9qPLnkneEOqBcfWgTqYhCU
	 ZFmQP5w+YJLDA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 9/9] mptcp: drop useless "err = 0" in subflow_destroy
Date: Thu,  7 Nov 2024 14:45:43 +0800
Message-ID: <6606e2c5b8b3536cad35baf722175a932242d820.1730961810.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1730961809.git.tanggeliang@kylinos.cn>
References: <cover.1730961809.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Upon successful return, mptcp_pm_parse_addr() returns 0. There is no need
to set "err = 0" after this. So after mptcp_nl_find_ssk() returns, just
need to set "err = -ESRCH", then release and free msk socket if it returns
NULL.

Also, no need to define the veriable "subflow" in subflow_destroy(), use
mptcp_subflow_ctx(ssk) directly.

This patch doesn't change the behaviour of the code, just refactoring.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 07e0c7259494..8545212f023e 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -535,19 +535,18 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 
 	lock_sock(sk);
 	ssk = mptcp_nl_find_ssk(msk, &addr_l.addr, &addr_r);
-	if (ssk) {
-		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-
-		spin_lock_bh(&msk->pm.lock);
-		mptcp_userspace_pm_delete_local_addr(msk, &addr_l);
-		spin_unlock_bh(&msk->pm.lock);
-		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
-		mptcp_close_ssk(sk, ssk, subflow);
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
-		err = 0;
-	} else {
+	if (!ssk) {
 		err = -ESRCH;
+		release_sock(sk);
+		goto destroy_err;
 	}
+
+	spin_lock_bh(&msk->pm.lock);
+	mptcp_userspace_pm_delete_local_addr(msk, &addr_l);
+	spin_unlock_bh(&msk->pm.lock);
+	mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
+	mptcp_close_ssk(sk, ssk, mptcp_subflow_ctx(ssk));
+	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
 	release_sock(sk);
 
 destroy_err:
-- 
2.45.2

