Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EAC22D4E9
	for <mptcp@lists.linux.dev>; Wed,  5 Mar 2025 11:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741172416; cv=none; b=WVEitSfv9LtVnL8oqWkOGihVwRwgjXmZH7oj+CTbO5ZAfdhlayOHBzNtcbUIrfB8TmljwXkSu9ax3Q4NGhCnoTLH6fztBZvRCY1Ir4QS3bjzagumGsQZzYF2FA7IkciQ/aPRYoZHbnzG8/cHe9MtnvNJ5r5J2TZEQ6GVg9DHrE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741172416; c=relaxed/simple;
	bh=ZrXeFgbX3fXImDOUNOR58o7loCEylvGDwXnHrWJ7uXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IM/+2jDGpLV9lbn/jMLZWUd5hBGwj9ENELAcjE/DB3UgXa/TtjgF/dneCnbs7FrjsR8+nN6yKfD5PR3k4sHArJZBEaGTO6OmsfGaHk2STq3lx5hQopt2AdIlZRnEHgTLZvdP5Mypdwd6mni1LvLeVhNeUoSuhLjKHdkLQlVzCBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2YgUOOi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2YgUOOi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D23DC4CEE8;
	Wed,  5 Mar 2025 11:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741172416;
	bh=ZrXeFgbX3fXImDOUNOR58o7loCEylvGDwXnHrWJ7uXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k2YgUOOizZiY46fbxESml2EliYb5loV2QKo0AIftT/LkjdOQfGLEBcKj11ylmbeSZ
	 yDlb92HPYyaySaCE3jIBCIM3qez3QrDXWGutQa9PVYUkdfKWP8uZ1vjAhcWDMAIVyO
	 ZuM0NfWrZrDzYPdz5ciYpixFylW1TgcowYrIybUnfCwbJ61ZRIGtXGsHxrxs5XkBFN
	 q4vWwLu1HoXl85iT1o9KYzOKIrGpY3re5lqYZXKTL2KS5ro0UuLkSEEwDY5OZaA8/7
	 E1Okfm9pzf9pLbqNMwqPvJ5BZ8m7psr05O388huKysXjg76Stcc92QLBmwtAIsWk4H
	 GTLM64yFTB7zA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 07/12] mptcp: pm: userspace: register mptcp_pm_userspace
Date: Wed,  5 Mar 2025 18:59:48 +0800
Message-ID: <3bdd767731ec0cbf909bbd0e0882bfd851814fb1.1741171898.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741171898.git.tanggeliang@kylinos.cn>
References: <cover.1741171898.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch defines the original userspace path manager as a new
struct mptcp_pm_ops named "mptcp_userspace_pm", and register it
in mptcp_pm_init(). mptcp_pm_userspace_is_release() is a wrapper
of mptcp_userspace_pm_free_local_addr_list().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           |  1 +
 net/mptcp/pm_userspace.c | 26 ++++++++++++++++++++++++++
 net/mptcp/protocol.h     |  1 +
 3 files changed, 28 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 28ea8bdaa8b0..5018ed3c575f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1028,6 +1028,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 void __init mptcp_pm_init(void)
 {
 	mptcp_pm_kernel_register();
+	mptcp_pm_userspace_register();
 	mptcp_pm_nl_init();
 }
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 13856df22673..dedff896346f 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -682,3 +682,29 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 	sock_put(sk);
 	return ret;
 }
+
+static void mptcp_pm_userspace_init(struct mptcp_sock *msk)
+{
+	struct mptcp_pm_data *pm = &msk->pm;
+
+	WRITE_ONCE(pm->work_pending, 0);
+	WRITE_ONCE(pm->accept_addr, 0);
+	WRITE_ONCE(pm->accept_subflow, 0);
+}
+
+static void mptcp_pm_userspace_release(struct mptcp_sock *msk)
+{
+	mptcp_userspace_pm_free_local_addr_list(msk);
+}
+
+static struct mptcp_pm_ops mptcp_pm_userspace = {
+	.init			= mptcp_pm_userspace_init,
+	.release		= mptcp_pm_userspace_release,
+	.name			= "userspace",
+	.owner			= THIS_MODULE,
+};
+
+void __init mptcp_pm_userspace_register(void)
+{
+	mptcp_pm_register(&mptcp_pm_userspace);
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f700cb55bf49..658bc60d4cd8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1162,6 +1162,7 @@ static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflo
 }
 
 void __init mptcp_pm_kernel_register(void);
+void __init mptcp_pm_userspace_register(void);
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_worker(struct mptcp_sock *msk);
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
-- 
2.43.0

