Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0502702D7
	for <mptcp@lists.linux.dev>; Thu, 27 Feb 2025 20:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740686940; cv=none; b=Rw7EMoOJMYdKfQzgNLCkXiMUeUOWiK6fq8zoqaJnXU6GKnp9rYl+oGCxeGLPreEB9IqrDHn+L2lT3InWG6OMCkCrFn/3a85z9/ArL3Za3LTHWJEyZ4sUf1PR0g9+AwZNbcDRbH87Ft84fXAs+faxTE2bUKZkak0+1J4F7xaOw2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740686940; c=relaxed/simple;
	bh=wcBZY8yZuO9n0zckgdU2YhS52/cGCxhb6UEjLocmPAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MfzethwVuMOe39abdTAy9BC7HlEW42TJwDs+VKZRHRmYPs0G/K9/Cy2IuNdZmTYLT5cv8NRHaVPX6OIfuy4psFCXhs4efXYbbFH7sFwJGsd5sTq3E1e82ioRrtWAsLlbs8W+heqwr7ALbUIjduvlywMB0zq4AkXEOlVK2JU3BkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvStZpnm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvStZpnm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA84C4CEE8;
	Thu, 27 Feb 2025 20:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740686939;
	bh=wcBZY8yZuO9n0zckgdU2YhS52/cGCxhb6UEjLocmPAU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mvStZpnmWLdpnAzg7gKEnkncy9UgjOfFmom0cfmz38Fq+I1PZPTR18F2oD9no6lgN
	 VH14PdcCYGKSJpB27PrLdS7vGQImUjDI13SRTiWfvab+g/sZkif5sogzT0kUHRyrdf
	 AyiVDSIMlZfNNJHZPzhaPr6mKR0gGvToDtp3ZrwXjIt6BaQRrJ134kf/3+bkdWj/ZD
	 UjtdKY6GLQctjlNanYPoglQG5xrULXqnFVobyjiXz0nR0ZEvT1b5NIOXP/Wd4D5pBw
	 GCGVthHjqEIYMGwWPV70LyZqFCN+M/h4ZeoICAem6v7spFLaJJLbe9k4WX+GsRrGtj
	 ObqrPBb89l6sA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 27 Feb 2025 21:08:48 +0100
Subject: [PATCH mptcp-next 1/7] mptcp: pm: remove '_nl' from
 mptcp_pm_nl_addr_send_ack
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-mptcp-pm-reorg-code-v1-1-cb4677096709@kernel.org>
References: <20250227-mptcp-pm-reorg-code-v1-0-cb4677096709@kernel.org>
In-Reply-To: <20250227-mptcp-pm-reorg-code-v1-0-cb4677096709@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3935; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=wcBZY8yZuO9n0zckgdU2YhS52/cGCxhb6UEjLocmPAU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnwMZYG8hHktuYMHr+mgRPC6afOASYTaH7ZjdFo
 /YaIpv9hBiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8DGWAAKCRD2t4JPQmmg
 c8Z+D/9M96vTQZBFx/F7FHT0XWy0v5cgsV9TgIraxq0/9WTcvw1OHpPfefPqJxKNWdQTqhfM4cK
 a6moHy/9u1VOcJ7ZSGqzyzCsBBXpG60BYVyaNpQzhBEHUZZy3pPzzO2U/JqTPl5e3E27T7kjCho
 bLEmVAwJCAMgkTaqndCKv3OzbI0h6OdJOWV88a0A7WlmvbL0bJXthDQUgaALCEG0FPU6OdRCIyw
 hP6AE6JRd05L8CN0+ufDV8RYsERaJCQuxpeUCuSGfzxMVa7EI8dvEfPE5VPFBm7gjJs/owJpbcw
 uf5snWOduj4QxvmMdgzuU/JucA8UTfMgJS0lKTxnM7lbJ0vkneEu8mCNukULW3t1OFiD+XAgwNT
 rWrRyNUZPaE8p1z4Z1Fw+DVTqCAMVsy1NYwcwcdm1UQVgJr4tT4CkEL7qWu6mSR2LTOICgS1+GR
 eOZJmRrqzWm64XpokAycveyd5DltrtXM1LrlfvZ2jVfOlUeolcqXQwlArL+ZVf2gRcbRugn6I9W
 82Y8q3x2HsOlXX8wB8T7q5AMXWJ7G1L+o2nDTa4zFS8qONUDEz8jQQQL6JP2nxzWPfZKtGkv4R8
 qmVq8QZZuE9w/DUooUuSdxoizGJVmVy5oN3KQS8YmyKr5Zo5jutk7wPJMLEP0RJxV3QbC0E5ViA
 u8Jre9j5FBxHPIA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Currently, in-kernel PM specific helpers are prefixed with
