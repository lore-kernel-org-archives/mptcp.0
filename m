Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF401E2312
	for <mptcp@lists.linux.dev>; Tue, 11 Mar 2025 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741685568; cv=none; b=EplSnv3bbX2gJ+sD4meyXR7lnwH6RgtSRmk2jHuf2KxPHYQcHJ3aIh5k8WloYlKX/mc0eJDaeW6f3y3nbCmlyizU8pTQ9ZE6erXWT/flxqpGzIIZLU4S6O1QN8YqNCDaF0fdOHfV7/XlEVI+40hsuB0a5m/fuJhlzf4Zn5hpqCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741685568; c=relaxed/simple;
	bh=QnWx9k2peACy3hLVXFAZjMdXZuJwUA4nRAr9bZbHJgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GvZqhlVQbCQU8l3zq4yUhNIeOgPaOuwU6c7oBDIr56JMTFZeZsRaTIRpWon2MVNWkThdo8YP36FzUAekQEksRhd14dNe4pZVxrmZBvioJzADYwBOXGU63RUznBzlzGTWPTPOCek/a+78rxhqeX5qqpYIUmu/qbmJKM2KuO1Whl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUKjJhi7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUKjJhi7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12AAC4CEE9;
	Tue, 11 Mar 2025 09:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741685567;
	bh=QnWx9k2peACy3hLVXFAZjMdXZuJwUA4nRAr9bZbHJgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gUKjJhi7gXoF/ldI2eUmzCks/Psn/9zHcubSVAt7rvq7TWNLTvpRK3yuYLOqWX6jM
	 MGTm6cmTm58oKng2yWQIUhS69r1QejF2qc91WDhxHA69cM54CnLVOAMiOv/Wmd9B7P
	 YdNMv3g19+a4x3/NcUt/wbDHHdJR8OrcJPMnVqlaPm2k5UWFEzp7GZPQQYD5MphgnJ
	 gkoSGobBr/1exVD87aNj8l/6EuZjXGujdXwO1t1T2NqghZ7xqV5aBoE0ihUQ6CH5On
	 r8rzOapnwUHZBX4aoxqObTzLBrAJ/OFtb7a33/5IMjzxknkUNaPCelrJdpQrvsgp37
	 7i6aLRE3iv1Zg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 5/6] mptcp: pm: add established() interface
Date: Tue, 11 Mar 2025 17:32:29 +0800
Message-ID: <7b91f66e9fcd99e1e7b10bfead7bc01bdcda114a.1741685260.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741685260.git.tanggeliang@kylinos.cn>
References: <cover.1741685260.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a .established interface for struct mptcp_pm_ops, and
calls pm->ops->established in from mptcp_pm_worker(). Then get rid of
the corresponding code from __mptcp_pm_kernel_worker().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h   | 2 ++
 net/mptcp/pm.c        | 5 +++++
 net/mptcp/pm_kernel.c | 7 ++-----
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 1f4d0d3988c1..1d69a0fbb032 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -131,6 +131,8 @@ struct mptcp_pm_ops {
 	void (*add_addr_echo)(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
 
+	void (*established)(struct mptcp_sock *msk);
+
 	char			name[MPTCP_PM_NAME_MAX];
 	struct module		*owner;
 	struct list_head	list;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index dc7ab696c24b..dc3ab2fa987f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -903,6 +903,11 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 		pm->status &= ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
 		mptcp_pm_rm_addr_recv(msk);
 	}
+	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
+		pm->status &= ~BIT(MPTCP_PM_ESTABLISHED);
+		if (pm->ops->established)
+			pm->ops->established(msk);
+	}
 	__mptcp_pm_kernel_worker(msk);
 
 	spin_unlock_bh(&msk->pm.lock);
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index d5002236fe6e..5c8764db3805 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -367,7 +367,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	mptcp_pm_nl_check_work_pending(msk);
 }
 
-static void mptcp_pm_nl_fully_established(struct mptcp_sock *msk)
+static void mptcp_pm_kernel_established(struct mptcp_sock *msk)
 {
 	mptcp_pm_create_subflow_or_signal_addr(msk);
 }
@@ -1348,10 +1348,6 @@ void __mptcp_pm_kernel_worker(struct mptcp_sock *msk)
 		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
 		mptcp_pm_nl_add_addr_received(msk);
 	}
-	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
-		pm->status &= ~BIT(MPTCP_PM_ESTABLISHED);
-		mptcp_pm_nl_fully_established(msk);
-	}
 	if (pm->status & BIT(MPTCP_PM_SUBFLOW_ESTABLISHED)) {
 		pm->status &= ~BIT(MPTCP_PM_SUBFLOW_ESTABLISHED);
 		mptcp_pm_nl_subflow_established(msk);
@@ -1482,6 +1478,7 @@ struct mptcp_pm_ops mptcp_pm_kernel = {
 	.accept_new_subflow	= mptcp_pm_kernel_accept_new_subflow,
 	.subflow_check_next	= mptcp_pm_kernel_subflow_check_next,
 	.add_addr_echo		= mptcp_pm_kernel_add_addr_echo,
+	.established		= mptcp_pm_kernel_established,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
-- 
2.43.0

