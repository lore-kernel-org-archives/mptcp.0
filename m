Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41E1C8EB
	for <mptcp@lists.linux.dev>; Thu, 27 Mar 2025 06:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743055480; cv=none; b=uuAagDifEQ7l0XxyCWsNTpdmB3/CY4klzKgBNyLktjgo0uKSvWqbr3m4fT4tZgcvxidhQ+M32Doo5PHq2sUUcyTKv0mmhbOqbmZD8aqrSI0si1s685/9fqZbbcD1TGDLuoCUHrKfb8KmalEGQ0m2ujlE8XqHdSRB+6uTT760PKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743055480; c=relaxed/simple;
	bh=PezlIydqHMyKTzPj0fB3iJjZXGhf6KD6xD9msyWxk4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3pEt11/r3S5a1k4JmtEHYLRWyaLCXTwmX/gnCzRQZnPNAmnKdOl6KGrCrLK35Wnt8ljThCh4njlBjuXr52ZSQq1HZZCKpFDimWTOOy01iL+7kjjbg+Bmn6eaYkwDV5WGkXoJh9bRyHc9p+L8EbWUo56niuOttmEEgH9cQzQrPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZG9MTSao; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZG9MTSao"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69C3C4CEE4;
	Thu, 27 Mar 2025 06:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743055480;
	bh=PezlIydqHMyKTzPj0fB3iJjZXGhf6KD6xD9msyWxk4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZG9MTSaoDXJ15I3LthrucQaKoO1HRnsBMGEZhosdcVj9eD9kY+BT32ijOPDioeYq1
	 mY4mn37/AQzLUfS0qVG2kpbzftpdYi+59hlgGCbvmE1hRGnp5M5z9Swb3BAVkwQmrZ
	 Z11fxoOJOVCRu0s0XtQveRRsVQWeFXekLgyqco91/nFA9DTf0l7Qs6CDJqFOh91JJK
	 PbkTkAokOEokzc+isHYRWUeZqnW+zakKe/820q4ZiNlWe0yQWZckEZnLfzdAHz7OSh
	 2psBF1sOeUPz6ddl7DXypmq3NU3yLNSpo/CryYv/W2GLx+iq9xKZm6uH6O5iAL7JbH
	 ppD8W95lazRZw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 6/7] mptcp: pm: add subflow_established() interface
Date: Thu, 27 Mar 2025 14:04:16 +0800
Message-ID: <5374c3b1640ce62ed454e5650ee166ae41134216.1743054942.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1743054942.git.tanggeliang@kylinos.cn>
References: <cover.1743054942.git.tanggeliang@kylinos.cn>
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

Since mptcp_pm_addr_send_ack() is a sleepable kfunc, which is invoked
by mptcp_pm_create_subflow_or_signal_addr(), .subflow_established()
interface of BPF PM should be invoked by __bpf_prog_enter_sleepable(),
which can't be invoked under a lock. This patch unlocks the pm lock
before invoking this interface in mptcp_pm_worker(), while holding this
lock in mptcp_pm_kernel_subflow_established().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h   |  1 +
 net/mptcp/pm.c        | 13 ++++++++++---
 net/mptcp/pm_kernel.c |  9 +++------
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 97a237c9bfe0..1eae68c9e662 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -127,6 +127,7 @@ struct mptcp_pm_ops {
 
 	/* optional, call from the msk context */
 	void (*established)(struct mptcp_sock *msk);
+	void (*subflow_established)(struct mptcp_sock *msk);
 
 	char			name[MPTCP_PM_NAME_MAX];
 	struct module		*owner;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 8dcf61a77b7d..39842f7786db 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -533,7 +533,7 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk)
 
 	pr_debug("msk=%p\n", msk);
 
-	if (!READ_ONCE(pm->work_pending))
+	if (!READ_ONCE(pm->work_pending) || !pm->ops->subflow_established)
 		return;
 
 	spin_lock_bh(&pm->lock);
@@ -560,7 +560,8 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 		return;
 	}
 
-	if (!READ_ONCE(pm->work_pending) && !update_subflows)
+	if (!pm->ops->subflow_established ||
+	    (!READ_ONCE(pm->work_pending) && !update_subflows))
 		return;
 
 	spin_lock_bh(&pm->lock);
@@ -618,7 +619,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 
 	pr_debug("msk=%p\n", msk);
 
-	if (!READ_ONCE(pm->work_pending))
+	if (!READ_ONCE(pm->work_pending) || !pm->ops->subflow_established)
 		return;
 
 	spin_lock_bh(&pm->lock);
@@ -963,6 +964,12 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 		spin_unlock_bh(&pm->lock);
 		pm->ops->established(msk);
 	}
+	if (status & BIT(MPTCP_PM_SUBFLOW_ESTABLISHED)) {
+		spin_lock_bh(&pm->lock);
+		pm->status &= ~BIT(MPTCP_PM_SUBFLOW_ESTABLISHED);
+		spin_unlock_bh(&pm->lock);
+		pm->ops->subflow_established(msk);
+	}
 	spin_lock_bh(&pm->lock);
 	__mptcp_pm_kernel_worker(msk);
 	spin_unlock_bh(&pm->lock);
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 5444565c8cf2..e37cee9d38d7 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -379,9 +379,9 @@ static void mptcp_pm_kernel_established(struct mptcp_sock *msk)
 	mptcp_pm_create_subflow_or_signal_addr(msk);
 }
 
-static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
+static void mptcp_pm_kernel_subflow_established(struct mptcp_sock *msk)
 {
-	__mptcp_pm_create_subflow_or_signal_addr(msk);
+	mptcp_pm_create_subflow_or_signal_addr(msk);
 }
 
 /* Fill all the local addresses into the array addrs[],
@@ -1355,10 +1355,6 @@ void __mptcp_pm_kernel_worker(struct mptcp_sock *msk)
 		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
 		mptcp_pm_nl_add_addr_received(msk);
 	}
-	if (pm->status & BIT(MPTCP_PM_SUBFLOW_ESTABLISHED)) {
-		pm->status &= ~BIT(MPTCP_PM_SUBFLOW_ESTABLISHED);
-		mptcp_pm_nl_subflow_established(msk);
-	}
 }
 
 static int __net_init pm_nl_init_net(struct net *net)
@@ -1451,6 +1447,7 @@ struct mptcp_pm_ops mptcp_pm_kernel = {
 	.get_priority		= mptcp_pm_kernel_get_priority,
 	.accept_new_subflow	= mptcp_pm_kernel_accept_new_subflow,
 	.established		= mptcp_pm_kernel_established,
+	.subflow_established	= mptcp_pm_kernel_subflow_established,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
-- 
2.43.0