'mptcp_pm_nl_'. But here 'mptcp_pm_nl_addr_send_ack()' is not specific
to this PM: it is used by both the in-kernel and userspace PMs.

To avoid confusions, the '_nl' bit has been removed from the name.

No behavioural changes intended.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c           | 2 +-
 net/mptcp/pm_netlink.c   | 8 ++++----
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.h     | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index f6030ce04efdf20b512b3445fb909b4dec386b1a..ece706e8ed22bfd10249f6e655a0d790dcee34c1 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -57,7 +57,7 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 	msk->pm.rm_list_tx = *rm_list;
 	rm_addr |= BIT(MPTCP_RM_ADDR_SIGNAL);
 	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
-	mptcp_pm_nl_addr_send_ack(msk);
+	mptcp_pm_addr_send_ack(msk);
 	return 0;
 }
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 23c28e37ab8f1befb391894e465635ee523d54ed..a70a688eae845c562c03caa0f3e20169c5f5be11 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -606,7 +606,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			local.addr.id = 0;
 
 		mptcp_pm_announce_addr(msk, &local.addr, false);
-		mptcp_pm_nl_addr_send_ack(msk);
+		mptcp_pm_addr_send_ack(msk);
 
 		if (local.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
 			signal_and_subflow = true;
@@ -740,7 +740,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 
 	remote = msk->pm.remote;
 	mptcp_pm_announce_addr(msk, &remote, true);
-	mptcp_pm_nl_addr_send_ack(msk);
+	mptcp_pm_addr_send_ack(msk);
 
 	if (lookup_subflow_by_daddr(&msk->conn_list, &remote))
 		return;
@@ -781,7 +781,7 @@ bool mptcp_pm_nl_is_init_remote_addr(struct mptcp_sock *msk,
 	return mptcp_addresses_equal(&mpc_remote, remote, remote->port);
 }
 
-void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
+void mptcp_pm_addr_send_ack(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow, *alt = NULL;
 
@@ -942,7 +942,7 @@ void mptcp_pm_nl_work(struct mptcp_sock *msk)
 	}
 	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_SEND_ACK)) {
 		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_SEND_ACK);
-		mptcp_pm_nl_addr_send_ack(msk);
+		mptcp_pm_addr_send_ack(msk);
 	}
 	if (pm->status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
 		pm->status &= ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 5b3ee43130be6de9d1b74f60088b508bb5f57d52..fbb29a9eb19125ea29f557e97123488689bfb3ce 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -235,7 +235,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
-		mptcp_pm_nl_addr_send_ack(msk);
+		mptcp_pm_addr_send_ack(msk);
 	}
 
 	spin_unlock_bh(&msk->pm.lock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ef1d43406f9bd87f2ea0c7d31f4ef9ea4d9ea9c6..b8800fd208429df43869c40e5f67f110d9584332 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1013,7 +1013,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
 bool mptcp_pm_nl_is_init_remote_addr(struct mptcp_sock *msk,
 				     const struct mptcp_addr_info *remote);
-void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk);
+void mptcp_pm_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 			       const struct mptcp_rm_list *rm_list);
 void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);

-- 
2.47.1

