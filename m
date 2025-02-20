Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3EF1F1315
	for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047833; cv=none; b=qLe5oZ2GfnctLPVfykmyFr85uhQhXrcg5WX6KevjCxzXtitccEbNdU0q2Phwe2mWiMKgtEm6YngQ/6nDG5duWysisL4+psqK4otnaEh0dHBKKjo6FfsSim1yNG3tndSBG8I0T916D28B6KClYW9XusQ4XMAvbGNCbpbU9Ezf9dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047833; c=relaxed/simple;
	bh=LL8DcENybaUZzwCB6kfrhyIT3jPFsiny5ouIaPgF4As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WLZ/c0jnWeO/FPQM0ZtEXanzYsG2w72Z6kN+FYZ/XO0J/7ChV1pTU2vR478fQ7M92vpf9SSpWbjgJ0B5Qqa4WJF9p6+XsLhrBgHM6FZ1U2xUN7brM18ZsikXoPKvDCf/Aju3XgSP8X6SkCdIB4s6KNW0JyfGbmstuuSSU8ITBBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRYmuhBv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRYmuhBv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10E7C4CEE3;
	Thu, 20 Feb 2025 10:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740047832;
	bh=LL8DcENybaUZzwCB6kfrhyIT3jPFsiny5ouIaPgF4As=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LRYmuhBvx+YbKBlLcOrAiWeusBWs3qEH49M9eG0nDeBcbF93QrF56gt36h3UG7gAx
	 Y8bVvp6gEzVCCAs8uaJHI2cLW6DU2V0lPXRwis56K73qdo38hm9y0zZszaEHT3OBSM
	 oUab7NYBcicPDg1L7JmDPpknIrWApufBfuHLA15sumokv1l11WmXWm5hxuYs0u1wCu
	 /MGaF8kKPO7RYEDIniRUF02yDPIky1utqt4zB8kNoTSU1JHiUsCNZwjr+SqBfR7a5S
	 wYIjjgmgYnhLZpMdZD+SHmqYAUJlWlg0ZYK0ZmRoApk434X8Q14jcVNJKoAT6esgOj
	 yyeVtq3248lGg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 6/9] mptcp: pm: userspace: address_announced interface
Date: Thu, 20 Feb 2025 18:36:55 +0800
Message-ID: <6d39ed9364b41f84b273598f198fa1aa226a2cbc.1740047738.git.tanggeliang@kylinos.cn>
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

Extract address_announced() interface of the userspace PM from the handler
of netlink command MPTCP_PM_CMD_ANNOUNCE mptcp_pm_nl_announce_doit(), only
leave the code for obtaining msk through "info" and parsing address entry
in the handler.

This interface is invoked under holding the msk socket lock.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 49 ++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index be578f5c3195..baac1027cfb8 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -190,9 +190,33 @@ static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *in
 	return msk;
 }
 
+static int mptcp_userspace_pm_address_announced(struct mptcp_sock *msk,
+						struct mptcp_pm_param *param)
+{
+	struct mptcp_pm_addr_entry *local = &param->entry;
+	int err;
+
+	err = mptcp_userspace_pm_append_new_local_addr(msk, local, false);
+	if (err < 0)
+		return err;
+
+	spin_lock_bh(&msk->pm.lock);
+
+	if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
+		msk->pm.add_addr_signaled++;
+		mptcp_pm_announce_addr(msk, &local->addr, false);
+		mptcp_pm_nl_addr_send_ack(msk);
+	}
+
+	spin_unlock_bh(&msk->pm.lock);
+
+	return 0;
+}
+
 int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry addr_val;
+	struct mptcp_pm_param param;
 	struct mptcp_sock *msk;
 	struct nlattr *addr;
 	int err = -EINVAL;
@@ -224,26 +248,16 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 		goto announce_err;
 	}
 
-	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val, false);
-	if (err < 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, addr,
-				    "did not match address and id");
-		goto announce_err;
-	}
-
 	lock_sock(sk);
-	spin_lock_bh(&msk->pm.lock);
-
-	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
-		msk->pm.add_addr_signaled++;
-		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
-		mptcp_pm_nl_addr_send_ack(msk);
-	}
-
-	spin_unlock_bh(&msk->pm.lock);
+	mptcp_pm_param_set_contexts(&param, &addr_val, NULL);
+	err = msk->pm.ops && msk->pm.ops->address_announced ?
+	      msk->pm.ops->address_announced(msk, &param) :
+	      mptcp_userspace_pm_address_announced(msk, &param);
 	release_sock(sk);
+	if (err)
+		NL_SET_ERR_MSG_ATTR(info->extack, addr,
+				    "did not match address and id");
 
-	err = 0;
  announce_err:
 	sock_put(sk);
 	return err;
@@ -690,6 +704,7 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 }
 
 static struct mptcp_pm_ops mptcp_userspace_pm = {
+	.address_announced	= mptcp_userspace_pm_address_announced,
 	.get_local_id		= mptcp_userspace_pm_get_local_id,
 	.get_priority		= mptcp_userspace_pm_get_priority,
 	.type			= MPTCP_PM_TYPE_USERSPACE,
-- 
2.43.0

