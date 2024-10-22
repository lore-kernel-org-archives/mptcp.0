Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D77A17B51B
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 09:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588512; cv=none; b=Q5LqfoAQJY54qJhhQwTvErLBKNY0/Iu6SWOHF1F956MWhK7DxLx629K1dlJncHi8gHcKqvYRh0GK+2CSP8N7Oet3kybqkdA4nP8VAvuwqblst6zFQCOFO0/W7Bj5BsXv2uSCCKqoyXkwxAvpM+sBWXEl+woZyTyFXxeQVE1B0sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588512; c=relaxed/simple;
	bh=1AvdtcvvuO07UPxN3er3DWNvs9MG0wXiVbQrAiF0U6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ayFxb4E11YwGwQ9iwkHy/yLGSIyS+Yifz+oOY5Ltq15jGQm9AUrSAy3MY3hre09UxVMBAFaryPg8qyv5R/gOx25kPlzEJVdgZ6z0uoBzeksNCLVVspNOObyy/FWDViZ89Aj3ILtYudaWlupZoVuOaQBUpgXQktYI2KRX1QLk/zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLvZquDx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLvZquDx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41360C4CEE4;
	Tue, 22 Oct 2024 09:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588512;
	bh=1AvdtcvvuO07UPxN3er3DWNvs9MG0wXiVbQrAiF0U6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jLvZquDx8Ju2v/2Wi2bhjh9yXUjTX4l1OxOAUpGBC3hNCq4dyQ8v2u0ikTLOZZnue
	 xlTJV6u7foKFN8NPg6dlxnLLW6uzcguHyk1bDXppvlOEdt6Jn/SliXvAREYzuuTld/
	 qRa58+nidDbWTENxnkBY8GRs08ZeO2UkOkR0qMhTxcVl6j5hgMh4GfMjF4s756qsF8
	 mr3+jrwHj59Wufs9WNt3Kp8zYX8/70XYVWTeWUClFMAMlhhafFEwxM/GxNce6sK+Am
	 6IFL6ZA/oMgBPRCla2zZcctaqmRCRjNACeONxoLKJvj7XzzQlDVARYCqwhgMSqMHzi
	 Cc+yi8swNup7Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 12/36] mptcp: change info of get_addr as const
Date: Tue, 22 Oct 2024 17:14:20 +0800
Message-ID: <c099997f32d07dbd2c9db09a392cf6868f397f97.1729588019.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729588019.git.tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

get_addr() interfeces will be invoked by dump_addr(), which using const
parameters "info", so this patch changes "info" parameters of get_addr()
as const too.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 9 ++++++---
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.h     | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 064fe4d494eb..02e4dda0dc13 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1793,12 +1793,15 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 }
 
 static int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
-				struct genl_info *info)
+				const struct genl_info *info)
 {
-	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
+	struct net *net = genl_info_net(info);
 	struct mptcp_pm_addr_entry *entry;
+	struct pm_nl_pernet *pernet;
 	int ret = -EINVAL;
 
+	pernet = pm_nl_get_pernet(net);
+
 	spin_lock_bh(&pernet->lock);
 	entry = __lookup_addr_by_id(pernet, id);
 	if (entry) {
@@ -1811,7 +1814,7 @@ static int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 }
 
 static int mptcp_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
-			     struct genl_info *info)
+			     const struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
 		return mptcp_userspace_pm_get_addr(id, addr, info);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index dd2ecc9ee6d5..c10794154187 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -633,7 +633,7 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 }
 
 int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
-				struct genl_info *info)
+				const struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ffc18646976b..8282a6355765 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1129,7 +1129,7 @@ bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
 int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
-				struct genl_info *info);
+				const struct genl_info *info);
 
 static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
 {
-- 
2.45.2

