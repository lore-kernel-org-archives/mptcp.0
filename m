Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0357FEC5
	for <mptcp@lists.linux.dev>; Tue, 11 Mar 2025 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741685570; cv=none; b=WEgGFPDUkDsl/A3UZkKCW5GvoDwr042UW0j874ybVuH9qTc4XFrg7rKyVDwNrLHeg5mmS6G0M3Nq9tbc+e1S+NKh8hBsbFjSLnEMwxNLqRjuBIOV/NOzHYSVJlE4PK8E+b7G3zIfNJQYy2+CE3jobnVmZqL5RovF+e3F+oJoMMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741685570; c=relaxed/simple;
	bh=owqOVHrz6Ogp+jNLPYPysEfXC2W1jPgjdXewukJmIgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G33FYgG5c6vWuIfry+nPX7nMBR2fo11Y2KKSncKKh8M0vpdpvb9Xo0XbwS5FANE1nu7Dfk3DmybiHY/yM/42cpLTn3uG0FEJ+yWkCvOjriAn+A9rzwh7+esTSIDenVEzZ8MUC5PsU7j+ySJqM+LLVXJoJb3CUZELwcRkZOpvFRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOf313hH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOf313hH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62267C4CEEB;
	Tue, 11 Mar 2025 09:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741685569;
	bh=owqOVHrz6Ogp+jNLPYPysEfXC2W1jPgjdXewukJmIgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WOf313hHXjq0YbAW9AhWWdsL3+KRLe1XnnScr6+i+LEjAr0P01ukbIjUVPioJyulW
	 ISVxxuZk30Mb9JyxqcmM5XXMN48bG4Pa79fn07TT4UjCdy3Xh7peVLpdARErsPIna1
	 F7kNq6pKw1SKBXfihaeOc634xV3xxAcjWxpUSrGhyLirlo0BtzxRUZzukFwHXSc8k4
	 iZX1+apEbctccRm0MJrsPWFpcoDV6pR3ZHrFfeLLuhVGqLM9/KCND15FiKn+mxx8Nf
	 J6cCnOQDFIb0z5IsueK9mwjIgTiUDEh54tUAtLFk179cRuvYCvi4xfPjfqEji8teAm
	 4fHZvPODLIL6Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 6/6] mptcp: pm: add subflow_established() interface
Date: Tue, 11 Mar 2025 17:32:30 +0800
Message-ID: <5251f022f18eef85a4ddf848cde344dddbb09b99.1741685260.git.tanggeliang@kylinos.cn>
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

This patch adds a .subflow_established interface for struct mptcp_pm_ops,
and calls pm->ops->subflow_established in from mptcp_pm_worker(). Then
get rid of the corresponding code from __mptcp_pm_kernel_worker().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h   | 1 +
 net/mptcp/pm.c        | 5 +++++
 net/mptcp/pm_kernel.c | 7 ++-----
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 1d69a0fbb032..88e0de990578 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -132,6 +132,7 @@ struct mptcp_pm_ops {
 			      const struct mptcp_addr_info *addr);
 
 	void (*established)(struct mptcp_sock *msk);
+	void (*subflow_established)(struct mptcp_sock *msk);
 
 	char			name[MPTCP_PM_NAME_MAX];
 	struct module		*owner;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index dc3ab2fa987f..57b32232137e 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -908,6 +908,11 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 		if (pm->ops->established)
 			pm->ops->established(msk);
 	}
+	if (pm->status & BIT(MPTCP_PM_SUBFLOW_ESTABLISHED)) {
+		pm->status &= ~BIT(MPTCP_PM_SUBFLOW_ESTABLISHED);
+		if (msk->pm.ops->subflow_established)
+			msk->pm.ops->subflow_established(msk);
+	}
 	__mptcp_pm_kernel_worker(msk);
 
 	spin_unlock_bh(&msk->pm.lock);
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 5c8764db3805..67f30d7c8080 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -372,7 +372,7 @@ static void mptcp_pm_kernel_established(struct mptcp_sock *msk)
 	mptcp_pm_create_subflow_or_signal_addr(msk);
 }
 
-static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
+static void mptcp_pm_kernel_subflow_established(struct mptcp_sock *msk)
 {
 	mptcp_pm_create_subflow_or_signal_addr(msk);
 }
@@ -1348,10 +1348,6 @@ void __mptcp_pm_kernel_worker(struct mptcp_sock *msk)
 		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
 		mptcp_pm_nl_add_addr_received(msk);
 	}
-	if (pm->status & BIT(MPTCP_PM_SUBFLOW_ESTABLISHED)) {
-		pm->status &= ~BIT(MPTCP_PM_SUBFLOW_ESTABLISHED);
-		mptcp_pm_nl_subflow_established(msk);
-	}
 }
 
 static int __net_init pm_nl_init_net(struct net *net)
@@ -1479,6 +1475,7 @@ struct mptcp_pm_ops mptcp_pm_kernel = {
 	.subflow_check_next	= mptcp_pm_kernel_subflow_check_next,
 	.add_addr_echo		= mptcp_pm_kernel_add_addr_echo,
 	.established		= mptcp_pm_kernel_established,
+	.subflow_established	= mptcp_pm_kernel_subflow_established,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
-- 
2.43.0

