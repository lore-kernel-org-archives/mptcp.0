Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B8E1758E
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 07:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708069362; cv=none; b=L80LlFNj/FPB/s7tJGWVMODhuZ+2bX0Wb/i0m7yuy3Hrn2iI5GPUrCAa10Grc2N54He6y7M2mPtGme6rK8bo5YaPxjDAcP9D4PDZUE0HJ9FEtQkfDNBku1hYOWaXN/qGxM1r5nCGzgzWCTzVfOXWDu1sALao9ssMyuCZ0NVNfdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708069362; c=relaxed/simple;
	bh=3Dzyj8Auqc8MAQNrbY8jIm2roj4GjGiibpUK1X4uztM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LrvCkQ0zjsFvQTfTWrUBKan/Bq+b/cGcrXOF6PnfuA+k2L25IHz7Ftaz1saAAXyTNfFrc75n75FgMmrjKO75WPwfOFGIM8t4Gb6+JrI8eRJ6s3eEoNmP9qWmtX51qOX/GnT2WOUFoW5elZVHqME+7FL5sLuu8vkt3EbZMnvcGvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqnEyDmk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqnEyDmk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5290C433F1;
	Fri, 16 Feb 2024 07:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708069362;
	bh=3Dzyj8Auqc8MAQNrbY8jIm2roj4GjGiibpUK1X4uztM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CqnEyDmk3qtvhgZxl3SpEGGiU/DzLOmUulO/8ECiJWuAUmK5OkFk0Pw6ba5PV9alR
	 Mu007e8XypnPK3yGDHEvMop1ZJRqoeyhKPq8y9AifB4TGpLdu2u4s6NrVO8SMTB3Yp
	 VjiuADZmwqMNTnbJQ1mrpJHcbi7Td+WJJG4R4Qe0fAeAF6ntb5L2DFelHqJuA+eb+x
	 XsTTdpZsLbakdveiqdm4QmG/Kg5ssaBQjczf9jk/nWgCn4aK7z3Ay+yCuuRoPWe1Uq
	 mQPF9a52rZ7HGL31IVyerynZT0H9WDgkhkkPxhRvfM+3SwLrGd7D/muq9wLyKcBg3S
	 ZBdvS1lVPdAOw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 10/14] mptcp: add userspace_pm_lookup_addr_by_id helper
Date: Fri, 16 Feb 2024 15:42:12 +0800
Message-Id: <f87d93d0f196078b6487aa4d82d91286e60f425a.1708069036.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708069036.git.tanggeliang@kylinos.cn>
References: <cover.1708069036.git.tanggeliang@kylinos.cn>
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
index 73ad286247f1..a9328f41f74c 100644
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
@@ -261,7 +268,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
-	struct mptcp_pm_addr_entry *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	LIST_HEAD(free_list);
@@ -298,13 +305,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
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

