Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F94E8F40
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 06:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705558351; cv=none; b=bV2TGDrkkWAQzH+ZhvIf7nC3LFZkb/Ah1FurknGcvdrYe6QvkGKLiPi71LQRentO4ZF+dDz5L2PnDZ/uKZE4XEXEn9JND6Djxl1UlGrQQ4icLfZL5SXmClU9jVmKZ1bs0r+amMx2Nkb8PMxRoxB11lv4oYTMgWlgOpxPCLj07Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705558351; c=relaxed/simple;
	bh=9w6i/K4JXfNNU/2JdoJLlyE+spjQx4z8xVbbLIFwh54=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=Plg+8n+1QR8PIZGfpojKBucCrnKq7fwYtohVR4L+M0nJDm5mEPjE4o6vu5aGBIRsDS+gHBahzvWPXE7XCt9m0R2mIDWRYzpvFGLHJDo6BP5nB2PwWqUH0cGT+V9YX/jXzuxx83afUmj7keIhYeonV82/2wGNAhOeW7N+Uvx3JYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igcm2LeT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igcm2LeT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E34C43601;
	Thu, 18 Jan 2024 06:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705558350;
	bh=9w6i/K4JXfNNU/2JdoJLlyE+spjQx4z8xVbbLIFwh54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=igcm2LeTkk1fte0Cua+DzEeAqUr7DtW2SBqlAVQgo8BbxDg7QUjPDXcDEeQAa3Wxi
	 QMrErDVyKLftxwhxPUXwKtbeyynkCvq/V0NqnuS9m8EY9/mZb3B14o4i7K6jx01ORv
	 aNAVgJhiAwoiKtS+Em7r3QQaV2g3J3w68X34HL6V7xbtav4E0HI222B3WEzQXW0fYp
	 NNeQ4PzjYsxVUcnKam+Q86pIfkMMEyKYCSLh+mEOqEs93PIJnAivPf92mSiT+oJCsz
	 hB9dbRA3ATEyFt+JewCRWeomryQm2ri0RGo7RH8DPt2eSZ9iUl5zGhnvGppqF6dx6N
	 JrF5BSsynYO1A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 16/23] mptcp: add userspace_pm_lookup_addr_by_id helper
Date: Thu, 18 Jan 2024 14:11:56 +0800
Message-Id: <1b48e005d654f6e68a515eb3aa819bca58af09ff.1705558030.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1705558030.git.tanggeliang@kylinos.cn>
References: <cover.1705558030.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Corresponding __lookup_addr_by_id() helper in the in-kernel netlink PM,
this patch adds a new helper mptcp_userspace_pm_lookup_addr_by_id() to
lookup the address entry with the given id on the userspace pm local
address list.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index ca0d6e1dfade..d1457a443b78 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -106,19 +106,26 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 	return -EINVAL;
 }
 
+static struct mptcp_pm_addr_entry *
+mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (entry->addr.id == id)
+			return entry;
+	}
+	return NULL;
+}
+
 int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 						   unsigned int id,
 						   u8 *flags, int *ifindex)
 {
-	struct mptcp_pm_addr_entry *entry, *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (id == entry->addr.id) {
-			match = entry;
-			break;
-		}
-	}
+	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
 	spin_unlock_bh(&msk->pm.lock);
 	if (match) {
 		*flags = match->flags;
@@ -262,7 +269,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
-	struct mptcp_pm_addr_entry *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	LIST_HEAD(free_list);
@@ -299,13 +306,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	lock_sock(sk);
 
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (entry->addr.id == id_val) {
-			match = entry;
-			break;
-		}
-	}
-
+	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
 		release_sock(sk);
-- 
2.40.1

