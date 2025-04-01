Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D79192B90
	for <mptcp@lists.linux.dev>; Tue,  1 Apr 2025 04:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743481824; cv=none; b=ChbNeUQnQMppvvjv97mxRFugE5EtmTAILW07xW3C+NZAFmNT+c5bDfra+1scL9F6AvFUKcGvNZMsWZBO2CRYbPQHncSli8cuM1/mKNsxPzjVs5fBZ75pQqhZxI2TS5X6lN/K0BuWBBcoln7rNP0ZuU4VwO4cghZZuQA1arEuqGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743481824; c=relaxed/simple;
	bh=0H55XYBfV79m/8lkr7BOgXjl+euDKNILcGKOhbo8Mys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+YwU/kgR6xaAO+PAM8Psffc7KPWoUMaT8UV9JccN8VU79YEyI7wWUHGAHwkdPpX8T9QN5ReCJYHjAZPblNmuei9c1EFieJVfzPuHHjmr2AoYKIw4jR8wM6syiuDz23MnGtijLCqX9K3x9L1UmCMPVO41HwdyeOaJ/4oHyzR20Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evJthCy7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evJthCy7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F560C4CEE8;
	Tue,  1 Apr 2025 04:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743481824;
	bh=0H55XYBfV79m/8lkr7BOgXjl+euDKNILcGKOhbo8Mys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=evJthCy7mNLL0+X9nZeTwxydiEB7WVjZNdgIimSBO6WUf3R2HdsxDVcVS6S+3EHOm
	 Bw1Wuyc3BKV3A3ioqn2JA3+noqok/SFzpUDqwII9MZXN41vIvWBTQWD5wahtrsbQNh
	 7nSzYWJ+y1iLGgTZUZkaOVd87MX4V0z7S3Huh12yYv+Evaw6MX0t9heq5QVavXxEtu
	 mvjJj3QbjFVbZvPDq1rTS8XUL3BhWbFU9bZqT6cB5UgX9GJqeIieDR7Bf3NJ+Jhu/W
	 TfRhCZ51DLvQWDtp+lylrNGnpWr7zQN/R8yVWVvXD1PdC0buVEGPnLEgzDSfbJ6GUU
	 QbUq54sVV/qWQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 4/4] mptcp: pm: add rm_addr_received() interface
Date: Tue,  1 Apr 2025 12:30:11 +0800
Message-ID: <be8ebbd63c0e0b07c19040f1ba1312e12325f81a.1743481566.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1743481566.git.tanggeliang@kylinos.cn>
References: <cover.1743481566.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds an optional .rm_addr_received interface for struct
mptcp_pm_ops and invokes it in mptcp_pm_rm_addr_or_subflow().

This interface is only implemented in the in-kernel PM as a wrapper
of mptcp_pm_nl_rm_addr().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h   | 1 +
 net/mptcp/pm.c        | 4 ++--
 net/mptcp/pm_kernel.c | 3 ++-
 net/mptcp/protocol.h  | 1 -
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index d63d251932ac..6d4c9304157b 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -135,6 +135,7 @@ struct mptcp_pm_ops {
 
 	/* optional, call from the msk context */
 	void (*add_addr_received)(struct mptcp_sock *msk);
+	void (*rm_addr_received)(struct mptcp_sock *msk, u8 rm_id);
 
 	char			name[MPTCP_PM_NAME_MAX];
 	struct module		*owner;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 39d0ad715d26..07b144ccc9f8 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -690,8 +690,8 @@ static void mptcp_pm_rm_addr_or_subflow(struct mptcp_sock *msk,
 
 		if (rm_type == MPTCP_MIB_RMADDR) {
 			__MPTCP_INC_STATS(sock_net(sk), rm_type);
-			if (removed && mptcp_pm_is_kernel(msk))
-				mptcp_pm_nl_rm_addr(msk, rm_id);
+			if (removed && msk->pm.ops->rm_addr_received)
+				msk->pm.ops->rm_addr_received(msk, rm_id);
 		}
 	}
 }
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index dff880b030d1..b6c489a29c5d 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -500,7 +500,7 @@ static void mptcp_pm_kernel_add_addr_received(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 }
 
-void mptcp_pm_nl_rm_addr(struct mptcp_sock *msk, u8 rm_id)
+static void mptcp_pm_kernel_rm_addr_received(struct mptcp_sock *msk, u8 rm_id)
 {
 	if (rm_id && WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)) {
 		/* Note: if the subflow has been closed before, this
@@ -1438,6 +1438,7 @@ struct mptcp_pm_ops mptcp_pm_kernel = {
 	.subflow_established	= mptcp_pm_kernel_subflow_established,
 	.accept_new_address	= mptcp_pm_kernel_accept_new_address,
 	.add_addr_received	= mptcp_pm_kernel_add_addr_received,
+	.rm_addr_received	= mptcp_pm_kernel_rm_addr_received,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 128c081810d9..70addda39a5f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1026,7 +1026,6 @@ void mptcp_pm_send_ack(struct mptcp_sock *msk,
 		       struct mptcp_subflow_context *subflow,
 		       bool prio, bool backup);
 void __mptcp_pm_addr_send_ack(struct mptcp_sock *msk);
-void mptcp_pm_nl_rm_addr(struct mptcp_sock *msk, u8 rm_id);
 void mptcp_pm_rm_subflow(struct mptcp_sock *msk,
 			 const struct mptcp_rm_list *rm_list);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
-- 
2.43.0

