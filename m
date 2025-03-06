Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C32120ADEE
	for <mptcp@lists.linux.dev>; Thu,  6 Mar 2025 11:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258925; cv=none; b=F5d+UoIgtUOn/SrhcjadPFivXqfw6uBtLGIhLHJQSIQvZbq4CVKdFEUc7/lJzqWQMTxMKHxXWfoHfSBinRXyaRWwnYDCeJ760NSmMh9820sY0AwrEPXH8DggHrI4l+zC6PoHScQAuIuD3I9V5OX96CLiXCarxByHsO3fHWoPEuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258925; c=relaxed/simple;
	bh=9x4F27dZIYxd/heppiad/FpicRUMu5wlNlDJCMBEgG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PROVI2Ii3Lt+lbr2m5bMP4W2WC2Yv6q2lwo9VL4Gfo1aSdFZMCUjUUf4NcDn5iz/cdBCADCf6wwuSRVbZYo3T0fk0ozrZc/ybZUi2W5eMWQFqfZ9zZB+SWnEa69pxndEeGZ66cCclr3mIFXKGVU6OIdf0OOzqkRqvOTYYndUGdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sEQtqE4S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEQtqE4S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE3FC4CEE0;
	Thu,  6 Mar 2025 11:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741258924;
	bh=9x4F27dZIYxd/heppiad/FpicRUMu5wlNlDJCMBEgG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sEQtqE4Srw6h8EMYjyp41OoHxZ3XkkYKFDW0T7SGxsNaqnRjQ6fgsVLejz/QmCua0
	 IdWWvjO4OeL6TMZ9vI0Ils57xqbotImBbaBOWyx5+x/qhZ4DKxkBKUeFYwo3prIodB
	 7nKEFx05/w9EseFgwMbtyFQ7X7tfHNApG0W+naL8RL8pvvO2vPTQpegaA81VySHRVb
	 6ghT+i+WM3gRGgoeH5uoUtZnqHokhh4377+2C0IZ79SeE3KfYuFVGNmRjJJOz3RoPA
	 DnfdyP9HOr/YCod1TTY7xQEmdbtKOwsvfRQdsIhFzTKK/ZmXnCaxlWpecMBmOYLKyY
	 /52sx5vvhCG8g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 07/12] mptcp: pm: add get_priority() interface
Date: Thu,  6 Mar 2025 19:01:42 +0800
Message-ID: <a621ea076e34460d863ed51f82324ea26caec274.1741258415.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741258415.git.tanggeliang@kylinos.cn>
References: <cover.1741258415.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds get_priority() interface for struct mptcp_sched_ops,
then mptcp_pm_is_backup() can directly invoke get_priority() interface
through "ops" of "msk->pm". Instead of using mptcp_pm_is_userspace()
to check which is_backup() helper to invoke.

Rename
	mptcp_pm_nl_is_backup()/mptcp_userspace_pm_is_backup()
to
	mptcp_pm_kernel_get_priority()/mptcp_pm_userspace_get_priority()

and make them static.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h      | 2 ++
 net/mptcp/pm.c           | 5 +----
 net/mptcp/pm_kernel.c    | 4 +++-
 net/mptcp/pm_userspace.c | 5 +++--
 net/mptcp/protocol.h     | 2 --
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 169e19440b03..b344b909e749 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -118,6 +118,8 @@ struct mptcp_sched_ops {
 struct mptcp_pm_ops {
 	int (*get_local_id)(struct mptcp_sock *msk,
 			    struct mptcp_pm_addr_entry *skc);
+	bool (*get_priority)(struct mptcp_sock *msk,
+			     struct mptcp_addr_info *skc);
 
 	char			name[MPTCP_PM_NAME_MAX];
 	struct module		*owner;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d2dfd91cab46..29bc903658f7 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -881,10 +881,7 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
 
 	mptcp_local_address((struct sock_common *)skc, &skc_local);
 
-	if (mptcp_pm_is_userspace(msk))
-		return mptcp_userspace_pm_is_backup(msk, &skc_local);
-
-	return mptcp_pm_nl_is_backup(msk, &skc_local);
+	return msk->pm.ops->get_priority(msk, &skc_local);
 }
 
 static void mptcp_pm_subflows_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index a67e94c02c64..9fc140d8fe26 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -722,7 +722,8 @@ static int mptcp_pm_kernel_get_local_id(struct mptcp_sock *msk,
 	return ret;
 }
 
-bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
+static bool mptcp_pm_kernel_get_priority(struct mptcp_sock *msk,
+					 struct mptcp_addr_info *skc)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct mptcp_pm_addr_entry *entry;
@@ -1418,6 +1419,7 @@ static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
 
 struct mptcp_pm_ops mptcp_pm_kernel = {
 	.get_local_id		= mptcp_pm_kernel_get_local_id,
+	.get_priority		= mptcp_pm_kernel_get_priority,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 81ddc14bc273..7fc19b844384 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -145,8 +145,8 @@ static int mptcp_pm_userspace_get_local_id(struct mptcp_sock *msk,
 	return mptcp_userspace_pm_append_new_local_addr(msk, skc, true);
 }
 
-bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
-				  struct mptcp_addr_info *skc)
+static bool mptcp_pm_userspace_get_priority(struct mptcp_sock *msk,
+					    struct mptcp_addr_info *skc)
 {
 	struct mptcp_pm_addr_entry *entry;
 	bool backup;
@@ -690,6 +690,7 @@ static void mptcp_pm_userspace_release(struct mptcp_sock *msk)
 
 static struct mptcp_pm_ops mptcp_pm_userspace = {
 	.get_local_id		= mptcp_pm_userspace_get_local_id,
+	.get_priority		= mptcp_pm_userspace_get_priority,
 	.release		= mptcp_pm_userspace_release,
 	.name			= "userspace",
 	.owner			= THIS_MODULE,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6cae1ae5e9be..d26e89d960a1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1138,8 +1138,6 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
-bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
-bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
-- 
2.43.0

