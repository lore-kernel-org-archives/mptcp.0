Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D801EFFB7
	for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047835; cv=none; b=OXVRnTJirWjhPJ/uNTjsq0jX4gUPhyDFH7bITyFoMXJtsdH1WoswsIKZ193w5Ymv5eBH9FsJ2k1VZwMZdhrhjVzntFIXQzp9xKLCcvo97ET92bH9PKjK+WhRkA2WML1youWej+dISYVVUwNCVz+ah1eHMake5d7hc5TbM4xdku8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047835; c=relaxed/simple;
	bh=PruhMdBdnPaoVGDJvDCLe7gHP2IK4zvgyVnqxB8CQS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m2aCbV0k74ReD0bgFq3RzUTg2Sok0IKxykEg+oAiw4F6Wg0i27zFYI62YpvK+9CaWIySmDK+4+4nrGSITRhYsXxQdrsrtIK+4jBSgDYTK7nE+arcIQdsqhxGppMlKCoZadDARijS8fTquKNtNpQ0GiebwhYY1qwkhbZ/CJhNVIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1NdcGT6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1NdcGT6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276D5C4CEE3;
	Thu, 20 Feb 2025 10:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740047834;
	bh=PruhMdBdnPaoVGDJvDCLe7gHP2IK4zvgyVnqxB8CQS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S1NdcGT6o/K3Ej8g2v9uJxZWPT2hImwHpyAHRePIVaXwQuDgGzytfFUM4TK1dVAp0
	 kPFtVu/ftNi3WKOHYxAiIlUXyrBz0oKNnsD6lIK5AVQ50vdR1n/ckUXHqT2EhDCyUG
	 algb4YEBR2PvkTo2sNUZuiUfk+I5ew/cNXPLiZynarIoN/J9GLi3nWF3jQ1zSZWxQF
	 Mg4nM/i5nqL3kOjDZMfwhPBp6PtzlspUVtkAXCefizQnb1/+xOecXq0kyRRiWNzpkG
	 41f3nayiiXQSA9o+8a1//i8lwRaNTOEdJKtWCLdwo0Ysjw3KqXiTFgV6BoHFVu2gG/
	 w73DNWbaDeV+Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 8/9] mptcp: pm: userspace: subflow_established interface
Date: Thu, 20 Feb 2025 18:36:57 +0800
Message-ID: <e726d784c4d20a619cf396b89893a4ae3993c4a2.1740047738.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740047738.git.tanggeliang@kylinos.cn>
References: <cover.1740047738.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Extract subflow_established() interface of the userspace PM from the
handler of netlink command MPTCP_PM_CMD_SUBFLOW_CREATE

        mptcp_pm_nl_subflow_create_doit(),

only leave the code for obtaining msk through "info", parsing local address
entry and parsing remote address info in the handler.

This interface is invoked under holding the msk socket lock.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 54 +++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 770d1c3e5c81..bd497893c927 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -369,12 +369,40 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+static int mptcp_userspace_pm_subflow_established(struct mptcp_sock *msk,
+						  struct mptcp_pm_param *param)
+{
+	struct mptcp_pm_addr_entry *entry = &param->entry;
+	struct mptcp_addr_info *remote = &param->addr;
+	struct sock *sk = (struct sock *)msk;
+	struct mptcp_pm_local local;
+	int err;
+
+	err = mptcp_userspace_pm_append_new_local_addr(msk, entry, false);
+	if (err < 0)
+		return err;
+
+	local.addr = entry->addr;
+	local.flags = entry->flags;
+	local.ifindex = entry->ifindex;
+
+	err = __mptcp_subflow_connect(sk, &local, remote);
+	spin_lock_bh(&msk->pm.lock);
+	if (err)
+		mptcp_userspace_pm_delete_local_addr(msk, entry);
+	else
+		msk->pm.subflows++;
+	spin_unlock_bh(&msk->pm.lock);
+
+	return err;
+}
+
 int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry entry = { 0 };
 	struct mptcp_addr_info addr_r;
 	struct nlattr *raddr, *laddr;
-	struct mptcp_pm_local local;
+	struct mptcp_pm_param param;
 	struct mptcp_sock *msk;
 	int err = -EINVAL;
 	struct sock *sk;
@@ -412,31 +440,16 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	err = mptcp_userspace_pm_append_new_local_addr(msk, &entry, false);
-	if (err < 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, laddr,
-				    "did not match address and id");
-		goto create_err;
-	}
-
-	local.addr = entry.addr;
-	local.flags = entry.flags;
-	local.ifindex = entry.ifindex;
-
 	lock_sock(sk);
-	err = __mptcp_subflow_connect(sk, &local, &addr_r);
+	mptcp_pm_param_set_contexts(&param, &entry, &addr_r);
+	err = msk->pm.ops && msk->pm.ops->subflow_established ?
+	      msk->pm.ops->subflow_established(msk, &param) :
+	      mptcp_userspace_pm_subflow_established(msk, &param);
 	release_sock(sk);
 
 	if (err)
 		GENL_SET_ERR_MSG_FMT(info, "connect error: %d", err);
 
-	spin_lock_bh(&msk->pm.lock);
-	if (err)
-		mptcp_userspace_pm_delete_local_addr(msk, &entry);
-	else
-		msk->pm.subflows++;
-	spin_unlock_bh(&msk->pm.lock);
-
  create_err:
 	sock_put(sk);
 	return err;
@@ -705,6 +718,7 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 static struct mptcp_pm_ops mptcp_userspace_pm = {
 	.address_announced	= mptcp_userspace_pm_address_announced,
 	.address_removed	= mptcp_userspace_pm_address_removed,
+	.subflow_established	= mptcp_userspace_pm_subflow_established,
 	.get_local_id		= mptcp_userspace_pm_get_local_id,
 	.get_priority		= mptcp_userspace_pm_get_priority,
 	.type			= MPTCP_PM_TYPE_USERSPACE,
-- 
2.43.0

