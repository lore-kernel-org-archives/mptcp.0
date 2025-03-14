Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3332E3379
	for <mptcp@lists.linux.dev>; Fri, 14 Mar 2025 02:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741920349; cv=none; b=u0iUaVxiGxKMx1a/G3IJ+8fbITISGn3+DPyjKE85vzUx17kulQF+CDko/6gSRYaH93dV1Y5BQQwKGsfpoX4E5k99OG/GLF8Y+vD5nPZOAQCetWGAPYWs0Hk6wWxMBJbPBobEbUmo/D3Q/MaU3dTVmUHrnrXvOGb65VqAiQgO/SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741920349; c=relaxed/simple;
	bh=e6aDsMwhZ7jauxMmgnbg78UWu4GVVhFJ3Mq6QPfwqcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S68Uc5YhvDLRRSEuKeAUDRGPREi2ZEXmCiZsClhfJpgz61/owhbVdf+Fnmf6jftOSZb/9zrobLsMdYDENuykQlZzB2QGpS72UoYClbUEYUhbah+WE3vqAbtQtjqDfxYkIE2cD4il/Yr1n/i9nUAB79qkKXBK0lVmRubpOLmvEOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmFVEXkN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmFVEXkN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BF0C4CEDD;
	Fri, 14 Mar 2025 02:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741920348;
	bh=e6aDsMwhZ7jauxMmgnbg78UWu4GVVhFJ3Mq6QPfwqcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kmFVEXkNbJAk+3M0DTZV4aByYOMV5SExFXDbhwt77IkQhH6EiFfvYnoNvbYlG9Rr5
	 XACme3zddWHkLwKchgA4BzUfXXiabXeOMG18Rm4gKtbD7I+ztlihpPgSEbGrBfHhiR
	 NlCMIvBzKiew0mWOW5qtvhtUwrQuON0IaDHLVC7aPZEaA4gQzYRVet2PBJOjjs/AfQ
	 cHI3udXi+Y5tkxDW//adCGIxZ+JR105r24MVOGGvzHuU25ONv8Q5kiZAChfUIM/wAM
	 /bPh2ZcFY9mY4lMn5N6z2hwwXv/5+8ShCHOzzFMmjZIXAf4KBHVnNVTsfBfuNd24M0
	 6IZ+sxsXlgS8g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 03/10] mptcp: pm: add established() interface
Date: Fri, 14 Mar 2025 10:45:24 +0800
Message-ID: <da3e6282c7d6f6f3b60b89123f533e863000eb06.1741919893.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1741919893.git.tanggeliang@kylinos.cn>
References: <cover.1741919893.git.tanggeliang@kylinos.cn>
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
 include/net/mptcp.h   | 3 +++
 net/mptcp/pm.c        | 7 ++++++-
 net/mptcp/pm_kernel.c | 7 ++-----
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 9f28ef550e10..d7410f08399e 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -124,6 +124,9 @@ struct mptcp_pm_ops {
 	bool (*get_priority)(struct mptcp_sock *msk,
 			     struct mptcp_addr_info *skc);
 
+	/* optional */
+	void (*established)(struct mptcp_sock *msk);
+
 	char			name[MPTCP_PM_NAME_MAX];
 	struct module		*owner;
 	struct list_head	list;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 4895318b94cc..3dcece1c6fef 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -516,7 +516,8 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk)
 	 * be sure to serve this event only once.
 	 */
 	if (READ_ONCE(pm->work_pending) &&
-	    !(pm->status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)))
+	    !(pm->status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)) &&
+	    pm->ops->established)
 		mptcp_pm_schedule_work(msk, MPTCP_PM_ESTABLISHED);
 
 	if ((pm->status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)) == 0)
@@ -964,6 +965,10 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 		pm->status &= ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
 		mptcp_pm_rm_addr_recv(msk);
 	}
+	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
+		pm->status &= ~BIT(MPTCP_PM_ESTABLISHED);
+		pm->ops->established(msk);
+	}
 	__mptcp_pm_kernel_worker(msk);
 
 	spin_unlock_bh(&msk->pm.lock);
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 7ec81d5195d4..1234066b5bcc 100644
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
@@ -1422,6 +1418,7 @@ static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
 struct mptcp_pm_ops mptcp_pm_kernel = {
 	.get_local_id		= mptcp_pm_kernel_get_local_id,
 	.get_priority		= mptcp_pm_kernel_get_priority,
+	.established		= mptcp_pm_kernel_established,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
-- 
2.45.2

