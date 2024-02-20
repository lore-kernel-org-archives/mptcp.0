Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ABF60881
	for <mptcp@lists.linux.dev>; Tue, 20 Feb 2024 09:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423127; cv=none; b=J+RyzT9Q5vmdnjkFWgm2BGQo+g93il4GnTOMLIBfTShkoq3bwI4Dm3pGbwrjkQ+IpQenTxdYjijl7SoFIHWM46P1Empahg6dQ3ubOEjD2H+f6NROxNGl6sVlrdti9sHoKoMdGOfp7jYx1MqpCJ5g9SOjdvjM8sq/FtOiJmYWr00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423127; c=relaxed/simple;
	bh=rCkzK1w01pi1hSJ4QbcUrIR1ioJhFbsheex9OtGa6Ds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tn4jHOutzI+JdH8QqOYjrkQdmKf7b730VRh2jRc+nErub4GAmetJl7b5OuZX6piOyB+IChWIUezExmVmQ79chTPtpNRpKip6ZZC+DCE8iB/dUqK7Obdjd0kDHJkKhwt2ToKJhTK5ci7heutHGjb5JYZKGTlcr91yWIlwMccsnwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aev0fNEE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aev0fNEE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B46AC433F1;
	Tue, 20 Feb 2024 09:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708423127;
	bh=rCkzK1w01pi1hSJ4QbcUrIR1ioJhFbsheex9OtGa6Ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aev0fNEElANe+Pu7DRNOcv1BV2vb/9wgfWMvKPIGe07Wy1TsGeP9rJY/1HMmkIvYf
	 ydBjjrfOOZSLji2C9MXVx3UUBGQRxIKw6DpqJsbOsOHGeVU3LiwQQFyE7vPr/02nAV
	 A0SdDwh0OYc9SPltmTrQwSTA/McC3+NLxKF/kl3KU1NK1Es6E5+rR/Pp6nNZFTeAHA
	 eZy7raU24g4ebJ2nPr6f9SvYDjnfC+5PoA2etN2qZqB0WtD7jJ+3lSgX4TReCCBmO+
	 oA2uIJfko9W3/UX4gmiz9hJ989FQ8c3kHlCRV34oaOScM4FsGqUq0jnoH0/qaWQtOB
	 fZnZVcT8Moxzg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 10/14] mptcp: add userspace_pm_lookup_addr_by_id helper
Date: Tue, 20 Feb 2024 17:58:24 +0800
Message-Id: <5c361b0bd150cb41f9c6a8fe0339be5cd022aa15.1708422758.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708422758.git.tanggeliang@kylinos.cn>
References: <cover.1708422758.git.tanggeliang@kylinos.cn>
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
index 3bd13e94b568..20cbcb62cd8c 100644
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

